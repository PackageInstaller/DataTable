-- chunkname: @modules/logic/fight/view/FightViewPlayCard.lua

module("modules.logic.fight.view.FightViewPlayCard", package.seeall)

local FightViewPlayCard = class("FightViewPlayCard", BaseView)

FightViewPlayCard.PlayCardWidth = 130
FightViewPlayCard.HalfCardWidth = FightViewPlayCard.PlayCardWidth / 2
FightViewPlayCard.VisibleCount = 9
FightViewPlayCard.HalfScrollWidth = 610
FightViewPlayCard.OffsetX = 1220 - FightViewPlayCard.PlayCardWidth * FightViewPlayCard.VisibleCount
FightViewPlayCard.OffsetHalfX = FightViewPlayCard.OffsetX / 2
FightViewPlayCard.LorenzCardWidth = 80

function FightViewPlayCard:onInitView()
	self._playCardGO = gohelper.findChild(self.viewGO, "root/playcards")
	self._playCardTr = self._playCardGO.transform
	self._scrollViewObj = gohelper.findChild(self.viewGO, "root/playcards/#scroll_cards")
	self._scrollView = gohelper.onceAddComponent(self._scrollViewObj, gohelper.Type_ScrollRect)
	self._playCardItemRoot = gohelper.findChild(self.viewGO, "root/playcards/#scroll_cards/Viewport/Content")
	self._playCardItemTransform = self._playCardItemRoot.transform
	self._playCardItemPrefab = gohelper.findChild(self.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem")

	gohelper.setActive(self._playCardItemPrefab, false)

	self._playCardItemList = {}
	self._resetCardFlow = FlowSequence.New()

	self._resetCardFlow:addWork(FightCardResetEffect.New())
	FightDataHelper.operationDataMgr:clearBeginRoundData()
end

function FightViewPlayCard:addEvents()
	return
end

function FightViewPlayCard:removeEvents()
	return
end

function FightViewPlayCard:onOpen()
	self.addEventCb(self, FightController.instance, FightEvent.ForceRefreshOperationArea, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelOperation, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.DistributeCards, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.PushCardInfo, self.onPushCardInfo, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRevertCard, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self._onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnAddActPoint, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEffectExtraMoveAct, self.onAddExtraMoveAct, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRestartFightDisposeDone, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSwitchPlaneClearAssetDone, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._refreshAllItemData, self)
	self.addEventCb(self, FightController.instance, FightEvent.ShowPlayCardEffect, self._showPlayCardEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.ShowPlayCardFlyEffect, self._onShowPlayCardFlyEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddPlayOperationData, self._onAddPlayOperationData, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayOperationEffectDone, self._onPlayOperationEffectDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.onNoActCostMoveFlowOver, self._onNoActCostMoveFlowOver, self)
	self.addEventCb(self, FightController.instance, FightEvent.CorrectPlayCardVisible, self.refreshPlayCardTrPosAndWidth, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleBackPack, self.OnBackPackClick, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshPlayCardRoundOp, self._onRefreshPlayCardRoundOp, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayCardFlowDone, self._onPlayCardFlowDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.PlayCardFlayFinish, self._onPlayCardFlayFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayAssistBossCardFlowDone, self._onPlayAssistBossCardDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayRouge2MusicCardFlowDone, self._onPlayRouge2MusicCardFlowDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.EnterOperateState, self._onEnterOperateState, self)
	self.addEventCb(self, FightController.instance, FightEvent.ExitOperateState, self._onExitOperateState, self)
	self.addEventCb(self, FightController.instance, FightEvent.HidePlayCardAllCard, self._onHidePlayCardAllCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforeCancelOperation, self.onBeforeCancelOperation, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshRecordSkill, self.onRefreshRecordSkill, self)
	self:createExtraMoveItem()
	self:refreshAllItemPos()
end

function FightViewPlayCard:onPushCardInfo()
	self:createExtraMoveItem()
	self:_refreshAllItemData()
end

function FightViewPlayCard:onAddExtraMoveAct()
	self:createExtraMoveItem()
	self:refreshAllItemPos()
end

function FightViewPlayCard:onStageChanged(stage)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if stage == FightStageMgr.StageType.Play then
		gohelper.setActive(self._playCardGO, false)
	end
end

function FightViewPlayCard:_onEnterOperateState(state)
	if state == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(self._playCardGO, false)
	end
end

function FightViewPlayCard:_onExitOperateState(state)
	if state == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(self._playCardGO, true)
	end
end

function FightViewPlayCard:onClose()
	TaskDispatcher.cancelTask(self._resetScrollView, self)

	self.extraMoveItem = nil

	self._resetCardFlow:unregisterDoneListener(self._onResetEffectDone, self)
	self._resetCardFlow:stop()
	FightDataHelper.operationDataMgr:clearBeginRoundData()
	self:_releaseAllFlyItems()
end

function FightViewPlayCard.isVisible(index, count, contentX)
	local posX = FightViewPlayCard.calcCardPosX(index, count)

	posX = posX + contentX

	local absPosX = math.abs(posX)

	return absPosX + FightViewPlayCard.HalfCardWidth <= FightViewPlayCard.HalfScrollWidth and absPosX - FightViewPlayCard.HalfCardWidth <= FightViewPlayCard.HalfScrollWidth
end

function FightViewPlayCard:OnBackPackClick()
	if self._playCardItemList then
		for i, v in pairs(self._playCardItemList) do
			if v then
				v:_onClickThis()
				FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

				return
			end
		end
	end
end

function FightViewPlayCard.calContentPosX(index, count, contentX)
	if count <= FightViewPlayCard.VisibleCount then
		return 0
	end

	local tarPosX = FightViewPlayCard.calcCardPosX(index, count)
	local visible = FightViewPlayCard.isVisible(index, count, contentX)

	if count - index <= 2 then
		local posX = -((count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth)

		posX = posX + FightViewPlayCard.OffsetHalfX

		return posX
	elseif visible then
		if not FightViewPlayCard.isVisible(index + 2, count, contentX) then
			local posX = -(count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth + (count - (index + 2)) * FightViewPlayCard.PlayCardWidth

			posX = posX - FightViewPlayCard.OffsetHalfX

			return posX
		else
			return contentX
		end
	elseif tarPosX < 0 then
		local posX = (count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth - (index - 1) * FightViewPlayCard.PlayCardWidth

		posX = posX - FightViewPlayCard.OffsetHalfX

		return posX
	else
		local posX = -(count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth + (count - (index + 2)) * FightViewPlayCard.PlayCardWidth

		posX = posX - FightViewPlayCard.OffsetHalfX

		return posX
	end

	return 0
end

function FightViewPlayCard:_resetScrollView()
	self._scrollView.enabled = true
end

function FightViewPlayCard:onRefreshRecordSkill()
	self:refreshAllItemPos()
end

function FightViewPlayCard:showLorenzRecordSkill()
	if not self.lorenzRecordCardItem then
		local go = gohelper.findChild(self.viewGO, "root/playcards/#go_lorentz_smallcardslot")

		go = gohelper.clone(go, self._playCardItemRoot)
		self.lorenzRecordCardItem = FightLorenzCardItem.Create(go)
	end

	self.lorenzRecordCardItem:updateSkill()
	self.lorenzRecordCardItem:show()
end

function FightViewPlayCard:hideLorenzRecordSkill()
	if not self.lorenzRecordCardItem then
		return
	end

	self.lorenzRecordCardItem:hide()
end

function FightViewPlayCard:_onAddPlayOperationData(round_op)
	if not round_op then
		return
	end

	self:recordPlayData(round_op)

	self._scrollView.enabled = false

	TaskDispatcher.cancelTask(self._resetScrollView, self)
	TaskDispatcher.runDelay(self._resetScrollView, self, 1)

	local count = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()

	if count > FightViewPlayCard.VisibleCount then
		if FightCardDataHelper.isNoCostSpecialCard(round_op.cardInfoMO) then
			return
		end

		local index = FightDataHelper.operationDataMgr:getShowIndex(round_op)
		local itemObj = self._playCardItemList[index]

		if not itemObj then
			return
		end

		local offset = gohelper.fitScrollItemOffset(self._scrollViewObj, self._playCardItemRoot, itemObj.go, ScrollEnum.ScrollDirH)

		if offset > 0 then
			local posX = (count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth - (index - 1) * FightViewPlayCard.PlayCardWidth

			posX = posX - FightViewPlayCard.OffsetHalfX

			recthelper.setAnchorX(self._playCardItemTransform, posX)
		elseif count - index <= 2 then
			local posX = -((count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth)

			posX = posX + FightViewPlayCard.OffsetHalfX

			recthelper.setAnchorX(self._playCardItemTransform, posX)
		else
			local checkIndex = index + 2
			local checkObj = self._playCardItemList[checkIndex]

			if not checkObj then
				return
			end

			offset = gohelper.fitScrollItemOffset(self._scrollViewObj, self._playCardItemRoot, checkObj.go, ScrollEnum.ScrollDirH)

			if offset ~= 0 then
				local posX = -(count - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth + (count - checkIndex) * FightViewPlayCard.PlayCardWidth

				posX = posX - FightViewPlayCard.OffsetHalfX

				recthelper.setAnchorX(self._playCardItemTransform, posX)
			end
		end
	else
		self:refreshPlayCardTrPosAndWidth(count)
	end
end

function FightViewPlayCard.getMaxItemCount()
	local showPlayItemCount = FightDataHelper.operationDataMgr.actPoint
	local noActPlayCardCount = 0
	local opActList = FightDataHelper.operationDataMgr:getShowOpActList()

	for i, op in ipairs(opActList) do
		if op:isPlayCard() and op.costActPoint == 0 then
			showPlayItemCount = showPlayItemCount + 1
			noActPlayCardCount = noActPlayCardCount + 1
		end

		if op:isPlayCard() and op:needCopyCard() then
			showPlayItemCount = showPlayItemCount + 1
			noActPlayCardCount = noActPlayCardCount + 1
		end

		if op:isAssistBossPlayCard() then
			showPlayItemCount = showPlayItemCount + 1
			noActPlayCardCount = noActPlayCardCount + 1
		end

		if op:isPlayerFinisherSkill() then
			showPlayItemCount = showPlayItemCount + 1
			noActPlayCardCount = noActPlayCardCount + 1
		end

		if op:isBloodPoolSkill() then
			showPlayItemCount = showPlayItemCount + 1
			noActPlayCardCount = noActPlayCardCount + 1
		end

		if op:isRouge2MusicSkill() then
			showPlayItemCount = showPlayItemCount + 1
			noActPlayCardCount = noActPlayCardCount + 1
		end
	end

	return showPlayItemCount, noActPlayCardCount
end

function FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()
	local showPlayItemCount, noActPlayCardCount = FightViewPlayCard.getMaxItemCount()

	showPlayItemCount = FightViewPlayCard.addExtraMoveActToShowPlayItemCount(showPlayItemCount)

	return showPlayItemCount, noActPlayCardCount
end

function FightViewPlayCard.addExtraMoveActToShowPlayItemCount(showPlayItemCount)
	local extraMoveActCount = FightDataHelper.operationDataMgr.extraMoveAct

	if extraMoveActCount > 0 then
		showPlayItemCount = showPlayItemCount + extraMoveActCount
	end

	return showPlayItemCount
end

function FightViewPlayCard:updateCardItemPreLv()
	self.effectTagCountDict = self.effectTagCountDict or {}

	tabletool.clear(self.effectTagCountDict)

	local opList = FightDataHelper.operationDataMgr:getOpList()

	for i = 1, #opList do
		local op = opList[i]

		if op:isPlayCard() then
			local skillId = op.skillId

			if not FightCardDataHelper.isBigSkill(skillId) then
				local skillCo = skillId and lua_skill.configDict[skillId]
				local effectTag = skillCo and skillCo.effectTag

				if effectTag then
					local existCount = self.effectTagCountDict[effectTag]

					self.effectTagCountDict[effectTag] = existCount and existCount + 1 or 1
				end
			end
		end
	end

	for i, cardItem in ipairs(self._playCardItemList) do
		self:updateOneCardItemCardPreLv(cardItem)
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshPreLv, self.effectTagCountDict)
end

function FightViewPlayCard:updateOneCardItemCardPreLv(cardItem)
	local op = cardItem and cardItem.fightBeginRoundOp

	if not op then
		cardItem:setPreLv(0)

		return
	end

	local belongUid = op.belongToEntityId
	local entityMo = FightDataHelper.entityMgr:getById(belongUid)

	if not entityMo then
		cardItem:setPreLv(0)

		return
	end

	local skillId = op.skillId
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

	local curSkillEffectTag = curSkillCo.effectTag
	local count = 0

	for _, effectTag in ipairs(canUpEffectTagList) do
		local existCount = self.effectTagCountDict[effectTag]

		if existCount then
			count = count + existCount

			if curSkillEffectTag == effectTag then
				count = count - 1
			end
		end
	end

	cardItem:setPreLv(count)
end

function FightViewPlayCard:_refreshAllItemData()
	self:_clearAllItemData()
	self:refreshAllItemPosIfEmptyCreate()

	local opActList = FightDataHelper.operationDataMgr:getShowOpActList()

	for _, op in ipairs(opActList) do
		self:recordPlayData(op)
		self:_refreshPlayOperationData(op)

		if not string.nilorempty(op.cardParam1) then
			FightDataHelper.operationDataMgr:setLorenzRecordSkillDepend(op)
			FightDataHelper.operationDataMgr:setLorenzRecordSkillId(op.cardParam1_skillId)
			self:onRefreshRecordSkill()
		end
	end

	self:_refreshSeasonArrowShow()
	FightDataHelper.operationDataMgr:clearAllRecordRoundData()
	self:checkDispatchEvent(opActList[#opActList])
end

function FightViewPlayCard:refreshPlayCardTrPosAndWidth(itemCount)
	itemCount = itemCount or FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()

	if itemCount <= FightViewPlayCard.VisibleCount then
		recthelper.setAnchorX(self._playCardItemTransform, 0)
	else
		local anchorX = (itemCount - FightViewPlayCard.VisibleCount) * FightViewPlayCard.HalfCardWidth - FightViewPlayCard.OffsetHalfX

		recthelper.setAnchorX(self._playCardItemTransform, anchorX)
	end

	local width = FightViewPlayCard.getPlayCardRootWidth(itemCount)

	recthelper.setWidth(self._playCardItemTransform, width)
end

function FightViewPlayCard:recordPlayData(round_op)
	if not round_op then
		return
	end

	if not FightDataHelper.operationDataMgr:canShowOpAct(round_op) then
		return
	end

	if FightCardDataHelper.checkOpAsPlayCardHandle(round_op) then
		FightDataHelper.operationDataMgr:addBeginRoundOp(round_op)
	elseif round_op:isMoveCard() then
		local extraMoveAct = FightDataHelper.operationDataMgr.extraMoveAct
		local extraMoveRoundOpList = FightDataHelper.operationDataMgr:getExtraMoveRoundOpList()

		if extraMoveAct > 0 and extraMoveAct > #extraMoveRoundOpList then
			FightDataHelper.operationDataMgr:addExtraMoveRoundOp(round_op)
		else
			FightDataHelper.operationDataMgr:addBeginRoundOp(round_op)
		end
	end

	FightDataHelper.operationDataMgr:addAllRecordRoundOp(round_op)
end

function FightViewPlayCard:removeListValue(list, value)
	if not list then
		return
	end

	for i, v in ipairs(list) do
		if v == value then
			table.remove(list, i)

			return i
		end
	end
end

function FightViewPlayCard:checkDispatchEvent(round_op)
	local allRecordOpList = FightDataHelper.operationDataMgr:getAllRecordOpList()

	if #allRecordOpList == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone, round_op)
	end
end

function FightViewPlayCard:_onPlayOperationEffectDone(round_op)
	self:_refreshPlayOperationData(round_op)
	self:_refreshSeasonArrowShow()

	local removeIndex = FightDataHelper.operationDataMgr:removeAllRecordRoundOp(round_op)

	if removeIndex then
		self:checkDispatchEvent(round_op)
	end
end

function FightViewPlayCard:_onPlayCardFlayFinish(round_op)
	return
end

function FightViewPlayCard:_onPlayCardFlowDone(round_op)
	local removeIndex = FightDataHelper.operationDataMgr:removeAllRecordRoundOp(round_op)

	if removeIndex then
		self:checkDispatchEvent(round_op)
	end
end

function FightViewPlayCard:_onPlayAssistBossCardDone(round_op)
	local removeIndex = FightDataHelper.operationDataMgr:removeAllRecordRoundOp(round_op)

	if removeIndex then
		self:checkDispatchEvent(round_op)
	end
end

function FightViewPlayCard:_onPlayRouge2MusicCardFlowDone(round_op)
	local removeIndex = FightDataHelper.operationDataMgr:removeAllRecordRoundOp(round_op)

	if removeIndex then
		self:checkDispatchEvent(round_op)
	end

	local index = FightDataHelper.operationDataMgr:getShowIndex(round_op)
	local playCardItem = index and self._playCardItemList[index]

	if not playCardItem then
		return
	end

	playCardItem:checkPlayAddRouge2MusicEffect()
end

function FightViewPlayCard:_onRefreshPlayCardRoundOp(round_op)
	self:_refreshPlayOperationData(round_op)
	self:_refreshSeasonArrowShow()
end

function FightViewPlayCard:_refreshSeasonArrowShow()
	if not FightModel.instance:isSeason2() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	local showPlayItemCount = FightViewPlayCard.getMaxItemCount()
	local findNowAct = false

	for i = 1, showPlayItemCount do
		local playCardItem = self._playCardItemList[i]

		if playCardItem and not playCardItem.fightBeginRoundOp then
			if not findNowAct then
				playCardItem:refreshSeasonArrowShow(true)

				findNowAct = true
			else
				playCardItem:refreshSeasonArrowShow(false)
			end
		end
	end
end

function FightViewPlayCard:_refreshPlayOperationData(round_op)
	local refresh_index = FightDataHelper.operationDataMgr:getShowIndex(round_op)

	if refresh_index then
		self:_refreshItemData(refresh_index, round_op)

		return
	end

	local extraMoveRoundOpList = FightDataHelper.operationDataMgr:getExtraMoveRoundOpList()
	local find = tabletool.indexOf(extraMoveRoundOpList, round_op)

	if find then
		self:refreshExtraMoveItem()

		return
	end
end

function FightViewPlayCard:_refreshItemData(refresh_index, round_op)
	local playCardItem = self._playCardItemList[refresh_index]

	if not playCardItem then
		self:refreshAllItemPosIfEmptyCreate()

		playCardItem = self._playCardItemList[refresh_index]
	end

	if not playCardItem then
		local totalCount = FightViewPlayCard.getMaxItemCount()
		local str = string.format("刷新出牌区出错,想要刷新下标:%d,但是当前总可用牌区点数为:%d", refresh_index, totalCount)

		logError(str)

		if refresh_index <= totalCount then
			self:_refreshAllItemData()
		end

		return
	end

	gohelper.setActive(playCardItem.go, true)
	playCardItem:updateItem(round_op)
	self:updateCardItemPreLv()

	if round_op and round_op:needCopyCard() then
		self:refreshAllItemPosIfEmptyCreate()

		playCardItem = self._playCardItemList[refresh_index + 1]

		gohelper.setActive(self._playCardItemList[refresh_index + 1].go, true)
		playCardItem:updateItem(round_op)
		playCardItem:setCopyCard()
	end
end

function FightViewPlayCard:_createNewPlayItemObj(index)
	for i = 1, index do
		local playCardItem = self._playCardItemList[i]

		if not playCardItem then
			local playCardGO = gohelper.clone(self._playCardItemPrefab, self._playCardItemRoot, "cardItem" .. index)

			playCardItem = MonoHelper.addNoUpdateLuaComOnceToGo(playCardGO, FightViewPlayCardItem)

			playCardItem:hideExtMoveEffect()

			playCardItem.PARENTVIEW = self
			self._playCardItemList[i] = playCardItem

			self:_refreshItemData(i, nil)
		end
	end

	return self._playCardItemList[index]
end

function FightViewPlayCard:_onHidePlayCardAllCard()
	self:_hideAllCard()
end

function FightViewPlayCard:_hideAllCard()
	for i, v in ipairs(self._playCardItemList) do
		gohelper.setActive(v._innerGO, false)
	end
end

function FightViewPlayCard:refreshRankUpDown()
	local changeIndex = {}

	for i, v in ipairs(self._playCardItemList) do
		local playCardItem = self._playCardItemList[i]
		local playData = playCardItem.fightBeginRoundOp

		if playData and playData:isPlayCard() then
			local skillConfig = lua_skill.configDict[playData.skillId]

			if skillConfig then
				for b_start = 1, FightEnum.MaxBehavior do
					local behavior = skillConfig["behavior" .. b_start]

					if behavior then
						local arr = FightStrUtil.instance:getSplitCache(behavior, "#")

						if arr[1] == "60075" then
							local f_change = arr[2] ~= "0"
							local b_change = arr[3] ~= "0"

							if f_change then
								for f_index = i - 1, 1, -1 do
									local f_cardItem = self._playCardItemList[f_index]
									local f_playData = f_cardItem.fightBeginRoundOp

									if f_playData and f_playData:isPlayCard() then
										changeIndex[f_index] = changeIndex[f_index] or {}

										local num = tonumber(arr[2])

										table.insert(changeIndex[f_index], num > 0 and "Up" or "Down")

										break
									end
								end
							end

							if b_change then
								for b_index = i + 1, #self._playCardItemList do
									local b_cardItem = self._playCardItemList[b_index]
									local b_playData = b_cardItem and b_cardItem.fightBeginRoundOp

									if b_playData and b_playData:isPlayCard() then
										changeIndex[b_index] = changeIndex[b_index] or {}

										local num = tonumber(arr[3])

										table.insert(changeIndex[b_index], num > 0 and "Up" or "Down")

										break
									end
								end
							end
						end
					end
				end
			end
		end
	end

	for i, cardItem in ipairs(self._playCardItemList) do
		local changeData = changeIndex[i]

		gohelper.setActive(cardItem.rankChangeRoot, changeData)

		if changeData then
			local showStr = "#go_" .. table.concat(changeData)
			local rankRoot = cardItem.rankChangeRoot.transform
			local childCount = rankRoot.childCount

			for index = 0, childCount - 1 do
				local child = rankRoot:GetChild(index).gameObject

				gohelper.setActive(child, child.name == showStr)
			end
		end
	end
end

function FightViewPlayCard:_clearAllItemData()
	for i = 1, #self._playCardItemList do
		local playCardItem = self._playCardItemList[i]

		playCardItem:updateItem(nil)
	end

	FightDataHelper.operationDataMgr:clearBeginRoundData()
end

function FightViewPlayCard:_onNoActCostMoveFlowOver()
	self:refreshAllItemPosIfEmptyCreate()
end

function FightViewPlayCard:_onShowPlayCardFlyEffect(card_mo, card_obj, fightBeginRoundOp)
	self._fly_items = self._fly_items or {}
	self.op2FlyItemDict = self.op2FlyItemDict or {}

	local class = FightCardPlayFlyEffect.New(self, card_mo, card_obj, fightBeginRoundOp)

	table.insert(self._fly_items, class)
	FightDataHelper.operationDataMgr:setOpIsFlying(fightBeginRoundOp, true)
	class:_startFly()
end

function FightViewPlayCard:onFlyDone(class)
	if self._fly_items then
		for i, v in ipairs(self._fly_items) do
			if v == class then
				table.remove(self._fly_items, i)

				break
			end
		end
	end

	FightDataHelper.operationDataMgr:setOpIsFlying(class._fightBeginRoundOp, nil)
end

function FightViewPlayCard:_releaseAllFlyItems()
	if self._fly_items then
		for i, v in ipairs(self._fly_items) do
			v:releaseSelf()
		end
	end

	self._fly_items = nil
end

function FightViewPlayCard:_showPlayCardEffect(cardInfoMO, toPlayCardIndex, tailEffectGO)
	local playCardItem = self._playCardItemList[toPlayCardIndex]

	if playCardItem and cardInfoMO then
		playCardItem:showPlayCardEffect(cardInfoMO, tailEffectGO)
	end
end

function FightViewPlayCard:onBeforeCancelOperation()
	self.curIndex2OriginHandCardIndex = {}

	for i, cardData in ipairs(FightDataHelper.handCardMgr.handCard) do
		self.curIndex2OriginHandCardIndex[i] = cardData.originHandCardIndex
	end
end

function FightViewPlayCard:_onResetCard(oldCardOps)
	self:_releaseAllFlyItems()
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	local context = self:getUserDataTb_()

	context.view = self
	context.viewGO = self.viewGO
	context.playCardItemList = self._playCardItemList
	context.oldCardOps = oldCardOps
	context.curIndex2OriginHandCardIndex = self.curIndex2OriginHandCardIndex
	self.curIndex2OriginHandCardIndex = nil

	self:_hideRankChangeEffect()
	self._resetCardFlow:registerDoneListener(self._onResetEffectDone, self)
	self._resetCardFlow:start(context)
end

function FightViewPlayCard:_hideRankChangeEffect()
	for i, cardItem in ipairs(self._playCardItemList) do
		gohelper.setActive(cardItem.rankChangeRoot, false)
	end
end

function FightViewPlayCard:_onResetEffectDone()
	self:_clearAllItemData()
	self:refreshAllItemPosIfEmptyCreate()
	self._resetCardFlow:unregisterDoneListener(self._onResetEffectDone, self)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
end

function FightViewPlayCard:refreshAllItemPosIfEmptyCreate()
	local showPlayItemCount = FightViewPlayCard.getMaxItemCount()
	local totalCount = FightViewPlayCard.addExtraMoveActToShowPlayItemCount(showPlayItemCount)

	self:refreshPlayCardTrPosAndWidth(totalCount)
	self:refreshExtraMoveItem()

	for i = 1, showPlayItemCount do
		local playCardItem = self._playCardItemList[i]

		playCardItem = playCardItem or self:_createNewPlayItemObj(i)

		gohelper.setActive(playCardItem.go, true)

		local posX, posY = FightViewPlayCard.calcCardPosX(i, totalCount)

		recthelper.setAnchor(playCardItem.tr, posX, posY)
	end

	for i = showPlayItemCount + 1, #self._playCardItemList do
		local playCardItem = self._playCardItemList[i]

		if playCardItem then
			playCardItem:updateItem(nil)
			gohelper.setActive(playCardItem.go, false)
		end
	end

	self:refreshLorentzAnchor()
end

function FightViewPlayCard:refreshAllItemPos()
	local showPlayItemCount = FightViewPlayCard.getMaxItemCount()
	local totalItemCount = FightViewPlayCard.addExtraMoveActToShowPlayItemCount(showPlayItemCount)

	self:refreshPlayCardTrPosAndWidth(totalItemCount)
	self:refreshExtraMoveItem()

	for i = 1, showPlayItemCount do
		local playCardItem = self._playCardItemList[i]

		if not playCardItem then
			logError("调用此函数时，需要保证对应index的playCardItem不为空, 否则请使用refreshAllItemPosIfEmptyCreate函数")

			playCardItem = self:_createNewPlayItemObj(i)
		end

		gohelper.setActive(playCardItem.go, true)

		local posX, posY = FightViewPlayCard.calcCardPosX(i, totalItemCount)

		recthelper.setAnchor(playCardItem.tr, posX, posY)
	end

	for i = showPlayItemCount + 1, #self._playCardItemList do
		local playCardItem = self._playCardItemList[i]

		if playCardItem then
			playCardItem:updateItem(nil)
			gohelper.setActive(playCardItem.go, false)
		end
	end

	self:refreshLorentzAnchor()
end

function FightViewPlayCard:refreshLorentzAnchor()
	local totalItemCount = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()
	local dependOp = FightDataHelper.operationDataMgr:getLorenzRecordSkillDepend()

	if not dependOp then
		self:hideLorenzRecordSkill()
	else
		self:showLorenzRecordSkill()

		if self.lorenzRecordCardItem then
			local index = FightDataHelper.operationDataMgr:getShowIndex(dependOp)
			local posX, posY = FightViewPlayCard.calcLorenzCardPosX(index, totalItemCount)

			self.lorenzRecordCardItem:setAnchor(posX, posY)
		end
	end
end

function FightViewPlayCard:refreshExtraMoveItem()
	if not self.extraMoveItem then
		return
	end

	local active = FightDataHelper.operationDataMgr.extraMoveAct > 0

	gohelper.setActive(self.extraMoveItem.go, active)

	if active then
		local showPlayItemCount = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()
		local posX, posY = FightViewPlayCard.calcCardPosX(showPlayItemCount, showPlayItemCount)

		recthelper.setAnchor(self.extraMoveItem.tr, posX, posY)

		local extraMoveRoundOpList = FightDataHelper.operationDataMgr:getExtraMoveRoundOpList()
		local roundOp = extraMoveRoundOpList[1]

		if roundOp and roundOp:isMoveCard() then
			self.extraMoveItem:updateItem(roundOp)
			self.extraMoveItem:hideExtMoveEffect()
		else
			self.extraMoveItem:updateItem(nil)
			self.extraMoveItem:showExtMoveEffect()
		end
	end
end

function FightViewPlayCard:createExtraMoveItem()
	local act = FightDataHelper.operationDataMgr.extraMoveAct

	if not act then
		return
	end

	if act < 1 then
		return
	end

	if self.extraMoveItem then
		return
	end

	local playCardGO = gohelper.clone(self._playCardItemPrefab, self._playCardItemRoot, "extraMoveItem")

	self.extraMoveItem = MonoHelper.addNoUpdateLuaComOnceToGo(playCardGO, FightViewPlayCardItem)

	self.extraMoveItem:updateItem(nil)
	self.extraMoveItem:showExtMoveEffect()
end

function FightViewPlayCard.getPlayCardRootWidth(itemCount)
	local width = itemCount * FightViewPlayCard.PlayCardWidth
	local dependOp = FightDataHelper.operationDataMgr:getLorenzRecordSkillDepend()

	if dependOp then
		width = width + FightViewPlayCard.LorenzCardWidth
	end

	return width
end

function FightViewPlayCard.calcCardPosX(cardIndex, cardCount)
	local playCardItemRootWidth = FightViewPlayCard.getPlayCardRootWidth(cardCount)
	local halfWidth = playCardItemRootWidth / 2
	local startAnchorPos = -halfWidth - FightViewPlayCard.HalfCardWidth
	local posX = startAnchorPos + FightViewPlayCard.PlayCardWidth * cardIndex
	local posY = 2
	local dependRoundOp = FightDataHelper.operationDataMgr:getLorenzRecordSkillDepend()

	if not dependRoundOp then
		return posX, posY
	end

	local dependIndex = FightDataHelper.operationDataMgr:getShowIndex(dependRoundOp)

	if cardIndex <= dependIndex then
		return posX, posY
	end

	return posX + FightViewPlayCard.LorenzCardWidth, posY
end

function FightViewPlayCard.calcLorenzCardPosX(cardIndex, cardCount)
	local posX, posY = FightViewPlayCard.calcCardPosX(cardIndex, cardCount)

	posX = posX + FightViewPlayCard.PlayCardWidth * 0.5
	posX = posX + FightViewPlayCard.LorenzCardWidth * 0.5

	return posX, posY
end

return FightViewPlayCard
