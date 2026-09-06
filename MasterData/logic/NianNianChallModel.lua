-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/model/NianNianChallModel.lua

module("logic.extensions.niannianchall.model.NianNianChallModel", package.seeall)

local NianNianChallModel = class("NianNianChallModel", BaseModel)

function NianNianChallModel:ctor()
	return
end

function NianNianChallModel:onInit()
	self:onReset()
end

function NianNianChallModel:onReset()
	self.resetInfo = {}
	self.stageId = 1
	self.supportPetCfg = nil
	self.hasGetInfo = false
	self.allClear = true
	self._supportPet = nil
	self.allPetList = nil
	self.challengeTimes = 0
	self.buyTimes = 0
	self.buffLevel = 0
	self.growthPath = 0
	self.petRankSize = 0
	self.processPrize = {}
	self._formation = FormationMO.New(function(id)
		return NianNianChallModel.instance:getPet(id)
	end)
	self._tempFormation = FormationMO.New(function(id)
		return NianNianChallModel.instance:getPet(id)
	end)
end

function NianNianChallModel:setHasGetInfo(torf)
	self.hasGetInfo = torf
end

function NianNianChallModel:getHasGetInfo()
	return self.hasGetInfo
end

function NianNianChallModel:setAllClear(torf)
	self.allClear = torf
end

function NianNianChallModel:getAllClear()
	return self.allClear
end

function NianNianChallModel:setStageId(id)
	self.stageId = id
end

function NianNianChallModel:getStageId()
	return self.stageId
end

function NianNianChallModel:setChallengeTimes(challengeTimes)
	self.challengeTimes = challengeTimes
end

function NianNianChallModel:getChallengeTimes()
	return self.challengeTimes
end

function NianNianChallModel:setBuyTimes(buyTimes)
	self.buyTimes = buyTimes
end

function NianNianChallModel:getBuyTimes()
	return self.buyTimes
end

function NianNianChallModel:setBuffLevel(buffLevel)
	self.buffLevel = buffLevel
end

function NianNianChallModel:getBuffLevel()
	return self.buffLevel
end

function NianNianChallModel:setGotBuff(gotBuff)
	self.gotBuff = gotBuff
end

function NianNianChallModel:getGotBuff()
	return self.gotBuff
end

function NianNianChallModel:setProcessPrize(i)
	self.processPrize[i] = true
end

function NianNianChallModel:getProcessPrize(i)
	return self.processPrize[i] or false
end

function NianNianChallModel:setGrowthPath(growthPath)
	self.growthPath = checknumber(growthPath)
end

function NianNianChallModel:getGrowthPath()
	return self.growthPath
end

function NianNianChallModel:setPetRankSize(petRankSize)
	self.petRankSize = checknumber(petRankSize)
end

function NianNianChallModel:getPetRankSize()
	return self.petRankSize
end

function NianNianChallModel:createPet()
	local creepCfg = self:getSupportPetCfg()
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	petMo.isSupportedPet = true
	self._supportPet = petMo
end

function NianNianChallModel:getSupportPet()
	if self._supportPet == nil then
		self:createPet()
	end

	return self._supportPet
end

function NianNianChallModel:getSupportPetCfg()
	return self.supportPetCfg
end

function NianNianChallModel:setSupportPetCfg(cfg)
	self.supportPetCfg = cfg
end

function NianNianChallModel:setFormation()
	self._teamId = self._teamId or 1

	if self._tempFormation:isEmpty() then
		self._tempFormation:Clone(FormationNewModel.instance:GetCurTeam():GetCurFormation())
	end

	self._formation:Clone(self._tempFormation)

	if self:getSupportPetCfg() then
		self:createPet()
		self._formation:SetPosition(self.supportPetCfg.posId, self.supportPetCfg.creepsId)
	end

	self.allPetList = nil
end

function NianNianChallModel:getFormation()
	return self._formation
end

function NianNianChallModel:getAllPets(force)
	if force or self.allPetList == nil then
		local pets = BagPetsController.instance:getFightBagPet()

		table.insert(pets, self:getSupportPet())

		self.allPetList = pets
	end

	return self.allPetList
end

function NianNianChallModel:getPet(petId)
	if not petId or petId == 0 then
		return
	end

	local mo = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	local list = self:getAllPets()

	for i, v in ipairs(list) do
		if v.petId == petId then
			if mo then
				v.summonMasterId = mo.summonMasterId
				v.summonedPetId = mo.summonedPetId
			end

			return v
		end
	end

	if self:getSupportPetCfg() and self.supportPetCfg.creepsId == petId then
		return self:getSupportPet(petId)
	end

	return nil
end

function NianNianChallModel:getDiffRacePetNum()
	local pets = self:getAllPets()

	ArraySort.sortOn(pets, "raceId")

	local lastId = -1
	local num = 0

	for i, v in ipairs(pets) do
		if lastId ~= v.raceId then
			lastId = v.raceId
			num = num + 1
		end
	end

	return num
end

NianNianChallModel.instance = NianNianChallModel.New()

return NianNianChallModel
