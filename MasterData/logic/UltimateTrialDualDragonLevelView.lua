-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/UltimateTrialDualDragonLevelView.lua

module("logic.extensions.divinedualdragonclg.view.UltimateTrialDualDragonLevelView", package.seeall)

local UltimateTrialDualDragonLevelView = class("UltimateTrialDualDragonLevelView", DivineDualDragonClgLevelView)

function UltimateTrialDualDragonLevelView:buildUI()
	UltimateTrialDualDragonLevelView.super.buildUI(self)
	self:_recordGoDefaultActive(self._prizeGo)
end

function UltimateTrialDualDragonLevelView:onEnter()
	UltimateTrialDualDragonLevelView.super.onEnter(self)

	self._isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(self._activityId)

	if self._isUltTrialClg then
		GameUtil.SetActive(self._prizeGo, false)
	else
		self:_refreshDefaultActive(self._prizeGo)
	end
end

function UltimateTrialDualDragonLevelView:_onClickArea(index)
	if UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId) then
		return
	end

	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(self._activityCfg.phasePlanId, self._phaseId)
	local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(phaseCfg.stagePlanId)
	local stageCfg = stagePlanCfg[index]

	if stageCfg.finalStage == true then
		if not DivineDualDragonClgController.instance:checkNormalStagePass(self._activityId, self._phaseId) then
			FloatWordMgr.instance:show(lang("未通关其余关卡"))
		else
			DivineDualDragonClgController.instance:openUltimateTrialFinalMissionView(self._activityId, self._phaseId, index)
		end
	else
		DivineDualDragonClgController.instance:openUltimateTrialNormalMissionView(self._activityId, self._phaseId, index)
	end
end

function UltimateTrialDualDragonLevelView:isShowPassZdl()
	return true
end

function UltimateTrialDualDragonLevelView:isCanSeePassStage()
	return true
end

function UltimateTrialDualDragonLevelView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function UltimateTrialDualDragonLevelView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function UltimateTrialDualDragonLevelView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

return UltimateTrialDualDragonLevelView
