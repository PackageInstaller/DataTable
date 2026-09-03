-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/StageMap.lua

require("dm.gameplay.stage.model.StoryPoint")
require("dm.gameplay.stage.model.PracticePoint")

StageMap = class("StageMap")

StageMap:has("_id", {
	is = "r"
})
StageMap:has("_index", {
	is = "rw"
})
StageMap:has("_pointCount", {
	is = "rw"
})
StageMap:has("_owner", {
	is = "rw"
})
StageMap:has("_config", {
	is = "rw"
})
StageMap:has("_continueDiamondTime", {
	is = "rw"
})

function StageMap:initialize(mapId)
	assert(mapId ~= nil, "error:mapId=nil")
	super.initialize(self)

	self._id = mapId
	self._config = ConfigReader:getRecordById(self:getConfigName(), mapId)
	self._index2Points = nil
	self._id2Points = nil

	self:initMapBoxData()

	self._continueDiamondTime = 0
end

function StageMap:dispose()
	super.dispose(self)
end

function StageMap:getConfigName()
	return "BlockMap"
end

function StageMap:getPassPointCount()
	local count = 0

	for k, v in pairs(self._index2Points) do
		if v:isPass() then
			count = count + 1
		end
	end

	return count
end

function StageMap:_getConfig()
	return self._config
end

function StageMap:getPlayer()
	return self:getOwner():getPlayer()
end

function StageMap:getType()
	return self._config.Type
end

function StageMap:getPointByIndex(pointIndex)
	if pointIndex and self._index2Points then
		return self._index2Points[pointIndex]
	end
end

function StageMap:getPointById(pointId)
	if pointId and self._id2Points then
		return self._id2Points[pointId]
	end
end

function StageMap:getStoryPointById(pointId)
	if pointId and self._id2StoryPoint then
		return self._id2StoryPoint[pointId]
	end
end

function StageMap:getPracticePointById(pointId)
	if pointId and self._id2PracticePoint then
		return self._id2PracticePoint[pointId]
	end
end

function StageMap:isPass()
	local points = self._index2Points
	local finalPoint = points[#points]

	return finalPoint:isPass()
end

function StageMap:isBattlePointPass()
	return self:isPass()
end

function StageMap:isUnlock()
	if not self._owner:isUnlock() then
		return false
	end

	if self._index > 1 then
		local lastMapIndex = self._index - 1
		local lastMap = self._owner:getMapByIndex(lastMapIndex)

		if not lastMap:isPass() then
			return false, Strings:get("Lock1")
		end
	end

	local openStar = self:getOpenStar()
	local curStar = self._owner._owner:getAllStageStar()

	if curStar < openStar then
		if self:getType() == StageType.kNormal then
			return false, Strings:get("Stage_Star_UnReach_Elite", {
				num = openStar
			})
		elseif self:getType() == StageType.kElite then
			return false, Strings:get("Stage_Star_UnReach_Common", {
				num = openStar
			})
		else
			return false
		end
	end

	local openLevel = self:getOpenLevel()
	local level = self:getPlayer():getLevel()

	if level < openLevel then
		return false, Strings:get("Lock3", {
			Level = openLevel
		})
	end

	return true
end

function StageMap:getName()
	return Strings:get(self._config.MapName)
end

function StageMap:getDesc()
	return Strings:get(self._config.MapDesc)
end

function StageMap:getIndexDesc()
	return Strings:get("STAGE_CHAPTER_INDEX", {
		index = GameStyle:intNumToCnString(self:getIndex())
	})
end

function StageMap:getOpenLevel()
	return self._config.OpenLevel
end

function StageMap:getOpenStar()
	return self._config.OpenStar
end

function StageMap:getBossPoint()
	local points = self._index2Points
	local finalPoint = points[#points]

	if finalPoint:isBoss() then
		return finalPoint
	end
end

function StageMap:getMapBoxData()
	return self._mapBoxData
end

function StageMap:setMapBoxReceived(stars)
	local mapBoxData = self._mapBoxData

	if not mapBoxData then
		return
	end

	for _, boxData in pairs(mapBoxData) do
		if boxData.stars == stars then
			boxData.boxState = StageBoxState.kHasReceived

			return
		end
	end
end

function StageMap:getMapBoxState(stars)
	local mapBoxData = self._mapBoxData

	if not mapBoxData then
		return
	end

	for _, boxData in pairs(mapBoxData) do
		if boxData.stars == stars then
			return boxData.boxState
		end
	end
end

function StageMap:initMapBoxData()
	local mapBoxConfig = self._config.StarBoxReward

	if mapBoxConfig and mapBoxConfig ~= "" then
		self._mapBoxData = {}

		for key, value in pairs(mapBoxConfig) do
			local stars = tonumber(key)
			local rewardId = value

			self._mapBoxData[#self._mapBoxData + 1] = {
				stars = stars,
				rewardId = rewardId
			}
		end

		table.sort(self._mapBoxData, function(a, b)
			return a.stars < b.stars
		end)
	end
end

function StageMap:initStoryPointMap()
	if self._index2StoryPoint == nil then
		self._index2StoryPoint = {}
		self._id2StoryPoint = {}

		local storyPointIds = self._config.SubStoryPoint

		for index = 1, #storyPointIds do
			local storyPointId = storyPointIds[index]
			local storyPoint = StoryPoint:new(storyPointId)

			storyPoint:setIndex(index)
			storyPoint:setOwner(self)

			self._index2StoryPoint[index] = storyPoint
			self._id2StoryPoint[storyPointId] = storyPoint
		end
	end

	self:syncStoryPoint()
end

function StageMap:syncStoryPoint()
	local player = self:getPlayer()
	local storyPointList = player:getStoryPointList()

	for k, _ in pairs(storyPointList) do
		if self._id2StoryPoint[k] ~= nil then
			self._id2StoryPoint[k]:sync({
				isPass = true
			})
		end
	end
end

function StageMap:initPracticePointMap()
	local subPracticePoints = self:getSubPracticePoint()

	self._id2PracticePoint = {}

	for index = 1, #subPracticePoints do
		local _id = subPracticePoints[index]
		local practicePoint = PracticePoint:new(_id)

		practicePoint:setOwner(self)
		practicePoint:sync()

		self._id2PracticePoint[_id] = practicePoint
	end
end

function StageMap:getCurrentStarCount()
	local currentStarCount = 0

	for _, point in pairs(self._index2Points) do
		currentStarCount = currentStarCount + point:getStarCount()
	end

	return currentStarCount
end

function StageMap:getTotalStarCount()
	local totalStarCount = 0

	for _, point in pairs(self._index2Points) do
		totalStarCount = totalStarCount + point:getTotalStarCount()
	end

	return totalStarCount
end

function StageMap:sync(mapData)
	assert(false, "override")
end

function StageMap:getStageTaskImg()
	return self._config.StageTaskImg
end

function StageMap:getTask()
	return self._config.Task
end

function StageMap:getSubPracticePoint()
	return self._config.SubPracticePoint
end

function StageMap:getStageTaskDesc()
	return self._config.StageTaskDesc
end

function StageMap:getMapReward()
	return self._config.MapReward
end

function StageMap:getURL()
	return self._config.URL
end

function StageMap:getContinueDiamonds()
	return self._config.ContinueDiamonds
end

function StageMap:getUnlockBubble()
	return self._config.UnlockBubble
end

function StageMap:getIconDesc()
	return self._config.IconDesc
end

function StageMap:getStageEventPoint()
	return self._config.StageEventPoint
end
