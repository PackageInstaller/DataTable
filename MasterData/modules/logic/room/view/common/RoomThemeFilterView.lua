-- chunkname: @modules/logic/room/view/common/RoomThemeFilterView.lua

module("modules.logic.room.view.common.RoomThemeFilterView", package.seeall)

local RoomThemeFilterView = class("RoomThemeFilterView", BaseView)

function RoomThemeFilterView:onInitView()
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

function RoomThemeFilterView:addEvents()
	self._btnall:AddClickListener(self._btnallOnClick, self)
end

function RoomThemeFilterView:removeEvents()
	self._btnall:RemoveClickListener()
end

function RoomThemeFilterView:_btnallOnClick()
	local isSelect = RoomThemeFilterListModel.instance:getIsAll()

	if isSelect then
		RoomThemeFilterListModel.instance:clearFilterData()
	else
		RoomThemeFilterListModel.instance:selectAll()
	end

	RoomThemeFilterListModel.instance:onModelUpdate()
	RoomMapController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function RoomThemeFilterView:_editableInitView()
	return
end

function RoomThemeFilterView:_onThemeFilterChanged()
	self:_refreshUI()
end

function RoomThemeFilterView:_refreshUI()
	local isSelect = RoomThemeFilterListModel.instance:getIsAll()

	if self._lastSelect ~= isSelect then
		self._lastSelect = isSelect

		gohelper.setActive(self._goselected, isSelect)
		gohelper.setActive(self._gounselected, not isSelect)
	end
end

function RoomThemeFilterView:onUpdateParam()
	return
end

function RoomThemeFilterView:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, self._onThemeFilterChanged, self)
	self:_refreshUI()

	local isBottom = false

	if self.viewParam then
		if self.viewParam.isGift then
			gohelper.setActive(self._gobuildingArrow, false)
			gohelper.setActive(self._goblockpackageArrow, true)
			self.viewContainer:layoutContentTrs(self._gocontent.transform, isBottom)
			recthelper.setAnchorY(self._gocontent.transform, 400)

			return
		end

		isBottom = self.viewParam.isBottom
	end

	gohelper.setActive(self._gobuildingArrow, isBottom)
	gohelper.setActive(self._goblockpackageArrow, not isBottom)
	self.viewContainer:layoutContentTrs(self._gocontent.transform, isBottom)
end

function RoomThemeFilterView:onClose()
	return
end

function RoomThemeFilterView:onDestroyView()
	return
end

return RoomThemeFilterView
