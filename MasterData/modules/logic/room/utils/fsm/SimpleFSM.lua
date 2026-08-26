-- chunkname: @modules/logic/room/utils/fsm/SimpleFSM.lua

module("modules.logic.room.utils.fsm.SimpleFSM", package.seeall)

local SimpleFSM = class("SimpleFSM")

function SimpleFSM:ctor(context)
	self.context = context
	self.states = {}
	self.transitions = {}
	self.isRunning = false
	self.isTransitioning = false
	self.curStateName = nil
end

function SimpleFSM:registerState(state)
	if state.fsm then
		return
	end

	if self.states[state.name] then
		return
	end

	state:register(self, self.context)

	self.states[state.name] = state
end

function SimpleFSM:registerTransition(transition)
	if transition.fsm then
		return
	end

	if self.transitions[transition.name] then
		return
	end

	if string.nilorempty(transition.fromStateName) or string.nilorempty(transition.toStateName) or not transition.eventId then
		return
	end

	if not self.states[transition.fromStateName] or not self.states[transition.toStateName] then
		return
	end

	for _, one in pairs(self.transitions) do
		if one.fromStateName == transition.fromStateName and one.eventId == transition.eventId then
			return
		end
	end

	transition:register(self, self.context)

	self.transitions[transition.name] = transition
end

function SimpleFSM:triggerEvent(eventId, param)
	if not self.isRunning or self.isTransitioning then
		return
	end

	if string.nilorempty(self.curStateName) then
		return
	end

	for name, transition in pairs(self.transitions) do
		if transition.fromStateName == self.curStateName and transition.eventId == eventId and transition:check() then
			self:startTransition(transition, param)

			break
		end
	end
end

function SimpleFSM:startTransition(transition, param)
	self.isTransitioning = true

	self:leaveState(self.curStateName)
	transition:onStart(param)
end

function SimpleFSM:endTransition(toStateName)
	self.isTransitioning = false

	self:enterState(toStateName)
end

function SimpleFSM:enterState(stateName)
	self.curStateName = stateName

	self.states[self.curStateName]:onEnter()
end

function SimpleFSM:leaveState()
	local previousStateName = self.curStateName

	self.curStateName = nil

	self.states[previousStateName]:onLeave()
end

function SimpleFSM:start(stateName)
	if self.isRunning then
		return
	end

	if string.nilorempty(stateName) then
		return
	end

	for _, state in pairs(self.states) do
		state:start()
	end

	for _, transition in pairs(self.transitions) do
		transition:start()
	end

	self.isRunning = true
	self.isTransitioning = false

	self:enterState(stateName)
end

function SimpleFSM:stop()
	if not self.isRunning then
		return
	end

	for _, state in pairs(self.states) do
		state:stop()
	end

	for _, transition in pairs(self.transitions) do
		transition:stop()
	end

	self.isRunning = false
	self.isTransitioning = false
	self.curStateName = nil
end

function SimpleFSM:clear()
	for _, state in pairs(self.states) do
		state:clear()
	end

	for _, transition in pairs(self.transitions) do
		transition:clear()
	end
end

return SimpleFSM
