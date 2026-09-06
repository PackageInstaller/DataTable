-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclglockView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclglockView", package.seeall)

local ShadowdragonclglockView = class("ShadowdragonclglockView", ViewComponent)

function ShadowdragonclglockView:ctor()
	ShadowdragonclglockView.super.ctor(self)
end

function ShadowdragonclglockView:unbindEvents()
	ShadowdragonclglockView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ShadowdragonclglockView:bindEvents()
	ShadowdragonclglockView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function ShadowdragonclglockView:buildUI()
	ShadowdragonclglockView.super.buildUI(self)

	self._tableviewfutureGo = self:getGo("tableviewfuture")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewpassGo = self:getGo("tableviewpass")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerListPass = ScrollerList.create(self._tableviewpassGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListFuture = ScrollerList.create(self._tableviewfutureGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._emptyGoPass = self:getGo("emptyPass")
	self._emptyGoFuture = self:getGo("emptyFuture")
end

function ShadowdragonclglockView:onExit()
	ShadowdragonclglockView.super.onExit(self)
	self._scrollerListPass:dispose()
	self._scrollerListFuture:dispose()
end

function ShadowdragonclglockView:onEnter()
	ShadowdragonclglockView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ShadowDragonClgConfirmRes, self._onShadowDragonClgConfirmRes, self)

	self._msg = self:getFirstParam()
	self._activityId = self._msg.activityId
	self._stageId = self._msg.stageId
	self._selectBuffId = self._msg.selectBuffId

	self:_updateUI()
end

function ShadowdragonclglockView:_onClickbtnClose()
	BattleFacade.instance:endBattle()
end

function ShadowdragonclglockView:_onClickbtnCancel()
	BattleFacade.instance:endBattle()
end

function ShadowdragonclglockView:_onClickbtnSure()
	ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgConfirmReq(self._activityId, self._stageId, self._selectBuffId)
end

function ShadowdragonclglockView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCell(MatType.Pet, data.left, cell.gameObject)
end

function ShadowdragonclglockView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function ShadowdragonclglockView:_updateUI()
	self._scrollerListPass:reloadData(self._msg.dieRacePosList)
	self._scrollerListFuture:reloadData(self._msg.activeRacePosList)
	goutil.setActive(self._emptyGoPass, not self._msg.dieRacePosList or #self._msg.dieRacePosList <= 0)
	goutil.setActive(self._emptyGoFuture, not self._msg.activeRacePosList or #self._msg.activeRacePosList <= 0)
end

function ShadowdragonclglockView:_onShadowDragonClgConfirmRes()
	BattleFacade.instance:endBattle()
end

return ShadowdragonclglockView
