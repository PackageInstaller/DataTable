-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType1Item.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType1Item", package.seeall)

local DecorateStoreBundleCompType1Item = class("DecorateStoreBundleCompType1Item", SimpleListItem)

function DecorateStoreBundleCompType1Item:onInit(viewGO)
	local rectTransform = self.transform

	rectTransform.anchorMin = Vector2.zero
	rectTransform.anchorMax = Vector2.one
	rectTransform.offsetMin = Vector2.zero
	rectTransform.offsetMax = Vector2.zero
	self._simagehero = gohelper.findChildSingleImage(viewGO, "#simage_heroskin")
	self._goselect = gohelper.findChild(viewGO, "#go_select")
	self._goowned = gohelper.findChild(viewGO, "#go_owned")

	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goowned, false)
end

function DecorateStoreBundleCompType1Item:onItemShow(data)
	self._goodId = data.id
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodId)
	self._goodCo = StoreConfig.instance:getGoodsConfig(self._goodId)

	if self._decorateConfig and not self._goodCo then
		logError("please check store_decorate goodId:" .. self._goodId .. " not found in store_goods!")

		return
	end

	local isOwn = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodId)

	gohelper.setActive(self._goowned, isOwn)

	local itemCos = string.splitToNumber(self._goodCo.product, "#")
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemCos[1], itemCos[2], true)

	self._simagehero:LoadImage(itemIcon)
end

function DecorateStoreBundleCompType1Item:onSelectChange(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

return DecorateStoreBundleCompType1Item
