-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperView", package.seeall)

local GoddessTrialSuperView = class("GoddessTrialSuperView", ViewComponent)

function GoddessTrialSuperView:ctor()
	GoddessTrialSuperView.super.ctor(self)
end

function GoddessTrialSuperView:unbindEvents()
	GoddessTrialSuperView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function GoddessTrialSuperView:bindEvents()
	GoddessTrialSuperView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function GoddessTrialSuperView:buildUI()
	GoddessTrialSuperView.super.buildUI(self)

	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redpoint")
	self._btnClose = self:getGo("btnClose")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnTip = self:getGo("btnTip")
	self._stageArea = self:getGo("stageArea")
	self._stageCell = self:getGo("stageArea/stageCell")
	self._stageRecordPos = self._stageArea:GetComponent(ComponentType.TestRecordPos)

	local formationGo = self:getGo("stageInfo/formation")

	self._formationGos = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(formationGo, "cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		self._formationGos[i] = cell
	end

	self._txtRule = self:getTxt("stageInfo/txtRule")
	self._txtStageName = self:getTxt("stageInfo/txtName")
end

function GoddessTrialSuperView:onExit()
	GoddessTrialSuperView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointPrize)
end

function GoddessTrialSuperView:onEnter()
	GoddessTrialSuperView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessTrialGetInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = GoddessTrialConfig.instance:getActivityCfg(self._activityId)
	self._stepId = GoddessTrialController.instance:getCurStepId(self._activityId)

	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self._activityId, self._stepId)
	local stageCfgs = GoddessTrialConfig.instance:getSuperStageCfgs(stepCfg.superTrialPlanId)

	self._curStageId = 1

	for i, v in ipairs(stageCfgs) do
		local score = GoddessTrialModel.instance:getSuperStageScore(self._activityId, self._stepId, v.stageId)

		if score <= 0 then
			self._curStageId = v.stageId

			break
		end
	end

	RedPointController.instance:regRedPoint(self._redPointPrize, self._activityCfg.redPointId)
	self:_refreshView()
end

function GoddessTrialSuperView:_refreshView()
	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self._activityId, self._stepId)
	local stageCfgs = GoddessTrialConfig.instance:getSuperStageCfgs(stepCfg.superTrialPlanId)

	GameUtil.updateCellsList(self._stageArea, self._stageCell, stageCfgs, self._updateStageCell, self)
	self._stageRecordPos:LoadPlan(0)

	local curCfg = stageCfgs[self._curStageId]

	self._txtStageName.text = langPara("第%d关", curCfg.stageId)

	local creepCfg = GoddessTrialConfig.instance:getCreepsCfg(curCfg.creepsMasterId)
	local teamCfg = GoddessTrialConfig.instance:getTeamCfg(curCfg.creepsMasterId)

	self._txtRule.text = teamCfg.ruleDesc

	for i, v in pairs(self._formationGos) do
		GameUtil.SetActive(v.go, false)
		MaterialMgr.resetAll(v.con)
	end

	for i, v in ipairs(creepCfg) do
		if self._formationGos[v.posId] then
			local cell = self._formationGos[v.posId]

			GameUtil.SetActive(cell.go, true)
			MaterialMgr.setCell(MatType.Pet, v.raceId, cell.con)
		end
	end
end

function GoddessTrialSuperView:_updateStageCell(cell, data, index)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local selectGo = goutil.findChild(go, "select")
	local scoreGo = goutil.findChild(go, "score")
	local txtScore = goutil.findChildTextComponent(scoreGo, "txt")
	local score = GoddessTrialModel.instance:getSuperStageScore(self._activityId, self._stepId, data.stageId)

	txtScore.text = score > 0 and langPara("最高分：<color=#6fffc3>%d</color>", score) or lang("未通关")

	GameUtil.SetActive(selectGo, data.stageId == self._curStageId)

	local creepCfg = GoddessTrialConfig.instance:getCreepsCfg(data.creepsMasterId)
	local showPetRaceId = creepCfg[1].raceId

	MaterialMgr.setIcon(con, MatType.Pet, showPetRaceId)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickStage(data.stageId)
	end, self)
end

function GoddessTrialSuperView:_onClickPrize()
	UIStateManager.instance:push(ViewName.GoddessTrialPrizeView, self._activityId)
end

function GoddessTrialSuperView:_onClickChallenge()
	GoddessTrialController.instance:openSuperMissionView(self._activityId, self._curStageId)
end

function GoddessTrialSuperView:_onClickStage(stageId)
	self._curStageId = stageId

	self:_refreshView()
end

function GoddessTrialSuperView:_onClickTip()
	TipsFacade.instance:openRulesView("goddess_trial_rule")
end

return GoddessTrialSuperView
