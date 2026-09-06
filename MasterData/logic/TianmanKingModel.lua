-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/TianmanKingModel.lua

module("logic.extensions.timelimitedchallenge.model.TianmanKingModel", package.seeall)

local TianmanKingModel = class("TianmanKingModel", BaseModel)

function TianmanKingModel:onInit()
	TianmanKingModel.super.onInit(self)
	self:onReset()
end

function TianmanKingModel:onReset()
	TianmanKingModel.super.onReset(self)

	self._linearPassedStage = 0
	self._supportPetMap = {}
end

function TianmanKingModel:setTimeOpenPassedStage(timeOpenPassedStage)
	self._timeOpenPassedStage = {
		num = 0
	}

	for i, v in ipairs(timeOpenPassedStage) do
		self._timeOpenPassedStage[v] = true
		self._timeOpenPassedStage.num = self._timeOpenPassedStage.num + 1
	end
end

function TianmanKingModel:getTimeOpenPassedStage()
	return self._timeOpenPassedStage
end

function TianmanKingModel:setLinearPassedStage(linearPassedStage)
	self._linearPassedStage = linearPassedStage
end

function TianmanKingModel:getLinearPassedStage()
	return self._linearPassedStage
end

function TianmanKingModel:isPassedStageAll()
	local count = #TianmanKingConfig.instance:getStageByType(2)

	return count <= self._linearPassedStage
end

function TianmanKingModel:setCurSummon(curSummon)
	self._curSummon = curSummon
end

function TianmanKingModel:getCurSummon()
	return self._curSummon
end

function TianmanKingModel:saveForm(formMo)
	self._formMo = formMo
end

function TianmanKingModel:getForm()
	return self._formMo
end

function TianmanKingModel:getPetMo(petId)
	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	local supportCfg = TianmanKingConfig.instance:getSupportPlanById(1001) or {}
	local creepCfg

	for _, v in pairs(supportCfg) do
		if v.creepsId == petId then
			return self:getSupportPet(v.creepsId, v)
		end
	end
end

function TianmanKingModel:getSupportPet(petId, v)
	local petMo = self._supportPetMap[petId]

	if petMo == nil then
		petMo = self:_createPet(v)
		self._supportPetMap[petId] = petMo
	end

	return petMo
end

function TianmanKingModel:getAllHelpPets(stage)
	local helpPets = {}
	local stageCfg = TianmanKingConfig.instance:getStageByTypeAndStage(2, stage)

	if stageCfg then
		local supportCfg = TianmanKingConfig.instance:getSupportPlanById(1001) or {}

		for _, v in pairs(supportCfg) do
			if v.summonMasterId == "" or v.summonMasterId == nil then
				local pet = self:getSupportPet(v.creepsId, v)

				pet.summonedPetId = self._curSummon

				table.insert(helpPets, pet)
			elseif v.creepsId == self._curSummon then
				local pet = self:getSupportPet(v.creepsId, v)

				table.insert(helpPets, pet)
			end
		end
	end

	return helpPets
end

function TianmanKingModel:_createPet(creepCfg)
	if not creepCfg then
		return
	end

	local fPowerPet = FightingPowerPetMo.New()

	if creepCfg.summonMasterId == "" or creepCfg.summonMasterId == nil then
		local cloneT = clone(creepCfg)

		cloneT.summonedPetId = self._curSummon

		fPowerPet:fromChallengeCreepCo(cloneT)

		creepCfg = cloneT
	else
		fPowerPet:fromChallengeCreepCo(creepCfg)
	end

	local petMo = fPowerPet:toBaseBagPetMo()

	petMo.isSupportedPet = true
	petMo.isMyPackPet = false

	return petMo
end

function TianmanKingModel:setBattleChallengeTypeAndId(challengeType, challengeId)
	self._challengeType = challengeType
	self._challengeId = challengeId
end

function TianmanKingModel:getBattleChallengeTypeAndId()
	return self._challengeType, self._challengeId
end

function TianmanKingModel:setIsWin(isWin)
	self._isWin = isWin
end

function TianmanKingModel:getIsWin()
	return self._isWin
end

TianmanKingModel.instance = TianmanKingModel.New()

return TianmanKingModel
