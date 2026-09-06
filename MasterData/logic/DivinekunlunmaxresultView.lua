-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunmaxresultView.lua

module("logic.extensions.divinekunlun.view.DivinekunlunmaxresultView", package.seeall)

local DivinekunlunmaxresultView = class("DivinekunlunmaxresultView", ViewComponent)

function DivinekunlunmaxresultView:ctor()
	DivinekunlunmaxresultView.super.ctor(self)
end

function DivinekunlunmaxresultView:unbindEvents()
	DivinekunlunmaxresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function DivinekunlunmaxresultView:bindEvents()
	DivinekunlunmaxresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function DivinekunlunmaxresultView:buildUI()
	DivinekunlunmaxresultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtRecord = self:getTxt("txtRecord")
	self._txtCurr = self:getTxt("txtCurr")
	self._btnCancel = self:getGo("btnCancel")
end

function DivinekunlunmaxresultView:onExit()
	DivinekunlunmaxresultView.super.onExit(self)
end

function DivinekunlunmaxresultView:onEnter()
	DivinekunlunmaxresultView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.DIVINE_KUNLUN_CLG_CONFIRM, self._onCloseAndEnd, self)
	self:_onRefreshUI()
end

function DivinekunlunmaxresultView:_onRefreshUI()
	local pb = DivineKunlunModel.instance:getExtFightPb(self._activityId) or {}

	self._stageId = pb.stageId
	self._txtCurr.text = langPara("本次挑战连击次数：%s", checknumber(pb.score))
	self._txtRecord.text = langPara("本关历史连击次数：%s", checknumber(pb.oldScore))
end

function DivinekunlunmaxresultView:_onClickCancel()
	DivineKunlunController.instance:sendConfirm(self._activityId, self._stageId, false)
end

function DivinekunlunmaxresultView:_onClickSure()
	DivineKunlunController.instance:sendConfirm(self._activityId, self._stageId, true)
end

function DivinekunlunmaxresultView:_onCloseAndEnd()
	self:close()
	BattleController.instance:endBattle()
end

return DivinekunlunmaxresultView
