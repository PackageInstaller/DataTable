-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainItem.lua

module("modules.logic.room.view.critter.RoomCritterTrainItem", package.seeall)

local RoomCritterTrainItem = class("RoomCritterTrainItem", ListScrollCellExtend)

function RoomCritterTrainItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/#txt_name")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "#scroll_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#scroll_base/viewport/content/#go_baseitem")
	self._btnclickitem = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clickitem")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnclickitem:AddClickListener(self._btnclickitemOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function RoomCritterTrainItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnclickitem:RemoveClickListener()
	self._btndetail:RemoveClickListener()
end

function RoomCritterTrainItem:_btnclickOnClick()
	self:_btnclickitemOnClick()
end

function RoomCritterTrainItem:_btndetailOnClick()
	CritterController.instance:openRoomCritterDetailView(true, self._mo, true)
end

function RoomCritterTrainItem:_btnclickitemOnClick()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectCritter, self:getDataMO())
	end
end

function RoomCritterTrainItem:_editableInitView()
	self._goScrollbaseContent = gohelper.findChild(self.viewGO, "#scroll_base/viewport/content")
end

function RoomCritterTrainItem:_editableAddEvents()
	return
end

function RoomCritterTrainItem:_editableRemoveEvents()
	return
end

function RoomCritterTrainItem:getDataMO()
	return self._mo
end

function RoomCritterTrainItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RoomCritterTrainItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function RoomCritterTrainItem:onDestroyView()
	return
end

function RoomCritterTrainItem:refreshUI()
	local critterMO = self._mo

	if critterMO then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._goicon)

		self.critterIcon:setMOValue(critterMO:getId(), critterMO:getDefineId())

		self._txtname.text = critterMO:getName()

		self:_refreshLineLinkUI()
	end
end

function RoomCritterTrainItem:_refreshLineLinkUI()
	if self._mo then
		self._dataList = self._mo:getAttributeInfos()

		local parent_obj = self._goScrollbaseContent
		local model_obj = self._gobaseitem

		gohelper.CreateObjList(self, self._onCritterArrComp, self._dataList, parent_obj, model_obj, RoomCritterAttrScrollCell)
	end
end

function RoomCritterTrainItem:_onCritterArrComp(cell_component, data, index)
	cell_component:onUpdateMO(data)

	cell_component._view = cell_component._view or self._view
end

RoomCritterTrainItem.prefabPath = "ui/viewres/room/critter/roomcrittertrainitem.prefab"

return RoomCritterTrainItem
