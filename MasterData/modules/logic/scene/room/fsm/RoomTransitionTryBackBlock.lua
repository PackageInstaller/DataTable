-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionTryBackBlock.lua

module("modules.logic.scene.room.fsm.RoomTransitionTryBackBlock", package.seeall)

local RoomTransitionTryBackBlock = class("RoomTransitionTryBackBlock", JompFSMBaseTransition)

function RoomTransitionTryBackBlock:start()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function RoomTransitionTryBackBlock:check()
	return true
end

function RoomTransitionTryBackBlock:onStart(param)
	self._param = param

	local hexPoint = self._param.hexPoint
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()

	if backBlockModel:getCount() >= RoomEnum.ConstNum.InventoryBlockOneBackMax and backBlockModel:getById(blockMO.id) == nil then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockOneBackMax)
		self:onDone()

		return
	end

	if not RoomMapBlockModel.instance:isBackMore() then
		self:_backOne(blockMO.id)
	end

	local curEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)
	local opstate = self._opToDis[blockMO:getOpState()] or RoomBlockEnum.OpState.Normal

	blockMO:setOpState(opstate)

	if opstate == RoomBlockEnum.OpState.Back then
		backBlockModel:addAtLast(blockMO)
	else
		backBlockModel:remove(blockMO)
		curEntity:refreshBlock()

		hexPoint = nil
	end

	self:onDone()
	self:_refreshBackBlock()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientTryBackBlock)

	if hexPoint then
		local pos = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)
		local cameraParam = {}

		if self:_isOutScreen(pos) then
			cameraParam.focusX = pos.x
			cameraParam.focusY = pos.y
		end

		self._scene.camera:tweenCamera(cameraParam)
	end
end

function RoomTransitionTryBackBlock:_refreshBackBlock()
	local isCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local list = backBlockModel:getList()

	for i = 1, #list do
		local blockMO = list[i]

		if blockMO:getOpStateParam() ~= isCanBack then
			blockMO:setOpState(RoomBlockEnum.OpState.Back, isCanBack)

			local blockEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

			if blockEntity then
				blockEntity:refreshBlock()
			end
		end
	end
end

function RoomTransitionTryBackBlock:_backOne(selectBlockId)
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local list = backBlockModel:getList()

	for i = 1, #list do
		local blockMO = list[i]

		if blockMO and blockMO.id ~= selectBlockId then
			blockMO:setOpState(RoomBlockEnum.OpState.Normal)

			local blockEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

			if blockEntity then
				blockEntity:refreshBlock()
			end
		end
	end

	backBlockModel:clear()
end

function RoomTransitionTryBackBlock:_isOutScreen(pos)
	return RoomHelper.isOutCameraFocus(pos)
end

function RoomTransitionTryBackBlock:stop()
	return
end

function RoomTransitionTryBackBlock:clear()
	return
end

function RoomTransitionTryBackBlock:onDone()
	RoomTransitionTryBackBlock.super.onDone(self)
end

return RoomTransitionTryBackBlock
