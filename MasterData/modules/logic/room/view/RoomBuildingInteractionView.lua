-- chunkname: @modules/logic/room/view/RoomBuildingInteractionView.lua

module("modules.logic.room.view.RoomBuildingInteractionView", package.seeall)

local RoomBuildingInteractionView = class("RoomBuildingInteractionView", BaseView)

function RoomBuildingInteractionView:onInitView()
	self._btnlockscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_lockscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBuildingInteractionView:addEvents()
	self._btnlockscreen:AddClickListener(self._btnlockscreenOnClick, self)
end

function RoomBuildingInteractionView:removeEvents()
	self._btnlockscreen:RemoveClickListener()
end

function RoomBuildingInteractionView:_btnlockscreenOnClick()
	self:closeThis()
	self:_resetCamera()
end

function RoomBuildingInteractionView:_resetCamera()
	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	if not playingInteractionParam or playingInteractionParam.behaviour ~= RoomCharacterEnum.InteractionType.Building then
		return
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(playingInteractionParam.heroId)

	if not roomCharacterMO then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if not scene or not scene.camera then
		return
	end

	local sceneCamera = scene.camera

	if sceneCamera:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		local pos = roomCharacterMO.currentPosition

		sceneCamera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = pos.x,
			focusY = pos.z
		})
	end
end

function RoomBuildingInteractionView:_editableInitView()
	return
end

function RoomBuildingInteractionView:onUpdateParam()
	return
end

function RoomBuildingInteractionView:onOpen()
	return
end

function RoomBuildingInteractionView:onClose()
	return
end

function RoomBuildingInteractionView:onDestroyView()
	return
end

return RoomBuildingInteractionView
