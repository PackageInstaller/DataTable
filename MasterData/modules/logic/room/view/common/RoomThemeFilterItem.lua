-- chunkname: @modules/logic/room/view/common/RoomThemeFilterItem.lua

module("modules.logic.room.view.common.RoomThemeFilterItem", package.seeall)

local RoomThemeFilterItem = class("RoomThemeFilterItem", ListScrollCellExtend)

function RoomThemeFilterItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomThemeFilterItem:addEvents()
	self._btnclick:AddClickListener(self._onBtnclick, self)
end

function RoomThemeFilterItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomThemeFilterItem:_editableInitView()
	self._goselect = gohelper.findChild(self.viewGO, "beselected")
	self._gounselect = gohelper.findChild(self.viewGO, "unselected")
	self._txtselectName = gohelper.findChildText(self.viewGO, "beselected/name")
	self._txtunselectName = gohelper.findChildText(self.viewGO, "unselected/name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "click")
end

function RoomThemeFilterItem:_onBtnclick()
	if not self._themeItemMO then
		return
	end

	local themeId = self._themeItemMO.id

	if RoomThemeFilterListModel.instance:isSelectById(themeId) then
		RoomThemeFilterListModel.instance:setSelectById(themeId, false)
	else
		RoomThemeFilterListModel.instance:setSelectById(themeId, true)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function RoomThemeFilterItem:_refreshUI()
	if not self._themeItemMO then
		return
	end

	if self._lastId ~= self._themeItemMO.id then
		self._lastId = self._themeItemMO.id
		self._txtselectName.text = self._themeItemMO.config.name
		self._txtunselectName.text = self._themeItemMO.config.name
	end

	local isSelect = RoomThemeFilterListModel.instance:isSelectById(self._themeItemMO.id)

	if self._lastSelect ~= isSelect then
		self._lastSelect = isSelect

		gohelper.setActive(self._goselect, isSelect)
		gohelper.setActive(self._gounselect, not isSelect)
	end
end

function RoomThemeFilterItem:onUpdateMO(mo)
	self._themeItemMO = mo

	self:_refreshUI()
end

function RoomThemeFilterItem:onSelect(isSelect)
	return
end

function RoomThemeFilterItem:onDestroyView()
	return
end

return RoomThemeFilterItem
