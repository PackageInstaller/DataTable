-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultCollectionListItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultCollectionListItem", package.seeall)

local Rouge2_ResultCollectionListItem = class("Rouge2_ResultCollectionListItem", ListScrollCellExtend)

function Rouge2_ResultCollectionListItem:onInitView()
	self._imagebg = gohelper.findChildImage(self.viewGO, "#image_bg")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#image_collection")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultCollectionListItem:addEvents()
	return
end

function Rouge2_ResultCollectionListItem:removeEvents()
	return
end

function Rouge2_ResultCollectionListItem:_editableInitView()
	return
end

function Rouge2_ResultCollectionListItem:_editableAddEvents()
	return
end

function Rouge2_ResultCollectionListItem:_editableRemoveEvents()
	return
end

function Rouge2_ResultCollectionListItem:onUpdateMO(mo)
	self._id = mo.id
	self._itemId = mo.itemId
	self._mo = mo
	self._type = mo.type

	self:refreshUI()
end

function Rouge2_ResultCollectionListItem:refreshUI()
	local itemId = self._itemId

	if self._type == Rouge2_OutsideEnum.CollectionType.Collection then
		Rouge2_IconHelper.setRelicsIcon(itemId, self._simagecollection)

		local itemConfig = Rouge2_OutSideConfig.getItemConfig(itemId)

		if not itemConfig.rare then
			local rare = 1

			Rouge2_IconHelper.setAlchemyRareBg(rare, self._imagebg)
		end
	elseif self._type == Rouge2_OutsideEnum.CollectionType.Material then
		local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(itemId)

		Rouge2_IconHelper.setMaterialIcon(itemId, self._simagecollection)

		if not materialConfig.rare then
			local rare = 1

			Rouge2_IconHelper.setAlchemyRareBg(rare, self._imagebg)
		end
	end
end

function Rouge2_ResultCollectionListItem:onSelect(isSelect)
	return
end

function Rouge2_ResultCollectionListItem:onDestroyView()
	return
end

return Rouge2_ResultCollectionListItem
