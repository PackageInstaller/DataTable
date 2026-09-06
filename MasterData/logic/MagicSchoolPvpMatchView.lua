-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpMatchView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpMatchView", package.seeall)

local MagicSchoolPvpMatchView = class("MagicSchoolPvpMatchView", ViewComponent)

function MagicSchoolPvpMatchView:buildUI()
	MagicSchoolPvpMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._btnClose = self:getGo("matching/btnCancel")
	self._txtTime = self:getTxt("matching/txtTime")
	self._success = self:getGo("success")
end

function MagicSchoolPvpMatchView:bindEvents()
	MagicSchoolPvpMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function MagicSchoolPvpMatchView:unbindEvents()
	MagicSchoolPvpMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MagicSchoolPvpMatchView:onEnter()
	MagicSchoolPvpMatchView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self._myCampId = self._subMo:getCampId()

	if self._myCampId <= 0 then
		printError(string.format("MagicSchoolPvpMatchView:onEnter 缺失campId ( activityId:%s, campId:%s )", self._activityId, self._myCampId))
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPGameStartRes, self._handlePM_NotifyMSPvPGameStartRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPMatchStartRes, self._handlePM_NotifyMSPvPMatchStartRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPMatchOverTimeRes, self._handlePM_NotifyMSPvPMatchOverTimeRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPMatchFailRes, self._handlePM_NotifyMSPvPMatchFailRes, self)
	self:_startMatch()

	local curPeriodType = self._subMo:getCurPeriodType()

	if curPeriodType > MagicSchoolPvPEnum.PeriodType_Match then
		self:close()
		MagicSchoolPvPController.instance:doCurrentPeriodEvent(self._activityId, MagicSchoolPvPEnum.PeriodType_Ready)

		return
	end
end

function MagicSchoolPvpMatchView:onExit()
	MagicSchoolPvpMatchView.super.onExit(self)
	self:_stopMatch()
end

function MagicSchoolPvpMatchView:_handlePM_NotifyMSPvPGameStartRes()
	self:close()
	MagicSchoolPvPController.instance:doCurrentPeriodEvent(self._activityId, MagicSchoolPvPEnum.PeriodType_Ready)
end

function MagicSchoolPvpMatchView:_handlePM_NotifyMSPvPMatchStartRes()
	return
end

function MagicSchoolPvpMatchView:_handlePM_NotifyMSPvPMatchOverTimeRes()
	self:close()

	local tipsContent = "匹配超时"
	local okFunc

	TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function MagicSchoolPvpMatchView:_handlePM_NotifyMSPvPMatchFailRes()
	self:close()

	local tipsContent = "匹配失败"
	local okFunc

	TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function MagicSchoolPvpMatchView:_startMatch()
	self._startMatchTime = ServerTime.now()

	GameUtil.SetActive(self._matching, true)
	GameUtil.SetActive(self._success, false)
	settimer(0.1, self._onMatchTicking, self)
end

function MagicSchoolPvpMatchView:_stopMatch()
	removetimer(self._onMatchTicking, self)
	removetimer(self._enterScence, self)
	removetimer(self._matchFailClose, self)
end

function MagicSchoolPvpMatchView:_onMatchTicking()
	self._deltaTime = ServerTime.now() - self._startMatchTime
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._deltaTime)
end

function MagicSchoolPvpMatchView:_matchSuccess()
	self:_stopMatch()
	GameUtil.SetActive(self._matching, false)
	GameUtil.SetActive(self._success, true)
	settimer(2, self._enterScence, self, false)
end

function MagicSchoolPvpMatchView:_enterScence()
	self:close()
	MagicSchoolPvPController.instance:doCurrentPeriodEvent(self._activityId, MagicSchoolPvPEnum.PeriodType_Ready)
end

function MagicSchoolPvpMatchView:_onClickBtnClose()
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKCancelMatchReq()
end

function MagicSchoolPvpMatchView:_handleDealCardRes()
	self:_matchSuccess()
end

function MagicSchoolPvpMatchView:_handleCancelMatchRes()
	self:close()
end

function MagicSchoolPvpMatchView:_handleMatchRes(status, msg)
	if status == 0 then
		-- block empty
	else
		settimer(3, self._matchFailClose, self, false)
	end
end

function MagicSchoolPvpMatchView:_matchFailClose()
	FloatWordMgr.instance:show("上一局游戏进行中,请等待冷却")
	self:close()
end

function MagicSchoolPvpMatchView:_handleMatchingOverTimeRes()
	FloatWordMgr.instance:show("匹配超时")
	self:close()
end

function MagicSchoolPvpMatchView:_handleMatchFailRes()
	FloatWordMgr.instance:show("因某种原因匹配失败")
	self:close()
end

return MagicSchoolPvpMatchView
