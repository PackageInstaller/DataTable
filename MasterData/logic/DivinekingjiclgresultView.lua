-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgresultView.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgresultView", package.seeall)

local DivinekingjiclgresultView = class("DivinekingjiclgresultView", ViewComponent)

function DivinekingjiclgresultView:ctor()
	DivinekingjiclgresultView.super.ctor(self)
end

function DivinekingjiclgresultView:unbindEvents()
	DivinekingjiclgresultView.super.unbindEvents(self)
	self._btnSave:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function DivinekingjiclgresultView:bindEvents()
	DivinekingjiclgresultView.super.bindEvents(self)
	self._btnSave:AddClickListener(self._onClickbtnSave, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function DivinekingjiclgresultView:buildUI()
	DivinekingjiclgresultView.super.buildUI(self)

	self._btnSave = self:getBtn("btnSave")
	self._btnCancel = self:getBtn("btnCancel")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("emptyGo")
end

function DivinekingjiclgresultView:onExit()
	DivinekingjiclgresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivinekingjiclgresultView:onEnter()
	DivinekingjiclgresultView.super.onEnter(self)

	self._clgNotifyFightResMsg = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.DivineKingJiClgConfirmRes, self._onDivineKingJiClgConfirmRes, self)
	self:_updateUI()
end

function DivinekingjiclgresultView:_onClickbtnSave()
	DivineKingJiClgAgent.instance:sendPM_DivineKingJiClgConfirmReq(self._clgNotifyFightResMsg.activityId, self._clgNotifyFightResMsg.stageId, true)
end

function DivinekingjiclgresultView:_onClickbtnCancel()
	DivineKingJiClgAgent.instance:sendPM_DivineKingJiClgConfirmReq(self._clgNotifyFightResMsg.activityId, self._clgNotifyFightResMsg.stageId, false)
end

function DivinekingjiclgresultView:_updateCell(view, cell, raceId, tag)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function DivinekingjiclgresultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivinekingjiclgresultView:_updateUI()
	local lockRaceIds = self._clgNotifyFightResMsg.lockRaceIds

	self._scrollerList:setCenterMode(true)
	self._scrollerList:reloadData(lockRaceIds)
	goutil.setActive(self._emptyGo, not lockRaceIds or #lockRaceIds <= 0)
end

function DivinekingjiclgresultView:_onDivineKingJiClgConfirmRes()
	BattleController.instance:endBattle()
end

return DivinekingjiclgresultView
