-- chunkname: @modules/logic/scene/room/comp/RoomSceneDebugComp.lua

module("modules.logic.scene.room.comp.RoomSceneDebugComp", package.seeall)

local RoomSceneDebugComp = class("RoomSceneDebugComp", BaseSceneComp)

function RoomSceneDebugComp:onInit()
	return
end

function RoomSceneDebugComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	if RoomController.instance:isDebugMode() then
		RoomDebugController.instance:registerCallback(RoomEvent.DebugConfirmPlaceBlock, self._debugConfirmPlaceBlock, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRotateBlock, self._debugRotateBlock, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBlock, self._debugRootOutBlock, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugReplaceBlock, self._debugReplaceBlock, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, self._debugSetPackage, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugPlaceBuilding, self._debugPlaceBuilding, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRotateBuilding, self._debugRotateBuilding, self)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBuilding, self._debugRootOutBuilding, self)
	end

	if isDebugBuild then
		TaskDispatcher.runRepeat(self._onFrame, self, 0.01)
	end
end

function RoomSceneDebugComp:_onFrame()
	local leftShift = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

	if leftShift and UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.S) then
		local count = RoomMapBlockModel.instance:getConfirmBlockCount()

		logNormal(string.format("一共放置了%d个地块", count))
	end
end

function RoomSceneDebugComp:_debugConfirmPlaceBlock(hexPoint, blockMO, emptyMO)
	local curEntity = self._scene.mapmgr:getBlockEntity(emptyMO and emptyMO.id, SceneTag.RoomEmptyBlock)

	if curEntity then
		self._scene.mapmgr:destroyBlock(curEntity)
	end

	local entity = self._scene.mapmgr:spawnMapBlock(blockMO)
	local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshBlock")

	local nearEmptyEntityList = RoomBlockHelper.getNearBlockEntity(true, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearEmptyEntityList, "refreshWaveEffect")

	local hexPoint = blockMO.hexPoint
	local neighbors = hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

	for i, neighbor in ipairs(neighbors) do
		local neighborMO = RoomMapBlockModel.instance:getBlockMO(neighbor.x, neighbor.y)

		if neighborMO and neighborMO.blockState == RoomBlockEnum.BlockState.Water then
			local entity = self._scene.mapmgr:getBlockEntity(neighborMO.id, SceneTag.RoomEmptyBlock)

			entity = entity or self._scene.mapmgr:spawnMapBlock(neighborMO)
		end
	end
end

function RoomSceneDebugComp:_debugRotateBlock(hexPoint, blockMO)
	local mapEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

	if mapEntity then
		mapEntity:refreshRotation()
		mapEntity:refreshBlock()
	end

	local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshBlock")
end

function RoomSceneDebugComp:_debugRootOutBlock(hexPoint, blockMO, emptyMOList)
	local mapEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

	if mapEntity then
		self._scene.mapmgr:destroyBlock(mapEntity)
	end

	local emptyMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if emptyMO and emptyMO.blockState == RoomBlockEnum.BlockState.Water then
		local entity = self._scene.mapmgr:getBlockEntity(emptyMO.id, SceneTag.RoomEmptyBlock)

		entity = entity or self._scene.mapmgr:spawnMapBlock(emptyMO)
	end

	for _, one in ipairs(emptyMOList) do
		local entity = self._scene.mapmgr:getBlockEntity(one.id, SceneTag.RoomEmptyBlock)

		if entity then
			self._scene.mapmgr:destroyBlock(entity)
		end
	end

	local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshBlock")

	local nearEmptyEntityList = RoomBlockHelper.getNearBlockEntity(true, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearEmptyEntityList, "refreshWaveEffect")
end

function RoomSceneDebugComp:_debugReplaceBlock(hexPoint, blockMO)
	local mapEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

	if mapEntity then
		mapEntity:refreshBlock()
	end

	local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshBlock")
end

function RoomSceneDebugComp:_debugSetPackage(hexPoint, blockMO)
	if not blockMO then
		return
	end

	local mapEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

	if mapEntity then
		mapEntity:refreshPackage()
	end

	RoomDebugPackageListModel.instance:setDebugPackageList()
end

function RoomSceneDebugComp:_debugPlaceBuilding(hexPoint, buildingMO)
	local entity = self._scene.buildingmgr:spawnMapBuilding(buildingMO)
	local nearBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(false, buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)

	RoomBlockHelper.refreshBlockResourceType(nearBlockEntityList)
	RoomBlockHelper.refreshBlockEntity(nearBlockEntityList, "refreshBlock")

	local nearEmptyBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(true, buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)

	RoomBlockHelper.refreshBlockEntity(nearEmptyBlockEntityList, "refreshWaveEffect")
end

function RoomSceneDebugComp:_debugRotateBuilding(hexPoint, buildingMO, previousRotate)
	local entity = self._scene.buildingmgr:getBuildingEntity(buildingMO.id, SceneTag.RoomBuilding)

	if entity then
		entity:refreshRotation()
	end

	local previousNearBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(false, buildingMO.buildingId, buildingMO.hexPoint, previousRotate)

	RoomBlockHelper.refreshBlockResourceType(previousNearBlockEntityList)
	RoomBlockHelper.refreshBlockEntity(previousNearBlockEntityList, "refreshBlock")

	local previousNearEmptyBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(true, buildingMO.buildingId, buildingMO.hexPoint, previousRotate)

	RoomBlockHelper.refreshBlockEntity(previousNearEmptyBlockEntityList, "refreshWaveEffect")

	local nearBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(false, buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)

	RoomBlockHelper.refreshBlockResourceType(nearBlockEntityList)
	RoomBlockHelper.refreshBlockEntity(nearBlockEntityList, "refreshBlock")

	local nearEmptyBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(true, buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)

	RoomBlockHelper.refreshBlockEntity(nearEmptyBlockEntityList, "refreshWaveEffect")
end

function RoomSceneDebugComp:_debugRootOutBuilding(hexPoint, buildingMO)
	local entity = self._scene.buildingmgr:getBuildingEntity(buildingMO.id, SceneTag.RoomBuilding)

	if entity then
		self._scene.buildingmgr:destroyBuilding(entity)
	end

	local nearBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(false, buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)

	RoomBlockHelper.refreshBlockResourceType(nearBlockEntityList)
	RoomBlockHelper.refreshBlockEntity(nearBlockEntityList, "refreshBlock")

	local nearEmptyBlockEntityList = RoomBlockHelper.getNearBlockEntityByBuilding(true, buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)

	RoomBlockHelper.refreshBlockEntity(nearEmptyBlockEntityList, "refreshWaveEffect")
end

function RoomSceneDebugComp:onSceneClose()
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugConfirmPlaceBlock, self._debugConfirmPlaceBlock, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRotateBlock, self._debugRotateBlock, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBlock, self._debugRootOutBlock, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugReplaceBlock, self._debugReplaceBlock, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, self._debugSetPackage, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPlaceBuilding, self._debugPlaceBuilding, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRotateBuilding, self._debugRotateBuilding, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBuilding, self._debugRootOutBuilding, self)
	TaskDispatcher.cancelTask(self._onFrame, self)
end

return RoomSceneDebugComp
