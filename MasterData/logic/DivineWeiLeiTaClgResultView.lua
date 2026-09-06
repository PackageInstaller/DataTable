-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgResultView.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgResultView", package.seeall)

local DivineWeiLeiTaClgResultView = class("DivineWeiLeiTaClgResultView", ViewComponent)

function DivineWeiLeiTaClgResultView:ctor()
	DivineWeiLeiTaClgResultView.super.ctor(self)
end

function DivineWeiLeiTaClgResultView:unbindEvents()
	DivineWeiLeiTaClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineWeiLeiTaClgResultView:bindEvents()
	DivineWeiLeiTaClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function DivineWeiLeiTaClgResultView:buildUI()
	DivineWeiLeiTaClgResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)

	self._emptyGo = self:getGo("empty")
end

function DivineWeiLeiTaClgResultView:onExit()
	DivineWeiLeiTaClgResultView.super.onExit(self)
end

function DivineWeiLeiTaClgResultView:onEnter()
	DivineWeiLeiTaClgResultView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local tempData = DivineWeiLeiTaClgModel.instance:getExtBattleTempData(self._activityId)

	self._tableList:reloadData(tempData.lockRaceIds)
	GameUtil.SetActive(self._emptyGo, not tempData.lockRaceIds or #tempData.lockRaceIds <= 0)
end

function DivineWeiLeiTaClgResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCell(MatType.Pet, data, go)
end

function DivineWeiLeiTaClgResultView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DivineWeiLeiTaClgResultView:_onClickCancel()
	DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgExtremeConfirmReq(self._activityId, false)
	self:close()
end

function DivineWeiLeiTaClgResultView:_onClickSure()
	DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgExtremeConfirmReq(self._activityId, true)
	self:close()
end

return DivineWeiLeiTaClgResultView
