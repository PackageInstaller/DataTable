-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEnchantBagItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnchantBagItem", package.seeall)

local V1a6_CachotEnchantBagItem = class("V1a6_CachotEnchantBagItem", ListScrollCellExtend)

function V1a6_CachotEnchantBagItem:onInitView()
	self._goscale = gohelper.findChild(self.viewGO, "#go_scale")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotEnchantBagItem:addEvents()
	return
end

function V1a6_CachotEnchantBagItem:removeEvents()
	return
end

function V1a6_CachotEnchantBagItem:_editableInitView()
	return
end

function V1a6_CachotEnchantBagItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function V1a6_CachotEnchantBagItem:refreshUI()
	local bagItem = self:getOrCreateCollectionItem()

	if bagItem then
		bagItem:onUpdateMO(self._mo)
	end
end

function V1a6_CachotEnchantBagItem:getOrCreateCollectionItem()
	if not self._bagItem then
		local resPath = self._view.viewContainer._viewSetting.otherRes[1]
		local collectionGO = self._view:getResInst(resPath, self._goscale, "collectionitem")

		self._bagItem = MonoHelper.addNoUpdateLuaComOnceToGo(collectionGO, V1a6_CachotCollectionBagItem)

		self._bagItem:setClickCallBack(self.clikCallBack, self)
	end

	return self._bagItem
end

function V1a6_CachotEnchantBagItem:clikCallBack()
	V1a6_CachotCollectionEnchantController.instance:onSelectBagItem(self._index)
end

function V1a6_CachotEnchantBagItem:onSelect(isSelect)
	if self._bagItem then
		self._bagItem:onSelect(isSelect)
	end
end

function V1a6_CachotEnchantBagItem:onDestroyView()
	if self._bagItem then
		self._bagItem:onDestroyView()

		self._bagItem = nil
	end
end

return V1a6_CachotEnchantBagItem
