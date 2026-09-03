-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopNormalMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopNormalMediator = class("ShopNormalMediator", DmAreaViewMediator, _M)

ShopNormalMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopNormalMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopNormalMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopNormalMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kNums = 2
local kCellHeight = 480
local kCellHeightTab = 50
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

function ShopNormalMediator:initialize()
	super.initialize(self)
end

function ShopNormalMediator:dispose()
	self:getView():stopAllActions()
	self:stopItemActions()
	super.dispose(self)
end

function ShopNormalMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function ShopNormalMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshByRset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PACKAGE_SUCC, self, self.onRefreshShopSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.onBuyPackageSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
end

function ShopNormalMediator:onRemove()
	super.onRemove(self)
end

function ShopNormalMediator:setupView()
	self:initMember()
	self:createRightShopConfig()
	self:initRightTabController()

	self._timer1 = LuaScheduler:getInstance():schedule(handler(self, self.onTick), 1, false)

	self:createSchel()
end

function ShopNormalMediator:onRefreshShopSuccess(event)
	self:forceRefreshRemainTime()

	local cache = self._nodeCache[self._shopId]

	if cache then
		self:refreshShopByTag(self._shopId)

		cache.isSendRefresh = nil
	end

	self:refreshShopData()
end

function ShopNormalMediator:refreshByRset(event)
	self:forceRefreshRemainTime()
	self._shopSystem:requestGetShop(self._shopId)
	self:refreshShopData()
end

function ShopNormalMediator:forceRefreshRemainTime()
	local systemTime = self._shopSystem:getCurSystemTime()

	for shopId, cache in pairs(self._nodeCache) do
		local shopGroup = self._shopSystem:getShopGroupById(shopId)
		local nextTime = shopGroup:getUpdateTime()

		if nextTime and nextTime - systemTime > 0 then
			self._nodeCache[shopId].remainTime = nextTime
		end
	end
end

function ShopNormalMediator:createSchel()
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
						local lastTime = self:refreshTimePanel(cell.panel, cell.data)

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

function ShopNormalMediator:refreshTimePanel(panel, data)
	local _infoPanel = panel:getChildByFullName("info_panel")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local _times = panel:getChildByFullName("info_panel.times")
	local _times1 = panel:getChildByFullName("info_panel.times1")
	local _duihuanText = panel:getChildByFullName("info_panel.duihuan_text")
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local noCDTime = data:getCDTime()

	if not noCDTime then
		return gameServerAgent:remoteTimestamp()
	end

	local updateTime = data:getUpdateTime()
	local lastTime = updateTime - gameServerAgent:remoteTimestamp()
	local times1 = data:getStock()
	local times2 = data:getStorage()
	local hasTime = lastTime > 0 and times1 < times2

	if hasTime then
		local str = "/" .. times2
		local timeStr = TimeUtil:formatTime("(${HH}:${MM}:${SS})", lastTime)

		_times1:setString(times1)
		_times:setString(str)
		_times1:setTextColor(cc.c3b(240, 60, 60))
		_duihuanText:setString(timeStr)
		_times1:setPositionX(_times:getPositionX() - _times:getContentSize().width)
		_duihuanText:setPositionX(_times1:getPositionX() - _times1:getContentSize().width - 2)
		self:setMarkImg(kMarkImgAndStr.RecoverMark)
		iconLayout:setColor(cc.c3b(127, 127, 127))
	end

	return lastTime
end

function ShopNormalMediator:refreshData()
	self._shopId = self:transShopNormalToShopId()

	local shopGroup = self._shopSystem:getShopGroupById(self._shopId)

	self._curShopItems = shopGroup:getGoodsList()
end

function ShopNormalMediator:transShopNormalToShopId()
	return self._shopTabList[self._rightTabIndex].shopId
end

function ShopNormalMediator:createRightShopConfig()
	local shopTabIds = ConfigReader:getRecordById("ConfigValue", "Shop_ShowSequence").content

	self._shopTabList = {}
	self._shopTabMap = {}
	self._nodeCache = {}
	self._rightTabIndex = 1

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

				local time = shopGroup:getUpdateTime()

				self._nodeCache[shopId] = {}

				if time then
					self._nodeCache[shopId].remainTime = time
				end

				if shopId == self._shopId then
					self._rightTabIndex = index
				end
			end
		end
	end
end

function ShopNormalMediator:initRightTabController()
	self._tabBtns = {}
	self._ignoreSound = true

	self._scrollViewTab:removeAllChildren()

	local length = #self._shopTabList
	local viewWidth = self._scrollViewTab:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidthTab * length)

	self._scrollViewTab:setInnerContainerSize(cc.size(allWidth, kCellHeightTab))
	self._scrollViewTab:setInnerContainerPosition(cc.p(0, 0))

	for i = 1, length do
		local nameStr = self._shopTabList[i].name[1]
		local nameStr1 = self._shopTabList[i].name[2]
		local btn = self._cellCloneTab:clone()

		btn:setVisible(true)
		btn:setTag(i)
		btn:getChildByFullName("dark_1.text"):setString(nameStr .. i)
		btn:getChildByFullName("light_1.text"):setString(nameStr .. i)

		if btn:getChildByFullName("dark_1.text1") then
			btn:getChildByFullName("dark_1.text1"):setString(nameStr1)
			btn:getChildByFullName("light_1.text1"):setString(nameStr1)
		end

		btn:addTo(self._scrollViewTab)
		btn:setPosition(cc.p(self._cellWidthTab * (i - 1), 0))

		self._tabBtns[#self._tabBtns + 1] = btn

		btn:addClickEventListener(function()
			self:onClickTabBtns(i)
		end)
	end
end

function ShopNormalMediator:reduceTime()
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

function ShopNormalMediator:onTick(dt)
	self:reduceTime()
	self:refreshTime()
end

function ShopNormalMediator:onClickTabBtns(tag)
	self._rightTabIndex = tag
	self._shopId = self._shopTabList[self._rightTabIndex].shopId

	self:refreshData()
	self:refreshView()
	self:setLayout()
end

function ShopNormalMediator:setLayout()
	self:refreshShopByTag(self._shopId)
	self:refreshTime(self._shopId)
	self._refreshPanel:setVisible(true)
end

function ShopNormalMediator:refreshShopByTag(shopId)
	local shopGroup = self._shopSystem:getShopGroupById(shopId)
	local times = shopGroup:getRemainRefreshTimes()

	self._refreshPanel:getChildByFullName("refresh_btn"):setGray(times == 0)
end

function ShopNormalMediator:refreshTime()
	local cache = self._nodeCache[self._shopId]

	if not cache then
		return
	end

	local shopGroup = self._shopSystem:getShopGroupById(self._shopId)
	local hasResetTime = self._shopSystem:hasResetTime(self._shopId)
	local maxTimes = shopGroup:getRefreshMaxTimes()

	if cache.remainTime and hasResetTime and maxTimes ~= 0 then
		self._refreshBtn:setVisible(true)
		self._refreshDesc:setVisible(true)
		self._refreshTime:setVisible(true)
		self._refreshTime1:setVisible(true)

		if cache.remainTime >= 0 then
			local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
			local remainTime = cache.remainTime - remoteTimestamp
			local str = TimeUtil:formatTime("${d}:${HH}:${MM}:${SS}", remainTime)
			local strArr = string.split(str, ":")

			self._refreshTime1:getChildByFullName("day"):setString(strArr[1])
			self._refreshTime:setString(strArr[2] .. ":" .. strArr[3] .. ":" .. strArr[4])
			self._refreshTime:setAdditionalKerning(4)

			if strArr[1] == "0" then
				self._refreshTime1:setVisible(false)
				self._refreshTime:setPositionX(self._refreshTimePosx - 43)
				self._refresh_btn:setPositionX(self._refresh_btnPosx - 25)
			else
				self._refreshTime:setPositionX(self._refreshTimePosx)
				self._refresh_btn:setPositionX(self._refresh_btnPosx)
			end
		else
			self._refreshBtn:setVisible(false)
			self._refreshDesc:setVisible(false)
			self._refreshTime:setVisible(false)
			self._refreshTime1:setVisible(false)
		end
	else
		self._refreshBtn:setVisible(false)
		self._refreshDesc:setVisible(false)
		self._refreshTime:setVisible(false)
		self._refreshTime1:setVisible(false)
	end
end

function ShopNormalMediator:initMember()
	local panel = self:getView()

	self._mainPanel = panel:getChildByFullName("main")
	self._cellClone = panel:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
	self._cellClone:getChildByFullName("cell.touch_panel"):setLocalZOrder(10)
	self._cellClone:getChildByFullName("cell.touch_panel"):setTouchEnabled(true)
	self._cellClone:getChildByFullName("cell.touch_panel"):setSwallowTouches(false)

	self._cellCloneTab = panel:getChildByFullName("tabClone")

	self._cellCloneTab:setVisible(false)

	self._refreshPanel = panel:getChildByName("refreshPanel")

	self._refreshPanel:getChildByFullName("refresh_btn"):addClickEventListener(function()
		self:onClickRefresh()
	end)

	self._refreshBtn = self._refreshPanel:getChildByFullName("refresh_btn")
	self._refreshDesc = self._refreshPanel:getChildByFullName("refresh_desc")
	self._refreshTime = self._refreshPanel:getChildByFullName("refresh_time_text")
	self._refreshTime1 = self._refreshPanel:getChildByFullName("refresh_time_text1")
	self._refreshTimePosx = self._refreshTime:getPositionX()
	self._refresh_btn = self._refreshPanel:getChildByFullName("refresh_btn")
	self._refresh_btnPosx = self._refresh_btn:getPositionX()

	self:adjustView()
end

function ShopNormalMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentWidth = winSize.width - 188 - AdjustUtils.getAdjustX()

	self._scrollView = self._mainPanel:getChildByName("scrollView")

	self._scrollView:setContentSize(cc.size(currentWidth, kCellHeight))
	self._scrollView:setScrollBarEnabled(false)

	self._cellWidth = self._cellClone:getContentSize().width
	self._cellHeight = self._cellClone:getContentSize().height
	self._scrollViewTab = self._mainPanel:getChildByName("scrollViewTab")

	self._scrollViewTab:setContentSize(cc.size(currentWidth, kCellHeightTab))
	self._scrollViewTab:setScrollBarEnabled(false)

	self._cellWidthTab = self._cellCloneTab:getContentSize().width
end

function ShopNormalMediator:clearView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()
	self._scrollViewTab:removeAllChildren()
end

function ShopNormalMediator:refreshView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()

	local length = math.ceil(#self._curShopItems / kNums)
	local viewWidth = self._scrollView:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidth * length)

	self._scrollView:setInnerContainerSize(cc.size(allWidth, kCellHeight))
	self._scrollView:setInnerContainerPosition(cc.p(0, 0))

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(self._cellWidth, kCellHeight))
		layout:addTo(self._scrollView)
		layout:setTag(i)
		layout:setAnchorPoint(cc.p(0, 0))
		layout:setPosition(cc.p(self._cellWidth * (i - 1), 10))
		layout:setTouchEnabled(false)
		self:createCell(layout, i)
	end

	self:runListAnim()
end

function ShopNormalMediator:createCell(cell, index)
	for i = 1, kNums do
		local itemIndex = kNums * (index - 1) + i
		local itemData = self._curShopItems[itemIndex]

		if itemData then
			local clonePanel = self._cellClone:clone()

			clonePanel:setVisible(true)
			cell:addChild(clonePanel)

			local z, r = math.modf(i / 2)
			local y = r == 0 and 0 or self._cellHeight

			clonePanel:setPosition(0, y)
			clonePanel:setTag(i)

			clonePanel.data = itemData
			clonePanel.panel = clonePanel:getChildByFullName("cell")

			self:setInfo(clonePanel, itemData, itemIndex)

			cell["ShopItem" .. i] = clonePanel
		end
	end
end

function ShopNormalMediator:cleanMarkImage(panel)
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

	image = panel:getChildByFullName("ImageMark")

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

function ShopNormalMediator:setInfo(panel, data, index)
	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local moneyLayout = panel:getChildByFullName("money_layout")
	local moneyIcon = moneyLayout:getChildByFullName("money_icon")
	local moneyText = moneyLayout:getChildByFullName("money")
	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickItem(sender, eventType, data)
	end)

	local moneySymbol = moneyLayout:getChildByFullName("moneySymbol")
	local _totalMoney = moneyLayout:getChildByFullName("totalMoney")
	local _lineImage = moneyLayout:getChildByFullName("lineImage")

	iconLayout:removeAllChildren()
	moneyIcon:removeAllChildren()
	self:cleanMarkImage(panel)

	local price = data:getPrice()

	price = price == 0 and Strings:get("Recruit_Free") or price

	moneyText:setString(price)

	local goldIcon = IconFactory:createResourcePic({
		id = data:getCostType()
	})

	goldIcon:addTo(moneyIcon):center(moneyIcon:getContentSize())

	local name = data:getName()

	nameText:setString(name)
	self:refreshInfo(panel, data)

	local timeTag = data:getTimeTag()

	if timeTag then
		self:setLimitDateImg()
	end

	local tagData = ItemTag[data:getTag()]

	self:setRecommendImg(panel, tagData)

	local costOff = data:getCostOff()

	if costOff ~= 1 then
		self:setDiscountImg(costOff)

		local totalPrice = data:getPrice()

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
end

function ShopNormalMediator:refreshInfo(panel, data)
	self:refreshIcon(panel, data)
	self:refreshTimes(panel, data)
end

function ShopNormalMediator:refreshTimes(panel, data)
	local _infoPanel = panel:getChildByFullName("info_panel")
	local _iconLayout = panel:getChildByFullName("icon_layout")
	local _times = panel:getChildByFullName("info_panel.times")
	local _times1 = panel:getChildByFullName("info_panel.times1")
	local _duihuanText = panel:getChildByFullName("info_panel.duihuan_text")
	local times1 = data:getStock()
	local times2 = data:getStorage()
	local resetMode = data:getResetMode()
	local hasResetMode = not not table.keyof(ResetMode, resetMode)

	_times:setVisible(hasResetMode)
	_times1:setVisible(hasResetMode)
	_duihuanText:setVisible(hasResetMode)
	_infoPanel:setVisible(hasResetMode)

	if hasResetMode then
		local str = Strings:get("SHOP_CELL_TEXT")

		if resetMode == ResetMode.kWeek or resetMode == ResetMode.kWeek1 then
			str = Strings:get("Shop_WeeklyExchange")
		elseif resetMode == ResetMode.kMonth or resetMode == ResetMode.kMonth1 then
			str = Strings:get("Shop_MonthlyExchange")
		end

		_duihuanText:setString(str)
		_times1:setTextColor(times1 == 0 and cc.c3b(240, 60, 60) or cc.c3b(255, 255, 255))
		_times:setString("/" .. times2)
		_times1:setString(times1)
		_times1:setPositionX(_times:getPositionX() - _times:getContentSize().width)
		_duihuanText:setPositionX(_times1:getPositionX() - _times1:getContentSize().width - 2)
	elseif times1 == 0 then
		self:setMarkImg(kMarkImgAndStr.OwnMark)
		_iconLayout:setColor(cc.c3b(127, 127, 127))
	end
end

function ShopNormalMediator:refreshIcon(panel, data)
	local _iconLayout = panel:getChildByFullName("icon_layout")
	local _nameText = panel:getChildByFullName("goods_name")
	local rewardInfo = data:getRewardInfo()

	if rewardInfo and rewardInfo.type == RewardType.kEquip then
		local info = data:getEquipInfo()
		local icon = IconFactory:createRewardEquipIcon(info, {
			hideLevel = true
		})

		_iconLayout:addChild(icon)
		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setPosition(cc.p(self._iconLayout:getContentSize().width / 2, _iconLayout:getContentSize().height / 2))
		GameStyle:setRarityText(_nameText, info.rarity)
	else
		local number = data:getAmount()
		local info = {
			id = data:getItemId(),
			amount = number
		}
		local icon = IconFactory:createIcon(info)

		_iconLayout:addChild(icon)
		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setPosition(cc.p(_iconLayout:getContentSize().width / 2, _iconLayout:getContentSize().height / 2))
		GameStyle:setQualityText(_nameText, data:getQuality())
	end
end

function ShopNormalMediator:setDiscountImg(panel, costOff)
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

function ShopNormalMediator:setRecommendImg(panel, tagData)
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

function ShopNormalMediator:setLimitDateImg(panel, time)
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

function ShopNormalMediator:setMarkImg(panel, type)
	local image = panel:getChildByFullName("ImageMark")

	if not type then
		if image then
			image:removeFromParent()
		end

		return
	end

	if not image then
		image = cc.Node:create()

		image:addTo(panel)
		image:setName("ImageMark")

		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 22)

		label:addTo(image)
		label:setName("TipMark")
		label:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 2)
	end

	local position = cc.p(63, 83)

	image:setPosition(position)
	image:getChildByFullName("TipMark"):setString(type)
end

function ShopNormalMediator:refreshShopData()
	self:refreshData()
	self:refreshView()

	local offsetY = self._scrollView:getInnerContainerPosition().y

	self._scrollView:setInnerContainerPosition(cc.p(0, offsetY))

	local offsetY = self._scrollViewTab:getInnerContainerPosition().y

	self._scrollViewTab:setInnerContainerPosition(cc.p(0, offsetY))
end

function ShopNormalMediator:onClickItem(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		local view = self:getInjector():getInstance("ShopPackageView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopId = ShopSpecialId.KShopTimelimitedmall,
			item = data
		}))
	end
end

function ShopNormalMediator:onBuyPackageSuccCallback(event)
	self:refreshShopData()
end

function ShopNormalMediator:stopItemActions()
	if self._scrollView then
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
end

function ShopNormalMediator:runListAnim()
	if not self._scrollView then
		return
	end

	self._scrollView:setTouchEnabled(false)

	local allCells = self._scrollView:getChildren()

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
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

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
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

function ShopNormalMediator:onClickRefresh()
	local shopGroup = self._shopSystem:getShopGroupById(self._shopId)
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

function ShopNormalMediator:showShopRefreshView(data)
	local view = self:getInjector():getInstance("ShopRefreshView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end
