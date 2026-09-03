-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/Stage.lua

Stage = class("Stage")

Stage:has("_owner", {
	is = "rw"
})
Stage:has("_type", {
	is = "rw"
})
Stage:has("_mapCount", {
	is = "rw"
})
Stage:has("_unlockMapIndex", {
	is = "rw"
})
Stage:has("_newOpenMapIndex", {
	is = "rw"
})

function Stage:initialize()
	self._owner = nil
	self._index2Maps = nil
	self._id2Maps = nil
	self._mapCount = 0
	self._systemName = ""
end

function Stage:dispose()
	super.dispose(self)
end

function Stage:sync(data)
	assert(false, "Override")
end

function Stage:getPlayer()
	return self:getOwner():getPlayer()
end

function Stage:getMapByIndex(mapIndex)
	if mapIndex and self._index2Maps then
		return self._index2Maps[mapIndex]
	end
end

function Stage:getMapById(mapId)
	if mapId and self._id2Maps then
		return self._id2Maps[mapId]
	end
end

function Stage:getUnlockMapCount()
	local count = 0

	if self._index2Maps then
		for index, map in ipairs(self._index2Maps) do
			if not map:isUnlock() then
				break
			end

			count = index
		end
	end

	return count
end

function Stage:getPassPointCount()
	local unlockMapCount = self:getUnlockMapCount()
	local passPointCount = 0

	for i = 1, unlockMapCount do
		local map = self._index2Maps[i]

		passPointCount = passPointCount + map:getPassPointCount()
	end

	return passPointCount
end

function Stage:isUnlock()
	return true
end

function Stage:getMapInfoList()
	return self._index2Maps
end

function Stage:mapId2Index(mapId)
	if mapId and self._id2Maps then
		local map = self._id2Maps[mapId]

		return map and map:getIndex()
	end
end

function Stage:index2MapId(index)
	if index and self._index2Maps then
		local map = self._index2Maps[index]

		return map and map:getId()
	end
end

function Stage:getLastPointIndexByMapIndex(mapIndex)
	local mapCfg = ConfigReader:getRecordById(self:getMapConfigName(), self:index2MapId(mapIndex))

	for i = #mapCfg.SubPoint, 1, -1 do
		local pointId = mapCfg.SubPoint[i]
		local pointCfg = self:getPointConfigById(pointId)

		return self:parseStageIndex(pointId).pointIndex
	end
end

function Stage:getPointConfigById(pointId)
	return ConfigReader:getRecordById(self:getPointConfigName(), pointId)
end

function Stage:getMapConfigById(mapId)
	return ConfigReader:getRecordById(self:getMapConfigName(), mapId)
end

function Stage:parseStageIndex(pointId)
	local data = {}
	local pointCfg = self:getPointConfigById(pointId)

	if pointCfg == nil then
		local str = "pointId=" .. pointId

		CommonUtils.uploadDataToBugly("pointIdNull", str)
	end

	data.mapIndex = self:mapId2Index(pointCfg.Map)

	local mapCfg = self:getMapConfigById(pointCfg.Map)

	for k, v in ipairs(mapCfg.SubPoint) do
		if v == pointId then
			data.pointIndex = k

			break
		end
	end

	return data
end

function Stage:getStageStar()
	local maps = self._index2Maps
	local currentStarCount = 0

	for i = 1, #maps do
		local _map = maps[i]

		currentStarCount = currentStarCount + _map:getCurrentStarCount()
	end

	return currentStarCount
end
