-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ToLua\\System\\Timer.lua

local setmetatable = setmetatable
local UpdateBeat = UpdateBeat
local CoUpdateBeat = CoUpdateBeat
local Time = Time
local logerror = logerror
local traceback = traceback

local function cmp_default(a, b)
	return a - b
end

local function binlocate(t, value, cmp)
	cmp = cmp or cmp_default

	local _start, _end, _mid, _state = 1, #t, 1, 0

	while _start <= _end do
		_mid = math.floor((_start + _end) / 2)

		local diff = cmp(value, t[_mid])

		if diff < 0 then
			_end, _state = _mid - 1, 0
		else
			_start, _state = _mid + 1, 1
		end
	end

	return _mid + _state
end

local function bininsert(t, value, cmp)
	local index = binlocate(t, value, cmp)

	table.insert(t, index, value)

	return index
end

local function binremove(t, value, cmp)
	cmp = cmp or cmp_default

	local _v
	local index = binlocate(t, value, cmp)

	for i = index - 1, 1, -1 do
		_v = t[i]

		if _v == value then
			return table.remove(t, i)
		elseif cmp(_v, value) ~= 0 then
			return nil
		end
	end

	return nil
end

local function timerCmpFunc(a, b)
	return a.time - b.time
end

local function TableRemoveInArray(t, v)
	for i, _v in ipairs(t) do
		if _v == v then
			table.remove(t, i)

			return
		end
	end
end

local function TimerQueueInsert(queue, timer)
	return bininsert(queue, timer, timerCmpFunc)
end

local function TimerQueueRemove(queue, timer)
	return binremove(queue, timer, timerCmpFunc)
end

local TimerState = {
	Running = 3,
	Sched = 2,
	Idle = 1,
	Paused = 4
}
local TimerManager = {
	timerList = {},
	unscaledTimerList = {},
	runList = {},
	pausedList = {},
	scheduleList = {}
}

function TimerManager:Update()
	self:__EnqueScheduledTimers()
	self:__CollectDueTimers()
	self:__RunDueTimers()
	self:__RescheduleDueTimers()
end

function TimerManager:__EnqueScheduledTimers()
	for i, timer in ipairs(self.scheduleList) do
		if timer.state == TimerState.Sched then
			local list = timer.scale and self.timerList or self.unscaledTimerList

			timer.state = TimerState.Running

			TimerQueueInsert(list, timer)
		end
	end

	while #self.scheduleList > 0 do
		table.remove(self.scheduleList)
	end
end

function TimerManager:__RemoveDueTimers(list, untilIndex)
	if untilIndex <= 1 then
		return
	end

	for k = untilIndex, #list do
		list[k - untilIndex + 1] = list[k]
	end

	for k = 1, untilIndex - 1 do
		table.remove(list)
	end
end

function TimerManager:__CollectDueTimers()
	local index = 1
	local time = Time.time

	for i, timer in ipairs(self.timerList) do
		if time < timer.time then
			break
		end

		index = i + 1

		table.insert(self.runList, timer)
	end

	self:__RemoveDueTimers(self.timerList, index)

	index = 1
	time = Time.unscaledTime

	for i, timer in ipairs(self.unscaledTimerList) do
		if time < timer.time then
			break
		end

		index = i + 1

		table.insert(self.runList, timer)
	end

	self:__RemoveDueTimers(self.unscaledTimerList, index)
end

function TimerManager:__RunDueTimers()
	for i, timer in ipairs(self.runList) do
		if timer.state == TimerState.Running then
			if timer.loop > 0 then
				timer.loop = timer.loop - 1
			end

			timer:Invoke()
		end
	end
end

function TimerManager:__RescheduleDueTimers()
	local time = Time.time
	local unscaledTime = Time.unscaledTime

	for i, timer in ipairs(self.runList) do
		if timer.state == TimerState.Running then
			local t = timer.scale and time or unscaledTime

			if timer.loop > 0 or timer.loop < 0 then
				timer.time = t + timer.duration
				timer.state = TimerState.Sched

				table.insert(self.scheduleList, timer)
			else
				timer.state = TimerState.Idle
			end
		end
	end

	while #self.runList > 0 do
		table.remove(self.runList)
	end

	self:__EnqueScheduledTimers()
end

function TimerManager:Schedule(timer)
	if timer.state == TimerState.Idle and timer.loop ~= 0 then
		local time = timer.scale and Time.time or Time.unscaledTime

		timer.state = TimerState.Sched
		timer.time = time + timer.duration

		table.insert(self.scheduleList, timer)
	end
end

function TimerManager:Unschedule(timer)
	if timer.state == TimerState.Running then
		local runList = timer.scale and self.timerList or self.unscaledTimerList

		TimerQueueRemove(runList, timer)
	elseif timer.state == TimerState.Sched then
		TableRemoveInArray(self.scheduleList, timer)
	elseif timer.state == TimerState.Paused then
		timer.elapsed = 0

		TableRemoveInArray(self.pausedList, timer)
	end

	timer.state = TimerState.Idle
end

function TimerManager:PauseTimer(timer)
	local canPause = false

	if timer.state == TimerState.Running then
		canPause = true

		local time = timer.scale and Time.time or Time.unscaledTime
		local runList = timer.scale and self.timerList or self.unscaledTimerList

		TimerQueueRemove(runList, timer)

		timer.elapsed = timer.duration - math.max(0, timer.time - time)
	elseif timer.state == TimerState.Sched then
		canPause = true

		TableRemoveInArray(self.scheduleList, timer)

		timer.elapsed = 0
	end

	if canPause then
		table.insert(self.pausedList, timer)

		timer.state = TimerState.Paused
	end
end

function TimerManager:ResumeTimer(timer)
	if timer.state == TimerState.Paused then
		TableRemoveInArray(self.pausedList, timer)

		local time = timer.scale and Time.time or Time.unscaledTime

		timer.state = TimerState.Sched
		timer.time = time + timer.duration - timer.elapsed
		timer.elapsed = 0

		table.insert(self.scheduleList, timer)
	end
end

UpdateBeat:Add(TimerManager.Update, TimerManager)

Timer = {
	loop = 1,
	time = 0,
	duration = 1,
	scale = false,
	state = TimerState.Idle
}

local Timer = Timer
local mt = {}

mt.__index = Timer

local ExceptionFunc

function Timer.SetExceptionFunc(exceFunc)
	ExceptionFunc = exceFunc
end

function Timer.New(func, duration, loop, scale)
	if func then
		local timer = {}

		setmetatable(timer, mt)
		timer:Setting(func, duration, loop, scale)

		return timer
	else
		return nil
	end
end

setmetatable(Timer, {
	__call = function(self, func, duration, loop, scale)
		return Timer.New(func, duration, loop, scale)
	end
})

function Timer:Setting(func, duration, loop, scale)
	scale = scale and true or false
	self.duration = duration
	self.time = scale and Time.time or Time.unscaledTime
	self.totalLoop = loop or 1
	self.loop = self.totalLoop
	self.scale = scale
	self.func = func
	self.count = Time.frameCount + 1
	self.elapsed = 0
end

function Timer:Invoke()
	if self.func ~= nil then
		local flag, msg = xpcall(self.func, traceback)

		if not flag then
			self:Stop()

			if ExceptionFunc then
				ExceptionFunc(msg)
			end
		end
	end
end

function Timer:Start()
	if self.state == TimerState.Idle then
		TimerManager:Schedule(self)
	end
end

function Timer:Stop()
	if self.state ~= TimerState.Idle then
		TimerManager:Unschedule(self)
	end
end

function Timer:Pause()
	TimerManager:PauseTimer(self)
end

function Timer:Resume()
	TimerManager:ResumeTimer(self)
end

function Timer:Reset()
	self:Stop()

	self.time = self.scale and Time.time or Time.unscaledTime
	self.loop = self.totalLoop
end

function Timer:Restart()
	self:Reset()
	self:Start()
end

function Timer:IsRunning()
	return self.state == TimerState.Running or self.state == TimerState.Sched
end

function Timer:IsPaused()
	return self.state == TimerState.Paused
end

FrameTimer = {
	loop = 1,
	duration = 1,
	count = 1,
	running = false
}

local FrameTimer = FrameTimer
local mt2 = {}

mt2.__index = FrameTimer

function FrameTimer.New(func, count, loop)
	local timer = {}

	setmetatable(timer, mt2)

	timer.count = Time.frameCount + count
	timer.duration = count
	timer.loop = loop
	timer.func = func

	return timer
end

setmetatable(FrameTimer, {
	__call = function(self, func, count, loop)
		return FrameTimer.New(func, count, loop)
	end
})

function FrameTimer:Start()
	self.running = true

	CoUpdateBeat:Add(self.Update, self)
end

function FrameTimer:Stop()
	self.running = false

	CoUpdateBeat:Remove(self.Update, self)
end

function FrameTimer:Update()
	if not self.running then
		return
	end

	if Time.frameCount >= self.count then
		if self.loop > 0 then
			self.loop = self.loop - 1
		end

		if self.loop == 0 then
			self:Stop()
		else
			self.count = Time.frameCount + self.duration
		end

		self.func()
	end
end

CoTimer = {
	loop = 1,
	running = false,
	time = 0,
	duration = 1
}

local CoTimer = CoTimer
local mt3 = {}

mt3.__index = CoTimer

function CoTimer.New(func, duration, loop)
	local timer = {}

	setmetatable(timer, mt3)
	timer:Reset(func, duration, loop)

	return timer
end

setmetatable(CoTimer, {
	__call = function(self, func, duration, loop)
		return CoTimer.New(func, duration, loop)
	end
})

function CoTimer:Start()
	self.running = true
	self.count = Time.frameCount + 1

	CoUpdateBeat:Add(self.Update, self)
end

function CoTimer:Reset(func, duration, loop)
	self.duration = duration
	self.loop = loop or 1
	self.func = func
	self.time = duration
	self.running = false
	self.count = Time.frameCount + 1
end

function CoTimer:Stop()
	self.running = false

	CoUpdateBeat:Remove(self.Update, self)
end

function CoTimer:Update()
	if not self.running then
		return
	end

	if self.time <= 0 and Time.frameCount > self.count then
		self.func()

		if self.loop > 0 then
			self.loop = self.loop - 1
			self.time = self.time + self.duration
		end

		if self.loop == 0 then
			self:Stop()
		elseif self.loop < 0 then
			self.time = self.time + self.duration
		end
	end

	self.time = self.time - Time.deltaTime
end
