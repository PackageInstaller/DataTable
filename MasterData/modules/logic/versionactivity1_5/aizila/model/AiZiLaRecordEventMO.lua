-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaRecordEventMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordEventMO", package.seeall)

local AiZiLaRecordEventMO = pureTable("AiZiLaRecordEventMO")

function AiZiLaRecordEventMO:init(eventCfg)
	self.id = eventCfg.eventId
	self.eventId = eventCfg.eventId
	self.config = eventCfg
	self._actId = eventCfg.activityId

	if eventCfg and not string.nilorempty(eventCfg.optionIds) then
		self._optionIds = string.splitToNumber(eventCfg.optionIds, "|")
	end

	self._optionIds = self._optionIds or {}
	self._redPointKey = AiZiLaHelper.getRedKey(RedDotEnum.DotNode.V1a5AiZiLaRecordEventNew, self.eventId)
end

function AiZiLaRecordEventMO:isFinished()
	local tAiZiLaModel = AiZiLaModel.instance

	if not tAiZiLaModel:isSelectEventId(self.eventId) then
		return false
	end

	for _, optionId in ipairs(self._optionIds) do
		if tAiZiLaModel:isSelectOptionId(optionId) then
			return true
		end
	end

	return false
end

function AiZiLaRecordEventMO:getSelectOptionCfg()
	local tAiZiLaModel = AiZiLaModel.instance
	local tAiZiLaConfig = AiZiLaConfig.instance

	for _, optionId in ipairs(self._optionIds) do
		if tAiZiLaModel:isSelectOptionId(optionId) then
			local optionCfg = tAiZiLaConfig:getOptionCo(self._actId, optionId)

			if optionCfg then
				return optionCfg
			end
		end
	end
end

function AiZiLaRecordEventMO:isHasRed()
	if self:isFinished() and not AiZiLaHelper.isFinishRed(self._redPointKey) then
		return true
	end

	return false
end

function AiZiLaRecordEventMO:finishRed()
	AiZiLaHelper.finishRed(self._redPointKey, true)
end

function AiZiLaRecordEventMO:getRedUid()
	return self.eventId
end

return AiZiLaRecordEventMO
