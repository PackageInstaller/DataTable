-- chunkname: @modules/logic/fight/view/FightCardDeckGMView.lua

module("modules.logic.fight.view.FightCardDeckGMView", package.seeall)

local FightCardDeckGMView = class("FightCardDeckGMView", BaseViewExtended)

function FightCardDeckGMView:onInitView()
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardDeckGMView:addEvents()
	self.addClickCb(self, self._click, self._onViewClick, self)
end

function FightCardDeckGMView:removeEvents()
	return
end

function FightCardDeckGMView:_editableInitView()
	self._nameText.text = ""
	self._skillText.text = ""
end

function FightCardDeckGMView:_onViewClick()
	self:closeThis()
end

function FightCardDeckGMView:onOpen()
	self._proto = self.viewParam
	self.selectType = FightCardDeckView.SelectType.CardBox
	self._cardItemDic = {}

	self:_refreshBtn()

	local cardPath = "ui/viewres/fight/fightcarditem.prefab"

	self:com_loadAsset(cardPath, self._onCardLoadFinish)
end

function FightCardDeckGMView:_startRefreshUI()
	self.addClickCb(self, self._btnCardBox, self._onCardBoxClick, self)
	self.addClickCb(self, self._btnDevice, self._onDeviceClick, self)
	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckGMView:_onCardBoxClick()
	self.selectType = FightCardDeckView.SelectType.CardBox

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckGMView:_onDeviceClick()
	self.selectType = FightCardDeckView.SelectType.Device

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckGMView:_onCardLoadFinish(loader)
	local tarPrefab = loader:GetResource()

	gohelper.clone(tarPrefab, gohelper.findChild(self._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(self._cardItem, "select"), false)
	self:_startRefreshUI()
end

function FightCardDeckGMView:_refreshUI()
	self._cardDataList = self._cardDataList or {}

	tabletool.clear(self._cardDataList)

	if self.selectType == FightCardDeckView.SelectType.CardBox then
		if not self._proto.deckInfos then
			local dataList = self._proto.deviceInfos

			for i, v in ipairs(dataList) do
				local tab = {}

				tab.entityId = v.uid
				tab.skillId = v.skillId
				tab.num = v.num

				table.insert(self._cardDataList, tab)
			end

			self:com_createObjList(self._onCardItemShow, self._cardDataList, self._cardRoot, self._cardItem)

			if #self._cardDataList == 0 then
				self._nameText.text = ""
				self._skillText.text = ""
			end

			if #self._cardDataList > 6 then
				recthelper.setHeight(self._cardMask, 480)
			else
				recthelper.setHeight(self._cardMask, 320)
			end
		end
	end
end

function FightCardDeckGMView:_onCardItemShow(obj, data, index)
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

	if index == 1 then
		self:_onCardItemClick(instanceId)
	end
end

function FightCardDeckGMView:_onCardItemClick(instanceId)
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

function FightCardDeckGMView:_refreshBtnState()
	gohelper.setActive(self._cardBoxSelect, self.selectType == FightCardDeckView.SelectType.CardBox)
	gohelper.setActive(self._cardBoxUnselect, self.selectType ~= FightCardDeckView.SelectType.CardBox)
	gohelper.setActive(self._deviceSelect, self.selectType == FightCardDeckView.SelectType.Device)
	gohelper.setActive(self._deviceUnselect, self.selectType ~= FightCardDeckView.SelectType.Device)
end

function FightCardDeckGMView:_refreshBtn()
	gohelper.setActive(self._btnCardBox.gameObject, true)
	gohelper.setActive(self._btnCardPre.gameObject, false)
	gohelper.setActive(self._btnDevice.gameObject, true)
end

function FightCardDeckGMView:onClose()
	return
end

function FightCardDeckGMView:onDestroyView()
	return
end

return FightCardDeckGMView
