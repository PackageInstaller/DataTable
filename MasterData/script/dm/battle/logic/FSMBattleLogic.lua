-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/FSMBattleLogic.lua

BattleState = class("BattleState", State)

function BattleState:initialize(name)
	super.initialize(self, name)

	self._transitions = {}
	self._enabledOperations = {}
end

function BattleState:setupContext(battleContext)
	return self
end

function BattleState:addTransition(msgType, stateOrStateChooser)
	assert(stateOrStateChooser ~= nil, "Invalid argument")

	self._transitions[msgType] = type(stateOrStateChooser) == "function" and {
		stateChooser = stateOrStateChooser
	} or {
		targetState = stateOrStateChooser
	}

	return self
end

function BattleState:enableOperation(op)
	self._enabledOperations[op] = true

	return self
end

function BattleState:isOperationEnabled(op)
	return self._enabledOperations[op]
end

function BattleState:onMessage(battleLogic, message)
	local msgType = message.type
	local trans = self._transitions[msgType]

	if trans then
		local targetState = trans.targetState

		if targetState == nil then
			targetState = trans.stateChooser(self, battleLogic, message)
		end

		if targetState ~= nil then
			battleLogic:switchToState(targetState, message.args)

			return true
		end
	end
end

function BattleState:enter(battleLogic, battleContext)
	return
end

function BattleState:exit(battleLogic, battleContext)
	self._timers = nil
end

function BattleState:update(battleLogic, battleContext, dt)
	self:updateTimers(dt)
end

function BattleState:handlePlayerInput(battleLogic, player, op, args, callback)
	return false
end

local __NullTimer__ = "NullTimer"

function BattleState:startTimer(timeout, callback)
	local timer = BattleTimer:new(timeout, callback)
	local timers = self._timers

	if timers == nil then
		self._timers = {
			timer
		}
	else
		timers[#timers + 1] = timer
	end

	timer:restart()

	return timer
end

function BattleState:updateTimers(dt)
	local timers = self._timers

	if timers ~= nil then
		local cntTimers = #timers
		local done = 0

		for i = 1, cntTimers do
			local timer = timers[i]

			if timer:tick(dt) then
				timers[i] = __NullTimer__
				done = done + 1
			end
		end

		if done > 0 then
			local eidx = 1

			for i = 1, #timers do
				local timer = timers[i]

				if timers[i] == __NullTimer__ then
					timers[i] = nil
				else
					if i ~= eidx then
						timers[eidx] = timer
						timers[i] = nil
					end

					eidx = eidx + 1
				end
			end
		end
	end
end

FSMBattleLogic = class("FSMBattleLogic", BaseBattleLogic)

function FSMBattleLogic:initialize()
	super.initialize(self)

	self._stateMachine = StateMachine:new(self)
	self._stateAssociatedOperations = {}
end

function FSMBattleLogic:getStateMachine()
	return self._stateMachine
end

function FSMBattleLogic:getCurrentState()
	return self._stateMachine:getCurrentState()
end

function FSMBattleLogic:switchToState(newState, ...)
	return self._stateMachine:changeState(newState, self._battleContext, ...)
end

function FSMBattleLogic:isInState(state)
	return self._stateMachine:isInState(state)
end

function FSMBattleLogic:dispatchMessage(message)
	return self._stateMachine:handleMessage(message)
end

function FSMBattleLogic:start(battleContext)
	if not super.start(self, battleContext) then
		return false
	end

	if not self:setupWithContext(battleContext) then
		return false
	end

	if not self:startSubModules(battleContext) then
		return false
	end

	self:switchToState(self:setupStateTransitions(battleContext))

	return true
end

function FSMBattleLogic:setupWithContext(battleContext)
	return true
end

function FSMBattleLogic:startSubModules(battleContext)
	return true
end

function FSMBattleLogic:setupStateTransitions(battleContext)
	assert(false, "Override me")

	return nil
end

function FSMBattleLogic:step(dt)
	self._stateMachine:update(self._battleContext, dt)

	return self._battleResult
end

function FSMBattleLogic:handlePlayerInput(player, op, args, callback)
	if not self:isOperationEnabled(op) then
		if callback ~= nil then
			callback(false, "InvalidState")
		end

		return true
	end

	local currentState = self:getCurrentState()

	if currentState ~= nil and currentState:handlePlayerInput(self, player, op, args, callback) then
		return true
	end

	return super.handlePlayerInput(self, player, op, args, callback)
end

function FSMBattleLogic:isOperationEnabled(op)
	if not self._stateAssociatedOperations[op] then
		return true
	end

	local state = self._stateMachine:getCurrentState()

	if state and state:isOperationEnabled(op) then
		return true
	end

	state = self._stateMachine:getGlobalState()

	if state and state:isOperationEnabled(op) then
		return true
	end

	return false
end

function FSMBattleLogic:setupInputHandler(op, handler, checkState)
	if not checkState then
		self._stateAssociatedOperations[op] = nil
	else
		self._stateAssociatedOperations[op] = true
	end

	return super.setupInputHandler(self, op, handler)
end
