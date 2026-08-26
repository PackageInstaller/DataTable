-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyTrialSelectView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyTrialSelectView", package.seeall)

local PartyGameLobbyTrialSelectView = class("PartyGameLobbyTrialSelectView", BaseView)

function PartyGameLobbyTrialSelectView:onInitView()
	self._txthasSelect = gohelper.findChildText(self.viewGO, "root/#txt_hasSelect")
	self._scrolllevel = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_level")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyTrialSelectView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function PartyGameLobbyTrialSelectView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function PartyGameLobbyTrialSelectView:_btnconfirmOnClick()
	PartyGameTrialController.instance:dispatchEvent(PartyGameLobbyEvent.TrialSelectFinish)
	self:closeThis()
end

function PartyGameLobbyTrialSelectView:_editableInitView()
	self._goContent = gohelper.findChild(self._scrolllevel.gameObject, "Viewport/Content")
end

function PartyGameLobbyTrialSelectView:onUpdateParam()
	return
end

function PartyGameLobbyTrialSelectView:onOpen()
	self.trialIndex = self.viewParam.trialIndex
	self._needPlayerCount = PartyGameTrialPlayModel.instance:getPlayerCountByIndex(self.trialIndex)

	local allPartyGameConfig = PartyGameLobbyModel.instance:getOnLineGameConfigByPlayerCount(self._needPlayerCount)
	local allGameConfig = {}
	local allSelectGameIds = PartyGameTrialPlayModel.instance:getAllSelectGameIds()
	local startIndex, endIndex = PartyGameTrialPlayModel.instance:getSelectGameIndexRange(self._needPlayerCount)
	local canAdd = true

	for i = 1, #allPartyGameConfig do
		canAdd = true

		if allSelectGameIds then
			for j = 1, #allSelectGameIds do
				if (j < startIndex or endIndex < j) and allSelectGameIds[j] == allPartyGameConfig[i].gameConfig.id then
					canAdd = false
				end
			end
		end

		if canAdd then
			table.insert(allGameConfig, allPartyGameConfig[i].gameConfig)
		end
	end

	self._allItem = self:getUserDataTb_()

	local itemRes = self.viewContainer:getSetting().otherRes.item
	local item = self:getResInst(itemRes, self._goContent, "HelpSelectItem")

	gohelper.CreateObjList(self, self._onPartyGameItem, allGameConfig, self._goContent, item, PartyGameTrialSelectMultipleItem)
	self.addEventCb(self, PartyGameTrialController.instance, PartyGameLobbyEvent.TrialSelect, self._updateSelectNum, self)
	self:_updateSelectNum()
end

function PartyGameLobbyTrialSelectView:_onPartyGameItem(item, data, index)
	item:UpdateGameInfo(data)
	item:updateItem()
	item:setPlayerCount(self._needPlayerCount)
	table.insert(self._allItem, item)
end

function PartyGameLobbyTrialSelectView:updateSelectState()
	if self._allItem == nil then
		return
	end

	for _, item in pairs(self._allItem) do
		item:updateItem()
	end
end

function PartyGameLobbyTrialSelectView:_updateSelectNum()
	self._txthasSelect.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("partygame_lobby_trial_select_has_select"), self:getNeedSelectCount(), self:getNeedAllGameNum())

	self:updateSelectState()
end

function PartyGameLobbyTrialSelectView:onClose()
	self.removeEventCb(self, PartyGameTrialController.instance, PartyGameLobbyEvent.TrialSelect, self._updateSelectNum, self)
end

function PartyGameLobbyTrialSelectView:onDestroyView()
	return
end

function PartyGameLobbyTrialSelectView:getNeedAllGameNum()
	local needPlayerCount = PartyGameTrialPlayModel.instance:getPlayerCountByIndex(self.trialIndex)

	return PartyGameTrialPlayEnum.selectCountMap[needPlayerCount]
end

function PartyGameLobbyTrialSelectView:getNeedSelectCount()
	local needPlayerCount = PartyGameTrialPlayModel.instance:getPlayerCountByIndex(self.trialIndex)

	return PartyGameTrialPlayModel.instance:getSelectGameCountByPlayerNumber(needPlayerCount)
end

return PartyGameLobbyTrialSelectView
