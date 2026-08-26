-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionConfirmPlaceBlock.lua

module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceBlock", package.seeall)

local RoomTransitionConfirmPlaceBlock = class("RoomTransitionConfirmPlaceBlock", JompFSMBaseTransition)

function RoomTransitionConfirmPlaceBlock:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomTransitionConfirmPlaceBlock:check()
	return true
end

function RoomTransitionConfirmPlaceBlock:onStart(param)
	self._param = param
	self._animDone = false

	local tempBlockMO = self._param.tempBlockMO
	local hexPoint = tempBlockMO.hexPoint
	local ranges = hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

	for i, range in ipairs(ranges) do
		local rangeMO = RoomMapBlockModel.instance:getBlockMO(range.x, range.y)

		if rangeMO and rangeMO.blockState == RoomBlockEnum.BlockState.Water then
			local entity = self._scene.mapmgr:getBlockEntity(rangeMO.id, SceneTag.RoomEmptyBlock)

			entity = entity or self._scene.mapmgr:spawnMapBlock(rangeMO)
		end
	end

	local curEntity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

	if curEntity then
		curEntity:refreshBlock()
		curEntity:refreshRotation()
		curEntity:playSmokeEffect()
		curEntity:playAmbientAudio()
	end

	local neighbors = hexPoint:getNeighbors()

	for i, neighbor in ipairs(neighbors) do
		local neighborMO = RoomMapBlockModel.instance:getBlockMO(neighbor.x, neighbor.y)

		if neighborMO and neighborMO.blockState == RoomBlockEnum.BlockState.Map and self:_isNeighborsCanAnim(neighbor.x, neighbor.y) then
			local entity = self._scene.mapmgr:getBlockEntity(neighborMO.id, SceneTag.RoomMapBlock)

			if entity then
				entity:playAnim(RoomScenePreloader.ResAnim.ContainerUp, "container_up")
			end
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateWater)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateInventoryCount)
	self._scene.inventorymgr:playForwardAnim(self._animCallback, self)
	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmBlock)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_fix)
end

function RoomTransitionConfirmPlaceBlock:_isNeighborsCanAnim(x, y)
	local builingParam = RoomMapBuildingModel.instance:getBuildingParam(x, y)

	if builingParam and RoomBuildingEnum.NotPlaceBlockAnimDict[builingParam.buildingId] then
		return false
	end

	return true
end

function RoomTransitionConfirmPlaceBlock:_animCallback()
	local tempBlockMO = self._param.tempBlockMO
	local hexPoint = tempBlockMO.hexPoint
	local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, true)

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshSideShow")
	self._scene.inventorymgr:moveForward()

	self._animDone = true

	self:_checkDone()
end

function RoomTransitionConfirmPlaceBlock:_checkDone()
	if self._animDone then
		local tempBlockMO = self._param.tempBlockMO

		RoomMapController.instance:dispatchEvent(RoomEvent.OnUseBlock, tempBlockMO.id)
		self:onDone()
	end
end

function RoomTransitionConfirmPlaceBlock:stop()
	return
end

function RoomTransitionConfirmPlaceBlock:clear()
	return
end

return RoomTransitionConfirmPlaceBlock
