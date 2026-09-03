-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreType.lua

ExploreType = class("ExploreType", objectlua.Object)

ExploreType:has("_id", {
	is = "r"
})
ExploreType:has("_lock", {
	is = "rw"
})
ExploreType:has("_lockTip", {
	is = "rw"
})
ExploreType:has("_taskMap", {
	is = "rw"
})
ExploreType:has("_rewardMap", {
	is = "rw"
})
ExploreType:has("_dpNum", {
	is = "rw"
})
ExploreType:has("_times", {
	is = "rw"
})
ExploreType:has("_totalTaskDp", {
	is = "rw"
})

function ExploreType:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("MapType", id)
	self._dpNum = 0
	self._times = 0
	self._lock = true
	self._lockTip = ""
	self._taskMap = {}
	self._rewardMap = {}
	self._totalTaskDp = self:getDPNum()

	self:initMapTask()
	self:initMapReward()
end

function ExploreType:initMapTask()
	local tasks = self:getDPTask()

	for i = 1, #tasks do
		self._taskMap[tasks[i]] = ExploreMapTask:new(tasks[i])
	end
end

function ExploreType:initMapReward()
	local rewards = self:getDPTaskReward()

	for i = 1, #rewards do
		local id = rewards[i].count

		self._rewardMap[id] = 0
	end
end

function ExploreType:syncMapTask(data)
	for id, v in pairs(data) do
		if self._taskMap[id] then
			self._taskMap[id]:synchronize(v)
		end
	end
end

function ExploreType:getTaskMapById(id)
	return self._taskMap[id]
end

function ExploreType:syncReward(data)
	for i, v in pairs(data) do
		if self._rewardMap[tostring(v)] then
			self._rewardMap[tostring(v)] = 1
		end
	end
end

function ExploreType:synchronize(data)
	if data.dp then
		self:setDpNum(data.dp)
	end

	if data.dpTasks then
		self:syncMapTask(data.dpTasks)
	end

	if data.gotReward then
		self:syncReward(data.gotReward)
	end
end

function ExploreType:getName()
	return Strings:get(self._config.Name)
end

function ExploreType:getSortNum()
	return self._config.Num
end

function ExploreType:getImg()
	return "asset/ui/explore/exploreStageIcon/" .. self._config.Img .. ".png"
end

function ExploreType:getUnlockCondition()
	return self._config.UnlockCondition
end

function ExploreType:getOpenType()
	return self._config.OpenType
end

function ExploreType:getMapPointId()
	return self._config.MapPointId
end

function ExploreType:getDPTask()
	return self._config.DPTask
end

function ExploreType:getDPTaskReward()
	return self._config.DPTaskReward
end

function ExploreType:getMapCountReset()
	return self._config.MapCountReset
end

function ExploreType:getDPNum()
	return self._config.DPNum
end

function ExploreType:getBGImg()
	return "asset/scene/" .. self._config.BGImg
end

function ExploreType:getSystemTaskIds()
	local ids = {}
	local pointIds = self:getMapPointId()

	for i = 1, #pointIds do
		local config = ConfigReader:requireRecordById("MapPoint", pointIds[i])

		if config then
			local taskIds = config.MapSystemFirstTask

			for j = 1, #taskIds do
				ids[taskIds[j]] = 1
			end
		end
	end

	return ids
end

function ExploreType:getBeforeStoryName()
	return Strings:get(self._config.BeforeStoryName)
end

function ExploreType:getBeforeStory()
	return self._config.BeforeStory
end

function ExploreType:getBeforeStoryPosition()
	return self._config.BeforeStoryPosition
end

function ExploreType:getBGStageAnim()
	return self._config.BGStageAnim
end
