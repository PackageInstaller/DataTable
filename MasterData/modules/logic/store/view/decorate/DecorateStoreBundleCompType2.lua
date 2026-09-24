-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType2.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType2", package.seeall)

local DecorateStoreBundleCompType2 = class("DecorateStoreBundleCompType2", LuaCompBase)

function DecorateStoreBundleCompType2.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleCompType2)
end

function DecorateStoreBundleCompType2:init(go)
	self.go = go
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._simagepackage = gohelper.findChildSingleImage(go, "scroll_products/viewport/content/#simage_package")
	self._gopackageselect = gohelper.findChild(go, "scroll_products/viewport/content/#simage_package/#go_select")
	self._goowned = gohelper.findChild(go, "scroll_products/viewport/content/#simage_package/#go_owned")
	self._godiscountroot = gohelper.findChild(go, "scroll_products/viewport/content/#simage_package/discount")
	self._godiscount2 = gohelper.findChild(self._godiscountroot, "#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self._godiscountroot, "#go_discount2/#txt_discount")
	self._godiscount1 = gohelper.findChild(self._godiscountroot, "#go_discount")
	self._txtdiscount1 = gohelper.findChildText(self._godiscountroot, "#go_discount/#txt_discount")
	self._btnpackageclick = gohelper.findChildButtonWithAudio(go, "scroll_products/viewport/content/#simage_package/#btn_click")
	self._goitem = gohelper.findChild(go, "scroll_products/viewport/content/grid/#go_item")

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreBundleCompType2:_initItem()
	self._subGoodsItem = {}

	gohelper.setActive(self._goitem, false)
end

function DecorateStoreBundleCompType2:_onClickPackage()
	local curGoodsId = DecorateStoreModel.instance:getCurGood(self._storeId)

	if curGoodsId == self._packageGoodId then
		return
	end

	DecorateStoreModel.instance:setCurGood(self._packageGoodId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, self._packageGoodId, true)
	self:_refreshType()
end

function DecorateStoreBundleCompType2:_addEvents()
	self._btnpackageclick:AddClickListener(self._onClickPackage, self)
end

function DecorateStoreBundleCompType2:_removeEvents()
	self._btnpackageclick:RemoveClickListener()
end

function DecorateStoreBundleCompType2:refresh(goodId)
	self._packageGoodId = goodId

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._packageGoodId = decorateConfig.fatherGoods
	end

	local goodCo = StoreConfig.instance:getGoodsConfig(goodId)

	self._storeId = tonumber(goodCo.storeId)
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._packageGoodId)
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._packageGoodId)

	self:_refreshDiscount()
	self:_refreshType()
end

function DecorateStoreBundleCompType2:_refreshDiscount()
	if self._decorateConfig.offTag > 0 then
		if not self._decorateConfig.offTag then
			local discount = 100
			local hasDiscount1 = discount > 0 and discount < 100

			if hasDiscount1 then
				self._txtdiscount1.text = string.format("-%s%%", discount)
			end

			local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._packageGoodId)
			local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._packageGoodId) or 100

			discount2 = discount2 == 0 and 100 or discount2

			local hasDiscount = discount2 > 0 and discount2 < 100

			if hasDiscount then
				self._txtdiscount2.text = string.format("-%s%%", discount2)
			end

			gohelper.setActive(self._godiscount1, hasDiscount1)
			gohelper.setActive(self._godiscount2, hasDiscount)
		end
	end
end

function DecorateStoreBundleCompType2:_refreshType()
	self:_refreshPackage()
	self:_refreshItems()
end

function DecorateStoreBundleCompType2:_refreshPackage()
	self._txtdesc.text = ""

	self._simagepackage:LoadImage(ResUrl.getDecorateStoreImg(self._decorateConfig.smalllmg))

	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	gohelper.setActive(self._gopackageselect, curGoodId == self._packageGoodId)

	local isOwn = DecorateStoreModel.instance:isDecorateGoodItemHas(self._packageGoodId)

	gohelper.setActive(self._goowned, isOwn)
end

function DecorateStoreBundleCompType2:_refreshItems()
	local goods = DecorateStoreModel.instance:getBundleSubGoods(self._packageGoodId)

	if not goods then
		return
	end

	if #self._subGoodsItem > #goods then
		for i = #goods + 1, #self._subGoodsItem do
			gohelper.setActive(self._subGoodsItem[i].go, false)
		end
	end

	for index, goodCo in pairs(goods) do
		if not self._subGoodsItem[index] then
			local go = gohelper.cloneInPlace(self._goitem, goodCo.id)

			self._subGoodsItem[index] = DecorateStoreBundleCompType2Item.Get(go)
		end

		gohelper.setActive(self._subGoodsItem[index].go, true)
		self._subGoodsItem[index]:refresh(goodCo.id, self._storeId)
	end
end

function DecorateStoreBundleCompType2:destroy()
	self._simagepackage:UnLoadImage()
	self:_removeEvents()

	if self._subGoodsItem then
		for _, item in pairs(self._subGoodsItem) do
			item:destroy()
		end

		self._subGoodsItem = nil
	end

	if self.go then
		gohelper.destroy(self.go)
	end
end

return DecorateStoreBundleCompType2
