-- chunkname: @modules/logic/store/view/StoreSkinGoodsView_DiscountRmb.lua

module("modules.logic.store.view.StoreSkinGoodsView_DiscountRmb", package.seeall)

local StoreSkinGoodsView_DiscountRmb = class("StoreSkinGoodsView_DiscountRmb", StoreSkinGoodsView_DiscountImpl)

function StoreSkinGoodsView_DiscountRmb:onInitView()
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#txt_discount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView_DiscountRmb:addEvents()
	return
end

function StoreSkinGoodsView_DiscountRmb:removeEvents()
	return
end

function StoreSkinGoodsView_DiscountRmb.s_create(Self, srcGo, baseViewContainer)
	return DecoratorSimpleItemBase.s_create(StoreSkinGoodsView_DiscountRmb, Self, srcGo, baseViewContainer)
end

function StoreSkinGoodsView_DiscountRmb.s_createByView(Self, srcGo)
	return DecoratorSimpleItemBase.s_createByView(StoreSkinGoodsView_DiscountRmb, Self, srcGo)
end

function StoreSkinGoodsView_DiscountRmb.s_createByListScrollCellExtend(Self, srcGo)
	return DecoratorSimpleItemBase.s_createByListScrollCellExtend(StoreSkinGoodsView_DiscountRmb, Self, srcGo)
end

function StoreSkinGoodsView_DiscountRmb:ctor(...)
	StoreSkinGoodsView_DiscountRmb.super.ctor(self, ...)
end

function StoreSkinGoodsView_DiscountRmb:onDestroyView()
	StoreSkinGoodsView_DiscountRmb.super.onDestroyView(self)
end

function StoreSkinGoodsView_DiscountRmb:_editableInitView()
	StoreSkinGoodsView_DiscountRmb.super._editableInitView(self)
end

return StoreSkinGoodsView_DiscountRmb
