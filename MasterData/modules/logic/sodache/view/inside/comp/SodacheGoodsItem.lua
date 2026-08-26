-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheGoodsItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheGoodsItem", package.seeall)

local SodacheGoodsItem = class("SodacheGoodsItem", LuaCompBase)

function SodacheGoodsItem:ctor(param)
	self.cellParam = param
end

function SodacheGoodsItem:init(go)
	self.parentScroll = go:GetComponentInParent(gohelper.Type_ScrollRect)
	self.parentScroll = self.parentScroll and self.parentScroll.gameObject
	self.imageRare = gohelper.findChildImage(go, "image_Rare")
	self.goCardItem = gohelper.findChild(go, "CardItem")
	self.animCardItem = gohelper.findComponentAnim(self.goCardItem)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.goCardItem, SodacheCardItem)

	self.cardItem:showInfo({
		true,
		true,
		false
	})
	self.cardItem:setNoNeedClick()

	self.txtCost = gohelper.findChildText(go, "txt_Cost")
	self.imageCost = gohelper.findChildImage(go, "txt_Cost/simage_Coin")

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageCost, SodacheUtil.getCurrencyIcon())

	self._golimit = gohelper.findChild(go, "limit")
	self._txtlimit = gohelper.findChildTextMesh(go, "limit/#txt_limit")
	self._gosoldout = gohelper.findChild(go, "go_soldout")
	self._goselect = gohelper.findChild(go, "select")

	local goAdd = gohelper.findChild(go, "btn_Add")

	self._drag = SLFramework.UGUI.UIDragListener.Get(goAdd)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self.clickAdd = gohelper.getClickWithDefaultAudio(goAdd)

	self.clickAdd:AddClickDownListener(self.onClickAddDown, self)
	self.clickAdd:AddClickUpListener(self.onClickAddUp, self)

	self.longPressAdd = SLFramework.UGUI.UILongPressListener.Get(self.clickAdd.gameObject)

	self.longPressAdd:SetLongPressTime({
		0.5,
		0.1
	})
	self.longPressAdd:AddLongPressListener(self.onLongPressAdd, self)

	local goSub = gohelper.findChild(go, "btn_Sub")

	self.clickSub = gohelper.getClickWithDefaultAudio(goSub)

	self.clickSub:AddClickDownListener(self.onClickSubDown, self)
	self.clickSub:AddClickUpListener(self.onClickSubUp, self)

	self.longPressSub = SLFramework.UGUI.UILongPressListener.Get(self.clickSub.gameObject)

	self.longPressSub:SetLongPressTime({
		0.5,
		0.1
	})
	self.longPressSub:AddLongPressListener(self.onLongPressSub, self)
end

function SodacheGoodsItem:addEventListeners()
	SodacheController.instance:registerCallback(SodacheEvent.OnClickGoodsItem, self.refreshCount, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnShopItemUpdate, self.onShopItemUpdate, self)
end

function SodacheGoodsItem:removeEventListeners()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickGoodsItem, self.refreshCount, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnShopItemUpdate, self.onShopItemUpdate, self)
end

function SodacheGoodsItem:updateMo(goodsMo)
	gohelper.setActive(self._golimit, goodsMo.count > 0)
	gohelper.setActive(self._gosoldout, goodsMo.count == 0)

	if goodsMo.count > 0 then
		self._txtlimit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_shopview_limit"), goodsMo.count)
	end

	self.goodsMo = goodsMo

	local fixrate = SodacheUtil.getAttr(SodacheEnum.AttrId.ShopItemPriceFix)

	self.txtCost.text = math.floor(goodsMo.price * (1 + fixrate / 1000))

	self.cardItem:updateMo(goodsMo.items[1])
	self:refreshCount()
end

function SodacheGoodsItem:onShopItemUpdate(updateIds)
	if not updateIds[self.goodsMo.id] then
		return
	end

	self.animCardItem:Play("shop", 0, 0)
end

function SodacheGoodsItem:refreshCount()
	local count = self.cellParam:getGoodSelectCount(self.goodsMo.id)

	self:setIsSelect(count > 0)
	gohelper.setActive(self.clickSub, self.cellParam.isMultSelect and count > 0)
end

function SodacheGoodsItem:setIsSelect(isSelect)
	self.isSelect = isSelect

	gohelper.setActive(self._goselect, self.isSelect)
end

function SodacheGoodsItem:onDestroy()
	self.clickAdd:RemoveClickUpListener()
	self.clickAdd:RemoveClickDownListener()
	self.longPressAdd:RemoveLongPressListener()
	self.clickSub:RemoveClickUpListener()
	self.clickSub:RemoveClickDownListener()
	self.longPressSub:RemoveLongPressListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
end

function SodacheGoodsItem:onClickAddDown()
	self.isLongPress = false
	self.isClickDown = true
end

function SodacheGoodsItem:_onDragBegin(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self.parentScroll, pointerEventData, 4)
end

function SodacheGoodsItem:_onDrag(_, pointerEventData)
	self.isClickDown = false
	self.isDrag = true

	ZProj.UGUIHelper.PassEvent(self.parentScroll, pointerEventData, 5)
end

function SodacheGoodsItem:_onDragEnd(_, pointerEventData)
	self.isDrag = false

	ZProj.UGUIHelper.PassEvent(self.parentScroll, pointerEventData, 6)
end

function SodacheGoodsItem:onClickAddUp()
	if not self.isLongPress and self.isClickDown then
		self:doAddItem()
	end

	self.isClickDown = false
end

function SodacheGoodsItem:onLongPressAdd()
	if not self.cellParam.isMultSelect or self.isDrag then
		return
	end

	self.isLongPress = true

	self:doAddItem()
end

function SodacheGoodsItem:onClickSubDown()
	self.isLongPress = false
end

function SodacheGoodsItem:onClickSubUp()
	if not self.isLongPress then
		self:doSubItem()
	end
end

function SodacheGoodsItem:onLongPressSub()
	self.isLongPress = true

	self:doSubItem()
end

function SodacheGoodsItem:doAddItem()
	self:addItemCount(self.cellParam.isMultSelect and 1 or 0)
end

function SodacheGoodsItem:doSubItem()
	self:addItemCount(-1)
end

function SodacheGoodsItem:addItemCount(count)
	local preCount = self.cellParam:getGoodSelectCount(self.goodsMo.id)

	self.cellParam:addGoodCount(self.goodsMo, count)

	local curCount = self.cellParam:getGoodSelectCount(self.goodsMo.id)

	if preCount == curCount then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
end

return SodacheGoodsItem
