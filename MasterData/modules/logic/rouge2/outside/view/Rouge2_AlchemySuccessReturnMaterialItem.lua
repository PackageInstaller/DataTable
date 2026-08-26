-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemySuccessReturnMaterialItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemySuccessReturnMaterialItem", package.seeall)

local Rouge2_AlchemySuccessReturnMaterialItem = class("Rouge2_AlchemySuccessReturnMaterialItem", LuaCompBase)

function Rouge2_AlchemySuccessReturnMaterialItem:init(go)
	self.go = go
	self._imagebg = gohelper.findChildImage(self.go, "#image_bg")
	self._simagecollection = gohelper.findChildSingleImage(self.go, "#simage_collection")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemySuccessReturnMaterialItem:_editableInitView()
	self._txtNum = gohelper.findChildTextMesh(self.go, "txt_num")
end

function Rouge2_AlchemySuccessReturnMaterialItem:setInfo(data, index)
	Rouge2_IconHelper.setMaterialIcon(data, self._simagecollection)

	local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(data)

	Rouge2_IconHelper.setMaterialRareBg(materialConfig.rare, self._imagebg)

	self._txtNum.text = tostring(Rouge2_OutsideEnum.MaterialReturnNum)
end

function Rouge2_AlchemySuccessReturnMaterialItem:onDestroy()
	return
end

return Rouge2_AlchemySuccessReturnMaterialItem
