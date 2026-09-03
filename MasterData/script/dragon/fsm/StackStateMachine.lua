-- chunkname: @/tmp/or_script/lua_compile/dragon/fsm/StackStateMachine.lua

StackStateMachine = class("StackStateMachine", StateMachine, _M)

function StackStateMachine:initialize(agent, initialState, globalState)
	super.initialize(self, agent, initialState, globalState)

	self._stateStack = nil
end

function StackStateMachine:setInitialState(initialState)
	self._stateStack = {}
	self._currentState = initialState
end

function StackStateMachine:getPreviousState()
	local stateStack = self._stateStack

	if stateStack == nil then
		return nil
	end

	local n = #stateStack

	return stateStack[n]
end

function StackStateMachine:changeState(newState, ...)
	self:_doChangeState(newState, true, ...)
end

function StateMachine:revertToPreviousState(...)
	local stateStack = self._stateStack

	if stateStack == nil then
		return false
	end

	local n = #stateStack
	local previousState = stateStack[n]

	if previousState == nil then
		return false
	end

	stateStack[n] = nil

	self:_doChangeState(previousState, false, ...)

	return true
end

function StackStateMachine:_doChangeState(newState, saveCurrentState, ...)
	if saveCurrentState and self._currentState ~= nil then
		self._stateStack[#self._stateStack + 1] = self._currentState
	end

	if self._currentState ~= nil then
		self._currentState:exit(self._agent, ...)
	end

	self._currentState = newState

	if self._currentState ~= nil then
		self._currentState:enter(self._agent, ...)
	end
end
