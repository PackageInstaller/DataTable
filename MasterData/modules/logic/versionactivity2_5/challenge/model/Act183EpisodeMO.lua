-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183EpisodeMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183EpisodeMO", package.seeall)

local Act183EpisodeMO = pureTable("Act183EpisodeMO")

function Act183EpisodeMO:init(info)
	self._episodeId = info.episodeId
	self._isPass = tonumber(info.status) == 1
	self._passOrder = info.passOrder or 0
	self._heroes = Act183Helper.rpcInfosToList(info.heroes, Act183HeroMO)
	self._useBadgeNum = info.useBadgeNum
	self._unlockConditions = {}

	tabletool.addValues(self._unlockConditions, info.unlockConditions)

	self._chooseConditions = {}

	tabletool.addValues(self._chooseConditions, info.chooseConditions)

	self._repress = Act183RepressMO.New()

	self._repress:init(info.repress)

	self._config = Act183Config.instance:getEpisodeCo(self._episodeId)
	self._groupId = self._config and self._config.groupId
	self._params = info.params
	self._star = info.star
	self._simulate = info.simulate
	self._totalStarCount = Act183Helper.calcEpisodeTotalConditionCount(self._episodeId)

	self:_buildEscapeRules()
end

function Act183EpisodeMO:_buildEscapeRules()
	if self._config then
		if self._config then
			local rule2 = self._config.ruleDesc2

			self._escapeRules = {}

			local repressIndex = self._repress:getRuleIndex()

			if repressIndex ~= 1 then
				table.insert(self._escapeRules, self._config)
			end

			if repressIndex ~= 2 then
				table.insert(self._escapeRules, rule2)
			end

			self._baseRuleNum = 0
		end
	end
end

function Act183EpisodeMO:getEpisodeId()
	return self._episodeId
end

function Act183EpisodeMO:getStatus()
	return (self._isPass or nil) and (Act183Enum.EpisodeStatus.Finished or Act183Enum.EpisodeStatus.Unlocked)
end

function Act183EpisodeMO:getPreEpisodeIds()
	if self._config and not string.nilorempty(self._config.preEpisodeIds) then
		return string.splitToNumber(self._config.preEpisodeIds, "#")
	end
end

function Act183EpisodeMO:isLocked()
	local status = self:getStatus()

	return status == Act183Enum.EpisodeStatus.Locked
end

function Act183EpisodeMO:isFinished()
	local status = self:getStatus()

	return status == Act183Enum.EpisodeStatus.Finished
end

function Act183EpisodeMO:getPassConditions()
	return self._unlockConditions
end

function Act183EpisodeMO:getConfig()
	return self._config
end

function Act183EpisodeMO:getEpisodeType()
	return Act183Helper.getEpisodeType(self._episodeId)
end

function Act183EpisodeMO:getGroupType()
	return self._config and self._config.type
end

function Act183EpisodeMO:getRepressMo()
	return self._repress
end

function Act183EpisodeMO:updateRepressMo(repressInfo)
	self._repress = self._repress or Act183RepressMO.New()

	self._repress:init(repressInfo)
	self:_buildEscapeRules()
end

function Act183EpisodeMO:getRuleStatus(ruleIndex)
	local status = self:getStatus()

	if status ~= Act183Enum.EpisodeStatus.Finished then
		return Act183Enum.RuleStatus.Enabled
	end

	local repressRuleIndex = self._repress:getRuleIndex()

	if repressRuleIndex == ruleIndex then
		return Act183Enum.RuleStatus.Repress
	end

	return Act183Enum.RuleStatus.Escape
end

function Act183EpisodeMO:getPassOrder()
	return self._passOrder
end

function Act183EpisodeMO:getConfigOrder()
	return self._config.order
end

function Act183EpisodeMO:getConditionIds()
	if self._config then
		return string.splitToNumber(self._config.condition, "#")
	end
end

function Act183EpisodeMO:isConditionPass(conditionId)
	if self._unlockConditions then
		return tabletool.indexOf(self._unlockConditions, conditionId) ~= nil
	end
end

function Act183EpisodeMO:isAllConditionPass()
	local status = self:getStatus()

	if status ~= Act183Enum.EpisodeStatus.Finished then
		return false
	end

	local conditions = string.splitToNumber(self._config.condition, "#")

	for _, conditionId in ipairs(conditions) do
		if not self:isConditionPass(conditionId) then
			return false
		end
	end

	return true
end

function Act183EpisodeMO:getEscapeRules()
	return self._escapeRules
end

function Act183EpisodeMO:getUseBadgeNum()
	return self._useBadgeNum
end

function Act183EpisodeMO:getHeroes()
	return self._heroes
end

function Act183EpisodeMO:getRepressHeroMo()
	local hasRepress = self._repress:hasRepress()

	if hasRepress then
		local heroIndex = self._repress:getHeroIndex()

		return self._heroes[heroIndex]
	end
end

function Act183EpisodeMO:isHeroRepress(heroId)
	local repressHeroMo = self:getRepressHeroMo()

	if repressHeroMo then
		return repressHeroMo:getHeroId() == heroId
	end
end

function Act183EpisodeMO:setSelectConditions(selectConditionIds)
	self._selectConditionIds = selectConditionIds
end

function Act183EpisodeMO:getGroupId()
	return self._groupId
end

function Act183EpisodeMO:getFinishStarCount()
	return self._star
end

function Act183EpisodeMO:getTotalStarCount()
	return self._totalStarCount
end

function Act183EpisodeMO:isSimulate()
	return self._simulate
end

return Act183EpisodeMO
