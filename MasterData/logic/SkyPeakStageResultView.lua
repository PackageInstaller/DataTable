-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakStageResultView.lua

module("logic.extensions.skypeak.view.SkyPeakStageResultView", package.seeall)

local SkyPeakStageResultView = class("SkyPeakStageResultView", ViewComponent)

function SkyPeakStageResultView:ctor()
	SkyPeakStageResultView.super.ctor(self)
end

function SkyPeakStageResultView:unbindEvents()
	SkyPeakStageResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function SkyPeakStageResultView:bindEvents()
	SkyPeakStageResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SkyPeakStageResultView:buildUI()
	SkyPeakStageResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtKillnum = self:getTxt("info/killnum")
	self._txtValueKillnum = self:getTxt("info/killnum/txtValue")
	self._txtValueKillnumScore = self:getTxt("info/killnum/score/txtValue")
	self._txtValueActiveNum = self:getTxt("info/activeNum/txtValue")
	self._txtValueActiveNumScore = self:getTxt("info/activeNum/score/txtValue")
	self._txtValueRoundNum = self:getTxt("info/roundNum/txtValue")
	self._txtValueRoundNumScore = self:getTxt("info/roundNum/score/txtValue")
	self._txtHistory = self:getTxt("info/txtHistory")
	self._txtNow = self:getTxt("info/txtNow")
	self._markNew = self:getGo("info/markNew")
end

function SkyPeakStageResultView:onExit()
	SkyPeakStageResultView.super.onExit(self)
end

function SkyPeakStageResultView:onEnter()
	SkyPeakStageResultView.super.onEnter(self)

	self._resultInfo = SkyPeakModel.instance:getLastStageChallengeResult()

	if self._resultInfo == nil then
		self:_onClickSure()

		return
	end

	self._activityId = self._resultInfo.activityId
	self._stageId = self._resultInfo.stageId
	self._alivePetCount = 0
	self._circleNum = 0
	self._extraKillTimes = 0

	if not self._resultInfo.stageScoreInfo then
		if self._resultInfo.stageScoreInfo then
			self._alivePetCount = self._resultInfo.stageScoreInfo.alivePetCount or 0
			self._circleNum = self._resultInfo.stageScoreInfo.circleNum or 0
			self._extraKillTimes = self._resultInfo.stageScoreInfo.extraKillTimes or 0
		end

		self._historyMaxScore = SkyPeakModel.instance:getLastStageScoreBeforeChange() or 0
		self._maxScore = self._resultInfo.maxScore or 0

		self:_updateUIByCfg()
		self:_updateUIByInfo()
	end
end

function SkyPeakStageResultView:_updateUIByCfg()
	self._stageCfg = SkyPeakConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}
	self._killUnitScore = self._stageCfg.killUnitScore or 0
	self._killScorePetName = SkyPeakController.instance:getKillPetName(self._activityId) or ""
	self._txtKillnum.text = self._killScorePetName ~= "" and langPara("%s\n击杀数", self._killScorePetName) or lang("指定位置未上阵")
end

function SkyPeakStageResultView:_updateUIByInfo()
	self._txtValueActiveNum.text = tostring(self._alivePetCount)
	self._txtValueRoundNum.text = tostring(self._circleNum)
	self._txtValueKillnum.text = tostring(self._extraKillTimes)
	self._txtValueActiveNumScore.text = langPara("+%s", SkyPeakConfig.instance:getAliveScore(self._stageCfg.aliveScorePlanId, self._alivePetCount))
	self._txtValueRoundNumScore.text = langPara("+%s", SkyPeakConfig.instance:getRoundCircleScore(self._stageCfg.circleScorePlanId, self._circleNum))
	self._txtValueKillnumScore.text = langPara("+%s", tostring(self._extraKillTimes * self._killUnitScore))
	self._txtHistory.text = tostring(self._historyMaxScore)
	self._txtNow.text = tostring(self._maxScore)

	goutil.setActive(self._markNew, self._maxScore > self._historyMaxScore)
end

function SkyPeakStageResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return SkyPeakStageResultView
