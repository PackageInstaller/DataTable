-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183GroupEpisodeRecordMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183GroupEpisodeRecordMO", package.seeall)

local Act183GroupEpisodeRecordMO = pureTable("Act183GroupEpisodeRecordMO")

function Act183GroupEpisodeRecordMO:init(info, actId)
	self._playerName = info.playerName
	self._portrait = info.portrait
	self._groupId = info.groupId
	self._allRound = info.allRound

	self:_onEpisodeListInfoLoaded(info.episodeList)

	self._finishedTime = info.finishedTime
	self._actId = actId
end

function Act183GroupEpisodeRecordMO:_onEpisodeListInfoLoaded(episodeList)
	self._episodeList = {}
	self._episodeTypeMap = {}

	for _, episodeInfo in ipairs(episodeList) do
		local episodeMo = Act183EpisodeRecordMO.New()

		episodeMo:init(episodeInfo)
		table.insert(self._episodeList, episodeMo)

		local episodeType = episodeMo:getEpisodeType()

		self._episodeTypeMap[episodeType] = self._episodeTypeMap[episodeType] or {}

		table.insert(self._episodeTypeMap[episodeType], episodeMo)
	end

	local episodeMo = self._episodeList[1]

	self._groupType = episodeMo and episodeMo:getGroupType()

	table.sort(self._episodeList, self._sortEpisodeByPassOrder)

	for _, typeEpisodeList in pairs(self._episodeTypeMap) do
		table.sort(typeEpisodeList, self._sortEpisodeByPassOrder)
	end
end

function Act183GroupEpisodeRecordMO:getUserName()
	return self._playerName
end

function Act183GroupEpisodeRecordMO:getPortrait()
	return self._portrait
end

function Act183GroupEpisodeRecordMO:getFinishedTime()
	return self._finishedTime
end

function Act183GroupEpisodeRecordMO:getAllRound()
	return self._allRound
end

function Act183GroupEpisodeRecordMO:getEpisodeListByType(episodeType)
	if self._episodeTypeMap then
		return self._episodeTypeMap
	end
end

function Act183GroupEpisodeRecordMO:getBossEpisode()
	local bossEpisodes = self:getEpisodeListByType(Act183Enum.EpisodeType.Boss)

	return bossEpisodes and bossEpisodes[1]
end

function Act183GroupEpisodeRecordMO:getEpusideListByTypeAndPassOrder(episodeType)
	return (self:getEpisodeListByType(episodeType))
end

function Act183GroupEpisodeRecordMO._sortEpisodeByPassOrder(aRecord, bRecord)
	local aPassOrder = aRecord:getPassOrder()
	local bPassOrder = bRecord:getPassOrder()

	return aPassOrder < bPassOrder
end

function Act183GroupEpisodeRecordMO:getGroupType()
	return self._groupType
end

function Act183GroupEpisodeRecordMO:getGroupId()
	return self._groupId
end

function Act183GroupEpisodeRecordMO:getActivityId()
	return self._actId
end

function Act183GroupEpisodeRecordMO:getBossEpisodeConditionStatus()
	local allConditionIds = {}
	local unlockConditionIds = {}
	local passConditionIds = {}
	local chooseConditions = {}

	for _, episodeMo in ipairs(self._episodeList) do
		local episodeType = episodeMo:getEpisodeType()

		if episodeType ~= Act183Enum.EpisodeType.Boss then
			local conditionIds = episodeMo:getConditionIds()
			local passIds = episodeMo:getPassConditions()

			tabletool.addValues(allConditionIds, conditionIds)
			tabletool.addValues(unlockConditionIds, passIds)
		else
			passConditionIds = episodeMo:getPassConditions()
			chooseConditions = episodeMo:getChooseConditions()
		end
	end

	return allConditionIds, unlockConditionIds, passConditionIds, chooseConditions
end

return Act183GroupEpisodeRecordMO
