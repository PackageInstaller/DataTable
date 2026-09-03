-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingTiledMapComponent.lua

BuildingTiledMapComponent = class("BuildingTiledMapComponent", DmBaseUI)

BuildingTiledMapComponent:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingTiledMapComponent:has("_buildingMediator", {
	is = "rw"
})

function BuildingTiledMapComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()

	self._tiledMapList = {}
end

function BuildingTiledMapComponent:dispose()
	super.dispose(self)
end

function BuildingTiledMapComponent:enterWithData()
	self:refreshTiledMapList()
end

function BuildingTiledMapComponent:setupView()
	return
end

function BuildingTiledMapComponent:adjustLayout(targetFrame)
	return
end

function BuildingTiledMapComponent:refreshTiledMapList()
	local view = self:getView()
	local roomList = ConfigReader:getDataTable("VillageRoom")

	for k, v in pairs(roomList) do
		local id = k

		if not self._tiledMapList[id] and self._buildingSystem:getRoomShow(id) then
			local pos = KBuilding_TiledMap_Room_Pos[k][1]
			local node = cc.Node:create():addTo(view)

			node:setPosition(pos)

			self._tiledMapList[id] = self:getInjector():instantiate("BuildingTiledMap", {
				view = node
			})

			self._tiledMapList[id]:enterWithData(id)
		end
	end
end

function BuildingTiledMapComponent:getEnterRoomIdByPos(worldPos)
	for k, v in pairs(self._tiledMapList) do
		if v:getBuildingTiledPos(worldPos) then
			return k
		end
	end

	return nil
end

function BuildingTiledMapComponent:getRoomCenterWorldPos(roomId)
	if self._tiledMapList[roomId] then
		local view = self._tiledMapList[roomId]:getView()

		return (view:convertToWorldSpace(cc.p(0, 0)))
	end

	return cc.p(0, 0)
end

function BuildingTiledMapComponent:getRoomNode(roomId)
	return self._tiledMapList[roomId]:getView()
end

function BuildingTiledMapComponent:getRoomIdMoveTo(worldPosB, worldPosE)
	local dis = 99999
	local roomId
	local roomShowId = self._buildingSystem:getShowRoomId()
	local beginPos = self:getRoomCenterWorldPos(roomShowId)
	local changePos = cc.p(worldPosB.x - worldPosE.x, worldPosB.y - worldPosE.y)
	local disY = changePos.y
	local disX = changePos.x

	for k, v in pairs(self._tiledMapList) do
		if k ~= roomShowId then
			local pos = v:getView():convertToWorldSpace(cc.p(0, 0))
			local dirSta = false

			if math.abs(changePos.x) > math.abs(changePos.y) then
				if changePos.x * (pos.x - beginPos.x) > 0 then
					dirSta = true
				end
			elseif changePos.y * (pos.y - beginPos.y) > 0 then
				dirSta = true
			end

			if dirSta then
				local lenLine = pos.x * disY - pos.y * disX - (beginPos.x * disY - beginPos.y * disX)

				lenLine = lenLine * lenLine
				lenLine = lenLine / (disY * disY + disX * disX)
				lenLine = math.sqrt(lenLine)

				if lenLine < 180 then
					local len = cc.pGetDistance(pos, beginPos)

					if len < dis then
						roomId = k
						dis = len
					end
				end
			end
		end
	end

	if not roomId then
		local dis = 300

		for k, v in pairs(self._tiledMapList) do
			local pos = self:getRoomCenterWorldPos(k)
			local winSize = cc.Director:getInstance():getWinSize()
			local centerPos = cc.p(winSize.width / 2, winSize.height / 2)
			local len = cc.pGetDistance(pos, centerPos)

			if len < dis then
				roomId = k
				dis = len
			end
		end
	end

	return roomId
end

function BuildingTiledMapComponent:getBuildingMapPos(roomId, pos)
	if self._tiledMapList[roomId] then
		local room = self._buildingSystem:getRoom(roomId)
		local mapLayer = self._tiledMapList[roomId]._tiledMapLayer
		local tileMap = self._tiledMapList[roomId]._tiledMap
		local realPos = self._buildingSystem:roomPosToTiledPos(roomId, pos)
		local tileMapCellPos = mapLayer:getPositionAt(realPos)
		local contentSize = tileMap:getContentSize()
		local tileMapCenterPos = room:getPos()
		local offset = self._tiledMapList[roomId]:getTiledOffset()

		return cc.p(tileMapCenterPos.x - contentSize.width / 2 + tileMapCellPos.x + offset.width, tileMapCenterPos.y - contentSize.height / 2 + tileMapCellPos.y + offset.height)
	end

	return cc.p(0, 0)
end

function BuildingTiledMapComponent:getRoomTiledPos(roomId, worldPos)
	if self._tiledMapList[roomId] then
		return self._tiledMapList[roomId]:getBuildingTiledPos(worldPos)
	end

	return nil
end
