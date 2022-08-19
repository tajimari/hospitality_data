-- add revenue column to calculate how much each stay cost
alter table hospitality
ADD revenue as ROUND((room_rate * stay_duration), 2)

-- Overall Stats
SELECT FLOOR(SUM(revenue)) as [Gross Revenue], count(*) as [Total Rooms Booked], sum(stay_duration) as [Nights Booked]
from hospitality

-- how much revenue did each hotel bring?
SELECT property, FLOOR(sum(revenue)) as [Revenue], 
       count(*) as [Number of Room Bookings],
       sum(stay_duration) as [Number of Nights Booked],
       ROUND(avg(room_rate), 2) as [Average Cost per Night]
FROM hospitality
GROUP BY property 
ORDER BY revenue desc

-- Find revenue and bookings by day of week
SELECT datename(dw, date) as [Day of Week], 
       ROUND(sum(revenue), 2) as [Revenue],
       COUNT(*) as [Number of Room Bookings]
FROM hospitality
GROUP BY datename(dw, date)
ORDER BY revenue DESC

-- when are the busiest months? does it differ by hotel?
SELECT datepart(month, date) as month, property, ROUND(sum(revenue), 2) as revenue
FROM hospitality
GROUP BY datepart(month, date), property
ORDER BY datepart(month, date), property


-- # of bookings for each property over timeframe
SELECT date, property, count(*) as count
FROM hospitality
group by property, date 
order by property, date 

-- distribution of booking channels
SELECT booking_channel, count(*) as count, FLOOR(sum(revenue)) as [Revenue]
FROM hospitality
GROUP BY booking_channel
ORDER BY revenue DESC

-- Reservation Status
SELECT reservation_status, count(*) as count
FROM hospitality
GROUP BY reservation_status
ORDER BY count desc

-- Room Type
SELECT room_type, count(*) as [Count], FLOOR(sum(revenue)) as [Revenue]
FROM hospitality
GROUP BY room_type
ORDER BY revenue DESC


