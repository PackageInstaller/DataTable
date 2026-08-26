-- chunkname: @modules/logic/room/view/debug/RoomDebugThemeFilterView.lua

module("modules.logic.room.view.debug.RoomDebugThemeFilterView", package.seeall)

local RoomDebugThemeFilterView = class("RoomDebugThemeFilterView", BaseView)

function RoomDebugThemeFilterView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._gobuildingArrow = gohelper.findChild(self.viewGO, "#go_content/bg/#go_buildingArrow")
	self._goblockpackageArrow = gohelper.findChild(self.viewGO, "#go_content/bg/#go_blockpackageArrow")
	self._goall = gohelper.findChild(self.viewGO, "#go_content/#go_all")
	self._goselected = gohelper.findChild(self.viewGO, "#go_content/#go_all/#go_selected")
	self._gounselected = gohelper.findChild(self.viewGO, "#go_content/#go_all/#go_unselected")
	self._btnall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#go_all/#btn_all")
	self._scrolltheme = gohelper.findChildScrollRect(self.viewGO, "#go_content/#scroll_theme")
	self._gothemeitem = gohelper.findChild(self.viewGO, "#go_content/#go_themeitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugThemeFilterView:addEvents()
	self._btnall:AddClickListener(self._btnallOnClick, self)
end

function RoomDebugThemeFilterView:removeEvents()
	self._btnall:RemoveClickListener()
end

function RoomDebugThemeFilterView:_btnallOnClick()
	local isSelect = RoomDebugThemeFilterListModel.instance:getIsAll()

	if isSelect then
		RoomDebugThemeFilterListModel.instance:clearFilterData()
	else
		RoomDebugThemeFilterListModel.instance:selectAll()
	end

	RoomDebugThemeFilterListModel.instance:onModelUpdate()
	RoomDebugController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function RoomDebugThemeFilterView:_editableInitView()
	return
end

function RoomDebugThemeFilterView:_onThemeFilterChanged()
	self:_refreshUI()
end

function RoomDebugThemeFilterView:_refreshUI()
	local isSelect = RoomDebugThemeFilterListModel.instance:getIsAll()

	if self._lastSelect ~= isSelect then
		self._lastSelect = isSelect

		gohelper.setActive(self._goselected, isSelect)
		gohelper.setActive(self._gounselected, not isSelect)
	end
end

function RoomDebugThemeFilterView:onUpdateParam()
	return
end

function RoomDebugThemeFilterView:onOpen()
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.UIRoomThemeFilterChanged, self._onThemeFilterChanged, self)
	self:_refreshUI()
end

function RoomDebugThemeFilterView:onClose()
	return
end

function RoomDebugThemeFilterView:onDestroyView()
	return
end

return RoomDebugThemeFilterView
