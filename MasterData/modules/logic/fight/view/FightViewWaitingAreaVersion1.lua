-- chunkname: @modules/logic/fight/view/FightViewWaitingAreaVersion1.lua

module("modules.logic.fight.view.FightViewWaitingAreaVersion1", package.seeall)

local FightViewWaitingAreaVersion1 = class("FightViewWaitingAreaVersion1", BaseViewExtended)
local UpdateCardFromType = {
	Server = 2,
	Client = 1
}

FightViewWaitingAreaVersion1.ScaleInterval = 0.05
FightViewWaitingAreaVersion1.PrefabWidth = 1270
FightViewWaitingAreaVersion1.CardItemWidth = 192

function FightViewWaitingAreaVersion1:onInitView()
	self._waitingAreaTran = gohelper.findChild(self.viewGO, "root/waitingArea").transform
	self._waitingAreaGO = gohelper.findChild(self.viewGO, "root/waitingArea/inner")
	self._skillTipsGO = gohelper.findChild(self.viewGO, "root/waitingArea/inner/skill")
	self._txtCardTitle = gohelper.findChildText(self._skillTipsGO, "txtTips/txtTitle")
	self._txtCardDesc = gohelper.findChildText(self._skillTipsGO, "txtTips")
	self._rectTrCardDesc = self._txtCardDesc:GetComponent(gohelper.Type_RectTransform)
	self._cardItemList = {}
	self._cardItemPool = {}
	self._cardItemGOList = self:getUserDataTb_()
	self._cardObjModel = gohelper.findChild(self._waitingAreaGO, "cardItemModel")
	self.goDeviceCardItem = gohelper.findChild(self._waitingAreaGO, "deviceCardItem")
	self.rectDeviceCardItem = self.goDeviceCardItem:GetComponent(gohelper.Type_RectTransform)

	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.RectDeviceCard, self.rectDeviceCardItem)

	self.goCalculatePosObj = gohelper.findChild(self._waitingAreaGO, "calculateposobj")

	self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.GoCalculatePosObj, self.goCalculatePosObj)
	self:_refreshTipsVisibleState()
end

function FightViewWaitingAreaVersion1:_refreshTipsVisibleState()
	gohelper.onceAddComponent(self._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function FightViewWaitingAreaVersion1:onOpen()
	self:_makeTipsOutofSight()
	self.addEventCb(self, FightController.instance, FightEvent.ShowSimulateClientUsedCard, self._onShowSimulateClientUsedCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetUseCards, self._onSetUseCards, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onEndRound, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.ASFD_OnStart, self.onASFDStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.ASFD_OnDone, self.onASFDDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.InvalidUsedCard, self._onInvalidUsedCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.InvalidPreUsedCard, self._onInvalidPreUsedCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._refreshTipsVisibleState, self)
	self.addEventCb(self, FightController.instance, FightEvent.ParallelPlayNextSkillDoneThis, self._onParallelPlayNextSkillDoneThis, self)
	self.addEventCb(self, FightController.instance, FightEvent.ForceEndSkillStep, self._onForceEndSkillStep, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCardAroundUpRank, self._onPlayCardAroundUpRank, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCardAroundDownRank, self._onPlayCardAroundDownRank, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCardAroundUpRank_Lorentz, self._onPlayCardAroundUpRank_Lorentz, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCardAroundSetGray, self._onPlayCardAroundSetGray, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddUseCard, self._onAddUseCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayChangeRankFail, self._onPlayChangeRankFail, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardLevelChangeDone, self._onCardLevelChangeDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.ALF_AddCardEffectAppear, self._onAlfAddCardEffectAppear, self)
	self.addEventCb(self, FightController.instance, FightEvent.ALF_AddCardEffectEnd, self._onAlfAddCardEffectEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateOnePlayedCard, self.onUpdateOnePlayedCard, self)
end

function FightViewWaitingAreaVersion1:onUpdateOnePlayedCard(index, updateFromType)
	local cardItem = self._cardItemList[index]

	if not cardItem then
		return
	end

	local cardList = FightPlayCardModel.instance:getUsedCards()
	local cardInfo = cardList[index]

	if not cardInfo then
		return
	end

	cardItem:updateItem(cardInfo.uid, cardInfo.skillId, cardInfo, updateFromType)
end

function FightViewWaitingAreaVersion1:_onAlfAddCardEffectAppear()
	self:updateCardLockObj()
end

function FightViewWaitingAreaVersion1:_onAlfAddCardEffectEnd()
	self:updateCardLockObj()
end

function FightViewWaitingAreaVersion1:onClose()
	return
end

function FightViewWaitingAreaVersion1:onDestroyView()
	if self._addUseCardFlow then
		self._addUseCardFlow:stop()

		self._addUseCardFlow = nil
	end

	for i, v in ipairs(self._cardItemList) do
		v:releaseEffectFlow()
	end

	for i, v in ipairs(self._cardItemPool) do
		v:releaseEffectFlow()
	end

	self:_releaseScaleTween()

	if self.deviceAreaCardItem then
		self.deviceAreaCardItem:dispose()

		self.deviceAreaCardItem = nil
	end

	if self.LYCard then
		self.LYCard:dispose()

		self.LYCard = nil
	end
end

function FightViewWaitingAreaVersion1:_onAddUseCard(cardIndexList, behaviourIdList)
	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local find = false

	for i, cardIndex in ipairs(cardIndexList) do
		local cardInfo = usedCards[cardIndex]

		if cardInfo then
			cardInfo.CUSTOMADDUSECARD = true
			cardInfo.CUSTOM_BehaviourId = behaviourIdList[i]
			find = true
		end
	end

	if find then
		if not self._addUseCardFlow then
			self._addUseCardFlow = FlowSequence.New()

			self._addUseCardFlow:addWork(FightViewWorkAddUseCard)
		end

		self._addUseCardFlow:stop()
		self._addUseCardFlow:start(self)
	end
end

function FightViewWaitingAreaVersion1:_onPlayChangeRankFail(index, failType)
	local cardItem = self._cardItemList[index]

	if cardItem then
		cardItem:playChangeRankFail(failType)
	end
end

function FightViewWaitingAreaVersion1.getCardItemName(index)
	return "cardItem" .. tostring(index)
end

function FightViewWaitingAreaVersion1.getCardPosByServerData(index, totalCount)
	if not totalCount then
		local usedCards = FightPlayCardModel.instance:getUsedCards()

		totalCount = #usedCards
	end

	local anchor = FightViewWaitingAreaVersion1.CardItemWidth * (totalCount - index)

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		anchor = anchor + FightViewWaitingAreaVersion1.CardItemWidth
	end

	local deviceIndex = FightPlayCardModel.instance:getDeviceIndex()

	if not deviceIndex then
		return -anchor
	end

	local deviceWidth = FightDeviceHelper.getDeviceAreaTotalWidth()

	if index < deviceIndex then
		anchor = anchor + deviceWidth - FightViewWaitingAreaVersion1.CardItemWidth

		return -anchor
	elseif index == deviceIndex then
		return -anchor
	else
		return -anchor
	end
end

function FightViewWaitingAreaVersion1.getCardPosByClientData(index)
	local totalCount = FightDataHelper.operationDataMgr:getPlayCardOpCount()
	local anchor = FightViewWaitingAreaVersion1.CardItemWidth * (totalCount - index)

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		anchor = anchor + FightViewWaitingAreaVersion1.CardItemWidth
	end

	if not FightDataHelper.hasDeviceArea() then
		return -anchor
	end

	local deviceWidth = FightDeviceHelper.getDeviceAreaTotalWidth()

	anchor = anchor + deviceWidth

	return -anchor
end

function FightViewWaitingAreaVersion1.getDeviceAnchorXByClientData()
	local anchor = 0

	if FightDataHelper.LYDataMgr:hasCountBuff() then
		anchor = anchor + FightViewWaitingAreaVersion1.CardItemWidth
	end

	return -anchor
end

function FightViewWaitingAreaVersion1.getDeviceAnchorXByServerData()
	local deviceIndex = FightPlayCardModel.instance:getDeviceIndex()

	if not deviceIndex then
		return 0
	end

	return (FightViewWaitingAreaVersion1.getCardPosByServerData(deviceIndex))
end

function FightViewWaitingAreaVersion1.getLYCardPos()
	return 0
end

function FightViewWaitingAreaVersion1:_onSetUseCards()
	self:_updateView(nil, nil, UpdateCardFromType.Server)
	self:updateCardLockObj()
end

function FightViewWaitingAreaVersion1:updateCardLockObj()
	local usedCards = FightPlayCardModel.instance:getUsedCards()

	for i, v in ipairs(usedCards) do
		local cardItem = self._cardItemList[i]

		if not cardItem:isDeviceAreaCard() then
			local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

			v.clientData.custom_lock = FightViewHandCardItemLock.setCardLock(v.uid, v.skillId, lockGO, false)
		end
	end
end

local TempUseCard = {}

function FightViewWaitingAreaVersion1:_onShowSimulateClientUsedCard()
	local clientUsedCard = TempUseCard

	tabletool.clear(clientUsedCard)

	for _, v in ipairs(FightDataHelper.operationDataMgr:getPlayCardOpList()) do
		table.insert(clientUsedCard, v.cardInfoMO)
	end

	if FightDataHelper.hasDeviceArea() then
		table.insert(clientUsedCard, FightCardInfoData.getTempDeviceCard())
	end

	self:_updateView(clientUsedCard, 0, UpdateCardFromType.Client)

	for i, v in ipairs(clientUsedCard) do
		local cardItem = self._cardItemList[i]

		if not cardItem:isDeviceAreaCard() then
			local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

			v.clientData.custom_lock = FightViewHandCardItemLock.setCardLock(v.uid, v.skillId, lockGO, false)
		end
	end

	if self.LYCard then
		self.LYCard:resetState()
		self.LYCard:playAnim("in")
	end
end

function FightViewWaitingAreaVersion1:_onEndRound()
	self:_makeTipsOutofSight()
end

function FightViewWaitingAreaVersion1:_onInvalidUsedCard(index, configEffect)
	local cardItem = self._cardItemList[index]

	if not cardItem then
		return
	end

	if cardItem:isDeviceAreaCard() then
		return
	end

	local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

	gohelper.setActive(lockGO, false)

	if configEffect == -1 then
		cardItem:disappearCard()
	else
		cardItem:dissolveCard()
	end
end

function FightViewWaitingAreaVersion1:_onInvalidPreUsedCard(index)
	for i = FightPlayCardModel.instance:getCurIndex() + 1, index - 1 do
		self:_onInvalidUsedCard(i)
	end
end

function FightViewWaitingAreaVersion1:_onParallelPlayNextSkillDoneThis(fightStepData)
	self:_onForceEndSkillStep(fightStepData)
end

function FightViewWaitingAreaVersion1:_onForceEndSkillStep(fightStepData)
	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	local cardIndex = fightStepData.cardIndex
	local cardItem = self._cardItemList[cardIndex]

	if not cardItem then
		return
	end

	if cardItem:isDeviceAreaCard() then
		return
	end

	cardItem:releaseEffectFlow()
	gohelper.setActive(cardItem.go, false)
	self:_makeTipsOutofSight()
end

function FightViewWaitingAreaVersion1:_beforePlaySkill(entity, skillId, fightStepData)
	if fightStepData.actType == FightEnum.ActType.DEVICE then
		return self:_beforePlayDeviceSkill(entity, skillId, fightStepData)
	end

	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	if fightStepData.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(fightStepData.cardIndex)
	self:playScaleTweenByServer()

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		self:refreshSkillText(skillId, entity.id)
		self:_displayFlow(entity.id, skillId, FightPlayCardModel.instance:getCurIndex())
	end
end

function FightViewWaitingAreaVersion1:_beforePlayDeviceSkill(entity, skillId, fightStepData)
	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	local deviceIndex = FightPlayCardModel.instance:getDeviceIndex()

	FightPlayCardModel.instance:playCard(deviceIndex)
	self:playScaleTweenByServer()
	self:refreshSkillText(skillId, entity.id)
	self:_displayFlow(entity.id, skillId, deviceIndex)
end

function FightViewWaitingAreaVersion1:refreshSkillText(skillId, entityId)
	local skillCO = lua_skill.configDict[skillId]
	local skillDesc = FightConfig.instance:getEntitySkillDesc(entityId, skillCO)

	self._txtCardDesc.text = skillCO and HeroSkillModel.instance:skillDesToSpot(skillDesc) or ""

	if skillCO then
		self._txtCardTitle.text = skillCO.name or ""
	end

	self._txtCardDesc:ForceMeshUpdate(true, true)

	local renderValue = self._txtCardDesc:GetRenderedValues()
	local descHeight = renderValue.y

	descHeight = math.max(0, descHeight)

	local height = descHeight + 83

	recthelper.setHeight(self._rectTrCardDesc, descHeight)
	recthelper.setHeight(self._skillTipsGO.transform, height)
end

function FightViewWaitingAreaVersion1:_displayFlow(entityId, skillId, index)
	local cardItem = self._cardItemList[index]

	if not cardItem then
		return
	end

	for i = 1, index - 1 do
		self._cardItemList[i]:releaseEffectFlow()
		gohelper.setActive(self._cardItemList[i].go, false)

		local lockGO = gohelper.findChild(self._cardItemList[i].parentGo, "lock")

		gohelper.setActive(lockGO, false)
	end

	self._cardItemList[index]:playUsedCardDisplay(self._skillTipsGO)
end

function FightViewWaitingAreaVersion1:_onSkillPlayFinish(entity, skillId, fightStepData)
	if fightStepData.actType == FightEnum.ActType.DEVICE then
		return self:_onDeviceSkillPlayFinish(entity, skillId, fightStepData)
	end

	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	local cardItem = self._cardItemList[fightStepData.cardIndex]

	if not cardItem then
		return
	end

	if cardItem:isDeviceAreaCard() then
		return
	end

	local param = {}

	if FightHelper.checkIsDevicePowerCard(skillId) then
		param.noCardFade = true
	end

	cardItem:playUsedCardFinish(self._skillTipsGO, self._waitingAreaGO, param)
end

function FightViewWaitingAreaVersion1:_onDeviceSkillPlayFinish(entity, skillId, fightStepData)
	if not FightHelper.isPlayerCardSkill(fightStepData) then
		return
	end

	local deviceIndex = FightPlayCardModel.instance:getDeviceIndex()
	local cardItem = self._cardItemList[deviceIndex]

	if not cardItem then
		return
	end

	cardItem:playUsedCardFinish(self._skillTipsGO, self._waitingAreaGO)
end

function FightViewWaitingAreaVersion1:onASFDStart(entity, skillId, fightStepData)
	if fightStepData.cardIndex <= FightPlayCardModel.instance:getCurIndex() then
		return
	end

	FightPlayCardModel.instance:playCard(fightStepData.cardIndex)
	self:playScaleTweenByServer()

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		self:refreshSkillText(skillId, entity.id)
		self:_displayFlow(entity.id, skillId, FightPlayCardModel.instance:getCurIndex())
	end
end

function FightViewWaitingAreaVersion1:onASFDDone(cardIndex)
	local cardItem = self._cardItemList[cardIndex]

	if not cardItem then
		return
	end

	if cardItem:isDeviceAreaCard() then
		return
	end

	cardItem:playUsedCardFinish(self._skillTipsGO, self._waitingAreaGO)
end

function FightViewWaitingAreaVersion1:_onBuffUpdate(entityId, effectType, buffId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO or entityMO.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local curIndex = FightPlayCardModel.instance:getCurIndex()

	for i = curIndex + 1, #usedCards do
		local cardItem = self._cardItemList[i]

		if cardItem and not cardItem:isDeviceAreaCard() then
			local cardInfo = usedCards[i]
			local oldLock = cardInfo.clientData.custom_lock
			local newLock = not FightViewHandCardItemLock.canUseCardSkill(cardInfo.uid, cardInfo.skillId)

			if oldLock ~= newLock then
				local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

				cardInfo.clientData.custom_lock = newLock

				if newLock then
					FightViewHandCardItemLock.setCardLock(cardInfo.uid, cardInfo.skillId, lockGO, false)
				else
					gohelper.setActive(lockGO, false)
				end
			end

			if (FightConfig.instance:hasBuffFeature(buffId, FightEnum.BuffFeature.SkillLevelJudgeAdd) or nil) and true then
				cardItem:detectShowBlueStar()
			end
		end
	end
end

function FightViewWaitingAreaVersion1:_makeTipsOutofSight()
	local skillTipsTr = self._skillTipsGO.transform

	recthelper.setAnchorX(skillTipsTr, 2000 + recthelper.getWidth(skillTipsTr))
end

function FightViewWaitingAreaVersion1:getCardItem()
	if #self._cardItemPool > 0 then
		return table.remove(self._cardItemPool)
	end

	local targetCardItemGO = gohelper.cloneInPlace(self._cardObjModel)
	local path = self.viewContainer:getSetting().otherRes[1]
	local cardItemGO = self:getResInst(path, targetCardItemGO, "card")

	gohelper.setAsFirstSibling(cardItemGO)

	local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardItemGO, FightViewCardItem, FightEnum.CardShowType.PlayCard)

	if FightCardDataHelper.getCardSkin() then
		FightViewHandCardItem.replaceLockBg(gohelper.findChild(targetCardItemGO, "lock"))
	end

	cardItem.parentGo = targetCardItemGO
	cardItem.parentTr = targetCardItemGO:GetComponent(gohelper.Type_RectTransform)

	return cardItem
end

function FightViewWaitingAreaVersion1:hideCardItemPool()
	for _, cardItem in ipairs(self._cardItemPool) do
		local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

		gohelper.setActive(lockGO, false)
		gohelper.setActive(cardItem.go, false)
		gohelper.setActive(cardItem.parentGo, false)
	end
end

function FightViewWaitingAreaVersion1:_updateView(cus_cards, cus_index, formType)
	formType = formType or UpdateCardFromType.Client

	if not cus_cards then
		::label_37_0::

		local usedCards = FightPlayCardModel.instance:getUsedCards()

		if not cus_index then
			::label_37_1::

			local curIndex = FightPlayCardModel.instance:getCurIndex()
			local count = #usedCards

			gohelper.setActive(self._waitingAreaGO, count > 0)

			for i = #self._cardItemList, 1, -1 do
				local cardItem = table.remove(self._cardItemList)

				if cardItem:isDeviceAreaCard() then
					self.deviceAreaCardItem = cardItem
				else
					table.insert(self._cardItemPool, cardItem)
				end
			end

			for i = 1, count do
				local usedCard = usedCards[i]
				local cardItem, anchor

				if usedCard.cardType == FightEnum.CardType.DEVICE then
					if not self.deviceAreaCardItem then
						self.deviceAreaCardItem = FightViewDeviceAreaCardItem.New()

						self.deviceAreaCardItem:init(self.goDeviceCardItem)
						self.viewContainer:setCacheUserData(FightViewContainerCacheKey.UserDataKey.DeviceAreaCardItem, self.deviceAreaCardItem)
					end

					self.deviceAreaCardItem:resetWidth()
					self.deviceAreaCardItem:setActive(true)
					self.deviceAreaCardItem:setCanvasAlpha(1)
					self.deviceAreaCardItem:refreshUI()
					self.deviceAreaCardItem:setCardInfo(usedCard)
					gohelper.setActive(self.deviceAreaCardItem.go, true)

					cardItem = self.deviceAreaCardItem
					anchor = formType == UpdateCardFromType.Client and FightViewWaitingAreaVersion1.getDeviceAnchorXByClientData() or FightViewWaitingAreaVersion1.getDeviceAnchorXByServerData()
				else
					local entityId = usedCard.uid
					local skillId = usedCard.skillId

					cardItem = self:getCardItem()
					gohelper.onceAddComponent(cardItem.go, typeof(UnityEngine.CanvasGroup)).alpha = 1
					usedCard.clientData.custom_playedCard = true

					cardItem:updateItem(entityId, skillId, usedCard)
					cardItem:detectShowBlueStar()
					self:refreshCardRedAndBlue(cardItem, usedCard)
					gohelper.setActive(cardItem.go, curIndex < i)
					gohelper.setActive(cardItem.parentGo, curIndex < i)

					cardItem.parentGo.name = FightViewWaitingAreaVersion1.getCardItemName(i)
					anchor = formType == UpdateCardFromType.Client and FightViewWaitingAreaVersion1.getCardPosByClientData(i) or FightViewWaitingAreaVersion1.getCardPosByServerData(i)
				end

				transformhelper.setLocalScale(cardItem.tr, 1, 1, 1)
				recthelper.setAnchor(cardItem.tr, 0, 0)
				table.insert(self._cardItemList, cardItem)
				recthelper.setAnchorX(cardItem.parentTr, anchor)
			end

			self:hideCardItemPool()

			if formType == UpdateCardFromType.Client then
				self:playScaleTweenByClient()
			else
				self:playScaleTweenByServer(count)
			end

			self:refreshLYCard()
		end
	end
end

function FightViewWaitingAreaVersion1:refreshCardRedAndBlue(cardItem, cardInfoMo)
	local redOrBlue = cardInfoMo and cardInfoMo.areaRedOrBlue

	cardItem:setActiveRed(redOrBlue == FightEnum.CardColor.Red)
	cardItem:setActiveBlue(redOrBlue == FightEnum.CardColor.Blue)
	cardItem:setActiveBoth(redOrBlue == FightEnum.CardColor.Both)
end

function FightViewWaitingAreaVersion1:refreshLYCard()
	if FightDataHelper.LYDataMgr:hasCountBuff() then
		self.LYCard = self.LYCard or FightLYWaitAreaCard.Create(self._waitingAreaGO)

		self.LYCard:setScale(FightEnum.LYCardWaitAreaScale)
	end

	if self.LYCard then
		self.LYCard:refreshLYCard()

		local anchorX = FightViewWaitingAreaVersion1.getLYCardPos()

		self.LYCard:setAnchorX(anchorX)
	end
end

function FightViewWaitingAreaVersion1:_playScaleTweenByFirstCardPos(firstCardAnchorPos)
	self:_releaseScaleTween()

	local needWidth = math.abs(firstCardAnchorPos) + FightViewWaitingAreaVersion1.CardItemWidth
	local toScale = 1

	if needWidth > FightViewWaitingAreaVersion1.PrefabWidth then
		toScale = FightViewWaitingAreaVersion1.PrefabWidth / needWidth
	end

	toScale = math.max(0.3, toScale)

	local skillScale = 1 / toScale

	transformhelper.setLocalScale(self._skillTipsGO.transform, skillScale, skillScale, skillScale)

	self._tweenScale = ZProj.TweenHelper.DOScale(self._waitingAreaTran, toScale, toScale, toScale, 0.1)
end

function FightViewWaitingAreaVersion1:playScaleTweenByClient()
	local lastPosX = FightViewWaitingAreaVersion1.getCardPosByClientData(1)

	self:_playScaleTweenByFirstCardPos(lastPosX)
end

function FightViewWaitingAreaVersion1:playScaleTweenByServer(count)
	count = count or FightPlayCardModel.instance:getRemainCardCount()

	local lastPosX = FightViewWaitingAreaVersion1.getCardPosByServerData(1, count)

	self:_playScaleTweenByFirstCardPos(lastPosX)
end

function FightViewWaitingAreaVersion1:_releaseScaleTween()
	if self._tweenScale then
		ZProj.TweenHelper.KillById(self._tweenScale)

		self._tweenScale = nil
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundUpRank(index, oldSkillId)
	local cardItem = self._cardItemList[index]

	if cardItem and not cardItem:isDeviceAreaCard() then
		local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

		gohelper.setActive(lockGO, false)
		cardItem:playCardLevelChange(nil, oldSkillId)
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundUpRank_Lorentz(index, newCardInfoMo)
	local cardItem = self._cardItemList[index]

	if cardItem and not cardItem:isDeviceAreaCard() then
		local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

		gohelper.setActive(lockGO, false)
		cardItem:playCardLevelChange_Lorentz(newCardInfoMo)
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundDownRank(index, oldSkillId)
	local cardItem = self._cardItemList[index]

	if cardItem and not cardItem:isDeviceAreaCard() then
		local lockGO = gohelper.findChild(cardItem.parentGo, "lock")

		gohelper.setActive(lockGO, false)
		cardItem:playCardLevelChange(nil, oldSkillId)
	end
end

function FightViewWaitingAreaVersion1:_onCardLevelChangeDone(cardInfo)
	if self._cardItemList then
		for i, v in ipairs(self._cardItemList) do
			if not v:isDeviceAreaCard() and v._cardInfoMO == cardInfo and i > FightPlayCardModel.instance:getCurIndex() then
				local lockGO = gohelper.findChild(v.parentGo, "lock")

				FightViewHandCardItemLock.setCardLock(cardInfo.uid, cardInfo.skillId, lockGO, false)

				break
			end
		end
	end
end

function FightViewWaitingAreaVersion1:_onPlayCardAroundSetGray(index)
	local cardItem = self._cardItemList[index]

	if cardItem and not cardItem:isDeviceAreaCard() then
		cardItem:playCardAroundSetGray()
	end
end

function FightViewWaitingAreaVersion1:getCardItemList()
	return self._cardItemList
end

return FightViewWaitingAreaVersion1
