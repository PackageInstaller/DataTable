-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddesGloryFastFormation.lua

module("logic.extensions.goddessglory.model.GoddesGloryFastFormation", package.seeall)

local GoddesGloryFastFormation = class("GoddesGloryFastFormation", FastFormation)

function GoddesGloryFastFormation:setCurrChallengeId(challengeId, stageId)
	self._challengeId = challengeId
	self._stageId = stageId
end

function GoddesGloryFastFormation:_getCurFormId()
	return GoddessGloryFmtModel.instance:getCurFormationId(self._challengeId, self._stageId)
end

function GoddesGloryFastFormation:_getCurFormation()
	return GoddessGloryFmtModel.instance:getFormation(self._challengeId, self._stageId)
end

function GoddesGloryFastFormation:_getPets()
	return GoddessGloryPetsModel.instance:getAllPets(self._challengeId, self._stageId)
end

function GoddesGloryFastFormation:_getPet(id)
	return GoddessGloryPetsModel.instance:getPet(self._challengeId, self._stageId, id)
end

function GoddesGloryFastFormation:_filterByRace(arr)
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

GoddesGloryFastFormation.instance = GoddesGloryFastFormation.New()

return GoddesGloryFastFormation
