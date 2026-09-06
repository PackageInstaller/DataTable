-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/model/RankRaceFmtModel.lua

module("logic.extensions.rankrace.model.RankRaceFmtModel", package.seeall)

local RankRaceFmtModel = class("RankRaceFmtModel", BaseListModel)

function RankRaceFmtModel:onInit()
	RankRaceFmtModel.super.onInit(self)
end

function RankRaceFmtModel:onReset()
	RankRaceFmtModel.super.onReset(self)

	self._defenseForms = nil
	self._defenseBuffIds = nil
	self._svrFormation = nil
	self._readyTime = nil
end

function RankRaceFmtModel:setDefenseForm(matchType, defenseForm, _isTable)
	self._defenseForms = self._defenseForms or {}

	local formation = FormationMO.New()

	formation:SetData(GameUtil.pbToTable(defenseForm))

	if _isTable then
		formation._positions = defenseForm.pos
		formation._hasPets = defenseForm._hasPets
	end

	local masterId = 0
	local summonId = 0

	for i, v in pairs(formation:GetPositions() or {}) do
		local petMo = formation:_getPet(v, true)

		if petMo then
			if checknumber(petMo.summonMasterId) > 0 then
				summonId = petMo.petId
			end

			if checknumber(petMo.summonedPetId) > 0 then
				masterId = petMo.petId
			end
		end
	end

	if checknumber(formation.summonMasterPetId) <= 0 and checknumber(formation.summonedPetId) <= 0 then
		formation.summonMasterPetId = masterId
		formation.summonedPetId = summonId
	end

	self._defenseForms[matchType] = formation

	self:_saveAsSvrFometion(matchType, formation)
end

function RankRaceFmtModel:getDefenseForm(matchType)
	if self._defenseForms then
		return self._defenseForms[matchType]
	end
end

function RankRaceFmtModel:setDefenseBuffId(matchType, defenseBuffId)
	self._defenseBuffIds = self._defenseBuffIds or {}
	self._defenseBuffIds[matchType] = defenseBuffId
end

function RankRaceFmtModel:getDefenseBuffId(matchType)
	if self._defenseBuffIds then
		return self._defenseBuffIds[matchType]
	end
end

function RankRaceFmtModel:isCurDefFormationEmpty(matchType)
	local formation = self:getDefenseForm(matchType)

	if not formation then
		return true
	end

	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function RankRaceFmtModel:getPetIdInDefTeamByRaceId(matchType, raceId)
	local formation = self:getDefenseForm(matchType)

	if not formation then
		return 0
	end

	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(checknumber(v))

			if pet.raceId == raceId then
				return pet.petId
			end
		end
	end

	return 0
end

function RankRaceFmtModel:changePosition(matchType, pos, value)
	self:_ensureDefFmtNotEmpty(matchType)

	local formation = self:getDefenseForm(matchType)

	formation:SetPosition(pos, value)
end

function RankRaceFmtModel:changeSkillId(matchType, id)
	self:_ensureDefFmtNotEmpty(matchType)

	local formation = self:getDefenseForm(matchType)

	formation:SetHeroSkillId(id)
end

function RankRaceFmtModel:getHeroSkillId(matchType)
	self:_ensureDefFmtNotEmpty(matchType)

	local formation = self:getDefenseForm(matchType)

	return formation:GetHeroSkillId()
end

function RankRaceFmtModel:getCurFormationId(matchType)
	self:_ensureDefFmtNotEmpty(matchType)

	local formation = self:getDefenseForm(matchType)

	return formation:GetId()
end

function RankRaceFmtModel:getFormPetsHeroSkills(matchType)
	self:_ensureDefFmtNotEmpty(matchType)

	local formation = self:getDefenseForm(matchType)
	local pet_poisition = formation:GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function RankRaceFmtModel:onViewClose(matchType)
	if RankRaceController.instance:getCloseForReset() then
		RankRaceController.instance:setCloseForReset(false)
	else
		self:saveCurrFormation(matchType)
	end
end

function RankRaceFmtModel:resetCurrFormation(matchType)
	local formation = FormationMO.New()

	formation.summonedPetId = self._svrFormation[matchType].summonedPetId
	formation._id = self._svrFormation[matchType]._id
	formation._heroSkillId = self._svrFormation[matchType]._heroSkillId
	formation._psychicedSkillId = self._svrFormation[matchType]._psychicedSkillId

	formation:SetFormStrengthInfo(self._svrFormation[matchType]:GetFormStrengthInfo())

	formation._hasPets = self._svrFormation[matchType]._hasPets
	formation._positions = {}

	for i, v in ipairs(self._svrFormation[matchType]._positions) do
		formation._positions[i] = v
	end

	self._defenseForms[matchType] = formation
end

function RankRaceFmtModel:saveCurrFormation(matchType)
	local isDirty = false
	local fmtId = self:getCurFormationId(matchType)
	local formation = self:getDefenseForm(matchType)
	local svrFormation = self._svrFormation[matchType]
	local poses = formation:GetPositions()
	local skillId = formation:GetHeroSkillId()
	local psychicSkillId = formation:GetPsychicedSkillId()

	if fmtId ~= svrFormation._id then
		isDirty = true
	end

	if not isDirty and svrFormation._heroSkillId ~= skillId then
		isDirty = true
	end

	if not isDirty and svrFormation.psychicSkillId ~= psychicSkillId then
		isDirty = true
	end

	if not isDirty then
		local svrPoses = svrFormation._positions

		for i = 1, #poses do
			if poses[i] ~= svrPoses[i] then
				isDirty = true

				break
			end
		end
	end

	local form = formation:createFormPb()

	self:_saveAsSvrFometion(matchType, formation)
	RankingMatchAgent.instance:sendRM_SetDefenseFormReq(matchType, form)

	return isDirty
end

function RankRaceFmtModel:_saveAsSvrFometion(matchType, form)
	self._svrFormation = self._svrFormation or {}

	local formation = FormationMO.New()

	formation.summonedPetId = form.summonedPetId
	formation._id = form._id
	formation._heroSkillId = form._heroSkillId
	formation._psychicedSkillId = form._psychicedSkillId

	formation:SetFormStrengthInfo(form:GetFormStrengthInfo())

	formation._hasPets = form._hasPets
	formation._positions = {}

	for i, v in ipairs(form._positions) do
		formation._positions[i] = v
	end

	self._svrFormation[matchType] = formation
end

function RankRaceFmtModel:_ensureDefFmtNotEmpty(matchType)
	self._defenseForms = self._defenseForms or {}

	local formation = self:getDefenseForm(matchType)

	if not formation then
		formation = FormationMO.New()
		self._defenseForms[matchType] = formation
	end
end

function RankRaceFmtModel:getCurrBuffFormId(matchtype)
	local formStrengthId = self:getDefenseForm(matchtype):GetFormStrengthInfo()

	if formStrengthId then
		return formStrengthId
	end

	return 0
end

function RankRaceFmtModel:setCurrBuffFormId(formStrengthId, matchtype)
	local formation = self:getDefenseForm(matchtype)
	local info = FormationNewModel.instance:getFormStrengthInfo(formStrengthId)

	if matchtype == RankRaceController.MatchTypeLimit then
		info = {
			formStrengthId = formStrengthId,
			formStrengthLv = BattleConfig.instance:getFormStrengthMaxLv(formStrengthId)
		}
	end

	if info then
		formation:SetFormStrengthInfo(info)
	end
end

RankRaceFmtModel.instance = RankRaceFmtModel.New()

return RankRaceFmtModel
