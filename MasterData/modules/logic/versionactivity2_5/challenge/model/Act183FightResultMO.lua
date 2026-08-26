-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183FightResultMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183FightResultMO", package.seeall)

local Act183FightResultMO = pureTable("Act183FightResultMO")

function Act183FightResultMO:init(info)
	self._episodeId = info.episodeId
	self._heroes = Act183Helper.rpcInfosToList(info.heroes, Act183HeroMO)
	self._unlockConditions = {}

	tabletool.addValues(self._unlockConditions, info.unlockConditions)

	self._star = info.star
end

function Act183FightResultMO:getHeroes()
	return self._heroes
end

function Act183FightResultMO:isConditionPass(conditionId)
	if self._unlockConditions then
		return tabletool.indexOf(self._unlockConditions, conditionId) ~= nil
	end
end

function Act183FightResultMO:getFinishStarCount()
	return self._star
end

return Act183FightResultMO
