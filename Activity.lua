---
-- Activity class for Awesome Time Tracker
---

-- PRIVATE

local Activity = {}

-- PUBLIC

---
-- Creates a new instance of activity with the specified name.
--
-- @param {string} name activity identifying name.
-- @return {table} activity object.
---
function Activity:new(name)
	local retval = {}
	setmetatable(retval, self)
	self.__index = self

	retval.name = name
	retval.time_interval = {}

	return retval
end

---
-- Starts tracking a new activity.
---
function Activity:start()
	self.time_interval.start = os.time()
end

---
-- Stops tracking the activity.
---
function Activity:stop()
	self.time_interval.stop = os.time()
end

---
-- Exports activity info to csv formatted string.
--
-- @return {string} csv formatted string representing activity.
---
function Activity:toCsv()
	local retval = ""

	retval = retval .. self.name .. ";"

	if self.time_interval.start then
		retval = retval .. self.time_interval.start
	end

	retval = retval .. ";"

	if self.time_interval.stop then
		retval = retval .. self.time_interval.stop
	end

	return retval
end

return Activity
