-- chunkname: @modules/logic/store/view/StoreSkinGoodsView_DiscountImpl.lua

module("modules.logic.store.view.StoreSkinGoodsView_DiscountImpl", package.seeall)

local StoreSkinGoodsView_DiscountImpl = class("StoreSkinGoodsView_DiscountImpl", RougeSimpleItemBase)

function StoreSkinGoodsView_DiscountImpl:ctor(...)
	StoreSkinGoodsView_DiscountImpl.super.ctor(self, ...)
end

function StoreSkinGoodsView_DiscountImpl:onDestroyView()
	StoreSkinGoodsView_DiscountImpl.super.onDestroyView(self)
end

function StoreSkinGoodsView_DiscountImpl:_editableInitView()
	StoreSkinGoodsView_DiscountImpl.super._editableInitView(self)

	self._txtdiscount.text = ""
end

function StoreSkinGoodsView_DiscountImpl:setDiscountStr(str)
	self._txtdiscount.text = str
end

return StoreSkinGoodsView_DiscountImpl
