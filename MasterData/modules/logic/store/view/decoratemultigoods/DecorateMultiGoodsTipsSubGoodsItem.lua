-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsSubGoodsItem.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsSubGoodsItem", package.seeall)

local DecorateMultiGoodsTipsSubGoodsItem = class("DecorateMultiGoodsTipsSubGoodsItem", LuaCompBase)

function DecorateMultiGoodsTipsSubGoodsItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateMultiGoodsTipsSubGoodsItem)
end

function DecorateMultiGoodsTipsSubGoodsItem:init(go)
	self.go = go
	self._goPrice = gohelper.findChild(self.go, "go_Price")
	self._goFinish = gohelper.findChild(self.go, "go_Finish")
	self._txtGold = gohelper.findChildText(self.go, "go_Price/txt_Gold")
	self._imageGold = gohelper.findChildImage(self.go, "go_Price/image_Gold")
	self._txtName = gohelper.findChildText(self.go, "txt_Name")
	self._txtNum = gohelper.findChildText(self.go, "txt_Num")
	self._goBg = gohelper.findChild(self.go, "go_Bg")
	self._txtOwner = gohelper.findChildText(self.go, "go_finish/txt_Owner")
end

function DecorateMultiGoodsTipsSubGoodsItem:addEventListeners()
	return
end

function DecorateMultiGoodsTipsSubGoodsItem:removeEventListeners()
	return
end

function DecorateMultiGoodsTipsSubGoodsItem:onUpdateMO(decorateCo, itemInfo, selectCostIndex, index)
	self._decorateCo = decorateCo
	self._itemType = itemInfo and itemInfo[1]
	self._itemId = itemInfo and itemInfo[2]
	self._itemNum = itemInfo and itemInfo[3]
	self._index = index
	self._itemCo = ItemModel.instance:getItemConfig(self._itemType, self._itemId)
	self._goodsMo = self:_getGoodsMoByItemId()
	self._selectCostIndex = selectCostIndex

	self:refreshUI()
end

function DecorateMultiGoodsTipsSubGoodsItem:refreshUI()
	self._txtName.text = self._itemCo and self._itemCo.name

	local quantity = ItemModel.instance:getItemQuantity(self._itemType, self._itemId)

	self._txtNum.text = string.format("%s/%s", quantity, self._itemNum)

	if self._goodsMo then
		local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._decorateCo.id)
		local cost1, cost2 = self._goodsMo:getAllCostInfo()

		if self._selectCostIndex == 1 and cost1 then
			if not cost1[1] then
				if cost2 then
					::label_6_0::

					local cost = cost2[1]

					if cost then
						if not cost[3] then
							local _costNum = 0

							_costNum = has and discount and _costNum * discount * 0.001 or _costNum
							self._txtGold.text = _costNum * (1 - self._decorateCo.offTag * 0.01)

							local str = DecorateMultiGoodsTipsPayItem._getCostIcon(cost)

							UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageGold, str)
						end
					end
				end
			end
		end
	end

	gohelper.setActive(self._goPrice, self._goodsMo ~= nil)
end

function DecorateMultiGoodsTipsSubGoodsItem:_getGoodsMoByItemId()
	local storeMo = StoreModel.instance:getStoreMO(self._decorateCo.storeld)

	if storeMo and storeMo:getGoodsList() then
		for _, mo in pairs(storeMo:getGoodsList()) do
			if not string.nilorempty(mo.config.product) then
				local productArr = GameUtil.splitString2(mo.config.product, true)

				for _, _product in pairs(productArr) do
					if self._itemType == _product[1] and self._itemId == _product[2] then
						return mo
					end
				end
			end
		end
	end
end

function DecorateMultiGoodsTipsSubGoodsItem:onDestory()
	return
end

return DecorateMultiGoodsTipsSubGoodsItem
