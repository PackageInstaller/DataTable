-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/AthenaGoActivity.lua

AthenaGoActivity = class("AthenaGoActivity", BaseActivity, _M)

AthenaGoActivity:has("_lastTime", {
	is = "r"
})
AthenaGoActivity:has("_cycleNum", {
	is = "r"
})
AthenaGoActivity:has("_map", {
	is = "r"
})
AthenaGoActivity:has("_treasureBox", {
	is = "r"
})
AthenaGoActivity:has("_curlCount", {
	is = "r"
})
AthenaGoActivity:has("_curlPos", {
	is = "r"
})
AthenaGoActivity:has("_rewardInfo", {
	is = "r"
})
AthenaGoActivity:has("_point", {
	is = "r"
})
AthenaGoActivity:has("_trigger", {
	is = "r"
})

function AthenaGoActivity:initialize(id)
	super.initialize(self, id)

	self._lastTime = 0
	self._cycleNum = 0
	self._curlCount = 0
	self._map = {}
	self._rewardInfo = {}
end

function AthenaGoActivity:dispose()
	super.dispose(self)
end

function AthenaGoActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.gameTimes then
		self._lastTime = data.gameTimes
	end

	if data.cycleNum then
		self._cycleNum = data.cycleNum
	end

	if data.chessBoardInfo then
		self._map = self._map or {}

		for k, v in pairs(data.chessBoardInfo) do
			self._map[k] = v
		end
	end

	if data.treasureBox then
		self._treasureBox = data.treasureBox
	end

	if data.buyGameTimes then
		self._curlCount = data.buyGameTimes
	end

	if data.playerIndex then
		self._curlPos = data.playerIndex
	end

	if data.getRewardInfo then
		self._rewardInfo = data.getRewardInfo
	end

	if data.point then
		self._point = data.point
	end

	if data.activityId then
		local stageMapId = self:getActivityConfig().stageMap

		self._actConfig = ConfigReader:getRecordById("TrialRoadMap", stageMapId)
	end

	self._trigger = data.trigger
end

function AthenaGoActivity:getSwitch()
	return GameConfigs.IsCloseAthenaGo
end

function AthenaGoActivity:getLastTime()
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

	return (developSystem:getBagSystem():getItemCount(self:getActivityConfig().PowerItem))
end

function AthenaGoActivity:getCycleNum()
	return self._cycleNum
end

function AthenaGoActivity:getRewardData()
	return self._rewardInfo
end

function AthenaGoActivity:hasRedPoint()
	if self:getLastTime() > 0 then
		return true
	end

	local boxState = self:getTreasureBox()

	for i = 1, #boxState do
		local data = boxState[i]

		if data.value == 1 then
			return true
		end
	end

	return false
end

function AthenaGoActivity:getBackGroundMusic()
	return self:getActivityConfig().bgm
end

function AthenaGoActivity:getResourcesBanner()
	return self:getActivityConfig().ResourcesBanner or {}
end

function AthenaGoActivity:getIsTodayOpen()
	local trialRoad_Unlock = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "TrialRoad_Unlock", "content")
	local roadwayOpenActId = trialRoad_Unlock.Activity
	local roadwayOpenMapId = trialRoad_Unlock.ActivityBlockMap
	local roadwayOpenPoiId = trialRoad_Unlock.ActivityStoryPoint
	local activity = self._activitySystem:getActivityById(roadwayOpenActId)

	if activity then
		local model = activity:getBlockMapActivity(roadwayOpenMapId)

		if model then
			local pointInfo, pointType = model:getPointById(roadwayOpenPoiId)
			local map = model:getActivityMapById(roadwayOpenMapId)

			if pointType == kStageTypeMap.StoryPoint and pointInfo then
				print("cdskcdnskcndskcndkscndkscndks---->>>>>>>", self._isTodayOpen and pointInfo:isPass())

				return self._isTodayOpen and pointInfo:isPass()
			end
		end
	end

	return false
end

function AthenaGoActivity:getUIType()
	return self:getActivityConfig().UI
end

function AthenaGoActivity:getRule()
	return self._actConfig.MapRule
end

function AthenaGoActivity:getBoxRewardData()
	return {
		BoxReward = self._actConfig.BoxReward,
		showReward = self._actConfig.BoxShowReward
	}
end

function AthenaGoActivity:getTotalCycleNum()
	return self._actConfig.CycleNum
end

function AthenaGoActivity:getCost()
	local needcount = ConfigReader:getRecordById("ConfigValue", "AG_extra").content
	local needType = ConfigReader:getRecordById("ConfigValue", "AG_consume").content

	return {
		type = needType,
		count = needcount[self._curlCount + 1]
	}
end

function AthenaGoActivity:getCountLastTime()
	local needcount = ConfigReader:getRecordById("ConfigValue", "AG_extra").content

	return #needcount, 10 - self._curlCount
end
