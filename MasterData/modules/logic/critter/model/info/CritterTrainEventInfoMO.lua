-- chunkname: @modules/logic/critter/model/info/CritterTrainEventInfoMO.lua

module("modules.logic.critter.model.info.CritterTrainEventInfoMO", package.seeall)

local CritterTrainEventInfoMO = pureTable("CritterTrainEventInfoMO")
local _TEMP_EMPTY_TB = {}

function CritterTrainEventInfoMO:init(info)
	info = info or _TEMP_EMPTY_TB
	self.eventId = info.eventId or 0
	self.remainCount = info.remainCount or 0
	self.finishCount = info.finishCount or 0
	self.activeTime = info.activeTime or self.activeTime or 0
	self.addAttributes = CritterHelper.getInitClassMOList(info.addAttributes, CritterAttributeMO, self.addAttributes)
	self.options = CritterHelper.getInitClassMOList(info.options, CritterTrainOptionInfoMO, self.options)

	self:_updateDefineCfg()
end

function CritterTrainEventInfoMO:setTrainInfoMO(trainInfoMO)
	self._trainInfoMO = trainInfoMO
end

function CritterTrainEventInfoMO:_updateDefineCfg()
	if self._lastEventId ~= self.eventId then
		self.config = CritterConfig.instance:getCritterTrainEventCfg(self.eventId, self.eventId ~= 0)
		self.conditionNums = self:_splitToNumer(self.config and self.config.condition)
		self.effectAttributeNums = self:_splitToNumer(self.config and self.config.effectAttribute)

		if self.config then
			self.eventType = self.config.type or 0
		end
	end
end

function CritterTrainEventInfoMO:_splitToNumer(str)
	if not string.nilorempty(str) then
		return string.splitToNumber(str, "#")
	end
end

function CritterTrainEventInfoMO:getDefineCfg()
	return self.config
end

function CritterTrainEventInfoMO:getConditionTime()
	if self.conditionNums then
		return self.conditionNums[2] or 0
	end

	return 0
end

function CritterTrainEventInfoMO:getEventType()
	return self.eventType or 0
end

function CritterTrainEventInfoMO:getFinishCount()
	return self.finishCount or 0
end

function CritterTrainEventInfoMO:isHasEventAction()
	if self:isEventFinish() then
		return false
	end

	if self:isEventActive() then
		return true
	end

	return false
end

function CritterTrainEventInfoMO:isEventActive()
	if (self.eventType == CritterEnum.EventType.Special or self.eventType == CritterEnum.EventType.ActiveTime) and (self.remainCount and self.remainCount > 0 or self.finishCount and self.finishCount > 0) then
		return true
	end

	return false
end

function CritterTrainEventInfoMO:getTrainProcessTime()
	if self._trainInfoMO then
		return self._trainInfoMO:getProcessTime()
	end

	return 0
end

function CritterTrainEventInfoMO:isEventFinish()
	if self.remainCount and self.remainCount <= 0 then
		if self.eventType == CritterEnum.EventType.ActiveTime and self.finishCount and self.finishCount <= 0 then
			return false
		end

		return true
	end

	return false
end

function CritterTrainEventInfoMO:getEventInfoOption(optionId)
	for _, option in ipairs(self.options) do
		if option.optionId == optionId then
			return option
		end
	end
end

return CritterTrainEventInfoMO
