-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopResetMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopResetMediator = class("ShopResetMediator", DmAreaViewMediator, _M)

ShopResetMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopResetMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopResetMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopResetMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kNums = 1
local kCellHeight = 510
local kCellHeightTab = 60
local ItemTag = {
	Hot = {
		bg = "common_bg_xb_2.png",
		text = Strings:get("shop_UI20"),
		outline = cc.c4b(139, 27, 27, 255)
	},
	Recommend = {
		bg = "common_bg_xb_2.png",
		text = Strings:get("shop_UI25"),
		outline = cc.c4b(139, 27, 27, 255)
	},
	New = {
		bg = "common_bg_xb_1.png",
		text = Strings:get("shop_UI26"),
		outline = cc.c4b(58, 86, 8, 255)
	},
	Limit = {
		bg = "common_bg_xb_1.png",
		text = Strings:get("shop_UI27"),
		outline = cc.c4b(58, 86, 8, 255)
	}
}
local kMarkImgAndStr = {
	SoldOutMark = Strings:get("shop_UI16"),
	RecoverMark = Strings:get("shop_UI17"),
	OwnMark = Strings:get("shop_UI21")
}

function ShopResetMediator:initialize()
	super.initialize(self)
end

function ShopResetMediator:dispose()
	self:getView():stopAllActions()
	self:stopItemActions()
	self:stopTimer()
	super.dispose(self)
end

function ShopResetMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function ShopResetMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.onBuyPackageSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
end

function ShopResetMediator:onRemove()
	super.onRemove(self)
end

function ShopResetMediator:setupView()
	self:initMember()
	self:createRightShopConfig()
	self:initRightTabController()
end

function ShopResetMediator:createRightShopConfig()
	self._shopTabList = {}
	self._rightTabIndex = 1
	self._shopTabList[1] = {
		shopId = kShopResetTypeSort[1],
		name = {
			Strings:get("Shop_Tab_Day"),
			""
		}
	}
	self._shopTabList[2] = {
		shopId = kShopResetTypeSort[2],
		name = {
			Strings:get("Shop_Tab_Week"),
			""
		}
	}
	self._shopTabList[3] = {
		shopId = kShopResetTypeSort[3],
		name = {
			Strings:get("Shop_Tab_Month"),
			""
		}
	}
end

function ShopResetMediator:initRightTabController()
	self._tabBtns = {}

	self._scrollViewTab:removeAllChildren()

	local length = #self._shopTabList
	local viewWidth = self._scrollViewTab:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidthTab * length)

	self._scrollViewTab:setInnerContainerSize(cc.size(allWidth, kCellHeightTab))
	self._scrollViewTab:setInnerContainerPosition(cc.p(0, 2))

	for i = 1, length do
		local nameStr = self._shopTabList[i].name[1]
		local nameStr1 = self._shopTabList[i].name[2]
		local btn = self._cellCloneTab:clone()

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

		btn.data = self._shopTabList[i]
		self._tabBtns[#self._tabBtns + 1] = btn

		btn:addClickEventListener(function()
			self:onClickTabBtns(_, i)
		end)

		local redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(btn):posite(149, 35)
		redPoint:setLocalZOrder(99900)
		redPoint:setName("redPoint" .. btn.data.shopId)
	end

	self:setTabStatus()
end

function ShopResetMediator:onClickTabBtns(name, tag)
	self._rightTabIndex = tag

	self:setData()
	self:refreshView()
	self:setTabStatus()
end

function ShopResetMediator:setTabStatus()
	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]

		btn:getChildByFullName("dark_1"):setVisible(i ~= self._rightTabIndex)
		btn:getChildByFullName("light_1"):setVisible(i == self._rightTabIndex)
		btn:getChildByFullName("redPoint" .. btn.data.shopId):setVisible(false)
		self:setRedPointBar(btn)
	end
end

function ShopResetMediator:setRedPointBar(btn)
	local package = self._shopSystem:getFreePackage()

	for i = 1, #package do
		local packageType = package[i]:getTimeTypeType()

		if btn.data.shopId == packageType then
			btn:getChildByFullName("redPoint" .. btn.data.shopId):setVisible(true)
		end
	end
end

function ShopResetMediator:refreshData(data)
	self._parentMediator = data.parentMediator or nil
	self._enterData = data.enterData or nil

	self:setData()
end

function ShopResetMediator:setData()
	self._shopId = self._shopTabList[self._rightTabIndex].shopId
	self._curShopItems = self._shopSystem:getPackageList(kShopResetTypeSort[self._rightTabIndex])
end

function ShopResetMediator:urlEnter()
	if self._enterData and self._enterData.packageId then
		for i = 1, 3 do
			local data = self._shopSystem:getPackageList(kShopResetTypeSort[i])

			for j = 1, #data do
				if data[j]:getId() == self._enterData.packageId then
					self:onClickTabBtns(_, i)

					local offsetY = self._scrollView:getInnerContainerPosition().y
					local offsetX = self._scrollView:getInnerContainerPosition().x
					local cell = self._cells["cell" .. self._enterData.packageId]
					local x = cell:getPositionX()

					if x < offsetX or x > self._scrollView:getContentSize().width then
						self._scrollView:setInnerContainerPosition(cc.p(-self._cellWidth * (j - 1), offsetY))
					end

					self:onClickItem(_, ccui.TouchEventType.began, data[j])
					self:onClickItem(_, ccui.TouchEventType.ended, data[j])

					self._enterData = nil

					return true
				end
			end
		end
	end

	return false
end

function ShopResetMediator:initMember()
	local panel = self:getView()

	self._cellClone = panel:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._mainPanel = panel:getChildByFullName("main")

	self._cellClone:getChildByFullName("cell.rewardPanel"):setTouchEnabled(false)

	self._cellCloneTab = panel:getChildByFullName("tabClone")

	self._cellCloneTab:setVisible(false)

	self._refreshPanel = panel:getChildByFullName("refreshPanel")
	self._refreshTime = self._refreshPanel:getChildByFullName("refresh_time_text")
	self._refreshTime1 = self._refreshPanel:getChildByFullName("refresh_time_text1")

	self._refreshTime1:setVisible(false)
	self:adjustView()
end

function ShopResetMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentWidth = winSize.width - 188 - AdjustUtils.getAdjustX()

	self._scrollView = self._mainPanel:getChildByName("scrollView")

	self._scrollView:setContentSize(cc.size(currentWidth, kCellHeight))
	self._scrollView:setScrollBarEnabled(false)

	self._scrollViewTab = self._mainPanel:getChildByName("scrollViewTab")

	self._scrollViewTab:setContentSize(cc.size(currentWidth, kCellHeightTab))
	self._scrollViewTab:setScrollBarEnabled(false)

	self._cellWidthTab = self._cellCloneTab:getContentSize().width
	self._cellWidth = self._cellClone:getContentSize().width
end

function ShopResetMediator:clearView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()
	self:stopTimer()
end

function ShopResetMediator:refreshView()
	self:setTimer()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()

	local length = math.ceil(#self._curShopItems / kNums)
	local viewWidth = self._scrollView:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidth * length)

	self._scrollView:setInnerContainerSize(cc.size(allWidth, kCellHeight))
	self._scrollView:setInnerContainerPosition(cc.p(0, 0))

	self._cells = {}

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(self._cellWidth, kCellHeight))
		layout:addTo(self._scrollView)
		layout:setTag(i)
		layout:setAnchorPoint(cc.p(0, 1))
		layout:setPosition(cc.p(self._cellWidth * (i - 1), kCellHeight))
		layout:setTouchEnabled(false)
		self:createCell(layout, i)
	end

	if not self:urlEnter() then
		self:runListAnim()
	end
end

function ShopResetMediator:createCell(cell, index)
	for i = 1, kNums do
		local itemIndex = kNums * (index - 1) + i
		local itemData = self._curShopItems[itemIndex]

		if itemData then
			local clonePanel = self._cellClone:clone()

			clonePanel:setVisible(true)
			cell:addChild(clonePanel)
			clonePanel:setPosition((i - 1) * self._cellWidth, 0)
			clonePanel:setTag(i)
			self:setInfo(clonePanel, itemData, itemIndex)

			self._cells["cell" .. itemData:getId()] = cell
		end
	end
end

function ShopResetMediator:cleanMarkImage(panel)
	local image = panel:getChildByFullName("DiscountMark")

	if image then
		image:removeFromParent()

		return
	end

	image = panel:getChildByFullName("RecommendMark")

	if image then
		image:removeFromParent()

		return
	end

	image = panel:getChildByFullName("LimitDateMark")

	if image then
		image:removeFromParent()

		return
	end

	image = panel:getChildByFullName("RechargeBonusMark")

	if image then
		image:removeFromParent()

		return
	end
end

function ShopResetMediator:setInfo(panel, data, index)
	panel = panel:getChildByFullName("cell")

	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local moneyLayout = panel:getChildByFullName("money_layout")
	local moneyText = moneyLayout:getChildByFullName("money")
	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickItem(sender, eventType, data)
	end)

	local moneySymbol = moneyLayout:getChildByFullName("moneySymbol")
	local _totalMoney = moneyLayout:getChildByFullName("totalMoney")
	local _lineImage = moneyLayout:getChildByFullName("lineImage")

	iconLayout:removeAllChildren()
	self:cleanMarkImage(panel)

	local name = data:getName()

	nameText:setString(name)

	local iconPath = data:getIcon()
	local icon = ccui.ImageView:create(iconPath, 1)

	iconLayout:addChild(icon)
	icon:setAnchorPoint(cc.p(0.5, 0.5))

	local pos = cc.p(iconLayout:getContentSize().width / 2, iconLayout:getContentSize().height / 2 - 5)

	icon:setPosition(pos)
	icon:setScale(0.7)
	GameStyle:setQualityText(nameText, data:getQuality())
	nameText:setScale(0.9)
	self:refreshPackageTime(panel, data)

	local timeTag = data:getTimeTag()

	if timeTag then
		self:setLimitDateImg(panel)
	end

	local isFree = data:getIsFree()
	local symbol, price = data:getPaySymbolAndPrice(data:getPayId())

	if isFree == 1 then
		moneyText:setString(Strings:get("Recruit_Free"))
		moneySymbol:setString("")
		moneyText:setPositionX(80)
		moneyText:setPositionY(10)
		moneyText:setFontSize(23)
	else
		moneyText:setString(price)
		moneySymbol:setString(symbol)
	end

	local name = data:getName()
	local costOff = data:getCostOff()

	if costOff ~= 1 then
		self:setDiscountImg(costOff)

		local totalPrice = price

		if costOff * 10 ~= 0 then
			totalPrice = math.ceil(totalPrice / costOff)
		end

		_totalMoney:setString(totalPrice)
		_totalMoney:setVisible(true)
		_lineImage:setVisible(true)
	else
		_totalMoney:setString("")
		_totalMoney:setVisible(false)
		_lineImage:setVisible(false)
	end

	local width = _totalMoney:getContentSize().width

	if _totalMoney:isVisible() then
		_lineImage:setContentSize(cc.size(width + 16, 16))
	end

	self:addRedPoint(panel, data)

	local rewardPanel = panel:getChildByFullName("rewardPanel")

	rewardPanel:removeAllChildren()
	rewardPanel:setTouchEnabled(true)
	rewardPanel:setSwallowTouches(true)

	local rewardId = data:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)
	local offset = #rewards == 1 and 65 or #rewards == 2 and 31 or 0

	for i = 1, 3 do
		local reward = rewards[i]

		if reward then
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				isWidget = true
			})

			rewardPanel:addChild(rewardIcon)
			rewardIcon:setScaleNotCascade(0.5)
			rewardIcon:setPositionX((i - 1) * 62 + offset)
			rewardIcon:setAnchorPoint(0, 0)
			IconFactory:bindClickHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
				touchDisappear = true,
				swallowTouches = true
			})
		end
	end
end

function ShopResetMediator:addRedPoint(panel, data)
	local package = self._shopSystem:getFreePackage()

	for i = 1, #package do
		local packageId = package[i]:getId()

		if data:getId() == packageId then
			local redPoint = panel:getChildByName("redPoint" .. packageId)

			if not redPoint then
				redPoint = RedPoint:createDefaultNode()

				redPoint:addTo(panel):posite(190, 484)
				redPoint:setLocalZOrder(99900)
				redPoint:setName("redPoint" .. packageId)
			end
		end
	end
end

function ShopResetMediator:setDiscountImg(panel, costOff)
	local image = panel:getChildByFullName("DiscountMark")

	if not costOff then
		if image then
			image:removeFromParent()
		end

		return
	end

	if not image then
		image = ccui.ImageView:create()

		image:addTo(panel)
		image:setName("DiscountMark")

		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

		label:addTo(image)
		label:setPosition(cc.p(26, 19))
		label:setName("TipMark")
	end

	local position = cc.p(25, 127)

	image:setPosition(position)

	local label = image:getChildByFullName("TipMark")

	if costOff > 0.2 then
		image:loadTexture("asset/common/common_bg_xb_4.png")
		label:enableOutline(cc.c4b(139, 27, 27, 255), 2)
	else
		image:loadTexture("asset/common/common_bg_xb_3.png")
		label:enableOutline(cc.c4b(58, 86, 8, 255), 2)
	end

	label:setString(costOff * 10 .. Strings:get("SHOP_COST_OFF_TEXT10"))
end

function ShopResetMediator:setRecommendImg(panel, tagData)
	local image = panel:getChildByFullName("RecommendMark")

	if not tagData then
		if image then
			image:removeFromParent()
		end

		return
	end

	if not image then
		image = ccui.ImageView:create()

		image:addTo(panel)
		image:setName("RecommendMark")

		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

		label:addTo(image)
		label:setPosition(cc.p(22, 24))
		label:setName("TipMark")
	end

	local position = cc.p(123, 128)

	image:setPosition(position)

	local str = tagData.text
	local outline = tagData.outline
	local bg = tagData.bg

	image:loadTexture("asset/common/" .. bg)

	local label = image:getChildByFullName("TipMark")

	label:setString(str)
	label:enableOutline(outline, 2)
end

function ShopResetMediator:setLimitDateImg(panel, time)
	local image = panel:getChildByFullName("LimitDateMark")

	if not time then
		if image then
			image:removeFromParent()
		end

		return
	end

	if not image then
		image = ccui.ImageView:create("asset/common/common_bg_xb_5.png")

		image:addTo(panel)
		image:setName("LimitDateMark")

		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

		label:addTo(image)
		label:setPosition(cc.p(55, 30))
		label:setName("TipMark")
	end

	local position = cc.p(223, 123)

	image:setPosition(position)
	image:getChildByFullName("TipMark"):setString(time)
end

function ShopResetMediator:refreshPackageTime(panel, data)
	local infoPanel = panel:getChildByFullName("info_panel")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local _times = panel:getChildByFullName("info_panel.times")
	local _times1 = panel:getChildByFullName("info_panel.times1")
	local _duihuanText = panel:getChildByFullName("info_panel.duihuan_text")
	local _mageMark = panel:getParent():getChildByFullName("ImageMark")

	_mageMark:setVisible(false)

	local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
	local start = data:getStartMills()
	local end_ = data:getEndMills()
	local times1 = data:getLeftCount()
	local times2 = data:getStorage()

	if times1 == -1 then
		infoPanel:setVisible(false)

		return
	end

	if curTime < start or end_ < curTime or times1 <= 0 then
		_mageMark:setVisible(true)
		panel:setColor(cc.c3b(125, 125, 125))
		_times:setVisible(false)
		_times1:setVisible(false)
		_duihuanText:setVisible(false)
		infoPanel:setVisible(false)

		return
	end

	_times:setVisible(true)
	_duihuanText:setVisible(true)
	infoPanel:setVisible(true)
	_times:setString(times1 .. "/" .. times2)
end

function ShopResetMediator:refreshShopData()
	self:setData()

	local offsetY = self._scrollView:getInnerContainerPosition().y

	self:refreshView()
	self._scrollView:setInnerContainerPosition(cc.p(0, offsetY))
	self:setTabStatus()
end

function ShopResetMediator:onClickItem(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		local times1 = data:getLeftCount()

		if times1 == 0 then
			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		local view = self:getInjector():getInstance("ShopBuyPackageView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopId = ShopSpecialId.KShopTimelimitedmall,
			item = data
		}))
	end
end

function ShopResetMediator:onBuyPackageSuccCallback(event)
	self:refreshShopData()
end

function ShopResetMediator:stopItemActions()
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

function ShopResetMediator:runListAnim()
	self._scrollView:setTouchEnabled(false)

	local allCells = self._scrollView:getChildren()

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
				local node = child:getChildByTag(j)

				if node then
					node:setOpacity(0)
				end
			end
		end
	end

	local length = math.min(5, #allCells)
	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
				local node = child:getChildByTag(j)

				if node then
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

function ShopResetMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self._refreshPanel:setVisible(false)
end

function ShopResetMediator:setTimer()
	self:stopTimer()

	if #self._curShopItems == 0 or not self._shopId then
		return
	end

	self._refreshPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._shopSystem:getResetShopEndMills(self._shopId)

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			endMills = self._shopSystem:getResetShopEndMills(self._shopId)

			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				performWithDelay(self:getView(), function()
					self:stopTimer()
					self._shopSystem:requestGetPackageShop()
				end, 0.5)

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			self._refreshTime:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
			self._refreshPanel:setVisible(true)
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end
