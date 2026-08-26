-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookTransferCollectionItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookTransferCollectionItem", package.seeall)

local Rouge2_CareerHandBookTransferCollectionItem = class("Rouge2_CareerHandBookTransferCollectionItem", LuaCompBase)

function Rouge2_CareerHandBookTransferCollectionItem:init(go)
	self.go = go
	self._imageeffectIcon = gohelper.findChildImage(self.go, "#image_effectIcon")
	self._txteffectName = gohelper.findChildText(self.go, "#txt_effectName")
	self._txteffectDesc = gohelper.findChildText(self.go, "#txt_effectDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookTransferCollectionItem:_editableInitView()
	self._simageeffectIcon = gohelper.findChildSingleImage(self.go, "#image_effectIcon")
end

function Rouge2_CareerHandBookTransferCollectionItem:setInfo(itemId)
	local config = Rouge2_CollectionConfig.instance:getRelicsConfig(itemId)

	Rouge2_IconHelper.setRelicsIcon(itemId, self._simageeffectIcon)

	self._txteffectName.text = config.name

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, config.id, self._txteffectDesc, Rouge2_Enum.ItemDescMode.Full)
end

function Rouge2_CareerHandBookTransferCollectionItem:onDestroy()
	return
end

return Rouge2_CareerHandBookTransferCollectionItem
