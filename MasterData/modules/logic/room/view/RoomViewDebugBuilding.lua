-- chunkname: @modules/logic/room/view/RoomViewDebugBuilding.lua

module("modules.logic.room.view.RoomViewDebugBuilding", package.seeall)

local RoomViewDebugBuilding = class("RoomViewDebugBuilding", BaseView)

function RoomViewDebugBuilding:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewDebugBuilding:addEvents()
	return
end

function RoomViewDebugBuilding:removeEvents()
	return
end

function RoomViewDebugBuilding:_editableInitView()
	self._godebugbuilding = gohelper.findChild(self.viewGO, "go_normalroot/go_debugbuilding")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_debugbuilding/btn_close")
	self._scrolldebugbuilding = gohelper.findChildScrollRect(self.viewGO, "go_normalroot/go_debugbuilding/scroll_debugbuilding")

	self._btnclose:AddClickListener(self._btncloseOnClick, self)

	self._isShowDebugBuilding = false

	gohelper.setActive(self._godebugbuilding, false)

	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomViewDebugBuilding:_btncloseOnClick()
	RoomDebugController.instance:setDebugBuildingListShow(false)
end

function RoomViewDebugBuilding:_refreshUI()
	return
end

function RoomViewDebugBuilding:_debugBuildingListViewShowChanged(isShowDebugBuilding)
	self._isShowDebugBuilding = isShowDebugBuilding

	RoomDebugBuildingListModel.instance:clearSelect()
	gohelper.setActive(self._godebugbuilding, isShowDebugBuilding)

	if isShowDebugBuilding then
		RoomDebugBuildingListModel.instance:setDebugBuildingList()

		self._scrolldebugbuilding.horizontalNormalizedPosition = 0
	end
end

function RoomViewDebugBuilding:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomViewDebugBuilding:onOpen()
	self:_refreshUI()
	self:_addBtnAudio()
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, self._debugBuildingListViewShowChanged, self)
end

function RoomViewDebugBuilding:onClose()
	return
end

function RoomViewDebugBuilding:onDestroyView()
	self._btnclose:RemoveClickListener()
	self._scrolldebugbuilding:RemoveOnValueChanged()
end

return RoomViewDebugBuilding
