-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttrDetailAttrTabItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttrDetailAttrTabItem", package.seeall)

local Rouge2_AttrDetailAttrTabItem = class("Rouge2_AttrDetailAttrTabItem", Rouge2_AttrDetailBaseTabItem)

function Rouge2_AttrDetailAttrTabItem:init(go)
	Rouge2_AttrDetailAttrTabItem.super.init(self, go)

	self._imageSelectIcon = gohelper.findChildImage(self.go, "go_Root/go_Select/image_Icon")
	self._txtSelectName = gohelper.findChildText(self.go, "go_Root/go_Select/txt_Name")
	self._txtSelectSpLevel = gohelper.findChildText(self.go, "go_Root/go_Select/txt_SpLevel")
	self._imageUnselectIcon = gohelper.findChildImage(self.go, "go_Root/go_Unselect/image_Icon")
	self._txtUnselectName = gohelper.findChildText(self.go, "go_Root/go_Unselect/txt_Name")
	self._txtUnselectSpLevel = gohelper.findChildText(self.go, "go_Root/go_Unselect/txt_SpLevel")
end

function Rouge2_AttrDetailAttrTabItem:addEventListeners()
	Rouge2_AttrDetailAttrTabItem.super.addEventListeners(self)
end

function Rouge2_AttrDetailAttrTabItem:removeEventListeners()
	Rouge2_AttrDetailAttrTabItem.super.removeEventListeners(self)
end

function Rouge2_AttrDetailAttrTabItem:refreshUI()
	if self._attrCo then
		self._attrName = self._attrCo.name or ""
	end

	local tabTitle = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_attributedetailview_attrtabitem"), self._attrName, self._attrValue)

	self._txtSelectName.text = tabTitle
	self._txtUnselectName.text = tabTitle

	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageSelectIcon, Rouge2_Enum.AttrIconSuffix.Big)
	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageUnselectIcon, Rouge2_Enum.AttrIconSuffix.Big)
	Rouge2_AttrDropDescHelper.loadAttrDropLevelList(self._careerId, self._attrId, self._txtSelectSpLevel, false)
	Rouge2_AttrDropDescHelper.loadAttrDropLevelList(self._careerId, self._attrId, self._txtUnselectSpLevel, false)
end

function Rouge2_AttrDetailAttrTabItem:onUpdateMO(careerId, groupIndex, index, parentView, attrInfo)
	self._attrInfo = attrInfo

	if attrInfo then
		self._attrId = attrInfo.attrId or 0
	end

	if attrInfo then
		self._attrValue = attrInfo.value or 0
	end

	self._attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)

	Rouge2_AttrDetailAttrTabItem.super.onUpdateMO(self, careerId, groupIndex, index, parentView, attrInfo)
end

return Rouge2_AttrDetailAttrTabItem
