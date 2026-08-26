-- chunkname: @modules/logic/rouge/view/RougeDLCSelectListItem.lua

module("modules.logic.rouge.view.RougeDLCSelectListItem", package.seeall)

local RougeDLCSelectListItem = class("RougeDLCSelectListItem", MixScrollCell)

function RougeDLCSelectListItem:init(go)
	self.viewGO = go
	self._goselectedequip = gohelper.findChild(self.viewGO, "go_info/go_selected_equip")
	self._gounselectequip = gohelper.findChild(self.viewGO, "go_info/go_unselect_equip")
	self._goselectedunequip = gohelper.findChild(self.viewGO, "go_info/go_selected_unequip")
	self._gounselectunequip = gohelper.findChild(self.viewGO, "go_info/go_unselect_unequip")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "go_info/btn_click")
	self._txtsekectedequip = gohelper.findChildText(self.viewGO, "go_info/go_selected_equip/txt_title")
	self._txtunselectequip = gohelper.findChildText(self.viewGO, "go_info/go_unselect_equip/txt_title")
	self._txtselectedunequip = gohelper.findChildText(self.viewGO, "go_info/go_selected_unequip/txt_title")
	self._txtunselectunequip = gohelper.findChildText(self.viewGO, "go_info/go_unselect_unequip/txt_title")
	self._txtsekectedequipen = gohelper.findChildText(self.viewGO, "go_info/go_selected_equip/en")
	self._txtunselectequipen = gohelper.findChildText(self.viewGO, "go_info/go_unselect_equip/en")
	self._txtselectedunequipen = gohelper.findChildText(self.viewGO, "go_info/go_selected_unequip/en")
	self._txtunselectunequipen = gohelper.findChildText(self.viewGO, "go_info/go_unselect_unequip/en")
	self._golater = gohelper.findChild(self.viewGO, "go_later")
	self._goequipedeffect = gohelper.findChild(self.viewGO, "go_info/go_selected_equip/click")
	self._goreddot = gohelper.findChild(self.viewGO, "go_info/go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDLCSelectListItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeDLCSelectListItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function RougeDLCSelectListItem:_btnclickOnClick()
	RougeDLCSelectListModel.instance:selectCell(self._index)
end

function RougeDLCSelectListItem:_editableInitView()
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.OnSelectDLC, self._onSelectDLC, self)
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.OnGetVersionInfo, self._onGetVersionInfo, self)
end

function RougeDLCSelectListItem:onUpdateMO(mo, mixType, param)
	self._mo = mo

	self:refreshUI()
end

function RougeDLCSelectListItem:refreshUI()
	self._txtsekectedequip.text = self._mo.name
	self._txtunselectequip.text = self._mo.name
	self._txtselectedunequip.text = self._mo.name
	self._txtunselectunequip.text = self._mo.name
	self._txtsekectedequipen.text = self._mo.enName
	self._txtunselectequipen.text = self._mo.enName
	self._txtselectedunequipen.text = self._mo.enName
	self._txtunselectunequipen.text = self._mo.enName

	local curSelectCell = RougeDLCSelectListModel.instance:getCurSelectIndex()

	self._isSelect = curSelectCell == self._index
	self._isEquiped = RougeDLCSelectListModel.instance:isAddDLC(self._mo.id)

	self:setSelectUI()
	self:setLaterFlagVisible()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RougeDLCNew, self._mo.id)
end

function RougeDLCSelectListItem:_onSelectDLC(versionId)
	if self._mo then
		local isSelect = self._mo.id == versionId
		local isNeedUpdate = isSelect or self._isSelect

		self._isSelect = isSelect

		if isNeedUpdate then
			self:setSelectUI()
		end
	end
end

function RougeDLCSelectListItem:_onGetVersionInfo()
	self:setSelectUI()
end

function RougeDLCSelectListItem:setSelectUI()
	local isEquiped = RougeDLCSelectListModel.instance:isAddDLC(self._mo.id)

	gohelper.setActive(self._goselectedequip, self._isSelect and isEquiped)
	gohelper.setActive(self._gounselectequip, not self._isSelect and isEquiped)
	gohelper.setActive(self._goselectedunequip, self._isSelect and not isEquiped)
	gohelper.setActive(self._gounselectunequip, not self._isSelect and not isEquiped)
	gohelper.setActive(self._goequipedeffect, self._isEquiped ~= isEquiped and isEquiped)
	self:setTabIcon(self._goselectedequip, true, true)
	self:setTabIcon(self._gounselectequip, false, true)
	self:setTabIcon(self._goselectedunequip, true, false)
	self:setTabIcon(self._gounselectunequip, false, false)

	self._isEquiped = isEquiped

	if self._isSelect then
		RougeOutsideController.instance:saveNewReadDLCInLocal(self._mo.id)
		RougeOutsideController.instance:initDLCReddotInfo()
	end
end

function RougeDLCSelectListItem:setTabIcon(goItem, isSelect, isEquiped)
	local iconImage = gohelper.findChildImage(goItem, "icon")

	if not iconImage then
		return
	end

	local iconImgNameFirstPart = string.format("rouge_dlc%s_leftlogo", self._mo.id)
	local iconImageNameLastPart = ""

	iconImageNameLastPart = isSelect and (isEquiped and "1" or "2") or isEquiped and "2" or "3"

	local iconImgName = iconImgNameFirstPart .. iconImageNameLastPart

	UISpriteSetMgr.instance:setRouge4Sprite(iconImage, iconImgName)
end

function RougeDLCSelectListItem:setLaterFlagVisible()
	gohelper.setActive(self._golater, false)
end

function RougeDLCSelectListItem:onDestroyView()
	return
end

return RougeDLCSelectListItem
