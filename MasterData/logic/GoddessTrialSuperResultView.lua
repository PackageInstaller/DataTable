-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperResultView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperResultView", package.seeall)

local GoddessTrialSuperResultView = class("GoddessTrialSuperResultView", ViewComponent)

function GoddessTrialSuperResultView:ctor()
	GoddessTrialSuperResultView.super.ctor(self)
end

function GoddessTrialSuperResultView:unbindEvents()
	GoddessTrialSuperResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function GoddessTrialSuperResultView:bindEvents()
	GoddessTrialSuperResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function GoddessTrialSuperResultView:buildUI()
	GoddessTrialSuperResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtCondition_2 = self:getTxt("txtCondition_2")
	self._txtScoreCondition_1 = self:getTxt("txtScoreCondition_1")
	self._scoreCondition_1 = self:getGo("txtScoreCondition_1")
	self._txtColorChangeCondition_1 = self._scoreCondition_1:GetComponent(ComponentType.UITextColorChange)
	self._txtScoreCondition_2 = self:getTxt("txtScoreCondition_2")
	self._scoreCondition_2 = self:getGo("txtScoreCondition_2")
	self._txtColorChangeCondition_2 = self._scoreCondition_2:GetComponent(ComponentType.UITextColorChange)
	self._txtCurTotalScore = self:getTxt("txtCurTotalScore")
	self._txtMaxScore = self:getTxt("txtMaxScore")
	self._recordTag = self:getGo("recordTag")
end

function GoddessTrialSuperResultView:onExit()
	GoddessTrialSuperResultView.super.onExit(self)
end

function GoddessTrialSuperResultView:onEnter()
	GoddessTrialSuperResultView.super.onEnter(self)

	local battleInfo = GoddessTrialModel.instance:getTempSuperBattleResult()

	self._activityId = battleInfo.activityId
	self._stepId = battleInfo.option.stepId
	self._stageId = battleInfo.option.stageId

	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self._activityId, self._stepId)
	local stageCfg = GoddessTrialConfig.instance:getSuperStageCfg(stepCfg.superTrialPlanId, self._stageId)
	local scoreplanCfgs = GoddessTrialConfig.instance:getSuperScorePlanCfgs(stepCfg.superTrialScorePlanId)
	local count = battleInfo.filterPetCount
	local maxCount = 0
	local score = 0

	for i, v in ipairs(scoreplanCfgs) do
		if count >= v.filterPetCount then
			score = v.score
		end

		if maxCount < v.filterPetCount then
			maxCount = v.filterPetCount
		end
	end

	self._txtCondition_2.text = langPara("累计上阵女性精灵(%d/%d)", count, maxCount)
	self._txtMaxScore.text = battleInfo.historyMaxScore
	self._txtCurTotalScore.text = battleInfo.curMaxScore

	GameUtil.SetActive(self._recordTag, battleInfo.oldMaxScore < battleInfo.historyMaxScore)

	if battleInfo.isWin == true then
		self._txtScoreCondition_1.text = string.format("+%d", stageCfg.score)
		self._txtScoreCondition_2.text = string.format("+%d", score)

		self._txtColorChangeCondition_1:SetState(0)
		self._txtColorChangeCondition_2:SetState(0)
	else
		self._txtColorChangeCondition_1:SetState(1)
		self._txtColorChangeCondition_2:SetState(1)

		self._txtScoreCondition_1.text = string.format("+%d", 0)
		self._txtScoreCondition_2.text = string.format("+%d", 0)
	end
end

function GoddessTrialSuperResultView:_onClickSure()
	GoddessTrialModel.instance:clearTempSuperBattleResult()
	BattleController.instance:endBattle()
end

return GoddessTrialSuperResultView
