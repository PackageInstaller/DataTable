-- chunkname: @modules/logic/box/equiplvup/view/EquipLvUpChooseItem.lua

module("modules.logic.box.equiplvup.view.EquipLvUpChooseItem", package.seeall)

local EquipLvUpChooseItem = class("EquipLvUpChooseItem", ListScrollCellExtend)

function EquipLvUpChooseItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "mask/#simage_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "mask/#simage_icon")
	self._golevel = gohelper.findChild(self.viewGO, "layout/#go_level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#image_rare")
	self._goclick = gohelper.findChild(self.viewGO, "go_click")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._goMask = gohelper.findChild(self.viewGO, "go_mask")
	self._gorefinecontainer = gohelper.findChild(self.viewGO, "#go_refinecontainer")
	self._txtrefinelv = gohelper.findChildText(self.viewGO, "#go_refinecontainer/#txt_refinelv")
	self._btnClick = gohelper.getClick(self._goclick)
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goclick)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipLvUpChooseItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnLongPress:AddLongPressListener(self._btnLongPressOnClick, self)
end

function EquipLvUpChooseItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function EquipLvUpChooseItem:_btnClickOnClick()
	if self._isMax then
		return
	end

	EquipLvUpModel.instance:onSelectEquip(self._mo.uid)
	EquipLvUpController.instance:dispatchEvent(EquipLvUpEvent.OnSelectEquip)
end

function EquipLvUpChooseItem:_btnLongPressOnClick()
	ViewMgr.instance:openView(ViewName.EquipView, {
		equipMO = self._mo
	})
end

function EquipLvUpChooseItem:_editableInitView()
	gohelper.setActive(self.viewGO, true)
end

function EquipLvUpChooseItem:_editableAddEvents()
	self.addEventCb(self, EquipLvUpController.instance, EquipLvUpEvent.OnSelectEquip, self.refreshSelect, self)
end

function EquipLvUpChooseItem:_editableRemoveEvents()
	self.removeEventCb(self, EquipLvUpController.instance, EquipLvUpEvent.OnSelectEquip, self.refreshSelect, self)
end

function EquipLvUpChooseItem:onUpdateMO(mo, index)
	self._mo = mo
	self._index = index
	self._config = self._mo.config

	local maxLv = EquipConfig.instance:getMaxLevel(self._config)
	local curLv = self._mo.level

	self._isMax = maxLv <= curLv
	self._txtlevel.text = curLv

	local refineLv = self._mo.refineLv

	self._txtrefinelv.text = refineLv >= EquipConfig.instance:getEquipRefineLvMax() and string.format("<color=#e87826>%s</color>", refineLv) or string.format("<color=#E8E7E7>%s</color>", refineLv)

	gohelper.setActive(self._goMask, self._isMax)

	self._imageicon.color = self._isMax and GameUtil.parseColor("#808080") or Color.white

	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. EquipConfig.instance:getRareColor(self._config.rare))
	self._simageicon:LoadImage(ResUrl.getEquipIcon(self._config.icon))
	self:refreshSelect()
end

function EquipLvUpChooseItem:refreshSelect()
	local isSelect = self._mo.uid == EquipLvUpModel.instance:getSelectEquip()

	gohelper.setActive(self._goselect, isSelect)
end

function EquipLvUpChooseItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return EquipLvUpChooseItem
