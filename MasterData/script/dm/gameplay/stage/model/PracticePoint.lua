-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/PracticePoint.lua

PracticePoint = class("PracticePoint")

PracticePoint:has("_id", {
	is = "r"
})
PracticePoint:has("_index", {
	is = "rw"
})
PracticePoint:has("_owner", {
	is = "rw"
})
PracticePoint:has("_isDailyFirstEnter", {
	is = "rw"
})

function PracticePoint:initialize(pointId)
	assert(pointId ~= nil, "error:pointId=nil")
	super.initialize(self)

	self._id = pointId
	self._isPass = false
	self._team = Team:new({
		teamId = 0,
		teamType = ""
	})
	self._config = ConfigReader:getRecordById("BlockPracticePoint", pointId)
	self._isDailyFirstEnter = true
end

function PracticePoint:getPlayer()
	return self:getOwner():getPlayer()
end

function PracticePoint:sync()
	local player = self:getPlayer()
	local practicePointList = player:getStagePractice()
	local points = practicePointList.points

	if points[self._id] then
		self._isPass = points[self._id].passed == 1
	end
end

function PracticePoint:isPass()
	return self._isPass
end

function PracticePoint:getTeam()
	return self._team
end

function PracticePoint:isUnlock()
	if not self._owner:isUnlock() then
		return false
	end

	local _prePointId = self:getPrevBPointId()
	local _prePoint = self._owner:getPointById(_prePointId)

	return _prePoint:isPass()
end

function PracticePoint:getName()
	return Strings:get(self._config.Name)
end

function PracticePoint:getDesc()
	return Strings:get(self._config.Desc)
end

function PracticePoint:getFirstReward()
	return (ConfigReader:getDataByNameIdAndKey("Reward", self._config.FirstReward, "Content"))
end

function PracticePoint:getCommonReward()
	return (ConfigReader:getDataByNameIdAndKey("Reward", self._config.PointReward, "Content"))
end

function PracticePoint:getPrevBPointId()
	return self._config.PrePoint
end

function PracticePoint:getShowHero()
	return self._config.PointHead
end

function PracticePoint:getCostEnergy()
	return self._config.StaminaCost
end

function PracticePoint:getSelfMaster()
	return self._config.SelfMaster[1]
end

function PracticePoint:getEnemyHero()
	return self._config.EnemyHero
end

function PracticePoint:getGuideDesc()
	return Strings:get(self._config.StageDesc)
end

function PracticePoint:getOwnMaster()
	local masterid = self._config.SelfMaster[1]
	local rid = ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel")

	return ConfigReader:getDataByNameIdAndKey("RoleModel", rid, "Model")
end

function PracticePoint:getBublingTips()
	return false
end

function PracticePoint:isBoss()
	return false
end
