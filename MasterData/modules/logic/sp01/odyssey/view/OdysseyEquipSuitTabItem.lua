-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyEquipSuitTabItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyEquipSuitTabItem", package.seeall)

local OdysseyEquipSuitTabItem = class("OdysseyEquipSuitTabItem", ListScrollCellExtend)

function OdysseyEquipSuitTabItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyEquipSuitTabItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function OdysseyEquipSuitTabItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function OdysseyEquipSuitTabItem:_btnclickOnClick()
	logNormal("点击过滤按钮 type: " .. self.mo.type)

	local haveSelect = self._isSelect

	if haveSelect then
		return
	end

	self._view:selectCell(self._index, true)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipSuitSelect, (not haveSelect or nil) and (self.mo or nil))
end

function OdysseyEquipSuitTabItem:_editableInitView()
	self._enableDeselect = true
end

function OdysseyEquipSuitTabItem:_editableAddEvents()
	return
end

function OdysseyEquipSuitTabItem:_editableRemoveEvents()
	return
end

function OdysseyEquipSuitTabItem:onUpdateMO(mo)
	self.mo = mo

	self:refreshUI()
end

function OdysseyEquipSuitTabItem:refreshUI()
	if self.mo.type == OdysseyEnum.EquipSuitType.All then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageicon, "odyssey_herogroup_icon_all")
	else
		local config = self.mo.config

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageicon, config.icon)
		self:onSelect(false)
	end
end

function OdysseyEquipSuitTabItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselect, isSelect)
end

function OdysseyEquipSuitTabItem:onDestroyView()
	return
end

return OdysseyEquipSuitTabItem
