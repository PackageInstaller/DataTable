-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/FSMComponent.lua

FSMComponent = class("FSMComponent", BaseComponent, _M)

function FSMComponent:initialize()
	super.initialize(self)
end

function FSMComponent:setInitialState(initialState)
	self._previousState = nil
	self._currentState = initialState
end

function FSMComponent:update(dt, battleContext)
	if self._currentState ~= nil then
		self._currentState:update(self, dt, battleContext)
	end
end

function FSMComponent:changeState(newState, ...)
	self._previousState = self._currentState

	if self._currentState ~= nil then
		self._currentState:exit(self, ...)
	end

	self._currentState = newState

	if self._currentState ~= nil then
		self._currentState:enter(self, ...)
	end
end

function FSMComponent:revertToPreviousState(...)
	if self._previousState == nil then
		return false
	end

	self:changeState(self._previousState, ...)

	return true
end

function FSMComponent:isInState(state)
	local current = self._currentState

	return current == state or current ~= nil and current:getName() == state
end

function FSMComponent:handleMessage(message)
	if self._currentState ~= nil and self._currentState:onMessage(self, message) then
		return true
	end

	return false
end

function FSMComponent:copyComponent(srcComp, ratio)
	return
end
