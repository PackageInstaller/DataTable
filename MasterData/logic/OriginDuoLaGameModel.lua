-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/model/OriginDuoLaGameModel.lua

module("logic.extensions.originduolagame.model.OriginDuoLaGameModel", package.seeall)

local OriginDuoLaGameModel = class("OriginDuoLaGameModel", BaseModel)

function OriginDuoLaGameModel:onInit()
	self:onReset()
end

function OriginDuoLaGameModel:onReset()
	self._infoMap = {}
end

function OriginDuoLaGameModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infoMap[data.activityId] = data
end

function OriginDuoLaGameModel:onStartGame(msg)
	return
end

function OriginDuoLaGameModel:onEndGame(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId

	if not self._infoMap[activityId] then
		self._infoMap[activityId].todayPassTimes = data.todayPassTimes
		self._infoMap[activityId].maxPassStageId = data.maxPassStageId
		self._infoMap[activityId] = self._infoMap[activityId]
	end
end

function OriginDuoLaGameModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function OriginDuoLaGameModel:getTodayPassTimes(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.todayPassTimes or 0
	end

	return 0
end

function OriginDuoLaGameModel:getMaxPassStageId(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.maxPassStageId or 0
	end

	return 0
end

OriginDuoLaGameModel.instance = OriginDuoLaGameModel.New()

return OriginDuoLaGameModel
