-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/transitions/UdimoWaitTransition.lua

module("modules.logic.scene.udimo.entitycomp.fsm.transitions.UdimoWaitTransition", package.seeall)

local UdimoWaitTransition = class("UdimoWaitTransition", UdimoBaseTransition)

function UdimoWaitTransition:onRegister()
	return
end

function UdimoWaitTransition:onFSMStart()
	return
end

function UdimoWaitTransition:checkTranslate(eventId)
	if eventId == UdimoEvent.OnPickUpUdimo then
		return UdimoEnum.UdimoState.PickedUp
	elseif eventId == UdimoEvent.UdimoWaitInteractOverTime then
		local udimoEntity = self.fsm:getEntity()

		if udimoEntity then
			udimoEntity:checkAndAdjustPos()
		end

		return UdimoEnum.UdimoState.Walk
	elseif eventId == UdimoEvent.BeginInetract then
		return UdimoEnum.UdimoState.Interact
	end
end

function UdimoWaitTransition:onStartTranslate(toStateName, param)
	self:endTranslate(toStateName, param)
end

function UdimoWaitTransition:onEndTranslate(toStateName, param)
	return
end

function UdimoWaitTransition:onFSMStop()
	return
end

function UdimoWaitTransition:onClear()
	return
end

return UdimoWaitTransition
