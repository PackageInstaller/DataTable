-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsTabItem.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsTabItem", package.seeall)

local DecorateMultiGoodsTipsTabItem = class("DecorateMultiGoodsTipsTabItem", LuaCompBase)

function DecorateMultiGoodsTipsTabItem:init(go)
	self.go = go
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._txtName = gohelper.findChildText(self.go, "txt_Name")
	self._txtName2 = gohelper.findChildText(self.go, "go_Select/txt_Name2")
	self._btnClik = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._goDiscount = gohelper.findChild(self.go, "go_Discount")
	self._txtDiscount = gohelper.findChildText(self.go, "go_Discount/txt_Discount")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._isSelect = false
end

function DecorateMultiGoodsTipsTabItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function DecorateMultiGoodsTipsTabItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function DecorateMultiGoodsTipsTabItem:_btnClickOnClick()
	if not self._goodsId or self._isSelect then
		return
	end

	StoreController.instance:dispatchEvent(StoreEvent.OnSelectDecorateMultiGoods, self._goodsId)
end

function DecorateMultiGoodsTipsTabItem:onUpdateMO(goodsId, index, isSelect)
	self._goodsId = goodsId
	self._index = index
	self._isSelect = isSelect
	self._goodsCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._offTag = self._goodsCo and self._goodsCo.offTag

	self:refreshUI()
end

function DecorateMultiGoodsTipsTabItem:refreshUI()
	self._txtName.text = self._goodsCo and self._goodsCo.typeName
	self._txtName2.text = self._goodsCo and self._goodsCo.typeName

	if self._offTag then
		local hasOffTag = self._offTag > 0

		if hasOffTag then
			self._txtDiscount.text = string.format("-%s%%", self._offTag)
		end

		gohelper.setActive(self._goDiscount, hasOffTag)
		gohelper.setActive(self._goSelect, self._isSelect)
	end
end

return DecorateMultiGoodsTipsTabItem
