-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/transitions/UdimoIdleTransition.lua

module("modules.logic.scene.udimo.entitycomp.fsm.transitions.UdimoIdleTransition", package.seeall)

local UdimoIdleTransition = class("UdimoIdleTransition", UdimoBaseTransition)

function UdimoIdleTransition:onRegister()
	return
end

function UdimoIdleTransition:onFSMStart()
	return
end

function UdimoIdleTransition:checkTranslate(eventId)
	if eventId == UdimoEvent.OnPickUpUdimo then
		return UdimoEnum.UdimoState.PickedUp
	elseif eventId == UdimoEvent.UdimoBeginWalk then
		return UdimoEnum.UdimoState.Walk
	end
end

function UdimoIdleTransition:onStartTranslate(toStateName, param)
	if self.fsm then
		local entity = self.fsm:getEntity()

		if not entity then
			return
		end

		if toStateName == UdimoEnum.UdimoState.Walk then
			local udimoId = entity:getId()

			UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Idle2Walk, false, true, self._onAnimEnd, self, {
				toStateName = toStateName,
				param = param
			})
		else
			self:endTranslate(toStateName, param)
		end
	end
end

function UdimoIdleTransition:_onAnimEnd(param)
	if not param then
		return
	end

	self:endTranslate(param.toStateName, param.param)
end

function UdimoIdleTransition:onEndTranslate(toStateName, param)
	return
end

function UdimoIdleTransition:onFSMStop()
	return
end

function UdimoIdleTransition:onClear()
	return
end

return UdimoIdleTransition
