-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/TeamMO.lua

module("logic.extensions.formation.model.TeamMO", package.seeall)

local TeamMO = tableMO()

function TeamMO:ctor()
	self._id = nil
	self._formationId = nil
	self._formations = {}
	self._tabName = "default"
end

function TeamMO:SetData(data)
	self._id = data.tabId
	self._formationId = data.curFormId or 10

	if data.simpleForm then
		local formation = self._formations[data.simpleForm.formId]

		if not formation then
			formation = FormationMO.New()
			self._formations[data.simpleForm.formId] = formation
		end

		formation:SetData(data.simpleForm)
		formation:SetData(data.simpleForm)
	end

	self._tabName = data.tabName or self._tabName
end

function TeamMO:RefreshFormData(data)
	self._id = data.tabId
	self._formationId = data.curFormId or 10

	local formation = self._formations[data.simpleForm.formId]

	if not formation then
		formation = FormationMO.New()
		self._formations[data.simpleForm.formId] = formation
	end

	formation:SetData(data.simpleForm)

	self._tabName = data.tabName or self._tabName
end

function TeamMO:setTabName(tabName)
	self._tabName = tabName or self._tabName
end

function TeamMO:getTabName()
	return self._tabName
end

function TeamMO:GetId()
	return self._id
end

function TeamMO:GetCurFormationId()
	return self._formationId
end

function TeamMO:checkHasFormationId(fid)
	return self._id == fid
end

function TeamMO:GetAllFormations()
	return self._formations
end

function TeamMO:GetFormation(formationId)
	return self:GetAllFormations()[formationId]
end

function TeamMO:GetCurFormation()
	return self:GetFormation(self._formationId)
end

function TeamMO:GetFormPetsHeroSkills(formationId)
	local formation_id = formationId or self._formationId
	local formation = self:GetFormation(formation_id)
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

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), formation:GetSummonMasterPetId(), formation:GetSummonPetId()))
end

function TeamMO:getCurExistPetNumber()
	local superFmtId = 10
	local formationMO = self._formations[superFmtId]

	if formationMO then
		return formationMO:getCurExistPetNumber()
	end

	return 0
end

function TeamMO:HasPet(petId)
	return TableUtil.Any(self._formations, function(k, v)
		return v:HasPet(petId)
	end, pairs)
end

function TeamMO:ToString()
	local str = tostring(self._formationId) .. "\n"

	for id, formation in ipairs(self:GetAllFormations()) do
		str = str .. string.format("formation %d - ", id) .. formation:ToString() .. "\n"
	end

	return str
end

return TeamMO
