-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestScoreReportDetailView.lua

module("logic.extensions.martialcontest.view.MartialContestScoreReportDetailView", package.seeall)

local MartialContestScoreReportDetailView = class("MartialContestScoreReportDetailView", TwoFormsBaseView)

function MartialContestScoreReportDetailView:unbindEvents()
	MartialContestScoreReportDetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialContestScoreReportDetailView:bindEvents()
	MartialContestScoreReportDetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function MartialContestScoreReportDetailView:onExit()
	MartialContestScoreReportDetailView.super.onExit(self)
end

function MartialContestScoreReportDetailView:buildUI()
	MartialContestScoreReportDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
end

function MartialContestScoreReportDetailView:onEnter()
	MartialContestScoreReportDetailView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MCGetBattleVideoRes, self._handleGetBattleVideo, self)
	self.addGEvent(self, GlobalNotify.PM_MCGetBattleVideoErrorRes, self._handleGetBattleVideoError, self)

	local params = self:getOpenParam()
	local data = params[4]
	local challegeDate = GameUtil.time2date(checkint(data.challnegeTime / 1000))

	self._txtTime.text = langPara("%02d月%02d日 %02d:%02d", challegeDate.month, challegeDate.day, challegeDate.hour, challegeDate.min)
end

function MartialContestScoreReportDetailView:_updateOneForms(cell, data)
	MartialContestScoreReportDetailView.super._updateOneForms(self, cell, data)

	local btnVideo = Framework.ButtonAdapter.GetFrom(cell, "btnVideo")

	btnVideo:AddClickListener(function()
		self:_onClickVideo(data.battleId)
	end)
end

function MartialContestScoreReportDetailView:_onClickVideo(battleId)
	if checknumber(battleId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	MartialContestAgent.instance:sendPM_MCGetBattleVideoReq(battleId)
end

function MartialContestScoreReportDetailView:_handleGetBattleVideo(handle)
	UIJumper.instance:clear()
	UIJumper.instance:saveCurStack()

	if handle then
		handle()
	end
end

function MartialContestScoreReportDetailView:_handleGetBattleVideoError(status)
	if status == -526 or status == -47 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")
	end
end

return MartialContestScoreReportDetailView
