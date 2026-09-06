-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/model/GoddessTrialSuperFmtMo.lua

module("logic.extensions.goddesstrial.model.GoddessTrialSuperFmtMo", package.seeall)

local GoddessTrialSuperFmtMo = class("GoddessTrialSuperFmtMo", BaseCustomFmtMo)

function GoddessTrialSuperFmtMo:initParams(activityId, stepId, stageId)
	self.activityId = activityId
	self.stepId = stepId
	self.stageId = stageId

	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self.activityId, self.stepId)
	local stageCfg = GoddessTrialConfig.instance:getSuperStageCfg(stepCfg.normalTrialPlanId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self.selectSeedMap = {}
	self._cfgEnemy = GoddessTrialConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = GoddessTrialConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function GoddessTrialSuperFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		GoddessTrialController.instance:sendPM_GoddessTrialSuperFightReq(self.activityId, self.stepId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GoddessTrialSuperFmtMo:getMonsterConfigList()
	return self._masterList
end

function GoddessTrialSuperFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GoddessTrialSuperFmtMo:updateCellTop(cell, petMo)
	local luaCls = GoddessTrialSuperFmtRightCell
	local url = GoddessTrialSuperFmtRightCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:setData(petMo)
	end
end

function GoddessTrialSuperFmtMo:clearCellTop(cell)
	MaterialMgr.resetAll(cell)
end

function GoddessTrialSuperFmtMo:getExtendViewName()
	return ViewName.GoddessTrialSuperFmtView
end

return GoddessTrialSuperFmtMo
