-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/TimingSystem.lua

TimingSystem = class("TimingSystem", BattleSubSystem)

TimingSystem:has("_entityManager", {
	is = "rw"
})

function TimingSystem:initialize()
	super.initialize(self)

	self._cumulativeTime = 0
end

function TimingSystem:startup(battleContext)
	super.startup(self, battleContext)

	return self
end

function TimingSystem:setIsTiming(isTiming, wontRecord)
	if self._isTimingRunning ~= isTiming then
		self._isTimingRunning = isTiming

		if not wontRecord then
			self._processRecorder:recordObjectEvent(kBRMainLine, "Timing", {
				ctrl = isTiming and "resume" or "pause",
				time = self:getCumulativeTime()
			})
		end
	end
end

function TimingSystem:isTiming()
	return self._isTimingRunning
end

function TimingSystem:getCumulativeTime()
	return self._cumulativeTime
end

function TimingSystem:resetCumulativeTime(time)
	self._cumulativeTime = time or 0
end

function TimingSystem:accumulateTime(deltaTime)
	if self._isTimingRunning then
		local oldTime = self._cumulativeTime
		local cumulativeTime = self._cumulativeTime + deltaTime

		self._cumulativeTime = cumulativeTime

		if oldTime < cumulativeTime and self._eventCenter then
			self._eventCenter:dispatchEvent("NewTime", {
				prev = oldTime,
				delta = deltaTime,
				now = cumulativeTime
			})
		end

		return cumulativeTime
	else
		return self._cumulativeTime
	end
end

function TimingSystem:lockTime(dur)
	self._lockTime = dur

	if self._lockTime then
		self:setIsTiming(false)
	end
end

function TimingSystem:checkLocking(dt)
	if self._lockTime and self._lockTime > 0 then
		self._lockTime = self._lockTime - dt

		return true
	end

	if self._lockTime then
		self._lockTime = nil

		self:setIsTiming(true)
	end

	return false
end

function TimingSystem:nextRound()
	return
end

function TimingSystem:getRoundTime()
	return
end
