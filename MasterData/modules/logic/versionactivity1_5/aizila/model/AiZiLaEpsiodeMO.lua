-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaEpsiodeMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaEpsiodeMO", package.seeall)

local AiZiLaEpsiodeMO = pureTable("AiZiLaEpsiodeMO")

function AiZiLaEpsiodeMO:init(episodeId, actId)
	self.id = episodeId
	self.episodeId = episodeId
	self.activityId = actId or VersionActivity1_5Enum.ActivityId.AiZiLa
	self.day = 0
	self.eventId = 0
	self.actionPoint = 0
	self.buffIds = {}
	self.option = 0
	self.optionResultId = 0
	self.altitude = 0
	self.round = 0
	self.costActionPoint = 0
	self.enterTimes = 0
	self._passRound = 8

	self:getConfig()
end

function AiZiLaEpsiodeMO:getConfig()
	if not self._config then
		self._config = AiZiLaConfig.instance:getEpisodeCo(self.activityId, self.episodeId)
		self._targetIds = self._config and string.splitToNumber(self._config.showTargets, "|") or {}

		local roundCfg = AiZiLaConfig.instance:getPassRoundCo(self.activityId, self.episodeId)

		if roundCfg then
			self._passRound = roundCfg.round
		end
	end

	return self._config
end

function AiZiLaEpsiodeMO:updateInfo(info)
	if info.actionPoint then
		self.actionPoint = info.actionPoint
	end

	if info.day then
		self.day = info.day
	end

	if info.eventId then
		self.eventId = info.eventId
	end

	if info.buffIds then
		local count = #self.buffIds

		for i = 1, count do
			table.remove(self.buffIds)
		end

		tabletool.addValues(self.buffIds, info.buffIds)
	end

	if info.option then
		self.option = info.option
	end

	if info.optionResultId then
		self.optionResultId = info.optionResultId
	end

	if info.altitude then
		self.altitude = info.altitude
	end

	if info.round then
		self.round = info.round
	end

	if info.costActionPoint then
		self.costActionPoint = info.costActionPoint
	end

	if info.enterTimes then
		self.enterTimes = info.enterTimes
	end
end

function AiZiLaEpsiodeMO:getTargetIds()
	return self._targetIds
end

function AiZiLaEpsiodeMO:isPass()
	if self._passRound < self.round then
		return true
	end

	if self._passRound == self.round and self.eventId ~= 0 and self.option ~= 0 and self.optionResultId ~= 0 then
		return true
	end

	return false
end

function AiZiLaEpsiodeMO:isCanSafe()
	if self.actionPoint < 0 then
		return false
	end

	if self:isPass() then
		return true
	end

	return false
end

function AiZiLaEpsiodeMO:getRoundCfg()
	return AiZiLaConfig.instance:getRoundCo(self.activityId, self.episodeId, self.round)
end

function AiZiLaEpsiodeMO:getCostActionPoint()
	return self.costActionPoint
end

return AiZiLaEpsiodeMO
