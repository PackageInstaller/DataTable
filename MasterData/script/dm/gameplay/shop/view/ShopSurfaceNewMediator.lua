-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopSurfaceNewMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopSurfaceNewMediator = class("ShopSurfaceNewMediator", DmAreaViewMediator, _M)

ShopSurfaceNewMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopSurfaceNewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.buyBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBuy"
	}
}

function ShopSurfaceNewMediator:initialize()
	super.initialize(self)
end

function ShopSurfaceNewMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self:getView():stopAllActions()
	super.dispose(self)
end

function ShopSurfaceNewMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initMember()

	self._heroSystem = self._developSystem:getHeroSystem()
end

function ShopSurfaceNewMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_REFRESH_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHBYGOLDORDIMOND_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_BUY_SUCC, self, self.onBuyShopSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_SURFACE_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.refreshView)
end

function ShopSurfaceNewMediator:onRemove()
	super.onRemove(self)
end

function ShopSurfaceNewMediator:refreshData()
	self._curShopItems = self._shopSystem:getSurfaceList()
	self._selectIndex = self._selectIndex or 1

	if self._curSurface then
		local id = self._curSurface:getId()

		for i = 1, #self._curShopItems do
			if self._curShopItems[i]:getId() == id then
				self._selectIndex = i

				break
			end
		end

		self._curSurface = self._curShopItems[self._selectIndex]
	else
		self._curSurface = self._curShopItems[self._selectIndex]
	end

	self._packageItems = self._shopSystem:getPackageList(ShopSpecialId.kShopSurfacePackage)
end

function ShopSurfaceNewMediator:setupView()
	self:getView():stopAllActions()
	self._scrollView:removeAllChildren()
	AdjustUtils.adjustLayoutByType(self._scrollView, AdjustUtils.kAdjustType.Right)

	local length = #self._curShopItems

	self._items = {}

	self._scrollView:setInnerContainerPosition(cc.p(0, 0))

	for i = 1, length do
		self:createCell(self._scrollView, i)
	end

	self._scrollView:setBounceEnabled(true)

	local innerWidth = (length + 1) * self._cellWidth + length * self._cellOffsetX

	if innerWidth > self._scrollView:getContentSize().width then
		self._scrollView:setInnerContainerSize(cc.size(innerWidth, self._cellHeight))
		self._scrollView:setMaxBounceOffset(20)
	else
		self._scrollView:setMaxBounceOffset(0.001)
	end

	self:refreshRolePanel()
	self:refreshPackage()
	self:setInfoCellStates()
	self:runMainAnim()
end

function ShopSurfaceNewMediator:initMember()
	local panel = self:getView()

	self._cellClone = panel:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._mainPanel = panel:getChildByFullName("main")

	self._cellClone:getChildByFullName("cell.touch_panel"):setLocalZOrder(10)
	self._cellClone:getChildByFullName("cell.touch_panel"):setTouchEnabled(true)
	self._cellClone:getChildByFullName("cell.touch_panel"):setSwallowTouches(false)

	self._limitPanel = self._mainPanel:getChildByFullName("limitPanel")

	self._limitPanel:setVisible(false)

	self._roleNode = self._mainPanel:getChildByFullName("roleNode")
	self._buyBtn = self._mainPanel:getChildByFullName("buyBtn")
	self._costNode = self._mainPanel:getChildByFullName("costNode")
	self._moneyText = self._costNode:getChildByFullName("text")
	self._moneyIcon = self._costNode:getChildByFullName("icon")

	local iconLayout = self._cellClone:getChildByFullName("cell.icon_layout")

	self._posY = iconLayout:getContentSize().height / 2
	self._scrollView = self._mainPanel:getChildByFullName("rightPanel.scrollView")

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setInertiaScrollEnabled(false)
	self._scrollView:scrollToPercentHorizontal(0, 0.1, false)
	self._scrollView:onScroll(function(event)
		self:onScroll(event)
	end)
	self._scrollView:onTouch(function(event)
		self:onTouch(event)
	end)

	self._cellWidth = self._cellClone:getContentSize().width
	self._cellHeight = self._cellClone:getContentSize().height
	self._scrollWidth = self._scrollView:getContentSize().width
	self._scrollHeight = self._scrollView:getContentSize().height
	self._cellOffsetX = -50
end

function ShopSurfaceNewMediator:onBuyShopSuccess(event)
	local data = event:getData()

	if data.rewards then
		local view = self:getInjector():getInstance("GetSurfaceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			surfaceId = data.rewards[1].code
		}))
	end

	self:refreshView()
	self:scrollToCurIndex(self._selectIndex)
end

function ShopSurfaceNewMediator:refreshView()
	self:refreshData()
	self:setupView()
end

function ShopSurfaceNewMediator:clearView()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self._selectIndex = nil
	self._curSurface = nil

	self:getView():stopAllActions()
	self._scrollView:removeAllChildren()
end

function ShopSurfaceNewMediator:refreshItemPanel()
	self._curPanel = self._items[self._selectIndex]
end

function ShopSurfaceNewMediator:refreshRolePanel()
	self._roleId = self._curSurface:getTargetHeroId()

	self._roleNode:removeAllChildren()

	local roleModel = self._curSurface:getModel()
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	})

	self._roleNode:addChild(img)
	img:setPosition(cc.p(70, -100))

	local function createRole()
		local roleNode = self._mainPanel:getChildByFullName("standRole.roleNode")

		roleNode:removeAllChildren()

		local model = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Model")
		local role = RoleFactory:createRoleAnimation(model)

		role:addTo(roleNode):posite(0, -5)
		role:setScale(0.7)
	end

	delayCallByTime(0, createRole)

	local price = self._curSurface:getPrice()

	price = price == 0 and Strings:get("Recruit_Free") or price

	self._moneyText:setString(price)

	local goldIcon = IconFactory:createResourcePic({
		id = self._curSurface:getCostType()
	})

	goldIcon:addTo(self._moneyIcon)

	if self._curSurface:getStock() == 0 then
		self._buyBtn:setVisible(false)
		self._costNode:setVisible(false)
	else
		self._buyBtn:setVisible(true)
		self._costNode:setVisible(true)
	end

	self:setRecommendImg()
end

function ShopSurfaceNewMediator:createCell(cell, index)
	local itemIndex = index
	local itemData = self._curShopItems[itemIndex]

	if itemData then
		local clonePanel = self._cellClone:clone()

		clonePanel:setVisible(true)
		cell:addChild(clonePanel)

		local posX = (self._cellWidth + self._cellOffsetX) * (itemIndex - 1) - self._cellOffsetX / 2

		clonePanel:setPosition(posX, 0)
		clonePanel:setTag(index)
		self:setInfo(clonePanel, itemData, itemIndex)
		clonePanel:setSwallowTouches(false)
		clonePanel:addClickEventListener(function()
			self:scrollToCurIndex(index)
		end)

		if itemIndex == self._selectIndex then
			self._curPanel = clonePanel
		end

		self._items[itemIndex] = clonePanel
	end
end

function ShopSurfaceNewMediator:setInfo(panel, data, index)
	panel = panel:getChildByFullName("cell")

	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local heroText = panel:getChildByFullName("hero_name")
	local limitIcon = panel:getChildByFullName("limitIcon")
	local imageMark = panel:getChildByFullName("imageMark")
	local bg = panel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)

	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:setVisible(false)

	local posY = self._posY
	local color = cc.c3b(255, 255, 255)
	local times1 = data:getStock()

	imageMark:setVisible(false)

	if times1 == 0 then
		imageMark:setVisible(true)

		color = cc.c3b(125, 125, 125)
	end

	panel:setColor(color)

	local name = data:getName()

	nameText:setString(name)
	iconLayout:removeAllChildren()

	local heroImg = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe7_2",
		id = data:getModel()
	})

	heroImg:addTo(iconLayout):center(iconLayout:getContentSize())
	heroImg:setName("HeroIcon")
	heroImg:setPositionY(posY)
	heroImg:setScale(0.72)

	local roleModel = ConfigReader:getDataByNameIdAndKey("RoleModel", data:getModel(), "Name")

	heroText:setString(Strings:get(roleModel))

	local isLimit = data:getIsLimit()

	limitIcon:setVisible(isLimit)
end

function ShopSurfaceNewMediator:onClickItem(index)
	if index == self._selectIndex then
		return
	end

	self._selectIndex = index
	self._curSurface = self._curShopItems[self._selectIndex]

	self:refreshItemPanel()
	self:refreshRolePanel()
end

function ShopSurfaceNewMediator:onClickBuy()
	local times1 = self._curSurface:getStock()

	if times1 == 0 then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

	local view = self:getInjector():getInstance("ShopBuySurfaceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		item = self._curSurface
	}))
end

function ShopSurfaceNewMediator:setRecommendImg(panel, tagData)
	local isLimit = self._curSurface:getIsLimit()

	if not isLimit or self._curSurface:getStock() == 0 then
		if self._timer then
			self._timer:stop()

			self._timer = nil
		end

		self._limitPanel:setVisible(false)

		return
	end

	self._limitPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._curSurface:getEndMills()

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			endMills = self._curSurface:getEndMills()

			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				performWithDelay(self:getView(), function()
					self._shopSystem:requestGetSurfaceShop()
					self._timer:stop()

					self._timer = nil

					self._limitPanel:setVisible(false)
				end, 0.5)

				return
			end

			local str = ""
			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

			self._limitPanel:getChildByFullName("time"):setString(Strings:get("shop_UI45", {
				time = str
			}))
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ShopSurfaceNewMediator:runMainAnim()
	self._mainPanel:stopAllActions()

	local action1 = cc.CSLoader:createTimeline("asset/ui/shopSurfaceNew.csb")

	self._mainPanel:runAction(action1)
	action1:clearFrameEventCallFunc()
	action1:gotoFrameAndPlay(0, 30, false)
	action1:setTimeSpeed(1)
end

function ShopSurfaceNewMediator:onClickPackageItem(data)
	if data:getLeftCount() == 0 then
		return
	end

	local view = self:getInjector():getInstance("ShopBuyPackageView")

	if view then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopId = ShopSpecialId.KShopTimelimitedmall,
			item = data
		}))
	end
end

function ShopSurfaceNewMediator:refreshPackage()
	local data = self._packageItems[1]
	local panel = self._mainPanel:getChildByFullName("rightPanel.package.cell")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local money_icon = panel:getChildByFullName("money_layout.money_icon")

	money_icon:removeAllChildren()

	local moneyText = panel:getChildByFullName("money_layout.money")
	local isFree = data:getIsFree()
	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:addClickEventListener(function()
		self:onClickPackageItem(data)
	end)
	nameText:setString(data:getName())
	GameStyle:setQualityText(nameText, data:getQuality(), true)

	if isFree == 1 then
		moneyText:setString(Strings:get("Recruit_Free"))
	elseif isFree == 2 then
		moneyText:setString(tostring(data:getGameCoin().amount))

		local goldIcon = IconFactory:createResourcePic({
			id = data:getGameCoin().type
		})

		goldIcon:addTo(money_icon):center(money_icon:getContentSize()):offset(0, 0)
		money_icon:setPositionX(moneyText:getPositionX() - moneyText:getContentSize().width / 2 - 10)
	else
		local symbol, price = data:getPaySymbolAndPrice(data:getPayId())

		moneyText:setString(symbol .. price)
	end

	iconLayout:removeAllChildren()
	iconLayout:setAnchorPoint(cc.p(0.5, 0.5))

	local icon = ccui.ImageView:create(data:getIcon(), ccui.TextureResType.localType)

	iconLayout:addChild(icon)
	icon:setAnchorPoint(cc.p(0.5, 0.5))

	local pos = cc.p(iconLayout:getContentSize().width / 2, iconLayout:getContentSize().height / 2 - 5)

	icon:setPosition(pos)
	icon:setScale(0.6)
	self:refreshPackageTime(panel, data)
end

function ShopSurfaceNewMediator:refreshPackageTime(panel, data)
	local infoPanel = panel:getChildByFullName("info_panel")
	local _duihuanText = panel:getChildByFullName("info_panel.duihuan_text")
	local mageMark = self._mainPanel:getChildByFullName("rightPanel.package.ImageMark")

	mageMark:setVisible(false)

	local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
	local start = data:getStartMills()
	local end_ = data:getEndMills()
	local times1 = data:getLeftCount()
	local times2 = data:getStorage()

	if times1 == -1 then
		infoPanel:setVisible(false)

		return
	end

	infoPanel:setVisible(true)

	if curTime < start or end_ < curTime or times1 <= 0 then
		mageMark:setVisible(true)
		panel:setColor(cc.c3b(127, 127, 127))
		_duihuanText:setVisible(false)
		infoPanel:setVisible(false)

		return
	end

	_duihuanText:setVisible(true)
	infoPanel:setVisible(true)
	_duihuanText:setString(Strings:get("Shop_BuyNumLimit") .. "(" .. times1 .. "/" .. times2 .. ")")
end

function ShopSurfaceNewMediator:onScroll(event)
	if event.name == "CONTAINER_MOVED" then
		self:setInfoCellStates()
	end
end

function ShopSurfaceNewMediator:onTouch(event)
	if event.name == "moved" then
		self._isMoving = true
	end

	if (event.name == "ended" or event.name == "cancelled") and self._isMoving then
		local scrollPosX = self._scrollView:getInnerContainerPosition().x
		local curIndex = math.floor(math.abs(scrollPosX) / (self._cellWidth + self._cellOffsetX) + 0.5) + 1

		self:scrollToCurIndex(curIndex)

		self._isMoving = false
	end
end

function ShopSurfaceNewMediator:setInfoCellStates()
	for i = 1, #self._curShopItems do
		local v = self._scrollView:getChildByTag(i)

		if v then
			local order = 1000
			local scrollPosX = self._scrollView:getInnerContainerPosition().x
			local posX = v:getPositionX()
			local absPos = math.abs(posX - math.abs(scrollPosX) + self._cellOffsetX / 2)
			local scaleNew = 1 - absPos / (self._cellWidth + self._cellOffsetX) * 0.2

			v:setScale(scaleNew)

			local colorOps = math.max(1 - absPos / (self._cellWidth + self._cellOffsetX) * 0.4, 0)
			local colorNew = cc.c3b(255 * colorOps, 255 * colorOps, 255 * colorOps)

			v:setColor(colorNew)
			v:setLocalZOrder(order + colorOps * 100)
		end
	end
end

function ShopSurfaceNewMediator:scrollToCurIndex(curIndex)
	dump(curIndex, "curIndex >>>>>>>>")

	if self._selectIndex ~= curIndex then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local index = math.min(#self._curShopItems, curIndex)

		self:onClickItem(index)
	end

	local posX = -(self._cellWidth + self._cellOffsetX) * (curIndex - 1)

	self._scrollView:setInnerContainerPosition(cc.p(posX, 0))
end
