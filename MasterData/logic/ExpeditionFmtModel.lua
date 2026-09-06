-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/model/ExpeditionFmtModel.lua

module("logic.extensions.expedition.model.ExpeditionFmtModel", package.seeall)

local ExpeditionFmtModel = class("ExpeditionFmtModel", BaseModel)

function ExpeditionFmtModel:ctor()
	return
end

function ExpeditionFmtModel:onInit()
	self:onReset()
end

function ExpeditionFmtModel:onReset()
	self._svrFormation = nil
	self._formation = nil
	self._teamId = 1
	self._petMap = nil
	self._curBagPetVersion = nil
end

function ExpeditionFmtModel:isCurFormationEmpty()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function ExpeditionFmtModel:setFormation(form)
	self._teamId = self._teamId or 1
	self._formation = ExpeditionFormationMO.New()

	self._formation:SetData(form)
	self:_saveAsSvrFometion(form)
	self:checkPetsDead()
end

function ExpeditionFmtModel:getFightingCreepsRandomRaceId(eventInfo)
	local ftStr = eventInfo.ft
	local fmt = string.split(ftStr, "#")
	local monsters = string.split(fmt[2], ",")
	local idx = math.random(1, #monsters)
	local cfg = monsters[idx]
	local mstInfo = string.split(cfg, ":")

	return checknumber(mstInfo[2])
end

function ExpeditionFmtModel:getFightingMonsterRaceId(eventInfo)
	local teams = self:getFightingMonsterMos(eventInfo, true)

	table.sort(teams, function(x, y)
		if x == y then
			return false
		end

		if x.fightingPower < y.fightingPower then
			return false
		end

		if x.fightingPower > y.fightingPower then
			return true
		end

		return false
	end)

	return teams[1].petMo.curFaceId
end

function ExpeditionFmtModel:getFightingMonsterMos(eventInfo, withDead)
	local cCfg, heroSkillId = self:getFightingCreeps(eventInfo)
	local creepCos, heroSkillId = self:getFightingCreeps(eventInfo, withDead)
	local info = ExpeditionModel.instance:getInfo()
	local fightingPowerOfTeam = info.curMaxZdl
	local stepCo = ExpeditionConfig.instance:getExpeditionMapStepCo(info.level + 1, info.nextXAixs)

	if not stepCo.zdlFactor then
		fightingPowerOfTeam = fightingPowerOfTeam * (10000 + stepCo.zdlFactor) / 10000

		local petMos = {}
		local teams = {}

		for i = 1, #creepCos do
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(creepCos[i], creepCos)
			table.insert(petMos, petMo)
		end

		for i = 1, #petMos do
			local fightingPower = fightingPowerOfTeam * creepCos[i].weight
			local mo = petMos[i]
			local finalAttrs = {}

			finalAttrs[GameEnum.AttrType.Hp] = math.floor(fightingPower * creepCos[i].propCfg.hpPoint / 10000)
			finalAttrs[GameEnum.AttrType.DefensePhysical] = math.floor(fightingPower * creepCos[i].propCfg.physcialDefensePoint / 10000)
			finalAttrs[GameEnum.AttrType.DefenseMagic] = math.floor(fightingPower * creepCos[i].propCfg.magicDefensePoint / 10000)
			finalAttrs[GameEnum.AttrType.Speed] = math.floor(fightingPower * creepCos[i].propCfg.speedPoint / 10000)
			finalAttrs[GameEnum.AttrType.Attack] = math.floor(fightingPower * creepCos[i].propCfg.attackPoint / 10000)
			mo.attrMo.finalAttrs = finalAttrs
			mo.attrMo.isCalcPower = false

			mo:refreshAllAttr()
			table.insert(teams, {
				petMo = mo,
				fightingPower = mo:getFightingPower(),
				data = creepCos[i],
				speed = math.floor(fightingPower * creepCos[i].propCfg.speedPoint / 10000)
			})
		end

		return teams
	end
end

function ExpeditionFmtModel:getFightingPowerOfFmt(eventInfo)
	local teams = self:getFightingMonsterMos(eventInfo)
	local fightingPower = 0

	for i = 1, #teams do
		fightingPower = fightingPower + teams[i].fightingPower
	end

	return math.floor(fightingPower)
end

function ExpeditionFmtModel:getFightingCreeps(eventInfo, withDead)
	local ftStr = eventInfo.ft
	local fmt = string.split(ftStr, "#")
	local monsters = string.split(fmt[2], ",")
	local elementalMasterId = checknumber(fmt[4])
	local elementalTargetId = checknumber(fmt[5])
	local creeps = {}
	local markMasterId = -1
	local markSummonedPetId = -1

	for i = 1, #monsters do
		local mstInfo = string.split(monsters[i], ":")
		local raceId = checknumber(mstInfo[2])
		local petCo = CharacterConfig.instance:getPetCo(raceId)
		local weight = ExpeditionConfig.instance:getRivalPropertyWeight(petCo.evaluateLevel)
		local firstJobKey = PetSkinConfig.instance:getFirstJobKey(raceId)
		local speedPoint = ExpeditionConfig.instance:getJobSpeedPoint(firstJobKey)
		local propCfg = ExpeditionConfig.instance:getJobPropCfg(firstJobKey)
		local skinId = checknumber(mstInfo[5])
		local summonMasterId = checknumber(mstInfo[6])
		local contractSkillId = checknumber(mstInfo[7])
		local carriedMasterId = 0
		local carriedPetId = checknumber(mstInfo[8])
		local oracleMasterId = 0
		local oraclePetId = checknumber(mstInfo[9])
		local oraclePetRaceId = checknumber(mstInfo[10])
		local bookSpiritPetId = 0
		local bookSpiritRaceId = 0

		if markMasterId < 0 then
			markMasterId = summonMasterId
			markSummonedPetId = checknumber(mstInfo[1])
		end

		if skinId == 0 then
			skinId = raceId
		end

		local mstCo = {
			summonedPetId = 0,
			talentLv = 0,
			equipment = "",
			creepsMasterId = eventInfo.em,
			creepsId = checknumber(mstInfo[1]),
			posId = checknumber(mstInfo[1]),
			raceId = raceId,
			faceId = skinId,
			lv = checknumber(mstInfo[3]),
			awakenLv = checknumber(mstInfo[4]),
			creepsName = petCo.name,
			summonMasterId = summonMasterId,
			contractSkillId = contractSkillId,
			weight = weight,
			speedPoint = speedPoint,
			propCfg = propCfg,
			carriedMasterId = carriedMasterId,
			carriedPetId = carriedPetId,
			oracleMasterId = oracleMasterId,
			oraclePetId = oraclePetId,
			oraclePetRaceId = oraclePetRaceId,
			bookSpiritPetId = bookSpiritPetId,
			bookSpiritRaceId = bookSpiritRaceId
		}

		if mstCo.creepsId == elementalTargetId then
			mstCo.elementalMasterId = elementalMasterId
		end

		if mstCo.creepsId == elementalMasterId then
			mstCo.elementalTargetId = elementalTargetId
		end

		table.insert(creeps, mstCo)
	end

	if markMasterId > 0 and markSummonedPetId > 0 then
		for i, mstCo in ipairs(creeps) do
			if mstCo.creepsId == markMasterId then
				mstCo.summonedPetId = markSummonedPetId

				break
			end
		end
	end

	local totalWeight = 0

	for i = 1, #creeps do
		totalWeight = totalWeight + creeps[i].weight
	end

	for i = 1, #creeps do
		creeps[i].weight = creeps[i].weight / totalWeight
	end

	if not withDead and eventInfo.ph and table.nums(eventInfo.ph) > 0 then
		local aliveCreeps = {}
		local deadCreepsMap = {}

		for k, v in pairs(eventInfo.ph) do
			deadCreepsMap[tonumber(k)] = tonumber(v) <= 0
		end

		for i = 1, #creeps do
			local alive = not deadCreepsMap[creeps[i].creepsId]

			if alive then
				table.insert(aliveCreeps, creeps[i])
			end
		end

		return aliveCreeps, checknumber(fmt[1])
	end

	return creeps, checknumber(fmt[1])
end

function ExpeditionFmtModel:getPetIdInTeamByRaceId(raceId)
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))

			if pet and pet.raceId == raceId then
				return pet.petId
			end
		end
	end

	return 0
end

function ExpeditionFmtModel:checkPetsDead()
	local formation = self:getFormation()

	if not formation then
		return
	end

	local pet_poisition = formation:GetPositions()
	local dirty

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local petState = ExpeditionModel.instance:getPetState(checknumber(v))

			if petState and petState.hpRate <= 0 then
				pet_poisition[i] = 0
				dirty = true
			end
		end
	end

	if dirty then
		formation:setPositionForce(pet_poisition)
	end
end

function ExpeditionFmtModel:setTeamId(teamId)
	self._teamId = teamId
end

function ExpeditionFmtModel:getTeamId()
	return self._teamId
end

function ExpeditionFmtModel:getFormation()
	return self._formation
end

function ExpeditionFmtModel:changePosition(pos, value)
	self._formation:SetPosition(pos, value)
end

function ExpeditionFmtModel:changeSkillId(id)
	self._formation:SetHeroSkillId(id)
end

function ExpeditionFmtModel:getHeroSkillId()
	return self._formation:GetHeroSkillId()
end

function ExpeditionFmtModel:getCurFormationId()
	return self._formation:GetId()
end

function ExpeditionFmtModel:getFormPetsHeroSkills()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), formation:GetSummonMasterPetId(), formation:GetSummonPetId()))
end

function ExpeditionFmtModel:getCurrBuffFormId()
	local info = self._formation:GetFormStrengthInfo()

	if info and info.formStrengthId then
		return info.formStrengthId
	end
end

function ExpeditionFmtModel:setCurrBuffFormInfo(formStrengthId)
	local info = FormationNewModel.instance:getFormStrengthInfo(formStrengthId)

	if info then
		local fomation = self._formation

		if fomation and fomation._formStrengInfo ~= formStrengthId then
			fomation:SetFormStrengthInfo(info)
		end
	end
end

function ExpeditionFmtModel:onViewClose()
	self:saveCurrFormation()
end

function ExpeditionFmtModel:saveCurrFormation()
	local isDirty = false
	local fmtId = self:getCurFormationId()
	local poses = self._formation:GetPositions()
	local skillId = self._formation:GetHeroSkillId()
	local psychicSkillId = self._formation:GetPsychicedSkillId()
	local masId = self._formation:GetElementalMasterId()
	local tarId = self._formation:GetElementalTargetId()
	local ha_masId = self._formation:GetHeavenAwakenMasterId()
	local ha_tarId = self._formation:GetHeavenAwakenSummonPetId()

	if fmtId ~= self._svrFormation.formId then
		isDirty = true
	end

	if not isDirty and self._svrFormation.extParams.heroSkillId ~= skillId then
		isDirty = true
	end

	if not isDirty and self._svrFormation.extParams.psychicSkillId ~= psychicSkillId then
		isDirty = true
	end

	if not isDirty and (self._svrFormation.extParams.elementalMasterId ~= masId or self._svrFormation.extParams.elementalTargetId ~= tarId) then
		isDirty = true
	end

	if not isDirty and (self._svrFormation.extParams.heavenAwakenMasterId ~= ha_masId or self._svrFormation.extParams.heavenAwakenSummonPetId ~= ha_tarId) then
		isDirty = true
	end

	if not isDirty then
		local svrPoses = self._svrFormation.pos

		for i = 1, #poses do
			if poses[i] ~= svrPoses[i] then
				isDirty = true

				break
			end
		end
	end

	local form = self._formation:createFormPb()

	ExpeditionAgent.instance:sendPM_ExpeditionSetFormReq(form, function(msg)
		self:_saveAsSvrFometion(msg.simpleForm)
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end)

	return isDirty
end

function ExpeditionFmtModel:getAllPets()
	self._petMap = {}

	local allPets = {}
	local pets = BagPetsController.instance:getFightBagPet()

	for k, v in pairs(pets) do
		local mo = clone(v)

		allPets[#allPets + 1] = mo
		self._petMap[mo.petId] = mo
	end

	local supportedPets = self:getSupportedPets()

	if supportedPets then
		for i = 1, #supportedPets do
			allPets[#allPets + 1] = supportedPets[i]
			self._petMap[supportedPets[i].petId] = supportedPets[i]
		end
	end

	return allPets
end

function ExpeditionFmtModel:getSupportedPets()
	local allPets = {}
	local supportedPetIds = ExpeditionModel.instance:getSupportedPetIds()

	if supportedPetIds then
		for i = 1, #supportedPetIds do
			local petId = supportedPetIds[i].petId

			allPets[#allPets + 1] = self:createPet(petId)
		end
	end

	return allPets
end

function ExpeditionFmtModel:bagCount()
	local num = BagModel.instance:BagCount()
	local supportedPetIds = ExpeditionModel.instance:getSupportedPetIds()

	if supportedPetIds then
		num = num + #supportedPetIds
	end

	return num
end

function ExpeditionFmtModel:alivePetsCount()
	local allPets = self:getAllPets()
	local raceIdsMap = {}

	for i = 1, #allPets do
		if not ExpeditionModel.instance:isPetDead(allPets[i].petId) then
			raceIdsMap[allPets[i].raceId] = true
		end
	end

	return table.nums(raceIdsMap)
end

function ExpeditionFmtModel:createPet(petId)
	local spPetCo = ExpeditionModel.instance:getSupportedPet(petId)
	local bagPetMo = BagPetMo.New()

	bagPetMo.petId = spPetCo.petId
	bagPetMo.raceId = spPetCo.raceId
	bagPetMo.level = spPetCo.level
	bagPetMo.supportedFightingPower = spPetCo.curZdl
	bagPetMo._speed = spPetCo.speed
	bagPetMo.awakeLevel = spPetCo.awakenLv
	bagPetMo.awakenLv = spPetCo.awakenLv
	bagPetMo.summonMasterId = 0
	bagPetMo.summonedPetId = 0
	bagPetMo.isSupportedPet = true
	bagPetMo.rare = CharacterConfig.instance:getRareByAwakenLv(bagPetMo.awakeLevel, bagPetMo.raceId)

	local petCo = CharacterConfig.instance:getPetCo(spPetCo.raceId)

	bagPetMo.curFaceId = checknumber(petCo.faceIds)

	bagPetMo:setAttrMo()

	bagPetMo.name = petCo.name

	return bagPetMo
end

function ExpeditionFmtModel:getPet(petId)
	if not petId or petId <= 0 then
		return
	end

	local tmp = BagPetsController.instance:getPetChangeVersion()

	if self._curBagPetVersion == nil then
		self._curBagPetVersion = tmp
	end

	if self._petMap == nil or tmp > self._curBagPetVersion then
		self._curBagPetVersion = tmp

		self:getAllPets()
	end

	return self._petMap[petId]
end

function ExpeditionFmtModel:_saveAsSvrFometion(form)
	self._svrFormation = {}
	self._svrFormation.formId = form.formId
	self._svrFormation.pos = {}

	for k, j in ipairs(form.pos) do
		self._svrFormation.pos[k] = j
	end

	self._svrFormation.extParams = {}
	self._svrFormation.extParams.heroSkillId = form.extParams.heroSkillId
	self._svrFormation.extParams.psychicSkillId = form.extParams.psychicSkillId
	self._svrFormation.extParams.elementalMasterId = form.extParams.elementalMasterId
	self._svrFormation.extParams.elementalTargetId = form.extParams.elementalTargetId
	self._svrFormation.extParams.heavenAwakenMasterId = form.extParams.heavenAwakenMasterId
	self._svrFormation.extParams.heavenAwakenSummonPetId = form.extParams.heavenAwakenSummonPetId
end

function ExpeditionFmtModel:getHeavenAwakenMasterAndTarget(eventInfo)
	local ftStr = eventInfo.ft
	local fmt = string.split(ftStr, "#")
	local heavenAwakenMasterId = checknumber(fmt[8])
	local heavenAwakenSummonPetId = checknumber(fmt[9])

	return heavenAwakenMasterId, heavenAwakenSummonPetId
end

ExpeditionFmtModel.instance = ExpeditionFmtModel.New()

return ExpeditionFmtModel
