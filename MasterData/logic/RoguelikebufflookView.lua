-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikebufflookView.lua

module("logic.extensions.roguelike.view.RoguelikebufflookView", package.seeall)

local RoguelikebufflookView = class("RoguelikebufflookView", ViewComponent)

RoguelikebufflookView.Enum_Global = 1
RoguelikebufflookView.Enum_Drop = 2

function RoguelikebufflookView:buildUI()
	RoguelikebufflookView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGlobal = self:getBtn("btnGlobal")
	self._btnDrop = self:getBtn("btnDrop")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._scrollView = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._scrollView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._globalSpriteChange = self._btnGlobal.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._dropSpriteChange = self._btnDrop.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._emptyGo = self:getGo("empty")
end

function RoguelikebufflookView:bindEvents()
	RoguelikebufflookView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnGlobal:AddClickListener(self._onClickGlobal, self)
	self._btnDrop:AddClickListener(self._onClickDrop, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
end

function RoguelikebufflookView:unbindEvents()
	RoguelikebufflookView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGlobal:RemoveClickListener()
	self._btnDrop:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function RoguelikebufflookView:onEnter()
	RoguelikebufflookView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoguelikeSelectDropBuffRes, self._onSelectDropBuffRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._phaseId = params[2]
	self._curTabId = 1

	self:_changeTab(RoguelikebufflookView.Enum_Global)
end

function RoguelikebufflookView:onExit()
	RoguelikebufflookView.super.onExit(self)
	self._scrollList:dispose()
end

function RoguelikebufflookView:_onClickClose()
	self:close()
end

function RoguelikebufflookView:_onClickGlobal()
	self:_changeTab(RoguelikebufflookView.Enum_Global)
end

function RoguelikebufflookView:_onClickDrop()
	self:_changeTab(RoguelikebufflookView.Enum_Drop)
end

function RoguelikebufflookView:_onClickRefresh()
	RoguelikeController.instance:onClickRefreshBuff(self._activityId, self._phaseId)
end

function RoguelikebufflookView:_onSelectDropBuffRes()
	self:_changeTab(RoguelikebufflookView.Enum_Drop)
end

function RoguelikebufflookView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "tableview/viewport/content/txtDesc")
	local buffIcon = goutil.findChild(cell, "buffIcon")
	local buffId = data

	if self._curTabId == RoguelikebufflookView.Enum_Global then
		local lv = RoguelikeModel.instance:getGlobalBuffLevel(self._activityId, buffId)
		local cfgList = RoguelikeConfig.instance:getGlobalBuffLvList(self._activityId, buffId)
		local initLvCfg = cfgList and cfgList[1]
		local curLvCfg = cfgList and cfgList[lv]

		if initLvCfg and curLvCfg then
			txtName.text = initLvCfg.buffName
			txtDesc.text = curLvCfg.buffDesc

			uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(initLvCfg.iconPath))
		end
	else
		local cfg = RoguelikeConfig.instance:getDropBuff(self._activityId, buffId)

		txtName.text = cfg.buffName
		txtDesc.text = cfg.buffDesc

		uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.iconPath))
	end
end

function RoguelikebufflookView:_clearCell(cell)
	local buffIcon = goutil.findChild(cell, "buffIcon")

	MaterialMgr.clearIcon(buffIcon)
end

function RoguelikebufflookView:_changeTab(tabId)
	self._curTabId = tabId

	self._globalSpriteChange:SetState(self._curTabId == RoguelikebufflookView.Enum_Global and 1 or 0)
	self._dropSpriteChange:SetState(self._curTabId == RoguelikebufflookView.Enum_Drop and 1 or 0)
	GameUtil.SetActive(self._btnRefresh, self._curTabId == RoguelikebufflookView.Enum_Drop)

	if self._curTabId == RoguelikebufflookView.Enum_Global then
		local globalBuffIdList = RoguelikeModel.instance:getUsingGlobalBuffList(self._activityId)
		local count = #globalBuffIdList

		self._scrollList:reloadData(globalBuffIdList)
		GameUtil.SetActive(self._emptyGo, count == 0)
	else
		local dropBuffIdList = RoguelikeModel.instance:getSelectedDropBuffs(self._activityId, self._phaseId)
		local count = #dropBuffIdList

		self._scrollList:reloadData(dropBuffIdList)
		GameUtil.SetActive(self._emptyGo, count == 0)
	end
end

return RoguelikebufflookView
