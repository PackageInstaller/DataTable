-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopGiftView.lua

module("logic.extensions.shop.view.ShopGiftView", package.seeall)

local ShopGiftView = class("ShopGiftView", TableViewComponent)

function ShopGiftView:_getPath()
	return {
		cellPath = "CellGift",
		viewPath = "ScrollView"
	}
end

function ShopGiftView:ctor()
	ShopGiftView.super.ctor(self)
end

function ShopGiftView:bindEvents()
	return
end

function ShopGiftView:unbindEvents()
	return
end

function ShopGiftView:buildUI()
	ShopGiftView.super.buildUI(self)
end

function ShopGiftView:destroyUI()
	return
end

function ShopGiftView:onEnter()
	ShopGiftView.super.onEnter(self)

	self._isFirstLoadData = true

	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._refresh, self)
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._refresh, self)
	self:_refresh()
end

function ShopGiftView:onEnterFinished()
	return
end

function ShopGiftView:onExit()
	ShopGiftView.super.onExit(self)

	self._isFirstLoadData = false

	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._refresh, self)
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._refresh, self)

	self._curViewDatas = nil
	self._lineBgList = {}
end

function ShopGiftView:onExitFinished()
	return
end

function ShopGiftView:_onClickCloseTip()
	return
end

function ShopGiftView:_cellSize()
	return 215, 225
end

function ShopGiftView:_updateCell(view, cell, data)
	local comp = ShopGiftItem.AddOnce(cell.gameObject)

	comp:init(data, self)

	return cell
end

function ShopGiftView:_refresh()
	self._curViewDatas = ShopModel.instance:getGifts()

	self._tableview:ReloadData()
end

function ShopGiftView:_clearTableview(cell)
	return
end

function ShopGiftView:_onClickClose()
	return
end

function ShopGiftView:_onReloadFinish()
	if self._isFirstLoadData then
		self._isFirstLoadData = false

		self._tableview:SetOffsetWithoutRefresh(0)
		self:reloadData()
	end
end

return ShopGiftView
