-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/BattleTimer.lua

BattleTimer = class("BattleTimer")

function BattleTimer:initialize(timeout, callback)
	super.initialize(self)

	self._timeout = timeout
	self._callback = callback
end

function BattleTimer:setCallback(callback)
	self._callback = callback
end

function BattleTimer:getTimeout()
	return self._timeout
end

function BattleTimer:setTimeout(timeout)
	self._timeout = timeout
end

function BattleTimer:getElapsed()
	return self._elapsed
end

function BattleTimer:restart()
	self._elapsed = 0
end

function BattleTimer:cancel()
	self._elapsed = nil
end

function BattleTimer:isDone()
	return self._elapsed == nil
end

function BattleTimer:tick(dt)
	local elapsed = self._elapsed

	if elapsed ~= nil then
		elapsed = elapsed + dt

		if elapsed < self._timeout then
			self._elapsed = elapsed
		else
			self._elapsed = nil

			if self._callback ~= nil then
				self:_callback()
			end
		end
	end

	return self._elapsed == nil
end

BattleTimerScheduler = class("BattleTimerScheduler")

function BattleTimerScheduler:initialize()
	super.initialize(self)

	self._timers = {}
	self._timersArray = {}
end

function BattleTimerScheduler:addTimer(timer)
	if self._timers[timer] ~= nil then
		return
	end

	self._timers[timer] = timer
	self._timersArray[#self._timersArray + 1] = timer

	timer:restart()
end

function BattleTimerScheduler:removeTimer(timer)
	self._timers[timer] = nil
end

function BattleTimerScheduler:update(dt)
	local timers = self._timers
	local timersArray = self._timersArray
	local total, invalid = #timersArray, 0

	for i = 1, total do
		local timer = timersArray[i]

		if timer == timers[timer] then
			if timer:tick(dt) then
				timers[timer] = nil
				invalid = invalid + 1
			end
		else
			invalid = invalid + 1
		end
	end

	if invalid > 0 then
		local eidx = 1

		for i = 1, #timersArray do
			local timer = timersArray[i]

			if timer ~= timers[timer] then
				timersArray[i] = nil
			else
				if i ~= eidx then
					timersArray[eidx] = timer
					timersArray[i] = nil
				end

				eidx = eidx + 1
			end
		end
	end
end
