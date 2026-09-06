-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerFastFormation.lua

module("logic.extensions.formation.model.SummontowerFastFormation", package.seeall)

local SummontowerFastFormation = class("SummontowerFastFormation", FastFormation)

function SummontowerFastFormation:_getCurFormId()
	return SummontowerFmtModel.instance:getCurFormationId()
end

function SummontowerFastFormation:_getCurFormation()
	return SummontowerFmtModel.instance:getFormation()
end

function SummontowerFastFormation:_getPets()
	local pets = SummontowerPetsModel.instance:getAllPets()
	local alivePets = {}

	for i = 1, #pets do
		if not ExpeditionModel.instance:isPetDead(pets[i].petId) then
			table.insert(alivePets, pets[i])
		end
	end

	return alivePets
end

function SummontowerFastFormation:_getPet(id)
	return SummontowerPetsModel.instance:getPet(id)
end

function SummontowerFastFormation:_filterByRace(arr)
	ArraySort.sortOn(arr, {
		"raceId",
		function(x)
			local xZdl = x:getFightingPower()

			if x.summonedPetId > 0 then
				xZdl = xZdl + self:_getPet(x.summonedPetId):getFightingPower()
			end

			return xZdl
		end
	}, {
		ArraySort.NUMERIC,
		ArraySort.DESCENDING
	})

	local tem = {}
	local lastId = -1

	for i, v in ipairs(arr) do
		if lastId ~= v.raceId then
			lastId = v.raceId

			table.insert(tem, v)
		end
	end

	return tem
end

SummontowerFastFormation.instance = SummontowerFastFormation.New()

return SummontowerFastFormation
