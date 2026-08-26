-- chunkname: @modules/logic/necrologiststory/game/v3a5/V3A5_RoleStoryGameAnimView.lua

module("modules.logic.necrologiststory.game.v3a5.V3A5_RoleStoryGameAnimView", package.seeall)

local V3A5_RoleStoryGameAnimView = class("V3A5_RoleStoryGameAnimView", BaseView)

function V3A5_RoleStoryGameAnimView:onInitView()
	self.goBg = gohelper.findChild(self.viewGO, "BG")
	self.goCoin1 = gohelper.findChild(self.viewGO, "Middle/#go_coin/coin1")
	self.goCoinRotation1 = gohelper.findChild(self.viewGO, "Middle/#go_coin/coin1/ani/rotation")
	self.goCoin2 = gohelper.findChild(self.viewGO, "Middle/#go_coin/coin2")
	self.goCoinRotation2 = gohelper.findChild(self.viewGO, "Middle/#go_coin/coin2/ani/rotation")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A5_RoleStoryGameAnimView:addEvents()
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A5_PlayGameAnim, self.playAnim, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A5_UpdateCoin, self.updateCoin, self)
end

function V3A5_RoleStoryGameAnimView:removeEvents()
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A5_PlayGameAnim, self.playAnim, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A5_UpdateCoin, self.updateCoin, self)
end

function V3A5_RoleStoryGameAnimView:_editableInitView()
	return
end

function V3A5_RoleStoryGameAnimView:updateCoin(index, status)
	if self.rotationTween then
		return
	end

	local isIndex0 = index == 0
	local isIndex7 = index == 7
	local isIndex8 = index == 8
	local isFront = status == NecrologistStoryEnum.V3A5NodeStatus.Front

	if isIndex0 or isIndex7 or isIndex8 then
		if not self.goCoin2 then
			local goCoin = self.goCoin1

			gohelper.setActive(self.goCoin1, false)
			gohelper.setActive(self.goCoin2, false)
			gohelper.setActive(goCoin, true)

			local anim = goCoin:GetComponent(typeof(UnityEngine.Animator))

			if anim then
				if isIndex8 then
					anim:Play("middle", 0, 0)
					recthelper.setAnchorY(goCoin.transform, 86)
				else
					anim:Play(isFront and "front" or "back", 0, 0)
					recthelper.setAnchorY(goCoin.transform, 0)
				end
			end

			local goCoinRotation = gohelper.findChild(goCoin, "ani/rotation")

			if not gohelper.isNil(goCoinRotation) then
				local rotationRound = isIndex8 and 0.25 or isFront and 0 or 0.5
				local rotation = 360 * rotationRound

				transformhelper.setLocalRotation(goCoinRotation.transform, rotation, 0, 0)
			end

			local goShadow = gohelper.findChild(goCoin, "coin_shadow")

			gohelper.setActive(goShadow, true)
		end
	end
end

function V3A5_RoleStoryGameAnimView:playAnim(value, result, index)
	self:clearTween()

	self.value = value
	self.result = result
	self.upTotalTime = 1.5

	local useCoin2 = self.result == 3 or index == 1

	if useCoin2 then
		self.goTweenCoin = self.goCoin2 or self.goCoin1
	end

	if useCoin2 then
		self.goTweenRotation = self.goCoinRotation2 or self.goCoinRotation1
	end

	gohelper.setActive(self.goCoin1, false)
	gohelper.setActive(self.goCoin2, false)
	gohelper.setActive(self.goTweenCoin, true)

	local goShadow = gohelper.findChild(self.goTweenCoin, "coin_shadow")

	gohelper.setActive(goShadow, false)
	self:_playUpAnim()
	self:_playRotationAnim()
end

function V3A5_RoleStoryGameAnimView:_playUpAnim()
	local upTime = self:getUpTime()
	local coinStartY = 0
	local coinEndY = 200 * self.value

	recthelper.setAnchorY(self.goTweenCoin.transform, coinStartY)

	self.coinMoveTween = ZProj.TweenHelper.DOAnchorPosY(self.goTweenCoin.transform, coinEndY, upTime, self.onUpAnimFinished, self, nil, EaseType.OutCubic)

	local bgStartY = -100
	local bgEndY = -1300 * self.value

	recthelper.setAnchorY(self.goBg.transform, bgStartY)

	self.bgMoveTween = ZProj.TweenHelper.DOAnchorPosY(self.goBg.transform, bgEndY, upTime, nil, nil, nil, EaseType.OutCubic)
end

function V3A5_RoleStoryGameAnimView:onUpAnimFinished()
	self:_playDownAnim()
end

function V3A5_RoleStoryGameAnimView:_playRotationAnim()
	local rotationTime = self:getDownTime() + self:getUpTime()
	local rotationRound = math.ceil(rotationTime * 3) + (self.result == 3 and 0.25 or self.result == 2 and 0.5 or 0)
	local startRotation = 0

	transformhelper.setLocalRotation(self.goTweenRotation.transform, startRotation, 0, 0)

	self.endRotation = 360 * rotationRound
	self.rotationTween = ZProj.TweenHelper.DOTweenFloat(0, 1, rotationTime, self._frameRotation, nil, self, nil, EaseType.InOutQuad)
end

function V3A5_RoleStoryGameAnimView:_frameRotation(value)
	local rotation = value * self.endRotation

	transformhelper.setLocalRotation(self.goTweenRotation.transform, rotation, 0, 0)
end

function V3A5_RoleStoryGameAnimView:_playDownAnim()
	if self.coinMoveTween then
		ZProj.TweenHelper.KillById(self.coinMoveTween)

		self.coinMoveTween = nil
	end

	if self.bgMoveTween then
		ZProj.TweenHelper.KillById(self.bgMoveTween)

		self.bgMoveTween = nil
	end

	local downTime = self:getDownTime()
	local coinEndY = self.result == 3 and 86 or 0

	self.coinMoveTween = ZProj.TweenHelper.DOAnchorPosY(self.goTweenCoin.transform, coinEndY, downTime, self.onDownAnimFinished, self, nil, EaseType.InExpo)

	local bgEndY = -100

	self.bgMoveTween = ZProj.TweenHelper.DOAnchorPosY(self.goBg.transform, bgEndY, downTime, nil, nil, nil, EaseType.InOutQuint)
end

function V3A5_RoleStoryGameAnimView:onDownAnimFinished()
	self:clearTween()
	recthelper.setAnchorY(self.goBg.transform, -100)

	local anim = self.goTweenCoin:GetComponent(typeof(UnityEngine.Animator))

	if anim then
		anim:Play(string.format("rolling%s", self.result), 0, 0)
	end

	local goShadow = gohelper.findChild(self.goTweenCoin, "coin_shadow")

	gohelper.setActive(goShadow, true)

	if self.result == 3 then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_coin_stand)
	else
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_coin_fall)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A5_GameAnimFinished)
end

function V3A5_RoleStoryGameAnimView:getUpTime()
	return self.upTotalTime * self.value
end

function V3A5_RoleStoryGameAnimView:getDownTime()
	return self.upTotalTime * self.value * 0.67
end

function V3A5_RoleStoryGameAnimView:clearTween()
	if self.coinMoveTween then
		ZProj.TweenHelper.KillById(self.coinMoveTween)

		self.coinMoveTween = nil
	end

	if self.bgMoveTween then
		ZProj.TweenHelper.KillById(self.bgMoveTween)

		self.bgMoveTween = nil
	end

	if self.rotationTween then
		ZProj.TweenHelper.KillById(self.rotationTween)

		self.rotationTween = nil
	end
end

function V3A5_RoleStoryGameAnimView:onDestroyView()
	self:clearTween()
end

return V3A5_RoleStoryGameAnimView
