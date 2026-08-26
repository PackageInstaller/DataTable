-- chunkname: @modules/logic/room/view/debug/RoomDebugBuildingItem.lua

module("modules.logic.room.view.debug.RoomDebugBuildingItem", package.seeall)

local RoomDebugBuildingItem = class("RoomDebugBuildingItem", ListScrollCellExtend)

function RoomDebugBuildingItem:onInitView()
	self._txtbuildingid = gohelper.findChildText(self.viewGO, "#txt_buildingid")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugBuildingItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomDebugBuildingItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomDebugBuildingItem:_btnclickOnClick()
	RoomDebugBuildingListModel.instance:setSelect(self._mo.id)
end

function RoomDebugBuildingItem:_editableInitView()
	self._isSelect = false

	gohelper.addUIClickAudio(self._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function RoomDebugBuildingItem:_refreshUI()
	self._txtbuildingid.text = self._mo.id
	self._txtname.text = self._mo.config.name
end

function RoomDebugBuildingItem:onUpdateMO(mo)
	gohelper.setActive(self._goselect, self._isSelect)

	self._mo = mo

	self:_refreshUI()
end

function RoomDebugBuildingItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	self._isSelect = isSelect
end

function RoomDebugBuildingItem:onDestroy()
	return
end

return RoomDebugBuildingItem
