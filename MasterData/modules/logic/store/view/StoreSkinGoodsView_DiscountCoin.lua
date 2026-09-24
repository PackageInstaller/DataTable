-- chunkname: @modules/logic/store/view/StoreSkinGoodsView_DiscountCoin.lua

module("modules.logic.store.view.StoreSkinGoodsView_DiscountCoin", package.seeall)

local StoreSkinGoodsView_DiscountCoin = class("StoreSkinGoodsView_DiscountCoin", StoreSkinGoodsView_DiscountImpl)

function StoreSkinGoodsView_DiscountCoin:onInitView()
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#txt_discount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView_DiscountCoin:addEvents()
	return
end

function StoreSkinGoodsView_DiscountCoin:removeEvents()
	return
end

function StoreSkinGoodsView_DiscountCoin.s_create(Self, srcGo, baseViewContainer)
	return DecoratorSimpleItemBase.s_create(StoreSkinGoodsView_DiscountCoin, Self, srcGo, baseViewContainer)
end

function StoreSkinGoodsView_DiscountCoin.s_createByView(Self, srcGo)
	return DecoratorSimpleItemBase.s_createByView(StoreSkinGoodsView_DiscountCoin, Self, srcGo)
end

function StoreSkinGoodsView_DiscountCoin.s_createByListScrollCellExtend(Self, srcGo)
	return DecoratorSimpleItemBase.s_createByListScrollCellExtend(StoreSkinGoodsView_DiscountCoin, Self, srcGo)
end

function StoreSkinGoodsView_DiscountCoin:ctor(...)
	StoreSkinGoodsView_DiscountCoin.super.ctor(self, ...)
end

function StoreSkinGoodsView_DiscountCoin:onDestroyView()
	StoreSkinGoodsView_DiscountCoin.super.onDestroyView(self)
end

function StoreSkinGoodsView_DiscountCoin:_editableInitView()
	StoreSkinGoodsView_DiscountCoin.super._editableInitView(self)

	self._go_icon_1 = gohelper.findChild(self.viewGO, "go_icon_1")
	self._go_icon_2 = gohelper.findChild(self.viewGO, "go_icon_2")

	self:setActive_icon1(false)
	self:setActive_icon2(true)
end

function StoreSkinGoodsView_DiscountCoin:setActive_icon1(bActive)
	gohelper.setActive(self._go_icon_1, bActive)
end

function StoreSkinGoodsView_DiscountCoin:setActive_icon2(bActive)
	gohelper.setActive(self._go_icon_2, bActive)
end

return StoreSkinGoodsView_DiscountCoin
