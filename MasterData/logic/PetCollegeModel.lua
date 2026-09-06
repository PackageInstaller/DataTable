-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/model/PetCollegeModel.lua

module("logic.extensions.petcollege.view.PetCollegeModel", package.seeall)

local PetCollegeModel = class("PetCollegeModel", BaseModel)

function PetCollegeModel:ctor()
	return
end

function PetCollegeModel:onInit()
	self:onReset()
end

function PetCollegeModel:onReset()
	self._processInfos = nil
	self._teamId = 1
	self._buffPlayInfos = {}
	self._skillPlayInfos = {}
end

function PetCollegeModel:setProcessInfos(infos)
	self._processInfos = infos
end

function PetCollegeModel:getCurrPassStageId(challengeId)
	local stageId = 0

	if self._processInfos then
		for k, v in pairs(self._processInfos) do
			if v.challengeId == challengeId then
				stageId = v.stagePass

				break
			end
		end

		local cfgs = PetCollegeConfig.instance:getStageCfg(challengeId)

		stageId = math.min(stageId, #cfgs)
	end

	return stageId
end

function PetCollegeModel:canBattleByRaceId(raceId)
	local canBattle = false
	local challengeId = PetCollegeConfig.instance:raceId2ChallengeId(raceId)

	if challengeId and self._processInfos then
		local cfgs = PetCollegeConfig.instance:getStageCfg(challengeId)
		local num = table.nums(cfgs)

		for k, v in pairs(self._processInfos) do
			if v.challengeId == challengeId and num > v.stagePass then
				canBattle = true

				break
			end
		end
	end

	return canBattle
end

function PetCollegeModel:getBagCount(challengeId, stageId)
	local list = PetCollegeModel.instance:getSupportPetIds(challengeId, stageId)

	return #list
end

function PetCollegeModel:isCurFormationEmpty()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function PetCollegeModel:setCurrChallenge(challengeId, stageId)
	local heavenAwakenMasterId = 0
	local heavenAwakenSummonPetId = 0

	self._buffPlayInfos = {}
	self._skillPlayInfos = {}
	self._currChallengeId, self._currStageId = challengeId, stageId

	local cfgs = PetCollegeConfig.instance:getSupportCfg(challengeId, stageId)
	local list = {}

	for i, v in pairs(cfgs) do
		table.insert(list, v)

		local masterId = checknumber(v.heavenAwakenMasterId)
		local summonId = checknumber(v.heavenAwakenSummonPetId)

		if masterId > 0 then
			heavenAwakenMasterId = masterId
		end

		if summonId > 0 then
			heavenAwakenSummonPetId = summonId
		end
	end

	local pos = {}
	local heroSkills = FightingPowerFormula.instance:getHeroSkills(list)

	for i = 1, 9 do
		pos[i] = 0
	end

	for i, v in ipairs(list) do
		if v.posId ~= 0 then
			pos[v.posId] = v.creepsId
		end
	end

	local var_9_0 = {
		formId = 10,
		pos = pos
	}
	local var_9_1 = {
		psychicSkillId = 0
	}

	var_9_1.heroSkillId = heroSkills[1] or 0
	var_9_0.extParams = var_9_1

	local form = var_9_0

	self:_setFormation(form)
end

function PetCollegeModel:_setFormation(form)
	self._teamId = self._teamId or 1
	self._formation = self._formation or PetCollegeFormationMO.New()

	self._formation:SetData(form)
end

function PetCollegeModel:getFormation()
	return self._formation
end

function PetCollegeModel:getPet(petId, isEnemy)
	return self:createPet(petId, isEnemy)
end

function PetCollegeModel:createPet(petId, isEnemy)
	if isEnemy then
		local var_13_0 = PetCollegeConfig.instance:getEnemyPetCfg(self._currChallengeId, self._currStageId, petId)

		if not var_13_0 then
			var_13_0 = PetCollegeConfig.instance:getMyPetCfg(self._currChallengeId, self._currStageId, petId)

			local spPetCo = var_13_0

			if not spPetCo then
				if petId ~= 0 then
					printError("petId no spPetCo", petId)
				end

				return
			end

			local fPowerPet = FightingPowerPetMo.New()

			fPowerPet:fromChallengeCreepCo(spPetCo)

			local resualt = fPowerPet

			if not isEnemy then
				resualt = fPowerPet:toBaseBagPetMo()
				resualt.petId = petId
			end

			return resualt
		end
	end
end

function PetCollegeModel:getCurFormationId()
	return self._formation:GetId()
end

function PetCollegeModel:getFormPetsHeroSkills()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()
	local heroskills = {}

	for i, petId in ipairs(pet_poisition) do
		if petId > 0 then
			local pet = self:getPet(petId)
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

			if petCo.heroSkillId > 0 and not TableUtil.isHad(heroskills, petCo.heroSkillId) then
				table.insert(heroskills, petCo.heroSkillId)
			end
		end
	end

	return heroskills
end

function PetCollegeModel:getHeroSkillId()
	return self._formation:GetHeroSkillId()
end

function PetCollegeModel:changeSkillId(id)
	self._formation:SetHeroSkillId(id)
end

function PetCollegeModel:getTeamId()
	return self._teamId
end

function PetCollegeModel:getAllPets(isEnemy)
	local allPets = {}
	local supportedPetIds = isEnemy and PetCollegeConfig.instance:getCreepsPetIds(self._currChallengeId, self._currStageId) or PetCollegeConfig.instance:getSupportPetIds(self._currChallengeId, self._currStageId)

	if supportedPetIds then
		for i = 1, #supportedPetIds do
			local petId = supportedPetIds[i]

			allPets[#allPets + 1] = self:createPet(petId, isEnemy)
		end
	end

	return allPets
end

function PetCollegeModel:getPetInTeam(petId)
	return self:getFormation():HasPet(petId)
end

function PetCollegeModel:isStagePass(challengeId, stageId)
	local pass = false

	if self._processInfos then
		for k, v in pairs(self._processInfos) do
			if v.challengeId == challengeId and stageId <= v.stagePass then
				pass = true

				break
			end
		end
	end

	return pass
end

function PetCollegeModel:challengeSuccess(iswin, challengeId, stageId)
	if iswin and self._processInfos then
		for k, v in pairs(self._processInfos) do
			if v.challengeId == challengeId then
				v.stagePass = math.max(v.stagePass, stageId)
			end
		end
	end
end

function PetCollegeModel:playBuff(buffId)
	local pause = false
	local content = ""
	local npcId = 0
	local key = string.format("%s@%s", self._currChallengeId, self._currStageId)
	local data = self._buffPlayInfos[key]

	if not data then
		local info = PetCollegeConfig.instance:getBuffGuide(self._currChallengeId, self._currStageId)

		if not info then
			return false
		end

		data = {
			buffIds = {},
			info = info
		}
		self._buffPlayInfos[key] = data
	end

	if data.buffIds[buffId] then
		return false
	elseif data.info[buffId] then
		pause = true
		data.buffIds[buffId] = true
		content = data.info[buffId]
		npcId = data.info[skillId].npcId
	end

	return pause, content, npcId
end

function PetCollegeModel:playSkill(skillId)
	local pause = false
	local content = ""
	local npcId = 0
	local key = string.format("%s@%s", self._currChallengeId, self._currStageId)
	local data = self._skillPlayInfos[key]

	if not data then
		local info = PetCollegeConfig.instance:getSkillGuide(self._currChallengeId, self._currStageId)

		if not info then
			return false
		end

		data = {
			skillIds = {},
			info = info
		}
		self._skillPlayInfos[key] = data
	end

	if data.skillIds[skillId] then
		return false
	elseif data.info[skillId] then
		pause = true
		data.skillIds[skillId] = true
		content = data.info[skillId].desc
		npcId = data.info[skillId].npcId
	end

	return pause, content, npcId
end

function PetCollegeModel:startGuide()
	local content, npcId = PetCollegeConfig.instance:getstartGuide(self._currChallengeId, self._currStageId)
	local pause = not string.nilorempty(content)

	return pause, content, npcId
end

function PetCollegeModel:getCurrChallengeAndStageId()
	return self._currChallengeId, self._currStageId
end

PetCollegeModel.instance = PetCollegeModel.New()

return PetCollegeModel
