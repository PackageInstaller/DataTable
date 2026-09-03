-- chunkname: @/tmp/or_script/lua_compile/dragon/fsm/StateMachine.lua

StateMachine = class("StateMachine", objectlua.Object, _M)

function StateMachine:initialize(agent, initialState, globalState)
	super.initialize(self)

	self._agent = agent

	self:setInitialState(initialState)
	self:setGlobalState(globalState)
end

function StateMachine:setAgent(agent)
	self._agent = agent
end

function StateMachine:getAgent()
	return self._agent
end

function StateMachine:setInitialState(initialState)
	self._previousState = nil
	self._currentState = initialState
end

function StateMachine:getCurrentState()
	return self._currentState
end

function StateMachine:getPreviousState()
	return self._previousState
end

function StateMachine:setGlobalState(globalState)
	self._globalState = globalState
end

function StateMachine:getGlobalState()
	return self._globalState
end

function StateMachine:update(...)
	if self._globalState ~= nil then
		self._globalState:update(self._agent, ...)
	end

	if self._currentState ~= nil then
		self._currentState:update(self._agent, ...)
	end
end

function StateMachine:changeState(newState, ...)
	self._previousState = self._currentState

	if self._currentState ~= nil then
		self._currentState:exit(self._agent, ...)
	end

	self._currentState = newState

	if self._currentState ~= nil then
		self._currentState:enter(self._agent, ...)
	end
end

function StateMachine:revertToPreviousState(...)
	if self._previousState == nil then
		return false
	end

	self:changeState(self._previousState, ...)

	return true
end

function StateMachine:isInState(state)
	local current = self._currentState

	return current == state or current ~= nil and current:getName() == state
end

function StateMachine:handleMessage(message)
	if self._currentState ~= nil and self._currentState:onMessage(self._agent, message) then
		return true
	end

	if self._globalState ~= nil and self._globalState:onMessage(self._agent, message) then
		return true
	end

	return false
end
