-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultUnlockInfoListItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultUnlockInfoListItem", package.seeall)

local Rouge2_ResultUnlockInfoListItem = class("Rouge2_ResultUnlockInfoListItem", LuaCompBase)

function Rouge2_ResultUnlockInfoListItem:init(go)
	self.go = go
	self._imagebg = gohelper.findChildImage(self.go, "#image_bg")
	self._simagecollection = gohelper.findChildSingleImage(self.go, "#simage_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultUnlockInfoListItem:_editableInitView()
	return
end

function Rouge2_ResultUnlockInfoListItem:setInfo(type, itemId)
	self._type = type
	self._itemId = itemId

	self:refreshUI()
end

function Rouge2_ResultUnlockInfoListItem:refreshUI()
	local itemId = self._itemId

	if self._type == Rouge2_OutsideEnum.CollectionType.Collection then
		Rouge2_IconHelper.setItemIcon(itemId, self._simagecollection)

		local config = Rouge2_OutSideConfig.getItemConfig(itemId)

		if not config.rare then
			local rare = 0

			Rouge2_IconHelper.setAlchemyRareBg(rare, self._imagebg)
		end
	elseif self._type == Rouge2_OutsideEnum.CollectionType.Formula then
		Rouge2_IconHelper.setFormulaIcon(itemId, self._simagecollection)

		local config = Rouge2_OutSideConfig.instance:getFormulaConfig(itemId)

		if not config.rare then
			local rare = 0

			Rouge2_IconHelper.setAlchemyRareBg(rare, self._imagebg)
		end
	end
end

function Rouge2_ResultUnlockInfoListItem:onDestroy()
	return
end

return Rouge2_ResultUnlockInfoListItem
