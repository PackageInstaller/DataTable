-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerAttributeActiveItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerAttributeActiveItem", package.seeall)

local Rouge2_CareerAttributeActiveItem = class("Rouge2_CareerAttributeActiveItem", LuaCompBase)

function Rouge2_CareerAttributeActiveItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._imageRare = gohelper.findChildImage(self.go, "#go_Root/#image_Rare")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "#go_Root/#simage_Icon")
	self._txtNum1 = gohelper.findChildText(self.go, "#go_Root/#txt_Num1")
	self._txtNum2 = gohelper.findChildText(self.go, "#go_Root/#txt_Num2")
end

function Rouge2_CareerAttributeActiveItem:onUpdateMO(curAttrValue, relicsInfo)
	local relicsCo = relicsInfo.config
	local relicsId = relicsCo and relicsCo.id

	self._txtNum1.text = curAttrValue
	self._txtNum2.text = relicsInfo.attrValue

	Rouge2_IconHelper.setItemIconAndRare(relicsId, self._simageIcon, self._imageRare)
end

function Rouge2_CareerAttributeActiveItem:onDestroy()
	self._simageIcon:UnLoadImage()
end

return Rouge2_CareerAttributeActiveItem
