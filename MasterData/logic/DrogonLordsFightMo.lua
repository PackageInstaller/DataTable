-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/model/DrogonLordsFightMo.lua

module("logic.extensions.dragonlords.model.DrogonLordsFightMo", package.seeall)

local DrogonLordsFightMo = class("DrogonLordsFightMo", BaseModel)

function DrogonLordsFightMo:ctor()
	return
end

function DrogonLordsFightMo:onInit()
	self:onReset()
end

function DrogonLordsFightMo:onReset()
	self._allPetList = nil
	self._curPetMap = {}
	self.formationMo = {}
	self._limitAllPetList = nil
	self._limitCurPetMap = {}
	self.limitFormationMo = {}
end

function DrogonLordsFightMo:getLimitAllPetList()
	if self._limitAllPetList == nil then
		self:initLimitPetList()
	end

	return self._limitAllPetList
end

function DrogonLordsFightMo:initLimitPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local list = {}

	self._limitCurPetMap = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	for k, v in pairs(pets) do
		if v then
			table.insert(list, v)

			self._limitCurPetMap[v.petId] = v
		end
	end

	self._limitAllPetList = list
end

function DrogonLordsFightMo:GetAllPetList()
	if self._allPetList == nil then
		self:initPetList()
	end

	return self._allPetList
end

function DrogonLordsFightMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local supPetMo = self:getSupPet()
	local list = {}

	self._curPetMap = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

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

function DrogonLordsFightMo:getSupPet()
	local stageInfo = DrogonLordsModel.instance:getNormalStageInfo()
	local stageCfg = DragonLordsConfig.instance:getNormolStageInfo(stageInfo.curstagePlanId, stageInfo.curStageId)
	local cfg = DragonLordsConfig.instance:getSupPet(stageCfg.helpPetPlanId)
	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(cfg)

	local petMo = fMo:toBaseBagPetMo()

	petMo.isSupportedPet = true
	petMo.hideZdl = true

	return petMo
end

function DrogonLordsFightMo:GetCurFormation(challengeId)
	self.formationMo[challengeId] = self.formationMo[challengeId] or FormationMO.New(GameUtil.handler(self.getPetMo, self))

	return self.formationMo[challengeId]
end

function DrogonLordsFightMo:getLimitFormation()
	local stageId = DrogonLordsModel.instance:getCurLimitStage()

	self.limitFormationMo[stageId] = self.limitFormationMo[stageId] or FormationMO.New(GameUtil.handler(self.getLimitPetMo, self))

	return self.limitFormationMo[stageId]
end

function DrogonLordsFightMo:getPetMo(petId)
	if self._allPetList == nil then
		self:initPetList()
	end

	if self._curPetMap then
		return self._curPetMap[petId]
	end

	return nil
end

function DrogonLordsFightMo:getLimitPetMo(petId)
	if self._limitAllPetList == nil then
		self:initLimitPetList()
	end

	if self._limitCurPetMap then
		return self._limitCurPetMap[petId]
	end

	return nil
end

DrogonLordsFightMo.instance = DrogonLordsFightMo.New()

return DrogonLordsFightMo
