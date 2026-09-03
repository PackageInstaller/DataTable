-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/model/DreamHouse.lua

DreamHouse = class("DreamHouse", objectlua.Object)

DreamHouse:has("_mapRewards", {
	is = "rw"
})
DreamHouse:has("_houseMap", {
	is = "rw"
})
DreamHouse:has("_mapIds", {
	is = "rw"
})

function DreamHouse:initialize()
	super.initialize(self)

	self._mapRewards = {}
	self._mapIds = ConfigReader:getKeysOfTable("DreamHouseMap")
	self._houseMap = {}

	for i = 1, #self._mapIds do
		self._houseMap[self._mapIds[i]] = DreamHouseMap:new(self._mapIds[i])
	end
end

function DreamHouse:synchronize(data)
	if data and data.mapRewards then
		for k, v in pairs(data.mapRewards) do
			table.insert(self._mapRewards, v)
		end
	end

	if data and data.houseMap then
		for k, v in pairs(data.houseMap) do
			self._houseMap[k]:synchronize(v)
		end
	end
end

function DreamHouse:delete(data)
	if data and data.houseMap then
		for k, v in pairs(data.houseMap) do
			self._houseMap[k]:delete(v)
		end
	end
end

function DreamHouse:getDefaultMapIdx()
	for i = 1, #self._mapIds do
		local mapId = self._mapIds[i]
		local data = self:getMapById(mapId)

		if not data:isLock() and not data:isPass() then
			return i
		end
	end

	for i = 1, #self._mapIds do
		local mapId = self._mapIds[i]
		local data = self:getMapById(mapId)

		if not data:isLock() and not data:isFullStarPass() then
			return i
		end
	end

	return 1
end

function DreamHouse:getMapById(id)
	return self._houseMap[id]
end

function DreamHouse:getLastMapIdx()
	for i = 1, #self._mapIds do
		local mapId = self._mapIds[i]
		local mapData = self:getMapById(mapId)
		local pointIds = mapData:getPointIds({})

		for j = 1, #pointIds do
			-- block empty
		end
	end
end

function DreamHouse:isMapRewardGet(mapId)
	for i = 1, #self._mapRewards do
		if self._mapRewards[i] == mapId then
			return true
		end
	end

	return false
end
