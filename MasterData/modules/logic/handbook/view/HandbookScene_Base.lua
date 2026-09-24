-- chunkname: @modules/logic/handbook/view/HandbookScene_Base.lua

module("modules.logic.handbook.view.HandbookScene_Base", package.seeall)

local HandbookScene_Base = class("HandbookScene_Base")
local centerCardIdx = 3
local cardCount = 5
local dragRate = 0.00075
local maxDragProgressPerFrame = 0.15
local cardDefaultPosMap = {
	0.8333,
	0.6667,
	0.5,
	0.3333,
	0.1667
}
local resetPosDuration = 0.25
local openDetailDuration = 0.1

function HandbookScene_Base:ctor()
	self._enterAniDone = false
	self._redDotComp = nil
	self._unlockVxLoader = nil
end

function HandbookScene_Base:setScene(scene)
	self._scene = scene
end

function HandbookScene_Base:setupRedDot(redDotComp)
	self._redDotComp = redDotComp
end

function HandbookScene_Base:getSkinCount()
	return
end

function HandbookScene_Base:getCardCount()
	return
end

function HandbookScene_Base:getCardDefaultPosMap()
	return cardDefaultPosMap
end

function HandbookScene_Base:isMaxProgressAtScreenLeft()
	return true
end

function HandbookScene_Base:getSkinCardDir()
	return
end

function HandbookScene_Base:getSkinDefaultCardPath()
	return
end

function HandbookScene_Base:getUnlockVxPath()
	return
end

function HandbookScene_Base:getUnlockVxGoName(cardIdx)
	return
end

function HandbookScene_Base:getRedDotLocateWrapCount()
	return
end

function HandbookScene_Base:isModeEntered()
	return
end

function HandbookScene_Base:isModeEntering()
	return
end

function HandbookScene_Base:onDispatchEnterEvent()
	return
end

function HandbookScene_Base:onDispatchExitEvent()
	return
end

function HandbookScene_Base:locateInitialCards()
	return
end

function HandbookScene_Base:enterScene()
	local scene = self._scene

	if self:isModeEntered() then
		return
	end

	scene._tarotCardAniProgress = {}

	self:onEnterSceneStart()
	self:_parseCardDatas()
	self:locateInitialCards()
	self:_locateFirstUnlockRedDotSkin()
	self:_hideRedDotAndMarkRead()
	self:_initCardGoRefs()

	for i = 1, cardCount do
		scene:setCardSprite(i, scene._tarotCardIdx2SkinIdx[i])
	end

	self:onEnterSceneEnd()
end

function HandbookScene_Base:onEnterSceneStart()
	local scene = self._scene

	scene._sceneAnimatorPlayer:Play(UIAnimationName.Click, nil, nil)
	self:onDispatchEnterEvent()
end

function HandbookScene_Base:_parseCardDatas()
	local scene = self._scene

	scene._tarotCardDatas = {}
	scene._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(scene._suitId)

	local skinIdStr = scene._skinSuitCfg.skinContain
	local skinImageNameStr = scene._skinSuitCfg.tarotCardPath

	scene._skinIdList = string.splitToNumber(skinIdStr, "|")
	scene._skinCardNameList = string.split(skinImageNameStr, "|")

	for i = 1, self:getSkinCount() do
		scene._tarotCardDatas[i] = {}

		if i <= #scene._skinIdList then
			local skinId = scene._skinIdList[i]

			scene._tarotCardDatas[i].path = string.format("%s/%s.png", self:getSkinCardDir(), scene._skinCardNameList[i])
			scene._tarotCardDatas[i].skinId = skinId

			self:_onParseCardData(i, skinId)
		else
			scene._tarotCardDatas[i].path = self:getSkinDefaultCardPath()
		end
	end
end

function HandbookScene_Base:_onParseCardData(cardIdx, skinId)
	return
end

function HandbookScene_Base:_locateFirstUnlockRedDotSkin()
	local scene = self._scene

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(scene._suitId) then
		local tarotSkinCount = self:getRedDotLocateWrapCount()

		for i = 1, tarotSkinCount do
			local skinId = scene._skinIdList[i]

			if skinId and HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId) then
				local leftIdx = i - 2

				while leftIdx < 1 do
					leftIdx = leftIdx + tarotSkinCount
				end

				scene._curLeftIdx = leftIdx

				local rightIdx = i + 2

				while tarotSkinCount < rightIdx do
					rightIdx = rightIdx - tarotSkinCount
				end

				scene._curRightIdx = rightIdx

				break
			end
		end
	end
end

function HandbookScene_Base:_hideRedDotAndMarkRead()
	local scene = self._scene

	if self._redDotComp then
		self._redDotComp:forceHide()
	end

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(scene._suitId) then
		HandbookController.instance:markHandbookSkinNewRedDotShow(scene._suitId)
	end
end

function HandbookScene_Base:_initCardGoRefs()
	local scene = self._scene

	scene._tarotCardGos = scene:getUserDataTb_()
	scene._tarotCardSpriteRender = scene:getUserDataTb_()
	scene._tarotCardGlowSpriteRender = scene:getUserDataTb_()
	scene._tarotCardAnimators = scene:getUserDataTb_()
	scene._tarotCardIdx2SkinIdx = {}
	scene._tarotCardUnlockVxs = scene:getUserDataTb_()
	scene._tarotCardUnlockAnimEvent = scene:getUserDataTb_()
	scene._tarotCardUnlockAnimator = scene:getUserDataTb_()

	self:_initSubSceneCardTables()

	local unlockVxPrefab = scene.viewContainer._abLoader:getAssetItem(self:getUnlockVxPath()):GetResource()

	for i = 1, cardCount do
		local cardRootGo = gohelper.findChild(scene._curSceneGo, string.format("#Card/card0%d", i))

		scene._tarotCardGos[i] = gohelper.findChild(cardRootGo, "card")

		self:_setupCardClickListener(scene._tarotCardGos[i], i)

		scene._tarotCardAnimators[i] = cardRootGo:GetComponent(gohelper.Type_Animator)

		local tarotCardSpriteRenderGo = cardRootGo.transform:Find("card/sprite").gameObject

		scene._tarotCardSpriteRender[i] = tarotCardSpriteRenderGo:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local goSpriteGlowEffect = gohelper.findChild(cardRootGo, "card/sprite/spriteglow")

		scene._tarotCardGlowSpriteRender[i] = goSpriteGlowEffect:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local skinIdx = (scene._curLeftIdx - 1 + i - 1) % self:getSkinCount() + 1

		scene._tarotCardIdx2SkinIdx[i] = skinIdx

		self:_setupCardExtraRenderers(cardRootGo, i, scene._tarotCardDatas[skinIdx].skinId)

		local uxName = self:getUnlockVxGoName(i)
		local unlockVxGo = gohelper.findChild(scene._tarotCardGos[i], uxName)

		unlockVxGo = unlockVxGo or gohelper.clone(unlockVxPrefab, scene._tarotCardGos[i], uxName)

		gohelper.setActive(unlockVxGo, false)
		gohelper.setAsLastSibling(unlockVxGo)

		scene._tarotCardUnlockVxs[i] = unlockVxGo

		local animEvent = unlockVxGo:GetComponent(gohelper.Type_AnimationEventWrap)

		scene._tarotCardUnlockAnimEvent[i] = animEvent

		local param = {
			self,
			i
		}

		animEvent:AddEventListener("unlock", self.onUnlockAnimPlayFinish, param)

		scene._tarotCardUnlockAnimator[i] = gohelper.findChildComponent(unlockVxGo, "", gohelper.Type_Animator)
	end
end

function HandbookScene_Base:_initSubSceneCardTables()
	return
end

function HandbookScene_Base:_setupCardExtraRenderers(cardRootGo, cardIdx, skinId)
	return
end

function HandbookScene_Base:_setupCardClickListener(cardGo, cardIdx)
	local clickListener = HandbookSkinScene.getOrAddBoxCollider2D(cardGo)

	clickListener:AddMouseUpListener(self.onItemClickUp, self, cardIdx)
end

function HandbookScene_Base:onEnterSceneEnd()
	return
end

function HandbookScene_Base:onUnlockAnimPlayFinish(param)
	if param then
		-- block empty
	end
end

function HandbookScene_Base:onEnterAniDone()
	local scene = self._scene

	self:_markModeEntered()

	scene._maxProgress = 0.916
	scene._minProgress = 0.083

	local cardPosMap = self:getCardDefaultPosMap()

	for i = 1, cardCount do
		scene._tarotCardAniProgress[i] = cardPosMap[i]
	end

	for i = 1, cardCount do
		local aniName = "slide"

		scene:UpdateAnimProgress(scene._tarotCardAnimators[i], aniName, scene._tarotCardAniProgress[i])
		self:_onCardEnterAniDone(i)
	end
end

function HandbookScene_Base:_markModeEntered()
	return
end

function HandbookScene_Base:_onCardEnterAniDone(cardIdx)
	local scene = self._scene

	self:_refreshCardUnlockUx(cardIdx, scene._tarotCardIdx2SkinIdx[cardIdx])
end

function HandbookScene_Base:_doExitScene()
	local scene = self._scene

	scene._tarotCardAniProgress = {}

	scene._sceneAnimatorPlayer:Play(UIAnimationName.Back, nil, nil)
	self:onDispatchExitEvent()
	TaskDispatcher.runDelay(self.onExitAniDone, self, 2)
end

function HandbookScene_Base:exitScene()
	if not self:isModeEntered() and not self:isModeEntering() then
		return
	end

	self:_markModeExited()
	self:_doExitScene()
end

function HandbookScene_Base:_markModeExited()
	return
end

function HandbookScene_Base:onExitAniDone()
	if self._redDotComp then
		self._redDotComp:resetForceHide()
	end
end

function HandbookScene_Base:isInMode()
	return self:isModeEntered() or self:isModeEntering()
end

function HandbookScene_Base:_refreshCardUnlockUx(cardGoIdx, skinIdx)
	local scene = self._scene
	local animator = scene._tarotCardUnlockAnimator[cardGoIdx]
	local skinId = scene._tarotCardDatas[skinIdx].skinId

	if skinId then
		::label_38_0::

		local haveSkin = HeroModel.instance:checkHasSkin(skinId)

		gohelper.setActive(scene._tarotCardUnlockVxs[cardGoIdx], haveSkin)

		if haveSkin then
			local showUnlockAnim = HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId)
			local unlockVxGo = scene._tarotCardUnlockVxs[cardGoIdx]

			gohelper.setAsLastSibling(unlockVxGo)
			self:_playUnlockUx(cardGoIdx, animator, skinId, showUnlockAnim)
		end
	end
end

function HandbookScene_Base:_playUnlockUx(cardGoIdx, animator, skinId, showUnlockAnim)
	return
end

function HandbookScene_Base:onItemClickUp(cardId)
	local scene = self._scene

	if scene._dragging or not self:isModeEntered() then
		return
	end

	if not scene.sceneVisible then
		return
	end

	local skinIdx = scene._tarotCardIdx2SkinIdx[cardId]

	self:doCardPosToMiddle(skinIdx)
end

function HandbookScene_Base:doCardDragBegin()
	local scene = self._scene

	for i = 1, cardCount do
		local curProgress = scene._tarotCardAniProgress[i]
		local cardPoxIdx = self:_checkCardPosIdx(curProgress)

		if cardPoxIdx == centerCardIdx then
			local cardAnimator = scene._tarotCardAnimators[i]
			local skinIdx = scene._tarotCardIdx2SkinIdx[i]
			local skinId = scene._tarotCardDatas[skinIdx].skinId
			local skinCfg = SkinConfig.instance:getSkinCo(skinId)

			if not skinCfg then
				return
			end

			self:_doPlaySpCardCloseAni(cardAnimator, skinId)
		end
	end
end

HandbookScene_Base.doCardDragToMiddleBegin = HandbookScene_Base.doCardDragBegin

function HandbookScene_Base:_doPlaySpCardCloseAni(cardAnimator, skinId)
	return
end

function HandbookScene_Base:getMiddleSkinIdx()
	local scene = self._scene
	local offset = (self:getCardCount() - 1) / 2

	return (scene._curLeftIdx - 1 + offset) % self:getSkinCount() + 1
end

function HandbookScene_Base:_checkFirstCardPosIdxByMiddleSkinIdx(skinIdx)
	local scene = self._scene
	local cardPosMap = self:getCardDefaultPosMap()
	local middleSkinMoveOffset = 0
	local idxAdd = 0
	local targetProgress = cardPosMap[centerCardIdx]

	for i = 1, cardCount do
		if skinIdx == scene._tarotCardIdx2SkinIdx[i] then
			local curProgress = scene._tarotCardAniProgress[i]

			middleSkinMoveOffset = targetProgress - curProgress

			local curIndex = self:_checkCardPosIdx(curProgress)

			idxAdd = curIndex - centerCardIdx

			break
		end
	end

	return middleSkinMoveOffset, idxAdd
end

function HandbookScene_Base:_checkCardPosIdx(curProgress)
	local cardPosMap = self:getCardDefaultPosMap()
	local minDiff = math.huge
	local minIdx = 1

	for i, pos in ipairs(cardPosMap) do
		local diff = math.abs(curProgress - pos)

		if diff < minDiff then
			minDiff = diff
			minIdx = i
		end
	end

	return minIdx
end

function HandbookScene_Base:doCardPosToMiddle(skinIdx)
	local scene = self._scene
	local skinId = scene._tarotCardDatas[skinIdx].skinId

	if self:getMiddleSkinIdx() == skinIdx then
		if skinId then
			scene:openSkinDetailView(skinId)
		end

		return
	end

	self:doCardDragToMiddleBegin()

	scene._dragResetPosTweens = {}
	scene._dragging = true
	scene._tempSkinId = skinId

	local removeProgressOffset, idxAdd = self:_checkFirstCardPosIdxByMiddleSkinIdx(skinIdx)

	scene._curProgressOffset = 0

	local changeNum = math.abs(idxAdd)

	scene._leftChangeNum = changeNum
	scene._rightChangeNum = changeNum

	if scene._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(scene._tweenCardPosTweenId)

		scene._tweenCardPosTweenId = nil
	end

	local duration = resetPosDuration

	TaskDispatcher.runDelay(self.onDoCardPosToMiddleEnd, self, duration + openDetailDuration)

	scene._tweenCardPosTweenId = ZProj.TweenHelper.DOTweenFloat(0, removeProgressOffset, duration, self.cardPosToMiddleTweenFrameCallback, self.cardPosToMiddleTweenEndCallback, self)
end

function HandbookScene_Base:onDoCardPosToMiddleEnd()
	local scene = self._scene

	scene._dragging = false

	scene:openSkinDetailView(scene._tempSkinId)
	TaskDispatcher.cancelTask(self.onDoCardPosToMiddleEnd, self)

	scene._tempSkinId = nil
end

function HandbookScene_Base:_wrapCardWindowForward(cardGoIdx)
	local scene = self._scene
	local skinCount = self:getSkinCount()

	scene._curLeftIdx = skinCount <= scene._curLeftIdx and 1 or scene._curLeftIdx + 1
	scene._curRightIdx = skinCount <= scene._curRightIdx and 1 or scene._curRightIdx + 1

	self:_setupCardExtraRenderers(scene._tarotCardAnimators[cardGoIdx].gameObject, cardGoIdx, scene._tarotCardDatas[scene._curRightIdx].skinId)
	scene:setCardSprite(cardGoIdx, scene._curRightIdx)

	scene._tarotCardIdx2SkinIdx[cardGoIdx] = scene._curRightIdx
end

function HandbookScene_Base:_wrapCardWindowBackward(cardGoIdx)
	local scene = self._scene
	local skinCount = self:getSkinCount()

	scene._curLeftIdx = scene._curLeftIdx <= 1 and skinCount or scene._curLeftIdx - 1
	scene._curRightIdx = scene._curRightIdx <= 1 and skinCount or scene._curRightIdx - 1

	self:_setupCardExtraRenderers(scene._tarotCardAnimators[cardGoIdx].gameObject, cardGoIdx, scene._tarotCardDatas[scene._curLeftIdx].skinId)
	scene:setCardSprite(cardGoIdx, scene._curLeftIdx)

	scene._tarotCardIdx2SkinIdx[cardGoIdx] = scene._curLeftIdx
end

function HandbookScene_Base:cardPosToMiddleTweenFrameCallback(value)
	local scene = self._scene
	local difference = value - scene._curProgressOffset

	scene._curProgressOffset = value

	for i, cardAnimator in ipairs(scene._tarotCardAnimators) do
		local curProgress = scene._tarotCardAniProgress[i]
		local dragAnimationName = "slide"
		local newProgress = curProgress + difference

		if newProgress >= scene._maxProgress then
			scene._tarotCardAniProgress[i] = scene._minProgress + newProgress - scene._maxProgress

			if self:isMaxProgressAtScreenLeft() then
				if scene._rightChangeNum > 0 then
					self:_wrapCardWindowForward(i)

					scene._rightChangeNum = scene._rightChangeNum - 1
				end
			elseif scene._leftChangeNum > 0 then
				self:_wrapCardWindowBackward(i)

				scene._leftChangeNum = scene._leftChangeNum - 1
			end
		elseif newProgress <= scene._minProgress then
			scene._tarotCardAniProgress[i] = scene._maxProgress + newProgress - scene._minProgress

			if self:isMaxProgressAtScreenLeft() then
				if scene._leftChangeNum > 0 then
					self:_wrapCardWindowBackward(i)

					scene._leftChangeNum = scene._leftChangeNum - 1
				end
			elseif scene._rightChangeNum > 0 then
				self:_wrapCardWindowForward(i)

				scene._rightChangeNum = scene._rightChangeNum - 1
			end
		else
			scene._tarotCardAniProgress[i] = newProgress
		end

		scene:UpdateAnimProgress(cardAnimator, dragAnimationName, scene._tarotCardAniProgress[i])
	end
end

function HandbookScene_Base:cardPosToMiddleTweenEndCallback()
	for i = 1, cardCount do
		self:playSpCardOpenAni(i)
	end
end

function HandbookScene_Base:doCardPosResetTween()
	local scene = self._scene

	scene._dragResetPosTweens = {}

	local cardPosMap = self:getCardDefaultPosMap()

	for i = 1, cardCount do
		local curProgress = scene._tarotCardAniProgress[i]
		local resetIdx = ((i == 1 or nil) and self:_checkCardPosIdx(curProgress)) + (i - 1)

		resetIdx = resetIdx > cardCount and resetIdx - cardCount or resetIdx

		local resetProgress = cardPosMap[resetIdx]

		scene._dragResetPosTweens[i] = ZProj.TweenHelper.DOTweenFloat(curProgress, resetProgress, resetPosDuration, self.cardPosResetTweenFrameCallback, self.cardPosResetTweenEndCallback, self, i)

		self:playSpCardOpenAni(i)
	end
end

function HandbookScene_Base:cardPosResetTweenFrameCallback(value, idx)
	local scene = self._scene
	local dragAnimationName = "slide"
	local cardAnimator = scene._tarotCardAnimators[idx]

	scene._tarotCardAniProgress[idx] = value

	scene:UpdateAnimProgress(cardAnimator, dragAnimationName, value)
end

function HandbookScene_Base:cardPosResetTweenEndCallback(idx)
	return
end

function HandbookScene_Base:playSpCardOpenAni(i)
	local scene = self._scene
	local cardAnimator = scene._tarotCardAnimators[i]
	local skinIdx = scene._tarotCardIdx2SkinIdx[i]
	local skinId = scene._tarotCardDatas[skinIdx].skinId
	local skinCfg = SkinConfig.instance:getSkinCo(skinId)

	if not skinCfg then
		return
	end

	local curProgress = scene._tarotCardAniProgress[i]
	local cardPosIdx = self:_checkCardPosIdx(curProgress)

	if cardPosIdx == centerCardIdx then
		self:_doPlaySpCardOpenAni(cardAnimator, skinId)
	end
end

function HandbookScene_Base:_doPlaySpCardOpenAni(cardAnimator, skinId)
	return
end

function HandbookScene_Base:onDragging(offsetX)
	local scene = self._scene

	if self:isModeEntering() or not self:isModeEntered() then
		return
	end

	scene._dragging = true

	if scene._moveToOtherSuitAni then
		return
	end

	if scene._dragResetPosTweens and #scene._dragResetPosTweens > 0 then
		for i = 1, #scene._dragResetPosTweens do
			ZProj.TweenHelper.KillById(scene._dragResetPosTweens[i])
		end

		scene._dragResetPosTweens = {}
	end

	local progressDiff = dragRate * offsetX

	progressDiff = Mathf.Clamp(progressDiff, -maxDragProgressPerFrame, maxDragProgressPerFrame)

	for i, cardAnimator in ipairs(scene._tarotCardAnimators) do
		local curProgress = scene._tarotCardAniProgress[i]
		local dragAnimationName = "slide"
		local newProgress = curProgress - progressDiff

		if newProgress >= scene._maxProgress then
			scene._tarotCardAniProgress[i] = scene._minProgress + newProgress - scene._maxProgress

			if self:isMaxProgressAtScreenLeft() then
				self:_wrapCardWindowForward(i)
			else
				self:_wrapCardWindowBackward(i)
			end
		elseif newProgress <= scene._minProgress then
			scene._tarotCardAniProgress[i] = scene._maxProgress + newProgress - scene._minProgress

			if self:isMaxProgressAtScreenLeft() then
				self:_wrapCardWindowBackward(i)
			else
				self:_wrapCardWindowForward(i)
			end
		else
			scene._tarotCardAniProgress[i] = newProgress
		end

		scene:UpdateAnimProgress(cardAnimator, dragAnimationName, scene._tarotCardAniProgress[i])
	end
end

function HandbookScene_Base:onClose()
	TaskDispatcher.cancelTask(self.onEnterAniDone, self)
	TaskDispatcher.cancelTask(self.onExitAniDone, self)
	TaskDispatcher.cancelTask(self.onDoCardPosToMiddleEnd, self)

	local scene = self._scene

	if scene._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(scene._tweenCardPosTweenId)

		scene._tweenCardPosTweenId = nil
	end
end

return HandbookScene_Base
