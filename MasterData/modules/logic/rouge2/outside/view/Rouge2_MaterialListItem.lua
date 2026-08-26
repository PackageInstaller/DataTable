-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_MaterialListItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_MaterialListItem", package.seeall)

local Rouge2_MaterialListItem = class("Rouge2_MaterialListItem", ListScrollCellExtend)

function Rouge2_MaterialListItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gonew = gohelper.findChild(self.viewGO, "#go_normal/go_new")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_bg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#image_collection")
	self._imagecollection = gohelper.findChildImage(self.viewGO, "#go_normal/#image_collection")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._imagelockedRare = gohelper.findChildImage(self.viewGO, "#go_locked")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._godlctag = gohelper.findChild(self.viewGO, "#go_dlctag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MaterialListItem:addEvents()
	return
end

function Rouge2_MaterialListItem:removeEvents()
	return
end

function Rouge2_MaterialListItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.UI_Common_Click)
	self._color = self._imagecollection.color
	self._orderColor = self._txtnum.color

	gohelper.setActive(self._simagecollection.gameObject, true)
end

function Rouge2_MaterialListItem:_editableAddEvents()
	self._click:AddClickListener(self._onClickItem, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClickMaterialListItem, self._onClickCollectionListItem, self)
end

function Rouge2_MaterialListItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function Rouge2_MaterialListItem:_onClickItem()
	Rouge2_MaterialListModel.instance:setSelectedConfig(self._mo)
end

function Rouge2_MaterialListItem:_onClickCollectionListItem()
	self:_updateSelected()
end

function Rouge2_MaterialListItem:_updateSelected()
	local selectedConfig = Rouge2_MaterialListModel.instance:getSelectedConfig()

	gohelper.setActive(self._goselected, selectedConfig and selectedConfig == self._mo)
end

function Rouge2_MaterialListItem:onUpdateMO(mo)
	self._mo = mo

	local isShow = mo ~= nil

	gohelper.setActive(self.viewGO, isShow)

	if not isShow then
		return
	end

	local isUnlock = true

	self._orderColor.a = 0.7
	self._txtnum.color = self._orderColor

	local num = Rouge2_AlchemyModel.instance:getMaterialNum(mo.id)

	self._txtnum.text = tonumber(num)

	local config = Rouge2_OutSideConfig.instance:getMaterialConfig(mo.id)
	local rare = config.rare

	Rouge2_IconHelper.setMaterialRareBg(rare, self._imagebg)
	Rouge2_IconHelper.setMaterialRareBg(rare, self._imagelockedRare)
	gohelper.setActive(self._gonormal, isUnlock)
	gohelper.setActive(self._golocked, not isUnlock)
	self:_updateSelected()
	Rouge2_IconHelper.setMaterialIcon(mo.id, self._simagecollection)
	self:_updateNewFlag()
end

function Rouge2_MaterialListItem:_updateNewFlag()
	return
end

function Rouge2_MaterialListItem:onSelect(isSelect)
	return
end

function Rouge2_MaterialListItem:onDestroyView()
	return
end

return Rouge2_MaterialListItem
