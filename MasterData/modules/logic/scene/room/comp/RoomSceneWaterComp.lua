-- chunkname: @modules/logic/scene/room/comp/RoomSceneWaterComp.lua

module("modules.logic.scene.room.comp.RoomSceneWaterComp", package.seeall)

local RoomSceneWaterComp = class("RoomSceneWaterComp", BaseSceneComp)

function RoomSceneWaterComp:onInit()
	return
end

function RoomSceneWaterComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._waterGODict = {}
	self._waterRes = RoomResHelper.getWaterPath()
	self._waterRoot = self._scene.go.waterRoot

	RoomMapController.instance:registerCallback(RoomEvent.UpdateWater, self._updateWater, self)
	self:_refreshWaterGO()
end

function RoomSceneWaterComp:_updateWater()
	self:_refreshWaterGO()
end

function RoomSceneWaterComp:_refreshWaterGO()
	local convexHull = RoomMapBlockModel.instance:getConvexHull()
	local hexPointDict = RoomMapBlockModel.instance:getConvexHexPointDict()

	for x, dict in pairs(hexPointDict) do
		for y, _ in pairs(dict) do
			local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)

			if blockMO then
				hexPointDict[x][y] = nil
			end
		end
	end

	for x, dict in pairs(hexPointDict) do
		for y, _ in pairs(dict) do
			if not self._waterGODict[x] or not self._waterGODict[x][y] then
				self._waterGODict[x] = self._waterGODict[x] or {}

				local hexPoint = HexPoint(x, y)
				local waterGO = RoomGOPool.getInstance(self._waterRes, self._waterRoot, RoomResHelper.getBlockName(hexPoint))

				if waterGO then
					local position = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

					transformhelper.setLocalPos(waterGO.transform, position.x, 0, position.y)

					self._waterGODict[x][y] = waterGO
				end
			end
		end
	end

	for x, dict in pairs(self._waterGODict) do
		for y, waterGO in pairs(dict) do
			if not hexPointDict[x] or not hexPointDict[x][y] then
				RoomGOPool.returnInstance(self._waterRes, waterGO)

				self._waterGODict[x][y] = nil
			end
		end
	end
end

function RoomSceneWaterComp:onSceneClose()
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateWater, self._updateWater, self)

	for x, dict in pairs(self._waterGODict) do
		for y, waterGO in pairs(dict) do
			RoomGOPool.returnInstance(self._waterRes, waterGO)
		end
	end

	self._waterGODict = nil
	self._prefab = nil
	self._waterRoot = nil
end

return RoomSceneWaterComp
