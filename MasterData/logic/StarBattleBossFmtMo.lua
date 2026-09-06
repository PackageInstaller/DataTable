-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/model/StarBattleBossFmtMo.lua

module("logic.extensions.starbattle.model.StarBattleBossFmtMo", package.seeall)

local StarBattleBossFmtMo = class("StarBattleBossFmtMo", BaseCustomFmtMo)

function StarBattleBossFmtMo:initParams(activityId, periodId, bossId)
	self.activityId = activityId
	self.periodId = periodId
	self.bossId = bossId
	self.preiodCfg = StarBattleConfig.instance:getPeriodCfg(self.activityId, self.periodId)
	self.bossCfg = StarBattleConfig.instance:getBossCfgById(self.preiodCfg.bossPlanId, self.bossId)

	local creepsMasterId = self.bossCfg.creepsMasterId

	self._masterData = StarBattleConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = StarBattleConfig.instance:getCreepCfgs(creepsMasterId)
	self.helpCfgs = StarBattleConfig.instance:getSupportPetCfgs(self.preiodCfg.supportPlanId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
end

function StarBattleBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		StarBattleController.instance:startBossChallenge(self.activityId, simpleForm, self.bossId, self.periodId)
	end

	self:setFightHandler(handler, nil)
end

function StarBattleBossFmtMo:initPetList()
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

function StarBattleBossFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function StarBattleBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function StarBattleBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function StarBattleBossFmtMo:getExtendViewName()
	return ViewName.StarBattleBossFmtExView
end

return StarBattleBossFmtMo
