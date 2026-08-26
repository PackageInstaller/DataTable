-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/transitions/UdimoWalkTransition.lua

module("modules.logic.scene.udimo.entitycomp.fsm.transitions.UdimoWalkTransition", package.seeall)

local UdimoWalkTransition = class("UdimoWalkTransition", UdimoBaseTransition)

function UdimoWalkTransition:onRegister()
	return
end

function UdimoWalkTransition:onFSMStart()
	return
end

function UdimoWalkTransition:checkTranslate(eventId)
	if eventId == UdimoEvent.OnPickUpUdimo then
		return UdimoEnum.UdimoState.PickedUp
	elseif eventId == UdimoEvent.UdimoWalkFinish then
		return UdimoEnum.UdimoState.Idle
	end
end

function UdimoWalkTransition:onStartTranslate(toStateName, param)
	local udimoEntity = self.fsm:getEntity()

	if not udimoEntity then
		return
	end

	local udimoId = udimoEntity:getId()

	if toStateName == UdimoEnum.UdimoState.Idle then
		UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Walk2Idle, false, true, self._onAnimEnd, self, {
			toStateName = toStateName,
			param = param
		})
	else
		self:endTranslate(toStateName, param)
	end
end

function UdimoWalkTransition:_onAnimEnd(param)
	if not param then
		return
	end

	self:endTranslate(param.toStateName, param.param)
end

function UdimoWalkTransition:onEndTranslate(toStateName, param)
	return
end

function UdimoWalkTransition:onFSMStop()
	return
end

function UdimoWalkTransition:onClear()
	return
end

return UdimoWalkTransition
