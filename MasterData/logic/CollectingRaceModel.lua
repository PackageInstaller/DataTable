-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/model/CollectingRaceModel.lua

module("logic.extensions.collectingrace.model.CollectingRaceModel", package.seeall)

local CollectingRaceModel = class("CollectingRaceModel", BaseModel)

function CollectingRaceModel:ctor()
	return
end

function CollectingRaceModel:onInit()
	self:onReset()
end

function CollectingRaceModel:onReset()
	self._activityMap = {}
	self._cacheActivityId = nil
	self._cacheCollectingRaceKRedPointData = {}

	GameUtil.whenLocalDataInited(function()
		self:_initRedPoint()
	end)
end

local CollectingRaceKey = "CollectingRaceRaceKey"

function CollectingRaceModel:_initRedPoint()
	self._cacheCollectingRaceKRedPointData = GameUtil.getUserData(CollectingRaceKey) or {}

	self:_updateFightRed()
end

function CollectingRaceModel:_updateFightRed()
	local redStates = {}
	local dataList = CollectingRaceConfig.instance:getRaceArrayDataList()

	for _, data in ipairs(dataList) do
		local skinId = data.skinId

		if redStates[data.clientRedId] == nil then
			redStates[data.clientRedId] = false
		end

		local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.COLLECTING_RACE, data.activityId)

		if isInTime and self:isFightRed(skinId) then
			redStates[data.clientRedId] = true
		end
	end

	for redId, state in pairs(redStates) do
		if checknumber(redId) ~= 0 then
			RedPointController.instance:setRedPointInfo(redId, state)
		end
	end
end

function CollectingRaceModel:isFightRed(skinId)
	return self._cacheCollectingRaceKRedPointData[tostring(skinId)] ~= true
end

function CollectingRaceModel:saveFightRed(skinId)
	self._cacheCollectingRaceKRedPointData[tostring(skinId)] = true

	self:_updateFightRed()
	GameUtil.saveUserData(CollectingRaceKey, self._cacheCollectingRaceKRedPointData)
end

function CollectingRaceModel:isPrizeRed(data)
	return ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.COLLECTING_RACE, data.activityId) and PetskinController.instance:checkHasForeverSkinBySkinId(data.skinId) and not self:isGainPrize(data.activityId)
end

function CollectingRaceModel:handleInfoRes(msg)
	local activities = msg.activities

	self._activityMap = {}

	for i = 1, #activities do
		local actInfo = activities[i]

		self._activityMap[actInfo.activityId] = actInfo.hasGainPrize
	end
end

function CollectingRaceModel:beforeGainPrize(activityId)
	self._cacheActivityId = activityId
end

function CollectingRaceModel:handleGainPrizeRes(msg)
	if self._cacheActivityId and self._cacheActivityId > 0 then
		self._activityMap[self._cacheActivityId] = true
	end

	self._cacheActivityId = nil
end

function CollectingRaceModel:isGainPrize(activityId)
	return self._activityMap[activityId]
end

CollectingRaceModel.instance = CollectingRaceModel.New()

return CollectingRaceModel
