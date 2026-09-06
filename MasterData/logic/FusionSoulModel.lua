-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/model/FusionSoulModel.lua

module("logic.extensions.fusionsoul.model.FusionSoulModel", package.seeall)

local FusionSoulModel = class("FusionSoulModel", BaseModel)

FusionSoulModel.ReadFlag = "FusionSoulModel.ReadFlag"

function FusionSoulModel:ctor()
	return
end

function FusionSoulModel:onInit()
	self:onReset()
end

function FusionSoulModel:onReset()
	self._fmtMo = nil
	self._info = {}
	self._clueMap = {}
	self._zoneInfo = {}
	self._gainPrize = {}
end

function FusionSoulModel:getFmtMo()
	self._fmtMo = self._fmtMo or FusionSoulFmtMo.New()

	return self._fmtMo
end

function FusionSoulModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data

	local clueMap = {}

	if data.gainClueIds then
		for i, v in ipairs(data.gainClueIds) do
			clueMap[v] = true
		end
	end

	self._clueMap[data.activityId] = clueMap

	local zoneInfoMap = {}

	if data.zoneInfo then
		for i, v in ipairs(data.zoneInfo) do
			zoneInfoMap[v.zoneId] = v
		end
	end

	self._zoneInfo[data.activityId] = zoneInfoMap

	local gainPrize = {}

	if data.gainPrizeIds then
		for i, v in ipairs(data.gainPrizeIds) do
			gainPrize[v] = true
		end
	end

	self._gainPrize[data.activityId] = gainPrize
end

function FusionSoulModel:getTotalClueCount(activityId)
	local totalCount = 0

	if self._clueMap[activityId] then
		for k, v in pairs(self._clueMap[activityId]) do
			totalCount = totalCount + 1
		end
	end

	return totalCount
end

function FusionSoulModel:isGainClue(activityId, clueId)
	if self._clueMap[activityId] then
		return self._clueMap[activityId][clueId] or false
	end

	return false
end

function FusionSoulModel:getZoneInfo(activityId, zoneId)
	if self._zoneInfo[activityId] then
		return self._zoneInfo[activityId][zoneId]
	end

	return nil
end

function FusionSoulModel:saveStartDispatch(msg)
	if self._zoneInfo[msg.eventKey.activityId] and self._zoneInfo[msg.eventKey.activityId][msg.eventKey.zoneId] then
		self._zoneInfo[msg.eventKey.activityId][msg.eventKey.zoneId].finishDispatchTimeMillis = msg.finishTimeMillis
	end
end

function FusionSoulModel:saveFinishEvent(msg)
	if self._zoneInfo[msg.eventKey.activityId] and self._zoneInfo[msg.eventKey.activityId][msg.eventKey.zoneId] then
		self._zoneInfo[msg.eventKey.activityId][msg.eventKey.zoneId].finishDispatchTimeMillis = nil
		self._zoneInfo[msg.eventKey.activityId][msg.eventKey.zoneId].eventId = msg.eventKey.eventId + 1
		self._zoneInfo[msg.eventKey.activityId][msg.eventKey.zoneId].selectAnswer = {}
	end
end

function FusionSoulModel:saveGainClue(msg)
	if self._clueMap[msg.activityId] then
		for i, v in ipairs(msg.clueId) do
			self._clueMap[msg.activityId][v] = true
		end
	end
end

function FusionSoulModel:saveAnswerInfo(msg)
	local eventInfo = msg.eventKey

	if self._zoneInfo[eventInfo.activityId] and self._zoneInfo[eventInfo.activityId][eventInfo.zoneId] then
		if not self._zoneInfo[eventInfo.activityId][eventInfo.zoneId].selectAnswer then
			self._zoneInfo[eventInfo.activityId][eventInfo.zoneId].selectAnswer = self._zoneInfo[eventInfo.activityId][eventInfo.zoneId].selectAnswer

			table.insert(self._zoneInfo[eventInfo.activityId][eventInfo.zoneId].selectAnswer, msg.answerId)
		end
	end
end

function FusionSoulModel:savePrizeInfo(msg)
	if self._gainPrize[msg.activityId] then
		self._gainPrize[msg.activityId][msg.prizeId] = true
	end
end

function FusionSoulModel:isGainPrize(activityId, prizeId)
	if self._gainPrize[activityId] then
		return self._gainPrize[activityId][prizeId]
	end
end

function FusionSoulModel:getNewEvent(activityId, zoneId)
	local key = string.format("%s#NewEvent#%d#%d", FusionSoulModel.ReadFlag, activityId, zoneId)

	return GameUtil.getUserData(key)
end

function FusionSoulModel:saveNewEvent(activityId, zoneId, eventId)
	local key = string.format("%s#NewEvent#%d#%d", FusionSoulModel.ReadFlag, activityId, zoneId)

	GameUtil.saveUserData(key, eventId)
end

FusionSoulModel.instance = FusionSoulModel.New()

return FusionSoulModel
