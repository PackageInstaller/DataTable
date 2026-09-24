-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType2Item.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType2Item", package.seeall)

local DecorateStoreBundleCompType2Item = class("DecorateStoreBundleCompType2Item", LuaCompBase)

function DecorateStoreBundleCompType2Item.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleCompType2Item)
end

function DecorateStoreBundleCompType2Item:init(go)
	self.go = go
	self._imagequality = gohelper.findChildImage(self.go, "#image_quaility")
	self._simageicon = gohelper.findChildSingleImage(self.go, "#simage_icon")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._goowned = gohelper.findChild(self.go, "#go_owned")
	self._btnClick = gohelper.getClickWithDefaultAudio(self.go)

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreBundleCompType2Item:_initItem()
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goowned, false)
end

function DecorateStoreBundleCompType2Item:_addEvents()
	self._btnClick:AddClickListener(self._onItemClick, self)
end

function DecorateStoreBundleCompType2Item:_removeEvents()
	self._btnClick:RemoveClickListener()
end

function DecorateStoreBundleCompType2Item:_onItemClick()
	DecorateStoreModel.instance:setCurGood(self._goodId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, self._goodId, true)
end

function DecorateStoreBundleCompType2Item:refresh(goodId)
	self._goodId = goodId
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodId)
	self._goodCo = StoreConfig.instance:getGoodsConfig(self._goodId)
	self._storeId = tonumber(self._goodCo.storeId)

	if self._decorateConfig and not self._goodCo then
		logError("please check store_decorate goodId:" .. self._goodId .. " not found in store_goods!")

		return
	end

	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	gohelper.setActive(self._goselect, curGoodId == self._goodId)

	local isOwn = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodId)

	gohelper.setActive(self._goowned, isOwn)

	local itemCos = string.splitToNumber(self._goodCo.product, "#")
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemCos[1], itemCos[2])

	self._simageicon:LoadImage(itemIcon)

	if not itemCo.rare then
		UISpriteSetMgr.instance:setCommonSprite(self._imagequality, "bgequip" .. tostring(ItemEnum.Color[itemCo.rare]))
	end
end

function DecorateStoreBundleCompType2Item:destroy()
	self._simageicon:UnLoadImage()
	self:_removeEvents()
end

return DecorateStoreBundleCompType2Item
