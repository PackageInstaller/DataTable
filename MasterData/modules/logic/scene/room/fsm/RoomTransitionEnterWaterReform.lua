-- chunkname: @modules/logic/scene/room/fsm/RoomTransitionEnterWaterReform.lua

module("modules.logic.scene.room.fsm.RoomTransitionEnterWaterReform", package.seeall)

local RoomTransitionEnterWaterReform = class("RoomTransitionEnterWaterReform", SimpleFSMBaseTransition)

function RoomTransitionEnterWaterReform:start()
	return
end

function RoomTransitionEnterWaterReform:onStart(param)
	RoomMapController.instance:clearRoomShowBlockList()
	RoomWaterReformModel.instance:initWaterArea()
	RoomWaterReformModel.instance:setWaterReform(true)
	RoomWaterReformController.instance:changeReformMode(RoomEnum.ReformMode.Block)
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectRoomViewBlockOpTab, RoomEnum.RoomViewBlockOpMode.WaterReform)
	self:onDone()
end

function RoomTransitionEnterWaterReform:stop()
	return
end

function RoomTransitionEnterWaterReform:clear()
	return
end

return RoomTransitionEnterWaterReform
