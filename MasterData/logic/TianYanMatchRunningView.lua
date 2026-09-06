-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchRunningView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchRunningView", package.seeall)

local TianYanMatchRunningView = class("TianYanMatchRunningView", ViewComponent)

function TianYanMatchRunningView:ctor()
	TianYanMatchRunningView.super.ctor(self)
end

function TianYanMatchRunningView:unbindEvents()
	TianYanMatchRunningView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function TianYanMatchRunningView:bindEvents()
	TianYanMatchRunningView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function TianYanMatchRunningView:buildUI()
	TianYanMatchRunningView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._txtTime = self:getTxt("matching/txtTime")
	self._btnCancel = self:getGo("matching/btnCancel")
end

function TianYanMatchRunningView:onExit()
	TianYanMatchRunningView.super.onExit(self)
	removetimer(self._updateTimer, self)
end

function TianYanMatchRunningView:onEnter()
	TianYanMatchRunningView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TianYanMatchNotifyMatchSucRes, self.close, self)
	self.addGEvent(self, GlobalNotify.PM_TianYanMatchNotifyMatchFailRes, self._PM_TianYanMatchNotifyMatchFailRes, self)
	self.addGEvent(self, GlobalNotify.PM_TianYanMatchCancelMatchRes, self.close, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_startMatch()
end

function TianYanMatchRunningView:_startMatch()
	goutil.setActive(self._suc, false)
	goutil.setActive(self._matching, true)

	self._timer = 0
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
	self._startTime = ServerTime.now()

	settimer(1, self._updateTimer, self, true)
	TianYanMatchAgent.instance:sendPM_TianYanMatchMatchReq(self._activityId)
end

function TianYanMatchRunningView:_updateTimer()
	self._timer = ServerTime.now() - self._startTime
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
end

function TianYanMatchRunningView:_PM_TianYanMatchNotifyMatchFailRes()
	FloatWordMgr.instance:show(lang("匹配超时"))
	self:close()
end

function TianYanMatchRunningView:_onClickCancel()
	TianYanMatchAgent.instance:sendPM_TianYanMatchCancelMatchReq(self._activityId)
end

return TianYanMatchRunningView
