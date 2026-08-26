-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionCancelPlaceBlock.lua

module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceBlock", package.seeall)

local RoomTransitionCancelPlaceBlock = class("RoomTransitionCancelPlaceBlock", JompFSMBaseTransition)

function RoomTransitionCancelPlaceBlock:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionCancelPlaceBlock:check()
	return true
end

function RoomTransitionCancelPlaceBlock:onStart(param)
	self._param = param

	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if not tempBlockMO then
		self:onDone()

		return
	end

	local hexPoint = tempBlockMO.hexPoint

	RoomMapBlockModel.instance:removeTempBlockMO()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)

	if tempBlockMO then
		local tempMapMgr = self._scene.mapmgr
		local tempEntity = tempMapMgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

		if tempEntity then
			tempEntity:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_donw")
			tempMapMgr:removeUnitData(SceneTag.RoomMapBlock, tempBlockMO.id)
			tempEntity:removeEvent()
			TaskDispatcher.runDelay(function()
				tempMapMgr:destroyUnit(tempEntity)
			end, self, 0.3333333333333333)
		end
	end

	local emptyMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	self._scene.mapmgr:spawnMapBlock(emptyMO)
	RoomBlockController.instance:refreshNearLand(hexPoint, true)
	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientCancelBlock)

	local savedCameraParam = RoomMapModel.instance:getCameraParam()
	local currentCameraParam = self._scene.camera:getCameraParam()
	local cameraParam = {}

	if cameraParam then
		self._scene.camera:tweenCamera(cameraParam, nil, self.onDone, self)
		RoomMapModel.instance:clearCameraParam()
	else
		self:onDone()
	end
end

function RoomTransitionCancelPlaceBlock:stop()
	return
end

function RoomTransitionCancelPlaceBlock:clear()
	return
end

return RoomTransitionCancelPlaceBlock
