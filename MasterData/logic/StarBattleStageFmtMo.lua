-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/model/StarBattleStageFmtMo.lua

module("logic.extensions.starbattle.model.StarBattleStageFmtMo", package.seeall)

local StarBattleStageFmtMo = class("StarBattleStageFmtMo", BaseCustomFmtMo)

function StarBattleStageFmtMo:initParams(activityId, periodId, stageId)
	self.activityId = activityId
	self.periodId = periodId
	self.stageId = stageId
	self.preiodCfg = StarBattleConfig.instance:getPeriodCfg(self.activityId, self.periodId)
	self.stageCfg = StarBattleConfig.instance:getStageCfgByStageId(self.preiodCfg.stagePlanId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = StarBattleConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = StarBattleConfig.instance:getCreepCfgs(creepsMasterId)
	self.helpCfgs = StarBattleConfig.instance:getSupportPetCfgs(self.preiodCfg.supportPlanId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
end

function StarBattleStageFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		StarBattleController.instance:startStageChallenge(self.activityId, self.stageId, simpleForm, self.periodId)
	end

	self:setFightHandler(handler, nil)
end

function StarBattleStageFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self.helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(self.helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function StarBattleStageFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function StarBattleStageFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function StarBattleStageFmtMo:getFmtInfoConfig()
	return self._masterData
end

return StarBattleStageFmtMo
