-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopView.lua

module("logic.extensions.shop.view.ShopView", package.seeall)

local ShopView = class("ShopView", ViewComponent)

function ShopView:ctor()
	ShopView.super.ctor(self)

	self._viewNames = {
		ViewName.Shopgift,
		ViewName.Shopmess,
		ViewName.Shopmess2,
		ViewName.Shopcharge
	}
	self._tabIndexs = {
		[ViewName.Shopgift] = 1,
		[ViewName.Shopmess] = 2,
		[ViewName.Shopmess2] = 3,
		[ViewName.Shopcharge] = 4
	}
end

function ShopView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)

	for i = 1, #self._viewNames do
		self._tabBtns[i]:AddClickListener(function()
			self:_changeTab(i)
		end, self)
	end
end

function ShopView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()

	for i = 1, #self._viewNames do
		self._tabBtns[i]:RemoveClickListener()
	end
end

function ShopView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._btnHome = self:getBtn("btn_home")
	self._tabBtns = {}
	self._btnImgChg = {}
	self._btnImgs = {}

	for i = 1, #self._viewNames do
		self._tabBtns[i] = self:getBtn("LeftBtns/Btn" .. i)
		self._btnImgChg[i] = self:getGo("LeftBtns/Btn" .. i .. "/ImgBtn"):GetComponent("UIChangeGroup")
		self._btnImgs[i] = self:getGo("LeftBtns/Btn" .. i .. "/ImgBtn"):GetComponent("Image")
	end

	self._Container = self:getGo("container")
	self.goldBarCon = self:getGo("goldBarCon")
end

function ShopView:destroyUI()
	return
end

function ShopView:onEnter()
	local viewName = self._viewPresentor:getFirstParam()

	if viewName then
		self:_changeTab(self._tabIndexs[viewName])
	else
		self:_changeTab(1)
	end

	ShopController.instance:getGoodLeftCount()
	ShopModel.instance:updateLastTimeShow()

	local objList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, objList)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self, NotifyPriority.Low)
end

function ShopView:_reloadData()
	ShopController.instance:getGoodLeftCount()
end

function ShopView:onEnterFinished()
	return
end

function ShopView:onExit()
	self._tabIndex = nil

	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
end

function ShopView:onExitFinished()
	return
end

function ShopView:_changeTab(tabIndex)
	if tabIndex == #self._viewNames then
		TipsFacade.instance:openCommonTips(ConstString.NotRelease)

		return
	end

	self._tabIndex = tabIndex

	self:showTabAt(self._Container, self._viewNames[self._tabIndex], tabIndex)

	for i = 1, #self._viewNames do
		if i == tabIndex then
			self._btnImgChg[i]:SetState(0)
		else
			self._btnImgChg[i]:SetState(1)
		end

		self._btnImgs[i]:SetNativeSize()
	end
end

function ShopView:_onClickClose()
	self:close()
end

function ShopView:_onClickHome()
	UIStateManager.instance:clear(true)
end

return ShopView
