-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionCancelBackBlock.lua

module("modules.logic.scene.room.fsm.RoomTransitionCancelBackBlock", package.seeall)

local RoomTransitionCancelBackBlock = class("RoomTransitionCancelBackBlock", JompFSMBaseTransition)

function RoomTransitionCancelBackBlock:start()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function RoomTransitionCancelBackBlock:check()
	return true
end

function RoomTransitionCancelBackBlock:onStart(param)
	self._param = param

	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local list = backBlockModel:getList()

	for i = 1, #list do
		local blockMO = list[i]

		blockMO:setOpState(RoomBlockEnum.OpState.Normal)

		local blockEntity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

		if blockEntity then
			blockEntity:refreshBlock()
		end
	end

	backBlockModel:clear()
	self:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientCancelBackBlock)
end

function RoomTransitionCancelBackBlock:stop()
	return
end

function RoomTransitionCancelBackBlock:clear()
	return
end

return RoomTransitionCancelBackBlock
