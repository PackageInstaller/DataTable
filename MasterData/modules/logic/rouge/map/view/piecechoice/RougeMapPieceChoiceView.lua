-- chunkname: @modules/logic/rouge/map/view/piecechoice/RougeMapPieceChoiceView.lua

module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceView", package.seeall)

local RougeMapPieceChoiceView = class("RougeMapPieceChoiceView", RougeMapChoiceBaseView)

function RougeMapPieceChoiceView:_editableInitView()
	self.goFullBg = gohelper.findChild(self.viewGO, "all_bg/#simage_FullBG")
	self.goEpisodeBg = gohelper.findChild(self.viewGO, "all_bg/#simage_EpisodeBG")

	gohelper.setActive(self.goFullBg, false)
	gohelper.setActive(self.goEpisodeBg, false)

	self._simageFrameBG = gohelper.findChildSingleImage(self.viewGO, "all_bg/#simage_FrameBG")

	self._simageFrameBG:LoadImage("singlebg/rouge/rouge_illustration_framebg.png")

	local optionItemResPath = self.viewContainer:getSetting().otherRes[2]

	self.goOptionItem = self.viewContainer:getResInst(optionItemResPath, self._gochoicecontainer)

	gohelper.setActive(self.goOptionItem, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, self.closeThis, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onRefreshPieceChoiceEvent, self.onRefreshPieceChoiceEvent, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onRefreshChoiceStore, self.onRefreshChoiceStore, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChoiceViewStatusChange, self.onChoiceViewStatusChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectPieceChoice, self.onSelectPieceChoice, self)
	RougeMapPieceChoiceView.super._editableInitView(self)
end

function RougeMapPieceChoiceView:onClickBlockOnFinishState()
	self:triggerHandle()
end

function RougeMapPieceChoiceView:onRefreshChoiceStore()
	self:noAnimRefreshRight()
end

function RougeMapPieceChoiceView:onRefreshPieceChoiceEvent()
	self:playAnimRefreshRight()
end

function RougeMapPieceChoiceView:onSelectPieceChoice(pieceMo, choiceId)
	if self.preSelectChoiceId == choiceId then
		RougeMapPieceTriggerHelper.triggerHandle(pieceMo, choiceId)

		return
	end

	local choiceCo = lua_rouge_piece_select.configDict[choiceId]
	local talkDesc = choiceCo and choiceCo.talkDesc

	self._selectPieceMo = pieceMo
	self._choiceId = choiceId
	self.preSelectChoiceId = choiceId

	if string.nilorempty(talkDesc) then
		self:triggerHandle()
	else
		self.startPlayDialogue(self, talkDesc, self.onSelectDialogueDone, self)
	end
end

function RougeMapPieceChoiceView:onSelectDialogueDone()
	if RougeMapHelper.isRestPiece(self._selectPieceMo.pieceCo.entrustType) then
		self:triggerHandle()

		return
	end

	self:changeState(RougeMapEnum.ChoiceViewState.Finish)
end

function RougeMapPieceChoiceView:triggerHandle()
	RougeMapPieceTriggerHelper.triggerHandle(self._selectPieceMo, self._choiceId)

	self._selectPieceMo = nil
	self._choiceId = nil

	self:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
end

function RougeMapPieceChoiceView:onChoiceViewStatusChange(status)
	self.viewStatus = status

	self:playAnimRefreshRight()
end

function RougeMapPieceChoiceView:initData()
	self.pieceMo = self.viewParam
	self.talkId = self.pieceMo.talkId
	self.talkCo = lua_rouge_piece_talk.configDict[self.talkId]
	self.preSelectChoiceId = 0
end

function RougeMapPieceChoiceView:onOpen()
	RougeMapPieceChoiceView.super.onOpen(self)
	self.viewContainer:setOverrideClose(self.exitCurView, self)

	self.viewStatus = RougeMapEnum.PieceChoiceViewStatus.Choice

	self:initData()
	self:refreshUI()
	self:refreshDesc()
end

function RougeMapPieceChoiceView:refreshUI()
	self._txtName.text = self.talkCo.title
	self._txtNameEn.text = ""
end

function RougeMapPieceChoiceView:refreshDesc()
	local desc = self.talkCo.content

	self.startPlayDialogue(self, desc, self.enterDialogueDone, self)
end

function RougeMapPieceChoiceView:enterDialogueDone()
	gohelper.setActive(self.goRight, true)
	gohelper.setActive(self.goLeft, true)
	self:playChoiceShowAnim()
	self:refreshChoice()
end

function RougeMapPieceChoiceView:playAnimRefreshRight()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	self.rightAnimator:Play("open", 0, 0)

	if self.viewStatus == RougeMapEnum.PieceChoiceViewStatus.Choice then
		self:refreshChoice()
	else
		self:refreshStoreGoods()
	end
end

function RougeMapPieceChoiceView:noAnimRefreshRight()
	if self.viewStatus == RougeMapEnum.PieceChoiceViewStatus.Choice then
		self:refreshChoice()
	else
		self:refreshStoreGoods()
	end
end

function RougeMapPieceChoiceView:refreshChoice()
	local selectIdStr = self.talkCo.selectIds
	local choiceIdList = string.splitToNumber(selectIdStr, "|")

	RougeMapHelper.filterUnActivePieceChoice(choiceIdList)
	table.insert(choiceIdList, 0)

	self.posList = RougeMapEnum.ChoiceItemPos[#choiceIdList]

	RougeMapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, RougeMapPieceChoiceItem, choiceIdList, self.choiceItemList, self.updateItem, self)

	if self.optionItem then
		self.optionItem:hide()
	end
end

function RougeMapPieceChoiceView:updateItem(item, index, choiceId)
	item:update(choiceId, self.posList[index], self.pieceMo)
end

function RougeMapPieceChoiceView:refreshStoreGoods()
	if self.pieceMo.triggerStr then
		if not self.pieceMo.triggerStr then
			logError("store goods is nil")

			return
		end

		self.collectionList = self.collectionList or {}
		self.consumeCoList = self.consumeCoList or {}

		tabletool.clear(self.collectionList)
		tabletool.clear(self.consumeCoList)

		for collectionId, consumeId in pairs(self.pieceMo.triggerStr) do
			collectionId = tonumber(collectionId)

			local consumeCo = lua_rouge_repair_shop_price.configDict[consumeId]

			table.insert(self.collectionList, collectionId)
			table.insert(self.consumeCoList, consumeCo)
		end

		local len = #self.collectionList + 1

		self.posList = RougeMapEnum.ChoiceItemPos[len]

		RougeMapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, RougeMapPieceChoiceItem, self.collectionList, self.choiceItemList, self.updateStoreGoods, self)

		if not self.optionItem then
			self.optionItem = RougeMapPieceOptionItem.New()

			self.optionItem:init(self.goOptionItem)
		end

		self.optionItem:show()
		self.optionItem:update(self.posList[len], self.pieceMo)
	end
end

function RougeMapPieceChoiceView:updateStoreGoods(item, index, collectionId)
	item:updateStoreGoods(collectionId, self.consumeCoList[index], self.posList[index], self.pieceMo)
end

function RougeMapPieceChoiceView:exitCurView()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function RougeMapPieceChoiceView:onDestroyView()
	if self.optionItem then
		self.optionItem:destroy()

		self.optionItem = nil
	end

	self._simageFrameBG:UnLoadImage()
	RougeMapPieceChoiceView.super.onDestroyView(self)
end

return RougeMapPieceChoiceView
