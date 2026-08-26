-- chunkname: @modules/logic/fight/view/FightViewHandCard.lua

module("modules.logic.fight.view.FightViewHandCard", package.seeall)

local FightViewHandCard = class("FightViewHandCard", FightBaseView)
local HandCardHeight = 256
local HandCardWidth = 185

FightViewHandCard.blockOperate = false

function FightViewHandCard:onInitView()
	self.skinDownEffectRoot = gohelper.findChild(self.viewGO, "root/hand_card_skin_down")
	self.skinDownEffectRoot_s = gohelper.findChild(self.viewGO, "root/hand_card_skin_s_down")
	self.skinUpEffectRoot = gohelper.findChild(self.viewGO, "root/hand_card_skin_up")
	self.skinUpEffectRoot_s = gohelper.findChild(self.viewGO, "root/hand_card_skin_s_up")
	self._handCardContainer = gohelper.findChild(self.viewGO, "root/handcards")
	self._handCardGO = gohelper.findChild(self.viewGO, "root/handcards/handcards")
	self._handCardTransform = self._handCardContainer.transform
	FightViewHandCard.handCardSiblingIndex = self._handCardTransform:GetSiblingIndex()
	self._playCardTransform = gohelper.findChild(self.viewGO, "root/playcards").transform
	FightViewHandCard.playCardSiblingIndex = self._playCardTransform:GetSiblingIndex()
	self._abandon = gohelper.findChild(self.viewGO, "root/abandon")
	self._abandonLine = gohelper.findChild(self.viewGO, "root/abandon/rightBottom/line").transform

	gohelper.setActive(self._abandon, false)

	self._abandonTran = self._abandon.transform
	self._abandonCardRoot = gohelper.findChild(self.viewGO, "root/abandon/cardRoot")
	self._abandonCardRootTran = self._abandonCardRoot.transform
	self._precisionFrame = gohelper.findChild(self.viewGO, "root/handcards/areaFrameRoot")

	gohelper.setActive(self._precisionFrame, false)

	self._handCardGOCanvasGroup = gohelper.onceAddComponent(self._handCardGO, typeof(UnityEngine.CanvasGroup))
	self._handCardTr = self._handCardGO.transform
	self._handCardItemPrefab = gohelper.findChild(self.viewGO, "root/handcards/handcards/cardItem")

	gohelper.setActive(self._handCardItemPrefab, false)

	self._handCardItemList = {}
	self._handCardItemPool = {}

	self:_setBlockOperate(false)

	self.areaSize = 0
	self.deviceBlackBg = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#go_devicediscard")

	self.deviceBlackBg:AddClickListener(self.onClickDeviceBg, self)

	self.LyNeedCheckFlowList = {}

	self:initRedOrBlueArea()
	self.addEventCb(self, FightController.instance, FightEvent.OnHandCardFlowCreate, self._onHandCardFlowCreate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnHandCardFlowStart, self._onHandCardFlowStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnHandCardFlowEnd, self._onHandCardFlowEnd, self)

	FightViewHandCard.handCardContainer = self._handCardContainer
	FightViewHandCard.HalfWidth = recthelper.getWidth(self._handCardTr) / 2
	FightViewHandCard.HalfItemWidth = recthelper.getWidth(self._handCardItemPrefab.transform) / 2
	FightViewHandCard.HandCardWidth = HandCardWidth
	FightViewHandCard.HandCardHeight = HandCardHeight
	self._correctHandCardScale = FightViewHandCardSequenceFlow.New("_correctHandCardScale")

	self._correctHandCardScale:addWork(FigthCardDistributeCorrectScale.New())

	self._cardDistributeFlow = FightViewHandCardParallelFlow.New()

	self._cardDistributeFlow:addWork(FigthCardDistributeCorrectScale.New())
	self._cardDistributeFlow:addWork(FigthCardDistributeEffect.New())
	self._cardDistributeFlow:addWork(FightCardCombineEndEffect.New())

	self._cardCombineFlow = FightViewHandCardSequenceFlow.New("_cardCombineFlow")

	self._cardCombineFlow:addWork(FightCardCombineEffect.New())

	self._cardLongPressFlow = FightViewHandCardSequenceFlow.New("_cardLongPressFlow")

	self._cardLongPressFlow:addWork(FightCardLongPressEffect.New())

	self._cardLongPressEndFlow = FightViewHandCardSequenceFlow.New("_cardLongPressEndFlow")

	self._cardLongPressEndFlow:addWork(FightCardLongPressEndEffect.New())

	self._cardDragFlow = FightViewHandCardSequenceFlow.New("_cardDragFlow")

	self._cardDragFlow:addWork(FightCardDragEffect.New())

	self._cardDragEndFlow = FightViewHandCardSequenceFlow.New("_cardDragEndFlow")

	self._cardDragEndFlow:addWork(FightCardDragEndEffect.New())

	self._redealCardFlow = FightViewHandCardSequenceFlow.New("_redealCardFlow")

	self._redealCardFlow:addWork(FightCardRedealEffect.New())

	self._universalAppearFlow = FightViewHandCardSequenceFlow.New("_universalAppearFlow")

	self._universalAppearFlow:addWork(FightCardUniversalAppearEffect.New())

	self._magicEffectCardFlow = FightViewHandCardSequenceFlow.New("_magicEffectCardFlow")

	self._magicEffectCardFlow:addWork(FightCardChangeMagicEffect.New())
end

function FightViewHandCard:onClickDeviceBg()
	local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

	if curOperateState == FightStageMgr.OperateStateType.DeviceDiscard then
		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.DeviceDiscard)
	end
end

function FightViewHandCard:initRedOrBlueArea()
	local skin = FightDataHelper.entityMgr:getHeroSkin(FightEnum.HeroId.LY)
	local co = skin and lua_fight_sp_handcard_area_ly.configDict[skin]

	co = co or lua_fight_sp_handcard_area_ly.configDict[0]

	local resPath = string.format("ui/viewres/fight/%s.prefab", co.path)

	self.lyAreaLoader = MultiAbLoader.New()

	self.lyAreaLoader:addPath(resPath)
	self.lyAreaLoader:startLoad(self.onLyLoaderDone, self)
end

function FightViewHandCard:onLyLoaderDone()
	local assistItem = self.lyAreaLoader:getFirstAssetItem()
	local prefab = assistItem:GetResource()
	local goParent = gohelper.findChild(self.viewGO, "root/handcards/")

	self.goLYAreaRoot = gohelper.clone(prefab, goParent)
	self.animatorLyRoot = self.goLYAreaRoot:GetComponent(gohelper.Type_Animator)
	self.goRedArea = gohelper.findChild(self.goLYAreaRoot, "redarea")
	self.goGreenArea = gohelper.findChild(self.goLYAreaRoot, "greenarea")
	self.rectTrRedArea = self.goRedArea:GetComponent(gohelper.Type_RectTransform)
	self.rectTrGreenArea = self.goGreenArea:GetComponent(gohelper.Type_RectTransform)

	self:refreshLYAreaActive()
end

function FightViewHandCard:onDestroyView()
	FightViewHandCard.handCardContainer = nil
	self.LyNeedCheckFlowList = nil

	if self.lyAreaLoader then
		self.lyAreaLoader:dispose()

		self.lyAreaLoader = nil
	end

	if self.lorentzLoader then
		self.lorentzLoader:dispose()

		self.lorentzLoader = nil
	end

	self.handCardMoving = false

	self:clearHandCardMoveDone()
end

function FightViewHandCard:addEvents()
	self:com_registMsg(FightMsgId.RegistPlayHandCardWork, self.onRegistPlayHandCardWork)
	self:com_registMsg(FightMsgId.RegistCardEndAniFlow, self.onRegistCardEndAniFlow)
end

function FightViewHandCard:onOpen()
	self:com_registMsg(FightMsgId.GetSkinDownEffectRoot, self.onGetSkinDownEffectRoot)
	self:_updateNow()
	self.addEventCb(self, FightController.instance, FightEvent.DistributeCards, self._startDistributeCards, self)
	self.addEventCb(self, FightController.instance, FightEvent.PushCardInfo, self._updateNow, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayHandCard, self._playHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCombineCards, self._onPlayCombineCards, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateHandCards, self._updateHandCards, self)
	self.addEventCb(self, FightController.instance, FightEvent.ResetCard, self._resetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.DragHandCardBegin, self._onDragHandCardBegin, self)
	self.addEventCb(self, FightController.instance, FightEvent.DragHandCardEnd, self._onDragHandCardEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.LongPressHandCard, self._longPressHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.LongPressHandCardEnd, self._longPressHandCardEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayRedealCardEffect, self._playRedealCardEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.UniversalAppear, self._playUniversalAppear, self)
	self.addEventCb(self, FightController.instance, FightEvent.CheckCardOpEnd, self._checkCardOpEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.DetectCardOpEndAfterOperationEffectDone, self._onDetectCardOpEndAfterOperationEffectDone, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.onApplicationPause, self._onApplicationPause, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetCardMagicEffectChange, self._setCardMagicEffectChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCardMagicEffectChange, self._playCardMagicEffectChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetBlockCardOperate, self._setBlockOperate, self)
	self.addEventCb(self, FightController.instance, FightEvent.SpCardAdd, self._onSpCardAdd, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddHandCard, self._onAddHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_AddHandCard, self._onDeviceAddHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnHeDuoNieAddCard, self._onAddHeDuoNieHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.TempCardRemove, self._onTempCardRemove, self)
	self.addEventCb(self, FightController.instance, FightEvent.ChangeToTempCard, self._onChangeToTempCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.CorrectHandCardScale, self._onCorrectHandCardScale, self)
	self.addEventCb(self, FightController.instance, FightEvent.RemoveEntityCards, self._onRemoveEntityCards, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardRemove, self._onCardRemove, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardRemove2, self._onCardRemove2, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_RemoveHandCard, self._onDeviceSkillRemoveHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnHeDuoNieRemoveCard, self._onHeDuoNieRemoveCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshHandCard, self._updateNow, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardsCompose, self._onCardsCompose, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardsComposeTimeOut, self._onCardsComposeTimeOut, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardLevelChange, self._onCardLevelChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterForceUpdatePerformanceData, self._onAfterForceUpdatePerformanceData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.MasterAddHandCard, self._onMasterAddHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.MasterCardRemove, self._onMasterCardRemove, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardAConvertCardB, self._onCardAConvertCardB, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._updateNow, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, self.OnKeyPlayCard, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, self.onControlRelease, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, self.selectLeftCard, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, self.selectRightCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self._onStageChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.EnterOperateState, self._onEnterOperateState, self)
	self.addEventCb(self, FightController.instance, FightEvent.ExitOperateState, self._onExitOperateState, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardEffectChange, self._onCardEffectChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshHandCardPrecisionEffect, self._onRefreshHandCardPrecisionEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.LY_CardAreaSizeChange, self.onLY_CardAreaSizeChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshCardHeatShow, self._onRefreshCardHeatShow, self)
	self.addEventCb(self, FightController.instance, FightEvent.ASFD_OnChangeCardEnergy, self.onChangeCardEnergy, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayCardFlowDone, self.refreshLYAreaActive, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforeSendOperate2ServerAnimDone, self.onBeforeSendOperate2ServerAnimDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnOperateMgrDisposeAllWork, self.removePreHandCardFlow, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshPreLv, self.refreshPreLv, self)
	self.addEventCb(self, FightController.instance, FightEvent.TriggerMoveHandCard, self.onTriggerMoveHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.TriggerInsertHandCard, self.onTriggerInsertHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateOneHandCard, self.updateOneCard, self)
	self:_setBlockOperate(false)
	self:_refreshPrecisionShow()
end

function FightViewHandCard:onClose()
	TaskDispatcher.cancelTask(self._delayCancelBlock, self)
	TaskDispatcher.cancelTask(self._combineCardsAfterAddHandCard, self)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.cancelTask(self._combineAfterCardLevelChange, self)
	TaskDispatcher.cancelTask(self._combineAfterCardRemove, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, self.OnKeyPlayCard, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, self.onControlRelease, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, self.selectLeftCard, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, self.selectRightCard, self)

	if self.deviceBlackBg then
		self.deviceBlackBg:RemoveClickListener()

		self.deviceBlackBg = nil
	end

	for i, v in ipairs(self._handCardItemList) do
		v:releaseSelf()
	end

	self._correctHandCardScale:stop()
	self._cardDistributeFlow:stop()
	self._cardCombineFlow:stop()
	self._cardLongPressFlow:stop()
	self._cardLongPressEndFlow:stop()
	self._cardDragFlow:stop()
	self._cardDragEndFlow:stop()
	self._redealCardFlow:stop()
	self._universalAppearFlow:stop()
	self._magicEffectCardFlow:stop()

	if self.moveHandCardFlow then
		self.moveHandCardFlow:unregisterDoneListener(self.onMoveHandCardFlowDone, self)
		self.moveHandCardFlow:stop()

		self.moveHandCardFlow = nil
	end

	if self.insertHandCardFlow then
		self.insertHandCardFlow:unregisterDoneListener(self.onInsertHandCardDone, self)
		self.insertHandCardFlow:stop()

		self.insertHandCardFlow = nil
	end
end

function FightViewHandCard:onTriggerInsertHandCard(insertIndex)
	local handCardList = FightDataHelper.handCardMgr.handCard
	local handCardItem = self:createHandCardItem()

	transformhelper.setLocalScale(handCardItem.tr, 1, 1, 1)
	handCardItem:updateItem(insertIndex, handCardList[insertIndex])
	gohelper.setAsLastSibling(handCardItem.go)

	if not self.insertHandCardFlow then
		self.insertHandCardFlow = FightViewHandCardSequenceFlow.New("insertHandCardFlow")

		self.insertHandCardFlow:registerDoneListener(self.onInsertHandCardDone, self)
		self.insertHandCardFlow:addWork(FightInsertHandCardWork.New())
	end

	self.insertHandCardFlow:stop()

	self.insertCardContext = self.moveHandCardContext or self:getUserDataTb_()
	self.insertCardContext.handCardItemList = self._handCardItemList
	self.insertCardContext.insertIndex = insertIndex
	self.insertCardContext.insertHandCardItem = handCardItem

	self.insertHandCardFlow:start(self.insertCardContext)
end

function FightViewHandCard:onInsertHandCardDone()
	self:_updateNow()
	FightController.instance:dispatchEvent(FightEvent.TriggerInsertHandCardDone)
end

function FightViewHandCard:onTriggerMoveHandCard(startIndex, endIndex)
	if not self.moveHandCardFlow then
		self.moveHandCardFlow = FightViewHandCardSequenceFlow.New("moveHandCardFlow")

		self.moveHandCardFlow:registerDoneListener(self.onMoveHandCardFlowDone, self)
		self.moveHandCardFlow:addWork(FightMoveCardWork.New())
	end

	self.moveHandCardFlow:stop()

	self.moveHandCardContext = self.moveHandCardContext or self:getUserDataTb_()
	self.moveHandCardContext.handCardItemList = self._handCardItemList
	self.moveHandCardContext.startIndex = startIndex
	self.moveHandCardContext.endIndex = endIndex

	self.moveHandCardFlow:start(self.moveHandCardContext)
end

function FightViewHandCard:onMoveHandCardFlowDone()
	self:_updateNow()
	FightController.instance:dispatchEvent(FightEvent.TriggerMoveHandCardDone)
end

function FightViewHandCard:refreshPreLv(existEffectTagCountDict)
	self.existEffectTagCountDict = existEffectTagCountDict

	self:_refreshPreLv(self.existEffectTagCountDict)
end

function FightViewHandCard:_refreshPreLv(existEffectTagCountDict)
	for _, cardItem in ipairs(self._handCardItemList) do
		self:updateOneCardItemCardPreLv(cardItem, existEffectTagCountDict)
	end
end

function FightViewHandCard:updateOneCardItemCardPreLv(cardItem, existEffectTagCountDict)
	if not existEffectTagCountDict then
		cardItem:setPreLv(0)

		return
	end

	local cardInfo = cardItem and cardItem.cardInfoMO

	if not cardInfo then
		cardItem:setPreLv(0)

		return
	end

	local belongUid = cardInfo.uid
	local entityMo = FightDataHelper.entityMgr:getById(belongUid)

	if not entityMo then
		cardItem:setPreLv(0)

		return
	end

	local skillId = cardInfo.skillId
	local curSkillCo = lua_skill.configDict[skillId]

	if not curSkillCo then
		cardItem:setPreLv(0)

		return
	end

	if FightCardDataHelper.isBigSkill(skillId) then
		cardItem:setPreLv(0)

		return
	end

	local cardIndex = entityMo:getSkillIdIndex(skillId)

	if not cardIndex then
		cardItem:setPreLv(0)

		return
	end

	local canUpEffectTagList = entityMo:getCanUpEffectTagList(cardIndex)

	if not canUpEffectTagList then
		cardItem:setPreLv(0)

		return
	end

	local count = 0

	for _, effectTag in ipairs(canUpEffectTagList) do
		local existCount = existEffectTagCountDict[effectTag]

		if existCount then
			count = count + existCount
		end
	end

	cardItem:setPreLv(count)
end

function FightViewHandCard:onBeforeSendOperate2ServerAnimDone()
	if self.preOperateEndFlow then
		self:removeHandCardFlow(self.preOperateEndFlow)

		self.preOperateEndFlow = nil
	end
end

function FightViewHandCard:_onHandCardFlowCreate(flow)
	table.insert(self.LyNeedCheckFlowList, flow)
end

function FightViewHandCard:removeHandCardFlow(flow)
	tabletool.removeValue(self.LyNeedCheckFlowList, flow)
	self:refreshLYAreaActive()
end

function FightViewHandCard:_onHandCardFlowEnd(flow)
	if flow == self._cardLongPressEndFlow or flow == self._cardDragEndFlow then
		self.longPressing = false
	end

	return self:refreshLYAreaActive()
end

function FightViewHandCard:_onHandCardFlowStart(flow)
	if flow == self._cardLongPressFlow then
		self.longPressing = true
	end

	return self:refreshLYAreaActive()
end

function FightViewHandCard:_onStageChanged(curStage)
	if curStage == FightStageMgr.StageType.Operate then
		for _, handCardItem in ipairs(self._handCardItemList) do
			handCardItem:setASFDActive(true)
		end

		self:_refreshPrecisionShow()
	elseif curStage == FightStageMgr.StageType.Play then
		gohelper.setActive(self._precisionFrame, false)
		self:_setBlockOperate(false)
	end

	self:refreshPreLv()

	return self:refreshLYAreaActive()
end

function FightViewHandCard:refreshLYAreaActive()
	if FightViewHandCard.blockOperate then
		return self:setActiveLyRoot(false)
	end

	if self.longPressing then
		return self:setActiveLyRoot(false)
	end

	local curStage = FightDataHelper.stageMgr:getCurStage()
	local isNormal = curStage == FightStageMgr.StageType.Operate

	if not isNormal then
		return self:setActiveLyRoot(false)
	end

	if self.LyNeedCheckFlowList then
		for _, flow in ipairs(self.LyNeedCheckFlowList) do
			if flow.status == WorkStatus.Running then
				return self:setActiveLyRoot(false)
			end
		end
	end

	self:refreshLyAreaPos()
	self:setActiveLyRoot(true)
end

function FightViewHandCard:setActiveLyRoot(active)
	if gohelper.isNil(self.goLYAreaRoot) then
		return
	end

	local areaSize = FightDataHelper.LYDataMgr.LYCardAreaSize

	if areaSize < 1 then
		gohelper.setActive(self.goLYAreaRoot, false)

		return
	end

	gohelper.setActive(self.goLYAreaRoot, true)

	if active then
		if not self.goLYAreaRoot.activeInHierarchy then
			gohelper.setActive(self.goLYAreaRoot, true)
			self.animatorLyRoot:Play("open", 0, 0)
		end
	else
		gohelper.setActive(self.goLYAreaRoot, false)
	end
end

function FightViewHandCard:onLY_CardAreaSizeChange()
	self:refreshLyCardTag()
	self:refreshLYAreaActive()
end

function FightViewHandCard:refreshLyCardTag()
	local cards = FightDataHelper.handCardMgr.handCard
	local areaSize = FightDataHelper.LYDataMgr.LYCardAreaSize

	if cards then
		if not #cards then
			local len = 0

			for i = 1, len do
				local handCardItem = self._handCardItemList[i]

				if handCardItem then
					handCardItem:resetRedAndBlue()

					if areaSize > len - i and i <= areaSize then
						handCardItem:setActiveBoth(true)
					else
						handCardItem:setActiveBlue(areaSize > len - i)
						handCardItem:setActiveRed(i <= areaSize)
					end
				end
			end
		end
	end
end

function FightViewHandCard:refreshLyAreaPos()
	local areaSize = FightDataHelper.LYDataMgr.LYCardAreaSize
	local curHandCardList = FightDataHelper.handCardMgr.handCard

	if curHandCardList then
		if not #curHandCardList then
			local handCardLen = 0

			areaSize = math.min(areaSize, handCardLen)

			local cards = FightDataHelper.handCardMgr.handCard

			if cards then
				if not #cards then
					local len = 0
					local show = areaSize and areaSize > 0 and len > 0

					gohelper.setActive(self.goRedArea, show)
					gohelper.setActive(self.goGreenArea, show)

					if show then
						local width = FightViewHandCard.calcTotalWidth(areaSize, 1) + FightEnum.LYCardAreaWidthOffset

						recthelper.setWidth(self.rectTrRedArea, width)
						recthelper.setWidth(self.rectTrGreenArea, width)

						local anchorX = FightViewHandCard.calcTotalWidth(len - areaSize, 1)

						recthelper.setAnchorX(self.rectTrGreenArea, -anchorX)
					end
				end
			end
		end
	end
end

function FightViewHandCard:_onApplicationPause(isFront)
	if isFront and FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		if self._cardDragFlow and self._cardDragFlow.status == WorkStatus.Running then
			self._cardDragFlow:stop()
		end

		self:_updateNow()
	end
end

function FightViewHandCard:getHandCardItem(index)
	return self._handCardItemList[index]
end

function FightViewHandCard:isMoveCardFlow()
	return self._cardDragFlow.status == WorkStatus.Running or self._cardDragEndFlow.status == WorkStatus.Running
end

function FightViewHandCard:isCombineCardFlow()
	return self._cardCombineFlow.status == WorkStatus.Running
end

function FightViewHandCard:onRegistCardEndAniFlow()
	local flow = self:buildOperateEndFlow()

	FightMsgMgr.replyMsg(FightMsgId.RegistCardEndAniFlow, flow)
end

function FightViewHandCard:buildOperateEndFlow()
	if self.preOperateEndFlow then
		self:removeHandCardFlow(self.preOperateEndFlow)

		self.preOperateEndFlow = nil
	end

	local flow = self:com_registFlowSequence()
	local oldFlow = FightViewHandCardSequenceFlow.New("OperateEnd")

	oldFlow:addWork(FightGuideCardEnd.New())
	oldFlow:addWork(FightCardEndEffect.New())

	self.preOperateEndFlow = oldFlow

	flow:addWork(oldFlow)

	local context = self:getUserDataTb_()

	context.handCardContainer = self._handCardGO
	context.playCardContainer = gohelper.findChild(self.viewGO, "root/playcards")
	context.waitCardContainer = gohelper.findChild(self.viewGO, "root/waitingArea/inner")
	context.deviceContainer = self.viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.DeviceAreaGo)
	context.rectDeviceCard = self.viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.RectDeviceCard)
	context.goCalculatePosObj = self.viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.GoCalculatePosObj)
	context.handCardItemList = self._handCardItemList
	flow.context = context

	return flow
end

function FightViewHandCard:_checkCardOpEnd()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		return
	end

	if FightDataHelper.stateMgr.forceUseCard then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() and #FightDataHelper.operationDataMgr:getOpList() > 0 then
		FightController.instance:dispatchEvent(FightEvent.CardOpEnd)

		if FightModel.instance:isSeason2() then
			FightWorkSendOperate2Server:onFinish()
			FightViewPartVisible.set(nil, nil, nil, nil, true)
			FightController.instance:dispatchEvent(FightEvent.HidePlayCardAllCard)

			return
		end

		self:_setBlockOperate(true)
		gohelper.setActive(self._precisionFrame, false)
		FightGameMgr.operateMgr:sendOperate2Server()
	end
end

function FightViewHandCard:_onDetectCardOpEndAfterOperationEffectDone(round_op)
	if round_op and FightModel.instance:isSeason2() and round_op:isMoveUniversal() then
		FightWorkSendOperate2Server:onFinish()

		return
	end

	self:_checkCardOpEnd()
end

function FightViewHandCard:_onCardEffectChange(index)
	if index == 1 then
		self:_refreshPrecisionShow()
	end
end

function FightViewHandCard:refreshPreDeleteCard(handCards)
	self.needPreDeleteCardIndexDict = self.needPreDeleteCardIndexDict or {}

	tabletool.clear(self.needPreDeleteCardIndexDict)

	if handCards then
		for index, cardInfoMo in ipairs(handCards) do
			local skillId = cardInfoMo.skillId
			local preDeleteCo = skillId and lua_fight_card_pre_delete.configDict[skillId]

			if preDeleteCo then
				local left = preDeleteCo.left

				if left > 0 then
					for i = 1, left do
						self.needPreDeleteCardIndexDict[index + i] = true
					end
				end

				local right = preDeleteCo.right

				if right > 0 then
					for i = 1, right do
						self.needPreDeleteCardIndexDict[index - i] = true
					end
				end
			end
		end
	end

	for index, handCardItem in ipairs(self._handCardItemList) do
		handCardItem:refreshPreDeleteImage(self.needPreDeleteCardIndexDict and self.needPreDeleteCardIndexDict[index])
	end
end

function FightViewHandCard:_refreshPrecisionShow()
	self._precisionState = false

	gohelper.setActive(self._precisionFrame, false)

	if FightDataHelper.stageMgr:isOperateStage() then
		local entityList = {}

		FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, entityList)
		FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, entityList)

		for i, entityMO in ipairs(entityList) do
			if entityMO:hasBuffFeature(FightEnum.BuffFeature.PrecisionRegion) then
				gohelper.setActive(self._precisionFrame, true)

				self._precisionState = true

				self:_detectPlayPrecisionEffect()

				break
			end
		end
	end
end

function FightViewHandCard:_detectPlayPrecisionEffect()
	if self._handCardItemList then
		for i, v in ipairs(self._handCardItemList) do
			local cardItem = v:getCardItem()

			if i == 1 then
				if FightCardDataHelper.isPrecision(cardItem._cardInfoMO) and self._precisionState then
					cardItem:showPrecisionEffect()
				else
					cardItem:hidePrecisionEffect()
				end
			else
				cardItem:hidePrecisionEffect()
			end
		end
	end
end

function FightViewHandCard:_onRefreshHandCardPrecisionEffect()
	self:_detectPlayPrecisionEffect()
end

function FightViewHandCard:_startDistributeCards(beforeCards, distributeCards, isEnterDistribute)
	self.distributeCards = FightDataUtil.copyData(distributeCards) or {}

	FightDataUtil.coverData(beforeCards, FightDataHelper.handCardMgr.handCard)
	self:_updateHandCards()

	local cardSkin = FightCardDataHelper.getCardSkin()

	if isEnterDistribute then
		if cardSkin == 672801 then
			local work = self.com_registWork(self, FightWorkEnterDistributeCards672801, self, self.distributeCards)

			work:registFinishCallback(self.onEnterDistributeCardsSkinDone, self)
			work:start()
		elseif cardSkin == 672802 then
			local work = self.com_registWork(self, FightWorkEnterDistributeCards672802, self, self.distributeCards)

			work:registFinishCallback(self.onEnterDistributeCardsSkinDone, self)
			work:start()
		elseif cardSkin == 672803 then
			local work = self.com_registWork(self, FightWorkEnterDistributeCards672803, self, self.distributeCards)

			work:registFinishCallback(self.onEnterDistributeCardsSkinDone, self)
			work:start()
		else
			self:_nextDistributeCards()
		end
	else
		self:_nextDistributeCards()
	end
end

function FightViewHandCard:onEnterDistributeCardsSkinDone()
	FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
end

function FightViewHandCard:_nextDistributeCards(preCombineIndex)
	self._correctHandCardScale:stop()
	self._cardDistributeFlow:stop()
	self._cardCombineFlow:stop()
	self._redealCardFlow:stop()
	self._magicEffectCardFlow:stop()

	if self.distributeCards then
		local queueLen = #self.distributeCards

		if queueLen > 0 then
			local handCard = FightDataHelper.handCardMgr.handCard
			local beforeCount = #handCard
			local newArr = {}

			for i = 1, queueLen do
				local distributeCard = table.remove(self.distributeCards, 1)

				table.insert(newArr, distributeCard)
				table.insert(handCard, distributeCard)

				local preCard = handCard[#handCard - 1]

				if FightCardDataHelper.canCombineCardForPerformance(distributeCard, preCard) then
					break
				end
			end

			local oldPosXList = FightCardCombineEffect.getCardPosXList(self._handCardItemList)

			self:_updateHandCards(handCard)

			local context = self:getUserDataTb_()

			context.cards = handCard
			context.handCardItemList = self._handCardItemList
			context.oldPosXList = oldPosXList
			context.preCombineIndex = preCombineIndex
			context.preCardCount = beforeCount
			context.newCardCount = #newArr
			context.playCardContainer = gohelper.findChild(self.viewGO, "root/playcards")
			context.isEnd = queueLen == 1
			context.handCardContainer = self._handCardContainer
			context.oldScale = 0

			self:_setBlockOperate(true)
			self._cardDistributeFlow:registerDoneListener(self._onDistributeCards, self)
			self._cardDistributeFlow:start(context)
		else
			self:_onDistributeCards()
		end
	end
end

function FightViewHandCard:_onDistributeCards()
	self._cardDistributeFlow:unregisterDoneListener(self._onDistributeCards, self)

	if self._cardDistributeFlow.context then
		if not self._cardDistributeFlow.context.cards then
			local cards = FightDataHelper.handCardMgr.handCard

			self:_combineCards(cards)
		end
	end
end

function FightViewHandCard:_playHandCard(from, targetEntityId, param2, param3, cardParam1)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	local cards = FightDataHelper.handCardMgr.handCard
	local cardInfoMO = cards[from]

	if not cardInfoMO then
		self:_updateNow()

		return
	end

	FightGameMgr.operateMgr:playHandCard(from, targetEntityId, param2, param3, cardParam1)
end

function FightViewHandCard:removePreHandCardFlow()
	if self.preHandCardFlow then
		self:removeHandCardFlow(self.preHandCardFlow)

		self.preHandCardFlow = nil
	end
end

function FightViewHandCard:buildPlayHandCardFlow(from, targetEntityId, param2, param3, cardParam1)
	local cards = FightDataHelper.handCardMgr.handCard
	local cardInfoMO = cards[from]

	if not cardInfoMO then
		return
	end

	local cardItem = self._handCardItemList[from]

	if not cardItem then
		return
	end

	if not cardItem.go.activeInHierarchy then
		return
	end

	self:removePreHandCardFlow()

	local flow = self:com_registFlowSequence()
	local oldFlow = FightViewHandCardSequenceFlow.New("PlayHandCardFlow")

	self.preHandCardFlow = oldFlow

	oldFlow:addWork(FightCardRouge2PushMusicWork.New())
	oldFlow:addWork(FightCardRecordSkillBeforePlay.New())
	oldFlow:addWork(FightCardPlayEffect.New())
	oldFlow:addWork(FightCardDissolveCardsAfterPlay.New())
	oldFlow:addWork(FightCardRecordSkillAfterPlay.New())
	oldFlow:addWork(FightCardDiscardAfterPlay.New())
	oldFlow:addWork(FightCardCheckCombineCards.New())
	oldFlow:addWork(FightCardRouge2PopMusicWork.New())
	flow:addWork(oldFlow)
	flow:registWork(FightWorkFunction, self._onPlayCardDone, self)
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
	self:_setBlockOperate(true)

	if param3 and param3 ~= 0 then
		cardInfoMO.skillId = param3
	end

	cardInfoMO.playCanAddExpoint = FightCardDataHelper.playCanAddExpoint(cards, cardInfoMO)

	local fightBeginRoundOp = FightDataHelper.operationDataMgr:newOperation()

	fightBeginRoundOp:playCard(from, targetEntityId, cardInfoMO, param2, param3, cardParam1)

	fightBeginRoundOp.cardColor = FightDataHelper.LYDataMgr:getCardColor(cards, from)
	fightBeginRoundOp.cardInfoMO.areaRedOrBlue = fightBeginRoundOp.cardColor

	if cardInfoMO.heatId ~= 0 then
		local teamDataMgr = FightDataHelper.teamDataMgr
		local heatId = cardInfoMO.heatId
		local myData = teamDataMgr.myData
		local heatData = myData.cardHeat.values[heatId]

		if not teamDataMgr.myCardHeatOffset[heatId] then
			teamDataMgr.myCardHeatOffset[heatId] = teamDataMgr.myCardHeatOffset[heatId] + heatData.changeValue

			FightController.instance:dispatchEvent(FightEvent.RefreshCardHeatShow, heatId)
		end
	end

	FightDataHelper.tempMgr:onPlayHandCard(fightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, fightBeginRoundOp)
	table.remove(cards, from)

	local beforeDissolveCards = FightDataUtil.copyData(cards)
	local dissolveCardIndexsAfterPlay

	if not FightCardDataHelper.isSkill3(cardInfoMO) and FightCardDataHelper.isBigSkill(cardInfoMO.skillId) then
		while true do
			if #cards > 0 then
				local isDone = false

				for i = 1, #cards do
					local tempCardInfo = cards[i]

					if tempCardInfo.uid == cardInfoMO.uid and FightCardDataHelper.isBigSkill(tempCardInfo.skillId) and not FightCardDataHelper.isSkill3(tempCardInfo) then
						dissolveCardIndexsAfterPlay = dissolveCardIndexsAfterPlay or {}

						table.insert(dissolveCardIndexsAfterPlay, i)

						local op = FightDataHelper.operationDataMgr:newOperation()

						op:simulateDissolveCard(i)
						table.remove(cards, i)

						break
					end

					if i == #cards then
						isDone = true
					end
				end

				if isDone then
					break
				end
			else
				break
			end
		end
	end

	local needDiscard = not not FightCardDataHelper.isDiscard(cardInfoMO)

	self._cardsForCombines = cards

	local context = self:getUserDataTb_()

	context.view = self
	context.cards = cards
	context.from = from
	context.viewGO = self.viewGO
	context.handCardTr = self._handCardTr
	context.handCardItemList = self._handCardItemList
	context.fightBeginRoundOp = fightBeginRoundOp
	context.beforeDissolveCards = beforeDissolveCards
	context.dissolveCardIndexsAfterPlay = dissolveCardIndexsAfterPlay
	context.needDiscard = needDiscard
	context.param2 = param2
	flow.context = context
	self.playCardFightBeginRoundOp = fightBeginRoundOp

	self:_playCardAudio(cardInfoMO)

	return flow
end

function FightViewHandCard:onRegistPlayHandCardWork(from, targetEntityId, param2, param3, cardParam1)
	local flow = self:buildPlayHandCardFlow(from, targetEntityId, param2, param3, cardParam1)

	if flow then
		FightMsgMgr.replyMsg(FightMsgId.RegistPlayHandCardWork, flow)
	end
end

function FightViewHandCard:_onPlayCardDone()
	self:_updateHandCards(FightDataHelper.handCardMgr.handCard)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, self.playCardFightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.PlayCardOver)
	self:_detectPlayPrecisionEffect()
	self:removePreHandCardFlow()

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		self:_setBlockOperate(true)

		return
	end
end

function FightViewHandCard:_playCardAudio(cardInfoMO)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local entity = FightHelper.getEntity(cardInfoMO.uid)
	local entityMO = entity and entity:getMO()

	if not entityMO then
		return
	end

	if FightEntityDataHelper.isPlayerUid(entityMO.id) then
		return
	end

	local cardOpList = FightDataHelper.operationDataMgr:getOpList()
	local buffList = FightBuffHelper.simulateBuffList(entityMO, cardOpList[#cardOpList])

	if not FightViewHandCardItemLock.canUseCardSkill(cardInfoMO.uid, cardInfoMO.skillId, buffList) then
		return
	end

	local audioId
	local heroId = entityMO.modelId

	if FightHelper.checkIsDevicePowerCard(cardInfoMO.skillId) then
		local randomValue = math.random(2)

		audioId = randomValue == 1 and FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar12, cardInfoMO.uid) or FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar3, cardInfoMO.uid)

		if audioId then
			FightAudioMgr.instance:playCardAudio(cardInfoMO.uid, audioId, heroId)
		end

		return
	end

	local skillCardLv = FightCardDataHelper.getSkillLv(cardInfoMO.uid, cardInfoMO.skillId)
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	if cardInfoMO.cardType == FightEnum.CardType.SKILL3 then
		audioId = self:getSkill3AudioId(entityMO, cardInfoMO)
	elseif skillCardLv == 1 or skillCardLv == 2 then
		audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar12, cardInfoMO.uid)
	elseif skillCardLv == 3 then
		audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar3, cardInfoMO.uid) or heroConfig and heroConfig.rare >= 4 and FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar3, cardInfoMO.uid) or FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar12, cardInfoMO.uid)
	elseif skillCardLv == FightEnum.UniqueSkillCardLv then
		audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardUnique, cardInfoMO.uid)
	end

	if audioId then
		FightAudioMgr.instance:playCardAudio(cardInfoMO.uid, audioId, heroId)
	end
end

function FightViewHandCard:getSkill3AudioId(entityMO, cardInfoMO)
	local timeline = FightConfig.instance:getSkinSkillTimeline(entityMO.skin, cardInfoMO.skillId)
	local voiceCoList = FightAudioMgr.instance:_getHeroVoiceCOs(entityMO.modelId, CharacterEnum.VoiceType.FightCardSkill3, entityMO.skin)

	if not voiceCoList then
		return
	end

	for i = #voiceCoList, 1, -1 do
		local voiceCo = voiceCoList[i]
		local timelineList = string.split(voiceCo.param, "#")
		local ok = timelineList and tabletool.indexOf(timelineList, timeline)

		if not ok then
			table.remove(voiceCoList, i)
		end
	end

	local len = #voiceCoList

	if len < 1 then
		return
	end

	if len == 1 then
		return voiceCoList[1].audio
	end

	local index = math.random(len)

	return voiceCoList[index].audio
end

function FightViewHandCard:_playRedealCardEffect(oldCards, newCards)
	local context = self:getUserDataTb_()

	context.oldCards = oldCards
	context.newCards = newCards
	context.handCardItemList = self._handCardItemList

	self:beforeRedealCardFlow()
	self._redealCardFlow:registerDoneListener(self._onRedealCardDone, self)
	self._redealCardFlow:start(context)
end

function FightViewHandCard:beforeRedealCardFlow()
	for _, handCardItem in ipairs(self._handCardItemList) do
		handCardItem:playASFDAnim("close")
	end
end

function FightViewHandCard:afterRedealCardFlow()
	for _, handCardItem in ipairs(self._handCardItemList) do
		handCardItem:playASFDAnim("open")
	end
end

function FightViewHandCard:_onRedealCardDone()
	self._redealCardFlow:unregisterDoneListener(self._onRedealCardDone, self)
	self:afterRedealCardFlow()
	self:_updateNow()
end

function FightViewHandCard:_setCardMagicEffectChange(card_index, old_effect, new_efffect)
	self._card_magic_effect_change_info = self._card_magic_effect_change_info or {}
	self._card_magic_effect_change_info[card_index] = {
		old_effect = old_effect,
		new_effect = new_efffect
	}
end

function FightViewHandCard:_playCardMagicEffectChange()
	local context = self:getUserDataTb_()

	context.changeInfos = self._card_magic_effect_change_info
	context.handCardItemList = self._handCardItemList
	self._card_magic_effect_change_info = nil

	self:_setBlockOperate(true)
	self._magicEffectCardFlow:registerDoneListener(self._onMagicEffectCardFlowDone, self)
	self._magicEffectCardFlow:start(context)
end

function FightViewHandCard:_onMagicEffectCardFlowDone()
	self._magicEffectCardFlow:unregisterDoneListener(self._onMagicEffectCardFlowDone, self)

	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_playUniversalAppear()
	self:_setBlockOperate(true)
	self:_updateNow()

	local context = self:getUserDataTb_()

	context.handCardItemList = self._handCardItemList

	self._universalAppearFlow:start(context)
	self._universalAppearFlow:registerDoneListener(self._onUniversalAppearDone, self)
end

function FightViewHandCard:_onSpCardAdd(index)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard

	self:_updateHandCards(cards, index)

	local tarCard = self._handCardItemList[index]

	gohelper.setActive(tarCard.go, false)
	tarCard:playCardAni(ViewAnim.FightCardBalance)
end

function FightViewHandCard:_onCorrectHandCardScale(oldScale)
	self:_playCorrectHandCardScale(oldScale)
end

function FightViewHandCard:_playCorrectHandCardScale(oldScale, newScale)
	self._correctHandCardScale:stop()

	local context = self:getUserDataTb_()

	context.cards = tabletool.copy(FightDataHelper.handCardMgr.handCard)
	context.oldScale = oldScale
	context.newScale = newScale
	context.handCardContainer = self._handCardContainer

	self._correctHandCardScale:start(context)
end

function FightViewHandCard:_onCardsCompose()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onCardsComposeTimeOut()
	if self._cardCombineFlow then
		self._cardCombineFlow:stop()
	end

	self:_updateNow()
end

function FightViewHandCard:_onRemoveEntityCards(entityId)
	for i = #self._handCardItemList, 1, -1 do
		local cardItem = self._handCardItemList[i]

		if cardItem.go.activeInHierarchy and cardItem:dissolveEntityCard(entityId, self.onDissolveCardDone, self) then
			table.remove(self._handCardItemList, i)
		end
	end

	FightViewHandCard.refreshCardIndex(self._handCardItemList)

	local delay = 1 / FightModel.instance:getUISpeed()

	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.runDelay(self._correctActiveCardObjPos, self, delay)
end

function FightViewHandCard:onDissolveCardDone(cardItem)
	self:recycleHandCardItem(cardItem)
end

function FightViewHandCard.refreshCardIndex(handCardItemList)
	for i, cardItem in ipairs(handCardItemList) do
		cardItem.index = i
	end
end

function FightViewHandCard:_onCardLevelChange(index, oldSkillId, canCombine)
	local cardItem = self._handCardItemList[index]

	if cardItem then
		cardItem:playCardLevelChange(oldSkillId)
	end

	if canCombine then
		TaskDispatcher.cancelTask(self._combineAfterCardLevelChange, self)
		TaskDispatcher.runDelay(self._combineAfterCardLevelChange, self, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_combineAfterCardLevelChange()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onPlayCombineCards(cards)
	self:_combineCards(cards)
end

function FightViewHandCard:_onDeviceSkillRemoveHandCard(indexes)
	for i, index in ipairs(indexes) do
		local cardItem = table.remove(self._handCardItemList, index)

		if cardItem and cardItem.go.activeInHierarchy then
			cardItem:playDeviceRemoveEffect(self.onDeviceRemoveCardDone, self)
		end
	end
end

function FightViewHandCard:onDeviceRemoveCardDone(handCardItem)
	self:recycleHandCardItem(handCardItem)
	FightViewHandCard.refreshCardIndex(self._handCardItemList)
	self._correctActiveCardObjPos(self, self.onDeviceRemoveCardCorrectPosDone, self)
end

function FightViewHandCard:onDeviceRemoveCardCorrectPosDone()
	FightController.instance:dispatchEvent(FightEvent.OnDevice_RemoveHandCardDone)
end

function FightViewHandCard:_onCardRemove(indexs, delayTime, canCombine)
	self:_onCardRemove2(indexs)

	if canCombine then
		TaskDispatcher.cancelTask(self._combineAfterCardRemove, self)
		TaskDispatcher.runDelay(self._combineAfterCardRemove, self, delayTime / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_combineAfterCardRemove()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onCardRemove2(indexs)
	for i, index in ipairs(indexs) do
		local cardItem = table.remove(self._handCardItemList, index)

		if cardItem and cardItem.go.activeInHierarchy then
			cardItem:dissolveCard(self.onDissolveCardDone, self)
		end
	end

	FightViewHandCard.refreshCardIndex(self._handCardItemList)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.runDelay(self._correctActiveCardObjPos, self, 1 / FightModel.instance:getUISpeed())
end

function FightViewHandCard:_onHeDuoNieRemoveCard(indexs)
	self.heDuoNieDisappearCount = 0

	for _, index in ipairs(indexs) do
		local cardItem = table.remove(self._handCardItemList, index)

		if cardItem and cardItem.go.activeInHierarchy then
			self.heDuoNieDisappearCount = self.heDuoNieDisappearCount + 1

			cardItem:heDuoNieDisappearCard(self._onHeDuoNieRemoveCardDone, self)
		end
	end

	if self.heDuoNieDisappearCount < 1 then
		FightViewHandCard.refreshCardIndex(self._handCardItemList)
		self._correctActiveCardObjPos(self, self._onHeDuoNieRemoveCardCorrectPosDone, self)
	end
end

function FightViewHandCard:_onHeDuoNieRemoveCardDone(handCardItem)
	self:recycleHandCardItem(handCardItem)

	self.heDuoNieDisappearCount = self.heDuoNieDisappearCount - 1

	if self.heDuoNieDisappearCount < 1 then
		FightViewHandCard.refreshCardIndex(self._handCardItemList)
		self._correctActiveCardObjPos(self, self._onHeDuoNieRemoveCardCorrectPosDone, self)
	end
end

function FightViewHandCard:_onHeDuoNieRemoveCardCorrectPosDone()
	FightController.instance:dispatchEvent(FightEvent.OnHeDuoNieRemoveCardDone)
end

function FightViewHandCard:_correctActiveCardObjPos(callback, callbackObj)
	if self.handCardMoving then
		logError("hand card moving")

		return
	end

	self.handCardMoving = true
	self.handCardMoveDoneCallback = callback
	self.handCardMoveDoneCallbackObj = callbackObj
	self.handCardMovingCount = 0

	local delayIndex = 0

	for i = 1, #self._handCardItemList do
		local cardItem = self._handCardItemList[i]

		cardItem.index = i
		cardItem.go.name = "cardItem" .. i

		local go = cardItem.go

		if not go.activeInHierarchy then
			break
		end

		local curPosX = recthelper.getAnchorX(go.transform)
		local endX = FightViewHandCard.calcCardPosX(i)

		if math.abs(curPosX - endX) >= 10 then
			if self.handCardMoveDoneCallback then
				self.handCardMovingCount = self.handCardMovingCount + 1

				cardItem:moveSelfPos(i, delayIndex, self.onPreHandCardMoveDone, self)
			else
				cardItem:moveSelfPos(i, delayIndex)
			end

			delayIndex = delayIndex + 1
		end
	end

	if self.handCardMovingCount < 1 then
		self:onPreHandCardMoveDone()
	end
end

function FightViewHandCard:onPreHandCardMoveDone()
	self.handCardMovingCount = self.handCardMovingCount - 1

	if self.handCardMovingCount <= 0 then
		self.handCardMoving = false

		if self.handCardMoveDoneCallback then
			-- block empty
		end
	end
end

function FightViewHandCard:clearHandCardMoveDone()
	self.handCardMoveDoneCallback = nil
	self.handCardMoveDoneCallbackObj = nil
	self.handCardMovingCount = 0
end

function FightViewHandCard:_onAddHeDuoNieHandCard()
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard
	local cardCount = #cards

	self:_updateHandCards(cards, cardCount)

	local tarCard = self._handCardItemList[cardCount]

	if tarCard then
		tarCard:playHeDuoNieAddCard(self._onAddHeDuoNieHandCardDone, self)
	else
		self:_onAddHeDuoNieHandCardDone()
	end
end

function FightViewHandCard:_onAddHeDuoNieHandCardDone()
	FightController.instance:dispatchEvent(FightEvent.OnHeDuoNieAddCardDone)
end

function FightViewHandCard:_onDeviceAddHandCard()
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard
	local cardCount = #cards

	self:_updateHandCards(cards, cardCount)

	local tarCard = self._handCardItemList[cardCount]

	if tarCard then
		tarCard:playDeviceAddCard(self._onDeviceAddHandCardDone, self)
	else
		self:_onDeviceAddHandCardDone()
	end
end

function FightViewHandCard:_onDeviceAddHandCardDone(handCardItem)
	if handCardItem then
		handCardItem:setDeviceEffectGoActive(false)
	end

	FightController.instance:dispatchEvent(FightEvent.OnDevice_AddHandCardDone)
end

function FightViewHandCard:_onAddHandCard(cardInfoMO, canCombine)
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard
	local cardCount = #cards

	self:_updateHandCards(cards, cardCount)

	local tarCard = self._handCardItemList[cardCount]

	tarCard:playDistribute()

	if canCombine then
		TaskDispatcher.runDelay(self._combineCardsAfterAddHandCard, self, 0.5 / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_onMasterAddHandCard(cardInfoMO, canCombine)
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard
	local cardCount = #cards

	self:_updateHandCards(cards, cardCount)

	local tarCard = self._handCardItemList[cardCount]

	tarCard:playMasterAddHandCard()

	if canCombine then
		TaskDispatcher.runDelay(self._combineCardsAfterAddHandCard, self, 1 / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_onMasterCardRemove(indexs, delayTime, canCombine)
	for i, index in ipairs(indexs) do
		local cardItem = table.remove(self._handCardItemList, index)

		if cardItem and cardItem.go.activeInHierarchy then
			cardItem:playMasterCardRemove(self.onMasterCardRemoveDone, self)
		end
	end

	FightViewHandCard.refreshCardIndex(self._handCardItemList)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.runDelay(self._correctActiveCardObjPos, self, 0.7 / FightModel.instance:getUISpeed())

	if canCombine then
		TaskDispatcher.cancelTask(self._combineAfterCardRemove, self)
		TaskDispatcher.runDelay(self._combineAfterCardRemove, self, delayTime / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:onMasterCardRemoveDone(handCardItem)
	self:recycleHandCardItem(handCardItem)
end

function FightViewHandCard:_combineCardsAfterAddHandCard()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onCardAConvertCardB(index, actEffectData)
	local cards = FightDataHelper.handCardMgr.handCard
	local cardItem = self._handCardItemList[index]

	if cardItem then
		cardItem:playCardAConvertCardB(actEffectData)
		cardItem:updateItem(index, cards[index])
	else
		self:_updateNow()
	end
end

function FightViewHandCard:_onTempCardRemove()
	self:_updateNow()

	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onChangeToTempCard(index)
	local tarCard = self._handCardItemList[index]

	if tarCard then
		tarCard:changeToTempCard()
	end
end

function FightViewHandCard:_onUniversalAppearDone()
	self._universalAppearFlow:unregisterDoneListener(self._onUniversalAppearDone, self)
	self:_setBlockOperate(false)
	FightController.instance:dispatchEvent(FightEvent.OnUniversalAppear)
end

function FightViewHandCard:_combineCards(cards, universalCombineIndex, fightBeginRoundOp)
	self._combineIndex = universalCombineIndex or FightCardDataHelper.canCombineCardListForPerformance(cards)
	self._isUniversalCombine = not not universalCombineIndex

	if self._combineIndex then
		self._cardsForCombines = cards

		local context = self:getUserDataTb_()

		context.cards = cards
		context.combineIndex = self._combineIndex
		context.handCardItemList = self._handCardItemList
		context.fightBeginRoundOp = fightBeginRoundOp

		self._cardCombineFlow:registerDoneListener(self._onCombineCardDone, self)
		self._cardCombineFlow:start(context)
	else
		self:_setBlockOperate(false)
		FightController.instance:dispatchEvent(FightEvent.OnCombineCardEnd, cards)

		if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) then
			if self.distributeCards and #self.distributeCards > 0 then
				self:_nextDistributeCards(#cards)
			else
				gohelper.destroy(gohelper.findChild(self._handCardGO, "CombineEffect"))
				self:_updateNow()
				FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
			end
		end

		if fightBeginRoundOp then
			FightController.instance:dispatchEvent(FightEvent.PlayOperationEffectDone, fightBeginRoundOp)
			self:_detectPlayPrecisionEffect()
		end
	end
end

function FightViewHandCard:_onCombineCardDone(status)
	self._cardCombineFlow:unregisterDoneListener(self._onCombineCardDone, self)

	local newCardInfoMO = self._cardsForCombines[self._combineIndex]

	FightController.instance:dispatchEvent(FightEvent.OnCombineOneCard, newCardInfoMO, self._isUniversalCombine)
	self:_combineCards(self._cardsForCombines, nil, self._cardCombineFlow.context.fightBeginRoundOp)
end

function FightViewHandCard:_resetCard(oldCardOps)
	FightGameMgr.operateMgr:cancelAllOperate()
	FightDataHelper.paTaMgr:resetOp()
	self:refreshPreLv()
	FightController.instance:dispatchEvent(FightEvent.OnResetCard, oldCardOps)
end

function FightViewHandCard:_updateNow()
	self:_updateHandCards(FightDataHelper.handCardMgr.handCard)
end

function FightViewHandCard:_filterInvalidCard(cards)
	for i = #cards, 1, -1 do
		local skillId = cards[i].skillId

		if not lua_skill.configDict[skillId] then
			if not skillId then
				logError("手牌数据没有skillId,请保存复现数据找开发看看")
			else
				logError("技能表找不到id:" .. skillId)
			end

			table.remove(cards, i)
		end
	end

	return cards
end

function FightViewHandCard:_updateHandCards(handCards, startIndex)
	handCards = handCards or FightDataHelper.handCardMgr.handCard
	handCards = self:_filterInvalidCard(handCards)

	if handCards then
		if not #handCards then
			local handCardCount = 0

			for i = startIndex or 1, handCardCount do
				local handCardItem = self._handCardItemList[i]

				handCardItem = handCardItem or self:createHandCardItem()
				handCardItem.go.name = "cardItem" .. i

				local posX = FightViewHandCard.calcCardPosX(i)

				recthelper.setAnchor(handCardItem.tr, posX, 0)
				gohelper.setActive(handCardItem.go, true)
				transformhelper.setLocalScale(handCardItem.tr, 1, 1, 1)
				handCardItem:updateItem(i, handCards[i])
				gohelper.setAsLastSibling(handCardItem.go)
			end

			for i = #self._handCardItemList, handCardCount + 1, -1 do
				local handCardItem = table.remove(self._handCardItemList)

				self:recycleHandCardItem(handCardItem)
			end

			self:refreshPreDeleteCard(handCards)
			self:refreshLyCardTag()
			self:_refreshPreLv(self.existEffectTagCountDict)
		end
	end
end

function FightViewHandCard:updateOneCard(index, updateFromType)
	local handCards = FightDataHelper.handCardMgr.handCard

	handCards = self:_filterInvalidCard(handCards)

	if handCards then
		if not #handCards then
			local handCardCount = 0

			for i = 1, handCardCount do
				if i == index then
					local handCardItem = self._handCardItemList[i]

					if not handCardItem then
						handCardItem = self:createHandCardItem()

						local posX = FightViewHandCard.calcCardPosX(i)

						recthelper.setAnchor(handCardItem.tr, posX, 0)
						gohelper.setActive(handCardItem.go, true)
						transformhelper.setLocalScale(handCardItem.tr, 1, 1, 1)
					end

					handCardItem:updateItem(i, handCards[i], updateFromType)

					break
				end
			end
		end
	end
end

function FightViewHandCard:createHandCardItem()
	local handCardItem = table.remove(self._handCardItemPool)

	if handCardItem then
		table.insert(self._handCardItemList, handCardItem)

		return handCardItem
	end

	local handCardGO = gohelper.clone(self._handCardItemPrefab, self._handCardGO)

	handCardItem = MonoHelper.addLuaComOnceToGo(handCardGO, FightViewHandCardItem, self)

	table.insert(self._handCardItemList, handCardItem)

	return handCardItem
end

function FightViewHandCard:recycleHandCardItem(handCardItem)
	gohelper.setActive(handCardItem.go, false)

	handCardItem.go.name = "cardItem0"

	handCardItem:updateItem(0, nil)
	handCardItem:setDeviceEffectGoActive(false)

	gohelper.onceAddComponent(handCardItem:getForAnimGo(), gohelper.Type_CanvasGroup).alpha = 1

	for _, cardItem in ipairs(self._handCardItemPool) do
		if cardItem == handCardItem then
			return
		end
	end

	table.insert(self._handCardItemPool, handCardItem)
end

function FightViewHandCard:_setBlockOperate(isBlock)
	FightViewHandCard.blockOperate = not not isBlock

	if not gohelper.isNil(self._handCardGOCanvasGroup) then
		self._handCardGOCanvasGroup.blocksRaycasts = not isBlock
	end

	if isBlock then
		TaskDispatcher.cancelTask(self._delayCancelBlock, self)
		TaskDispatcher.runDelay(self._delayCancelBlock, self, 10)
	else
		TaskDispatcher.cancelTask(self._delayCancelBlock, self)
	end

	self:refreshLYAreaActive()
end

function FightViewHandCard:_delayCancelBlock()
	self:_setBlockOperate(false)
end

function FightViewHandCard:_onAfterForceUpdatePerformanceData()
	self:_updateNow()
end

function FightViewHandCard:_onRoundSequenceFinish()
	self:_updateNow()
end

function FightViewHandCard:_onClothSkillRoundSequenceFinish()
	return
end

function FightViewHandCard:_onDragHandCardBegin(index, position)
	if self._cardDragFlow.status == WorkStatus.Running then
		return
	end

	self._draging = true

	if self._cardLongPressFlow.status == WorkStatus.Running then
		self._cardLongPressFlow:stop()
		self._cardLongPressFlow:reset()
	end

	self._dragBeginCards = FightDataHelper.handCardMgr.handCard
	self._cardCount = #self._dragBeginCards

	if index > self._cardCount then
		return
	end

	local context = self:getUserDataTb_()

	context.index = index
	context.position = position
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList
	context.handCardTr = self._handCardTr
	context.handCards = self._dragBeginCards

	self._cardDragFlow:start(context)
	self._handCardItemList[index]:stopLongPressEffect()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
end

function FightViewHandCard:_onDragHandCardEnd(index, position)
	if index > self._cardCount then
		self:_updateNow()

		return
	end

	self._draging = false

	self._cardDragFlow:stop()
	self._cardDragFlow:reset()

	self._dragIndex = index

	local anchorPos = recthelper.screenPosToAnchorPos(position, self._handCardTr)
	local curScale, _, _ = transformhelper.getLocalScale(self._handCardItemList[index].tr)
	local targetPosX = anchorPos.x - FightViewHandCard.HalfWidth

	self._targetIndex = FightViewHandCard.calcCardIndexDraging(targetPosX, self._cardCount, 1)

	local context = self:getUserDataTb_()

	context.index = index
	context.targetIndex = self._targetIndex
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList
	context.handCardTr = self._handCardTr
	context.handCards = self._dragBeginCards

	self._cardDragEndFlow:registerDoneListener(self._onDragEndFlowDone, self)
	self._cardDragEndFlow:start(context)
	self:_setBlockOperate(true)
end

function FightViewHandCard:_onDragEndFlowDone()
	self._cardDragEndFlow:unregisterDoneListener(self._onDragEndFlowDone, self)

	local from = self._dragIndex
	local to = self._targetIndex

	if not self:_checkGuideMoveCard(from, to) then
		return
	end

	if from == to then
		self:_setBlockOperate(false)

		return
	end

	local fromCard = self._dragBeginCards[from]
	local isMoveUniversalCard = false

	if FightEnum.UniversalCard[fromCard.skillId] then
		local cardList = tabletool.copy(self._dragBeginCards)

		table.remove(cardList, from)
		table.insert(cardList, to, fromCard)

		if not FightCardDataHelper.canCombineWithUniversalForPerformance(fromCard, cardList[to + 1]) then
			self:_updateNow()
			self:_setBlockOperate(false)

			return
		end

		isMoveUniversalCard = to
	end

	local cards = self._dragBeginCards
	local fromSkillId = fromCard.skillId

	if (fromCard.uid == FightEntityScene.MySideId or fromCard.uid == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[fromSkillId] then
		self:_updateNow()
		self:_setBlockOperate(false)

		return
	end

	self:_moveCardItemInList(from, to)

	if not FightDataHelper.operationDataMgr:isCardOpEnd() then
		local operation = FightDataHelper.operationDataMgr:newOperation()

		operation.moveCanAddExpoint, operation.isUnlimitMoveOrExtraMove = FightCardDataHelper.moveCanAddExpoint(cards, fromCard)

		if isMoveUniversalCard then
			operation:moveUniversalCard(from, to, fromCard)
		else
			operation:moveCard(from, to, fromCard)
		end

		FightCardDataHelper.moveOnly(cards, from, to)

		if from ~= to then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCardEnd)
		end

		self:_updateHandCards(cards)
		FightController.instance:dispatchEvent(FightEvent.OnMoveHandCard, operation, fromCard)
		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, operation)

		local combineIndex = isMoveUniversalCard and to

		self:_combineCards(cards, combineIndex, operation)
	else
		self:_updateHandCards(cards)

		if not FightDataHelper.stateMgr.isReplay then
			-- block empty
		end

		self:_setBlockOperate(false)
	end
end

function FightViewHandCard:_moveCardItemInList(from, to)
	if not self._handCardItemList or not self._handCardItemList[from] or not self._handCardItemList[to] then
		return
	end

	if from == to then
		return
	end

	local fromCardItem = self._handCardItemList[from]
	local offset = from < to and 1 or -1

	for i = from, to - offset, offset do
		self._handCardItemList[i] = self._handCardItemList[i + offset]
	end

	self._handCardItemList[to] = fromCardItem
end

function FightViewHandCard:_playCardItemInList(from)
	if not self._handCardItemList or not self._handCardItemList[from] then
		return
	end

	self:_moveCardItemInList(from, #self._handCardItemList)
end

function FightViewHandCard:_checkGuideMoveCard(from, to)
	local guideFlag = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if guideFlag then
		local success = from == guideFlag.from

		if success then
			local flag = false
			local tos = guideFlag.tos

			for i, one in ipairs(tos) do
				if to == one then
					flag = true

					break
				end
			end

			success = flag
		end

		if success then
			FightController.instance:dispatchEvent(FightEvent.OnGuideDragCard)

			return true
		else
			self:_resetCard({})
			self:_setBlockOperate(false)

			return false
		end
	end

	return true
end

function FightViewHandCard:selectLeftCard()
	if self._longPressIndex == nil then
		local index = 1

		for i, cardItem in pairs(self._handCardItemList) do
			if cardItem.go.activeInHierarchy and index < cardItem.index then
				index = cardItem.index
			end
		end

		self:OnkeyLongPress(index)
	else
		if self._longPressIndex + 1 > #self._handCardItemList then
			return
		end

		local cardItem = self._handCardItemList[self._longPressIndex + 1]

		if cardItem and not cardItem.go.activeInHierarchy then
			return
		end

		self:OnkeyLongPress(self._longPressIndex + 1)
	end
end

function FightViewHandCard:selectRightCard()
	if self._longPressIndex == nil then
		local index = 1

		for i, cardItem in pairs(self._handCardItemList) do
			if cardItem.go.activeInHierarchy and index > cardItem.index then
				index = cardItem.index
			end
		end

		self:OnkeyLongPress(index)
	else
		if self._longPressIndex - 1 < 1 then
			return
		end

		self:OnkeyLongPress(self._longPressIndex - 1)
	end
end

function FightViewHandCard:OnKeyPlayCard(index)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	self:_longPressHandCardEnd()

	local cardCount = #FightDataHelper.handCardMgr.handCard

	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem.index == cardCount - index + 1 and cardItem.go.activeInHierarchy then
			cardItem:_onClickThis()
		end
	end
end

function FightViewHandCard:OnkeyLongPress(index)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	self:_longPressHandCardEnd()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem.index == index and cardItem.go.activeInHierarchy then
			cardItem:_onLongPress()
		end
	end
end

function FightViewHandCard:onControlRelease()
	if not self._longPressIndex then
		return
	end

	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem and cardItem.index == self._longPressIndex then
			cardItem:onKeyClickThis()
		end
	end
end

function FightViewHandCard:OnSeleCardMoveEnd()
	self._keyDrag = false

	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, self.startDragIndex, self.dragIndex)

	self.dragIndex = nil
	self.curLongPress = nil
end

function FightViewHandCard:getLongPressItemIndex()
	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem and cardItem._isLongPress then
			return cardItem
		end
	end

	return nil
end

function FightViewHandCard:_longPressHandCard(index)
	if self._draging then
		return
	end

	logNormal("_longPressHandCard ", index)
	self:_longPressHandCardEnd(self._longPressIndex)

	if self._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if self._cardLongPressFlow.status == WorkStatus.Running then
		return
	end

	self._longPressIndex = index
	self._cardCount = #FightDataHelper.handCardMgr.handCard

	local context = self:getUserDataTb_()

	context.index = index
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList

	self._cardLongPressFlow:registerDoneListener(self._onLongPressFlowDone, self)
	self._cardLongPressFlow:start(context)

	local cardItem = self._handCardItemList[index]

	cardItem:playLongPressEffect()
end

function FightViewHandCard:_onLongPressFlowDone()
	self._cardLongPressFlow:unregisterDoneListener(self._onLongPressFlowDone, self)
end

function FightViewHandCard:_longPressHandCardEnd(index)
	if self._draging then
		return
	end

	index = index or self._longPressIndex

	if not index then
		return
	end

	local cardItem = self._handCardItemList[index]

	if not cardItem then
		return
	end

	cardItem:stopLongPressEffect()
	cardItem:onLongPressEnd()

	if self._cardLongPressFlow.status == WorkStatus.Running then
		self._cardLongPressFlow:stop()
		self._cardLongPressFlow:reset()
	end

	local context = self:getUserDataTb_()

	context.index = index
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList

	self._cardLongPressEndFlow:registerDoneListener(self._onLongPressEndFlowDone, self)
	self._cardLongPressEndFlow:start(context)

	self._longPressIndex = nil
end

function FightViewHandCard:_onLongPressEndFlowDone()
	self._cardLongPressEndFlow:unregisterDoneListener(self._onLongPressEndFlowDone, self)
end

function FightViewHandCard:_onEnterOperateState(operateState)
	if operateState == FightStageMgr.OperateStateType.Discard then
		self._abandonTran:SetAsLastSibling()
		gohelper.setActive(self._abandon, true)
		self._playCardTransform:SetAsLastSibling()

		local count = 0

		for i = 1, #self._handCardItemList do
			local handCardItem = self._handCardItemList[i]

			if handCardItem then
				if handCardItem.go.activeInHierarchy then
					count = count + 1
				else
					break
				end

				local cardInfo = handCardItem.cardInfoMO
				local entityMO = FightDataHelper.entityMgr:getById(cardInfo.uid)

				if entityMO and (FightCardDataHelper.isBigSkill(cardInfo.skillId) or true) or true then
					handCardItem.go.transform:SetParent(self._abandonCardRootTran, true)
				end
			end
		end

		local scale = FightCardDataHelper.getHandCardContainerScale(false)
		local srcWidth = FightViewHandCard.calcTotalWidth(count, 1) + 20

		recthelper.setWidth(self._abandonLine, scale * srcWidth)
	elseif operateState == FightStageMgr.OperateStateType.RecordSkill then
		self:enterRecordSkillState()
	elseif operateState == FightStageMgr.OperateStateType.DeviceDiscard then
		self:enterDeviceDiscardCardState()
	end
end

function FightViewHandCard:cancelAbandonState()
	gohelper.setActive(self._abandon, false)

	local childCount = self._abandonCardRootTran.childCount

	for i = childCount - 1, 0, -1 do
		self._abandonCardRootTran:GetChild(i):SetParent(self._handCardTr, true)
	end

	self._playCardTransform:SetSiblingIndex(FightViewHandCard.playCardSiblingIndex)
end

function FightViewHandCard:enterDeviceDiscardCardState()
	self.goDeviceDiscard = self.goDeviceDiscard or gohelper.findChild(self.viewGO, "root/#go_devicediscard")
	self.rectDeviceDiscardRoot = gohelper.findChildComponent(self.goDeviceDiscard, "cardRoot", gohelper.Type_RectTransform)

	gohelper.setActive(self.goDeviceDiscard, true)
	gohelper.setAsLastSibling(self.goDeviceDiscard)
	self._playCardTransform:SetAsLastSibling()

	local handCardMgr = FightDataHelper.handCardMgr

	for i = 1, #self._handCardItemList do
		local handCardItem = self._handCardItemList[i]

		if handCardItem then
			local cardInfo = handCardItem.cardInfoMO

			if handCardMgr:checkCardIsDeviceCard(cardInfo) then
				handCardItem.go.transform:SetParent(self.rectDeviceDiscardRoot, true)
			end
		end
	end
end

function FightViewHandCard:enterRecordSkillState()
	self.goLorentz = self.goLorentz or gohelper.findChild(self.viewGO, "root/#go_lorentz")
	self.goLorentzCardRootTr = gohelper.findChildComponent(self.goLorentz, "cardRoot", gohelper.Type_RectTransform)

	gohelper.setActive(self.goLorentz, true)
	gohelper.setAsLastSibling(self.goLorentz)
	self._playCardTransform:SetAsLastSibling()

	for i = 1, #self._handCardItemList do
		local handCardItem = self._handCardItemList[i]

		if handCardItem then
			local cardInfo = handCardItem.cardInfoMO

			if FightDataHelper.operationDataMgr:canRecordCard(cardInfo) then
				handCardItem.go.transform:SetParent(self.goLorentzCardRootTr, true)
			end
		end
	end

	self:showLorentzArea()
end

function FightViewHandCard:exitDeviceDiscardState()
	gohelper.setActive(self.goDeviceDiscard, false)
	self._playCardTransform:SetSiblingIndex(FightViewHandCard.playCardSiblingIndex)

	local childCount = self.rectDeviceDiscardRoot.childCount

	for i = childCount - 1, 0, -1 do
		self.rectDeviceDiscardRoot:GetChild(i):SetParent(self._handCardTr, true)
	end

	for _, cardItem in ipairs(self._handCardItemList) do
		recthelper.setAnchorY(cardItem.tr, 0)
	end
end

function FightViewHandCard:exitRecordSkillState()
	gohelper.setActive(self.goLorentz, false)
	self:hideLorentzArea()
	self._playCardTransform:SetSiblingIndex(FightViewHandCard.playCardSiblingIndex)

	local childCount = self.goLorentzCardRootTr.childCount

	for i = childCount - 1, 0, -1 do
		self.goLorentzCardRootTr:GetChild(i):SetParent(self._handCardTr, true)
	end

	for _, cardItem in ipairs(self._handCardItemList) do
		recthelper.setAnchorY(cardItem.tr, 0)
	end
end

function FightViewHandCard:showLorentzArea()
	self.lorentzActive = true

	if self.goLorentzArea then
		self:refreshLorentzArea()

		return
	end

	if self.lorentzLoader then
		return
	end

	self.lorentzLoader = MultiAbLoader.New()

	self.lorentzLoader:addPath("ui/viewres/fight/fight_lorentz_handcard.prefab")
	self.lorentzLoader:startLoad(self.onLoadLorentzDone, self)
end

FightViewHandCard.LorentzWidthOffset = 137

function FightViewHandCard:onLoadLorentzDone()
	local prefab = self.lorentzLoader:getFirstAssetItem():GetResource()

	self.goLorentzArea = gohelper.clone(prefab, self.goLorentz)
	self.rectLorentzArea = self.goLorentzArea:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(self.rectLorentzArea, 0, 0)
	self:refreshLorentzArea()
end

function FightViewHandCard:refreshLorentzArea()
	if not self.lorentzActive then
		gohelper.setActive(self.goLorentzArea, false)

		return
	end

	local cards = FightDataHelper.handCardMgr.handCard

	if cards then
		if not #cards then
			local len = 0

			if len < 1 then
				gohelper.setActive(self.goLorentzArea, false)

				return
			end

			AudioMgr.instance:trigger(350023)

			local width = FightViewHandCard.calcTotalWidth(len, 1) + FightViewHandCard.LorentzWidthOffset

			gohelper.setActive(self.goLorentzArea, true)
			recthelper.setWidth(self.rectLorentzArea, width)
		end
	end
end

function FightViewHandCard:hideLorentzArea()
	self.lorentzActive = false

	self:refreshLorentzArea()
end

function FightViewHandCard:_onExitOperateState(operateState)
	if operateState == FightStageMgr.OperateStateType.Discard then
		self:cancelAbandonState()
	elseif operateState == FightStageMgr.OperateStateType.RecordSkill then
		self:exitRecordSkillState()
	elseif operateState == FightStageMgr.OperateStateType.DeviceDiscard then
		self:exitDeviceDiscardState()
	end
end

function FightViewHandCard:_onRefreshCardHeatShow(heatId)
	if self._handCardItemList then
		for i, v in ipairs(self._handCardItemList) do
			v:showCardHeat()
		end
	end
end

function FightViewHandCard:onChangeCardEnergy(changeList)
	if not changeList then
		return
	end

	for _, change in ipairs(changeList) do
		local index = change[1]
		local cardItem = self._handCardItemList[index]

		if cardItem then
			cardItem:changeEnergy()
		end
	end
end

function FightViewHandCard:onGetSkinDownEffectRoot()
	FightMsgMgr.replyMsg(FightMsgId.GetSkinDownEffectRoot, self.skinDownEffectRoot)
end

function FightViewHandCard.calcCardPosXDraging(cardIndex, cardCount, dragToIndex, dragCardScale)
	local totalWidth = FightViewHandCard.calcTotalWidth(cardCount, dragCardScale)
	local newCardWidth = totalWidth / (cardCount - 1 + dragCardScale)

	if cardIndex < dragToIndex then
		return -0.5 * newCardWidth - newCardWidth * (cardIndex - 1)
	elseif dragToIndex < cardIndex then
		return -0.5 * newCardWidth - newCardWidth * (cardIndex - 1) - (dragCardScale - 1) * newCardWidth
	else
		return -0.5 * newCardWidth - newCardWidth * (cardIndex - 2) - (dragCardScale * 0.5 + 0.5) * newCardWidth
	end
end

function FightViewHandCard.calcCardIndexDraging(anchorX, cardCount, dragCardScale)
	local totalWidth = FightViewHandCard.calcTotalWidth(cardCount, dragCardScale)
	local newCardWidth = totalWidth / (cardCount - 1 + dragCardScale)
	local index = -anchorX / newCardWidth - dragCardScale * 0.5 + 1

	index = math.floor(index + 0.5)
	index = Mathf.Clamp(index, 1, cardCount)

	return index
end

function FightViewHandCard.calcTotalWidth(cardCount, dragCardScale)
	return cardCount * HandCardWidth + (dragCardScale - 1) * HandCardWidth * 0.5
end

function FightViewHandCard.calcCardPosX(cardIndex)
	return -1 * HandCardWidth * (cardIndex - 1) - HandCardWidth / 2
end

return FightViewHandCard
