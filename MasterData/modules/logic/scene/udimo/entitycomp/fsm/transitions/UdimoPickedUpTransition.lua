-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/transitions/UdimoPickedUpTransition.lua

module("modules.logic.scene.udimo.entitycomp.fsm.transitions.UdimoPickedUpTransition", package.seeall)

local UdimoPickedUpTransition = class("UdimoPickedUpTransition", UdimoBaseTransition)

function UdimoPickedUpTransition:onRegister()
	self._entity = self.fsm and self.fsm:getEntity()
end

function UdimoPickedUpTransition:onFSMStart()
	return
end

function UdimoPickedUpTransition:checkTranslate(eventId, param)
	if not self._entity then
		return
	end

	if eventId == UdimoEvent.OnPickUpUdimoOver then
		local udimoId = self._entity:getId()
		local interactId = UdimoModel.instance:getUdimoInteractId(udimoId)

		if interactId then
			local friendId = param and param.friendId

			return (friendId or nil) and (UdimoEnum.UdimoState.Interact or UdimoEnum.UdimoState.WaitInteract)
		else
			return UdimoEnum.UdimoState.Walk
		end
	end
end

function UdimoPickedUpTransition:onStartTranslate(toStateName, param)
	if not self._entity then
		return
	end

	self:_killTween()

	if toStateName == UdimoEnum.UdimoState.Walk then
		self._entity:clampPosX()
		self._entity:refreshOrderLayer(toStateName)

		local curPosY, targetY, playAnimY = self._entity:getFallDownTargetY()

		param = param or {}
		param.fromPickUpState = true

		local fallDownParam = {
			toStateName = toStateName,
			param = param,
			targetY = targetY
		}

		if playAnimY then
			local speed = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.FallDownSpeed, false, nil, true)
			local durationTime = math.abs(curPosY - playAnimY) / speed

			self._fallDownTweenId = ZProj.TweenHelper.DOTweenFloat(curPosY, playAnimY, durationTime, self._onFallDownFrame, self._onReachPlayAnimY, self, fallDownParam, EaseType.Linear)
		else
			self:_onReachPlayAnimY(fallDownParam)
		end
	else
		self:endTranslate(toStateName, param)
	end
end

function UdimoPickedUpTransition:_onFallDownFrame(posY)
	if not self._entity or not posY then
		self:_killTween()

		return
	end

	self._entity:setPosition(nil, posY)
end

function UdimoPickedUpTransition:_onReachPlayAnimY(param)
	self:_killTween()

	if not self._entity or not param then
		return
	end

	local udimoId = self._entity:getId()

	self._entity:setPosition(nil, param.targetY)
	UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Catch2Walk, false, true, self._onAnimEnd, self, param)
end

function UdimoPickedUpTransition:_onAnimEnd(param)
	if not param then
		return
	end

	self:endTranslate(param.toStateName, param.param)
end

function UdimoPickedUpTransition:onEndTranslate(toStateName, param)
	if toStateName == UdimoEnum.UdimoState.Walk and self._entity then
		self._entity:checkAndAdjustPos(toStateName)
	end
end

function UdimoPickedUpTransition:onFSMStop()
	return
end

function UdimoPickedUpTransition:_killTween()
	if self._fallDownTweenId then
		ZProj.TweenHelper.KillById(self._fallDownTweenId)
	end

	self._fallDownTweenId = nil
end

function UdimoPickedUpTransition:onClear()
	self:_killTween()

	self._entity = nil
end

return UdimoPickedUpTransition
