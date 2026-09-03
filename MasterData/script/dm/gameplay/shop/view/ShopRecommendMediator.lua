-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopRecommendMediator.lua

ShopRecommendMediator = class("ShopRecommendMediator", DmAreaViewMediator, _M)

ShopRecommendMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopRecommendMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopRecommendMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopRecommendMediator:has("_activitySystem", {
	is = "rw"
}):injectWith("ActivitySystem")

local kCellHeightTab = 70
local kCellWidthTab = 920
local innerOffsetx = 10

function ShopRecommendMediator:initialize()
	super.initialize(self)
end

function ShopRecommendMediator:dispose()
	self:clearView()
	self:stopTimer()
	super.dispose(self)
end

function ShopRecommendMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function ShopRecommendMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ACTIVITY_PAY_SUCC, self, self.refreshShopData)
end

function ShopRecommendMediator:onRemove()
	super.onRemove(self)
end

function ShopRecommendMediator:setupView()
	self:initMember()

	self._rightTabIndex = 1
end

function ShopRecommendMediator:clearView()
	self:getView():stopAllActions()

	if self._shopSpine then
		self._shopSpine:stopEffect()
	end
end

function ShopRecommendMediator:refreshData()
	self:createRightShopConfig()

	if self._rightTabIndex > #self._shopTabList then
		self._rightTabIndex = 1

		if not self._shopTabList[self._rightTabIndex] then
			self._data = nil

			self:getView():setVisible(false)

			return
		end
	end

	self:getView():setVisible(true)

	self._data = self._shopTabList[self._rightTabIndex].data
end

function ShopRecommendMediator:initMember()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._rightTabPanel = self:getView():getChildByName("rightTabPanel")
	self._tabBg = self:getView():getChildByFullName("rightTabPanel.tabBg")

	self._tabBg:setContentSize(cc.size(winSize.width - 200, 46))

	self._touchPanel = self:getView():getChildByName("touchPanel")
	self._bgImage = self._touchPanel:getChildByName("Image_bg")

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickItem(sender, eventType)
	end)

	self._talkRole = self:getView():getChildByName("talkPanel")

	self._talkRole:addClickEventListener(function(sender)
		self:onClickTalkRole(sender)
	end)
	self._talkRole:getChildByName("Image_19"):setVisible(false)

	self._rolePanel = self._talkRole:getChildByName("rolePanel")

	self._rolePanel:setTouchEnabled(false)

	self._shopSpine = ShopSpine:new()

	self._shopSpine:addSpine(self._rolePanel)

	self._talkText = self._talkRole:getChildByName("Text_talk")

	self._talkText:setString("")

	self._fanxingPanel = self:getView():getChildByFullName("panel_fanxing")

	self._fanxingPanel:setVisible(false)

	self._surfacePanel = self:getView():getChildByFullName("Panel_surfaceShop")

	self._surfacePanel:setVisible(false)
	self:adjustView()
end

function ShopRecommendMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentWidth = winSize.width - 188 - AdjustUtils.getAdjustX()

	self._scrollViewTab = self._rightTabPanel:getChildByName("scrollViewTab")

	self._scrollViewTab:setContentSize(cc.size(kCellWidthTab, kCellHeightTab))
	self._scrollViewTab:setScrollBarEnabled(false)

	self._tabClone = self._view:getChildByFullName("tabClone")

	self._tabClone:setVisible(false)

	self._cellWidthTab = self._tabClone:getContentSize().width
end

function ShopRecommendMediator:refreshView()
	if not self._data then
		return
	end

	self:getView():stopAllActions()
	self:initRightTabController()
	self._fanxingPanel:setVisible(false)
	self._surfacePanel:setVisible(false)

	if not ("asset/ui/shop/" .. self._data.BackGroundImg .. ".jpg") then
		self._bgImage:loadTexture("asset/ui/shop/" .. self._data.BackGroundImg .. ".jpg")

		local pid = self._data.PackageId[1]

		if pid == KMonthCardType.KMonthCard then
			local frameData = self._shopSystem:getMonthCardHeadFrame()

			if frameData then
				if self._bgImage.frameData and frameData.code ~= self._bgImage.frameData.code and self._bgImage.frameIcon then
					self._bgImage.frameIcon:removeFromParent()

					self._bgImage.frameIcon = nil
				end

				if not self._bgImage.frameIcon then
					local icon = IconFactory:createPic({
						id = frameData.code
					}, {
						isWidget = true,
						showAmount = false
					})

					if getCurrentLanguage() == GameLanguageType.CN then
						icon:addTo(self._bgImage):posite(688, 442):setScale(0.83)
					elseif getCurrentLanguage() == GameLanguageType.EN then
						icon:addTo(self._bgImage):posite(577.5, 444):setScale(0.83)
					elseif getCurrentLanguage() == GameLanguageType.DE then
						icon:addTo(self._bgImage):posite(568, 455):setScale(0.83)
					elseif getCurrentLanguage() == GameLanguageType.FR then
						icon:addTo(self._bgImage):posite(568, 405):setScale(0.83)
					elseif getCurrentLanguage() == GameLanguageType.ES then
						icon:addTo(self._bgImage):posite(566, 388):setScale(0.83)
					elseif getCurrentLanguage() == GameLanguageType.PT then
						icon:addTo(self._bgImage):posite(568, 338):setScale(0.83)
					elseif getCurrentLanguage() == GameLanguageType.TH then
						icon:addTo(self._bgImage):posite(612, 455):setScale(0.83)
					end

					IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), frameData, {
						needDelay = true
					})
					icon:setSwallowTouches(true)

					self._bgImage.frameData = frameData
					self._bgImage.frameIcon = icon
				end

				self._bgImage.frameIcon:setVisible(true)
			end
		elseif pid == KMonthCardType.KCardFanxingZhi then
			local activity = self._activitySystem:getFanXingZhiMengActivity()

			if activity then
				self._fanxingPanel:setVisible(true)

				local activityConfig = activity:getActivityConfig()
				local payId = activityConfig.payId
				local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
				local symbol, price = payOffSystem:getPaySymbolAndPrice(payId)
				local symbolS = self._fanxingPanel:getChildByFullName("symbol")
				local moneyS = self._fanxingPanel:getChildByFullName("money")
				local textNum = self._fanxingPanel:getChildByFullName("text_num")

				symbolS:setString(symbol)
				moneyS:setString(price)
				textNum:setString(activity:getTotalNumReward())

				if getCurrentLanguage() == GameLanguageType.EN then
					textNum:setPositionX(678)
				elseif getCurrentLanguage() == GameLanguageType.FR then
					textNum:setPositionX(686)
				elseif getCurrentLanguage() == GameLanguageType.DE then
					textNum:setPositionX(656)
				elseif getCurrentLanguage() == GameLanguageType.PT then
					textNum:setPositionX(674)
				elseif getCurrentLanguage() == GameLanguageType.ES then
					textNum:setPositionX(678)
				elseif getCurrentLanguage() == GameLanguageType.TH then
					textNum:setPositionX(692)
				end

				self:setTimer()
			end

			if self._bgImage.frameIcon then
				self._bgImage.frameIcon:setVisible(false)
			end
		elseif pid == KMonthCardType.KSurfaceShop then
			if self._shopSystem:getSurfaceShowInShopById(self._data.Config.Surface) then
				self._surfacePanel:setVisible(true)

				local panel_suface1 = self._surfacePanel:getChildByFullName("Node_surface1")
				local panel_suface2 = self._surfacePanel:getChildByFullName("Node_surface2")
				local sufaceIds = self._data.Config.Surface

				panel_suface1:setVisible(#sufaceIds == 1)
				panel_suface2:setVisible(#sufaceIds == 2)

				local panel = #sufaceIds == 1 and panel_suface1 or panel_suface2

				for i, v in ipairs(sufaceIds) do
					local surfaceId = ConfigReader:getDataByNameIdAndKey("ShopSurface", v, "Surface")
					local surfaceConfig = ConfigReader:getRecordById("Surface", surfaceId)
					local name = panel:getChildByFullName("text_name" .. i)
					local surfaceName = panel:getChildByFullName("text_name_surface" .. i)
					local role = panel:getChildByFullName("Node_role" .. i)

					role:removeAllChildren()
					surfaceName:setString(Strings:get(surfaceConfig.Name))
					surfaceName:getVirtualRenderer():setAdditionalKerning(6)

					local n = self._shopSystem:getHeroNameAndModelByHeroId(surfaceConfig.Hero)

					name:setString(n)

					if #sufaceIds == 2 then
						GameStyle:setCommonOutlineEffect(name, 38.25, 2)
					end

					local img = IconFactory:createRoleIconSpriteNew({
						useAnim = true,
						frameId = "bustframe9",
						id = surfaceConfig.Model
					})

					role:setScale(self._data.Config.Scale[i] or 1)
					img:addTo(role):posite(0, -100)
				end

				local timeNode = self._surfacePanel:getChildByFullName("timeNode")
				local remoteTime = TimeUtil:formatStrToRemoteTImestamp(self._data.TimeType.start)
				local startLocalData = TimeUtil:localDate("%Y.%m.%d", remoteTime)
				local remoteTime = TimeUtil:formatStrToRemoteTImestamp(self._data.TimeType["end"])
				local endLocalData = TimeUtil:localDate("%Y.%m.%d", remoteTime)

				timeNode:getChildByFullName("time"):setString(startLocalData .. "-" .. endLocalData)
			end
		elseif self._bgImage.frameIcon then
			self._bgImage.frameIcon:setVisible(false)
		end

		self:setTalkView()
	end
end

function ShopRecommendMediator:refreshShopData()
	local offsetx = self._scrollViewTab:getInnerContainerPosition().x

	self:refreshData()
	self:refreshView()

	offsetx = offsetx == 0 and innerOffsetx or offsetx

	self._scrollViewTab:setInnerContainerPosition(cc.p(offsetx, 0))
end

function ShopRecommendMediator:createRightShopConfig()
	self._shopTabList = {}
	self._shopTabListData = self._shopSystem:getRecomendData()

	for index = 1, #self._shopTabListData do
		self._shopTabList[index] = {
			data = self._shopTabListData[index],
			name = {
				Strings:get(self._shopTabListData[index].TabName),
				""
			}
		}
	end
end

function ShopRecommendMediator:initRightTabController()
	self._tabBtns = {}

	self._scrollViewTab:removeAllChildren()

	local length = #self._shopTabList
	local viewWidth = self._scrollViewTab:getContentSize().width
	local allWidth = math.max(viewWidth, self._cellWidthTab * length)

	self._scrollViewTab:setInnerContainerSize(cc.size(allWidth, kCellHeightTab))
	self._scrollViewTab:setInnerContainerPosition(cc.p(innerOffsetx, 0))

	for i = 1, length do
		local info = self._shopTabList[i]
		local nameStr = info.name[1]
		local nameStr1 = info.name[2]
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

		btn.data = info.data
		self._tabBtns[#self._tabBtns + 1] = btn

		btn:addClickEventListener(function()
			self:onClickTabBtns(_, i)
		end)
	end

	self:setTabStatus()
end

function ShopRecommendMediator:onClickTabBtns(name, tag)
	if self._rightTabIndex == tag then
		return
	end

	self._rightTabIndex = tag
	self._showTalk = true

	self:setTabStatus()
	self:refreshShopData()
end

function ShopRecommendMediator:setTabStatus()
	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]
		local data = self._tabBtns[i].data

		btn:getChildByFullName("dark_1"):setVisible(i ~= self._rightTabIndex)
		btn:getChildByFullName("light_1"):setVisible(i == self._rightTabIndex)

		local player = self._developSystem:getPlayer()
		local idStr = string.split(player:getRid(), "_")
		local userId = data.Id .. idStr[1]
		local value = cc.UserDefault:getInstance():getStringForKey(userId)

		btn:getChildByFullName("Image_new"):setVisible(value == "")

		if value == "" and i == self._rightTabIndex then
			cc.UserDefault:getInstance():setStringForKey(userId, userId)
		end

		local timeVisible = data.TimeType.type == "limit"

		btn:getChildByFullName("Image_xianshi"):setVisible(timeVisible and value ~= "")
	end
end

function ShopRecommendMediator:onClickItem(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn and self._data.Link and self._data.Link ~= "" then
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(self._data.Link)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end
	end
end

function ShopRecommendMediator:setTalkView()
	self._showTalk = false

	self:onClickTalkRole()
end

function ShopRecommendMediator:onClickTalkRole(sender)
	self._showTalk = not self._showTalk

	local talkBg = self._talkRole:getChildByName("Image_20")

	talkBg:setVisible(self._showTalk)
	self._talkText:setVisible(self._showTalk)
	self._talkText:setString(self._shopSystem:getShopTalkShow())
	self:playAnimation(sender)
end

function ShopRecommendMediator:playAnimation(sender)
	local function callback(voice)
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

function ShopRecommendMediator:setTimer()
	self:stopTimer()

	local activity = self._activitySystem:getFanXingZhiMengActivity()

	if not activity then
		return
	end

	local activityConfig = activity:getActivityConfig()
	local times = self._fanxingPanel:getChildByFullName("times")

	if getCurrentLanguage() == GameLanguageType.EN then
		times:setPositionX(380)
	elseif getCurrentLanguage() == GameLanguageType.FR then
		times:setPositionX(380)
	elseif getCurrentLanguage() == GameLanguageType.DE then
		times:setPositionX(360)
	elseif getCurrentLanguage() == GameLanguageType.PT then
		times:setPositionX(402)
	elseif getCurrentLanguage() == GameLanguageType.ES then
		times:setPositionX(440)
	elseif getCurrentLanguage() == GameLanguageType.TH then
		times:setPositionX(360)
	end

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local startTime = activity:getStartTime() / 1000
	local buyDays = activityConfig.buyDays
	local endMills = startTime + tonumber(buyDays) * 24 * 60 * 60

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = startTime + tonumber(buyDays) * 24 * 60 * 60

			if endMills <= remoteTimestamp then
				self:stopTimer()
				self:refreshData()

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local remainTime = endMills - remoteTimestamp
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			times:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end

function ShopRecommendMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end
