-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterIncubateItem.lua

module("modules.logic.room.view.critter.summon.RoomCritterIncubateItem", package.seeall)

local RoomCritterIncubateItem = class("RoomCritterIncubateItem", ListScrollCellExtend)

function RoomCritterIncubateItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/#txt_name")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "#scroll_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#scroll_base/viewport/content/#go_baseitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterIncubateItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	CritterSummonController.instance:registerCallback(CritterSummonEvent.onSelectParentCritter, self.refreshSelectParent, self)
	CritterSummonController.instance:registerCallback(CritterSummonEvent.onRemoveParentCritter, self.refreshSelectParent, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterRenameReply, self._onCritterRenameReply, self)
end

function RoomCritterIncubateItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnlongPrees:RemoveLongPressListener()
	CritterSummonController.instance:unregisterCallback(CritterSummonEvent.onSelectParentCritter, self.refreshSelectParent, self)
	CritterSummonController.instance:unregisterCallback(CritterSummonEvent.onRemoveParentCritter, self.refreshSelectParent, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterRenameReply, self._onCritterRenameReply, self)
end

function RoomCritterIncubateItem:_btnclickOnClick()
	if self.isSelect then
		CritterIncubateModel.instance:removeSelectParentCritter(self._uid)
	else
		CritterIncubateModel.instance:addSelectParentCritter(self._uid)
	end
end

local PRESS_TIME = 0.5
local NEXT_PRESS_TIME = 99999

function RoomCritterIncubateItem:_editableInitView()
	self._btnlongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btnclick.gameObject)

	self._btnlongPrees:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})
	self._btnlongPrees:AddLongPressListener(self._onLongPress, self)
end

function RoomCritterIncubateItem:_onLongPress()
	local isMaturity = self._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not isMaturity, self._mo)
end

function RoomCritterIncubateItem:_editableAddEvents()
	return
end

function RoomCritterIncubateItem:_editableRemoveEvents()
	return
end

function RoomCritterIncubateItem:onUpdateMO(mo)
	self._mo = mo
	self._uid = self._mo.uid
	self._txtname.text = mo:getName()
	self._critterIcon = self._critterIcon or IconMgr.instance:getCommonCritterIcon(self._goicon)

	self._critterIcon:onUpdateMO(self._mo)
	self._critterIcon:hideMood()
	self:showAttr()
	self:refreshSelect()

	local additionAttr = mo:getAdditionAttr()

	if next(additionAttr) ~= nil then
		self._critterIcon:showUpTip()
	end
end

function RoomCritterIncubateItem:onSelect(isSelect)
	return
end

function RoomCritterIncubateItem:onDestroyView()
	return
end

function RoomCritterIncubateItem:_onCritterRenameReply(critterUid)
	if self._mo and self._uid == critterUid then
		self._txtname.text = self._mo:getName()
	end
end

function RoomCritterIncubateItem:showAttr()
	local attrInfos = self._mo:getAttributeInfos()

	self._attrItems = self._attrItems or self:getUserDataTb_()

	local index = 1

	if attrInfos then
		for type, mo in pairs(attrInfos) do
			local item = self:getAttrItem(index)
			local normal, add = self:getAttrRatioColor()

			item:setRatioColor(normal, add)
			item:onRefreshMo(mo, index)

			index = index + 1
		end
	end

	for i = 1, #self._attrItems do
		gohelper.setActive(self._attrItems[i].viewGO, i < index)
	end
end

function RoomCritterIncubateItem:getAttrRatioColor()
	return "#acacac", "#FFAE46"
end

function RoomCritterIncubateItem:getAttrItem(index)
	local item = self._attrItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gobaseitem)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailAttrItem)
		self._attrItems[index] = item
	end

	return item
end

function RoomCritterIncubateItem:refreshSelectParent(index, uid)
	if self._uid ~= uid then
		return
	end

	self:refreshSelect()
end

function RoomCritterIncubateItem:refreshSelect()
	self.isSelect = CritterIncubateModel.instance:isSelectParentCritter(self._uid)

	gohelper.setActive(self._goselected, self.isSelect)
end

return RoomCritterIncubateItem
