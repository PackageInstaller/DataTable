-- chunkname: @modules/logic/fight/view/FightViewPartVisible.lua

module("modules.logic.fight.view.FightViewPartVisible", package.seeall)

local FightViewPartVisible = class("FightViewPartVisible", BaseView)
local visible_clothSkill = false
local visible_handCard = false
local visible_playCard = false
local visible_enemyRound = false
local visible_waitingArea = false

function FightViewPartVisible.setWaitAreaActive(active)
	visible_waitingArea = active

	FightController.instance:dispatchEvent(FightEvent.UpdateUIPartVisible)
end

function FightViewPartVisible.set(clothSkill, handCard, playCard, enemyRound, waitingArea)
	visible_clothSkill = clothSkill
	visible_handCard = handCard
	visible_playCard = playCard
	visible_enemyRound = enemyRound
	visible_waitingArea = waitingArea

	FightController.instance:dispatchEvent(FightEvent.UpdateUIPartVisible)
end

function FightViewPartVisible.setPlayStatus(enemyRound, waitingArea)
	visible_enemyRound = enemyRound

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		return
	end

	visible_waitingArea = waitingArea
end

function FightViewPartVisible.setWaitingStatus(state)
	visible_waitingArea = state
end

function FightViewPartVisible:onInitView()
	self._clothSkillGO = gohelper.findChild(self.viewGO, "root/heroSkill")
	self._handCardGO = gohelper.findChild(self.viewGO, "root/handcards")
	self._handCardInnerGO = gohelper.findChild(self.viewGO, "root/handcards/handcards")
	self._playCardGO = gohelper.findChild(self.viewGO, "root/playcards")
	self._enemyRoundGO = gohelper.findChild(self.viewGO, "root/enemyRound")
	self._enemyRoundTextGO = gohelper.findChild(self.viewGO, "root/enemyRoundText")
	self._waitingAreaGO = gohelper.findChild(self.viewGO, "root/waitingArea")
	self._rogueSkillRoot = gohelper.findChild(self.viewGO, "root/rogueSkillRoot")
	self._playCardTr = self._playCardGO.transform

	self:_onSetPlayCardPartOriginPos()
	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.HandCardGo, self._handCardGO)
	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.HandCardInnerGo, self._handCardInnerGO)
	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.ClothSkillGo, self._clothSkillGO)
	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.PlayCardGO, self._playCardGO)
	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.WaitingAreaGO, self._waitingAreaGO)

	visible_clothSkill = false
	visible_handCard = false
	visible_playCard = false
	visible_enemyRound = false
	visible_waitingArea = false
end

function FightViewPartVisible:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.UpdateUIPartVisible, self._updateUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self.onCameraFocusChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnUniversalAppear, self._tweenHandCardContainerScale, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self._tweenHandCardContainerScale, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillExpand, self._onClothSkillExpand, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillShrink, self._onClothSkillShrink, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCombineOneCard, self._onCombineOneCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onClothSkillShrink, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onClothSkillShrink, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetPlayCardPartOutScreen, self._onSetPlayCardPartOutScreen, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetPlayCardPartOriginPos, self._onSetPlayCardPartOriginPos, self)
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._updateUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetHandCardVisible, self._onSetHandCardVisible, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelVisibleViewScaleTween, self._onCancelVisibleViewScaleTween, self)
end

function FightViewPartVisible:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.UpdateUIPartVisible, self._updateUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self.onCameraFocusChanged, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnUniversalAppear, self._tweenHandCardContainerScale, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnResetCard, self._tweenHandCardContainerScale, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnClothSkillExpand, self._onClothSkillExpand, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnClothSkillShrink, self._onClothSkillShrink, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCombineOneCard, self._onCombineOneCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onClothSkillShrink, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onClothSkillShrink, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetPlayCardPartOutScreen, self._onSetPlayCardPartOutScreen, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetPlayCardPartOriginPos, self._onSetPlayCardPartOriginPos, self)
	self.removeEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._updateUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetHandCardVisible, self._onSetHandCardVisible, self)
	self.removeEventCb(self, FightController.instance, FightEvent.CancelVisibleViewScaleTween, self._onCancelVisibleViewScaleTween, self)
end

function FightViewPartVisible:onOpen()
	self:_updateUI()

	self._clothSkillExpand = false

	self:_tweenHandCardContainerScale()
end

function FightViewPartVisible:_onClothSkillExpand()
	self._clothSkillExpand = true

	self:_tweenHandCardContainerScale()
end

function FightViewPartVisible:_onClothSkillShrink()
	self._clothSkillExpand = false

	self:_tweenHandCardContainerScale()
end

function FightViewPartVisible:_onCombineOneCard()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		self:_onClothSkillShrink()
	end
end

function FightViewPartVisible:_onPlayHandCard(cardInfoMO, waitRemoveCard)
	if waitRemoveCard then
		return
	end

	self:_tweenHandCardContainerScale()
end

function FightViewPartVisible:_tweenHandCardContainerScale()
	local time = FightWorkEffectDistributeCard.getHandCardScaleTime()
	local scale = FightCardDataHelper.getHandCardContainerScale(self._clothSkillExpand)

	self._scaleTweenId = ZProj.TweenHelper.DOScale(self._handCardGO.transform, scale, scale, scale, time)
end

function FightViewPartVisible:_onCancelVisibleViewScaleTween()
	if self._scaleTweenId then
		ZProj.TweenHelper.KillById(self._scaleTweenId)

		self._scaleTweenId = nil
	end
end

function FightViewPartVisible:_updateUI()
	local canvasGroup = gohelper.onceAddComponent(self._playCardGO, typeof(UnityEngine.CanvasGroup))

	if self._playCardGO.activeInHierarchy then
		local isPrevShowPlayCard = canvasGroup.alpha > 0.9

		if not isPrevShowPlayCard and visible_playCard then
			if GMFightShowState.cards then
				ZProj.TweenHelper.KillByObj(canvasGroup)
				ZProj.TweenHelper.DOFadeCanvasGroup(self._playCardGO, 0, 1, 0.165)
			end
		elseif isPrevShowPlayCard and not visible_playCard then
			ZProj.TweenHelper.KillByObj(canvasGroup)
			ZProj.TweenHelper.DOFadeCanvasGroup(self._playCardGO, 1, 0, 0.165)
		end

		if FightDataHelper.fieldMgr:isRouge2() then
			gohelper.setActive(self._rogueSkillRoot, GMFightShowState.clothSkill)
			gohelper.setActive(self._clothSkillGO, false)
		else
			local canShowCloth = PlayerClothModel.instance:getSpEpisodeClothID() or OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) and FightModel.instance.clothId > 0

			gohelper.setActive(self._clothSkillGO, visible_clothSkill and canShowCloth and GMFightShowState.clothSkill)

			if visible_clothSkill and canShowCloth then
				::label_15_0::

				local showRougeSkill = GMFightShowState.clothSkill

				if visible_clothSkill then
					FightController.instance:dispatchEvent(FightEvent.OnGuideShowRougeSkill)
				end

				gohelper.setActive(self._rogueSkillRoot, visible_clothSkill)
			end
		end

		gohelper.setActive(self._handCardGO, visible_handCard)
		gohelper.setActive(self._playCardGO, visible_playCard)
		gohelper.setActive(self._enemyRoundGO, visible_enemyRound and GMFightShowState.bottomEnemyRound)
		gohelper.setActive(self._enemyRoundTextGO, visible_enemyRound and GMFightShowState.bottomEnemyRound)
		gohelper.setActive(self._waitingAreaGO, visible_waitingArea and GMFightShowState.cards)
		self:setActiveCanvasGroup(self._handCardInnerGO, GMFightShowState.cards)
		self:setActiveCanvasGroup(self._playCardGO, GMFightShowState.cards)
		self:setActiveCanvasGroup(self._waitingAreaGO, GMFightShowState.cards)
	end
end

function FightViewPartVisible:setActiveCanvasGroup(go, active)
	local canvasGroup = gohelper.onceAddComponent(go, gohelper.Type_CanvasGroup)

	canvasGroup.alpha = active and 1 or 0
end

function FightViewPartVisible:onCameraFocusChanged(isFocus)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		self:setActiveCanvasGroup(self._playCardGO, not isFocus)
		gohelper.setActive(self._handCardGO, not isFocus)
		gohelper.setActiveCanvasGroup(FightNameMgr.instance:getNameParent(), not isFocus)
	end
end

function FightViewPartVisible:_onSetPlayCardPartOutScreen()
	recthelper.setAnchor(self._playCardTr, 10000, 10000)
end

function FightViewPartVisible:_onSetPlayCardPartOriginPos()
	local originAnchor, scale = FightPlayCardLayoutHelper.getAnchorPosAndScale(FightPlayCardLayoutHelper.PlayCardOperateType.PlayCard)

	recthelper.setAnchor(self._playCardTr, originAnchor.x, originAnchor.y)
	transformhelper.setLocalScale(self._playCardTr, scale, scale, scale)
end

function FightViewPartVisible:_onSetHandCardVisible(state, revert)
	if revert then
		gohelper.setActive(self._waitingAreaGO, visible_waitingArea)
		gohelper.setActive(self._handCardGO, visible_handCard)
	else
		gohelper.setActive(self._waitingAreaGO, false)
		gohelper.setActive(self._handCardGO, state)
	end
end

return FightViewPartVisible
