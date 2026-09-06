-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/model/GoddessTrialNormalFmtMo.lua

module("logic.extensions.goddesstrial.model.GoddessTrialNormalFmtMo", package.seeall)

local GoddessTrialNormalFmtMo = class("GoddessTrialNormalFmtMo", BaseCustomFmtMo)

function GoddessTrialNormalFmtMo:onInit()
	GoddessTrialNormalFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
end

function GoddessTrialNormalFmtMo:initParams(activityId, stepId, stageId)
	self.activityId = activityId
	self.stepId = stepId
	self.stageId = stageId

	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self.activityId, self.stepId)
	local stageCfg = GoddessTrialConfig.instance:getNormalStageCfg(stepCfg.normalTrialPlanId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = GoddessTrialConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = GoddessTrialConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function GoddessTrialNormalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		GoddessTrialController.instance:sendPM_GoddessTrialNormalFightReq(self.activityId, self.stepId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GoddessTrialNormalFmtMo:initPetList()
	self:clearAllPetList()

	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self.activityId, self.stepId)
	local supportCfgs = GoddessTrialConfig.instance:getSupportPetCfgs(stepCfg.systemPetPlanId)

	for i, cfgSupport in pairs(supportCfgs) do
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(cfgSupport)
		fmo:setSupportedPet(true)

		local supportPetMo = fmo:toBaseBagPetMo()

		self:addPetToList(supportPetMo)
	end
end

function GoddessTrialNormalFmtMo:getMonsterConfigList()
	return self._masterList
end

function GoddessTrialNormalFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return GoddessTrialNormalFmtMo
