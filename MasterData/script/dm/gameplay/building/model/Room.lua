-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/model/Room.lua

Room = class("Room", objectlua.Object, _M)

Room:has("_buildingSystem", {
	is = "rw"
})
Room:has("_floorId", {
	is = "rw"
})
Room:has("_ownFloorIdList", {
	is = "rw"
})
Room:has("_buildingList", {
	is = "rw"
})
Room:has("_heroList", {
	is = "rw"
})
Room:has("_id", {
	is = "rw"
})
Room:has("_bag", {
	is = "rw"
})
Room:has("_comfortValue", {
	is = "rw"
})
Room:has("_placedBuildings", {
	is = "rw"
})
Room:has("_lastHeroLove", {
	is = "rw"
})

function Room:initialize()
	super.initialize(self)
	self:clear()
end

function Room:dispose()
	super.dispose(self)
end

function Room:synchronize(data)
	if not data then
		return
	end

	if data.curOutwardId then
		-- block empty
	end

	if data.unlockedOutward then
		-- block empty
	end

	if data.heroes then
		self._heroList = {}

		for k, v in pairs(data.heroes) do
			self._heroList[k + 1] = v
		end

		local developSystem = self._buildingSystem._developSystem

		developSystem:getPlayer():syncAttrEffect()
	end

	if data.buildings then
		for k, v in pairs(data.buildings) do
			local building = self._buildingList[k]

			if not building then
				building = self._buildingSystem:judgeResouseType(v.type) and ResourceBuilding:new() or DecorateBuilding:new()
				self._buildingList[k] = building

				self._buildingList[k]:setId(k)

				self._buildingList[k]._buildingSystem = self._buildingSystem

				building:setFinishAnimTime(self._buildingSystem:getGameServerAgent():remoteTimestamp() + KBUILDING_BUILD_ANIM_PLAY_TIME)
			end

			building:synchronize(v)
		end
	end

	if data.placedBuildings then
		self._placedBuildings = {}

		for k, v in pairs(data.placedBuildings) do
			self._placedBuildings[v] = true
		end
	end

	if data.comfortValue and self._comfortValue ~= data.comfortValue then
		self._comfortValue = data.comfortValue

		self._buildingSystem:dispatch(Event:new(BUILDING_COMFORT_REFRESH))
	end

	if data.unlockedSurface then
		-- block empty
	end

	self._lastHeroLove = {}

	if data.lastHeroLove then
		self._lastHeroLove = data.lastHeroLove
	end
end

function Room:clear()
	self._floorId = ""
	self._ownFloorIdList = {}
	self._buildingList = {}
	self._heroList = {}
	self._id = ""
	self._bag = {}
	self._usePos = {}
	self._comfortValue = 0
	self._placedBuildings = {}
	self._heroPosList = {}
end

function Room:getPos()
	return KBuilding_TiledMap_Room_Pos[self._id][1]
end

function Room:getTileMap()
	return KBuilding_TiledMap_Room_Pos[self._id][2]
end

function Room:getBuildingById(id)
	if id then
		return self._buildingList[id]
	end

	return nil
end

function Room:resetUsePos()
	self._usePos = {}

	for k, v in pairs(self._placedBuildings) do
		local buildingData = self._buildingList[k]
		local posList = buildingData:getUsePos()

		for i = 1, #posList do
			local pos = posList[i]
			local key = pos.x .. "_" .. pos.y

			self._usePos[key] = true
		end
	end

	local content = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_Unbuild", "content")

	if content and content[self._id] then
		local posList = content[self._id]

		for i = 1, #posList do
			local pos = posList[i]
			local key = pos[1] .. "_" .. pos[2]

			self._usePos[key] = true
		end
	end
end

function Room:getOwnNum(configId)
	local num = 0

	for k, v in pairs(self._buildingList) do
		if v._configId == configId then
			num = num + 1
		end
	end

	return num
end

function Room:getOwnList(configId)
	local list = {}

	for k, v in pairs(self._buildingList) do
		if v._configId == configId then
			list[#list + 1] = v
		end
	end

	return list
end

function Room:getIdByPos(pos)
	for k, v in pairs(self._placedBuildings) do
		local buildingData = self._buildingList[k]
		local posList = buildingData:getUsePos()

		for i = 1, #posList do
			local posN = posList[i]

			if posN.x == pos.x and posN.y == pos.y then
				return k
			end
		end
	end

	return nil
end

function Room:getRecycleList()
	local idList = {}

	for k, v in pairs(self._buildingList) do
		if not self._placedBuildings[k] then
			idList[#idList + 1] = k
		end
	end

	return idList
end

function Room:getCanPutHeroPosList()
	local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", self._id, "Area")
	local posList = {}
	local posKeyList = {}
	local maxX = area[1]
	local maxY = area[2]
	local useList = {}

	for k, v in pairs(self._heroPosList) do
		local key = v.x .. "_" .. v.y

		useList[key] = true
	end

	for x = 0, maxX do
		for y = 0, maxY do
			local key = x .. "_" .. y

			if not self._usePos[key] and not useList[key] then
				posList[#posList + 1] = cc.p(x, y)
				posKeyList[key] = true
			end
		end
	end

	return posList, posKeyList
end

function Room:setHeroPutPos(heroId, pos)
	if pos then
		self._heroPosList[heroId] = cc.p(pos.x, pos.y)
	else
		self._heroPosList[heroId] = nil

		for k, v in pairs(self._buildingList) do
			v:removePutHero(heroId)
		end
	end
end

function Room:getHeroIdList()
	local list = {}

	for k, v in pairs(self._heroList) do
		list[v] = true
	end

	return list
end

function Room:getBuildingByPos(pos)
	for k, v in pairs(self._placedBuildings) do
		local building = self._buildingList[k]
		local posList = building:getUsePos()

		for i = 1, #posList do
			local posNow = posList[i]

			if posNow.x == pos.x and posNow.y == pos.y then
				return building
			end
		end
	end
end

function Room:getHeroIdByPos(heroId, pos)
	for k, v in pairs(self._heroPosList) do
		if k ~= heroId and v.x == pos.x and v.y == pos.y then
			return k
		end
	end

	return nil
end

function Room:getHeroCanGoPos(pos)
	local posList, posKeyList = self:getCanPutHeroPosList()
	local list = {}
	local key = pos.x + 1 .. "_" .. pos.y

	if posKeyList[key] then
		local info = {}

		info.pos = cc.p(pos.x + 1, pos.y)
		info.dir = 1
		list[#list + 1] = info
	end

	key = pos.x .. "_" .. pos.y + 1

	if posKeyList[pos.x .. "_" .. pos.y + 1] then
		local info = {}

		info.pos = cc.p(pos.x, pos.y + 1)
		info.dir = 2
		list[#list + 1] = info
	end

	key = pos.x - 1 .. "_" .. pos.y

	if posKeyList[pos.x - 1 .. "_" .. pos.y] then
		local info = {}

		info.pos = cc.p(pos.x - 1, pos.y)
		info.dir = 3
		list[#list + 1] = info
	end

	key = pos.x .. "_" .. pos.y - 1

	if posKeyList[pos.x .. "_" .. pos.y - 1] then
		local info = {}

		info.pos = cc.p(pos.x, pos.y - 1)
		info.dir = 4
		list[#list + 1] = info
	end

	return list
end

function Room:getCollectSta()
	for k, v in pairs(self._buildingList) do
		if v:getResouseNum() > 0 then
			return true
		end
	end

	return false
end

function Room:getRoomLvUpSta()
	for k, v in pairs(self._buildingList) do
		if v._status == KBuildingStatus.kLvUp then
			return true
		end
	end

	return false
end

function Room:getAllOutNum()
	local outNum = 0

	for k, v in pairs(self._buildingList) do
		outNum = outNum + v:getOutput()
	end

	return outNum
end
