-- chunkname: @/tmp/or_script/lua_compile/dragon/schedule/QueuedExecutor.lua

local function getCCScheduler()
	return cc.Director:getInstance():getScheduler()
end

QueuedExecutor = class("QueuedExecutor", objectlua.Object, _M)

local __executorInstance

function QueuedExecutor.class:getInstance()
	if __executorInstance == nil then
		__executorInstance = QueuedExecutor:new()
	end

	return __executorInstance
end

function QueuedExecutor:initialize()
	super.initialize(self)

	self.currentState = nil
	self.blockedQueue = nil
end

function QueuedExecutor:finalize()
	if self.tickEntry ~= nil then
		getCCScheduler():unscheduleScriptEntry(self.tickEntry)

		self.tickEntry = nil
	end

	self.blockedQueue = nil
end

function QueuedExecutor:switchState(state)
	self.currentState = state
end

function QueuedExecutor:getCurrentState()
	return self.currentState
end

function QueuedExecutor:isStateMatched(targetState)
	if targetState == nil or self.currentState == nil then
		return true
	end

	return targetState == self.currentState
end

function QueuedExecutor:exec(targetState, delayMilliseconds, func)
	assert(func ~= nil)

	if self:isStateMatched(targetState) and delayMilliseconds == nil then
		func()
	else
		self:addBlockedEntry({
			targetState = targetState,
			cd = (delayMilliseconds or 0) * 0.001,
			func = func
		})
	end
end

function QueuedExecutor:addBlockedEntry(entry)
	if self.blockedQueue == nil then
		self.blockedQueue = {}
	end

	self.blockedQueue[#self.blockedQueue + 1] = entry

	if self.tickEntry == nil then
		self.tickEntry = getCCScheduler():scheduleScriptFunc(function(dt)
			self:tick(dt)
		end, 0, false)
	end
end

function QueuedExecutor:tick(dt)
	if self.blockedQueue == nil or #self.blockedQueue == 0 then
		if self.tickEntry ~= nil then
			getCCScheduler():unscheduleScriptEntry(self.tickEntry)

			self.tickEntry = nil
		end

		return
	end

	local originalQueue = self.blockedQueue

	self.blockedQueue = nil

	local n = #originalQueue
	local removed = 0

	for i = 1, n do
		local entry = originalQueue[i]

		if entry.cd > 0 then
			entry.cd = entry.cd - dt
		end

		if entry.cd <= 0 and self:isStateMatched(entry.targetState) then
			entry.func()

			originalQueue[i] = nil
			removed = removed + 1
		end
	end

	if removed > 0 then
		local j = 0

		for i = 1, n do
			local a = originalQueue[i]

			if j >= 1 and a ~= nil then
				originalQueue[j] = a
				j = j + 1
			elseif j < 1 and a == nil then
				j = i
			end
		end

		if j >= 1 then
			for i = j, n do
				originalQueue[i] = nil
			end
		end
	end

	if self.blockedQueue == nil then
		if #originalQueue > 0 then
			self.blockedQueue = originalQueue
		end
	else
		local blockedQueue = self.blockedQueue
		local n, c = #blockedQueue, #originalQueue + 1

		for i = 1, n do
			c = c + 1
			originalQueue[c] = blockedQueue[i]
		end

		self.blockedQueue = originalQueue
	end
end
