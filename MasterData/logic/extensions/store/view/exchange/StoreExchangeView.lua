-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/exchange/StoreExchangeView.lua

module("logic.extensions.store.view.exchange.StoreExchangeView", package.seeall)

local M = class("StoreExchangeView", StoreFragmentViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._goCommon = self._registry:getGo("store_exchange_panel_335097407")
	self._goEchoCard = self._registry:getGo("store_exchange_panel_-1759378492")
	self._commonView = StroeExchangeCommonView.New(self._goCommon)

	self._commonView:setUIRegistry(self._registry)

	self._echoCardView = StoreExchangeEchoCardView.New(self._goEchoCard)

	self._echoCardView:setUIRegistry(self._registry)
end

function M:destroyUI()
	self._commonView:destroyUI()
	self._echoCardView:destroyUI()
end

function M:bindEvents()
	self._commonView:bindEvents()
	self._echoCardView:bindEvents()
end

function M:unbindEvents()
	self._commonView:unbindEvents()
	self._echoCardView:unbindEvents()
end

function M:onEnter()
	M.super.onEnter(self)
	self._commonView:onEnter()
	self._echoCardView:onEnter()
end

function M:onExit()
	M.super.onExit(self)
	self._commonView:onExit()
	self._echoCardView:onExit()
end

function M:_clickStoreCallBack(index, storeMo, isClick)
	M.super._clickStoreCallBack(self, index, storeMo, isClick)

	if self._selectIndex == index and isClick then
		return
	end

	local type = storeMo:getStoreType()

	if type == StoreEnum.MallType.EchoCardPack then
		self._echoCardView:updateView(storeMo, self._targetGoodsId)
		self._commonView:setActive(false)
	else
		self._commonView:updateView(storeMo, self._targetGoodsId)
		self._echoCardView:setActive(false)
	end

	self:_updateMoneyView(storeMo:getId())

	self._selectIndex = index
	self._selectStoreId = storeMo:getId()
end

return M
