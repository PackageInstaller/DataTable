-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/UdimoBaseTransition.lua

module("modules.logic.scene.udimo.entitycomp.fsm.UdimoBaseTransition", package.seeall)

local UdimoBaseTransition = class("UdimoBaseTransition")

function UdimoBaseTransition:ctor(fromStateName)
	self.fromStateName = fromStateName

	self:clear()
end

function UdimoBaseTransition:register(fsm)
	self.fsm = fsm
	self._isClear = false

	self:onRegister()
end

function UdimoBaseTransition:checkTranslate(eventId, param)
	if not self._transitions then
		return
	end

	for _, transition in ipairs(self._transitions) do
		local result = transition:checkFunc(eventId, param)

		if result then
			return transition.toStateName
		end
	end
end

function UdimoBaseTransition:startTranslate(toStateName, param)
	self:onStartTranslate(toStateName, param)
end

function UdimoBaseTransition:endTranslate(toStateName, param)
	self:onEndTranslate(toStateName, param)

	if self.fsm then
		self.fsm:endTransition(toStateName, param)
	end
end

function UdimoBaseTransition:clear()
	self._isClear = true

	self:onClear()

	self.fsm = nil
end

function UdimoBaseTransition:onRegister()
	self._transitions = {}
end

function UdimoBaseTransition:onFSMStart()
	return
end

function UdimoBaseTransition:onStartTranslate(toStateName, param)
	self:endTranslate(toStateName, param)
end

function UdimoBaseTransition:onEndTranslate(toStateName, param)
	return
end

function UdimoBaseTransition:onFSMStop()
	return
end

function UdimoBaseTransition:onClear()
	return
end

return UdimoBaseTransition
