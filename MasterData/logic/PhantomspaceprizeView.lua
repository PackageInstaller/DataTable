-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspaceprizeView.lua

module("logic.extensions.phantomspace.view.PhantomspaceprizeView", package.seeall)

local PhantomspaceprizeView = class("PhantomspaceprizeView", ViewComponent)

function PhantomspaceprizeView:ctor()
	PhantomspaceprizeView.super.ctor(self)
end

function PhantomspaceprizeView:unbindEvents()
	PhantomspaceprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PhantomspaceprizeView:bindEvents()
	PhantomspaceprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PhantomspaceprizeView:buildUI()
	PhantomspaceprizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._itemTablecell = self:getGo("itemTablecell")
	self._ranktablecell = self:getGo("ranktablecell")
	self._ranktableview = self:getGo("ranktableview")
	self._rankTableView = self:getGo("ranktableview")
	self._rankTableCell = self:getGo("ranktablecell")
	self._rankTableList = ScrollerList.create(self._rankTableView, self._rankTableCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function PhantomspaceprizeView:onExit()
	PhantomspaceprizeView.super.onExit(self)
	self._rankTableList:dispose()
end

function PhantomspaceprizeView:onEnter()
	PhantomspaceprizeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PhantomSpaceController.instance:getDefaultActivityId()
	end

	self._itemTableListDir = {}

	self.addGEvent(self, GlobalNotify.PHANTOM_SPACE_INFO_UPDATE, self._onRefreshUI, self)
	PhantomSpaceController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function PhantomspaceprizeView:_onRefreshUI()
	self._info = PhantomSpaceModel.instance:getInfo(self._activityId) or {}
	self._stageKey = self._info.stageKey or {}
	self._buffLv = checknumber(self._stageKey.buffLv)

	local list = PhantomSpaceConfig.instance:getBuffListCfgById(self._activityId) or {}

	self._rankTableList:reloadData(list)

	if self._buffLv > 0 then
		self._rankTableList:MoveCellToCenter(self._buffLv - 1)
	end
end

function PhantomspaceprizeView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local itemTableView = goutil.findChild(go, "itemTableview")
	local geted = goutil.findChild(go, "geted")
	local doing = goutil.findChild(go, "doing")
	local waiting = goutil.findChild(go, "waiting")

	GameUtil.SetActive(geted, self._buffLv > data.buffLv)
	GameUtil.SetActive(doing, self._buffLv == data.buffLv)
	GameUtil.SetActive(waiting, self._buffLv < data.buffLv)

	txtRank.text = data.desc

	local prizeArray = string.split(data.buffPrize, "#")
	local itemTableList = self._itemTableListDir[cell]

	if itemTableList == nil then
		itemTableList = ScrollerList.create(itemTableView, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		itemTableList:dragNotifyParent()
		itemTableList:setCenterMode(true)

		self._itemTableListDir[cell] = itemTableList
	end

	itemTableList:reloadData(prizeArray)
end

function PhantomspaceprizeView:_clearRankCell(cell)
	if self._itemTableListDir[cell] then
		self._itemTableListDir[cell]:dispose()

		self._itemTableListDir[cell] = nil
	end
end

function PhantomspaceprizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function PhantomspaceprizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return PhantomspaceprizeView
