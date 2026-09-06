-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/model/FanRuiLifeCustomFmtMo.lua

module("logic.extensions.fanruichallenge.model.FanRuiLifeCustomFmtMo", package.seeall)

local FanRuiLifeCustomFmtMo = class("FanRuiLifeCustomFmtMo", ICustomFmtMo)

function FanRuiLifeCustomFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local cfgStage = FanRuiChallengeConfig.instance:getLifeClgStageCfg(activityId, stageId)

	self._monsterCfg = FanRuiChallengeConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = FanRuiChallengeConfig.instance:getCreepsCfgs(cfgStage.creepsMasterId)
end

function FanRuiLifeCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function FanRuiLifeCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function FanRuiLifeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function FanRuiLifeCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		FanRuiChallengeAgent.instance:sendPM_FanRuiClgFightThemeLifeReq(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function FanRuiLifeCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function FanRuiLifeCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function FanRuiLifeCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

return FanRuiLifeCustomFmtMo
