-- chunkname: @/tmp/or_script/lua_compile/dm/battle/interactor/BattleDirector.lua

local kDefaultFrameInterval = 50

BattleDirector = class("BattleDirector")

BattleDirector:has("_frameInterval", {
	is = "rw"
})
BattleDirector:has("_maxReachableFrame", {
	is = "rw"
})
BattleDirector:has("_battleSimulator", {
	is = "rw"
})
BattleDirector:has("_battleInterpreter", {
	is = "rw"
})
BattleDirector:has("_opData", {
	is = "rw"
})

function BattleDirector:initialize()
	super.initialize(self)

	self._frameInterval = kDefaultFrameInterval
end

function BattleDirector:getCurrentFrame()
	return self._frameCounter
end

function BattleDirector:pause()
	self._isPaused = true
end

function BattleDirector:resume()
	self._isPaused = false
end

function BattleDirector:isPaused()
	return self._isPaused
end

function BattleDirector:getBattleResult()
	return self._battleResult
end

function BattleDirector:start()
	self._battleResult = nil
	self._frameCounter = 0
	self._actime = 0
	self._realFrameInterval = self._frameInterval

	if self._battleSimulator then
		self._battleSimulator:start(self._realFrameInterval)

		if self._opData then
			local inputManager = self._battleSimulator:getInputManager()

			inputManager:restore(self._opData)
		end
	end

	if self._battleInterpreter then
		self._battleInterpreter:start()
	end
end

function BattleDirector:update(dt)
	local frameInterval = self._realFrameInterval
	local battleSimulator = self._battleSimulator
	local battleInterpreter = self._battleInterpreter
	local actime = self._actime + dt

	self._actime = actime

	while frameInterval <= actime do
		if self._isPaused then
			return "paused"
		end

		if self._maxReachableFrame ~= nil and self._maxReachableFrame <= self._frameCounter then
			return "waiting"
		end

		actime = actime - frameInterval
		self._actime = actime
		self._frameCounter = self._frameCounter + 1

		if battleSimulator and self._battleResult == nil then
			local result = battleSimulator:tick(frameInterval)

			if result ~= nil then
				self._battleResult = result
			end
		end

		if battleInterpreter then
			battleInterpreter:update(self._frameCounter)
		end
	end

	return "running"
end

function BattleDirector:createPlayerController()
	assert(false, "Implement me!")
end
