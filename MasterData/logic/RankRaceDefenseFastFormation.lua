-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDefenseFastFormation.lua

module("logic.extensions.rankrace.view.RankRaceDefenseFastFormation", package.seeall)

local RankRaceDefenseFastFormation = class("RankRaceDefenseFastFormation", FastFormation)

function RankRaceDefenseFastFormation:_getCurFormId()
	return RankRaceFmtModel.instance:getCurFormationId(self._matchType)
end

function RankRaceDefenseFastFormation:_getCurFormation()
	return RankRaceFmtModel.instance:getDefenseForm(self._matchType)
end

function RankRaceDefenseFastFormation:_getPets()
	return BagPetsController.instance:getFightBagPet()
end

function RankRaceDefenseFastFormation:_getPet(id)
	return BagPetsController.instance:getPet(id)
end

function RankRaceDefenseFastFormation:setMatchType(matchType)
	self._matchType = matchType
end

RankRaceDefenseFastFormation.instance = RankRaceDefenseFastFormation.New()

return RankRaceDefenseFastFormation
