-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyListItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyListItem", package.seeall)

local Rouge2_AlchemyListItem = class("Rouge2_AlchemyListItem", ListScrollCellExtend)

function Rouge2_AlchemyListItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_icon")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._godlctag = gohelper.findChild(self.viewGO, "#go_dlctag")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemyListItem:_editableInitView()
	return
end

function Rouge2_AlchemyListItem:addEvents()
	self._btnclick:AddClickListener(self._onClickItem, self)
end

function Rouge2_AlchemyListItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Rouge2_AlchemyListItem:_onClickItem()
	if self.type == Rouge2_OutsideEnum.AlchemyItemType.Formula then
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onClickAlchemyFormula, (not self.isSelect or nil) and (self.itemId or nil))
	elseif self.type == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial then
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onClickAlchemySubMaterial, self.itemId)
	end
end

function Rouge2_AlchemyListItem:_editableRemoveEvents()
	return
end

function Rouge2_AlchemyListItem:onSelect(isSelect)
	self.isSelect = isSelect

	gohelper.setActive(self._goselected, isSelect)
end

function Rouge2_AlchemyListItem:onUpdateMO(mo)
	self.mo = mo
	self.id = mo.id
	self.itemId = mo.itemId
	self.type = mo.type

	self:refreshUI()
end

function Rouge2_AlchemyListItem:refreshUI()
	local id = self.itemId

	gohelper.setActive(self._txtnum, self.type == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial)

	if self.type == Rouge2_OutsideEnum.AlchemyItemType.Formula then
		local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(id)

		Rouge2_IconHelper.setFormulaIcon(id, self._simageicon)
		Rouge2_IconHelper.setAlchemyRareBg(formulaConfig.rare, self._imagebg)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnFormulaItemRefreshFinish, self.id)
	elseif self.type == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial then
		local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(id)

		Rouge2_IconHelper.setMaterialIcon(id, self._simageicon)

		local rare = materialConfig.rare

		Rouge2_IconHelper.setMaterialRareBg(rare, self._imagebg)

		local count = Rouge2_AlchemyModel.instance:getMaterialNum(id) or 0

		self._txtnum.text = tostring(count)

		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnMaterialItemRefreshFinish, self.id)
	end
end

function Rouge2_AlchemyListItem:onDestroyView()
	return
end

return Rouge2_AlchemyListItem
