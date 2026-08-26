-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionConfirmBackBlock.lua

module("modules.logic.scene.room.fsm.RoomTransitionConfirmBackBlock", package.seeall)

local RoomTransitionConfirmBackBlock = class("RoomTransitionConfirmBackBlock", JompFSMBaseTransition)

function RoomTransitionConfirmBackBlock:start()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function RoomTransitionConfirmBackBlock:check()
	return true
end

function RoomTransitionConfirmBackBlock:onStart(param)
	self._param = param

	local blockMOList = param.blockMOList

	for i = 1, #blockMOList do
		local blockMO = blockMOList[i]
		local blockEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

		if blockEntity then
			self._scene.mapmgr:destroyBlock(blockEntity)

			local hexPoint = blockMO.hexPoint
			local emptyMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

			self._scene.mapmgr:spawnMapBlock(emptyMO)
		end
	end

	self:onDone()
	self._scene.inventorymgr:moveForward()
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateWater)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateInventoryCount)
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmBackBlock)

	local nearMapEntityList = {}
	local nearEmptyEntityList = {}

	for i = 1, #blockMOList do
		local blockMO = blockMOList[i]
		local hexPoint = blockMO.hexPoint

		self:_addValues(nearMapEntityList, RoomBlockHelper.getNearBlockEntity(false, hexPoint, 1, true))
		self:_addValues(nearEmptyEntityList, RoomBlockHelper.getNearBlockEntity(true, hexPoint, 1, true))
		RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)
	end

	RoomBlockHelper.refreshBlockEntity(nearMapEntityList, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(nearEmptyEntityList, "refreshWaveEffect")
end

function RoomTransitionConfirmBackBlock:_addValues(targetArray, addArray)
	if targetArray and addArray then
		for _, value in ipairs(addArray) do
			local index = tabletool.indexOf(targetArray, value)

			if not index then
				table.insert(targetArray, value)
			end
		end
	end
end

function RoomTransitionConfirmBackBlock:stop()
	return
end

function RoomTransitionConfirmBackBlock:clear()
	return
end

return RoomTransitionConfirmBackBlock
