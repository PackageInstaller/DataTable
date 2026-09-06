-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameOverView.lua

module("logic.extensions.linkgame.view.LinkGameOverView", package.seeall)

local LinkGameOverView = class("LinkGameOverView", ViewComponent)

function LinkGameOverView:ctor()
	LinkGameOverView.super.ctor(self)
end

function LinkGameOverView:bindEvents()
	LinkGameOverView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function LinkGameOverView:unbindEvents()
	LinkGameOverView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LinkGameOverView:buildUI()
	LinkGameOverView.super.buildUI(self)

	self._btnClose = self:getGo("viewBoxGo")
	self._txtCost = self:getTxt("costCount/txt")
	self._tableView = self:getGo("gainCount/itemScrollerview")
	self._tableCell = self:getGo("gainCount/itemScrollercell")
	self._firstTip = self:getGo("txtFirstTip")
	self._newRecord = self:getGo("costCount/tag")
end

function LinkGameOverView:onEnter()
	local params = self:getOpenParam()

	self._changeId = params[1]
	self._costTime = params[2]

	local isNewRecord = params[3]
	local isFirstWin = params[4]

	self._txtCost.text = checknumber(self._costTime)
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)

	local rewards = MaterialController.instance:getTempItemsByChangeSetId(checknumber(self._changeId))

	self._tableList:reloadData(rewards)
	GameUtil.SetActive(self._firstTip, not isFirstWin)
	GameUtil.SetActive(self._newRecord, isNewRecord and isNewRecord == true)
end

function LinkGameOverView:onExit()
	LinkGameOverView.super.onExit(self)
	self._tableList:dispose()
end

function LinkGameOverView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local proxy = MaterialMgr.setCell(data.type, data.id, go)

	if proxy then
		proxy.binder:setNum(data.num)
	end
end

function LinkGameOverView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function LinkGameOverView:_onClickClose()
	UIStateManager.instance:popByName(ViewName.LinkGamePlayView)
	UIStateManager.instance:popByName(ViewName.LinkGameEndlessView)
	self:close()
end

return LinkGameOverView
