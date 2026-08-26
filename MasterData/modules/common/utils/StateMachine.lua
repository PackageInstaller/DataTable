-- chunkname: @modules/common/utils/StateMachine.lua

module("modules.common.utils.StateMachine", package.seeall)

local StateMachine = class("StateMachine")

function StateMachine.Create()
	local instance = StateMachine.New()

	instance.states = {}
	instance.currentState = nil

	return instance
end

function StateMachine:addState(name, onEnter, onUpdate, onExit, cbObj)
	if self.states[name] == nil then
		self.states[name] = {}
	end

	self.states[name].onEnter = onEnter
	self.states[name].onUpdate = onUpdate
	self.states[name].onExit = onExit
	self._cbObj = cbObj
end

function StateMachine:setInitialState(name)
	self.currentState = name

	if self.states[name] and self.states[name].onEnter then
		self.states[name].onEnter(self._cbObj)
	end
end

function StateMachine:transitionTo(name)
	if self.currentState == name then
		return
	end

	local current = self.states[self.currentState]
	local nextState = self.states[name]

	if current and current.onExit then
		current.onExit(self._cbObj)
	end

	self.currentState = name

	if nextState and nextState.onEnter then
		nextState.onEnter(self._cbObj)
	end
end

function StateMachine:update(deltaTime)
	local current = self.states[self.currentState]

	if current and current.onUpdate then
		current.onUpdate(self._cbObj, deltaTime)
	end
end

function StateMachine:onDestroy()
	if self.states ~= nil then
		tabletool.clear(self.states)

		self.states = nil
	end

	self._cbObj = nil
end

return StateMachine
