-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionTryPlaceBlock.lua

module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceBlock", package.seeall)

local RoomTransitionTryPlaceBlock = class("RoomTransitionTryPlaceBlock", SimpleFSMBaseTransition)

function RoomTransitionTryPlaceBlock:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionTryPlaceBlock:check()
	return true
end

function RoomTransitionTryPlaceBlock:onStart(param)
	self._param = param

	local hexPoint = self._param.hexPoint
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if tempBlockMO then
		local inventoryBlockMO = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

		if inventoryBlockMO and inventoryBlockMO.id ~= tempBlockMO.id then
			self:_replaceBlock()
		else
			self:_changeBlock()
		end
	else
		self:_placeBlock()
	end

	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientPlaceBlock)

	if hexPoint then
		local pos = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)
		local cameraParam = {}

		if self:_isOutScreen(pos) then
			cameraParam.focusX = pos.x
			cameraParam.focusY = pos.y
		end

		if not tempBlockMO then
			local revertCameraParam = self._scene.camera:getCameraParam()

			RoomMapModel.instance:saveCameraParam(revertCameraParam)
		end

		self._scene.camera:tweenCamera(cameraParam, nil, self.onDone, self)
	else
		self:onDone()
	end
end

function RoomTransitionTryPlaceBlock:_isOutScreen(pos)
	return RoomHelper.isOutCameraFocus(pos)
end

function RoomTransitionTryPlaceBlock:_replaceBlock()
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()
	local riveCount = tempBlockMO:getRiverCount()
	local inventoryBlockMO = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()
	local mapEntity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

	if mapEntity then
		self._scene.mapmgr:destroyBlock(mapEntity)
	end

	self._param.hexPoint = self._param.hexPoint or tempBlockMO.hexPoint

	RoomMapBlockModel.instance:removeTempBlockMO()
	self:_placeBlock()
end

function RoomTransitionTryPlaceBlock:_placeBlock()
	local hexPoint = self._param.hexPoint
	local curEmptyMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)
	local inventoryBlockMO = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()
	local tempBlockMO = RoomMapBlockModel.instance:addTempBlockMO(inventoryBlockMO, hexPoint)

	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)

	if curEmptyMO then
		::label_6_0::

		local curEntity = self._scene.mapmgr:getBlockEntity(curEmptyMO.id, SceneTag.RoomEmptyBlock)

		if curEntity then
			self._scene.mapmgr:destroyBlock(curEntity)
		end

		local entity = self._scene.mapmgr:spawnMapBlock(tempBlockMO)

		entity:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_play")
		entity:playVxWaterEffect()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_put)
		self:_refreshNearBlockEntity(false, hexPoint, true)
	end
end

function RoomTransitionTryPlaceBlock:_changeBlock()
	local hexPoint = self._param.hexPoint
	local rotate = self._param.rotate
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	hexPoint = hexPoint or tempBlockMO.hexPoint
	rotate = rotate or tempBlockMO.rotate

	local previousHexPoint = HexPoint(tempBlockMO.hexPoint.x, tempBlockMO.hexPoint.y)
	local previousRotate = tempBlockMO.rotate
	local curEmptyMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)
	local inventoryBlockMO = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	RoomMapBlockModel.instance:changeTempBlockMO(hexPoint, rotate)
	RoomInventoryBlockModel.instance:rotateFirst(rotate)
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)

	if previousHexPoint ~= hexPoint then
		RoomMapBlockModel.instance:refreshNearRiver(previousHexPoint, 1)
	end

	if previousHexPoint ~= hexPoint then
		if curEmptyMO then
			::label_7_0::

			do
				local curEntity = self._scene.mapmgr:getBlockEntity(curEmptyMO.id, SceneTag.RoomEmptyBlock)

				if curEntity then
					self._scene.mapmgr:destroyBlock(curEntity)
				end

				local mapEntity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

				if mapEntity then
					self._scene.mapmgr:moveTo(mapEntity, hexPoint)
					mapEntity:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_play")
					mapEntity:playVxWaterEffect()
					AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_put)
				end

				local emptyMO = RoomMapBlockModel.instance:getBlockMO(previousHexPoint.x, previousHexPoint.y)

				self._scene.mapmgr:spawnMapBlock(emptyMO)
			end

			if previousRotate ~= rotate then
				local mapEntity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

				if mapEntity then
					mapEntity:refreshRotation(true)
				end

				local inventoryEntity = self._scene.inventorymgr:getBlockEntity(inventoryBlockMO.id, SceneTag.RoomInventoryBlock)

				if inventoryEntity then
					inventoryEntity:refreshRotation(true)
				end
			end

			local mapEntity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

			if mapEntity then
				mapEntity:refreshBlock()
			end

			if previousHexPoint ~= hexPoint then
				self:_refreshNearBlockEntity(false, previousHexPoint, false)
			end

			self:_refreshNearBlockEntity(false, hexPoint, true)
		end
	end
end

function RoomTransitionTryPlaceBlock:_refreshNearBlockEntity(isEmpty, hexPoint, withoutSelf)
	RoomBlockController.instance:refreshNearLand(hexPoint, withoutSelf)
end

function RoomTransitionTryPlaceBlock:stop()
	return
end

function RoomTransitionTryPlaceBlock:clear()
	return
end

return RoomTransitionTryPlaceBlock
