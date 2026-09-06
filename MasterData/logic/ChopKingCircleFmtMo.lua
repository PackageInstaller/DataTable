-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/model/ChopKingCircleFmtMo.lua

module("logic.extensions.chopking.model.ChopKingCircleFmtMo", package.seeall)

local ChopKingCircleFmtMo = class("ChopKingCircleFmtMo", BaseCustomFmtMo)

function ChopKingCircleFmtMo:initParams(activityId, stagId)
	self._activityId = activityId
	self._stageId = stagId

	local cfgStage = ChopKingConfig.instance:getCircleClgCfg(self._activityId, self._stageId)

	self._monsterCfg = ChopKingConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = ChopKingConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	local activityCfg = ChopKingConfig.instance:getActivityCfg(self._activityId)

	self._supportPetIdList = {
		activityCfg.creepsId
	}

	local supportPetCfg = ChopKingConfig.instance:getSupportPetCfg(self._activityId, activityCfg.creepsId)

	self._mustRaceId = supportPetCfg.raceId

	if stagId == 1 then
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_UserSet
		self.strShowRuleFlagKey = string.format("ChopKingCircleFmtMo#%d", self._activityId)

		GameUtil.saveUserData(self.strShowRuleFlagKey, true)
	else
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	end
end

function ChopKingCircleFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	for i, creepsId in ipairs(self._supportPetIdList) do
		local cfgSupport = ChopKingConfig.instance:getSupportPetCfg(self._activityId, creepsId)

		if cfgSupport then
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(cfgSupport)
			fmo:setSupportedPet(true)

			local supportPetMo = fmo:toBaseBagPetMo()

			self:addPetToList(self:_changePetMo(supportPetMo))
		end
	end
end

function ChopKingCircleFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		ChopKingAgent.instance:sendPM_ChopKingCircleClgFightReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function ChopKingCircleFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function ChopKingCircleFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function ChopKingCircleFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local curFormation = self:getCurFormation()

	if not curFormation:HasRace(self._mustRaceId) then
		local petCfg = CharacterConfig.instance:getPetCo(self._mustRaceId)

		FloatWordMgr.instance:show(langPara("必须上阵%s", petCfg.name))

		return true
	end

	return ChopKingCircleFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

local emptyTb = {}
local oneTb = {}

function ChopKingCircleFmtMo:getPsychicsPets()
	local formationMo = self:getCurFormation()

	if formationMo:HasRace(self._mustRaceId) then
		local hasPets = self:getCurFormation():getHasPets()
		local targetPetMo

		for i, petId in pairs(hasPets) do
			local mo = self:getPetMoById(petId)

			if mo and mo:getDefineId() == self._mustRaceId then
				targetPetMo = mo
			end
		end

		oneTb[1] = targetPetMo

		return oneTb
	end

	return emptyTb
end

function ChopKingCircleFmtMo:onFmoSetDown()
	ChopKingCircleFmtMo.super.onFmoSetDown(self)

	if self:getCurFormation():GetPsychicedSkillId() ~= 0 then
		local hasPets = self:getCurFormation():getHasPets()
		local targetPetMo

		for i, petId in pairs(hasPets) do
			local mo = self:getPetMoById(petId)

			if mo and mo:getDefineId() == self._mustRaceId then
				targetPetMo = mo
			end
		end

		if targetPetMo then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(targetPetMo.curFaceId)

			if petCo then
				self:getCurFormation():SetPsychicedSkillId(petCo.psychicSkillId)
			else
				self:getCurFormation():SetPsychicedSkillId(0)
			end
		else
			self:getCurFormation():SetPsychicedSkillId(0)
		end
	end
end

return ChopKingCircleFmtMo
