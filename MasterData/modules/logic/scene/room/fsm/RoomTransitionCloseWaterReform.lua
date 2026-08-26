-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionCloseWaterReform.lua

module("modules.logic.scene.room.fsm.RoomTransitionCloseWaterReform", package.seeall)

local RoomTransitionCloseWaterReform = class("RoomTransitionCloseWaterReform", SimpleFSMBaseTransition)

function RoomTransitionCloseWaterReform:start()
	return
end

function RoomTransitionCloseWaterReform:onStart(param)
	local scene = GameSceneMgr.instance:getCurScene()

	if scene and scene.inventorymgr then
		scene.inventorymgr:removeAllBlockEntity()
	end

	RoomWaterReformListModel.instance:clear()
	RoomWaterReformController.instance:clearSelectWater()
	RoomWaterReformController.instance:clearSelectBlock()
	RoomWaterReformModel.instance:clear()
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	RoomMapController.instance:setRoomShowBlockList()
	self:onDone()
end

function RoomTransitionCloseWaterReform:stop()
	return
end

function RoomTransitionCloseWaterReform:clear()
	return
end

return RoomTransitionCloseWaterReform
