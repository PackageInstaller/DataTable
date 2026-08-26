-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaRecordMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordMO", package.seeall)

local AiZiLaRecordMO = pureTable("AiZiLaRecordMO")

function AiZiLaRecordMO:init(recordCfg)
	self.id = recordCfg.recordId
	self.config = recordCfg
	self._groupMOList = {}
	self._actId = recordCfg.activityId
	self._recordId = recordCfg.recordId
	self._eventMOList = {}

	local unLockDesc = string.split(recordCfg.unLockDesc, "|") or {}
	local eventIdGroups = GameUtil.splitString2(recordCfg.eventIds, true) or {}
	local tAiZiLaConfig = AiZiLaConfig.instance

	for i, eventIds in ipairs(eventIdGroups) do
		local groupMO = AiZiLaRecordEventGroupMO.New()

		groupMO:init(i, unLockDesc[i])
		table.insert(self._groupMOList, groupMO)

		for _, eventId in ipairs(eventIds) do
			local eventCfg = tAiZiLaConfig:getEventCo(self._actId, eventId)

			if eventCfg then
				local eventMO = AiZiLaRecordEventMO.New()

				eventMO:init(eventCfg)
				groupMO:addEventMO(eventMO)
				table.insert(self._eventMOList, eventMO)
			else
				logError(string.format("export_事件记录 activity:%s,eventId:%s 找不到", self._actId, eventId))
			end
		end
	end

	local num = #eventIdGroups - #unLockDesc

	if num > 0 then
		logError(string.format("export_事件记录 activity:%s,recordId:%s unLockDesc数量少：%s", self._actId, self._recordId, num))
	end
end

function AiZiLaRecordMO:isUnLock()
	for i, groupMO in ipairs(self._groupMOList) do
		if groupMO:isUnLock() then
			return true
		end
	end

	return false
end

function AiZiLaRecordMO:isHasRed()
	for i, groupMO in ipairs(self._groupMOList) do
		if groupMO:isHasRed() then
			return true
		end
	end

	return false
end

function AiZiLaRecordMO:finishRed()
	for i, groupMO in ipairs(self._groupMOList) do
		groupMO:finishRed()
	end
end

function AiZiLaRecordMO:getRedUid()
	return self.id
end

function AiZiLaRecordMO:getRroupMOList()
	return self._groupMOList
end

function AiZiLaRecordMO:getEventMOList()
	return self._eventMOList
end

return AiZiLaRecordMO
