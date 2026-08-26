-- chunkname: @modules/logic/rouge/map/view/store/RougeMapStoreGoodsItem.lua

module("modules.logic.rouge.map.view.store.RougeMapStoreGoodsItem", package.seeall)

local RougeMapStoreGoodsItem = class("RougeMapStoreGoodsItem", UserDataDispose)

function RougeMapStoreGoodsItem:init(go)
	self:__onInit()

	self.go = go

	self:_editableInitView()
end

function RougeMapStoreGoodsItem:_editableInitView()
	self.click = gohelper.findChildClickWithDefaultAudio(self.go, "click")

	self.click:AddClickListener(self.onClickSelf, self)

	self._goenchantlist = gohelper.findChild(self.go, "#go_enchantlist")
	self._gohole = gohelper.findChild(self.go, "#go_enchantlist/#go_hole")
	self.goGridContainer = gohelper.findChild(self.go, "collection/gridbg")
	self.goGridItem = gohelper.findChild(self.go, "collection/gridbg/grid")
	self._gotagitem = gohelper.findChild(self.go, "tags/#go_tagitem")
	self._simagecollection = gohelper.findChildSingleImage(self.go, "collection/#simage_collection")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._godiscount = gohelper.findChild(self.go, "#go_discount")
	self._txtdiscount = gohelper.findChildText(self.go, "#go_discount/#txt_discount")
	self._txtcost = gohelper.findChildText(self.go, "layout/#txt_cost")
	self._txtoriginalprice = gohelper.findChildText(self.go, "layout/#txt_originalprice")
	self._gosoldout = gohelper.findChild(self.go, "#go_soldout")
	self.holeGoList = self:getUserDataTb_()
	self.gridItemList = self:getUserDataTb_()
	self.tagGoList = self:getUserDataTb_()

	gohelper.setActive(self._gotagitem, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onBuyGoods, self.onBuyGoods, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, self.refreshCost, self)
end

function RougeMapStoreGoodsItem:onBuyGoods(pos)
	if self.pos == pos then
		self:refreshSellOut()
	end
end

function RougeMapStoreGoodsItem:onClickSelf()
	logNormal("click self")
	ViewMgr.instance:openView(ViewName.RougeStoreGoodsView, {
		collectionId = self.collectionId,
		pos = self.pos,
		eventMo = self.eventMo,
		price = self.price
	})
end

function RougeMapStoreGoodsItem:update(eventMo, index, goodsMo)
	self.eventMo = eventMo
	self.pos = index
	self.goodsMo = goodsMo
	self.discountRate = self.goodsMo.discountRate
	self.originalPrice = self.goodsMo.originalPrice
	self.price = self.goodsMo.price
	self.collectionId = self.goodsMo.collectionId
	self.hasDiscount = self.discountRate ~= -1 and self.discountRate ~= 1000

	self:show()
	self:refreshHole()
	self:refreshTag()
	self:refreshCollection()
	self:refreshCost()
	self:refreshSellOut()
	self:refreshDiscount()
end

function RougeMapStoreGoodsItem:refreshHole()
	local hole = RougeCollectionConfig.instance:getCollectionHoleNum(self.collectionId) or 0

	if hole < 1 then
		gohelper.setActive(self._goenchantlist, false)

		return
	end

	for i = 2, hole do
		local go = self.holeGoList[i]

		if not go then
			go = gohelper.cloneInPlace(self._gohole)

			table.insert(self.holeGoList, go)
		end

		gohelper.setActive(go, true)
	end

	for i = hole + 1, #self.holeGoList do
		gohelper.setActive(self.holeGoList[i], false)
	end
end

function RougeMapStoreGoodsItem:refreshTag()
	RougeCollectionHelper.loadTags(self.collectionId, self._gotagitem, self.tagGoList)
end

function RougeMapStoreGoodsItem:refreshCollection()
	local url = RougeCollectionHelper.getCollectionIconUrl(self.collectionId)

	if url then
		self._simagecollection:LoadImage(url)
	end

	self._txtname.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	RougeCollectionHelper.loadShapeGrid(self.collectionId, self.goGridContainer, self.goGridItem, self.gridItemList)
end

function RougeMapStoreGoodsItem:refreshCost()
	local curCoin = RougeModel.instance:getRougeInfo().coin
	local coin

	self._txtcost.text = curCoin < self.price and string.format("<color=#EC6363>%s</color>", self.price) or self.price

	gohelper.setActive(self._txtoriginalprice.gameObject, self.hasDiscount)

	if self.hasDiscount then
		self._txtoriginalprice.text = self.originalPrice
	end
end

function RougeMapStoreGoodsItem:refreshSellOut()
	gohelper.setActive(self._gosoldout, self.eventMo:checkIsSellOut(self.pos))
end

function RougeMapStoreGoodsItem:refreshDiscount()
	gohelper.setActive(self._godiscount, self.hasDiscount)

	if self.hasDiscount then
		self._txtdiscount.text = string.format("%+d%%", (self.discountRate - 1000) / 10)
	end
end

function RougeMapStoreGoodsItem:show()
	gohelper.setActive(self.go, true)
end

function RougeMapStoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeMapStoreGoodsItem:destroy()
	self._simagecollection:UnLoadImage()
	self.click:RemoveClickListener()
	self:__onDispose()
end

return RougeMapStoreGoodsItem
