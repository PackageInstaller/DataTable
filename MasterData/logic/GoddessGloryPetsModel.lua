-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryPetsModel.lua

module("logic.extensions.goddessglory.model.GoddessGloryPetsModel", package.seeall)

local GoddessGloryPetsModel = class("GoddessGloryPetsModel", BaseModel)

function GoddessGloryPetsModel:onInit()
	self:onReset()
end

function GoddessGloryPetsModel:onReset()
	self._pets = nil
	self._mutiBodyMap = {}
end

function GoddessGloryPetsModel:setPets(challengeId, stageId, pets)
	self._pets = self._pets or {}
	self._pets[challengeId] = self._pets[challengeId] or {}
	self._pets[challengeId][stageId] = {}

	if not pets then
		return
	end

	for i = 1, #pets do
		self._pets[challengeId][stageId][pets[i]] = self:_createPet(pets[i])
	end
end

function GoddessGloryPetsModel:_createPet(petId)
	local creepCo = GoddessGloryConfig.instance:getSupportPetCo(petId)

	if creepCo then
		local fightingMo = FightingPowerPetMo.New(creepCo.raceId, creepCo.lv)

		fightingMo:fromChallengeCreepCo(creepCo)

		local bagPetMo = fightingMo:toBaseBagPetMo()

		bagPetMo.petId = petId
		bagPetMo.isSupportedPet = true

		return bagPetMo
	else
		local mo = FightingPowerPetMo.getMaxPetMoByData(BagPetsController.instance:getPet(petId))

		if mo then
			mo.summonMasterId = 0
			mo.summonedPetId = 0

			if PetSkinConfig.instance:checkHasMutiBody(mo.raceId) then
				self._mutiBodyMap[mo.petId] = true
			end
		end

		return mo
	end
end

function GoddessGloryPetsModel:checkMutiPet(petId)
	return self._mutiBodyMap[petId] == true
end

function GoddessGloryPetsModel:addPet(challengeId, stageId, petId)
	self._pets[challengeId] = self._pets[challengeId] or {}
	self._pets[challengeId][stageId] = self._pets[challengeId][stageId] or {}
	self._pets[challengeId][stageId][petId] = self:_createPet(petId)
end

function GoddessGloryPetsModel:clearPets(challengeId, stageId)
	if self._pets and self._pets[challengeId] then
		self._pets[challengeId][stageId] = nil
	end
end

function GoddessGloryPetsModel:getAllPets(challengeId, stageId)
	local allPets = {}
	local pets = self:getPets(challengeId, stageId)

	if pets then
		for k, v in pairs(pets) do
			if self:checkMutiPet(v.petId) then
				local mo = FightingPowerPetMo.getMaxPetMoByData(BagPetsController.instance:getPet(v.petId))

				mo.summonMasterId = 0
				mo.summonedPetId = 0
				allPets[#allPets + 1] = mo
			else
				allPets[#allPets + 1] = v
			end
		end
	end

	return allPets
end

function GoddessGloryPetsModel:hasPet(challengeId, stageId)
	local pets = self:getPets(challengeId, stageId)

	if pets then
		for k, v in pairs(pets) do
			return true
		end
	end

	return false
end

function GoddessGloryPetsModel:getPetsCount(challengeId, stageId)
	local pets = self:getPets(challengeId, stageId)

	if pets then
		local raceIdsMap = {}

		for k, v in pairs(pets) do
			raceIdsMap[v.raceId] = true
		end

		return table.nums(raceIdsMap)
	end

	return 0
end

function GoddessGloryPetsModel:getPets(challengeId, stageId)
	if self._pets then
		local pets

		return (self._pets[challengeId] and self._pets[challengeId][stageId] or nil) and self._pets[challengeId][stageId]
	end
end

function GoddessGloryPetsModel:getPet(challengeId, stageId, petId)
	local pets = self:getPets(challengeId, stageId)

	if pets then
		if self:checkMutiPet(petId) then
			local mo = FightingPowerPetMo.getMaxPetMoByData(BagPetsController.instance:getPet(petId))

			mo.summonMasterId = 0
			mo.summonedPetId = 0
			pets[petId] = mo
		end

		return pets[petId]
	end
end

GoddessGloryPetsModel.instance = GoddessGloryPetsModel.New()

return GoddessGloryPetsModel
