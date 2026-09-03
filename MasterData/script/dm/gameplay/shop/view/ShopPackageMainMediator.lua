-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopPackageMainMediator.lua

ShopPackageMainMediator = class("ShopPackageMainMediator", DmAreaViewMediator, _M)

ShopPackageMainMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopPackageMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopPackageMainMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopPackageMainMediator:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")
ShopPackageMainMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ShopPackageMainMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopPackageMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kNums = 3
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

function ShopPackageMainMediator:initialize()
	super.initialize(self)
end

function ShopPackageMainMediator:dispose()
	self:clearView()
	super.dispose(self)
end

function ShopPackageMainMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function ShopPackageMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.onBuyPackageSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
end

function ShopPackageMainMediator:onRemove()
	super.onRemove(self)
end

function ShopPackageMainMediator:setupView()
	self._timer = {}

	self:initMember()
end

function ShopPackageMainMediator:refreshData(data)
	self._shopId = data.shopId or nil
	self._shopSubType = data.shopSubType or ""

	self:createRightShopConfig()
	self:initRightTabController()

	self._rightTabIndex = data.rightTabIndex or 1
	self._subId = data.subId or nil

	if self._subId then
		for i = 1, #self._shopTabList do
			if self._shopTabList[i].shopId == self._subId then
				self._rightTabIndex = i
			end
		end
	end

	if self._shopSubType then
		for i = 1, #self._shopTabList do
			if self._shopTabList[i].shopSubType == self._shopSubType then
				self._rightTabIndex = i
			end
		end
	end

	self._packageId = data.packageId or nil

	if self._packageId then
		for i = 1, #self._shopTabList do
			local items = self._shopSystem:getPackageList(self._shopTabList[i].shopId)

			for j = 1, #items do
				if items[j]:getId() == self._packageId then
					self._rightTabIndex = i
				end
			end
		end
	end

	if self._shopId == ShopSpecialId.kShopReset or self._shopId == ShopSpecialId.KShopTimelimitedmall then
		self._shopId = self._shopTabList[self._rightTabIndex].shopId

		self:setTabStatus()
	end

	self._parentMediator = data.parentMediator or nil
	self._enterData = data.enterData or nil

	self:setData()
end

function ShopPackageMainMediator:setData()
	self._curShopItems = self._shopSystem:getPackageList(self._shopId, self._shopSubType)

	if #self._curShopItems == 0 then
		self._curShopItems = self._shopSystem:getPackageList(self._shopId)
	end
end

function ShopPackageMainMediator:initMember()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._scrollBarBg = self:getView():getChildByFullName("scrollBarBg")
	self._cellClone = self:getView():getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
	self._cellClone:getChildByFullName("cell.rewardPanel"):setTouchEnabled(false)

	self._scrollView = self:getView():getChildByFullName("scrollView")

	self._scrollView:setScrollBarEnabled(false)

	self._cellWidth = self._cellClone:getContentSize().width + 15
	self._cellHeight = self._cellClone:getContentSize().height + 10
	self._tabBg = self:getView():getChildByFullName("tabBg")

	self._tabBg:setVisible(false)
	self._tabBg:setContentSize(cc.size(winSize.width - 200, 46))

	self._tabClone = self:getView():getChildByFullName("tabClone")

	self._tabClone:setVisible(false)

	self._cellWidthTab = self._tabClone:getContentSize().width
	self._scrollViewTab = self:getView():getChildByFullName("tabBg.scrollViewTab")

	self._scrollViewTab:setScrollBarEnabled(false)

	self._refreshPanel = self:getView():getChildByFullName("refreshPanel")

	self._refreshPanel:setVisible(false)

	self._refreshTime = self._refreshPanel:getChildByFullName("refresh_time_text")
end

function ShopPackageMainMediator:clearView(refresh)
	self:stopTimers()
	self:stopResetTimer()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()

	if not refresh and self._shopSpine then
		self._shopSpine:stopEffect()
	end
end

function ShopPackageMainMediator:refreshView()
	self:clearView(true)
	self:setResetTimer()
	self:setMenuView()
	self:setRefreshView()

	local width = self._scrollView:getContentSize().width
	local num1 = math.floor(width / self._cellWidth)
	local num2 = math.ceil(#self._curShopItems / 2)

	kNums = math.max(num1, num2)

	local length = math.ceil(#self._curShopItems / kNums)
	local viewHeight = self._scrollView:getContentSize().height
	local allHeight = math.max(viewHeight, self._cellHeight * length)

	self._scrollView:setInnerContainerSize(cc.size(kNums * self._cellWidth + 120, allHeight))

	self._cells = {}

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(kNums * self._cellWidth, self._cellHeight))
		layout:addTo(self._scrollView)
		layout:setTag(i)
		layout:setAnchorPoint(cc.p(0, 1))

		local h = allHeight - self._cellHeight * (i - 1) + 6

		layout:setPosition(cc.p(0, h))
		layout:setTouchEnabled(false)
		self:createCell(layout, i)
	end

	if not self:urlEnter() then
		self:runListAnim()
	end

	if self._curGoods then
		self._scrollView:setInnerContainerPosition(cc.p(self._viewOffsetX, 0))

		self._curGoods = nil
		self._viewOffsetX = nil
	end
end

function ShopPackageMainMediator:urlEnter()
	if self._enterData and self._enterData.packageId and not self._instanceEnter then
		self._instanceEnter = true

		local function enter(data)
			local offsetY = self._scrollView:getInnerContainerPosition().y
			local offsetX = self._scrollView:getInnerContainerPosition().x
			local cell = self._cells["cell" .. self._enterData.packageId]
			local x = cell:getPositionX()

			if x < offsetX or x > self._scrollView:getContentSize().width then
				self._scrollView:setInnerContainerPosition(cc.p(-self._cellWidth * (i - 1), offsetY))
			end

			self:onClickItem(data)

			self._enterData = nil
		end

		if table.indexof(kShopResetTypeSort, self._shopId) then
			for i = 1, 3 do
				local data = self._shopSystem:getPackageList(kShopResetTypeSort[i])

				for j = 1, #data do
					if data[j]:getId() == self._enterData.packageId then
						self:onClickTabBtns(_, i)
						enter(data[j])

						return true
					end
				end
			end
		else
			local data = self._curShopItems

			for i = 1, #data do
				if data[i]._id == self._enterData.packageId then
					enter(data[i])

					return true
				end
			end
		end
	end

	return false
end

function ShopPackageMainMediator:createCell(cell, index)
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

			self._cells["cell" .. itemData._id] = cell
		end
	end
end

function ShopPackageMainMediator:cleanMarkImage(panel)
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

function ShopPackageMainMediator:setInfo(panel, data, index)
	panel = panel:getChildByFullName("cell")

	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local money_icon = panel:getChildByFullName("money_layout.money_icon")

	money_icon:removeAllChildren()

	local moneyText = panel:getChildByFullName("money_layout.money")
	local isFree = data:getIsFree()
	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:addClickEventListener(function()
		self:onClickItem(data)
	end)
	self:cleanMarkImage(panel)
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
		money_icon:setPositionX(moneyText:getPositionX() - moneyText:getContentSize().width / 2 - 15)
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
	icon:setScale(0.7)
	self:refreshPackageTime(panel, data)
	self:setLimitDateImg(panel, data)
	self:setRecommendImg(panel, ItemTag[data:getTag()])
	self:setDiscountImg(panel, data)

	local rewardPanel = panel:getChildByFullName("rewardPanel")

	rewardPanel:removeAllChildren()

	local rewardId = data:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)
	local offset = #rewards == 1 and 80 or #rewards == 2 and 50 or #rewards == 3 and 22 or #rewards == 4 and 5 or 0
	local scale = 0.4
	local cellWidth = #rewards >= 4 and 48 or 53

	for i = 1, 4 do
		local reward = rewards[i]

		if reward then
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				isWidget = true
			})

			rewardPanel:addChild(rewardIcon)
			rewardIcon:setScaleNotCascade(scale)
			rewardIcon:setPosition((i - 1) * cellWidth + offset, 0)
			rewardIcon:setAnchorPoint(0, 0)
			IconFactory:bindClickHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
				touchDisappear = true,
				swallowTouches = true
			})
		end
	end

	self:addRedPoint(panel, data)
end

function ShopPackageMainMediator:addRedPoint(panel, data)
	local package = self._shopSystem:getFreePackage()

	for i = 1, #package do
		local packageId = package[i]:getId()

		if data:getId() == packageId then
			local redPoint = panel:getChildByName("redPoint" .. packageId)

			if not redPoint then
				redPoint = RedPoint:createDefaultNode()

				redPoint:addTo(panel):posite(195, 230)
				redPoint:setLocalZOrder(99901)
				redPoint:setName("redPoint" .. packageId)
			end
		end
	end
end

function ShopPackageMainMediator:setDiscountImg(panel, data)
	local costOffTagPanel = panel:getChildByName("costOffTagPanel")
	local costOff = data:getCostOff()

	if costOff and costOff > 0 then
		costOffTagPanel:setVisible(true)

		local n = costOffTagPanel:getChildByName("number")

		n:setString(tostring(costOff * 100) .. "%")
	else
		costOffTagPanel:setVisible(false)
	end
end

function ShopPackageMainMediator:setRecommendImg(panel, tagData)
	local label = panel:getChildByFullName("RecommendMark")

	if not tagData then
		if label then
			label:removeFromParent()
		end

		return
	end

	local str = tagData.text

	if not label then
		label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 28)

		label:addTo(panel)
		label:setName("TipMark")
	end

	label:setString(str)
	label:setPosition(cc.p(180, 205))
	label:setColor(cc.c4b(255, 211, 94, 255))
	label:enableOutline(cc.c4b(67, 35, 14, 255), 1)
	label:enableShadow(cc.c4b(0, 0, 0, 117.30000000000001), cc.size(2, 0), 2)
end

function ShopPackageMainMediator:setLimitDateImg(panel, data)
	self:setTimer(panel, data)
end

function ShopPackageMainMediator:refreshPackageTime(panel, data)
	local infoPanel = panel:getChildByFullName("info_panel")
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

	infoPanel:setVisible(true)

	if curTime < start or end_ < curTime or times1 <= 0 then
		_mageMark:setVisible(true)
		panel:setColor(cc.c3b(127, 127, 127))
		_duihuanText:setVisible(false)
		infoPanel:setVisible(false)

		return
	end

	_duihuanText:setVisible(true)
	infoPanel:setVisible(true)
	_duihuanText:setString(Strings:get("Shop_BuyNumLimit") .. "(" .. times1 .. "/" .. times2 .. ")")
end

function ShopPackageMainMediator:refreshShopData()
	if self:isCurShop() then
		self:setData()
		self:refreshView()
		self:setTabStatus()
	end
end

function ShopPackageMainMediator:isCurShop()
	local shopId = self._shopId

	if table.indexof(kShopResetTypeSort, shopId) then
		shopId = ShopSpecialId.kShopReset
	end

	if shopId and self._parentMediator and shopId == self._parentMediator:getCurShopId() then
		return true
	end

	if (shopId == ShopSpecialId.kShopPackage or shopId == ShopSpecialId.kShopTimeLimit or shopId == ShopSpecialId.kShopTimeLimit2) and self._parentMediator then
		return true
	end

	return false
end

function ShopPackageMainMediator:onClickItem(data)
	if data:getLeftCount() == 0 then
		return
	end

	local view = self:getInjector():getInstance("ShopBuyPackageView")

	if view then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)
		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopId = ShopSpecialId.kShopPackage,
			item = data
		}))

		self._curGoods = data
		self._viewOffsetX = self._scrollView:getInnerContainerPosition().x
	end
end

function ShopPackageMainMediator:onBuyPackageSuccCallback(event)
	if self:isCurShop() then
		self._buySuccessedInstance = true

		self:refreshShopData()
	end
end

function ShopPackageMainMediator:stopItemActions()
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

function ShopPackageMainMediator:runListAnim()
	local v = 4
	local startCount = 1

	if self._viewOffsetX then
		startCount = math.ceil(-self._viewOffsetX / self._cellWidth)
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

					node:setPositionX(starPosX + 20)

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

function ShopPackageMainMediator:stopTimer(view, id)
	if self._timer[id] then
		self._timer[id]:stop()

		self._timer[id] = nil
	end

	if view then
		view:setVisible(false)
	end
end

function ShopPackageMainMediator:stopTimers()
	if self._timer then
		for key, value in pairs(self._timer) do
			value:stop()
		end

		self._timer = {}
	end
end

function ShopPackageMainMediator:setTimer(panel, data)
	local limitePanel = panel:getChildByName("limitePanel")

	self:stopTimer(limitePanel, data:getId())

	local tag = data:getTimeTag()

	if not tag then
		return
	end

	limitePanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = data:getEndMillsByCondition()

	if remoteTimestamp < endMills and not self._timer[data:getId()] then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = data:getEndMillsByCondition()
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				self:stopTimer(nil, data:getId())

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
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") or "1" .. Strings:get("TimeUtil_Min")

			local times = limitePanel:getChildByName("times")

			times:setString(str)
			limitePanel:setVisible(true)
		end

		checkTimeFunc()

		self._timer[data:getId()] = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end

function ShopPackageMainMediator:playAnimation(sender)
	local function callback(voice)
		return
	end

	if self._buySuccessedInstance then
		self._buySuccessedInstance = false

		self._shopSpine:playAnimation(nil, nil, KShopVoice.buyEnd, callback)

		return
	end

	if sender then
		if self._shopSpine:getActionStatus() then
			self._shopSpine:playAnimation(KShopAction.click, false, KShopVoice.click, callback)
		end
	elseif self._shopSystem:getPlayInstance() then
		self._shopSpine:playAnimation(KShopAction.begin, false, KShopVoice.begin, callback)
		self._shopSystem:setPlayInstance(false)
	else
		self._shopSpine:playAnimation(KShopAction.beginEnd, true)
	end
end

function ShopPackageMainMediator:setMenuView()
	if table.indexof(kShopResetTypeSort, self._shopId) then
		self._tabBg:setVisible(true)
	elseif self._shopId == ShopSpecialId.kShopPackage then
		self._tabBg:setVisible(true)
	elseif self._shopId == ShopSpecialId.kShopTimeLimit then
		self._tabBg:setVisible(true)
	elseif self._shopId == ShopSpecialId.kShopTimeLimit2 then
		self._tabBg:setVisible(true)
	else
		self._tabBg:setVisible(false)
	end
end

function ShopPackageMainMediator:createRightShopConfig()
	self._shopTabList = {}

	if self._shopId == ShopSpecialId.KShopTimelimitedmall then
		local function setShopPackage()
			local list = self._shopSystem:getPackageList(ShopSpecialId.kShopPackage)
			local unlock, tips = self._systemKeeper:isUnlock(ShopUnlockId.kShopPackage)
			local canShow = self._systemKeeper:canShow(ShopUnlockId.kShopPackage) and CommonUtils.GetSwitch("fn_shop_package")

			if #list > 0 and canShow and unlock then
				self._shopTabList[#self._shopTabList + 1] = {
					shopId = ShopSpecialId.kShopPackage,
					name = {
						Strings:get("Unlock_Package_Shop"),
						""
					}
				}
			end
		end

		local function setShopTimeLimit()
			local list = self._shopSystem:getPackageList(ShopSpecialId.kShopTimeLimit)
			local unlock, tips = self._systemKeeper:isUnlock(ShopUnlockId.kShopTimeLimit)
			local canShow = self._systemKeeper:canShow(ShopUnlockId.kShopTimeLimit) and CommonUtils.GetSwitch("fn_shop_timelimit")
			local categorizedData = {}

			for _, item in ipairs(list) do
				if item._config then
					if item._config then
						categorizedData[item._config] = categorizedData[item._config] or {}

						table.insert(categorizedData[item._config], item)
					end
				end
			end

			self._categorizedData = categorizedData

			for shopSubType, items in pairs(categorizedData) do
				if #items > 0 and canShow and unlock then
					local var_40_0 = self._shopTabList
					local var_40_1 = {
						shopId = ShopSpecialId.kShopTimeLimit,
						shopSubType = shopSubType
					}
					local var_40_2 = {
						nil,
						""
					}

					var_40_2[1] = Strings and Strings:get("Unlock_Shop_TimeLimit") or ""
					var_40_1.name = var_40_2

					table.insert(var_40_0, var_40_1)
				end
			end
		end

		local function setShopTimeLimit2()
			local list = self._shopSystem:getPackageList(ShopSpecialId.kShopTimeLimit2)
			local unlock, tips = self._systemKeeper:isUnlock(ShopUnlockId.kShopTimeLimit2)
			local canShow = self._systemKeeper:canShow(ShopUnlockId.kShopTimeLimit2) and CommonUtils.GetSwitch("fn_shop_timelimit")

			if #list > 0 and canShow and unlock then
				self._shopTabList[#self._shopTabList + 1] = {
					shopId = ShopSpecialId.kShopTimeLimit2,
					name = {
						Strings:get("Unlock_Shop_TimeLimit"),
						""
					}
				}
			end
		end

		local sortDay = DataReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerPackage_Duration", "content")
		local createTime = self._developSystem:getPlayer():getCreateTime()
		local curTimeData = TimeUtil:timeByRemoteDate()
		local sortData = sortDay * 24 * 60 * 60 + createTime / 1000

		if curTimeData < sortData then
			setShopPackage()
			setShopTimeLimit()
			setShopTimeLimit2()
		else
			setShopTimeLimit()
			setShopTimeLimit2()
			setShopPackage()

			if self._shopSubType == "" then
				self._shopSubType = self._shopTabList[1].shopSubType or ""
			end
		end
	else
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
end

function ShopPackageMainMediator:initRightTabController()
	self._tabBtns = {}

	self._scrollViewTab:removeAllChildren()

	local length = #self._shopTabList
	local viewWidth = self._scrollViewTab:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidthTab * length)

	self._tabBg:setContentSize(cc.size(math.min(viewWidth, self._cellWidthTab * length) + 18, 46))
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

		btn.data = self._shopTabList[i]
		self._tabBtns[#self._tabBtns + 1] = btn

		btn:addClickEventListener(function()
			self:onClickTabBtns(_, i)
		end)

		local redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(btn):posite(149, 35)
		redPoint:setLocalZOrder(99900)

		if btn.data.shopSubType then
			redPoint:setName("redPoint" .. btn.data.shopSubType)
		else
			redPoint:setName("redPoint" .. btn.data.shopId)
		end
	end
end

function ShopPackageMainMediator:onClickTabBtns(name, tag)
	if self._rightTabIndex == tag then
		return
	end

	self._rightTabIndex = tag
	self._shopId = self._shopTabList[self._rightTabIndex].shopId
	self._shopSubType = self._shopTabList[self._rightTabIndex].shopSubType or ""

	self:setData()
	self:refreshView()
	self:setTabStatus()
end

function ShopPackageMainMediator:setTabStatus()
	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]

		btn:getChildByFullName("dark_1"):setVisible(i ~= self._rightTabIndex)
		btn:getChildByFullName("light_1"):setVisible(i == self._rightTabIndex)

		if btn.data.shopSubType then
			btn:getChildByFullName("redPoint" .. btn.data.shopSubType):setVisible(false)
		else
			btn:getChildByFullName("redPoint" .. btn.data.shopId):setVisible(false)
		end

		self:setRedPointBar(btn)
	end
end

function ShopPackageMainMediator:setRedPointBar(btn)
	local package = self._shopSystem:getFreePackage()

	for i = 1, #package do
		local packageType = package[i]:getShopSort()

		if btn.data.shopId == packageType then
			local shopSubType = package[i]:getShopSubType()

			if btn.data.shopSubType then
				if btn.data.shopSubType == shopSubType then
					btn:getChildByFullName("redPoint" .. btn.data.shopSubType):setVisible(true)
				end
			else
				btn:getChildByFullName("redPoint" .. btn.data.shopId):setVisible(true)
			end
		end
	end
end

function ShopPackageMainMediator:setRefreshView()
	if table.indexof(kShopResetTypeSort, self._shopId) then
		self._refreshPanel:setVisible(true)
	else
		self._refreshPanel:setVisible(false)
	end
end

function ShopPackageMainMediator:stopResetTimer()
	if self._resetTimer then
		self._resetTimer:stop()

		self._resetTimer = nil
	end

	self._refreshPanel:setVisible(false)
end

function ShopPackageMainMediator:setResetTimer()
	self:stopResetTimer()

	if #self._curShopItems == 0 or not self._shopId then
		return
	end

	self._refreshPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._shopSystem:getResetShopEndMills(self._shopId)

	if remoteTimestamp < endMills and not self._resetTimer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			endMills = self._shopSystem:getResetShopEndMills(self._shopId)

			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				performWithDelay(self:getView(), function()
					self:stopResetTimer()
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

			if not DisposableObject:isDisposed(self) and self._refreshTime and self._refreshPanel then
				self._refreshTime:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
				self._refreshPanel:setVisible(true)
			end
		end

		checkTimeFunc()

		self._resetTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end
