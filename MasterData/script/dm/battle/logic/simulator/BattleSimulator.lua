-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/simulator/BattleSimulator.lua

BattleSimulator = class("BattleSimulator")

BattleSimulator:has("_battleContext", {
	is = "r"
})
BattleSimulator:has("_battleLogic", {
	is = "rw"
})
BattleSimulator:has("_battleRecorder", {
	is = "rw"
})
BattleSimulator:has("_battleStatist", {
	is = "rw"
})
BattleSimulator:has("_inputManager", {
	is = "r"
})
BattleSimulator:has("_autoScheduler", {
	is = "r"
})

function BattleSimulator:initialize()
	super.initialize(self)

	self._battleResult = nil
	self._frameCounter = 0
	self._timeSinceStarting = 0
	self._inputManager = BattleInputManager:new()
	self._autoScheduler = BattleAIScheduler:new()
end

function BattleSimulator:getBattleResult()
	return self._battleResult
end

function BattleSimulator:setDelegate(delegate)
	self._delegate = delegate
end

function BattleSimulator:getCurrentFrame()
	return self._frameCounter
end

function BattleSimulator:getCurrentTime()
	return self._timeSinceStarting
end

function BattleSimulator:_reset()
	self._battleResult = nil
	self._frameCounter = 0
	self._timeSinceStarting = 0
end

function BattleSimulator:_setBattleTime(frame, timeSinceStarting)
	self._frameCounter = frame
	self._timeSinceStarting = timeSinceStarting

	self._battleContext:setBattleTime(frame, timeSinceStarting)

	if self._battleRecorder then
		self._battleRecorder:gotoFrame(frame)
	end
end

function BattleSimulator:start(frameInterval)
	assert(self._battleLogic ~= nil, "No battle logic!")
	self:_reset()

	local battleContext = self._battleLogic:createBattleContext()

	self._battleContext = battleContext

	battleContext:startup()
	battleContext:setObject("BattleRecorder", self._battleRecorder)
	battleContext:setObject("BattleStatist", self._battleStatist)
	battleContext:setObject("BattleLogic", self._battleLogic)

	self._frameInterval = frameInterval

	battleContext:setFrameInterval(frameInterval)
	self:_setBattleTime(0, 0)
	self._inputManager:reset()
	self._inputManager:setCurrentFrame(1)

	if self._battleRecorder then
		self._battleRecorder:startRecording()
	end

	if self._battleStatist then
		self._battleStatist:willStartBattle(battleContext)
	end

	self._battleLogic:start(battleContext)

	self._battleResult = self._battleLogic:getBattleResult()

	if self._battleResult ~= nil then
		return self._battleResult
	end

	self._autoScheduler:start(battleContext)

	if self._delegate and self._delegate.battleStart then
		self._delegate.battleStart(battleContext)
	end
end

function BattleSimulator:tick(frameInterval)
	if self._battleResult ~= nil then
		return self._battleResult
	end

	local frame = self._frameCounter + 1
	local timeSinceStarting = self._timeSinceStarting + frameInterval

	self:_setBattleTime(frame, timeSinceStarting)

	local battleLogic, inputManager = self._battleLogic, self._inputManager

	self:_processInputs(inputManager, battleLogic)

	local result = battleLogic:step(frameInterval)
	local nextFrameIndex = frame + 1

	inputManager:setCurrentFrame(nextFrameIndex)
	inputManager:flushComingInputs()

	if result ~= nil then
		self._battleResult = result

		if self._battleStatist then
			self._battleStatist:didFinishBattle(result)
		end

		if self._battleRecorder then
			self._battleRecorder:endRecording()
		end

		return result
	end

	self._autoScheduler:tick(frameInterval)
end

function BattleSimulator:_processInputs(inputManager, battleLogic)
	if not battleLogic:isReadyForInput() then
		return
	end

	repeat
		local idx, playerId, op, args, callback = inputManager:nextInput()

		if idx == nil then
			break
		end

		battleLogic:handleInputMessage(playerId, op, args, callback)
	until false
end

function BattleSimulator:addAutoStrategy(autoStrategy)
	if autoStrategy == nil then
		return
	end

	if self._autoScheduler:schedule(autoStrategy) and self._battleContext ~= nil then
		autoStrategy:start(self._battleContext)
	end
end

function BattleSimulator:removeAutoStrategy(autoStrategy)
	self._autoScheduler:unschedule(autoStrategy)
end
