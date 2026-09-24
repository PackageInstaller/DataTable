-- chunkname: @modules/logic/store/view/decorate/DecorateStoreGoodTabCompItem.lua

module("modules.logic.store.view.decorate.DecorateStoreGoodTabCompItem", package.seeall)

local DecorateStoreGoodTabCompItem = class("DecorateStoreGoodTabCompItem", SimpleListItem)

function DecorateStoreGoodTabCompItem:onInit(viewGO)
	local rectTransform = self.transform

	rectTransform.anchorMin = Vector2.zero
	rectTransform.anchorMax = Vector2.one
	rectTransform.offsetMin = Vector2.zero
	rectTransform.offsetMax = Vector2.zero
	self._gospbg = gohelper.findChild(viewGO, "#go_spbg")
	self._imagerare = gohelper.findChildImage(viewGO, "#image_rare")
	self._goselect = gohelper.findChild(viewGO, "select")
	self._gounselect = gohelper.findChild(viewGO, "unselect")
	self._simageicon = gohelper.findChildSingleImage(viewGO, "#image_icon")

	gohelper.setActive(self._gospbg, false)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gounselect, false)
end

function DecorateStoreGoodTabCompItem:onItemShow(data)
	self._goodId = data.id
	self._goodCo = StoreConfig.instance:getGoodsConfig(self._goodId)
	self._storeId = self._goodCo and tonumber(self._goodCo.storeId) or StoreEnum.StoreId.SpiritualityDecorateStore

	local itemCos = string.splitToNumber(self._goodCo.product, "#")
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemCos[1], itemCos[2], true)

	self._simageicon:LoadImage(itemIcon)
	gohelper.setActive(self._imagerare.gameObject, true)

	if not itemCo.rare then
		UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(ItemEnum.Color[itemCo.rare]))
	end
end

function DecorateStoreGoodTabCompItem:onSelectChange(isSelect)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gounselect, not isSelect)

	local scale = isSelect and 1.16 or 1

	transformhelper.setLocalScale(self.transform, scale, scale, 1)
end

return DecorateStoreGoodTabCompItem
