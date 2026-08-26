-- chunkname: @modules/logic/room/view/RoomViewDebugCamera.lua

module("modules.logic.room.view.RoomViewDebugCamera", package.seeall)

local RoomViewDebugCamera = class("RoomViewDebugCamera", BaseView)

function RoomViewDebugCamera:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewDebugCamera:addEvents()
	return
end

function RoomViewDebugCamera:removeEvents()
	return
end

function RoomViewDebugCamera:_editableInitView()
	self._btndebugcameraoverlookfarest = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugcameraoverlookfarest")
	self._btndebugcameraoverlooknearest = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugcameraoverlooknearest")
	self._btndebugcameranormal = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugcameranormal")
	self._btndebugcameracharacter = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugcameracharacter")

	self._btndebugcameraoverlookfarest:AddClickListener(self._btndebugcameraoverlookfarestOnClick, self)
	self._btndebugcameraoverlooknearest:AddClickListener(self._btndebugcameraoverlooknearestOnClick, self)
	self._btndebugcameranormal:AddClickListener(self._btndebugcameranormalOnClick, self)
	self._btndebugcameracharacter:AddClickListener(self._btndebugcameracharacterOnClick, self)

	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomViewDebugCamera:_btndebugcameraoverlookfarestOnClick()
	self._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		zoom = 1
	})
end

function RoomViewDebugCamera:_btndebugcameraoverlooknearestOnClick()
	self._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		zoom = 0
	})
end

function RoomViewDebugCamera:_btndebugcameranormalOnClick()
	self._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {})
end

function RoomViewDebugCamera:_btndebugcameracharacterOnClick()
	self._scene.camera:switchCameraState(RoomEnum.CameraState.Character, {})
end

function RoomViewDebugCamera:_refreshUI()
	gohelper.setActive(self._btndebugcameraoverlookfarest.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(self._btndebugcameraoverlooknearest.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(self._btndebugcameranormal.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(self._btndebugcameracharacter.gameObject, RoomController.instance:isDebugMode())
end

function RoomViewDebugCamera:onOpen()
	self:_refreshUI()
end

function RoomViewDebugCamera:onClose()
	return
end

function RoomViewDebugCamera:onDestroyView()
	self._btndebugcameraoverlookfarest:RemoveClickListener()
	self._btndebugcameraoverlooknearest:RemoveClickListener()
	self._btndebugcameranormal:RemoveClickListener()
	self._btndebugcameracharacter:RemoveClickListener()
end

return RoomViewDebugCamera
