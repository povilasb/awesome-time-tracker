---
-- Awesome Time Tracker
---

require "awful"
local Activity = require "TimeTracker.Activity"

-- PRIVATE

local TimeTracker = {}

---
-- Checks if time tracker was initialised. If it was not, raises error.
---
function TimeTracker:validateInit()
	if not self.config then
		error("Awesome Time Tracker was not initialised")
	end
end

---
-- Appends specified activity info to db.
--
-- @param {Activity} activity Activity object whose info will be written to
--	database file.
---
function TimeTracker:writeToDb(activity)
	local dbFile = self.config.dbFilePath

	f = io.open(dbFile, "a")
	f:write(activity:toCsv(), "\n")
	f:close()
end

-- PUBLIC

---
-- Initialises time tracker with a specified database file path. This must
-- be invoked before starting to use time tracker. If it is not, the error
-- will be raised.
--
-- @param {string} dbFilePath database file name path. This is the file that
--	activity data will be stored.
---
function TimeTracker:init(dbFilePath)
	self.config = {}
	self.config.dbFilePath = dbFilePath

	self.currentActivity = nil

	-- if DB file does not exist yet, create it and write header to it
	if not awful.util.file_readable(self.config.dbFilePath) then
		local header = "Activity name;Start time;Stop time"
		f = io.open(self.config.dbFilePath, "w")
		f:write(header, "\n")
		f:close()
	end
end

---
-- Starts tracking the specified activity. If another activity was already
-- being tracked, stops it before starting to track a new one.
--
-- @param {string} activity_name string identifying activity.
---
function TimeTracker:setActivity(activity_name)
	self:validateInit()

	if self.currentActivity then
		self.currentActivity:stop()
		self:writeToDb(self.currentActivity);
	end

	self.currentActivity = Activity:new(activity_name)
	self.currentActivity:start()
end

---
-- Stops the activity that is currently being tracked.
---
function TimeTracker:stopCurrentActivity()
	if self.currentActivity then
		self.currentActivity:stop()
		self:writeToDb(self.currentActivity);
		self.currentActivity = nil
	end
end

return TimeTracker

