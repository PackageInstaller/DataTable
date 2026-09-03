-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopMainMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopMainMediator = class("ShopMainMediator", DmAreaViewMediator, _M)

ShopMainMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ShopMainMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopMainMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kNums = 4
local kCellHeightTab = 50
local kCellHeight = 495
local kbackgroundPath = "asset/scene/shop_img_zsbg.jpg"
local kShopView = {
	[ShopSpecialId.kShopMall] = "ShopRechargeView",
	[ShopSpecialId.kShopPackage] = "ShopPackageMainView",
	[ShopSpecialId.kShopMonthcard] = "ShopMonthCardView",
	[ShopSpecialId.kShopSurface] = "ShopSurfaceNewView",
	[ShopSpecialId.kShopReset] = "ShopPackageMainView",
	[ShopSpecialId.kShopRecommend] = "ShopRecommendView",
	[ShopSpecialId.kShopSurfacePackage] = "ShopPackageMainView",
	[ShopSpecialId.kShopTimeLimit] = "ShopPackageMainView",
	[ShopSpecialId.kShopTimeLimit2] = "ShopPackageMainView",
	[ShopSpecialId.KShopTimelimitedmall] = "ShopPackageMainView"
}
local kShopNormalType = {
	Normal = "Normal",
	GoldPartner = "GoldPartner"
}

function ShopMainMediator:initialize()
	super.initialize(self)
end

function ShopMainMediator:dispose()
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

function ShopMainMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()

	self:mapEventListeners()
end

function ShopMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_REFRESH_SUCC, self, self.onRefreshShopSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_BUY_REFRESH_SUCC, self, self.onBuyShopItemSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshByRset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHBYGOLDORDIMOND_SUCC, self, self.refreshViewByDimondSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PACKAGE_SUCC, self, self.showPackageShop)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_BUY_SUCC, self, self.onBuyShopSurfaceSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_SURFACE_SUCC, self, self.showSurfaceShop)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FefreshForeverCard, self, self.refreshForeverView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.onBuyPackageSuccCallback)
end

function ShopMainMediator:onRemove()
	super.onRemove(self)
end

function ShopMainMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:initMember()
	self:initData(data)
	self:initLeftTabController()
	self:forceRefreshRemainTime()
	self:initRightTabController()

	if not kShopView[self._shopId] then
		self:refreshView()
	end

	self._timer1 = LuaScheduler:getInstance():schedule(handler(self, self.onTick), 1, false)

	self:createSchel()
end

function ShopMainMediator:initData(data)
	self._data = data

	if data then
		self._shopId = data.shopId or ShopSpecialId.kShopNormal
	end

	self._leftTabIndex = 1

	if data then
		self._rightTabIndex = data.rightTabIndex or 1
	end

	if data then
		self._from = data.from or ""
	end

	self._enterData = data

	self._shopSystem:setPlayInstance(true)

	self._showSell = true
	self._nodeCache = {}
	self._viewCache = {}

	self:createLeftShopConfig()
	self:createRightShopConfig()
	self:refreshData()
end

function ShopMainMediator:refreshForeverView()
	if self._tabBtnWidget then
		self._tabBtnWidget:refreshAllRedPoint()
	end
end

function ShopMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Shop_Mystery")
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
		title = Strings:get("Shop_Text1")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ShopMainMediator:refreshTopInfo(shopId)
	local unlockKey = ""

	if self._shopTabMap[shopId] then
		unlockKey = self._shopTabMap[shopId].unlockKey
	elseif self._leftMap[shopId] then
		unlockKey = self._leftMap[shopId].unlockKey
	end

	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds(unlockKey)
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		title = Strings:get("Shop_Text1")
	}

	self._topInfoWidget:updateView(config)
end

function ShopMainMediator:refreshData()
	if self:getShopNormalId() == ShopSpecialId.kShopNormal then
		local shopId = self:transShopNormalToShopId()
		local shopGroup = self._shopSystem:getShopGroupById(shopId)

		self._curShopItems = shopGroup:getGoodsList()
		self._shopId = shopId
	end
end

function ShopMainMediator:transShopNormalToShopId()
	return (self._shopId == ShopSpecialId.kShopNormal or nil) and self._shopTabList[self._rightTabIndex].shopId
end

function ShopMainMediator:getShopNormalId()
	if self._shopTabMap[self._shopId] then
		return ShopSpecialId.kShopNormal
	end

	return self._shopId
end

function ShopMainMediator:createLeftShopConfig()
	self._leftArr, self._leftMap = self._shopSystem:getLeftShowTabs()

	if not self._leftMap[self._shopId] then
		self._fresh = true

		for key, value in pairs(self._leftMap) do
			if value.index == 1 then
				self._shopId = key

				break
			end
		end
	end

	self._leftTabIndex = self._leftMap[self._shopId].index
end

function ShopMainMediator:createRightShopConfig()
	local shopTabIds = ConfigReader:getRecordById("ConfigValue", "Shop_ShowSequence").content

	self._shopTabList = {}
	self._shopTabMap = {}

	for i = 1, #shopTabIds do
		local shopId = shopTabIds[i]
		local shopGroup = self._shopSystem:getShopGroupById(shopId)

		if shopGroup then
			local config = ConfigReader:getRecordById("Shop", shopId)
			local unlock, tips = self._systemKeeper:isUnlock(config.UnlockSystem)
			local canShow = self._systemKeeper:canShow(config.UnlockSystem)

			if canShow and unlock then
				local index = #self._shopTabList + 1

				self._shopTabList[index] = {
					shopId = shopId,
					name = {
						Strings:get(config.Name),
						Strings:get(config.ENName)
					}
				}
				self._shopTabMap[shopId] = {
					unlockKey = config.UnlockSystem
				}

				local shopGroup = self._shopSystem:getShopGroupById(shopId)
				local time = shopGroup:getUpdateTime()

				self._nodeCache[shopId] = {}

				if time then
					self._nodeCache[shopId].remainTime = time
				end

				if shopId == self._shopId then
					self._rightTabIndex = index
					self._leftTabIndex = self._leftMap[ShopSpecialId.kShopNormal].index
				end
			end
		end
	end
end

function ShopMainMediator:initMember()
	self._view = self:getView()
	self._mainPanel = self._view:getChildByFullName("main")
	self._backgroundBG = self._mainPanel:getChildByFullName("backgroundBG")
	self._leftTabPanel = self._view:getChildByName("leftTabPanel")
	self._rightTabPanel = self._view:getChildByName("rightTabPanel")
	self._tabClone = self._view:getChildByFullName("tabClone")

	self._tabClone:setVisible(false)

	self._cellCloneNormal = self._view:getChildByFullName("cellCloneNormal")

	self._cellCloneNormal:setVisible(false)

	self._refreshPanel = self._view:getChildByName("refreshPanel")

	self._refreshPanel:getChildByFullName("refresh_btn"):addClickEventListener(function()
		self:onClickRefresh()
	end)

	self._refreshBtn = self._refreshPanel:getChildByFullName("refresh_btn")
	self._refreshDesc = self._refreshPanel:getChildByFullName("refresh_desc")
	self._refreshTime = self._refreshPanel:getChildByFullName("refresh_time_text")

	self._refreshTime:setAdditionalKerning(2)

	self._refresh_btn = self._refreshPanel:getChildByFullName("refresh_btn")
	self._exchange_btn = self._view:getChildByFullName("Button_exchange")

	self._exchange_btn:setVisible(false)
	self._exchange_btn:addClickEventListener(function()
		self:onClickExhange()
	end)
	self:adjustView()
end

function ShopMainMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentWidthNormal = winSize.width - 188 - AdjustUtils.getAdjustX()
	local currentWidthNormalTab = winSize.width - 200 - AdjustUtils.getAdjustX()

	self._scrollViewTab = self._rightTabPanel:getChildByName("scrollViewTab")

	self._scrollViewTab:setScrollBarEnabled(false)

	self._tabBg = self._rightTabPanel:getChildByName("tabBg")

	self._tabBg:setContentSize(cc.size(winSize.width - 200, 46))

	self._scrollView = self._mainPanel:getChildByFullName("scrollView")

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setContentSize(cc.size(currentWidthNormalTab, self._scrollView:getContentSize().height))

	self._cellWidthTab = self._tabClone:getContentSize().width
	self._cellWidthNormal = self._cellCloneNormal:getContentSize().width + 13
	self._cellHeightNormal = self._cellCloneNormal:getContentSize().height + 8
	self._goldScrollView = self._mainPanel:getChildByFullName("goldScrollView")

	self._goldScrollView:setScrollBarEnabled(false)
	self._goldScrollView:setContentSize(cc.size(currentWidthNormalTab, self._goldScrollView:getContentSize().height))

	self._goldCell = self._view:getChildByFullName("goldCell")
end

function ShopMainMediator:refreshView()
	local shopType = ConfigReader:getDataByNameIdAndKey("Shop", self._shopId, "ShopType")

	if shopType and shopType == kShopNormalType.Normal then
		self:setScrollView(true)
		self._refreshDesc:setString(Strings:get("Shop_Next_Refresh"))

		local width = self._scrollView:getContentSize().width
		local num1 = math.floor(width / self._cellWidthNormal)
		local num2 = math.ceil(#self._curShopItems / 2)

		kNums = math.max(num1, num2)

		local length = math.ceil(#self._curShopItems / kNums)

		if self:getShopNormalId() == ShopSpecialId.kShopNormal then
			local allHeight = math.max(kCellHeight, self._cellHeightNormal * length - 8)

			self._scrollView:setInnerContainerSize(cc.size(kNums * self._cellWidthNormal, allHeight))
			self._scrollView:setInnerContainerPosition(cc.p(0, -(allHeight - kCellHeight)))

			for i = 1, length do
				local layout = ccui.Layout:create()

				layout:setContentSize(cc.size(kNums * self._cellWidthNormal, self._cellHeightNormal))
				layout:addTo(self._scrollView)
				layout:setTag(i)
				layout:setAnchorPoint(cc.p(0, 1))

				local h = allHeight - self._cellHeightNormal * (i - 1) + 8

				layout:setPosition(cc.p(0, h))
				layout:setTouchEnabled(false)
				self:createCell(layout, i)
			end
		end

		self:runListAnim()

		if self._curGoods then
			self._scrollView:setInnerContainerPosition(cc.p(self._viewOffsetX, 0))

			self._curGoods = nil
			self._viewOffsetX = nil
		end
	elseif shopType and shopType == kShopNormalType.GoldPartner then
		local winSize = cc.Director:getInstance():getWinSize()

		self:setScrollView(false)

		local len = #self._curShopItems

		table.sort(self._curShopItems, function(a, b)
			if a:getStock() <= 0 and b:getStock() > 0 then
				return false
			end

			if a:getStock() > 0 and b:getStock() <= 0 then
				return true
			end

			return a:getSort() < b:getSort()
		end)
		self._goldScrollView:setInnerContainerSize(cc.size(235 * len, 486))
		self._goldScrollView:setInnerContainerPosition(cc.p(0, 0))
		self._refreshDesc:setString(Strings:get("Shop_GoldPartner_FlashDes"))

		for i = 1, len do
			local cell = self._goldCell:clone()

			cell:setVisible(true)
			cell:addTo(self._goldScrollView)
			cell:setPosition(cc.p(235 * (i - 1), 15))
			self:createGoldCell(cell, self._curShopItems[i])
		end

		self:runGoldListAnim()
	end

	self._exchange_btn:setVisible(false)

	if self._shopId == "Shop_URMap" then
		self._exchange_btn:setVisible(true)

		if self._shopSystem:getRedPointForShopExchange() then
			local data = self._bagSystem:getRepeatURItems()

			self._bagSystem:setURExchangeRedPoint(next(data) ~= nil)
		end

		self:refreshExchangeRedpoint()
	end
end

function ShopMainMediator:resumeBackground()
	self._backgroundBG:loadTexture(kbackgroundPath)
end

function ShopMainMediator:changeBackground(path)
	self._backgroundBG:loadTexture(path)
end

function ShopMainMediator:createCell(cell, index)
	for i = 1, kNums do
		local itemIndex = kNums * (index - 1) + i
		local itemData = self._curShopItems[itemIndex]

		if itemData then
			local item = ShopItem:new()
			local clonePanel = self._cellCloneNormal:clone()

			clonePanel:setVisible(true)
			clonePanel:setAnchorPoint(cc.p(0, 0))
			item:setView(clonePanel, self)
			cell:addChild(item:getView())
			item:getView():setTag(i)

			local x = (i - 1) * self._cellWidthNormal
			local y = 0

			item:getView():setPosition(x, y)
			item:getView():setTag(i)

			cell["item" .. i] = item

			item:setInfo(itemData)

			local function callback()
				self:onClickItem(itemData)
			end

			item:setTouchHandler(callback)

			cell["ShopItem" .. i] = item
		end
	end
end

function ShopMainMediator:createGoldCell(cell, data)
	local name = cell:getChildByFullName("heroName")

	name:setString(data:getName())

	local discount = cell:getChildByName("discount")
	local discountNum = discount:getChildByName("num")
	local totalMoney = cell:getChildByName("Text_12")
	local lineImage = cell:getChildByName("lineImage")
	local costOff = data:getCostOff()

	if costOff ~= 1 then
		discount:setVisible(true)
		discountNum:setString(costOff * 10 .. Strings:get("SHOP_COST_OFF_TEXT10"))

		local totalPrice = data:getPrice()

		if costOff * 10 ~= 0 then
			local originalPrice = data:getOriginalPrice()

			totalPrice = originalPrice and originalPrice or math.ceil(totalPrice / costOff)
		end

		totalMoney:setString(totalPrice)
		totalMoney:setVisible(true)
		lineImage:setVisible(true)
	else
		discount:setVisible(false)
		totalMoney:setString("")
		totalMoney:setVisible(false)
		lineImage:setVisible(false)
	end

	local moneyText = cell:getChildByName("prize")
	local price = data:getPrice()

	price = price == 0 and Strings:get("Recruit_Free") or price

	moneyText:setString(price)

	local moneyIcon = cell:getChildByName("moneyIcon")
	local goldIcon = IconFactory:createPic({
		id = data:getCostType()
	})

	goldIcon:addTo(moneyIcon):center(moneyIcon:getContentSize()):offset(0, -2)

	local heroId = data:getItemConfig().TargetId.id
	local detailBtn = cell:getChildByName("detailBtn")

	detailBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local view = self:getInjector():getInstance("HeroInfoView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				heroId = heroId
			}))
		end
	end)

	local scale = data:getScale()
	local baseRole = cell:getChildByFullName("role")
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = false,
		frameId = "bustframe9",
		id = roleModel
	})

	heroSprite:setScale(scale.Zoom)
	heroSprite:addTo(baseRole):offset(scale.XOffst + 100, scale.YOffset + 300)

	local tagImg = cell:getChildByFullName("tagImg")
	local rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Rareity")

	tagImg:loadTexture(GameStyle:getHeroRarityImage(rarity), 1)

	local touchPanel = cell:getChildByFullName("touchPanel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickItem(data)
		end
	end)

	local times1 = data:getStock()
	local resetMode = data:getResetMode()
	local exchangeLab = cell:getChildByName("exchangeLab")
	local str = Strings:get("Shop_GoldPartner_BuyNum", {
		fontSize = 22,
		num = times1,
		fontName = TTF_FONT_FZYH_R
	})

	exchangeLab:setString(str)

	local mask = cell:getChildByFullName("mask")

	if times1 <= 0 then
		mask:setVisible(true)
	else
		mask:setVisible(false)
	end
end

function ShopMainMediator:refreshShopData()
	if not kShopView[self._shopId] then
		self:refreshData()
		self:refreshView()
	end
end

function ShopMainMediator:refreshByRset(event)
	self:forceRefreshRemainTime()
	self._shopSystem:requestGetShop(self._shopId)
	self:refreshShopData()
end

function ShopMainMediator:refreshViewByDimondSuccess(event)
	self:refreshShopData()
end

function ShopMainMediator:onBuyShopItemSuccess(event)
	local shopId = self:transShopNormalToShopId()
	local cache = self._nodeCache[shopId]

	if cache then
		self:refreshShopByTag(shopId)

		cache.isSendRefresh = nil

		AudioEngine:getInstance():playEffect("Se_Alert_Buy", false)

		local data = event:getData().data

		if data and data.rewards and #data.rewards > 0 then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data.rewards
			}))
		end
	end

	self:refreshShopData()
end

function ShopMainMediator:onBuyShopSurfaceSuccess(event)
	local shopId = self:transShopNormalToShopId()
	local cache = self._nodeCache[shopId]

	if cache then
		self:refreshShopByTag(shopId)

		cache.isSendRefresh = nil
	end

	self:refreshShopData()
end

function ShopMainMediator:onRefreshShopSuccess(event)
	self:forceRefreshRemainTime()

	local shopId = self:transShopNormalToShopId()
	local cache = self._nodeCache[shopId]

	if cache then
		self:refreshShopByTag(shopId)

		cache.isSendRefresh = nil
	end

	self:refreshShopData()
end

function ShopMainMediator:createSchel()
	local function checkTimeFunc()
		local needRefresh = false

		if self._stopRefresh or not self._scrollView then
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

function ShopMainMediator:initLeftTabController(disOnClickTab)
	self._leftTabPanel:removeAllChildren()

	self._tabBtnWidget = nil

	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local btnDatas = {}

	for i = 1, #self._leftArr do
		btnDatas[#btnDatas + 1] = {
			fontSize = 20,
			textOffsety = 7,
			btnOffsetX = 47,
			redPointPosx = 132,
			unEnableOutline = true,
			redPointPosy = 36,
			textOffsetx = -7,
			tabText = self._leftArr[i].name[1],
			tabTextTranslate = self._leftArr[i].name[2],
			tabImage = {
				"sd_btn_z_2.png",
				"sd_btn_z_1.png"
			},
			fontName = CUSTOM_TTF_FONT_1,
			fontColor = cc.c4b(255, 255, 255, 255),
			fontColorSel = cc.c4b(62, 62, 62, 255),
			redPointFunc = function()
				if self._leftArr[i].shopId == ShopSpecialId.kShopReset then
					return self._shopSystem:getRedPointForShopReset()
				end

				if self._leftArr[i].shopId == ShopSpecialId.kShopPackage then
					return self._shopSystem:getRedPointByPackageType(ShopSpecialId.kShopPackage)
				end

				if self._leftArr[i].shopId == ShopSpecialId.kShopSurfacePackage then
					return self._shopSystem:getRedPointByPackageType(ShopSpecialId.kShopSurfacePackage)
				end

				if self._leftArr[i].shopId == ShopSpecialId.kShopTimeLimit then
					return self._shopSystem:getRedPointByPackageType(ShopSpecialId.kShopTimeLimit)
				end

				if self._leftArr[i].shopId == ShopSpecialId.kShopTimeLimit2 then
					return self._shopSystem:getRedPointByPackageType(ShopSpecialId.kShopTimeLimit2)
				end

				if self._leftArr[i].shopId == ShopSpecialId.kShopMonthcard then
					return self._shopSystem:getRedPointForMonthcard()
				end

				if self._leftArr[i].shopId == ShopSpecialId.KShopTimelimitedmall then
					return self._shopSystem:getRedPointByPackageType(ShopSpecialId.kShopTimeLimit)
				end

				return false
			end
		}
	end

	config.btnDatas = btnDatas

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode1()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:initTabBtn(config, {
		hideBtnAnim = true,
		ignoreSound = true,
		ignoreRedSelectState = true,
		noCenterBtn = true,
		disMovieClip = true
	})
	self._tabBtnWidget:selectTabByTag(self._leftTabIndex, disOnClickTab)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._leftTabPanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function ShopMainMediator:initRightTabController()
	self._tabBtns = {}
	self._cacheViewsName = {}
	self._ignoreSound = true

	self._scrollViewTab:removeAllChildren()

	local length = #self._shopTabList
	local viewWidth = self._scrollViewTab:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidthTab * length)

	self._scrollViewTab:setInnerContainerSize(cc.size(allWidth, kCellHeightTab))
	self._scrollViewTab:setInnerContainerPosition(cc.p(0, 2))

	for i = 1, length do
		local nameStr = self._shopTabList[i].name[1]
		local nameStr1 = self._shopTabList[i].name[2]
		local btn = self._tabClone:clone()

		btn:setVisible(true)
		btn:setTag(i)
		btn:getChildByFullName("dark_1.text"):setString(nameStr)
		btn:getChildByFullName("light_1.text"):setString(nameStr)

		if btn:getChildByFullName("dark_1.text1") then
			btn:getChildByFullName("dark_1.text1"):setString(nameStr1)
			btn:getChildByFullName("light_1.text1"):setString(nameStr1)
		end

		btn:addTo(self._scrollViewTab)
		btn:setPosition(cc.p(self._cellWidthTab * (i - 1), 0))

		self._tabBtns[#self._tabBtns + 1] = btn

		btn:addClickEventListener(function()
			self:onClickTabBtns(_, i)
		end)
	end

	self:setTabStatus()
end

function ShopMainMediator:setTabStatus()
	for i = 1, #self._tabBtns do
		self._tabBtns[i]:getChildByFullName("dark_1"):setVisible(i ~= self._rightTabIndex)
		self._tabBtns[i]:getChildByFullName("light_1"):setVisible(i == self._rightTabIndex)
	end
end

function ShopMainMediator:checkIsNormalShop()
	local normalShops = ConfigReader:getRecordById("ConfigValue", "Shop_ShowSequence").content
	local shop = self:getShopNormalId()

	if shop == ShopSpecialId.kShopNormal or table.indexof(normalShops, shop) then
		return true
	end

	return false
end

function ShopMainMediator:onClickTabBtns(name, tag)
	if self:checkIsNormalShop() then
		self._rightTabIndex = tag

		local shopId = self._shopTabList[self._rightTabIndex].shopId

		self._shopId = shopId

		if not kShopView[self._shopId] then
			local shopGroup = self._shopSystem:getShopGroupById(shopId)

			self._curShopItems = shopGroup:getGoodsList()

			self:setLayout()

			if not self._ignoreSound then
				AudioEngine:getInstance():playEffect("Se_Click_Tab_4", false)
			else
				self._ignoreSound = false
			end

			self:refreshView()
		end

		self:setTabStatus()
	end

	if self._ignoreSound then
		self._ignoreSound = false
	end
end

function ShopMainMediator:onClickTab(name, tag)
	self._exchange_btn:setVisible(false)

	self._leftTabIndex = tag
	self._shopId = self._leftArr[self._leftTabIndex].shopId

	self._rightTabPanel:setVisible(self:getShopNormalId() == ShopSpecialId.kShopNormal)
	self._refreshPanel:setVisible(self:getShopNormalId() == ShopSpecialId.kShopNormal)
	self:refreshData()
	self:checkIsShowShopSellView()
	self:resumeBackground()
	self:resetView()

	if kShopView[self._shopId] then
		self:setScrollView(false)

		local shopId = self:transShopNormalToShopId()

		self:refreshTopInfo(shopId)
	else
		self:setLayout()
		self:refreshView()
	end
end

function ShopMainMediator:setScrollView(status)
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()
	self._scrollView:setVisible(status)
	self._goldScrollView:removeAllChildren()
	self._goldScrollView:setVisible(not status)
end

function ShopMainMediator:resetView()
	if self._shopId == ShopSpecialId.kShopSurface then
		if self._enterData then
			self:showSurfaceShop()
		else
			self._shopSystem:requestGetSurfaceShop()
		end
	elseif self._shopId == ShopSpecialId.KShopTimelimitedmall then
		if self._enterData then
			self:showPackageShop()
		else
			self._shopSystem:requestGetPackageShop()
		end
	else
		if not self._viewCache[self._shopId] and kShopView[self._shopId] then
			local view = self:getInjector():getInstance(kShopView[self._shopId])

			if view then
				view:addTo(self._mainPanel)
				AdjustUtils.adjustLayoutUIByRootNode(view)
				view:setPosition(0, 0)

				local mediator = self:getMediatorMap():retrieveMediator(view)

				if mediator then
					view.mediator = mediator

					mediator:setupView(self)
				end

				self._viewCache[self._shopId] = view
			end
		end

		for shopId, view in pairs(self._viewCache) do
			if self._shopId == shopId then
				view:setVisible(true)
				view.mediator:refreshData({
					shopId = self._shopId,
					enterData = self._enterData,
					parentMediator = self
				})
				view.mediator:refreshView()

				self._enterData = nil
			end
		end
	end

	for shopId, view in pairs(self._viewCache) do
		if shopId ~= self._shopId then
			view.mediator:clearView()
			view:setVisible(false)
		end
	end
end

function ShopMainMediator:getCurShopId()
	return self._shopId
end

function ShopMainMediator:showSurfaceShop()
	local shopId = ShopSpecialId.kShopSurface

	if shopId ~= self._shopId then
		return
	end

	if not self._viewCache[shopId] and kShopView[shopId] then
		local view = self:getInjector():getInstance(kShopView[shopId])

		if view then
			view:addTo(self._mainPanel)
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setPosition(0, 0)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator
			end

			self._viewCache[shopId] = view
		end
	end

	self._viewCache[shopId]:setVisible(true)
	self._viewCache[shopId].mediator:refreshData()
	self._viewCache[shopId].mediator:setupView(self)

	self._enterData = nil
end

function ShopMainMediator:showPackageShop()
	local shopId = self._shopId

	if not self._viewCache[shopId] and kShopView[shopId] then
		local view = self:getInjector():getInstance(kShopView[shopId])

		if view then
			view:addTo(self._mainPanel)
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setPosition(0, 0)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:setupView(self)
			end

			self._viewCache[shopId] = view
		end
	end

	self._viewCache[shopId]:setVisible(true)

	local var_51_0 = {
		shopId = self._shopId,
		enterData = self._enterData,
		parentMediator = self,
		subId = self._data.subid
	}

	var_51_0.shopSubType = self._data.shopSubType or ""
	var_51_0.packageId = self._data.packageId

	self._viewCache[shopId].mediator:refreshData(var_51_0)
	self._viewCache[shopId].mediator:refreshView()

	self._enterData = nil
end

function ShopMainMediator:checkIsShowShopSellView()
	if not self._showSell or not self:checkIsNormalShop() then
		return
	end

	if self._shopSystem:isShowShopSellView() then
		self:showShopSellView()

		self._showSell = false
	end
end

function ShopMainMediator:setLayout()
	local shopId = self:transShopNormalToShopId()

	self:refreshTopInfo(shopId)
	self:refreshShopByTag(shopId)
	self:refreshTime(shopId)
end

function ShopMainMediator:forceRefreshRemainTime()
	local systemTime = self._shopSystem:getCurSystemTime()

	for shopId, cache in pairs(self._nodeCache) do
		local shopGroup = self._shopSystem:getShopGroupById(shopId)
		local nextTime = shopGroup:getUpdateTime()

		if nextTime and nextTime - systemTime > 0 then
			self._nodeCache[shopId].remainTime = nextTime
		end
	end
end

function ShopMainMediator:refreshShopByTag(shopId)
	local shopGroup = self._shopSystem:getShopGroupById(shopId)
	local times = shopGroup:getRemainRefreshTimes()

	self._refreshPanel:getChildByFullName("refresh_btn"):setGray(times == 0)
end

function ShopMainMediator:refreshTime(shopId)
	shopId = shopId or self:transShopNormalToShopId()

	local cache = self._nodeCache[shopId]

	if not cache then
		return
	end

	local shopGroup = self._shopSystem:getShopGroupById(shopId)
	local hasResetTime = self._shopSystem:hasResetTime(shopId)
	local maxTimes = shopGroup:getRefreshMaxTimes()

	if cache.remainTime and hasResetTime then
		self._refreshPanel:setVisible(true)

		if cache.remainTime >= 0 then
			local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
			local remainTime = cache.remainTime - remoteTimestamp
			local str = TimeUtil:formatTime("${d}:${HH}:${MM}:${SS}", remainTime)
			local strArr = string.split(str, ":")

			if tonumber(strArr[1]) > 0 then
				self._refreshTime:setString(strArr[1] .. Strings:get("TimeUtil_Day") .. strArr[2] .. Strings:get("Shop_GoldPartner_TimeUtil_Hour"))
			elseif tonumber(strArr[2]) > 0 then
				self._refreshTime:setString(strArr[2] .. Strings:get("Shop_GoldPartner_TimeUtil_Hour"))
			elseif tonumber(strArr[3]) > 0 then
				self._refreshTime:setString(strArr[3] .. Strings:get("TimeUtil_Min") .. strArr[4] .. Strings:get("TimeUtil_Sec"))
			else
				self._refreshTime:setString(strArr[4] .. Strings:get("TimeUtil_Sec"))
			end
		else
			self._refreshPanel:setVisible(false)
		end

		if maxTimes == 0 then
			self._refreshPanel:getChildByName("refresh_btn"):setVisible(false)
		else
			self._refreshPanel:getChildByName("refresh_btn"):setVisible(true)
		end
	else
		self._refreshPanel:setVisible(false)
	end
end

function ShopMainMediator:reduceTime()
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

function ShopMainMediator:onClickItem(data)
	local isOpen, lockTip, unLockLevel = data:getCondition()

	if not isOpen then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = lockTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

	local stock = data:getStock()

	if stock == 0 then
		return
	end

	self:showShopBuyViewNormal(data)

	self._curGoods = data
	self._viewOffsetX = self._scrollView:getInnerContainerPosition().x
end

function ShopMainMediator:onBackClicked()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function ShopMainMediator:onCurrencyClicked(sender, eventType)
	local shopId = self:transShopNormalToShopId()

	if self._nodeCache[shopId] and self._nodeCache[shopId].currencyTips then
		if eventType == ccui.TouchEventType.began then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._nodeCache[shopId].currencyTips:setVisible(true)
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			self._nodeCache[shopId].currencyTips:setVisible(false)
		end
	end
end

function ShopMainMediator:onTick(dt)
	self:reduceTime()
	self:refreshTime()
end

function ShopMainMediator:onClickRefresh()
	local shopId = self:transShopNormalToShopId()
	local shopGroup = self._shopSystem:getShopGroupById(shopId)
	local times = shopGroup:getRemainRefreshTimes()

	if times < 1 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("SHOP_Text_14")
		}))

		return true
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:showShopRefreshView(shopGroup)
end

function ShopMainMediator:onClickExhange()
	local data = self._bagSystem:getRepeatURItems()

	if next(data) then
		self._bagSystem:setURExchangeRedPoint(false)
		self:refreshExchangeRedpoint()
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local view = self:getInjector():getInstance("ShopURExchangeView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Shop_URMap_Button_Desc5")
		}))
	end
end

function ShopMainMediator:showShopSellView()
	local view = self:getInjector():getInstance("ShopSellView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function ShopMainMediator:showShopBuyView(data)
	local view = self:getInjector():getInstance("ShopBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemData = data
	}))
end

function ShopMainMediator:showShopBuyViewNormal(data)
	local view = self:getInjector():getInstance("ShopBuyNormalView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemData = data
	}))
end

function ShopMainMediator:showShopRefreshView(data)
	local view = self:getInjector():getInstance("ShopRefreshView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function ShopMainMediator:onBuyPackageSuccCallback(event)
	self._fresh = nil

	self:createLeftShopConfig()
	self:initLeftTabController(not self._fresh)
end

function ShopMainMediator:refreshExchangeRedpoint()
	self._exchange_btn:getChildByFullName("redpoint"):setVisible(self._shopSystem:getRedPointForShopExchange())
end

function ShopMainMediator:stopItemActions()
	if DisposableObject:isDisposed(self) then
		return
	end

	local allCells = self._scrollView:getChildren()

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					node:stopAllActions()
				end
			end
		end
	end
end

function ShopMainMediator:runListAnim()
	local v = 4
	local startCount = 1

	if self._viewOffsetX then
		startCount = math.ceil(-self._viewOffsetX / self._cellWidthNormal)
	end

	self._scrollView:setTouchEnabled(false)

	local allCells = self._scrollView:getChildren()

	for i = 1, v do
		local child = allCells[i]

		if child then
			for j = startCount, startCount + 5 do
				local node = child:getChildByTag(j)

				if node then
					node:setOpacity(0)
				end
			end
		end
	end

	local length = math.min(v, #allCells)
	local delayTime = v / 30
	local delayTime1 = math.min(delayTime, kNums / 30)

	for i = 1, v do
		local child = allCells[i]

		if child then
			local count = 1

			for j = startCount, startCount + 5 do
				local node = child:getChildByTag(j)

				if node then
					local starPosX = node:getPositionX()
					local starPosY = node:getPositionY()

					node:setPositionX(starPosX + 100)

					local time = (i - 1) * delayTime + (count - 1) * delayTime1
					local delayAction = cc.DelayTime:create(time)
					local callfunc = cc.CallFunc:create(function()
						local action1 = cc.MoveTo:create(0.1, cc.p(starPosX, starPosY))

						node:stopAllActions()
						node:runAction(action1)
					end)
					local callfunc1 = cc.CallFunc:create(function()
						node:setOpacity(255)

						if length == i then
							self._scrollView:setTouchEnabled(true)
						end
					end)
					local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

					self:getView():runAction(seq)

					count = count + 1
				end
			end
		end
	end
end

function ShopMainMediator:runGoldListAnim()
	self._goldScrollView:setTouchEnabled(false)

	local allCells = self._goldScrollView:getChildren()
	local length = #allCells
	local delayTime = 0.05

	for i = 1, length do
		local child = allCells[i]

		if child then
			local starPosX = child:getPositionX()
			local starPosY = child:getPositionY()

			child:setPositionX(starPosX + 150)

			local time = (i - 1) * delayTime
			local delayAction = cc.DelayTime:create(time)
			local callfunc = cc.CallFunc:create(function()
				local action1 = cc.MoveTo:create(0.1, cc.p(starPosX, starPosY))

				child:stopAllActions()
				child:runAction(action1)
			end)
			local callfunc1 = cc.CallFunc:create(function()
				child:setOpacity(255)

				if length == i then
					self._goldScrollView:setTouchEnabled(true)
				end
			end)
			local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

			self:getView():runAction(seq)
		end
	end
end
