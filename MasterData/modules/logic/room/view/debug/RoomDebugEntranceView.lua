-- chunkname: @modules/logic/room/view/debug/RoomDebugEntranceView.lua

module("modules.logic.room.view.debug.RoomDebugEntranceView", package.seeall)

local RoomDebugEntranceView = class("RoomDebugEntranceView", BaseView)

function RoomDebugEntranceView:onInitView()
	self._btndebug = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_debug")
	self._btninit = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_init")
	self._btnpackage = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_package")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugEntranceView:addEvents()
	self._btndebug:AddClickListener(self._btndebugOnClick, self)
	self._btninit:AddClickListener(self._btninitOnClick, self)
	self._btnpackage:AddClickListener(self._btnpackageOnClick, self)
end

function RoomDebugEntranceView:removeEvents()
	self._btndebug:RemoveClickListener()
	self._btninit:RemoveClickListener()
	self._btnpackage:RemoveClickListener()
end

function RoomDebugEntranceView:_btndebugOnClick()
	RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	ViewMgr.instance:closeAllPopupViews()
end

function RoomDebugEntranceView:_btninitOnClick()
	RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit)
	ViewMgr.instance:closeAllPopupViews()
end

function RoomDebugEntranceView:_btnpackageOnClick()
	ViewMgr.instance:openView(ViewName.RoomDebugSelectPackageView)
end

function RoomDebugEntranceView:_editableInitView()
	return
end

function RoomDebugEntranceView:onOpen()
	return
end

function RoomDebugEntranceView:onClose()
	return
end

function RoomDebugEntranceView:onDestroyView()
	return
end

return RoomDebugEntranceView
