-- chunkname: @modules/logic/commandstation/model/CommandStationModel.lua

module("modules.logic.commandstation.model.CommandStationModel", package.seeall)

local CommandStationModel = class("CommandStationModel", BaseModel)

function CommandStationModel:onInit()
	self.paper = 0
	self.gainBonus = {}
	self._eventList = {}
	self.catchNum = 0
	self._characterState = {}
end

function CommandStationModel:reInit()
	self:onInit()
end

function CommandStationModel:updateCharacterStateList(list)
	for i, v in ipairs(list) do
		self:updateCharacterState(v)
	end
end

function CommandStationModel:updateCharacterState(id)
	self._characterState[id] = true
end

function CommandStationModel:getCharacterState(id)
	return self._characterState[id]
end

function CommandStationModel:updateEventList(list)
	for i, v in ipairs(list) do
		self:updateEventInfo(v)
	end
end

function CommandStationModel:updateEventInfo(info)
	self._eventList[info.id] = self._eventList[info.id] or CommandPostEventInfoMO.New()

	self._eventList[info.id]:init(info)
end

function CommandStationModel:getDispatchEventInfo(id)
	local config = lua_copost_event.configDict[id]

	if config and config.eventType == CommandStationEnum.EventType.Dispatch then
		local info = self._eventList[id]

		if info and info.hasInit and info.state ~= CommandStationEnum.EventState.NotDispatch then
			return info
		end
	end
end

function CommandStationModel:getDispatchEventState(eventId)
	local eventInfo = self:getDispatchEventInfo(eventId)

	if eventInfo then
		if eventInfo:hasGetReward() then
			return CommandStationEnum.DispatchState.GetReward
		end

		if not eventInfo:isFinished() then
			return CommandStationEnum.DispatchState.InProgress
		end

		return CommandStationEnum.DispatchState.Completed
	end

	return CommandStationEnum.DispatchState.NotStart
end

function CommandStationModel:eventIsActivated(id)
	local list = CommandStationConfig.instance:getUnlockEventList(id)

	if not list then
		return true
	end

	for i, eventId in ipairs(list) do
		if not self:eventIsActivated(eventId) or not self:eventIsFinished(eventId) then
			return false
		end
	end

	return true
end

function CommandStationModel:eventIsFinished(eventId)
	if CommandStationConfig.instance:isReadFinishEvent(eventId) then
		if not self:isEventRead(eventId) then
			return false
		end
	else
		local config = lua_copost_event.configDict[eventId]

		if config then
			if config.eventType == CommandStationEnum.EventType.Dispatch then
				if self:getDispatchEventState(eventId) ~= CommandStationEnum.DispatchState.GetReward then
					return false
				end
			elseif self:getEventState(eventId) ~= CommandStationEnum.EventState.GetReward then
				return false
			end
		end
	end

	return true
end

function CommandStationModel:isEventRead(id)
	local eventInfo = self._eventList[id]

	return eventInfo and eventInfo.read
end

function CommandStationModel:getEventState(id)
	local config = lua_copost_event.configDict[id]

	if config and config.eventType == CommandStationEnum.EventType.Dispatch then
		logError(string.format("getEventState error, id = %d", id))

		return nil
	end

	local eventInfo = self._eventList[id]

	return eventInfo and eventInfo.state
end

function CommandStationModel:setEventFinish(id)
	self._eventList[id] = self._eventList[id] or CommandPostEventInfoMO.New()
	self._eventList[id].state = CommandStationEnum.EventState.GetReward
end

function CommandStationModel:setEventRead(id)
	self._eventList[id] = self._eventList[id] or CommandPostEventInfoMO.New()
	self._eventList[id].read = true
end

function CommandStationModel:getAllEventHeroList()
	local list = {}

	for k, v in pairs(self._eventList) do
		if v.heroIds and not v:hasGetReward() then
			for i, heroId in ipairs(v.heroIds) do
				list[heroId] = heroId
			end
		end
	end

	return list
end

function CommandStationModel:getTimeIdCanRead(timeId)
	self._timeIdCanRead = false

	local targetCharacterId = CommandStationMapModel.instance:getCharacterId()

	if targetCharacterId then
		CommandStationConfig.instance:forEachGetEventList(timeId, nil, CommandStationEnum.EventCategoryKey.Character, self._eventIsRead, self)
	else
		CommandStationConfig.instance:forEachGetEventList(timeId, nil, CommandStationEnum.EventCategoryKey.Normal, self._eventIsRead, self)
		CommandStationConfig.instance:forEachGetEventList(timeId, nil, CommandStationEnum.EventCategoryKey.Character, self._eventIsRead, self)
	end

	return self._timeIdCanRead
end

function CommandStationModel:_eventIsRead(eventId)
	if not self:eventIsActivated(eventId) then
		return
	end

	local targetCharacterId = CommandStationMapModel.instance:getCharacterId()

	if targetCharacterId then
		if CommandStationConfig.instance:eventContainCharacterId(eventId, targetCharacterId) and not self:isEventRead(eventId) then
			self._timeIdCanRead = true
		end
	elseif not self:isEventRead(eventId) then
		self._timeIdCanRead = true
	else
		local config = lua_copost_event.configDict[eventId]

		if config and config.eventType == CommandStationEnum.EventType.Dispatch then
			local state = self:getDispatchEventState(eventId)

			if state ~= CommandStationEnum.DispatchState.GetReward then
				self._timeIdCanRead = true
			end
		end
	end
end

CommandStationModel.instance = CommandStationModel.New()

return CommandStationModel
