-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingTiledMap.lua

BuildingTiledMap = class("BuildingTiledMap", DmBaseUI)

BuildingTiledMap:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingTiledMap:has("_buildingMediator", {
	is = "rw"
})

function BuildingTiledMap:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BuildingTiledMap:dispose()
	super.dispose(self)
end

function BuildingTiledMap:enterWithData(roomId)
	self._roomId = roomId

	self:createTileMap()
end

function BuildingTiledMap:setupView()
	return
end

function BuildingTiledMap:adjustLayout(targetFrame)
	return
end

function BuildingTiledMap:createTileMap()
	local resPath = KBuilding_TiledMap_Room_Pos[self._roomId][2]

	self._tiledMap = ccexp.TMXTiledMap:create(resPath)
	self._tiledMapCellSize = self._tiledMap:getMapSize()
	self._tileSize = self._tiledMap:getTileSize()
	self._tiledMapLayer = self._tiledMap:getLayer("mapLayer")

	self._tiledMap:setAnchorPoint(0.5, 0.5)
	self:getView():addChild(self._tiledMap)

	local offset = self:getTiledOffset()

	self._tiledMap:setPosition(cc.p(offset.width, offset.height))
	self:getView():setVisible(false)
end

function BuildingTiledMap:getBuildingTiledPos(worldPos)
	local mapPos = self._tiledMapLayer:convertToNodeSpace(worldPos)
	local ret = self._tiledMapLayer:getTileCoordinateFor45Degree(mapPos)

	if ret.x == -1 or ret.y == -1 then
		return nil
	end

	return ret
end

function BuildingTiledMap:getTiledSize()
	return KBuilding_TiledMap_Size[self._roomId] or cc.size(0, 0)
end

function BuildingTiledMap:getTiledOffset()
	return KBuilding_TiledMap_Offset[self._roomId] or cc.size(0, 0)
end
