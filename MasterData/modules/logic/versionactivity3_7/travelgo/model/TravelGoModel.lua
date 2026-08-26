-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/TravelGoModel.lua

module("modules.logic.versionactivity3_7.travelgo.model.TravelGoModel", package.seeall)

local TravelGoModel = class("TravelGoModel", BaseModel)

function TravelGoModel:onInit()
	self.activityId = 13710
end

function TravelGoModel:reInit()
	return
end

function TravelGoModel:clear()
	TravelGoModel.super.clear(self)
end

function TravelGoModel:onGameStart(gameId)
	self.isWin = nil
	self.gameId = gameId
	self.day = 0
	self.exp = 0
	self.level = 1
	self.recordLevel = 1
	self.levelUpNeed = tonumber(lua_activity220_mle_const.configDict[self.activityId][1].value)
	self.EventMO = {
		[TravelGoEnum.EventType.Story] = TravelGoStoryEventMO,
		[TravelGoEnum.EventType.Battle] = TravelGoBattleEventMO,
		[TravelGoEnum.EventType.Luck] = TravelGoLuckEventMO
	}
end

function TravelGoModel:nextDay()
	self.day = self.day + 1
	self.dayCfg = TravelGoConfig.instance:getDayCfg(self.gameId, self.day)
	self.maxDay = TravelGoConfig.instance:getMaxDay(self.gameId)
end

function TravelGoModel:randomDayEvent()
	local dayEventId
	local eventType = self.dayCfg.eventType
	local eventParam = self.dayCfg.eventParam

	if eventType == 1 then
		local infos = GameUtil.splitString2(eventParam, true, "|", "#")
		local weights = {}

		for i, v in ipairs(infos) do
			local weight = v[2]

			table.insert(weights, weight)
		end

		local index = TravelGoController.instance:randomByWeight(weights)

		dayEventId = infos[index][1]
	elseif eventType == 0 then
		local infos = GameUtil.splitString2(eventParam, true, "|", "#")
		local weights = {}

		for i, v in ipairs(infos) do
			local weight = v[2]

			table.insert(weights, weight)
		end

		local index = TravelGoController.instance:randomByWeight(weights)
		local dayEventType = infos[index][1]
		local cfgs = TravelGoConfig.instance:getEventCfgByType(self.gameId, dayEventType)
		local weights2 = {}

		for i, cfg in ipairs(cfgs) do
			local weight = cfg.weight

			table.insert(weights2, weight)
		end

		local index2 = TravelGoController.instance:randomByWeight(weights2)

		dayEventId = cfgs[index2].eventId
	else
		logError("小瑞安依 未支持触发类型")
	end

	self:createDayEvent(dayEventId)
end

function TravelGoModel:createDayEvent(dayEventId)
	if dayEventId then
		local cfg = TravelGoConfig.instance:getEventCfgByEventId(self.gameId, dayEventId)
		local t = cfg.type
		local Class = self.EventMO[t]

		self.travelGoEventMO = Class.New()

		self.travelGoEventMO:setData(self.day, dayEventId)
		logNormal(string.format("小瑞安依 生成事件 id:%s", self.travelGoEventMO.eventId))

		return self.travelGoEventMO
	end
end

function TravelGoModel:addExp(exp)
	self.exp = self.exp + exp

	local oldLevel = self.level

	self.level = math.floor(self.exp / self.levelUpNeed) + 1

	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnExpChange)

	if oldLevel ~= self.level then
		TravelGoController.instance:dispatchEvent(TravelGoEvent.OnLevelChange)
	end
end

function TravelGoModel:recordLevelUpCheck()
	self.recordLevel = self.level
end

function TravelGoModel:setSettle(isWin)
	self.isWin = isWin
end

TravelGoModel.instance = TravelGoModel.New()

return TravelGoModel
