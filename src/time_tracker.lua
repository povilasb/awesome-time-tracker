---
-- Awesome Time Tracker.
---

local qmonix = require "qmonix.qmonix"
require("naughty")


local time_tracker = {}


---
-- Creates new time_tracker object with the specified Qmonix server URI, e.g.
-- "http://localhost:8337"
--
-- @param {string} qmonix_uri qmonix server URI.
-- @return {table} time_tracker object.
---
function time_tracker.create(qmonix_uri)
	local retval = {}

	setmetatable(retval, {
		["__index"] = time_tracker
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
function time_tracker:set_activity(activity_name)
	if self.current_activity then
		self.current_activity:fire_dispatch()
	end

	self.current_activity = self.qmonix_tracker:start("time_tracker/"
		.. activity_name)

	self.show_message("Task started: " .. activity_name)
end


---
-- Stops the activity that is currently being tracked.
---
function time_tracker:stop_current_activity()
	if self.current_activity then
		self.current_activity:fire_dispatch()

		self.show_message("Task stopped : "
			.. self.current_activity.tag)

		self.current_activity = nil
	end
end


---
-- Shows active task name.
---
function time_tracker:show_current_activity()
	if self.current_activity then
		self.show_message("Active task : "
			.. self.current_activity.tag)
	else
		self.show_message("No active tasks.")
	end
end


---
-- Displays message with the specified text.
---
function time_tracker.show_message(message)
	naughty.notify({title = 'Awesome time tracker',
		text = message,
		timeout = 3,
		screen = mouse.screen
	})
end


return time_tracker
