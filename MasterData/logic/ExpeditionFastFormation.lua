-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/ExpeditionFastFormation.lua

module("logic.extensions.formation.model.ExpeditionFastFormation", package.seeall)

local ExpeditionFastFormation = class("ExpeditionFastFormation", FastFormation)

function ExpeditionFastFormation:_getCurFormId()
	return ExpeditionFmtModel.instance:getCurFormationId()
end

function ExpeditionFastFormation:_getCurFormation()
	return ExpeditionFmtModel.instance:getFormation()
end

function ExpeditionFastFormation:_getPets()
	local pets = ExpeditionFmtModel.instance:getAllPets()
	local alivePets = {}

	for i = 1, #pets do
		if not ExpeditionModel.instance:isPetDead(pets[i].petId) then
			table.insert(alivePets, pets[i])
		end
	end

	return alivePets
end

function ExpeditionFastFormation:_getPet(id)
	return ExpeditionFmtModel.instance:getPet(id)
end

function ExpeditionFastFormation:_filterByRace(arr)
	ArraySort.sortOn(arr, {
		"raceId",
		function(x)
			return (x:getFightingPower())
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

ExpeditionFastFormation.instance = ExpeditionFastFormation.New()

return ExpeditionFastFormation
