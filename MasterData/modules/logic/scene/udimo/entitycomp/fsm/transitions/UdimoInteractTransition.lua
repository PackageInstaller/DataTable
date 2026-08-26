-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/transitions/UdimoInteractTransition.lua

module("modules.logic.scene.udimo.entitycomp.fsm.transitions.UdimoInteractTransition", package.seeall)

local UdimoInteractTransition = class("UdimoInteractTransition", UdimoBaseTransition)

function UdimoInteractTransition:onRegister()
	return
end

function UdimoInteractTransition:onFSMStart()
	return
end

function UdimoInteractTransition:checkTranslate(eventId)
	if eventId == UdimoEvent.OnPickUpUdimo then
		return UdimoEnum.UdimoState.PickedUp
	elseif eventId == UdimoEvent.InteractFinished then
		local udimoEntity = self.fsm:getEntity()

		if udimoEntity then
			udimoEntity:checkAndAdjustPos()
		end

		return UdimoEnum.UdimoState.Walk
	end
end

function UdimoInteractTransition:onStartTranslate(toStateName, param)
	self:endTranslate(toStateName, param)
end

function UdimoInteractTransition:onEndTranslate(toStateName, param)
	return
end

function UdimoInteractTransition:onFSMStop()
	return
end

function UdimoInteractTransition:onClear()
	return
end

return UdimoInteractTransition
