-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummontowerFmtModel.lua

module("logic.extensions.expedition.model.SummontowerFmtModel", package.seeall)

local SummontowerFmtModel = class("SummontowerFmtModel", BaseModel)

function SummontowerFmtModel:onInit()
	self._formation = nil
	self._svrFormation = nil
	self._teamId = 1
end

function SummontowerFmtModel:onReset()
	self._formation = nil
	self._teamId = 1
end

function SummontowerFmtModel:initFormation()
	self._teamId = self._teamId or 1
	self._formation = SummontowerFormationMO.New()

	self._formation:SetData(nil)
end

function SummontowerFmtModel:checkFormationValid()
	local formation = self:getFormation()

	if not formation then
		return
	end

	local pet_poisition = formation:GetPositions()
	local dirty

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = SummontowerPetsModel.instance:getPet(checknumber(v))

			if not pet then
				pet_poisition[i] = 0
				dirty = true
			end
		end
	end

	if dirty then
		formation:setPositionForce(pet_poisition)
		self:saveCurrFormation()
	end
end

function SummontowerFmtModel:toSimpleForm()
	return (self._formation:createFormPb())
end

function SummontowerFmtModel:isCurFormationEmpty()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function SummontowerFmtModel:setFormation(form)
	self._teamId = self._teamId or 1
	self._formation = SummontowerFormationMO.New()

	self._formation:SetData(form)
	self:_saveAsSvrFometion(form)
end

function SummontowerFmtModel:getFightingMonsterMos(gridData)
	local petMos = {}
	local creeps = self:getFightingCreeps(gridData)

	for i = 1, #creeps do
		local petMo = FightingPowerPetMo.New()

		petMo:fromChallengeCreepCo(creeps[i])
		table.insert(petMos, petMo)
	end

	return petMos
end

function SummontowerFmtModel:getFightingCreeps(gridData)
	local guardEvent = gridData.guardEvent
	local guardEventCo = SummontowerConfig.instance:getGuardEventCo(gridData.gridEventId)
	local creepsCo = SummontowerConfig.instance:getCreepCo(guardEventCo.creepsMasterId)
	local creeps = {}

	for k, v in pairs(creepsCo) do
		local isDead = false

		for j = 1, #guardEvent.creepsHpInfos do
			if guardEvent.creepsHpInfos[j].creepsId == v.creepsId and guardEvent.creepsHpInfos[j].hp <= 0 then
				isDead = true

				break
			end
		end

		if not isDead then
			table.insert(creeps, v)
		end
	end

	return creeps, 0
end

function SummontowerFmtModel:getFightingPowerOfFmt(gridData)
	local teams = self:getFightingMonsterMos(gridData)
	local fightingPower = 0

	for i = 1, #teams do
		fightingPower = fightingPower + teams[i].fightingPower
	end

	return math.floor(fightingPower)
end

function SummontowerFmtModel:getPetIdInTeamByRaceId(raceId)
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = SummontowerPetsModel.instance:getPet(checknumber(v))

			if pet and pet.raceId == raceId then
				return pet.petId
			end
		end
	end

	return 0
end

function SummontowerFmtModel:setTeamId(teamId)
	self._teamId = teamId
end

function SummontowerFmtModel:getTeamId()
	return self._teamId
end

function SummontowerFmtModel:getFormation()
	return self._formation
end

function SummontowerFmtModel:changePosition(pos, value)
	self._formatio:SetPosition(pos, value)
end

function SummontowerFmtModel:changeSkillId(id)
	self._formation:SetHeroSkillId(id)
end

function SummontowerFmtModel:getHeroSkillId()
	return self._formation:GetHeroSkillId()
end

function SummontowerFmtModel:getCurFormationId()
	return self._formation:GetId()
end

function SummontowerFmtModel:getFormPetsHeroSkills()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = SummontowerPetsModel.instance:getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function SummontowerFmtModel:getCurrBuffFormId()
	local info = self._formation:GetFormStrengthInfo()

	if info and info.formStrengthId then
		return info.formStrengthId
	end
end

function SummontowerFmtModel:setCurrBuffFormInfo(formStrengthId)
	local info = FormationNewModel.instance:getFormStrengthInfo(formStrengthId)

	if info then
		local fomation = self._formation

		if fomation and fomation._formStrengInfo ~= formStrengthId then
			fomation:SetFormStrengthInfo(info)
		end
	end
end

function SummontowerFmtModel:onViewClose()
	self:saveCurrFormation()
end

function SummontowerFmtModel:saveCurrFormation()
	local form = self._formation:createFormPb()

	self:_saveAsSvrFometion(form)
end

function SummontowerFmtModel:_saveAsSvrFometion(form)
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
	self._svrFormation.extParams.cutePetId = form.extParams.cutePetId
	self._svrFormation.extParams.cutePetRaceId = form.extParams.cutePetRaceId
	self._svrFormation.extParams.cutePetQuality = form.extParams.cutePetQuality
end

SummontowerFmtModel.instance = SummontowerFmtModel.New()

return SummontowerFmtModel
