-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FormationModel.lua

module("logic.extensions.formation.model.FormationModel", package.seeall)

local FormationModel = class("FormationModel", BaseModel)

function FormationModel:ctor()
	FormationModel.super.ctor(self)
end

function FormationModel:isFormationSeatOpen(seatNum)
	return FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPosition(seatNum) == -1
end

function FormationModel:getTeamFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function FormationModel:onReplacePet(id, uid)
	FormationNewModel.instance:GetCurTeam():GetCurFormation():SetPosition(id, uid)
end

function FormationModel:isCurFormationEmpty()
	local team = FormationNewModel.instance:GetCurTeam()

	if not team then
		return true
	end

	local formation = team:GetCurFormation()

	if not formation then
		return true
	end

	for i = 1, 9 do
		local pos = formation:GetPosition(i)

		if not pos then
			return true
		end

		if pos > 0 then
			return false
		end
	end

	return true
end

function FormationModel:isInFormation(id)
	local formation = FormationNewModel.instance:GetCurTeam():GetCurFormation()

	return formation:HasPet(id), formation:GetPetPosition(id)
end

function FormationModel:getCurTab()
	return FormationNewModel.instance:GetCurTeamId()
end

function FormationModel:getCurFormId()
	return FormationNewModel.instance:GetCurTeam():GetCurFormationId()
end

function FormationModel:getForms()
	return
end

function FormationModel:getCurFormPos()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
end

function FormationModel:getActiveForms(tab_id)
	return
end

function FormationModel:setCurTab(tabId)
	FormationNewModel.instance:SetCurTeamId(tabId)
end

FormationModel.instance = FormationModel.New()

return FormationModel
