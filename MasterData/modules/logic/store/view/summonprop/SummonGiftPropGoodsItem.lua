-- chunkname: @modules/logic/store/view/summonprop/SummonGiftPropGoodsItem.lua

module("modules.logic.store.view.summonprop.SummonGiftPropGoodsItem", package.seeall)

local SummonGiftPropGoodsItem = class("SummonGiftPropGoodsItem", ListScrollCellExtend)

function SummonGiftPropGoodsItem:onInitView()
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonGiftPropGoodsItem:addEvents()
	return
end

function SummonGiftPropGoodsItem:removeEvents()
	return
end

function SummonGiftPropGoodsItem:_editableInitView()
	return
end

function SummonGiftPropGoodsItem:_editableAddEvents()
	return
end

function SummonGiftPropGoodsItem:_editableRemoveEvents()
	return
end

function SummonGiftPropGoodsItem:onUpdateMO(mo)
	local isEmpty = mo == nil or mo.goodsMo == nil

	gohelper.setActive(self._gohas, not isEmpty)
	gohelper.setActive(self._goempty, isEmpty)

	if isEmpty then
		return
	end

	self.goodsItem = self.goodsItem or self._view.viewContainer:getGoodsItem(self._gohas)

	self.goodsItem:onUpdateMO(mo.goodsMo)

	local animator = self.goodsItem:getAnimator()

	if animator then
		animator:Play("idel", 0, 0)
	end
end

function SummonGiftPropGoodsItem:setView(view)
	self._view = view
end

function SummonGiftPropGoodsItem:onSelect(isSelect)
	return
end

function SummonGiftPropGoodsItem:onDestroyView()
	return
end

return SummonGiftPropGoodsItem
