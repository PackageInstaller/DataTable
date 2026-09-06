-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/model/FunCampFightMo.lua

module("logic.extensions.funcamp.model.FunCampFightMo", package.seeall)

local FunCampFightMo = class("FunCampFightMo", BaseModel)

function FunCampFightMo:ctor()
	return
end

function FunCampFightMo:onInit()
	self:onReset()
end

function FunCampFightMo:onReset()
	self._allPetList = nil
	self._curPetMap = {}
	self.formationMo = nil
end

function FunCampFightMo:GetAllPetList()
	if self._allPetList == nil then
		self:initPetList()
	end

	return self._allPetList
end

function FunCampFightMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local supPetMo = self:getSupPet()
	local list = {}

	self._curPetMap = {}

	for k, v in pairs(pets) do
		if v then
			table.insert(list, v)

			self._curPetMap[v.petId] = v
		end
	end

	if supPetMo then
		table.insert(list, supPetMo)

		self._curPetMap[supPetMo.petId] = supPetMo
	end

	self._allPetList = list
end

function FunCampFightMo:getSupPet()
	local campId = FunCampModel.instance:getCampId()
	local actId = FunCampModel.instance:getActivityId()
	local cfg = FunCampNpcConfig.instance:getCampSupPetInfo(actId, campId)
	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(cfg)

	local petMo = fMo:toBaseBagPetMo()

	petMo.isSupportedPet = true
	petMo.hideZdl = true

	return petMo
end

function FunCampFightMo:GetCurFormation(newForm)
	self.formationMo = self.formationMo or newForm

	return self.formationMo
end

function FunCampFightMo:getPetMo(petId)
	if self._allPetList == nil then
		self:initPetList(self._curActId)
	end

	if self._curPetMap then
		return self._curPetMap[petId]
	end

	return nil
end

FunCampFightMo.instance = FunCampFightMo.New()

return FunCampFightMo
