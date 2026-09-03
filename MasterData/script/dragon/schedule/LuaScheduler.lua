-- chunkname: @/tmp/or_script/lua_compile/dragon/schedule/LuaScheduler.lua

local function getCCScheduler()
	return cc.Director:getInstance():getScheduler()
end

function delayCallByTime(delayMilliseconds, func, ...)
	assert(func ~= nil, "delayCallByTime: func is nil")

	local callFunc = func
	local arglist = {
		n = select("#", ...),
		...
	}
	local animTickEntry

	local function timeUp(time)
		if animTickEntry ~= nil then
			getCCScheduler():unscheduleScriptEntry(animTickEntry)

			animTickEntry = nil

			if arglist ~= nil and arglist.n > 0 then
				callFunc(unpack(arglist, 1, arglist.n))
			else
				callFunc()
			end
		end
	end

	local delay = (delayMilliseconds or 0) * 0.001

	animTickEntry = getCCScheduler():scheduleScriptFunc(timeUp, delay, false)

	return animTickEntry
end

function cancelDelayCall(entry)
	if entry ~= nil then
		getCCScheduler():unscheduleScriptEntry(entry)
	end
end

function actionFunction(duration, updateFunc, endFunc)
	assert(duration > 0 and updateFunc ~= nil, "invalid arguments")

	local step = 1 / duration
	local p = 0

	return function(task, dt)
		p = p + dt * step

		local ended = false

		if p >= 1 then
			p = 1

			task:stop()

			ended = true
		end

		updateFunc(p)

		if ended and endFunc ~= nil then
			endFunc()
		end
	end
end

ScheduleEntry = class("ScheduleEntry", objectlua.Object, _M)

function ScheduleEntry:initialize(scheduler, callback, interval, triggerImmediately)
	super.initialize(self)

	self._scheduler = scheduler
	self._callback = callback
	self._interval = interval
	self._accuTime = 0

	if triggerImmediately then
		self._triggerCallbackOnNextTick = true
	end
end

function ScheduleEntry:getScheduler()
	return self._scheduler
end

function ScheduleEntry:isDeleted()
	return self._isDeleted
end

function ScheduleEntry:tick(dt)
	local interval = self._interval

	if interval == nil or interval <= 0 then
		self:_callback(dt)
	else
		dt = (self._accuTime or 0) + dt

		if interval <= dt or self._triggerCallbackOnNextTick then
			self._accuTime = 0
			self._triggerCallbackOnNextTick = nil

			self:_callback(dt)
		else
			self._accuTime = dt
		end
	end
end

function ScheduleEntry:stop()
	self._isDeleted = true
end

LuaScheduler = class("LuaScheduler", objectlua.Object, _M)

function LuaScheduler:initialize()
	super.initialize(self)

	self._tasks = {}
end

function LuaScheduler.class:getInstance()
	if __schedulerInstance == nil then
		__schedulerInstance = LuaScheduler:new()

		__schedulerInstance:start()
	end

	return __schedulerInstance
end

function LuaScheduler:start()
	if self.tickEntry == nil then
		self.tickEntry = getCCScheduler():scheduleScriptFunc(function(dt)
			self:tick(dt)
		end, 0, false)
	end
end

function LuaScheduler:stop()
	if self.tickEntry ~= nil then
		getCCScheduler():unscheduleScriptEntry(self.tickEntry)

		self.tickEntry = nil
	end
end

function LuaScheduler:pause()
	self._isPaused = true
end

function LuaScheduler:resume()
	self._isPaused = false
end

function LuaScheduler:isRunning()
	return self.tickEntry ~= nil
end

function LuaScheduler:schedule(callback, interval, triggerImmediately)
	assert(callback ~= nil, "callback required but got nil!")

	local task = ScheduleEntry:new(self, callback, interval, triggerImmediately)

	self._tasks[#self._tasks + 1] = task

	return task
end

function LuaScheduler:unschedule(task)
	if task and task:getScheduler() == self then
		task:stop()
	end
end

function LuaScheduler:tick(dt)
	if self._isPaused then
		return
	end

	if self._tasks == nil or next(self._tasks) == nil then
		return
	end

	local tasks = self._tasks
	local count = #tasks
	local fidx = 1

	for i = 1, count do
		local task = tasks[i]

		if task:isDeleted() then
			tasks[i] = nil
		else
			if i ~= fidx then
				tasks[fidx] = task
				tasks[i] = nil
			end

			fidx = fidx + 1
		end
	end

	local imax = #tasks

	for i = 1, imax do
		local task = tasks[i]

		if task ~= nil and not task:isDeleted() then
			task:tick(dt)
		end
	end
end
