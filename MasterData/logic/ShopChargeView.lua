-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopChargeView.lua

module("logic.extensions.shop.view.ShopChargeView", package.seeall)

local ShopChargeView = class("ShopChargeView", ViewComponent)

function ShopChargeView:ctor()
	ShopChargeView.super.ctor(self)
end

function ShopChargeView:bindEvents()
	for i = 1, 6 do
		self._cells[i]._btn:AddClickListener(function()
			self:_onClickCell(i)
		end, self)
	end
end

function ShopChargeView:unbindEvents()
	for i = 1, 6 do
		self._cells[i]._btn:RemoveClickListener()
	end
end

function ShopChargeView:buildUI()
	self._cells = {}

	for i = 1, 6 do
		self._cells[i] = {}
		self._cells[i]._go = self:getGo("Cells/Cell" .. i)
		self._cells[i]._btn = self:getBtn("Cells/Cell" .. i)
		self._cells[i]._price = goutil.findChildTextComponent(self._cells[i]._go, "TxtPrice")
		self._cells[i]._moneyType = goutil.findChildTextComponent(self._cells[i]._go, "TxtMoney")
		self._cells[i]._count = goutil.findChildTextComponent(self._cells[i]._go, "ImgCnt/Txt")

		local cfg = ShopConfig.instance:getChargeCfgById(i)

		self._cells[i]._price.text = cfg.price
		self._cells[i]._moneyType.text = cfg.moneyType
		self._cells[i]._count.text = "X " .. cfg.count
	end
end

function ShopChargeView:destroyUI()
	return
end

function ShopChargeView:onEnter()
	return
end

function ShopChargeView:onEnterFinished()
	return
end

function ShopChargeView:onExit()
	return
end

function ShopChargeView:onExitFinished()
	return
end

function ShopChargeView:_onClickClose()
	UIStateManager.instance:pop()
end

function ShopChargeView:_onClickCell(index)
	TipsFacade.instance:openCommonTips("支付功能尚未开放")
end

return ShopChargeView
