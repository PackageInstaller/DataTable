-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/model/FemalePsychicChallengeFmtMo.lua

module("logic.extensions.femalepsychic.model.FemalePsychicChallengeFmtMo", package.seeall)

local FemalePsychicChallengeFmtMo = class("FemalePsychicChallengeFmtMo", ICustomFmtMo)

function FemalePsychicChallengeFmtMo:onReset()
	FemalePsychicChallengeFmtMo.super.onReset(self)
end

function FemalePsychicChallengeFmtMo:initParams(activityId, challengeId, stageId)
	self._activityId = activityId
	self._challengeId = challengeId
	self._stageIdId = stageId
end

function FemalePsychicChallengeFmtMo:updateData()
	self.isShowOneKey = false

	local info = FemalePsychicChallengeConfig.instance:getStageChallengeDetailCfg(self._activityId, self._challengeId, self._stageIdId)
	local cfg = FemalePsychicChallengeConfig.instance:getChallengeMasterCfg(info.creepsMasterId)
	local actCfg = FemalePsychicChallengeConfig.instance:getActivityCfgById(self._activityId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = info.rule

	if actCfg.raceIdShouldOnForm then
		local nameList = {}

		if info.raceId then
			for i, raceId in ipairs(info.raceId) do
				table.insert(nameList, MaterialMgr.getMaterialsName(MatType.Pet, raceId))
			end
		end

		self.validatorDescStr = string.format("必须上阵%s精灵", table.concat(nameList, "、"))
	else
		self.validatorDescStr = ""
	end

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
end

function FemalePsychicChallengeFmtMo:initFightHandler()
	local function handler()
		FemalePsychicController.instance:fightResult(self._challengeId)

		local simpleForm = self:getCurSimpleForm()

		FemalePsychicController.instance:sendPM_FemalePsychicChallengeReq(self._activityId, self._challengeId, self._stageIdId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function FemalePsychicChallengeFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local cfg = FemalePsychicChallengeConfig.instance:getStageChallengeDetailCfg(self._activityId, self._challengeId, self._stageIdId)

	if cfg.supportPetId > 0 then
		local supportPetCfg = FemalePsychicChallengeConfig.instance:getSupportCfg(cfg.supportPetId)

		if not self._fpFmo then
			local fmo = FightingPowerPetMo.New()

			self._fpFmo = fmo

			fmo:fromChallengeCreepCo(supportPetCfg)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function FemalePsychicChallengeFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function FemalePsychicChallengeFmtMo:getMonsterConfigList()
	local info = FemalePsychicChallengeConfig.instance:getStageChallengeDetailCfg(self._activityId, self._challengeId, self._stageIdId)

	return FemalePsychicChallengeConfig.instance:getStageCreepsCfg(info.creepsMasterId)
end

function FemalePsychicChallengeFmtMo:getFmtInfoConfig()
	local info = FemalePsychicChallengeConfig.instance:getStageChallengeDetailCfg(self._activityId, self._challengeId, self._stageIdId)

	return (FemalePsychicChallengeConfig.instance:getChallengeMasterCfg(info.creepsMasterId))
end

return FemalePsychicChallengeFmtMo
