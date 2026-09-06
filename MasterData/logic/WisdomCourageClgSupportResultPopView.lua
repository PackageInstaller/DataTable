-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgSupportResultPopView.lua

module("logic.extensions.aoqigod.view.WisdomCourageClgSupportResultPopView", package.seeall)

local WisdomCourageClgSupportResultPopView = class("WisdomCourageClgSupportResultPopView", ViewComponent)

function WisdomCourageClgSupportResultPopView:ctor()
	WisdomCourageClgSupportResultPopView.super.ctor(self)
end

function WisdomCourageClgSupportResultPopView:buildUI()
	WisdomCourageClgSupportResultPopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtNum = self:getTxt("txtNum")
end

function WisdomCourageClgSupportResultPopView:bindEvents()
	WisdomCourageClgSupportResultPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function WisdomCourageClgSupportResultPopView:unbindEvents()
	WisdomCourageClgSupportResultPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function WisdomCourageClgSupportResultPopView:onEnter()
	WisdomCourageClgSupportResultPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._clgMo = WisdomCourageClgController.instance:getWisdomCourageClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_NotifyWisdomCourageClgSupportChallengeFinishRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WisdomCourageClgSupportConfirmRes, self._handlePM_WisdomCourageClgSupportConfirmRes, self)
	self:_onUpdate()
end

function WisdomCourageClgSupportResultPopView:onExit()
	WisdomCourageClgSupportResultPopView.super.onExit(self)
end

function WisdomCourageClgSupportResultPopView:_handlePM_WisdomCourageClgSupportConfirmRes(status, msg)
	BattleController.instance:endBattle()
end

function WisdomCourageClgSupportResultPopView:_onUpdate()
	local msg = self._clgMo:getSupportClgFinishResMsg()

	self._txtNum.text = msg.curSupportPetNum
end

function WisdomCourageClgSupportResultPopView:_onClickBtnSure()
	WisdomCourageClgController.instance:sendPM_WisdomCourageClgSupportConfirmReq(self._activityId, true)
end

function WisdomCourageClgSupportResultPopView:_onClickBtnClose()
	WisdomCourageClgController.instance:sendPM_WisdomCourageClgSupportConfirmReq(self._activityId, false)
end

return WisdomCourageClgSupportResultPopView
