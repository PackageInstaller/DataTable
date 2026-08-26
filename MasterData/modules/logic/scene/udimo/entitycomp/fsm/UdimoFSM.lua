-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/UdimoFSM.lua

module("modules.logic.scene.udimo.entitycomp.fsm.UdimoFSM", package.seeall)

local UdimoFSM = class("UdimoFSM")

function UdimoFSM:ctor(entity)
	self.states = {}
	self.transitions = {}
	self.isRunning = false
	self.isTranslating = false
	self.curStateName = nil
	self.entity = entity
end

function UdimoFSM:registerState(state)
	local stateName = state.name

	if state.fsm or self.states[stateName] then
		return
	end

	state:register(self)

	self.states[stateName] = state
end

function UdimoFSM:registerTransition(transition)
	local fromState = transition.fromStateName

	if transition.fsm or not self.states[fromState] or self.transitions[fromState] then
		return
	end

	transition:register(self)

	self.transitions[fromState] = transition
end

function UdimoFSM:start(initStateName)
	if self.isRunning or string.nilorempty(initStateName) then
		return
	end

	for _, state in pairs(self.states) do
		state:onFSMStart()
	end

	for _, transition in pairs(self.transitions) do
		transition:onFSMStart()
	end

	self.isRunning = true
	self.isTranslating = false

	self:enterState(initStateName)
end

function UdimoFSM:stop()
	if not self.isRunning then
		return
	end

	for _, state in pairs(self.states) do
		state:onFSMStop()
	end

	for _, transition in pairs(self.transitions) do
		transition:onFSMStop()
	end

	self.isRunning = false
	self.isTranslating = false
end

function UdimoFSM:clear()
	for _, state in pairs(self.states) do
		state:clear()
	end

	for _, transition in pairs(self.transitions) do
		transition:clear()
	end

	self.states = {}
	self.transitions = {}
	self.curStateName = nil
end

function UdimoFSM:release()
	self:stop()
	self:clear()

	self.entity = nil
end

function UdimoFSM:triggerEvent(eventId, param)
	if not self.isRunning or self.isTranslating or string.nilorempty(self.curStateName) then
		return
	end

	local transition = self.transitions[self.curStateName]
	local toStateName = transition and transition:checkTranslate(eventId, param)

	if toStateName then
		self:startTransition(toStateName, param)
	end
end

function UdimoFSM:updateStateParam(stateName, param)
	if not self.isRunning then
		return
	end

	local state = self.states[stateName]

	if state then
		state:updateParam(param)
	end
end

function UdimoFSM:onUpdate()
	if not self.isRunning or not self.curStateName then
		return
	end

	local state = self.states[self.curStateName]

	if state and state.onUpdate then
		state:onUpdate()
	end
end

function UdimoFSM:startTransition(toStateName, param)
	if not self.isRunning then
		return
	end

	if string.nilorempty(toStateName) then
		logError("UdimoFSM:startTransitiona error, toStateName is nil")

		return
	end

	self.isTranslating = true

	local transition = self.transitions[self.curStateName]

	self:exitState(self.curStateName)
	transition:startTranslate(toStateName, param)
end

function UdimoFSM:exitState()
	if not self.isRunning then
		return
	end

	local preState = self.curStateName

	self.curStateName = nil

	self.states[preState]:onExit()
end

function UdimoFSM:endTransition(toStateName, param)
	if not self.isRunning then
		return
	end

	if string.nilorempty(toStateName) then
		logError("UdimoFSM:endTransition error, toStateName is nil")

		return
	end

	self.isTranslating = false

	self:enterState(toStateName, param)
end

function UdimoFSM:enterState(stateName, param)
	if not self.isRunning then
		return
	end

	self.curStateName = stateName

	self.states[self.curStateName]:onEnter(param)
end

function UdimoFSM:getEntity()
	return self.entity
end

return UdimoFSM
