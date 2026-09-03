-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneEnemyCache.lua

require("dm.gameplay.miniGame.model.plane.PlaneEnemyGroup")

PlaneEnemyCache = class("PlaneEnemyCache", objectlua.Object, _M)

PlaneEnemyCache:has("_list", {
	is = "r"
})
PlaneEnemyCache:has("_groupIndex", {
	is = "rw"
})
PlaneEnemyCache:has("_pointIndex", {
	is = "rw"
})

function PlaneEnemyCache:initialize(config)
	super.initialize(self)
	self:initData(config)
end

function PlaneEnemyCache:dispose()
	super.dispose(self)
end

function PlaneEnemyCache:initData(data)
	self._groupIndex = 0
	self._pointIndex = 0
	self._list = {}
	self._maxCount = #data

	for i = 1, self._maxCount do
		local groupId = data[i]
		local config = ConfigReader:getRecordById("MiniPlaneBattle", groupId)

		self._list[i] = PlaneEnemyGroup:new(groupId)
	end
end

function PlaneEnemyCache:getCurGroup()
	return self:getGroupByIndex(self:getGroupIndex())
end

function PlaneEnemyCache:getNextGroup()
	return self:getGroupByIndex(self:getGroupIndex() + 1)
end

function PlaneEnemyCache:getCurEnemyId()
	local group = self:getCurGroup()
	local index = self:getPointIndex()

	return group:getEnemyIdByIndex(index)
end

function PlaneEnemyCache:getAppearSleepTime(groupIndex)
	groupIndex = groupIndex or self:getGroupIndex()

	local group = self:getGroupByIndex(groupIndex)
	local groupCount = group:getEnemyCount()

	if self:getPointIndex() == groupCount then
		return group:getNextGropSleepTime()
	end

	return group:getSleepTime()
end

function PlaneEnemyCache:isFirstGroup()
	return self:getGroupIndex() == 1
end

function PlaneEnemyCache:getGroupByIndex(index)
	return self._list[index or 1]
end

function PlaneEnemyCache:isLastGroup(index)
	return index >= self._maxCount
end

function PlaneEnemyCache:isLastEnemy()
	local group = self:getCurGroup()

	if self:getGroupIndex() >= self._maxCount and self:getPointIndex() >= group:getEnemyCount() then
		return true
	end

	return false
end
