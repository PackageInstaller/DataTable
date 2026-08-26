-- chunkname: @modules/logic/room/controller/RoomSceneTaskDetailController.lua

module("modules.logic.room.controller.RoomSceneTaskDetailController", package.seeall)

local RoomSceneTaskDetailController = class("RoomSceneTaskDetailController", BaseController)

function RoomSceneTaskDetailController:goToTask(taskCO)
	if taskCO.listenerType == RoomSceneTaskEnum.ListenerType.EditResArea or taskCO.listenerType == RoomSceneTaskEnum.ListenerType.EditHasResBlockCount then
		return self:goToEditMode()
	elseif taskCO.listenerType == RoomSceneTaskEnum.ListenerType.RoomLevel then
		return self:goToHallLevelUp()
	end
end

function RoomSceneTaskDetailController:goToHallLevelUp()
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskGoOBModeInEditMode)
	elseif RoomController.instance:isObMode() then
		RoomMapController.instance:openRoomLevelUpView()
	end
end

function RoomSceneTaskDetailController:goToEditMode()
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)

		return true
	end
end

RoomSceneTaskDetailController.instance = RoomSceneTaskDetailController.New()

return RoomSceneTaskDetailController
