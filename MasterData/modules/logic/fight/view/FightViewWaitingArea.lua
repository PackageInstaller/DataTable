-- chunkname: @modules/logic/fight/view/FightViewWaitingArea.lua

module("modules.logic.fight.view.FightViewWaitingArea", package.seeall)

local FightViewWaitingArea = class("FightViewWaitingArea", BaseView)
local ItemWidth = 0

function FightViewWaitingArea:onInitView()
	self._waitingAreaTran = gohelper.findChild(self.viewGO, "root/waitingArea").transform
	self._waitingAreaGO = gohelper.findChild(self.viewGO, "root/waitingArea/inner")
	self._skillTipsGO = gohelper.findChild(self.viewGO, "root/waitingArea/inner/skill")
	self._txtCardTitle = gohelper.findChildText(self._skillTipsGO, "txtTips/txtTitle")
	self._txtCardDesc = gohelper.findChildText(self._skillTipsGO, "txtTips")
	self._rectTrCardDesc = self._txtCardDesc:GetComponent(gohelper.Type_RectTransform)
	self._cardItemList = {}
	self._cardItemGOList = self:getUserDataTb_()
	self._cardObjModel = gohelper.findChild(self._waitingAreaGO, "cardItemModel")

	local cardItemGO1 = gohelper.cloneInPlace(self._cardObjModel, "cardItem1")

	table.insert(self._cardItemGOList, cardItemGO1)

	ItemWidth = recthelper.getWidth(cardItemGO1.transform)

	local item1AnchorX = recthelper.getAnchorX(cardItemGO1.transform)

	for i = 2, 5 do
		local cardItemGO = gohelper.findChild(self._waitingAreaGO, "cardItem" .. i)

		cardItemGO = cardItemGO or gohelper.cloneInPlace(self._cardObjModel, "cardItem" .. i)

		table.insert(self._cardItemGOList, cardItemGO)
		recthelper.setAnchorX(cardItemGO.transform, item1AnchorX - 192 * (i - 1))
	end

	self._cardDisplayFlow = FlowSequence.New()

	self._cardDisplayFlow:addWork(FightCardDisplayEffect.New())

	self._cardDisplayEndFlow = FlowSequence.New()

	self._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())

	self._cardDissolveFlow = FlowSequence.New()

	self._cardDissolveFlow:addWork(FightCardDissolveEffect.New())

	self._cardDisappearFlow = FlowParallel.New()

	self._cardDisappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	self._cardDisappearFlow:addWork(FightCardDissolveEffect.New())

	self._changeCardFlow = FlowSequence.New()

	self._changeCardFlow:addWork(FightCardChangeEffectInWaitingArea.New())
	self:_refreshTipsVisibleState()
end

function FightViewWaitingArea:_refreshTipsVisibleState()
	gohelper.onceAddComponent(self._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function FightViewWaitingArea:onOpen()
	self:_makeTipsOutofSight()
	self.addEventCb(self, FightController.instance, FightEvent.UpdateWaitingArea, self._updateWaitingArea, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginRound, self._beginRoundSaveCardCantUse, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onEndRound, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._skillFinishSaveCardCantUse, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayChangeCardEffectInWaitingArea, self._playChangeCardEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.CardDisappear, self._onCardDisappear, self)
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._refreshTipsVisibleState, self)
end

function FightViewWaitingArea:onClose()
	self:_releaseScalseTween()
	self.removeEventCb(self, FightController.instance, FightEvent.UpdateWaitingArea, self._updateWaitingArea, self)
	self.removeEventCb(self, FightController.instance, FightEvent.RespBeginRound, self._beginRoundSaveCardCantUse, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onEndRound, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._skillFinishSaveCardCantUse, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.removeEventCb(self, FightController.instance, FightEvent.PlayChangeCardEffectInWaitingArea, self._playChangeCardEffect, self)
	self.removeEventCb(self, FightController.instance, FightEvent.CardDisappear, self._onCardDisappear, self)
	self.removeEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._refreshTipsVisibleState, self)
	self._cardDisplayFlow:stop()
	self._cardDisplayEndFlow:stop()
	self._cardDissolveFlow:stop()
	self._cardDisappearFlow:stop()
	self._changeCardFlow:stop()
	TaskDispatcher.cancelTask(self._delayPlayCardsChangeEffect, self)
	TaskDispatcher.cancelTask(self._delayPlayCardDisappear, self)
end

function FightViewWaitingArea:_fixWaitingAreaItemCount(count)
	if self._cardItemGOList then
		if count <= self._cardItemGOList then
			return
		end

		local cardItemGO1 = self._cardItemGOList[1]
		local item1AnchorX = recthelper.getAnchorX(cardItemGO1.transform)

		for i = self._cardItemGOList + 1, count do
			local cardItemGO = gohelper.findChild(self._waitingAreaGO, "cardItem" .. i)

			cardItemGO = cardItemGO or gohelper.cloneInPlace(self._cardObjModel, "cardItem" .. i)

			table.insert(self._cardItemGOList, cardItemGO)
			recthelper.setAnchorX(cardItemGO.transform, item1AnchorX - 192 * (i - 1))
		end
	end
end

function FightViewWaitingArea:_updateWaitingArea()
	self:_updateView()
end

function FightViewWaitingArea:_onEndRound()
	self:_makeTipsOutofSight()
end

function FightViewWaitingArea:_beginRoundSaveCardCantUse()
	self:_saveCantUseStatus()
end

function FightViewWaitingArea:_skillFinishSaveCardCantUse(entity, skillId, fightStepData)
	if not entity:isMySide() then
		return
	end

	self:_saveCantUseStatus()
end

function FightViewWaitingArea:_saveCantUseStatus()
	self._cardCantUseDict = {}

	local clientLeft = FightPlayCardModel.instance:getClientLeftSkillOpList()

	if #clientLeft == 0 then
		-- block empty
	end

	for i, displayMO in ipairs(clientLeft) do
		local entityMO = FightDataHelper.entityMgr:getById(displayMO.entityId)
		local isDead = entityMO and entityMO:isStatusDead()

		if entityMO then
			if not entityMO.exPoint then
				local exPoint = 0
				local maxExPoint = entityMO and entityMO:getUniqueSkillPoint() or 5
				local isBigSkill = entityMO and FightCardDataHelper.isBigSkill(displayMO.skillId)
				local isBigSkillInvalid = isBigSkill and exPoint < maxExPoint
				local canUseCard = FightViewHandCardItemLock.canUseCardSkill(displayMO.entityId, displayMO.skillId)

				if isDead or isBigSkillInvalid or not canUseCard then
					self._cardCantUseDict[displayMO] = true
				end
			end
		end
	end
end

function FightViewWaitingArea:_onCardDisappear()
	if self._dissapearCount then
		self._dissapearCount = self._dissapearCount + 1 or 1
	end

	TaskDispatcher.runDelay(self._delayPlayCardDisappear, self, 0.01)
end

function FightViewWaitingArea:_delayPlayCardDisappear()
	local context = {}

	context.dissolveSkillItemGOs = self:getUserDataTb_()
	context.hideSkillItemGOs = self:getUserDataTb_()

	local count = math.min(self._dissapearCount, #FightPlayCardModel.instance:getClientLeftSkillOpList())

	if count == 0 then
		self:_onDisappearCallback()

		return
	end

	for i = 1, count do
		local skillOps = FightPlayCardModel.instance:getClientLeftSkillOpList()
		local clientCount = #skillOps
		local displayMO = skillOps[clientCount]
		local entityId = displayMO.entityId
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if self._cardCantUseDict and self._cardCantUseDict[displayMO] then
			local cardGO = self._cardItemList[clientCount].go

			table.insert(context.dissolveSkillItemGOs, cardGO)

			local lockGO = gohelper.findChild(cardGO.transform.parent.gameObject, "lock")

			gohelper.setActive(lockGO, false)
		else
			table.insert(context.hideSkillItemGOs, self._cardItemList[clientCount].go)
		end

		FightPlayCardModel.instance:removeClientSkillOnce()
	end

	self._dissapearCount = nil

	self._cardDisappearFlow:registerDoneListener(self._onDisappearCallback, self)
	self._cardDisappearFlow:start(context)
end

function FightViewWaitingArea:_onDisappearCallback()
	FightController.instance:dispatchEvent(FightEvent.CardDisappearFinish)
end

function FightViewWaitingArea:_beforePlaySkill(entity, skillId, fightStepData)
	local leftSkillOpList = FightPlayCardModel.instance:getClientLeftSkillOpList()
	local count = #leftSkillOpList

	if count == 0 then
		FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, skillId)

		return
	end

	self._playingEntityId = entity.id
	self._playingSkillId = skillId
	self._displayingEntityId = nil
	self._displayingSkillId = nil

	self:_updateView()

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		if skillId == leftSkillOpList[count].skillId then
			self:_displayFlow(self._playingEntityId, self._playingSkillId)
			FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, skillId)
		elseif #leftSkillOpList > 0 then
			self:_dissolveFlow(self._onSkillPlayDissolveDone)
		else
			FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, skillId)
		end
	else
		FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, skillId)
	end
end

function FightViewWaitingArea:_onSkillPlayDissolveDone()
	local leftSkillOpList = FightPlayCardModel.instance:getClientLeftSkillOpList()
	local count = #leftSkillOpList

	if count > 0 then
		local first = leftSkillOpList[count]

		self:_displayFlow(first.entityId, first.skillId)
	end

	FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, self._playingSkillId)
end

function FightViewWaitingArea:_displayFlow(entityId, skillId)
	self._displayingEntityId = entityId
	self._displayingSkillId = skillId

	if self._cardDisplayEndFlow.status == WorkStatus.Running then
		self._cardDisplayEndFlow:stop()
		self._cardDisplayFlow:reset()
	end

	if self._cardDisplayFlow.status == WorkStatus.Running then
		self._cardDisplayFlow:stop()
		self._cardDisplayFlow:reset()
	end

	local count = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	local context = self:getUserDataTb_()

	context.skillTipsGO = self._skillTipsGO
	context.skillItemGO = self._cardItemList[count].go
	context.waitingAreaGO = self._waitingAreaGO

	self._cardDisplayFlow:start(context)
	FightPlayCardModel.instance:onPlayOneSkillId(self._displayingEntityId, self._displayingSkillId)
end

function FightViewWaitingArea:_dissolveFlow(callback)
	self._dissolveEndCallback = callback

	local context = {}

	context.dissolveSkillItemGOs = self:getUserDataTb_()

	local isMatch = false
	local clientCount = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	local serverCount = #FightPlayCardModel.instance:getServerLeftSkillOpList()

	while not isMatch and clientCount > 0 and serverCount <= clientCount do
		isMatch = FightPlayCardModel.instance:checkClientSkillMatch(self._playingEntityId, self._playingSkillId)

		if not isMatch then
			FightPlayCardModel.instance:removeClientSkillOnce()

			local cardGO = self._cardItemList[clientCount].go

			table.insert(context.dissolveSkillItemGOs, cardGO)

			local lockGO = gohelper.findChild(cardGO.transform.parent.gameObject, "lock")

			gohelper.setActive(lockGO, false)
		end

		clientCount = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	end

	self._cardDissolveFlow:registerDoneListener(self._onDissolveFlowDone, self)
	self._cardDissolveFlow:start(context)
end

function FightViewWaitingArea:_onDissolveFlowDone()
	self:_updateView()

	local callback = self._dissolveEndCallback

	self._dissolveEndCallback = nil

	if callback then
		self:_dissolveEndCallback()
	end
end

function FightViewWaitingArea:_onSkillPlayFinish(entity, skillId, fightStepData)
	if not self._displayingEntityId then
		return
	end

	if entity.id ~= self._displayingEntityId or skillId ~= self._displayingSkillId then
		return
	end

	local skillItemGO

	for i = #self._cardItemList, 1, -1 do
		local item = self._cardItemList[i]

		if item.go.activeSelf then
			skillItemGO = item.go

			break
		end
	end

	self._displayingEntityId = nil
	self._displayingSkillId = nil

	local context = self:getUserDataTb_()

	context.skillTipsGO = self._skillTipsGO
	context.skillItemGO = skillItemGO
	context.waitingAreaGO = self._waitingAreaGO
	context.param = {
		skillId = skillId
	}

	self._cardDisplayEndFlow:start(context)
end

function FightViewWaitingArea:_onBuffUpdate(entityId, effectType, buffId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO or entityMO.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local leftSkillOpList = FightPlayCardModel.instance:getClientLeftSkillOpList()

	for i = 1, #leftSkillOpList do
		local cardItem = self._cardItemList[i]

		if cardItem then
			self:_setCardLockEffect(cardItem, leftSkillOpList[i], i)
		end
	end
end

function FightViewWaitingArea:_makeTipsOutofSight()
	local skillTipsTr = self._skillTipsGO.transform

	recthelper.setAnchorX(skillTipsTr, 960 + recthelper.getWidth(skillTipsTr))
end

function FightViewWaitingArea:_updateView()
	local leftSkillOpList = FightPlayCardModel.instance:getClientLeftSkillOpList()
	local count = #leftSkillOpList

	gohelper.setActive(self._waitingAreaGO, count > 0)

	for i = 1, count do
		local cardItemGOParent = self._cardItemGOList[i]
		local entityId = leftSkillOpList[i].entityId
		local skillId = leftSkillOpList[i].skillId
		local cardItem = self._cardItemList[i]

		if not cardItem then
			local path = self.viewContainer:getSetting().otherRes[1]
			local cardItemGO = self:getResInst(path, cardItemGOParent, "card")

			gohelper.setAsFirstSibling(cardItemGO)

			cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardItemGO, FightViewCardItem, FightEnum.CardShowType.PlayCard)

			table.insert(self._cardItemList, cardItem)
		end

		transformhelper.setLocalScale(cardItem.tr, 1, 1, 1)
		recthelper.setAnchor(cardItem.tr, 0, 0)

		gohelper.onceAddComponent(cardItem.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(cardItem.go, true)
		cardItem:updateItem(entityId, skillId)

		cardItem.op = leftSkillOpList[i]

		self:_setCardLockEffect(cardItem, leftSkillOpList[i], i)
	end

	for i = count + 1, #self._cardItemList do
		local cardItem = self._cardItemList[i]
		local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

		gohelper.setActive(lockGO, false)
		gohelper.setActive(cardItem.go, false)
	end

	if leftSkillOpList[count] then
		local firstSkillId = leftSkillOpList[count].skillId

		if leftSkillOpList[count] then
			local entityId = leftSkillOpList[count].entityId
			local skillCO = firstSkillId and lua_skill.configDict[firstSkillId]
			local desc = FightConfig.instance:getEntitySkillDesc(entityId, skillCO, firstSkillId)

			if skillCO then
				self._txtCardTitle.text = skillCO.name or ""
			end

			self._txtCardDesc.text = skillCO and HeroSkillModel.instance:skillDesToSpot(desc) or ""

			self._txtCardDesc:ForceMeshUpdate(true, true)

			local renderValue = self._txtCardDesc:GetRenderedValues()
			local descHeight = renderValue.y
			local height = descHeight + 83

			recthelper.setHeight(self._rectTrCardDesc, descHeight)
			recthelper.setHeight(self._skillTipsGO.transform, height)
			self:_releaseScalseTween()

			if count > 7 then
				if not (1 - (count - 7) * 0.12) then
					local toScale = 1

					if toScale < 0 then
						toScale = 0.5
					end

					local skillScale = 1 / toScale

					transformhelper.setLocalScale(self._skillTipsGO.transform, skillScale, skillScale, skillScale)

					self._tweenScale = ZProj.TweenHelper.DOScale(self._waitingAreaTran, toScale, toScale, toScale, 0.1)
				end
			end
		end
	end
end

function FightViewWaitingArea:_releaseScalseTween()
	if self._tweenScale then
		ZProj.TweenHelper.KillById(self._tweenScale)

		self._tweenScale = nil
	end
end

function FightViewWaitingArea:_setCardLockEffect(cardItem, skillOp, index)
	local now = Time.time

	if self._unlockStartTime then
		if self._unlockStartTime and now - self._unlockStartTime < 1 then
			return
		end

		local lockGO = gohelper.findChild(cardItem.tr.parent.gameObject, "lock")

		FightViewHandCardItemLock.setCardLock(skillOp.entityId, skillOp.skillId, lockGO, false)

		local canUse = FightViewHandCardItemLock.canUseCardSkill(skillOp.entityId, skillOp.skillId)
		local serverOp = FightPlayCardModel.instance:getServerLeftSkillOpList()[index]
		local isPreRemove = not canUse and serverOp and serverOp.entityId == skillOp.entityId and serverOp.skillId == skillOp.skillId

		if isPreRemove then
			self._preRemoveState = self._preRemoveState or {}
			self._preRemoveState[skillOp] = true

			FightViewHandCardItemLock.setCardPreRemove(skillOp.entityId, skillOp.skillId, lockGO, false)
		end

		if canUse and self._preRemoveState and self._preRemoveState[skillOp] then
			gohelper.setActive(lockGO, true)
			FightViewHandCardItemLock.setCardUnLock(skillOp.entityId, skillOp.skillId, lockGO)

			self._preRemoveState[skillOp] = nil
			self._unlockStartTime = self._unlockStartTime or {}
			self._unlockStartTime[skillOp] = now
		end
	end
end

function FightViewWaitingArea:_playChangeCardEffect(changeInfos)
	self._changeInfos = self._changeInfos or {}

	tabletool.addValues(self._changeInfos, changeInfos)
	TaskDispatcher.cancelTask(self._delayPlayCardsChangeEffect, self)
	TaskDispatcher.runDelay(self._delayPlayCardsChangeEffect, self, 0.03)
end

function FightViewWaitingArea:_delayPlayCardsChangeEffect()
	local context = self:getUserDataTb_()

	context.changeInfos = self._changeInfos
	context.cardItemList = self._cardItemList

	self._changeCardFlow:registerDoneListener(self._onChangeCardDone, self)
	self._changeCardFlow:start(context)

	self._changeInfos = nil
end

function FightViewWaitingArea:_onChangeCardDone()
	self._changeCardFlow:unregisterDoneListener(self._onChangeCardDone, self)
	self:_updateView()
	FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
end

return FightViewWaitingArea
