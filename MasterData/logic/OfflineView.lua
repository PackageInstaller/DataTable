-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflineView.lua

module("logic.extensions.offline.view.OfflineView", package.seeall)

local OfflineView = class("OfflineView", ViewComponent)
local STACK_NAME = {
	ViewName.OfflinepvView,
	ViewName.OfflinesongView,
	ViewName.OfflinenoticeView,
	ViewName.OfflinenewsView,
	ViewName.OfflinejournalView
}

function OfflineView:ctor()
	OfflineView.super.ctor(self)
end

function OfflineView:unbindEvents()
	OfflineView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self.close, self)
end

function OfflineView:bindEvents()
	OfflineView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function OfflineView:buildUI()
	OfflineView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.container = self:getGo("container")
	self.tableView = self:getGo("tableView")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableView, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function OfflineView:onExit()
	OfflineView.super.onExit(self)
	self.scrollList:dispose()
end

function OfflineView:onEnter()
	OfflineView.super.onEnter(self)

	self.selectId = 0

	local activityId = OfflineController.instance:getCurrActivityId()
	local cfg = OfflineConfig.instance:getCfgById(activityId) or {}
	local list = OfflineConfig.instance:getPrizeListCfgById(cfg.planId) or {}

	self.scrollList:reloadData(list)
	self:onClickTab(list[1])
	OfflineController.instance:sendGetPrizeInfo(activityId)
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_HUD_OFFLINE, true)
end

function OfflineView:_updateCell(view, cell, data, tag)
	local redpoint = goutil.findChild(cell, "redpoint")
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtNameGo = goutil.findChild(cell, "txtName")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickTab, self, data))

	txtName.text = data.name

	GameUtil.setUITextColorIdx(txtNameGo, self.selectId == data.id and 1 or 0)
	GameUtil.SetActive(imgSelected, self.selectId == data.id)
	RedPointController.instance:regRedPoint(redpoint, data.redpoint)
end

function OfflineView:clearCell(cell)
	local redpoint = goutil.findChild(cell, "redpoint")

	RedPointController.instance:unregRedPoint(redpoint)
end

function OfflineView:onClickTab(data)
	self.selectId = data.id

	local id = data.id
	local viewName = STACK_NAME[id]

	self:showTabAt(self.container, viewName, data)
	self.scrollList:refresh()
end

return OfflineView
