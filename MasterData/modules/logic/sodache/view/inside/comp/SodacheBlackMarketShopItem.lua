-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheBlackMarketShopItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheBlackMarketShopItem", package.seeall)

local SodacheBlackMarketShopItem = class("SodacheBlackMarketShopItem", LuaCompBase)

function SodacheBlackMarketShopItem:init(go)
	self._golimit = gohelper.findChild(go, "limit")
	self._txtlimit = gohelper.findChildTextMesh(go, "limit/#txt_limit")
	self._txtname = gohelper.findChildTextMesh(go, "name/txt_Name")
	self._goprice = gohelper.findChild(go, "price")
	self._txtprice = gohelper.findChildTextMesh(go, "price/txt_Price")
	self._goselect = gohelper.findChild(go, "go_Select")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self._goitemparent = gohelper.findChild(go, "layout")
	self._goitem = gohelper.findChild(go, "#scroll_card/viewport/content/CardItem")
	self._gosoldout = gohelper.findChild(go, "go_soldout")
end

function SodacheBlackMarketShopItem:addEventListeners()
	self._btnClick:AddClickListener(self._onClickItem, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickGoodsItem, self.refreshCount, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnShopItemUpdate, self.onShopItemUpdate, self)
end

function SodacheBlackMarketShopItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickGoodsItem, self.refreshCount, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnShopItemUpdate, self.onShopItemUpdate, self)
end

function SodacheBlackMarketShopItem:setCellParam(cellParam)
	self.cellParam = cellParam
end

function SodacheBlackMarketShopItem:updateMo(data)
	self.data = data

	gohelper.setActive(self._golimit, false)
	gohelper.setActive(self._gosoldout, false)

	self._txtname.text = data.goodCo.bundleName

	if not string.nilorempty(data.goodCo.bundleDiscount) then
		gohelper.setActive(self._goprice, true)

		self._txtprice.text = data.goodCo.bundleDiscount
	else
		gohelper.setActive(self._goprice, false)
	end

	self:refreshCount()

	if not self._cardAnims then
		self._cardAnims = self:getUserDataTb_()
	else
		tabletool.clear(self._cardAnims)
	end

	gohelper.CreateObjList(self, self._createItem, data.items, self._goitemparent, self._goitem, SodacheCardItem)
end

function SodacheBlackMarketShopItem:onShopItemUpdate(updateIds)
	if not updateIds[self.data.id] then
		return
	end

	for i, anim in ipairs(self._cardAnims) do
		anim:Play("shop", 0, 0)
	end
end

function SodacheBlackMarketShopItem:_createItem(obj, data, index)
	obj:updateMo(data)
	obj:setOverrideClick(self._onClickCardItem, self, data)

	self._cardAnims[index] = gohelper.findComponentAnim(obj.go)
end

function SodacheBlackMarketShopItem:refreshCount()
	gohelper.setActive(self._goselect, self.cellParam:getGoodSelectCount(self.data.id) > 0)
end

function SodacheBlackMarketShopItem:_onClickCardItem(data)
	if self.cellParam:getGoodSelectCount(self.data.id) > 0 then
		ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
			cardMo = data
		})
	else
		self:_onClickItem()
	end
end

function SodacheBlackMarketShopItem:_onClickItem()
	self.cellParam:addGoodCount(self.data, 0)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
end

return SodacheBlackMarketShopItem
