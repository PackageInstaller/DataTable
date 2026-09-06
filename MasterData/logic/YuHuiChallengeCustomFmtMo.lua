-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/model/YuHuiChallengeCustomFmtMo.lua

module("logic.extensions.yuhuichallenge.model.YuHuiChallengeCustomFmtMo", package.seeall)

local YuHuiChallengeCustomFmtMo = class("YuHuiChallengeCustomFmtMo", ICustomFmtMo)

function YuHuiChallengeCustomFmtMo:initParams(creepsCfg, challengeId)
	self._challengeId = challengeId
	self._creepsCfg = creepsCfg
	self._masterList = YuHuiChallengeConfig.instance:getCreepsMasterCfgs(self._creepsCfg.creepsMasterId)
	self.topTitleStr = self._creepsCfg.name
	self.validatorDescStr = self._creepsCfg.ruleDesc
end

function YuHuiChallengeCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		YuHuiChallengeController.instance:challengeFight(self._challengeId, self._creepsCfg.modeId, self:getCurFormation())
	end

	self:setFightHandler(handler, nil)
end

function YuHuiChallengeCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function YuHuiChallengeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function YuHuiChallengeCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function YuHuiChallengeCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

function YuHuiChallengeCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

return YuHuiChallengeCustomFmtMo
