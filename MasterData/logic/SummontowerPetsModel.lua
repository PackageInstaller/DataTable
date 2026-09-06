-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummontowerPetsModel.lua

module("logic.extensions.summer.model.SummontowerPetsModel", package.seeall)

local SummontowerPetsModel = class("SummontowerPetsModel", BaseModel)

SummontowerPetsModel.PetType = {
	SolicitPet = 3,
	SummonedAnimal = 2,
	SummonMaster = 1
}

function SummontowerPetsModel:onInit()
	self:onReset()
end

function SummontowerPetsModel:onReset()
	self._petsCfg = nil
	self._summonMasterPetId = 0
	self._summonedAnimalPetId = 0
end

function SummontowerPetsModel:setPets(pets)
	self._petsCfg = {}
	self._pets = {}
	self._summonMasterPetId = 0
	self._summonedAnimalPetId = 0

	if not pets then
		return
	end

	for i = 1, #pets do
		self._petsCfg[pets[i].petId] = pets[i]

		if pets[i].type == SummontowerPetsModel.PetType.SummonMaster then
			self._summonMasterPetId = pets[i].petId
		elseif pets[i].type == SummontowerPetsModel.PetType.SummonedAnimal then
			self._summonedAnimalPetId = pets[i].petId
		end

		self._pets[pets[i].petId] = self:_createPet(pets[i])
	end

	self:_handleSummonInfo()
end

function SummontowerPetsModel:_createPet(petCfg)
	local creepCo = SummontowerConfig.instance:getPetCo(petCfg.creepsId)
	local fightingMo = FightingPowerPetMo.New(creepCo.raceId, creepCo.lv)

	fightingMo:fromChallengeCreepCo(creepCo)

	local bagPetMo = fightingMo:toBaseBagPetMo()

	bagPetMo.petId = petCfg.petId

	return bagPetMo
end

function SummontowerPetsModel:_handleSummonInfo()
	if not self._pets then
		return
	end

	local dirty0 = false
	local dirty1 = false

	for k, v in pairs(self._pets) do
		if v.summonedPetId > 0 then
			v.summonedPetId = self._summonedAnimalPetId
			dirty0 = true
		end

		if v.summonMasterId > 0 then
			v.summonMasterId = self._summonMasterPetId
			dirty1 = true
		end

		if dirty0 and dirty1 then
			break
		end
	end
end

function SummontowerPetsModel:isSummonMasterPet(summonMasterPetId)
	return self._summonMasterPetId == summonMasterPetId
end

function SummontowerPetsModel:isSummonedAnimalPet(summonedAnimalPetId)
	return self._summonedAnimalPetId == summonedAnimalPetId
end

function SummontowerPetsModel:getFmtedPetsCount()
	local allPets = self:getAllPets()
	local raceIdsMap = {}

	for i = 1, #allPets do
		raceIdsMap[allPets[i].raceId] = true
	end

	return table.nums(raceIdsMap)
end

function SummontowerPetsModel:isPetNumMax()
	return #self:getAllPets() >= checknumber(SummontowerConfig.instance:getParamsString("SELF_MAX_PET_COUNT"))
end

function SummontowerPetsModel:getAllPets()
	local allPets = {}

	if self._pets then
		for k, v in pairs(self._pets) do
			allPets[#allPets + 1] = v
		end
	end

	return allPets
end

function SummontowerPetsModel:getPetCfg(petId)
	if self._petsCfg then
		return self._petsCfg[petId]
	end
end

function SummontowerPetsModel:getAllPetCfg()
	return self._petsCfg
end

function SummontowerPetsModel:getAllPetCfgList()
	local allPets = {}

	if self._petsCfg then
		for k, v in pairs(self._petsCfg) do
			allPets[#allPets + 1] = v
		end
	end

	return allPets
end

function SummontowerPetsModel:getPets()
	return self._pets
end

function SummontowerPetsModel:getPet(petId)
	if self._pets then
		return self._pets[petId]
	end
end

function SummontowerPetsModel:getSummonMasterLevel()
	local creepsId = self:getSummonMasterCreepId()

	if creepsId then
		return 0
	end

	local petCo = SummontowerConfig.instance:getPetCo(creepsId)

	return petCo.lv
end

function SummontowerPetsModel:getSummonMasterCreepId()
	if self._summonMasterPetId == 0 then
		return 0
	end

	local petData = self:getPetCfg(self._summonMasterPetId)

	if not petData then
		return 0
	end

	return petData.creepsId
end

SummontowerPetsModel.instance = SummontowerPetsModel.New()

return SummontowerPetsModel
