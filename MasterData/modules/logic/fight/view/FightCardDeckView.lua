-- chunkname: @modules/logic/fight/view/FightCardDeckView.lua

module("modules.logic.fight.view.FightCardDeckView", package.seeall)

local FightCardDeckView = class("FightCardDeckView", BaseViewExtended)

function FightCardDeckView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self._btnCardBox = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_cardbox")
	self._cardBoxSelect = gohelper.findChild(self.viewGO, "topTab/#btn_cardbox/select")
	self._cardBoxUnselect = gohelper.findChild(self.viewGO, "topTab/#btn_cardbox/unselect")
	self._btnCardPre = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_cardpre")
	self._cardPreSelect = gohelper.findChild(self.viewGO, "topTab/#btn_cardpre/select")
	self._cardPreUnselect = gohelper.findChild(self.viewGO, "topTab/#btn_cardpre/unselect")
	self._btnDevice = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_device")
	self._deviceSelect = gohelper.findChild(self.viewGO, "topTab/#btn_device/select")
	self._deviceUnselect = gohelper.findChild(self.viewGO, "topTab/#btn_device/unselect")
	self._cardRoot = gohelper.findChild(self.viewGO, "layout/#scroll_card/Viewport/Content")
	self._cardItem = gohelper.findChild(self.viewGO, "layout/#scroll_card/Viewport/Content/#go_carditem")
	self._nameText = gohelper.findChildText(self.viewGO, "layout/#scroll_card/#txt_skillname")
	self._skillText = gohelper.findChildText(self.viewGO, "layout/#scroll_card/#scroll_skill/viewport/content/#txt_skilldec")
	self._cardMask = gohelper.findChild(self.viewGO, "layout/#scroll_card/Viewport").transform
	self.cardDataTabPool = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardDeckView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.GetFightCardDeckInfoReply, self._onGetFightCardDeckInfoReply, self)
	self.addClickCb(self, self._click, self._onViewClick, self)
end

function FightCardDeckView:removeEvents()
	return
end

function FightCardDeckView:_editableInitView()
	self._nameText.text = ""
	self._skillText.text = ""
end

function FightCardDeckView:_onViewClick()
	self:closeThis()
end

FightCardDeckView.SelectType = {
	Device = 3,
	PreCard = 2,
	CardBox = 1
}

function FightCardDeckView:onOpen()
	self._cardItemDic = {}

	if self.viewParam then
		self._selectType = self.viewParam.selectType or FightCardDeckView.SelectType.CardBox
	end

	local cardPath = "ui/viewres/fight/fightcarditem.prefab"

	self:com_loadAsset(cardPath, self._onCardLoadFinish)
	FightRpc.instance:sendGetFightCardDeckInfoRequest(FightRpc.DeckInfoRequestType.MySide)
end

local CanSelectTypeList = {}

function FightCardDeckView:_startRefreshUI()
	if not self.assetLoaded then
		return
	end

	if not self.replyMsg then
		return
	end

	tabletool.clear(CanSelectTypeList)

	if not FightHelper.allIsDeviceEntity() then
		table.insert(CanSelectTypeList, FightCardDeckView.SelectType.CardBox)
	end

	if FightDataHelper.hasDeviceArea() then
		table.insert(CanSelectTypeList, FightCardDeckView.SelectType.Device)
	end

	self._preCardList = FightHelper.getNextRoundGetCardList()

	if self._preCardList and #self._preCardList > 0 then
		table.insert(CanSelectTypeList, FightCardDeckView.SelectType.PreCard)
	end

	local findSelect = false

	for _, type in ipairs(CanSelectTypeList) do
		if type == self._selectType then
			findSelect = true

			break
		end
	end

	if not findSelect then
		self._selectType = CanSelectTypeList[1]
	end

	self:_refreshBtn()
	self:_refreshBtnState()
	self.addClickCb(self, self._btnCardBox, self._onCardBoxClick, self)
	self.addClickCb(self, self._btnCardPre, self._onCardPreClick, self)
	self.addClickCb(self, self._btnDevice, self._onDeviceClick, self)
	self:_refreshUI()
end

function FightCardDeckView:_onCardBoxClick()
	self._selectType = FightCardDeckView.SelectType.CardBox

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckView:_onCardPreClick()
	self._selectType = FightCardDeckView.SelectType.PreCard

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckView:_onDeviceClick()
	self._selectType = FightCardDeckView.SelectType.Device

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckView:_onCardLoadFinish(loader)
	local tarPrefab = loader:GetResource()

	gohelper.clone(tarPrefab, gohelper.findChild(self._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(self._cardItem, "select"), false)

	self.assetLoaded = true

	self:_startRefreshUI()
end

function FightCardDeckView:_onGetFightCardDeckInfoReply(msg)
	if self._boxList then
		for _, cardDataTab in ipairs(self._boxList) do
			self:recycleCardDataTab(cardDataTab)
		end

		tabletool.clear(self._boxList)
	end

	if self._deviceBoxList then
		for _, cardDataTab in ipairs(self._deviceBoxList) do
			self:recycleCardDataTab(cardDataTab)
		end

		tabletool.clear(self._deviceBoxList)
	end

	self:buildBoxList(msg)
	self:buildDeviceBoxList(msg)

	self.replyMsg = true

	self:_startRefreshUI()
end

function FightCardDeckView:getCardDataTab()
	local cardDataTab = table.remove(self.cardDataTabPool)

	cardDataTab = cardDataTab or {}

	return cardDataTab
end

function FightCardDeckView:recycleCardDataTab(cardDataTab)
	table.insert(self.cardDataTabPool, cardDataTab)
end

function FightCardDeckView:getTempKey(cardData)
	return (string.format("%s_%s", cardData.skillId, cardData.tempCard and "1" or "0"))
end

local TempDict = {}

function FightCardDeckView:buildBoxList(msg)
	tabletool.clear(TempDict)

	self._boxList = self._boxList or {}

	tabletool.clear(self._boxList)

	for _, v in ipairs(msg.deckInfos) do
		local cardData = v
		local key = self:getTempKey(cardData)
		local cardDataTab = TempDict[key]

		if not cardDataTab then
			cardDataTab = self:getCardDataTab()
			cardDataTab.skillId = cardData.skillId
			cardDataTab.tempCard = cardData.tempCard
			cardDataTab.entityId = cardData.uid
			cardDataTab.num = 0
			TempDict[key] = cardDataTab
		end

		cardDataTab.num = cardDataTab.num + 1
	end

	for _, cardDataTab in pairs(TempDict) do
		table.insert(self._boxList, cardDataTab)
	end
end

function FightCardDeckView:buildDeviceBoxList(msg)
	tabletool.clear(TempDict)

	self._deviceBoxList = self._deviceBoxList or {}

	tabletool.clear(self._deviceBoxList)

	for _, v in ipairs(msg.deviceInfos) do
		local cardData = v
		local key = self:getTempKey(cardData)
		local cardDataTab = TempDict[key]

		if not cardDataTab then
			cardDataTab = self:getCardDataTab()
			cardDataTab.skillId = cardData.skillId
			cardDataTab.tempCard = cardData.tempCard
			cardDataTab.entityId = cardData.uid
			cardDataTab.num = 0
			TempDict[key] = cardDataTab
		end

		cardDataTab.num = cardDataTab.num + 1
	end

	for _, cardDataTab in pairs(TempDict) do
		table.insert(self._deviceBoxList, cardDataTab)
	end
end

function FightCardDeckView:_refreshUI()
	if self._selectType == FightCardDeckView.SelectType.CardBox then
		if self._boxList then
			self:_refreshCardBox()
		end
	elseif self._selectType == FightCardDeckView.SelectType.Device then
		if self._deviceBoxList then
			self:_refreshDeviceCardBox()
		end
	else
		self:_refreshPreCard()
	end
end

function FightCardDeckView.sortCardBox(item1, item2)
	local entityMO1 = FightDataHelper.entityMgr:getById(item1.entityId)
	local entityMO2 = FightDataHelper.entityMgr:getById(item2.entityId)

	if not entityMO1 and entityMO2 then
		return true
	elseif entityMO1 and not entityMO2 then
		return false
	elseif not entityMO1 and not entityMO2 then
		return item1.skillId < item2.skillId
	else
		local position1 = entityMO1.position
		local position2 = entityMO2.position

		if position1 < position2 then
			return true
		elseif position2 < position1 then
			return false
		elseif item1.skillId == item2.skillId then
			if item1.tempCard and not item2.tempCard then
				return true
			elseif not item1.tempCard and item2.tempCard then
				return false
			else
				return item1.skillId < item2.skillId
			end
		else
			return item1.skillId < item2.skillId
		end
	end
end

function FightCardDeckView:_refreshDeviceCardBox()
	table.sort(self._deviceBoxList, FightCardDeckView.sortCardBox)
	self:com_createObjList(self._onCardItemShow, self._deviceBoxList, self._cardRoot, self._cardItem)

	if #self._deviceBoxList == 0 then
		self._nameText.text = ""
		self._skillText.text = ""
	end

	if #self._deviceBoxList > 6 then
		recthelper.setHeight(self._cardMask, 480)
	else
		recthelper.setHeight(self._cardMask, 320)
	end
end

function FightCardDeckView:_refreshCardBox()
	table.sort(self._boxList, FightCardDeckView.sortCardBox)
	self:com_createObjList(self._onCardItemShow, self._boxList, self._cardRoot, self._cardItem)

	if #self._boxList == 0 then
		self._nameText.text = ""
		self._skillText.text = ""
	end

	if #self._boxList > 6 then
		recthelper.setHeight(self._cardMask, 480)
	else
		recthelper.setHeight(self._cardMask, 320)
	end
end

function FightCardDeckView:_refreshPreCard()
	self:com_createObjList(self._onCardItemShow, self._preCardList, self._cardRoot, self._cardItem)

	if #self._preCardList == 0 then
		self._nameText.text = ""
		self._skillText.text = ""
	end

	if #self._preCardList > 6 then
		recthelper.setHeight(self._cardMask, 480)
	else
		recthelper.setHeight(self._cardMask, 320)
	end
end

function FightCardDeckView:_onCardItemShow(obj, data, index)
	gohelper.setActive(obj, false)
	gohelper.setActive(obj, true)

	local instanceId = obj:GetInstanceID()
	local cardItem = self._cardItemDic[instanceId]

	if not cardItem then
		cardItem = self:openSubView(FightCardDeckViewItem, obj)
		self._cardItemDic[instanceId] = cardItem

		self.addClickCb(self, gohelper.getClickWithDefaultAudio(gohelper.findChild(obj, "card")), self._onCardItemClick, self, instanceId)
	end

	cardItem:refreshItem(data)

	if self._selectType == FightCardDeckView.SelectType.CardBox or self._selectType == FightCardDeckView.SelectType.Device then
		cardItem:showCount(data.num)
	end

	if index == 1 then
		self:_onCardItemClick(instanceId)
	end
end

function FightCardDeckView:_onCardItemClick(instanceId)
	local cardItem = self._cardItemDic[instanceId]

	if self._curSelectItem then
		self._curSelectItem:setSelect(false)
	end

	self._curSelectItem = cardItem

	self._curSelectItem:setSelect(true)

	local itemData = cardItem._data
	local skillId = itemData.skillId
	local entityId = itemData.entityId
	local skillConfig = lua_skill.configDict[skillId]

	self._nameText.text = skillConfig.name
	self._skillText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(entityId, skillConfig), "#c56131", "#7c93ad")
end

function FightCardDeckView:_refreshBtnState()
	gohelper.setActive(self._cardBoxSelect, self._selectType == FightCardDeckView.SelectType.CardBox)
	gohelper.setActive(self._cardBoxUnselect, self._selectType ~= FightCardDeckView.SelectType.CardBox)
	gohelper.setActive(self._cardPreSelect, self._selectType == FightCardDeckView.SelectType.PreCard)
	gohelper.setActive(self._cardPreUnselect, self._selectType ~= FightCardDeckView.SelectType.PreCard)
	gohelper.setActive(self._deviceSelect, self._selectType == FightCardDeckView.SelectType.Device)
	gohelper.setActive(self._deviceUnselect, self._selectType ~= FightCardDeckView.SelectType.Device)
end

function FightCardDeckView:_refreshBtn()
	gohelper.setActive(self._btnCardBox.gameObject, tabletool.indexOf(CanSelectTypeList, FightCardDeckView.SelectType.CardBox))
	gohelper.setActive(self._btnCardPre.gameObject, tabletool.indexOf(CanSelectTypeList, FightCardDeckView.SelectType.PreCard))
	gohelper.setActive(self._btnDevice.gameObject, tabletool.indexOf(CanSelectTypeList, FightCardDeckView.SelectType.Device))
end

function FightCardDeckView:onClose()
	return
end

function FightCardDeckView:onDestroyView()
	return
end

return FightCardDeckView
