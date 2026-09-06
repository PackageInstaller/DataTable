-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuExtTipView.lua

module("logic.extensions.kunwu.view.KunWuExtTipView", package.seeall)

local KunWuExtTipView = class("KunWuExtTipView", ViewComponent)

function KunWuExtTipView:buildUI()
	KunWuExtTipView.super.buildUI(self)

	self._txtAliveNum = self:getTxt("txtAliveNum")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
end

function KunWuExtTipView:bindEvents()
	KunWuExtTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function KunWuExtTipView:unbindEvents()
	KunWuExtTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function KunWuExtTipView:onEnter()
	KunWuExtTipView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KunWuController.instance:getActivityId()
	end

	self._phase = checknumber(params[2])
	self._score = checknumber(params[3])

	self:_onSetUI()
end

function KunWuExtTipView:onExit()
	KunWuExtTipView.super.onExit(self)
end

function KunWuExtTipView:_onSetUI()
	local str = KunWuConfig.instance:getExtStageBottomWord(self._activityId, self._phase)

	self._txtAliveNum.text = "本次" .. str .. self._score .. "\n是否进行记录？"
end

function KunWuExtTipView:_onClickBtnSure()
	local confirmNum = KunWuModel.instance:getExtConfirmNum(self._activityId)

	if confirmNum ~= -1 then
		KunWuController.instance:sendPM_KunWuClgConfirmReq(self._activityId, confirmNum, true)
	end

	BattleController.instance:endBattle()
end

function KunWuExtTipView:_onClickBtnCancel()
	local confirmNum = KunWuModel.instance:getExtConfirmNum(self._activityId)

	if confirmNum ~= -1 then
		KunWuController.instance:sendPM_KunWuClgConfirmReq(self._activityId, confirmNum, false)
	end

	BattleController.instance:endBattle()
end

return KunWuExtTipView
