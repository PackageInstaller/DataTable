-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaRecordEventGroupMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaRecordEventGroupMO", package.seeall)

local AiZiLaRecordEventGroupMO = pureTable("AiZiLaRecordEventGroupMO")

function AiZiLaRecordEventGroupMO:init(id, lockDesc)
	self.id = id
	self.lockDesc = lockDesc or ""
	self._eventMOList = {}
end

function AiZiLaRecordEventGroupMO:addEventMO(eventMO)
	table.insert(self._eventMOList, eventMO)
end

function AiZiLaRecordEventGroupMO:isUnLock()
	local eventMO = self:getFinishedEventMO()

	if eventMO then
		return true
	end

	return false
end

function AiZiLaRecordEventGroupMO:getFinishedEventMO()
	for i, eventMO in ipairs(self._eventMOList) do
		if eventMO:isFinished() then
			return eventMO
		end
	end
end

function AiZiLaRecordEventGroupMO:isHasRed()
	for i, eventMO in ipairs(self._eventMOList) do
		if eventMO:isHasRed() then
			return true
		end
	end

	return false
end

function AiZiLaRecordEventGroupMO:finishRed()
	for i, eventMO in ipairs(self._eventMOList) do
		if eventMO:isFinished() then
			eventMO:finishRed()
		end
	end
end

function AiZiLaRecordEventGroupMO:getRedUid()
	local eventMO = self:getFinishedEventMO() or self._eventMOList[1]

	return eventMO and eventMO:getRedUid() or self.id
end

return AiZiLaRecordEventGroupMO
