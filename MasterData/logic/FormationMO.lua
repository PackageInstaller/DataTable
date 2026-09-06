-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FormationMO.lua

module("logic.extensions.formation.model.FormationMO", package.seeall)

local FormationMO = class("FormationMO")
local YUAN_LIMIT = 2

FormationMO.STATE_NORMAL = 0
FormationMO.STATE_CAN_NOT_UP_CONTRACT = 1
FormationMO.STATE_CAN_NOT_UP_YUAN = 2

function FormationMO:ctor(getPetFunc)
	self.myGetPetFunc = getPetFunc
	self._id = 10
	self._positions = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self._heroSkillId = 0
	self._psychicedSkillId = 0
	self.summonedPetId = -1
	self.summonMasterPetId = -1
	self._hasPets = {}
	self._formStrengInfo = nil
	self.extGetPetFunc = nil
	self._elementalMasterId = 0
	self._elementalTargetId = 0
	self._elementRelationMap = {}
	self._changeRaceTypes = {}
	self._lastElementMasterId = self._elementalMasterId - 1
	self._cutePetId = 0
	self._cutePetRaceId = 0
	self._cutePetQuality = 0
	self._heavenAwakenMasterId = 0
	self._heavenAwakenSummonPetId = 0
	self._spiritInvocationPetId = 0
	self.isAutoSetSummonPet = true
	self.isBanMySummonPet = false
	self._normalPetCount = 0
	self._summonPetCount = 0
end

function FormationMO:SetData(data)
	if data then
		self._id = data.formId

		if not data.extParams then
			self._heroSkillId = checknumber(data.extParams.heroSkillId)
			self._psychicedSkillId = checknumber(data.extParams.psychicSkillId)

			self:SetFormStrengthInfo({
				formStrengthId = data.extParams.formStrengthId,
				formStrengthLv = data.extParams.formStrengthLv
			})

			self._elementalMasterId = checknumber(data.extParams.elementalMasterId)
			self._elementalTargetId = checknumber(data.extParams.elementalTargetId)
			self._cutePetId = checknumber(data.extParams.cutePetId)
			self._cutePetRaceId = checknumber(data.extParams.cutePetRaceId)
			self._cutePetQuality = checknumber(data.extParams.cutePetQuality)
			self._heavenAwakenMasterId = checknumber(data.extParams.heavenAwakenMasterId)
			self._heavenAwakenSummonPetId = checknumber(data.extParams.heavenAwakenSummonPetId)
			self._spiritInvocationPetId = checknumber(data.extParams.spiritInvocationPetId)
			self.summonedPetId = checknumber(data.extParams.summonedPetId)
			self.summonMasterPetId = checknumber(data.extParams.summonMasterPetId)
			self._changeRaceTypes = {}

			for i, v in ipairs(data.extParams.changeRaceTypes or {}) do
				local obj = {}

				obj.petId = v.petId
				obj.raceType = v.raceType

				table.insert(self._changeRaceTypes, obj)
			end

			self._positions = {
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			}

			for i, v in ipairs(data.pos) do
				self._positions[i] = v
			end

			self:fixAndUpdatePsychicedSkill()
			self:resetHasPet()
		end
	end
end

function FormationMO:Clone(formationMo, summonedPetId)
	if formationMo then
		summonedPetId = summonedPetId or -1
		self.summonedPetId = summonedPetId
		self._id = formationMo:GetId()

		local pos = {}
		local pet_poisition = formationMo:GetPositions() or {}

		for i, v in ipairs(pet_poisition) do
			local petMo = self:_getPet(v, true)

			pos[i] = petMo and v or 0
		end

		self:_setAllPositions(pos)
		self:CloneByMo(formationMo)
	end
end

function FormationMO:CloneFromFmoAndFix(formationMo, pet_poisition)
	if formationMo then
		local pos = {}

		if pet_poisition == nil then
			pet_poisition = formationMo:GetPositions() or {}
		end

		for i, v in ipairs(pet_poisition) do
			local petMo = self:_getPet(v, true)

			pos[i] = petMo and v or 0
		end

		self:_setAllPositions(pos)
		self:CloneByMo(formationMo)
	end
end

function FormationMO:CloneByMo(formationMo)
	self:SetPsychicedSkillId(formationMo:GetPsychicedSkillId())
	self:SetHeroSkillId(formationMo:GetHeroSkillId())
	self:SetSpiritInvocationPetId(formationMo:GetSpiritInvocationPetId())

	self._elementalMasterId = formationMo:GetElementalMasterId()
	self._elementalTargetId = formationMo:GetElementalTargetId()
	self._changeRaceTypes = clone(formationMo:GetChangeRaceTypes())

	local strengthInfo = formationMo:GetFormStrengthInfo()

	if strengthInfo then
		local info = {
			formStrengthId = strengthInfo.formStrengthId,
			formStrengthLv = strengthInfo.formStrengthLv
		}

		self:SetFormStrengthInfo(info)
	else
		self:SetFormStrengthInfo(nil)
	end

	self._cutePetId = formationMo:GetCutePetId()
	self._cutePetRaceId = formationMo:GetCutePetRaceId()
	self._cutePetQuality = formationMo:GetCutePetQuality()

	self:fixAndUpdateStength()
	self:fixAndUpdateHeroSkill()
	self:fixAndUpdatePsychicedSkill()
	self:fixAndUpdateChangeRaceTypes()
	self:fixAndUpdateSpiritInvocationkill()

	self.summonedPetId = formationMo.summonedPetId
	self.summonMasterPetId = formationMo.summonMasterPetId
	self.isAutoSetSummonPet = formationMo.isAutoSetSummonPet
end

function FormationMO:fixAndUpdateChangeRaceTypes()
	for i, v in ipairs(self._changeRaceTypes or {}) do
		if not self:HasPet(v.petId) then
			v.raceType = ""
		end
	end
end

function FormationMO:fixAndUpdatePsychicedSkill()
	if BagPetsController.instance:getReady() then
		self._psychicedSkillId = checknumber(self._psychicedSkillId)
		self._elementalMasterId = checknumber(self._elementalMasterId)
		self._elementalTargetId = checknumber(self._elementalTargetId)

		if self._psychicedSkillId > 0 or self._psychicedSkillId > 0 or self._elementalTargetId > 0 then
			local isValidPsy = false
			local isValidEleMas = false
			local isValidEleTar = false

			for i, v in ipairs(self._positions) do
				local petMo = self:_getPet(v)

				if petMo then
					local petCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

					if petCo.psychicSkillId == self._psychicedSkillId then
						isValidPsy = true
					end

					if petMo.petId == self._elementalMasterId then
						isValidEleMas = true
					end

					if petMo.petId == self._elementalTargetId then
						isValidEleTar = true
					end
				end
			end

			if isValidPsy == false then
				self._psychicedSkillId = 0
			end

			if isValidEleMas == false then
				self._elementalMasterId = 0
			end

			if isValidEleTar == false then
				self._elementalTargetId = 0
			end
		end
	end
end

function FormationMO:fixAndUpdateSpiritInvocationkill()
	if BagPetsController.instance:getReady() then
		self._spiritInvocationPetId = checknumber(self._spiritInvocationPetId)

		if self._spiritInvocationPetId > 0 then
			local isValidPet = false
			local pets = self:_getValidSpiritInvocationPets()

			for i, petMo in ipairs(pets) do
				if checknumber(petMo.petId) == self._spiritInvocationPetId then
					isValidPet = true

					break
				end
			end

			if isValidPet == false then
				self._spiritInvocationPetId = 0
			end
		end
	end
end

function FormationMO:_getValidSpiritInvocationPets()
	local teams = {}

	for i, v in ipairs(self._positions) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	return FightingPowerFormula.instance:getSpiritInvocationValidPets(teams, self:getCurElementRelationMap())
end

function FormationMO:fixAndUpdateHeroSkill()
	self._heroSkillId = checknumber(self._heroSkillId)

	if self._heroSkillId > 0 then
		local skills = self:_getValidHeroSkills()

		if TableUtil.isHad(skills, self._heroSkillId) then
			-- block empty
		else
			self._heroSkillId = table.getn(skills) > 0 and skills[1] or 0
		end
	end
end

function FormationMO:_getValidHeroSkills()
	local teams = {}

	for i, v in ipairs(self._positions) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, self:getCurElementRelationMap(), self:GetSummonMasterPetId(), self:GetSummonPetId()))
end

function FormationMO:GetId()
	return self._id
end

function FormationMO:GetHeroSkillId()
	self:fixAndUpdateHeroSkill()

	return self._heroSkillId
end

function FormationMO:GetPsychicedSkillId()
	return self._psychicedSkillId
end

function FormationMO:SetPsychicedSkillId(skillId)
	if self._psychicedSkillId ~= skillId then
		self._psychicedSkillId = skillId

		return true
	end

	return false
end

function FormationMO:SetElementalMasterId(eleMasterId)
	if self._elementalMasterId ~= eleMasterId then
		self._elementalMasterId = eleMasterId

		return true
	else
		return false
	end
end

function FormationMO:GetElementalMasterId()
	return self._elementalMasterId
end

function FormationMO:SetElementalTargetId(eleTargetId)
	if self._elementalTargetId ~= eleTargetId then
		self._elementalTargetId = eleTargetId

		return true
	else
		return false
	end
end

function FormationMO:GetElementalTargetId()
	return self._elementalTargetId
end

function FormationMO:tryGetFirstElement()
	if self._elementalMasterId <= 0 then
		for k, v in pairs(self._positions) do
			if v > 0 then
				local petMo = self:_getPet(v)

				if petMo and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Element) then
					self._elementalMasterId = v
				end
			end
		end
	end
end

function FormationMO:getCurElementRelationMap()
	self._elementRelationMap = {}

	local types = self._changeRaceTypes

	for i, v in ipairs(types) do
		if not string.nilorempty(v.raceType) and self:HasPet(v.petId) then
			self._elementRelationMap[v.petId] = GameEnum.Races[v.raceType]
		end
	end

	if self._elementalMasterId > 0 or self._elementalTargetId > 0 then
		local masMo = self:_getPet(self._elementalMasterId)
		local tarMo = self:_getPet(self._elementalTargetId)

		if BagPetsController.instance:getReady() then
			if masMo == nil or not self:HasPet(self._elementalMasterId) then
				self._elementalMasterId = 0
				self._elementalTargetId = 0

				return self._elementRelationMap
			end

			if tarMo == nil or not self:HasPet(self._elementalTargetId) then
				self._elementalTargetId = 0

				return self._elementRelationMap
			end
		end

		if masMo then
			self._elementRelationMap[self._elementalTargetId] = PetSkinConfig.instance:getFisrtEleAttrIdx((checknumber(masMo.curFaceId) > 0 or nil) and checknumber(masMo.curFaceId))
		end
	end

	return self._elementRelationMap
end

function FormationMO:GetFormStrengthInfo()
	return self._formStrengInfo
end

function FormationMO:SetFormStrengthInfo(info)
	self._formStrengInfo = info
end

function FormationMO:fixAndUpdateStength()
	if self._formStrengInfo then
		local fid = self._formStrengInfo.formStrengthId
		local cfg = FightingPowerFormula.instance:getFormStrength(self._positions, self.summonedPetId)

		if cfg and fid == cfg.formStrengthId then
			-- block empty
		else
			self:SetFormStrengthInfo(nil)
		end
	end
end

function FormationMO:SetHeroSkillId(skillId)
	if self._heroSkillId ~= skillId then
		self._heroSkillId = skillId

		return true
	end

	return false
end

function FormationMO:GetPositions()
	return self._positions
end

function FormationMO:GetPosition(pos)
	return self._positions[pos]
end

function FormationMO:ResetPosition(notDispatch)
	for i = 1, 9 do
		if checknumber(self._positions[i]) > 0 then
			self._positions[i] = 0
		end
	end

	self:resetHasPet()

	if not notDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	end
end

function FormationMO:SwapPosition(fPos, tPos, notDispatch)
	self._positions[fPos], self._positions[tPos] = self._positions[tPos], self._positions[fPos]

	if not notDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	end
end

function FormationMO:SetPosition(pos, petId, notDispatch)
	if not self:IsOpen(pos) then
		return false
	end

	local oldValue = self._positions[pos]

	if oldValue == -1 then
		return false
	end

	if oldValue == petId then
		if not notDispatch then
			GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
		end

		return false
	end

	local canUpState = self:preDealDragMasterPosAndSetSummonPet(pos, petId)

	if canUpState == 0 then
		local newPos = self:GetPetPosition(petId)

		if newPos then
			self._positions[newPos] = oldValue
		end

		self._positions[pos] = petId

		self:resetHasPet()

		if not notDispatch then
			GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged, newPos, oldValue)
		end
	end

	return isCanUp
end

function FormationMO:setPositionForce(positions, forceDispatch)
	local change = self:_setAllPositions(positions)

	if change or forceDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	end

	return change
end

function FormationMO:_setAllPositions(positions)
	local change = false

	self._positions = self._positions or {}
	positions = positions or {}

	for i = 1, 9 do
		local tem = positions[i]

		if tem == nil or tem == -1 then
			tem = self._positions[i]
		end

		if self._positions[i] ~= tem then
			change = true
		end

		self._positions[i] = tem
	end

	self:resetHasPet()

	return change
end

function FormationMO:_setPetToNullPos(willDownPetMo)
	if willDownPetMo and (self.summonMasterPetId <= 0 or self.summonMasterPetId == willDownPetMo.petId or self.summonedPetId == willDownPetMo.petId) then
		local hasMaster, masterId, summonId = self:_getContractInTeam(willDownPetMo, nil)

		self.summonMasterPetId = masterId
		self.summonedPetId = summonId

		if self.summonMasterPetId <= 0 and self.summonedPetId <= 0 then
			local hasMaster, masterId, summonId = self:_getOneContractInTeamNotMyPack()

			self.summonMasterPetId = masterId
			self.summonedPetId = summonId
		end
	end

	return FormationMO.STATE_NORMAL
end

function FormationMO:_setPetToEmptyPos(willUpPetId, willUpPetMo, isFullSeat)
	if self:HasPet(willUpPetId) then
		return FormationMO.STATE_NORMAL
	end

	if not willUpPetMo then
		return FormationMO.STATE_NORMAL
	end

	local canNotUpYuan = self:checkYuanLimit(willUpPetMo)

	if canNotUpYuan then
		return FormationMO.STATE_CAN_NOT_UP_YUAN
	end

	local hasMaster, masterId, summonId = false, self.summonMasterPetId, self.summonedPetId

	if checknumber(self.summonedPetId) <= 0 then
		if willUpPetMo.isMyPackPet then
			if willUpPetMo:isSummonedMaster() or willUpPetMo:isSummonedPet() then
				hasMaster, masterId, summonId = self:_getContractInTeam(nil, willUpPetMo)
			end
		elseif checknumber(willUpPetMo.summonedPetId) > 0 or checknumber(willUpPetMo.summonMasterId) > 0 then
			hasMaster, masterId, summonId = self:_getContractInTeamNotMyPack(nil, willUpPetMo)
		end
	end

	self.summonMasterPetId = masterId
	self.summonedPetId = summonId

	if hasMaster then
		return FormationMO.STATE_NORMAL
	end

	if not isFullSeat then
		return FormationMO.STATE_NORMAL
	else
		return self:_checkCanUpWithFullSeat(isFullSeat)
	end
end

function FormationMO:_setPetToPetPos(willUpPetId, willUpPetMo, willDownPetMo, isFullSeat)
	if self:HasPet(willUpPetId) then
		return FormationMO.STATE_NORMAL
	end

	if willDownPetMo and willUpPetMo then
		local canNotUpYuan = self:checkYuanLimit(willUpPetMo)

		if canNotUpYuan and not PetSkinConfig.instance:checkHasEleAttr(willDownPetMo.curFaceId, GameEnum.RaceType.Yuan) then
			return FormationMO.STATE_CAN_NOT_UP_YUAN
		end

		local hasMaster, masterId, summonId = false, self.summonMasterPetId, self.summonedPetId

		if willUpPetMo.isMyPackPet then
			if (willUpPetMo:isSummonedMaster() or willUpPetMo:isSummonedPet()) and (self.summonMasterPetId <= 0 or self.summonedPetId <= 0) then
				hasMaster, masterId, summonId = self:_getContractInTeam(willDownPetMo, willUpPetMo)
				self.summonMasterPetId = masterId
				self.summonedPetId = summonId

				return FormationMO.STATE_NORMAL
			end
		elseif (checknumber(willUpPetMo.summonedPetId) > 0 or checknumber(willUpPetMo.summonMasterId) > 0) and (self.summonMasterPetId <= 0 or self.summonedPetId <= 0) then
			hasMaster, masterId, summonId = self:_getContractInTeamNotMyPack(willDownPetMo, willUpPetMo)
			self.summonMasterPetId = masterId
			self.summonedPetId = summonId

			return FormationMO.STATE_NORMAL
		end

		if self.summonMasterPetId == willDownPetMo.petId then
			hasMaster, masterId, summonId = self:_getContractInTeam(willDownPetMo, willUpPetMo)

			if not hasMaster then
				self:_resetSummonPet()
			end

			self.summonMasterPetId = masterId
			self.summonedPetId = summonId

			return FormationMO.STATE_NORMAL
		elseif self.summonedPetId == willDownPetMo.petId then
			local var_35_0, var_35_1, var_35_2 = self:_getContractInTeam(willDownPetMo, willUpPetMo)

			summonId = var_35_2
			masterId = var_35_1

			if var_35_0 then
				self.summonMasterPetId = masterId
				self.summonedPetId = summonId

				return FormationMO.STATE_NORMAL
			elseif not isFullSeat then
				self.summonMasterPetId = masterId
				self.summonedPetId = summonId

				return FormationMO.STATE_NORMAL
			else
				return self:_checkCanUpWithFullSeat(isFullSeat)
			end
		end
	end

	return FormationMO.STATE_NORMAL
end

function FormationMO:preDealDragMasterPosAndSetSummonPet(pos, willUpPetId, isFullSeat)
	if checknumber(self.summonedPetId) <= 0 and checknumber(willUpPetId) <= 0 then
		return FormationMO.STATE_NORMAL
	end

	local prePetId = checknumber(self._positions[pos])

	if prePetId == willUpPetId then
		return FormationMO.STATE_NORMAL
	end

	if self:HasPet(willUpPetId) then
		return FormationMO.STATE_NORMAL
	end

	local willDownPetMo = self:_getPet(prePetId)
	local willUpPetMo = self:_getPet(willUpPetId)

	if willUpPetId <= 0 then
		return self:_setPetToNullPos(willDownPetMo)
	elseif prePetId <= 0 then
		return self:_setPetToEmptyPos(willUpPetId, willUpPetMo, isFullSeat)
	else
		return self:_setPetToPetPos(willUpPetId, willUpPetMo, willDownPetMo, isFullSeat)
	end
end

function FormationMO:_checkCanUpWithFullSeat(isFullSeat)
	if isFullSeat then
		if self.summonMasterPetId <= 0 and self.summonedPetId <= 0 then
			local hasMaster, masterId, summonId = self:_getContractInTeam(nil, nil)

			self.summonMasterPetId = masterId
			self.summonedPetId = summonId

			if self.summonMasterPetId > 0 and self.summonedPetId > 0 then
				return FormationMO.STATE_NORMAL
			end
		end

		if self.summonMasterPetId <= 0 and self.summonedPetId <= 0 then
			local hasMaster, masterId, summonId = self:_getOneContractInTeamNotMyPack()

			self.summonMasterPetId = masterId
			self.summonedPetId = summonId

			if self.summonMasterPetId > 0 and self.summonedPetId > 0 then
				return FormationMO.STATE_NORMAL
			end
		end

		return FormationMO.STATE_CAN_NOT_UP_CONTRACT
	else
		return FormationMO.STATE_NORMAL
	end
end

function FormationMO:_getOneContractInTeamNotMyPack()
	if not self.isAutoSetSummonPet then
		return false, -1, -1
	end

	local map = {}

	for i, v in ipairs(self._positions) do
		if v > 0 then
			map[v] = true
		end
	end

	for i, v in ipairs(self._positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if petMo and not petMo.isMyPackPet then
				if checknumber(petMo.summonedPetId) > 0 and map[checknumber(petMo.summonedPetId)] then
					local masterMo = petMo
					local summonMo = self:_getPet(petMo.summonedPetId)

					if masterMo and summonMo then
						local cfg = ContractConfig.instance:getGroupCfg(masterMo.raceId, summonMo.raceId)

						if cfg then
							return true, v, checknumber(petMo.summonedPetId)
						end
					end
				end

				if checknumber(petMo.summonMasterId) > 0 and map[checknumber(petMo.summonMasterId)] then
					local masterMo = self:_getPet(petMo.summonMasterId)
					local summonMo = petMo

					if masterMo and summonMo then
						local cfg = ContractConfig.instance:getGroupCfg(masterMo.raceId, summonMo.raceId)

						if cfg then
							return true, checknumber(petMo.summonMasterId), v
						end
					end
				end
			end
		end
	end

	return false, -1, -1
end

function FormationMO:_getContractInTeamNotMyPack(willDownPetMo, willUpPetMo)
	if not self.isAutoSetSummonPet then
		return false, -1, -1
	end

	for k, v in pairs(self._positions) do
		if v > 0 and (willDownPetMo == nil or v ~= willDownPetMo.petId) then
			if checknumber(willUpPetMo.summonedPetId) == v then
				return true, willUpPetMo.petId, v
			end

			if checknumber(willUpPetMo.summonMasterId) == v then
				return true, v, willUpPetMo.petId
			end
		end
	end

	return false, -1, -1
end

function FormationMO:_getContractInTeam(willDownPetMo, willUpPetMo)
	if not self.isAutoSetSummonPet or self.isBanMySummonPet then
		return false, -1, -1
	end

	local map = {}

	for k, v in pairs(self._positions) do
		if v > 0 and (willDownPetMo == nil or v ~= willDownPetMo.petId) then
			local petMo = self:_getPet(v)

			if petMo and not petMo:isBorrowPet() and petMo.isMyPackPet then
				map[petMo.raceId] = petMo
			end
		end
	end

	if willUpPetMo then
		map[willUpPetMo.raceId] = willUpPetMo
	end

	local hasMaster = false

	for k, v in pairs(map) do
		for m, n in pairs(map) do
			if k ~= m then
				local cfg = ContractConfig.instance:getGroupCfg(k, m)

				if cfg then
					hasMaster = true

					return true, v.petId, n.petId
				end

				local cfg = ContractConfig.instance:getGroupCfg(m, k)

				if cfg then
					hasMaster = true

					return true, n.petId, v.petId
				end
			end
		end
	end

	return hasMaster, -1, -1
end

function FormationMO:_resetSummonPet()
	if self.summonedPetId > 0 then
		local summonedPos = self:GetPetPosition(self.summonedPetId)

		if summonedPos then
			self._positions[summonedPos] = 0
			self._hasPets[self.summonedPetId] = nil
		end
	end

	self.summonedPetId = -1
end

function FormationMO:setSummonPetAndSetPos(summonedPetId, withOutPos)
	local change = false

	self.summonedPetId = summonedPetId

	if summonedPetId < 0 then
		return change
	end

	local mo = self:_getPet(summonedPetId)

	if mo == nil then
		change = true

		self:_resetSummonPet()

		return change
	end

	local arr = {}

	if withOutPos then
		arr = type(withOutPos) == "table" and withOutPos or {
			withOutPos
		}
	end

	local pos = self._hasPets[summonedPetId]

	if pos ~= nil then
		if table.indexof(arr, pos) == false then
			return change
		else
			change = true

			self:_resetSummonPet()
		end
	end

	local canNotPut = true

	for i, v in pairs(self._positions) do
		if checknumber(v) <= 0 and table.indexof(arr, i) == false then
			self._positions[i] = summonedPetId
			self._hasPets[summonedPetId] = i
			canNotPut = false

			break
		end
	end

	if canNotPut then
		change = true

		self:_resetSummonPet()
	end

	return change
end

function FormationMO:resetHasPet(num)
	self._hasPets = {}
	self._raceMap = {}

	local isReady = BagPetsController.instance:getReady()

	self:preDealSummonMasterNotHere()

	self._normalPetCount = 0
	self._summonPetCount = 0
	num = checknumber(num)

	local list

	if num > 0 then
		list = {}
	end

	local isSummonedMark = false

	for i = 1, 9 do
		local petId = checknumber(self._positions[i])
		local mo

		if petId > 0 then
			if isReady then
				mo = self:_getPet(petId)
			end

			if mo == nil and isReady then
				self._positions[i] = 0

				if petId == checknumber(self.summonMasterPetId) then
					self.summonMasterPetId = -1
					self.summonedPetId = -1

					if isSummonedMark then
						if num > 0 then
							table.insert(list, petId)
						end

						self._normalPetCount = self._normalPetCount + 1

						self:_isOverRemoveOne(num, self._normalPetCount, list, petId)
					end
				end
			else
				self._hasPets[petId] = i

				if mo then
					self._raceMap[mo.raceId] = checknumber(self._raceMap[mo.raceId]) + 1
				end

				if petId == self.summonedPetId then
					isSummonedMark = true
					self._summonPetCount = self._summonPetCount + 1
				elseif petId == checknumber(self.summonMasterPetId) then
					self._normalPetCount = self._normalPetCount + 1

					self:_isOverRemoveOne(num, self._normalPetCount, list, petId)
				else
					if num > 0 then
						table.insert(list, petId)
					end

					self._normalPetCount = self._normalPetCount + 1

					self:_isOverRemoveOne(num, self._normalPetCount, list, petId)
				end
			end
		end
	end

	self:dealSummonMasterNotHere()
	self:getCurElementRelationMap()
	self:tryGetFirstElement()
end

function FormationMO:_isOverRemoveOne(num, count, list, petId)
	if num > 0 and num < count and list and #list > 0 then
		local temPetId = table.remove(list)
		local tempIdx = self._hasPets[petId]

		self._positions[tempIdx] = 0
		self._hasPets[petId] = nil
	end
end

function FormationMO:preDealSummonMasterNotHere()
	if not BagPetsController.instance:getReady() then
		return
	end

	if checknumber(self.summonedPetId) > 0 and checknumber(self.summonMasterPetId) > 0 then
		local masterMo = self:_getPet(self.summonMasterPetId)
		local summonMo = self:_getPet(self.summonedPetId)

		if masterMo and summonMo then
			local cfg = ContractConfig.instance:getGroupCfg(masterMo.raceId, summonMo.raceId)

			if cfg == nil then
				self.summonMasterPetId = -1
				self.summonedPetId = -1
			end
		else
			self.summonMasterPetId = -1
			self.summonedPetId = -1
		end
	end
end

function FormationMO:dealSummonMasterNotHere()
	if checknumber(self.summonedPetId) > 0 and not self:HasPet(self.summonedPetId) then
		self.summonMasterPetId = -1
		self.summonedPetId = -1
	end

	if checknumber(self.summonMasterPetId) > 0 and not self:HasPet(self.summonMasterPetId) then
		self.summonMasterPetId = -1
		self.summonedPetId = -1
	end
end

function FormationMO:trySaveMySelf()
	local cls = getglobal(self.__cname)

	self.tempSaveFmo = cls and cls.New(self.myGetPetFunc) or FormationMO.New(self.myGetPetFunc)

	self.tempSaveFmo:setExtGetPetFunc(self.extGetPetFunc)
	self.tempSaveFmo:Clone(self, self.summonedPetId)

	return self.tempSaveFmo
end

function FormationMO:trySetSummonPetByMasterId(masterPetId, newSummonPetId, num)
	if self:checkAllBorrowPet(masterPetId, newSummonPetId) then
		return
	end

	local petMo = self:_getPet(newSummonPetId)
	local isExist, pos = self:getHasSameRaceIdUp(petMo)

	if isExist then
		self._positions[pos] = 0
		self._hasPets[petMo.petId] = nil
	end

	local summonedPos = -1

	if self.summonedPetId > 0 and self:HasPet(self.summonedPetId) then
		summonedPos = self:GetPetPosition(self.summonedPetId)
	end

	local newPetPos = -1

	if newSummonPetId > 0 and self:HasPet(newSummonPetId) then
		newPetPos = self:GetPetPosition(newSummonPetId)
	end

	if newSummonPetId <= 0 or masterPetId <= 0 then
		if checknumber(num) > 0 and self:getCurExistPetNumber(true) >= checknumber(num) then
			self:_resetSummonPet()
		end

		self.summonedPetId = -1
		self.summonMasterPetId = -1
	elseif newPetPos == -1 then
		if summonedPos == -1 then
			for i = 9, 1, -1 do
				if checknumber(self._positions[i]) == 0 then
					summonedPos = i

					break
				end
			end
		else
			self._hasPets[self.summonedPetId] = nil
		end

		local canNotUpYuan = self:checkYuanLimit(petMo)

		if not canNotUpYuan then
			self._positions[summonedPos] = newSummonPetId
			self._hasPets[newSummonPetId] = summonedPos
			self.summonedPetId = newSummonPetId
			self.summonMasterPetId = masterPetId
		else
			self.summonedPetId = -1
			self.summonMasterPetId = -1
		end
	else
		self.summonedPetId = newSummonPetId
		self.summonMasterPetId = masterPetId
	end

	self:resetHasPet(num)
end

function FormationMO:getCurExistPetNumber(isNeedSummonPet)
	if isNeedSummonPet then
		return self._normalPetCount + self._summonPetCount, self._summonPetCount
	else
		return self._normalPetCount, self._summonPetCount
	end
end

function FormationMO:HasPet(petId)
	local pos = self._hasPets[petId]

	return pos and pos > 0
end

function FormationMO:HasRace(raceId)
	for petId, pos in pairs(self._hasPets) do
		local mo = self:_getPet(petId)

		if mo and mo:getDefineId() == raceId then
			return true, pos
		end
	end

	return false, 0
end

function FormationMO:getHasSameRaceIdUp(petMo)
	if petMo then
		for pos, petId in ipairs(self._positions) do
			if petId > 0 and petId ~= petMo.petId then
				local pet = self:_getPet(petId)

				if pet and pet.raceId == petMo.raceId then
					return true, pos
				end
			end
		end
	end

	return false, 0
end

function FormationMO:getHasPets()
	local t = {}

	for petId, pos in pairs(self._hasPets) do
		if pos and pos > 0 then
			table.insert(t, petId)
		end
	end

	return t
end

function FormationMO:isEmpty()
	if not self._positions then
		return true
	end

	for pos, id in pairs(self._positions) do
		if id > 0 then
			return false
		end
	end

	return true
end

function FormationMO:GetPetPosition(petId)
	return self._hasPets[petId]
end

function FormationMO:IsOpen(pos)
	local list = BattleConfig.instance:getFormationPosKVList(self._id)

	return list[pos]
end

function FormationMO:SetCutePetMo(mo)
	self._cutePetId = 0
	self._cutePetRaceId = 0
	self._cutePetQuality = 0

	if mo then
		self._cutePetId = mo.id
		self._cutePetRaceId = mo.raceId
		self._cutePetQuality = mo.curQuality
	end
end

function FormationMO:getCutePetInfo()
	local cutePetId = self:GetCutePetId()

	if cutePetId > 0 then
		local cutePetMo = MaterialMgr.getModel(MatType.CutePet, cutePetId)

		if cutePetMo then
			return cutePetMo.raceId, cutePetMo.curQuality
		end
	end

	return self:GetCutePetRaceId(), self:GetCutePetQuality()
end

function FormationMO:SetCutePetId(id)
	self._cutePetId = id
end

function FormationMO:SetCutePetRaceId(id)
	self._cutePetRaceId = id
end

function FormationMO:SetCutePetQuality(id)
	self._cutePetQuality = id
end

function FormationMO:GetCutePetId()
	return checknumber(self._cutePetId)
end

function FormationMO:GetCutePetRaceId()
	return checknumber(self._cutePetRaceId)
end

function FormationMO:GetCutePetQuality()
	return checknumber(self._cutePetQuality)
end

function FormationMO:GetChangeRaceTypes()
	return self._changeRaceTypes
end

function FormationMO:updateChangeRaceTypes(petId, raceType)
	local isFound = false

	for i, obj in ipairs(self._changeRaceTypes) do
		if obj.petId == petId then
			obj.raceType = raceType
			isFound = true

			break
		end
	end

	if not isFound then
		local obj = {}

		obj.petId = petId
		obj.raceType = raceType

		table.insert(self._changeRaceTypes, obj)
	end

	self._isRaceTypeChange = true
end

function FormationMO:checkAndResetChangeRace()
	self._isRaceTypeChange = false

	return (checkbool(self._isRaceTypeChange))
end

function FormationMO:GetSummonMasterPetId()
	return checknumber(self.summonMasterPetId)
end

function FormationMO:GetSummonPetId()
	return checknumber(self.summonedPetId)
end

function FormationMO:ToString()
	local str = "["

	for i, v in ipairs(self:GetPositions()) do
		str = str .. v .. ","
	end

	str = str .. "] " .. self:GetHeroSkillId()

	return str
end

function FormationMO:ToString2()
	local str = ""

	for k, v in pairs(self._hasPets) do
		str = str .. tostring(k) .. "," .. tostring(v) .. "\n"
	end

	return str
end

function FormationMO:checkYuanLimit(data)
	local canNotUp = false

	if data and PetSkinConfig.instance:checkHasEleAttr(data.curFaceId, GameEnum.RaceType.Yuan) then
		local count = 0

		for _, petId in ipairs(self:GetPositions()) do
			if petId > 0 then
				local pet = self:_getPet(petId)

				if pet and PetSkinConfig.instance:checkHasEleAttr(pet.curFaceId, GameEnum.RaceType.Yuan) then
					count = count + 1
				end
			end
		end

		if count >= YUAN_LIMIT then
			canNotUp = true
		end
	end

	return canNotUp
end

function FormationMO:setExtGetPetFunc(func)
	self.extGetPetFunc = func
end

function FormationMO:getPowerAndSpeed(isUseCutePet)
	local team, formation, speed = self:getTeamAndFormation()
	local fid, flvl = self:GetFormStrengthIdAndLv()
	local heroSkill = self:GetHeroSkillId()
	local eleMap = self:getCurElementRelationMap()
	local cutePetRaceId, cutePetQuality = 0, 0

	if isUseCutePet == nil or isUseCutePet == true then
		cutePetRaceId, cutePetQuality = self:getCutePetInfo()
	end

	return FightingPowerFormula.instance:getTeamFightingPower(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, self.summonMasterPetId, self.summonedPetId), speed
end

function FormationMO:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, flvl
end

function FormationMO:getTeamAndFormation()
	local team = {}
	local formations = {}
	local speed = 0

	for idx = 1, 9 do
		local v = checknumber(self._positions[idx])

		if v > 0 then
			local pet = self:_getPet(v)

			if pet then
				table.insert(team, pet)

				formations[idx] = pet

				if self.summonedPetId ~= pet.petId then
					speed = speed + pet._speed
				end
			end
		end
	end

	return team, formations, speed
end

function FormationMO:_getPet(id, isNotShowLog)
	local mo = self.myGetPetFunc and GameUtil.callBack(self.myGetPetFunc, id) or BagPetsController.instance:getPet(id)

	if mo == nil then
		mo = GameUtil.callBack(self.extGetPetFunc, id)
	end

	if not isNotShowLog and id > 0 and mo == nil and BagPetsController.instance:getReady() and self.myGetPetFunc == nil and enableDebug then
		printError(">>>>>>>>>>>>>>> 通过自己背包数据找不到petId=【", id, "】数据，确保自己需要继承FormationMO 还是 需要通过New 传 myGetPetFunc 进来 ")
	end

	if mo and mo:isExist() then
		return mo
	end
end

function FormationMO:createFormPb(formPb)
	return (FormationFacade.createFormPb(formPb, self))
end

function FormationMO:checkHasBorrowPet()
	local isExistBorrowPet = false

	for i, v in ipairs(self._positions) do
		local petMo = self:_getPet(v)

		if petMo and petMo:isBorrowPet() then
			isExistBorrowPet = true

			break
		end
	end

	return isExistBorrowPet
end

function FormationMO:checkAllBorrowPet(...)
	local checkList = {
		...
	}

	for i, v in ipairs(checkList) do
		local petMo = self:_getPet(v)

		if petMo and not petMo:isBorrowPet() then
			return false
		end
	end

	return true
end

function FormationMO:SetHeavenAwakenMasterId(masterId)
	if self._heavenAwakenMasterId ~= masterId then
		self._heavenAwakenMasterId = masterId

		return true
	else
		return false
	end
end

function FormationMO:GetHeavenAwakenMasterId()
	return self._heavenAwakenMasterId
end

function FormationMO:SetHeavenAwakenSummonPetId(summonId)
	if self._heavenAwakenSummonPetId ~= summonId then
		self._heavenAwakenSummonPetId = summonId

		return true
	else
		return false
	end
end

function FormationMO:GetHeavenAwakenSummonPetId()
	return self._heavenAwakenSummonPetId
end

function FormationMO:SetSpiritInvocationPetId(petId)
	if self._spiritInvocationPetId ~= petId then
		self._spiritInvocationPetId = petId

		return true
	else
		return false
	end
end

function FormationMO:GetSpiritInvocationPetId()
	self:fixAndUpdateSpiritInvocationkill()

	return self._spiritInvocationPetId
end

return FormationMO
