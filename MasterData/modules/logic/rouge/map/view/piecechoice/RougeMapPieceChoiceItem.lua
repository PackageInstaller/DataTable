-- chunkname: @modules/logic/rouge/map/view/piecechoice/RougeMapPieceChoiceItem.lua

module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceItem", package.seeall)

local RougeMapPieceChoiceItem = class("RougeMapPieceChoiceItem", RougeMapChoiceBaseItem)

function RougeMapPieceChoiceItem:_editableInitView()
	RougeMapPieceChoiceItem.super._editableInitView(self)

	self._btnlockdetail2 = gohelper.findChildButtonWithAudio(self.go, "#go_locked/#btn_lockdetail2")
	self._simagelockcollection = gohelper.findChildSingleImage(self.go, "#go_locked/#btn_lockdetail2/#simage_collection")
	self._btnnormaldetail2 = gohelper.findChildButtonWithAudio(self.go, "#go_normal/#btn_normaldetail2")
	self._simagenormalcollection = gohelper.findChildSingleImage(self.go, "#go_normal/#btn_normaldetail2/#simage_collection")
	self._btnselectdetail2 = gohelper.findChildButtonWithAudio(self.go, "#go_select/#btn_selectdetail2")
	self._simageselectcollection = gohelper.findChildSingleImage(self.go, "#go_select/#btn_selectdetail2/#simage_collection")

	self._btnlockdetail2:AddClickListener(self.onClickCollection, self)
	self._btnnormaldetail2:AddClickListener(self.onClickCollection, self)
	self._btnselectdetail2:AddClickListener(self.onClickCollection, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChoiceItemStatusChange, self.onStatusChange, self)
end

function RougeMapPieceChoiceItem:onClickCollection()
	if not self:hadCollection() then
		return
	end

	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	self.collectionIdList = self.collectionIdList or {
		self.collectionId
	}

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClickPieceStoreDetail, self.collectionIdList)
end

function RougeMapPieceChoiceItem:onClickSelf()
	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	if self:canShowLockUI() then
		return
	end

	if self.viewEnum == RougeMapEnum.PieceChoiceViewStatus.Store then
		self:handleStoreChoice()

		return
	end

	self:handleNormalChoice()
end

function RougeMapPieceChoiceItem:handleNormalChoice()
	if self.status == RougeMapEnum.ChoiceStatus.Select then
		if self.choiceId == 0 then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
		else
			self.animator:Play("select", 0, 0)
			TaskDispatcher.cancelTask(self.onNormalChoiceSelectAnimDone, self)
			TaskDispatcher.runDelay(self.onNormalChoiceSelectAnimDone, self, RougeMapEnum.ChoiceSelectAnimDuration)
			UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
		end
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, self.dataId)
	end
end

function RougeMapPieceChoiceItem:onNormalChoiceSelectAnimDone()
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)

	local choiceCo = lua_rouge_piece_select.configDict[self.choiceId]
	local triggerType = choiceCo.triggerType

	if triggerType == RougeMapEnum.PieceTriggerType.Shop and self.pieceMo.triggerStr and self.pieceMo.triggerStr.repairShopCollections then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, self.pieceMo, self.choiceId)

		return
	elseif triggerType == RougeMapEnum.PieceTriggerType.EndFight and self.pieceMo.selectId and self.pieceMo.selectId ~= 0 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, self.pieceMo, self.choiceId)

		return
	end

	self:clearCallback()

	self.callbackId = RougeRpc.instance:sendRougePieceTalkSelectRequest(self.choiceId, self.onReceiveMsg, self)
end

function RougeMapPieceChoiceItem:onReceiveMsg()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, self.pieceMo, self.choiceId)
end

function RougeMapPieceChoiceItem:handleStoreChoice()
	if self.status == RougeMapEnum.ChoiceStatus.Select then
		self.animator:Play("select", 0, 0)
		TaskDispatcher.cancelTask(self.onStoreSelectAnimDone, self)
		TaskDispatcher.runDelay(self.onStoreSelectAnimDone, self, RougeMapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, self.dataId)
	end
end

function RougeMapPieceChoiceItem:onStoreSelectAnimDone()
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	self:clearCallback()

	self.callbackId = RougeRpc.instance:sendRougeRepairShopBuyRequest(self.collectionId, self.onReceiveBuyMsg, self)
end

function RougeMapPieceChoiceItem:onReceiveBuyMsg()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshChoiceStore)
end

function RougeMapPieceChoiceItem:onStatusChange(dataId)
	if self.status == RougeMapEnum.ChoiceStatus.Lock or self.status == RougeMapEnum.ChoiceStatus.Bought then
		return
	end

	local status = dataId and (dataId == self.dataId and RougeMapEnum.ChoiceStatus.Select or RougeMapEnum.ChoiceStatus.UnSelect) or RougeMapEnum.ChoiceStatus.Normal

	if status == self.status then
		return
	end

	self.status = status

	self:refreshUI()
end

function RougeMapPieceChoiceItem:update(choiceId, pos, pieceMo)
	RougeMapPieceChoiceItem.super.update(self, pos)

	self.viewEnum = RougeMapEnum.PieceChoiceViewStatus.Choice
	self.choiceId = choiceId
	self.dataId = choiceId
	self.pieceMo = pieceMo
	self.collectionIdList = nil

	if self.choiceId == 0 then
		local talkId = self.pieceMo.talkId
		local talkCo = lua_rouge_piece_talk.configDict[talkId]

		self.desc = talkCo.exitDesc
		self.title = ""
		self.collectionId = nil
	else
		self.choiceCo = lua_rouge_piece_select.configDict[choiceId]
		self.desc = self.choiceCo.content
		self.title = self.choiceCo.title
		self.collectionId = self.choiceCo.display
	end

	self.status = RougeMapPieceTriggerHelper.getChoiceStatus(pieceMo, choiceId)
	self.tip = RougeMapPieceTriggerHelper.getTip(self.pieceMo, self.choiceId, self.status)

	self:refreshUI()
	self:playUnlockAnim()
end

function RougeMapPieceChoiceItem:updateStoreGoods(collectionId, consumeCo, pos, pieceMo)
	RougeMapPieceChoiceItem.super.update(self, pos)

	self.collectionIdList = nil
	self.viewEnum = RougeMapEnum.PieceChoiceViewStatus.Store
	self.collectionId = collectionId
	self.dataId = collectionId
	self.consumeCo = consumeCo
	self.pieceMo = pieceMo
	self.consumeUnlockType = consumeCo.unlockType
	self.consumeUnlockParam = consumeCo.unlockParam
	self.boughtCollectionList = pieceMo.triggerStr.curBoughtRepairShopCollections

	self:initGoodsStatus()

	self.title = ""
	self.desc = self.consumeCo.desc
	self.tip = self:getGoodsTip()

	self:refreshUI()
end

function RougeMapPieceChoiceItem:initGoodsStatus()
	if tabletool.indexOf(self.boughtCollectionList, self.collectionId) then
		self.status = RougeMapEnum.ChoiceStatus.Bought

		return
	end

	local unlock = RougeMapUnlockHelper.checkIsUnlock(self.consumeUnlockType, self.consumeUnlockParam)

	if unlock then
		self.status = RougeMapEnum.ChoiceStatus.Normal or RougeMapEnum.ChoiceStatus.Lock
	end
end

function RougeMapPieceChoiceItem:getGoodsTip()
	if self.status == RougeMapEnum.ChoiceStatus.Bought then
		return ""
	end

	if self.status == RougeMapEnum.ChoiceStatus.Lock then
		return RougeMapUnlockHelper.getLockTips(self.consumeUnlockType, self.consumeUnlockParam)
	end

	return ""
end

function RougeMapPieceChoiceItem:canShowLockUI()
	return self.status == RougeMapEnum.ChoiceStatus.Lock or self.status == RougeMapEnum.ChoiceStatus.Bought
end

function RougeMapPieceChoiceItem:refreshLockUI()
	RougeMapPieceChoiceItem.super.refreshLockUI(self)
	self:refreshCollection(self._golockdetail2, self._simagelockcollection)
end

function RougeMapPieceChoiceItem:refreshNormalUI()
	RougeMapPieceChoiceItem.super.refreshNormalUI(self)
	self:refreshCollection(self._gonormaldetail2, self._simagenormalcollection)
end

function RougeMapPieceChoiceItem:refreshSelectUI()
	RougeMapPieceChoiceItem.super.refreshSelectUI(self)
	self:refreshCollection(self._goselectdetail2, self._simageselectcollection)
end

function RougeMapPieceChoiceItem:refreshCollection(go, simage)
	local hadCollection = self:hadCollection()

	gohelper.setActive(go, hadCollection)

	if hadCollection then
		simage:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))
	end
end

function RougeMapPieceChoiceItem:hadCollection()
	return self.collectionId and self.collectionId ~= 0
end

function RougeMapPieceChoiceItem:playUnlockAnim()
	if not self.choiceCo then
		return
	end

	local activeType = self.choiceCo.activeType

	if activeType == 0 then
		return
	end

	if RougeMapController.instance:checkPieceChoicePlayedUnlockAnim(self.choiceId) then
		return
	end

	if RougeMapUnlockHelper.checkIsUnlock(activeType, self.choiceCo.activeParam) then
		self.animator:Play("unlock", 0, 0)
		RougeMapController.instance:playedPieceChoiceEvent(self.choiceId)
	end
end

function RougeMapPieceChoiceItem:destroy()
	self._btnlockdetail2:RemoveClickListener()
	self._btnnormaldetail2:RemoveClickListener()
	self._btnselectdetail2:RemoveClickListener()
	self._simagenormalcollection:UnLoadImage()
	self._simageselectcollection:UnLoadImage()
	RougeMapPieceChoiceItem.super.destroy(self)
end

return RougeMapPieceChoiceItem
