-- chunkname: @modules/logic/room/view/record/RoomCritterHandBookBackItem.lua

module("modules.logic.room.view.record.RoomCritterHandBookBackItem", package.seeall)

local RoomCritterHandBookBackItem = class("RoomCritterHandBookBackItem", ListScrollCellExtend)

function RoomCritterHandBookBackItem:onInitView()
	self._simageitem = gohelper.findChildSingleImage(self.viewGO, "#simage_item")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._gouse = gohelper.findChild(self.viewGO, "#go_use")
	self._gonew = gohelper.findChild(self.viewGO, "#go_normal/#go_new")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gonoraml = gohelper.findChild(self.viewGO, "#go_normal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterHandBookBackItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshUse, self)
end

function RoomCritterHandBookBackItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshUse, self)
end

function RoomCritterHandBookBackItem:_btnclickOnClick()
	self._view:selectCell(self._index, true)
	RoomHandBookBackModel.instance:setSelectMo(self._mo)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.refreshBack)
end

function RoomCritterHandBookBackItem:_editableInitView()
	return
end

function RoomCritterHandBookBackItem:_editableAddEvents()
	return
end

function RoomCritterHandBookBackItem:_editableRemoveEvents()
	return
end

function RoomCritterHandBookBackItem:onUpdateMO(mo)
	self._mo = mo
	self._id = mo.id
	self._config = mo:getConfig()
	self._isuse = mo:checkIsUse()
	self._isEmpty = mo:isEmpty()

	gohelper.setActive(self._goempty, self._isEmpty)
	gohelper.setActive(self._gonoraml, not self._isEmpty)
	gohelper.setActive(self._gouse, self._isuse)
	gohelper.setActive(self._gonew, mo:checkNew())
	gohelper.setActive(self._simageitem.gameObject, not self._isEmpty)

	if not self._isEmpty then
		self._simageitem:LoadImage(ResUrl.getPropItemIcon(self._config.icon))
	end
end

function RoomCritterHandBookBackItem:refreshUse()
	self._isuse = self._mo:checkIsUse()

	gohelper.setActive(self._gouse, self._isuse)
end

function RoomCritterHandBookBackItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomCritterHandBookBackItem:onDestroyView()
	return
end

return RoomCritterHandBookBackItem
