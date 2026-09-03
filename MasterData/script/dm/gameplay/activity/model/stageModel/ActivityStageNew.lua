-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/stageModel/ActivityStageNew.lua

require("dm.gameplay.activity.model.stageModel.ActivityStagePoint")
require("dm.gameplay.activity.model.ActivityColorEgg")

ActivityStageSort = class("ActivityStageSort")

ActivityStageSort:has("_pointList", {
	is = "rw"
})
ActivityStageSort:has("_index", {
	is = "rw"
})
ActivityStageSort:has("_owner", {
	is = "rw"
})
ActivityStageSort:has("_id", {
	is = "rw"
})
ActivityStageSort:has("_pointMap", {
	is = "rw"
})
ActivityStageSort:has("_config", {
	is = "rw"
})
ActivityStageSort:has("_isDailyFirstEnter", {
	is = "rw"
})

function ActivityStageSort:initialize(id)
	self._id = id
	self._config = ConfigReader:getRecordById("ActivityBlockSort", self._id)
	self._isDailyFirstEnter = true
end

function ActivityStageSort:sync(data)
	if not self._pointList then
		self._pointList = {}
		self._pointMap = {}

		local list = self._config.BlockPoint

		for index, id in pairs(list) do
			local point = ActivityStagePoint:new(id, "ActivityBlockBattle")

			point:setIndex(index)
			point:setOwner(self)
			point:sync({})

			self._pointList[#self._pointList + 1] = point
			self._pointMap[id] = point
		end
	end

	if data and data.points then
		for pointId, pointData in pairs(data.points) do
			local point = self._pointMap[pointId]

			if point then
				point:sync(pointData)
			end
		end
	end
end

function ActivityStageSort:getPointById(id)
	return self._pointMap[id]
end

function ActivityStageSort:isPass()
	local point = self._pointList[1]

	return point and point:isPass()
end

function ActivityStageSort:isPerfect()
	local perfect = true

	for i, point in pairs(self._pointList) do
		if not point:isPass() then
			perfect = false
		end
	end

	return perfect
end

function ActivityStageSort:isUnlock()
	if not self._owner:isUnlock() then
		return false
	end

	local prePoints = self._config.OpenPoint
	local preStoryPoints = self._config.PreStoryPoint

	if prePoints[1] then
		local _point = self._owner:getPointById(prePoints[1])

		if _point and not _point:isPass() then
			return false
		end
	end

	if preStoryPoints[1] then
		local _point = self._owner:getStoryPointById(preStoryPoints[1])

		if _point and not _point:isPass() then
			return false
		end
	end

	return true
end

function ActivityStageSort:getName()
	return Strings:get(self._config.Name)
end

function ActivityStageSort:isBoss()
	return self._config.PointType == StagePointType.kBoss
end

function ActivityStageSort:getHiddenStory()
	return self._config.HiddenStory or {}
end

function ActivityStageSort:getFirstReward()
	return self._config.FirstKillReward
end

ActivityStageNew = class("ActivityStageNew")

ActivityStageNew:has("_mapCount", {
	is = "rw"
})
ActivityStageNew:has("_type", {
	is = "rw"
})
ActivityStageNew:has("_mapId", {
	is = "rw"
})
ActivityStageNew:has("_config", {
	is = "rw"
})
ActivityStageNew:has("_owner", {
	is = "rw"
})
ActivityStageNew:has("_index2Points", {
	is = "rw"
})
ActivityStageNew:has("_id2Points", {
	is = "rw"
})

function ActivityStageNew:initialize(id)
	self._mapCount = 0
	self._mapId = id
	self._index2Points = nil
	self._id2Points = nil
end

function ActivityStageNew:sync(data)
	if data.mapId then
		self._mapId = data.mapId
	end

	self._config = ConfigReader:getRecordById("ActivityBlockMap", self._mapId)

	self:syncPointInfo(data.stageMaps)
	self:initStoryPointMap()
	self:initColorEggMap()
end

function ActivityStageNew:hasRedPoint()
	return false
end

function ActivityStageNew:getCurrentStarCount()
	local currentStarCount = 0

	for _, point in pairs(self._index2Points) do
		currentStarCount = currentStarCount + point:getStarCount()
	end

	return currentStarCount
end

function ActivityStageNew:syncPointInfo(data)
	if self._index2Points == nil then
		self._index2Points = {}
		self._id2Points = {}

		local sortIds = self._config.SubSort

		for index = 1, #sortIds do
			local pointId = sortIds[index]
			local point = ActivityStageSort:new(pointId)

			point:setIndex(index)
			point:setOwner(self)

			if not data[pointId] then
				point:sync(data[pointId])

				self._index2Points[index] = point
				self._id2Points[pointId] = point
			end
		end
	else
		for pointId, pointData in pairs(data) do
			local point = self._id2Points[pointId]

			if point then
				point:sync(pointData)
			end
		end
	end
end

function ActivityStageNew:initStoryPointMap()
	if self._index2StoryPoint == nil then
		self._index2StoryPoint = {}
		self._id2StoryPoint = {}

		if not self._config.SubStoryPoint then
			local storyPointIds = {}

			for index = 1, #storyPointIds do
				local storyPointId = storyPointIds[index]
				local storyPoint = StoryPoint:new(storyPointId, "ActivityStoryPoint")

				storyPoint:setIndex(index)
				storyPoint:setOwner(self)

				self._index2StoryPoint[index] = storyPoint
				self._id2StoryPoint[storyPointId] = storyPoint
			end

			if not self._config.SubPoint then
				local subPointIds = {}

				for index = 1, #subPointIds do
					local subPointId = subPointIds[index]
					local config = ConfigReader:getRecordById("ActivityBlockPoint", subPointId)

					if config.HiddenStory then
						for sPointId, v in pairs(config.HiddenStory) do
							local storyPoint = StoryPoint:new(sPointId, "ActivityStoryPoint")

							storyPoint:setIndex(#self._index2StoryPoint + 1)
							storyPoint:setOwner(self)
							storyPoint:setIsHidden(true)

							self._index2StoryPoint[#self._index2StoryPoint + 1] = storyPoint
							self._id2StoryPoint[sPointId] = storyPoint
						end
					end
				end
			end
		end
	end

	self:syncStoryPoint()
end

function ActivityStageNew:hasStoryPointRed()
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()

	for i, story in pairs(self._index2StoryPoint) do
		local value = cc.UserDefault:getInstance():getBoolForKey("activityStageRed" .. story:getId() .. player:getRid())

		if story:isPass() and not value then
			return true
		end
	end

	return false
end

function ActivityStageNew:getStoryPoints()
	return self._index2StoryPoint
end

function ActivityStageNew:syncStoryPoint()
	local storyPointList = self._owner:getStorySet()

	for _, k in pairs(storyPointList) do
		if self._id2StoryPoint[k] ~= nil then
			self._id2StoryPoint[k]:sync({
				isPass = true
			})
		end
	end
end

function ActivityStageNew:getPointById(pointId)
	local point = self._id2Points[pointId]

	if point then
		return point, kStageTypeMap.point
	end

	point = self._id2StoryPoint[pointId]

	if self._id2StoryPoint[pointId] then
		return point, kStageTypeMap.StoryPoint
	end

	return nil
end

function ActivityStageNew:getStoryPointById(pointId)
	return self._id2StoryPoint[pointId]
end

function ActivityStageNew:initColorEggMap()
	if self._colorEggsMap == nil then
		self._colorEggsMap = {}

		local colorEggs = self._config.ColourEgg

		if colorEggs then
			for index = 1, #colorEggs do
				local eggId = colorEggs[index]

				self._colorEggsMap[eggId] = ActivityColorEgg:new(eggId)
			end
		end
	end
end

function ActivityStageNew:isUnlock()
	return true
end

function ActivityStageNew:isPass()
	local lastBattlePoint = self._index2Points[#self._index2Points]

	if self._index2StoryPoint and next(self._index2StoryPoint) then
		local lastStoryPoint = self._index2StoryPoint[#self._index2StoryPoint]

		for i = #self._index2StoryPoint, 0, -1 do
			if not self._index2StoryPoint[i]:getIsHidden() then
				lastStoryPoint = self._index2StoryPoint[i]

				break
			end
		end

		return lastBattlePoint:isPass() and lastStoryPoint:isPass()
	else
		return lastBattlePoint:isPass()
	end
end

function ActivityStageNew:getStartTimestamp()
	local config = ConfigReader:getRecordById("ActivityBlockPoint", self._config.SubPoint[1])
	local timestamp = 0

	if config.PointTime then
		local startTime = config.PointTime.start

		timestamp = TimeUtil:formatStrToRemoteTImestamp(startTime)
	end

	return timestamp
end
