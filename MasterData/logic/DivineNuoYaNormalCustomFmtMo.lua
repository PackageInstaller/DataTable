-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/model/DivineNuoYaNormalCustomFmtMo.lua

module("logic.extensions.divinenuoyachallenge.model.DivineNuoYaNormalCustomFmtMo", package.seeall)

local DivineNuoYaNormalCustomFmtMo = class("DivineNuoYaNormalCustomFmtMo", ICustomFmtMo)

function DivineNuoYaNormalCustomFmtMo:initParams(activityId, stageId, planId)
	self._isChangePlanId = self._planId and self._planId ~= planId
	self._activityId = activityId
	self._stageId = stageId
	self._planId = planId

	local cfgStage = DivineNuoYaChallengeConfig.instance:getNormalStage(activityId, stageId)

	self._monsterCfg = DivineNuoYaChallengeConfig.instance:getMaster(cfgStage.creepsMasterId)
	self._creepsCfgs = DivineNuoYaChallengeConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self._supportPetCount = cfgStage.supportPetCount
end

function DivineNuoYaNormalCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc
	self.validatorDescStr = string.format("从助阵阵容挑选任意%d只精灵上阵", self._supportPetCount)
	self.validatorDescIsShowYesOrNo = true

	self:setFormCondition(self._monsterCfg.formCondition)

	if self._isChangePlanId then
		self:initPetList()
	end
end

function DivineNuoYaNormalCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaClgNormalFightReq(self._activityId, form, self._planId)
	end

	self:setFightHandler(handler, nil)
end

function DivineNuoYaNormalCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineNuoYaNormalCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DivineNuoYaNormalCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(bagPetMoList) do
		self:addPetToList(petMo)
	end

	local helpCfgs = DivineNuoYaChallengeConfig.instance:getSupportPetList(self._activityId, self._planId)

	if helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function DivineNuoYaNormalCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineNuoYaNormalCustomFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local isMatchSupportPet = self:_getSupportNum() == self._supportPetCount

	if isMatchSupportPet then
		return DivineNuoYaNormalCustomFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	else
		FloatWordMgr.instance:show(string.format("必须上阵%d只助战精灵", self._supportPetCount))

		return true
	end
end

function DivineNuoYaNormalCustomFmtMo:onFormationChangeFinish()
	local isMatchSupportPet = self:_getSupportNum() == self._supportPetCount

	self:setValidatorDescYesOrNo(isMatchSupportPet)
end

function DivineNuoYaNormalCustomFmtMo:_getSupportNum()
	local formation = self:getCurFormation()
	local poses = formation:GetPositions()
	local supportNum = 0

	for i, id in ipairs(poses) do
		if id > 0 then
			local petMo = self:getPetMoById(id)

			if petMo and petMo.isSupportedPet then
				supportNum = supportNum + 1
			end
		end
	end

	return supportNum
end

function DivineNuoYaNormalCustomFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

return DivineNuoYaNormalCustomFmtMo
