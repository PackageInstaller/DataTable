-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/model/StagePracticeMap.lua

StagePracticeMap = class("StagePracticeMap", objectlua.Object, _M)

StagePracticeMap:has("_pointList", {
	is = "r"
})
StagePracticeMap:has("_pointArray", {
	is = "r"
})
StagePracticeMap:has("_id", {
	is = "r"
})
StagePracticeMap:has("_config", {
	is = "r"
})
StagePracticeMap:has("_lockState", {
	is = "r"
})
StagePracticeMap:has("_fullStarReward", {
	is = "r"
})

StagePracticeLockState = {
	kLock = 1,
	kUnLock = 2
}
SPracticeRewardState = {
	kHasGet = 2,
	kNotCanGet = 0,
	kCanGet = 1
}

function StagePracticeMap:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("StagePracticeMap", tostring(id))
	self._lockState = StagePracticeLockState.kLock
	self._fullStarReward = SPracticeRewardState.kNotCanGet

	self:initPoints()
end

function StagePracticeMap:initPoints()
	self._pointList = {}
	self._pointArray = {}

	local config = self:getSubPoint()

	for i = 1, #config do
		local id = config[i]
		local point = StagePracticePoint:new(id, self:getId())

		self._pointArray[i] = point
		self._pointList[id] = point
	end
end

function StagePracticeMap:sync(data)
	if data.stagePoints then
		self:syncPoints(data.stagePoints)
	end

	if data.teams then
		self:syncTeams(data.teams)
	end

	if data.fullStarReward then
		self._fullStarReward = data.fullStarReward
	end

	self._lockState = StagePracticeLockState.kUnLock
end

function StagePracticeMap:isAllPointPass()
	for i = 1, #self._pointArray do
		local data = self._pointArray[i]

		if data:getPassed() ~= 1 then
			return false
		end
	end

	return true
end

function StagePracticeMap:syncPoints(data)
	for pointId, pointData in pairs(data) do
		if self._pointList[pointId] then
			self._pointList[pointId]:sync(pointData)
		end
	end
end

function StagePracticeMap:syncTeams(data)
	for pointId, teamData in pairs(data) do
		if self._pointList[pointId] then
			self._pointList[pointId]:sync({
				teams = teamData
			})
		end
	end
end

function StagePracticeMap:isLock()
	return self._lockState == StagePracticeLockState.kLock
end

function StagePracticeMap:getStar()
	local num = 0

	for id, point in pairs(self._pointList) do
		num = num + point:getStar()
	end

	return num
end

function StagePracticeMap:getAllStar()
	local num = 0

	for id, point in pairs(self._pointList) do
		num = num + #point:getStarCondition()
	end

	return num
end

function StagePracticeMap:hasRedPoint()
	if self:hasPointRedPoint() then
		return true
	end

	return false
end

function StagePracticeMap:hasPointRedPoint()
	for id, point in pairs(self._pointList) do
		if point:getFirstPassState() == SPracticeRewardState.kCanGet then
			return true
		end
	end

	return false
end

function StagePracticeMap:getPointById(id)
	return self._pointList[id]
end

function StagePracticeMap:getPointByIndex(index)
	return self._pointArray[index]
end

function StagePracticeMap:getName()
	return Strings:get(self._config.MapName)
end

function StagePracticeMap:getMapPicture()
	return self._config.MapPicture
end

function StagePracticeMap:getType()
	return self._config.Type
end

function StagePracticeMap:getIcon()
	return self._config.Icon
end

function StagePracticeMap:getShowCondition()
	return self._config.UnlockCondition
end

function StagePracticeMap:getUnLockTips()
	return self._config.Tip
end

function StagePracticeMap:getPreMap()
	return self._config.PreMap
end

function StagePracticeMap:getPreMapPass()
	for k, v in pairs(self._pointList) do
		if v._fullStarReward == 0 then
			return false
		end
	end

	return true
end

function StagePracticeMap:getPreMapName()
	local namekey = ConfigReader:getDataByNameIdAndKey("StagePracticeMap", self._config.PreMap, "MapName")

	return Strings:get(namekey)
end

function StagePracticeMap:getStarCondition()
	return self._config.StarCondition
end

function StagePracticeMap:getLocation()
	return self._config.Location
end

function StagePracticeMap:getStarReward()
	return self._config.StarReward
end

function StagePracticeMap:getSubPoint()
	return self._config.SubPoint
end

function StagePracticeMap:getImg()
	return self._config.Img
end

function StagePracticeMap:getBackImgType()
	return self._config.Img.color
end

function StagePracticeMap:getBackImgRole()
	return self._config.Img.role
end
