-- chunkname: @modules/logic/scene/room/comp/RoomSceneTimerComp.lua

module("modules.logic.scene.room.comp.RoomSceneTimerComp", package.seeall)

local RoomSceneTimerComp = class("RoomSceneTimerComp", BaseSceneComp)

function RoomSceneTimerComp:init(sceneId, levelId)
	TaskDispatcher.runRepeat(self.everySecondCall, self, TimeUtil.OneSecond)
	RoomMapController.instance:dispatchEvent(RoomEvent.RoomTimerInitComplete)
end

function RoomSceneTimerComp:everySecondCall()
	local isDebugMode = RoomController.instance:isDebugMode()

	if isDebugMode then
		return
	end

	ManufactureController.instance:checkManufactureInfoUpdate()
end

function RoomSceneTimerComp:onSceneClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

return RoomSceneTimerComp
