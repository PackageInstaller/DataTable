-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopDebrisMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopDebrisMediator = class("ShopDebrisMediator", DmAreaViewMediator, _M)

ShopDebrisMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopDebrisMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopDebrisMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ShopDebrisMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopDebrisMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kNums = 3
local kCellWidth = 820

function ShopDebrisMediator:initialize()
	super.initialize(self)
end

function ShopDebrisMediator:dispose()
	self:getView():stopAllActions()
	self:stopItemActions()

	if self._timer1 then
		self._timer1:stop()

		self._timer1 = nil
	end

	if self._timer2 then
		self._timer2:stop()

		self._timer2 = nil
	end

	super.dispose(self)
end

function ShopDebrisMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()

	self:mapEventListeners()

	self._exchangeBtn = self:bindWidget("main.exchangeBtn", ThreeLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickExchange, self)
		}
	})
end

function ShopDebrisMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_REFRESH_SUCC, self, self.onRefreshShopSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_BUY_REFRESH_SUCC, self, self.onBuyShopItemSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshByRset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SELL_DEBRIS_SUCC, self, self.onSellDebrisSuccess)
end

function ShopDebrisMediator:onRemove()
	super.onRemove(self)
end

function ShopDebrisMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:initMember()
	self:initData(data)
	self:forceRefreshRemainTime()
	self:refreshView()

	self._timer1 = LuaScheduler:getInstance():schedule(handler(self, self.onTick), 1, false)

	self:onTick()
	self:createSchel()
end

function ShopDebrisMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Shop_Fragment")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("shop_UI36")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ShopDebrisMediator:initData(data)
	self._shopId = "Shop_Fragment"
	self._nodeCache = {}

	self:refreshData()
end

function ShopDebrisMediator:refreshData()
	local shopGroup = self._shopSystem:getShopGroupById(self._shopId)

	self._curShopItems = shopGroup:getGoodsList()

	local time = shopGroup:getUpdateTime()

	self._nodeCache[self._shopId] = {}

	if time then
		self._nodeCache[self._shopId].remainTime = time
	end
end

function ShopDebrisMediator:initMember()
	self._view = self:getView()
	self._cellClone = self._view:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._mainPanel = self._view:getChildByFullName("main")
	self._refreshPanel = self._mainPanel:getChildByName("refreshPanel")

	local refreshDesc = self._refreshPanel:getChildByFullName("refresh_desc")
	local refreshTime = self._refreshPanel:getChildByFullName("refresh_time_text")

	refreshTime:setAdditionalKerning(4)

	local refreshTime1 = self._refreshPanel:getChildByFullName("refresh_time_text1")

	refreshDesc:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	refreshTime:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	refreshTime1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	refreshTime1:getChildByName("day"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self:adjustView()
end

function ShopDebrisMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentHeight = winSize.height - 124

	self._scrollView = self._mainPanel:getChildByName("scrollView")

	self._scrollView:setContentSize(cc.size(kCellWidth, currentHeight))
	self._scrollView:setScrollBarEnabled(false)

	self._cellHeight = self._cellClone:getContentSize().height
end

function ShopDebrisMediator:refreshView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()

	local length = math.ceil(#self._curShopItems / kNums)
	local viewHeight = self._scrollView:getContentSize().height
	local allHeight = math.max(viewHeight, self._cellHeight * length)

	self._scrollView:setInnerContainerSize(cc.size(kCellWidth, allHeight))
	self._scrollView:setInnerContainerPosition(cc.p(0, viewHeight - allHeight))

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(kCellWidth, self._cellHeight))
		layout:addTo(self._scrollView)
		layout:setAnchorPoint(cc.p(0, 1))
		layout:setPosition(cc.p(0, allHeight - (i - 1) * self._cellHeight))
		layout:setTouchEnabled(false)
		self:createCell(layout, i)
	end

	self:runListAnim()
end

function ShopDebrisMediator:createCell(cell, index)
	for i = 1, kNums do
		local itemIndex = kNums * (index - 1) + i
		local itemData = self._curShopItems[itemIndex]

		if itemData then
			local item = ShopItem:new()
			local clonePanel = self._cellClone:clone()

			clonePanel:setVisible(true)
			item:setView(clonePanel, self)
			cell:addChild(item:getView())
			item:getView():setPosition((i - 1) * 270, 0)
			item:getView():setTag(i)

			cell["item" .. i] = item

			item:setInfo(itemData)
			item:setTouchHandler(handler(self, self.onClickItem))

			cell["ShopItem" .. i] = item
		end
	end
end

function ShopDebrisMediator:refreshShopData()
	self:refreshData()

	local offsetY = self._scrollView:getInnerContainerPosition().y

	self:refreshView()
	self._scrollView:setInnerContainerPosition(cc.p(0, offsetY))
end

function ShopDebrisMediator:refreshByRset(event)
	self:forceRefreshRemainTime()
	self._shopSystem:requestGetShop(self._shopId)
	self:refreshShopData()
end

function ShopDebrisMediator:onBuyShopItemSuccess(event)
	local cache = self._nodeCache[self._shopId]

	if cache then
		cache.isSendRefresh = nil

		self:dispatch(ShowTipEvent({
			tip = Strings:get("SHOP_BUY_SUCCESS")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Buy", false)
	end

	self:refreshShopData()
end

function ShopDebrisMediator:onSellDebrisSuccess(event)
	local rewards = event:getData().rewards

	self:dispatch(ShowTipEvent({
		tip = Strings:get("shop_UI38")
	}))

	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}, nil))
end

function ShopDebrisMediator:onRefreshShopSuccess(event)
	self:forceRefreshRemainTime()

	local cache = self._nodeCache[self._shopId]

	if cache then
		cache.isSendRefresh = nil
	end

	self:refreshShopData()
end

function ShopDebrisMediator:createSchel()
	local function checkTimeFunc()
		local needRefresh = false

		if self._stopRefresh then
			return
		end

		local allCells = self._scrollView:getChildren()

		for _, ecell in pairs(allCells) do
			if ecell then
				for i = 1, kNums do
					local cell = ecell["ShopItem" .. i]

					if cell then
						local lastTime = cell:refreshTimePanel()

						if lastTime <= 0 and lastTime > -1 then
							needRefresh = true

							break
						end
					end
				end
			end
		end

		if needRefresh then
			self._stopRefresh = true

			self._shopSystem:requestGetShop(self._shopId, function()
				self._stopRefresh = false
			end)
		end
	end

	self._timer2 = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function ShopDebrisMediator:forceRefreshRemainTime()
	local systemTime = self._shopSystem:getCurSystemTime()

	for shopId, cache in pairs(self._nodeCache) do
		local shopGroup = self._shopSystem:getShopGroupById(shopId)
		local nextTime = shopGroup:getUpdateTime()

		if nextTime and nextTime - systemTime > 0 then
			self._nodeCache[shopId].remainTime = nextTime
		end
	end
end

function ShopDebrisMediator:refreshTime(shopId)
	shopId = self._shopId

	local cache = self._nodeCache[self._shopId]

	if not cache then
		return
	end

	local hasResetTime = self._shopSystem:hasResetTime(shopId)
	local refreshDesc = self._refreshPanel:getChildByFullName("refresh_desc")
	local refreshTime = self._refreshPanel:getChildByFullName("refresh_time_text")
	local refreshTime1 = self._refreshPanel:getChildByFullName("refresh_time_text1")

	if cache.remainTime and hasResetTime then
		refreshDesc:setVisible(true)
		refreshTime:setVisible(true)
		refreshTime1:setVisible(true)

		if cache.remainTime >= 0 then
			local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
			local remainTime = cache.remainTime - remoteTimestamp
			local str = TimeUtil:formatTime("${d}:${HH}:${MM}:${SS}", remainTime)
			local strArr = string.split(str, ":")

			refreshTime1:getChildByFullName("day"):setString(strArr[1])
			refreshTime:setString(strArr[2] .. ":" .. strArr[3] .. ":" .. strArr[4])

			if strArr[1] == "0" then
				refreshTime1:setVisible(false)
				refreshDesc:setPositionX(refreshTime:getPositionX() - refreshTime:getContentSize().width / 2)
			else
				refreshTime1:setPositionX(refreshTime:getPositionX() - refreshTime:getContentSize().width / 2)
				refreshDesc:setPositionX(refreshTime1:getPositionX() - 56)
			end
		else
			refreshDesc:setVisible(false)
			refreshTime:setVisible(false)
			refreshTime1:setVisible(false)
		end
	else
		refreshDesc:setVisible(false)
		refreshTime:setVisible(false)
		refreshTime1:setVisible(false)
	end
end

function ShopDebrisMediator:reduceTime()
	for shopId, cache in pairs(self._nodeCache) do
		if self._nodeCache[shopId].remainTime then
			local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
			local remainTime = self._nodeCache[shopId].remainTime - remoteTimestamp
			local hasResetTime = self._shopSystem:hasResetTime(shopId)

			if remainTime <= 0 and not self._nodeCache[shopId].isSendRefresh and hasResetTime then
				self._nodeCache[shopId].remainTime = 0

				self._shopSystem:requestGetShop(shopId)

				self._nodeCache[shopId].isSendRefresh = true
			end
		end
	end
end

function ShopDebrisMediator:onClickItem(event)
	if event.name == "began" then
		self._isReturn = true
	elseif event.name == "ended" and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		local itemModel = event.target._data

		self:showShopBuyView(itemModel)
	end
end

function ShopDebrisMediator:onBackClicked()
	self:dismiss()
end

function ShopDebrisMediator:onClickExchange()
	local view = self:getInjector():getInstance("ShopDebrisSellView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function ShopDebrisMediator:onTick(dt)
	self:reduceTime()
	self:refreshTime()
end

function ShopDebrisMediator:showShopBuyView(data)
	local view = self:getInjector():getInstance("ShopBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemData = data
	}))
end

function ShopDebrisMediator:showShopRefreshView(data)
	local view = self:getInjector():getInstance("ShopRefreshView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function ShopDebrisMediator:stopItemActions()
	local allCells = self._scrollView:getChildren()

	for i = 1, 5 do
		local child = allCells[i]

		if child then
			for j = 1, 3 do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					node:stopAllActions()
				end
			end
		end
	end
end

function ShopDebrisMediator:runListAnim()
	self._scrollView:setTouchEnabled(false)

	local allCells = self._scrollView:getChildren()

	for i = 1, 5 do
		local child = allCells[i]

		if child then
			for j = 1, 3 do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					node:setOpacity(0)
				end
			end
		end
	end

	local length = math.min(5, #allCells)
	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667

	for i = 1, 5 do
		local child = allCells[i]

		if child then
			for j = 1, 3 do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					local time = (i - 1) * delayTime + (j - 1) * delayTime1
					local delayAction = cc.DelayTime:create(time)
					local callfunc = cc.CallFunc:create(function()
						CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
					end)
					local callfunc1 = cc.CallFunc:create(function()
						node:setOpacity(255)

						if length == i then
							self._scrollView:setTouchEnabled(true)
						end
					end)
					local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

					self:getView():runAction(seq)
				end
			end
		end
	end
end
