-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/view/DivineShiKongLongZunFightEndShowView.lua

module("logic.extensions.divineshikonglongzunmainview.view.DivineShiKongLongZunFightEndShowView", package.seeall)

local DivineShiKongLongZunFightEndShowView = class("DivineShiKongLongZunFightEndShowView", ViewComponent)

function DivineShiKongLongZunFightEndShowView:buildUI()
	DivineShiKongLongZunFightEndShowView.super.buildUI(self)

	self._txtPreScore = self:getTxt("lottery/desc1")
	self._txtNewScore = self:getTxt("lottery/desc2")
	self._btnWin = self:getGo("btnWin")
	self._btnDontCover = self:getGo("btnWin/btnDontCover")
	self._btnCover = self:getGo("btnWin/btnCover")
	self._btnLose = self:getGo("btnLose")
	self._btnFinish = self:getGo("btnLose/btnFinish")
end

function DivineShiKongLongZunFightEndShowView:bindEvents()
	DivineShiKongLongZunFightEndShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCover, self._onClickCover, self)
	GameUtil.addClickHandler(self._btnDontCover, self._onClickDontCover, self)
	GameUtil.addClickHandler(self._btnFinish, self._onClickFinish, self)
end

function DivineShiKongLongZunFightEndShowView:unbindEvents()
	DivineShiKongLongZunFightEndShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCover)
	GameUtil.rmClickHandler(self._btnDontCover)
	GameUtil.rmClickHandler(self._btnFinish)
end

function DivineShiKongLongZunFightEndShowView:onEnter()
	self._activityId = self:getFirstParam()

	local model = DivineShiKongLongZunModel.instance:GetModel(self._activityId)

	self._stageId = model.resStageId
	self._teamIndex = model.resTeamIndex
	self._score = model.resScore
	self._needConfirm = model.resNeedConfirm
	self._passStage = model.resPassStage

	self:OnSetUI()
	self.addGEvent(self, GlobalNotify.PM_DivineTSDragonLordClgConfirmScoreRes, self._PM_DivineTSDragonLordClgConfirmScoreRes, self)
end

function DivineShiKongLongZunFightEndShowView:onExit()
	DivineShiKongLongZunFightEndShowView.super.onExit(self)
end

function DivineShiKongLongZunFightEndShowView:_PM_DivineTSDragonLordClgConfirmScoreRes(status, msg)
	if status == 0 then
		local activityId = self._activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end
	end

	self:close()
	BattleController.instance:endBattle()
end

function DivineShiKongLongZunFightEndShowView:OnSetUI()
	local teamIsPass = DivineShiKongLongZunModel.instance:curTeamIsPass(self._activityId, self._stageId, self._teamIndex)
	local preScoreArr = DivineShiKongLongZunModel.instance:getStageTeamScore(self._activityId, self._stageId, self._teamIndex)

	GameUtil.SetActive(self._btnWin, self._needConfirm)
	GameUtil.SetActive(self._btnLose, not self._needConfirm)

	self._txtPreScore.text = teamIsPass and "<color=#fff1ba>曙光:</color><color=#6bf4ff>" .. preScoreArr[1] .. "</color> <color=#fff1ba>   黑暗:</color><color=#6bf4ff>" .. preScoreArr[2] .. "</color>" or "<color=#fff1ba>--暂无--</color>"
	self._txtNewScore.text = "<color=#fff1ba>曙光:</color><color=#6bf4ff>" .. self._score[1] .. "</color> <color=#fff1ba>   黑暗:</color><color=#6bf4ff>" .. self._score[2] .. "</color>"
end

function DivineShiKongLongZunFightEndShowView:_onClickCover()
	DivineShiKongLongZunController.instance:sendPM_DivineTSDragonLordClgConfirmScoreReq(self._activityId, self._stageId, self._teamIndex, true)
end

function DivineShiKongLongZunFightEndShowView:_onClickDontCover()
	DivineShiKongLongZunController.instance:sendPM_DivineTSDragonLordClgConfirmScoreReq(self._activityId, self._stageId, self._teamIndex, false)
end

function DivineShiKongLongZunFightEndShowView:_onClickFinish()
	self:close()
	BattleController.instance:endBattle()
end

return DivineShiKongLongZunFightEndShowView
