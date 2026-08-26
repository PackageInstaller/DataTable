-- chunkname: @modules/logic/room/view/debug/RoomDebugThemeFilterItem.lua

module("modules.logic.room.view.debug.RoomDebugThemeFilterItem", package.seeall)

local RoomDebugThemeFilterItem = class("RoomDebugThemeFilterItem", ListScrollCellExtend)

function RoomDebugThemeFilterItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugThemeFilterItem:addEvents()
	self._btnclick:AddClickListener(self._onBtnclick, self)
end

function RoomDebugThemeFilterItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomDebugThemeFilterItem:_editableInitView()
	self._goselect = gohelper.findChild(self.viewGO, "beselected")
	self._gounselect = gohelper.findChild(self.viewGO, "unselected")
	self._txtselectName = gohelper.findChildText(self.viewGO, "beselected/name")
	self._txtunselectName = gohelper.findChildText(self.viewGO, "unselected/name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "click")
end

function RoomDebugThemeFilterItem:_onBtnclick()
	if not self._themeItemMO then
		return
	end

	local themeId = self._themeItemMO.id

	if RoomDebugThemeFilterListModel.instance:isSelectById(themeId) then
		RoomDebugThemeFilterListModel.instance:setSelectById(themeId, false)
	else
		RoomDebugThemeFilterListModel.instance:setSelectById(themeId, true)
	end

	RoomDebugController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function RoomDebugThemeFilterItem:_refreshUI()
	if not self._themeItemMO then
		return
	end

	if self._lastId ~= self._themeItemMO.id then
		self._lastId = self._themeItemMO.id
		self._txtselectName.text = self._themeItemMO.config.name
		self._txtunselectName.text = self._themeItemMO.config.name
	end

	local isSelect = RoomDebugThemeFilterListModel.instance:isSelectById(self._themeItemMO.id)

	if self._lastSelect ~= isSelect then
		self._lastSelect = isSelect

		gohelper.setActive(self._goselect, isSelect)
		gohelper.setActive(self._gounselect, not isSelect)
	end
end

function RoomDebugThemeFilterItem:onUpdateMO(mo)
	self._themeItemMO = mo

	self:_refreshUI()
end

function RoomDebugThemeFilterItem:onSelect(isSelect)
	return
end

function RoomDebugThemeFilterItem:onDestroyView()
	return
end

return RoomDebugThemeFilterItem
