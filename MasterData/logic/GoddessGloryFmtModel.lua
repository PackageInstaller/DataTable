-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryFmtModel.lua

module("logic.extensions.goddessglory.model.GoddessGloryFmtModel", package.seeall)

local GoddessGloryFmtModel = class("GoddessGloryFmtModel", BaseModel)

function GoddessGloryFmtModel:onInit()
	self._formations = nil
	self._teamId = 1
	self._formationNums = nil
end

function GoddessGloryFmtModel:onReset()
	self._formations = nil
	self._teamId = 1
	self._formationNums = nil
end

function GoddessGloryFmtModel:checkFormationValid(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)

	if not formation then
		return
	end

	local pet_poisition = formation:GetPositions()
	local dirty

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = GoddessGloryPetsModel.instance:getPet(challengeId, stageId, checknumber(v))

			if not pet then
				pet_poisition[i] = 0
				dirty = true
			end
		end
	end

	if dirty then
		formation:setPositionForce(pet_poisition)
		self:saveCurrFormation(challengeId, stageId)
	end
end

function GoddessGloryFmtModel:getFightingCreeps(eventId)
	local eventCo = GoddessGloryConfig.instance:getEventCo(eventId)
	local creepsCo = GoddessGloryConfig.instance:getCreepCo(eventCo.creepsMasterId)
	local creeps = {}

	for k, v in pairs(creepsCo) do
		table.insert(creeps, v)
	end

	return creeps, 0
end

function GoddessGloryFmtModel:toSimpleForm(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)

	return (formation:createFormPb())
end

function GoddessGloryFmtModel:isCurFormationEmpty(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function GoddessGloryFmtModel:setFormation(challengeId, stageId, canFormCount, form)
	self._teamId = self._teamId or 1
	self._formations = self._formations or {}
	self._formations[challengeId] = self._formations[challengeId] or {}

	local formation = GoddessGloryFormationMO.New()

	self._formations[challengeId][stageId] = formation

	formation:SetData(form)

	self._formationNums = self._formationNums or {}
	self._formationNums[challengeId] = self._formationNums[challengeId] or {}
	self._formationNums[challengeId][stageId] = canFormCount
end

function GoddessGloryFmtModel:clearFormation(challengeId, stageId)
	if self._formations and self._formations[challengeId] then
		self._formations[challengeId][stageId] = nil
	end

	if self._formationNums and self._formationNums[challengeId] then
		self._formationNums[challengeId][stageId] = nil
	end
end

function GoddessGloryFmtModel:canFormCount(challengeId, stageId)
	if not self._formationNums or not self._formationNums[challengeId] then
		return 0
	end

	return self._formationNums[challengeId][stageId] or 0
end

function GoddessGloryFmtModel:addCanFormCount(challengeId, stageId)
	local num = self:canFormCount(challengeId, stageId)

	self._formationNums = self._formationNums or {}
	self._formationNums[challengeId] = self._formationNums[challengeId] or {}
	self._formationNums[challengeId][stageId] = num + 1
end

function GoddessGloryFmtModel:getFormation(challengeId, stageId)
	if not self._formations or not self._formations[challengeId] then
		return
	end

	return self._formations[challengeId][stageId]
end

function GoddessGloryFmtModel:getPetIdInTeamByRaceId(challengeId, stageId, raceId)
	local formation = self:getFormation(challengeId, stageId)
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = GoddessGloryPetsModel.instance:getPet(challengeId, stageId, checknumber(v))

			if pet and pet.raceId == raceId then
				return pet.petId
			end
		end
	end

	return 0
end

function GoddessGloryFmtModel:getIdInTeamPetsCount(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)
	local pet_poisition = formation:GetPositions()
	local cnt = 0

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = GoddessGloryPetsModel.instance:getPet(challengeId, stageId, checknumber(v))

			if pet then
				cnt = cnt + 1
			end
		end
	end

	return cnt
end

function GoddessGloryFmtModel:setTeamId(teamId)
	self._teamId = teamId
end

function GoddessGloryFmtModel:getTeamId()
	return self._teamId
end

function GoddessGloryFmtModel:changePosition(challengeId, stageId, pos, value)
	local formation = self:getFormation(challengeId, stageId)

	formation:SetPosition(pos, value)
end

function GoddessGloryFmtModel:changeSkillId(challengeId, stageId, id)
	local formation = self:getFormation(challengeId, stageId)

	formation:SetHeroSkillId(id)
end

function GoddessGloryFmtModel:getHeroSkillId(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)

	return formation:GetHeroSkillId()
end

function GoddessGloryFmtModel:getCurFormationId(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)

	return formation:GetId()
end

function GoddessGloryFmtModel:getFormPetsHeroSkills(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)
	local pet_poisition = formation:GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = GoddessGloryPetsModel.instance:getPet(challengeId, stageId, checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function GoddessGloryFmtModel:getCurrBuffFormId(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)
	local info = formation:GetFormStrengthInfo()

	if info and info.formStrengthId then
		return info.formStrengthId
	end
end

function GoddessGloryFmtModel:setCurrBuffFormInfo(challengeId, stageId, formStrengthId)
	local info = FormationNewModel.instance:getFormStrengthInfo(formStrengthId)

	if info then
		local fomation = self:getFormation(challengeId, stageId)

		if fomation and fomation._formStrengInfo ~= formStrengthId then
			fomation:SetFormStrengthInfo(info)
		end
	end
end

function GoddessGloryFmtModel:onViewClose(challengeId, stageId)
	self:saveCurrFormation(challengeId, stageId)
end

function GoddessGloryFmtModel:saveCurrFormation(challengeId, stageId)
	local fmtId = self:getCurFormationId(challengeId, stageId)
	local formation = self:getFormation(challengeId, stageId)
	local poses = formation:GetPositions()
	local skillId = formation:GetHeroSkillId()
	local form = formation:createFormPb()

	GoddessGloryController.instance:requestGoddessGlorySetForm(form, challengeId, stageId)
end

function GoddessGloryFmtModel:onGoddessGlorySetForm(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
end

GoddessGloryFmtModel.instance = GoddessGloryFmtModel.New()

return GoddessGloryFmtModel
