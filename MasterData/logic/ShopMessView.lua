-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopMessView.lua

module("logic.extensions.shop.view.ShopMessView", package.seeall)

local ShopMessView = class("ShopMessView", TableViewComponent)

function ShopMessView:_getPath()
	return {
		cellPath = "CellMess",
		viewPath = "ScrollView"
	}
end

function ShopMessView:ctor()
	ShopMessView.super.ctor(self)
end

function ShopMessView:bindEvents()
	ShopController.instance:registerLocalNotify(ShopController.MESSSELECTCHANGE, self._refresh, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._refresh, self)
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._refresh, self)
end

function ShopMessView:unbindEvents()
	ShopController.instance:unregisterLocalNotify(ShopController.MESSSELECTCHANGE, self._refresh, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._refresh, self)
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._refresh, self)
end

function ShopMessView:buildUI()
	ShopMessView.super.buildUI(self)
end

function ShopMessView:destroyUI()
	return
end

function ShopMessView:onEnter()
	ShopMessView.super.onEnter(self)

	self._isFirstLoadData = true

	self:_reloadData()
end

function ShopMessView:onEnterFinished()
	return
end

function ShopMessView:onExit()
	ShopMessView.super.onExit(self)

	self._isFirstLoadData = false
	self._curViewDatas = nil

	ShopModel.instance:select(nil, true)

	self._lineBgList = {}
end

function ShopMessView:onExitFinished()
	return
end

function ShopMessView:_cellSize()
	return 215, 225
end

function ShopMessView:_updateCell(view, cell, data)
	local comp = ShopMessItem.AddOnce(cell.gameObject)

	comp:init(data)

	return cell
end

function ShopMessView:_clearTableview(cell)
	print("+==调用")

	local comp = ShopMessItem.AddOnce(cell.gameObject)

	comp:reset()
end

function ShopMessView:_reloadData()
	self._curViewDatas = ShopModel.instance:getGoodsByType(2)

	if #self._curViewDatas > 0 then
		self._tableview:ReloadData()
	end
end

function ShopMessView:_refresh()
	self._tableview:Refresh()
end

function ShopMessView:_onReloadFinish()
	if self._isFirstLoadData then
		self._isFirstLoadData = false

		self._tableview:SetOffsetWithoutRefresh(0)
		self:reloadData()
	end
end

return ShopMessView
