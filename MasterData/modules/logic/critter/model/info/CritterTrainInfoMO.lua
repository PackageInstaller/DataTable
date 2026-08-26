-- chunkname: @modules/logic/critter/model/info/CritterTrainInfoMO.lua

module("modules.logic.critter.model.info.CritterTrainInfoMO", package.seeall)

local CritterTrainInfoMO = pureTable("CritterTrainInfoMO")
local _TEMP_EMPTY_TB = {}

function CritterTrainInfoMO:init(info)
	info = info or _TEMP_EMPTY_TB
	self.heroId = info.heroId or 0
	self.startTime = info.startTime or 0
	self.endTime = info.endTime or 0
	self.fastForwardTime = info.fastForwardTime or 0
	self.trainTime = info.trainTime or self.trainTime or 0
	self.events = CritterHelper.getInitClassMOList(info.events, CritterTrainEventInfoMO, self.events)
	self.eventTimePoints = self.eventTimePoints or {}

	self:updateEventActiveTime()
end

function CritterTrainInfoMO:updateEventActiveTime()
	local activeTime = 0
	local count = 0

	for i, eventMO in ipairs(self.events) do
		if eventMO:getEventType() == CritterEnum.EventType.ActiveTime then
			count = count + 1
			self.eventTimePoints[count] = activeTime
			activeTime = activeTime + eventMO:getConditionTime()
		end

		eventMO:setTrainInfoMO(self)
	end

	if count < #self.eventTimePoints then
		while count < #self.eventTimePoints do
			table.remove(self.eventTimePoints, #self.eventTimePoints)
		end
	end
end

function CritterTrainInfoMO:setCritterMO(critterMO)
	self._critterMO = critterMO
end

function CritterTrainInfoMO:isTraining()
	if self.heroId and self.heroId ~= 0 then
		return self.startTime + self.fastForwardTime < self.endTime
	end

	return false
end

function CritterTrainInfoMO:isTrainFinish()
	if self.heroId and self.heroId ~= 0 then
		return self:getCurCdTime() <= 0
	end

	return false
end

function CritterTrainInfoMO:isCultivating()
	if self.trainInfo.heroId and self.trainInfo.heroId ~= 0 and (self:getCurCdTime() > 0 or self._critterMO.finishTrain ~= true) then
		return true
	end

	return false
end

function CritterTrainInfoMO:isHasEventTrigger()
	for i = 1, #self.events do
		local eventMO = self.events[i]

		if CritterEnum.NeedActionEventTypeDict[eventMO:getEventType()] and eventMO:isHasEventAction() then
			return true
		end
	end

	return false
end

function CritterTrainInfoMO:checkRoundFinish(round, eventType)
	for i = 1, #self.events do
		local eventMO = self.events[i]

		if (eventType == nil or eventMO:getEventType() == eventType) and round > eventMO:getFinishCount() then
			return false
		end
	end

	return true
end

function CritterTrainInfoMO:getTotalTime()
	return self.endTime - self.startTime
end

function CritterTrainInfoMO:getProcessTime()
	local curTime = ServerTime.now()
	local processTime = curTime - self.startTime + self.fastForwardTime

	if processTime > self.trainTime then
		return self.trainTime
	end

	return processTime
end

function CritterTrainInfoMO:getCurCdTime()
	local cdTime = self.trainTime - self:getProcessTime()

	if cdTime < 0 then
		return 0
	end

	return cdTime
end

function CritterTrainInfoMO:getProcess()
	if self.endTime ~= 0 then
		local processTime = self:getProcessTime()
		local total = self.trainTime

		if total > 0 and processTime > 0 then
			return processTime / total
		end
	end

	return 0
end

function CritterTrainInfoMO:isFinishAllEvent()
	for i, event in ipairs(self.events) do
		if CritterEnum.NeedActionEventTypeDict[event:getEventType()] and not event:isEventFinish() then
			return false
		end
	end

	return true
end

function CritterTrainInfoMO:selectFinishEvent(eventId)
	for i, event in ipairs(self.events) do
		if event.eventId == eventId then
			event.remainCount = event.remainCount - 1
			event.finishCount = event.finishCount + 1
		end
	end
end

function CritterTrainInfoMO:getEvents(eventId)
	for _, event in ipairs(self.events) do
		if event.eventId == eventId then
			return event
		end
	end
end

function CritterTrainInfoMO:getEventOptions(eventId)
	for _, event in ipairs(self.events) do
		if event.eventId == eventId then
			return event.options
		end
	end
end

function CritterTrainInfoMO:getEventOptionMOByOptionId(eventId, optionId)
	for _, event in ipairs(self.events) do
		if event.eventId == eventId then
			return event:getEventInfoOption(optionId)
		end
	end
end

function CritterTrainInfoMO:getAddAttributeValue(attributeId)
	local value = 0

	for _, event in ipairs(self.events) do
		for _, att in ipairs(event.addAttributes) do
			if att.attributeId == attributeId then
				value = value + att.value
			end
		end
	end

	return value
end

return CritterTrainInfoMO
