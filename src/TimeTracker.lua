---
-- Awesome Time Tracker
---

require "awful"
local qmonix = require "qmonix"


local TimeTracker = {}


---
-- Creates new TimeTracker object with the specified Qmonix server URI, e.g.
-- "http://localhost:8337"
--
-- @param {string} qmonix_uri qmonix server URI.
-- @return {table} TimeTracker object.
---
function TimeTracker.create(qmonix_uri)
	local retval = {}

	setmetatable(retval, {
		["__index"] = TimeTracker
	})

	retval.qmonix_tracker = qmonix.new_http_tracker(qmonix_uri .. "/event/")

	return retval
end


---
-- Starts tracking the specified activity. If another activity was already
-- being tracked, stops it before starting to track a new one.
--
-- @param {string} activity_name string identifying activity.
---
function TimeTracker:setActivity(activity_name)
	if self.current_activity then
		self.current_activity:fire_dispatch()
	end

	self.current_activity = self.qmonix_tracker:start("time_tracker/"
		.. activity_name)
end


---
-- Stops the activity that is currently being tracked.
---
function TimeTracker:stopCurrentActivity()
	if self.current_activity then
		self.current_activity:fire_dispatch()
		self.current_activity = nil
	end
end


return TimeTracker
