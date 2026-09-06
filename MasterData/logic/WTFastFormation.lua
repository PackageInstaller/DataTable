-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/model/WTFastFormation.lua

module("logic.extensions.formation.model.WTFastFormation", package.seeall)

local WTFastFormation = class("WTFastFormation", FastFormation)

function WTFastFormation:_getCurFormId()
	return WTowerModel.instance:getCurFormationId()
end

function WTFastFormation:_getCurFormation()
	return WTowerModel.instance:getCurFormation()
end

function WTFastFormation:_getPet(id)
	return WTowerModel.instance:getPet(id)
end

function WTFastFormation:_getPets()
	return WTowerModel.instance:getAllPets()
end

function WTFastFormation:_filterByRace(arr)
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

	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.TowerType.Warrior == towerId then
		return tem
	else
		local tem2 = {}

		for i, v in ipairs(tem) do
			local Races = PetSkinConfig.instance:getFisrtEleAttrIdx(v.curFaceId)

			if towerId - 1 == Races then
				table.insert(tem2, v)
			end
		end

		return tem2
	end
end

WTFastFormation.instance = WTFastFormation.New()

return WTFastFormation
