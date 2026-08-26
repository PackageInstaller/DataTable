-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183EpisodeRecordMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183EpisodeRecordMO", package.seeall)

local Act183EpisodeRecordMO = pureTable("Act183EpisodeRecordMO")

function Act183EpisodeRecordMO:init(info)
	self._episodeId = info.episodeId
	self._passOrder = info.passOrder
	self._heroes = Act183Helper.rpcInfosToList(info.heroes, Act183HeroMO)
	self._useBadgeNum = info.useBadgeNum
	self._passConditions = {}

	tabletool.addValues(self._passConditions, info.unlockConditions)

	self._chooseConditions = {}

	tabletool.addValues(self._chooseConditions, info.chooseConditions)

	self._repress = Act183RepressMO.New()

	self._repress:init(info.repress)

	self._config = Act183Config.instance:getEpisodeCo(self._episodeId)
	self._params = info.params
	self._star = info.star
	self._simulate = info.simulate
	self._round = info.round
	self._totalStarCount = Act183Helper.calcEpisodeTotalConditionCount(self._episodeId)
end

function Act183EpisodeRecordMO:getConfig()
	return self._config
end

function Act183EpisodeRecordMO:getEpisodeId()
	return self._episodeId
end

function Act183EpisodeRecordMO:getPassOrder()
	return self._passOrder
end

function Act183EpisodeRecordMO:getUseBadgeNum()
	return self._useBadgeNum
end

function Act183EpisodeRecordMO:getHeroMos()
	return self._heroes
end

function Act183EpisodeRecordMO:getEpisodeType()
	return Act183Helper.getEpisodeType(self._episodeId)
end

function Act183EpisodeRecordMO:getGroupType()
	return self._config and self._config.type
end

function Act183EpisodeRecordMO:getConditionIds()
	if self._config then
		return string.splitToNumber(self._config.condition, "#")
	end
end

function Act183EpisodeRecordMO:getPassConditions()
	return self._passConditions
end

function Act183EpisodeRecordMO:getChooseConditions()
	return self._chooseConditions
end

function Act183EpisodeRecordMO:isConditionPass(conditionId)
	if self._passConditions then
		return tabletool.indexOf(self._passConditions, conditionId) ~= nil
	end
end

function Act183EpisodeRecordMO:getAllConditions()
	return (string.splitToNumber(self._config.condition, "#"))
end

function Act183EpisodeRecordMO:isAllConditionPass()
	local conditions = self:getAllConditions()

	for _, conditionId in ipairs(conditions) do
		if not self:isConditionPass(conditionId) then
			return false
		end
	end

	return true
end

function Act183EpisodeRecordMO:getRuleStatus(ruleIndex)
	local repressRuleIndex = self._repress:getRuleIndex()

	if repressRuleIndex == ruleIndex then
		return Act183Enum.RuleStatus.Repress
	end

	return Act183Enum.RuleStatus.Escape
end

function Act183EpisodeRecordMO:getFinishStarCount()
	return self._star
end

function Act183EpisodeRecordMO:getTotalStarCount()
	return self._totalStarCount
end

function Act183EpisodeRecordMO:isSimulate()
	return self._simulate
end

function Act183EpisodeRecordMO:getRound()
	return self._round
end

return Act183EpisodeRecordMO
