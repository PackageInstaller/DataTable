-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivityBlockFudaiMediator.lua

ActivityBlockFudaiMediator = class("ActivityBlockFudaiMediator", DmPopupViewMediator, _M)

ActivityBlockFudaiMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockFudaiMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
require("dm.gameplay.shop.model.ShopPackage")

local kBtnHandlers = {
	["main.Panel_button.Button_buy"] = {
		func = "onBuyClicked"
	},
	["main.Button_close"] = {
		func = "onCloseClicked"
	},
	["main.Panel_rate.Button_tishi"] = {
		func = "onPreviewClicked"
	}
}
local state_fudai = {
	State_Fudai_End = 2,
	State_Fudai_Opening = 1,
	State_Fudai_NotOpen = 0
}

function ActivityBlockFudaiMediator:initialize()
	super.initialize(self)
end

function ActivityBlockFudaiMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ActivityBlockFudaiMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITYFUDAI_BUYDONE, self, self.refreshButtonShow)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.buySucceedDone)
end

function ActivityBlockFudaiMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		return
	end

	self._activityFudai = self._activity:getActivityTpurchase()

	assert(self._activityFudai, "getActivityTpurchase not find")

	self._purchaseId = self._activityFudai:getTimePurchaseId()
	self._packageShop = self._shopSystem:getPackageById(self._purchaseId)
	self._packageShopConfig = self._activityFudai:getShopPackageConfig()
	self._isFree = self._packageShopConfig:getIsFree()
	self._startTime = self._packageShopConfig:getStartMills()
	self._endTime = self._packageShopConfig:getEndMills()
	self._price = self._packageShopConfig:getPrice()

	self:initMember()
	self:initListView()
	self:refreshUI()
	self:startAnim()
end

function ActivityBlockFudaiMediator:initMember()
	self._main = self:getView():getChildByFullName("main")

	local touchPanel = self._main:getChildByFullName("touchPanel")

	touchPanel:addClickEventListener(function()
		self:onCloseClicked()
	end)

	self._listView = self._main:getChildByFullName("Panel_rate.listView")

	self._listView:setScrollBarEnabled(false)

	self._content = self._main:getChildByFullName("Panel_rate.content_panel")

	self._content:setVisible(false)

	self._buyBtn = self._main:getChildByFullName("Panel_button.Button_buy")
	self._rewardPanel = self._main:getChildByFullName("reward")
	self._listTitleText = self._main:getChildByFullName("Panel_rate.Text_title")
	self._rewardTtitleText = self._main:getChildByFullName("Text_reward_title")

	self._rewardTtitleText:setVisible(true)
	self._rewardTtitleText:setLocalZOrder(100)

	self._timeshowText = self._main:getChildByFullName("Text_time_show")
	self._priceText = self._main:getChildByFullName("Panel_button.Text_price")
	self._priceNowText = self._main:getChildByFullName("Panel_button.Text_price_now")
	self._buyDesText = self._main:getChildByFullName("Panel_button.Text_buy_des")
	self._lineImage = self._main:getChildByFullName("Panel_button.Image_xian")
	self._panelRate = self._main:getChildByFullName("Panel_rate")
	self._panelButton = self._main:getChildByFullName("Panel_button")
	self._closeButton = self._main:getChildByFullName("Button_close")
end

function ActivityBlockFudaiMediator:initListView()
	self._listView:removeAllChildren()

	self._rewards = {}

	local desinfo = self._activityFudai:getActivityConfig().Translate
	local showrate = self._activityFudai:getActivityConfig().ShowRate
	local showdes = desinfo.ShowDesc

	self._listView:setContentSize(cc.size(340, 80))

	local posX, posY = self._listView:getPosition()
	local n = 3

	for i = 1, n do
		if showdes[i] then
			local panel = self._content:clone()

			panel:setVisible(true)

			local name1 = panel:getChildByFullName("Text_name")
			local name2 = panel:getChildByFullName("Text_name2")
			local rate = panel:getChildByFullName("Text_rate")
			local key = next(showdes[i])

			name1:setString(Strings:get(key))
			name2:setString(Strings:get(showdes[i][key]))
			rate:setString(tonumber(showrate[i]) * 100 .. "%")
			panel:setPosition(posX, posY - (i - 1) * 25)
			self._listView:addChild(panel)
			name2:setPositionX(name1:getPositionX() + name1:getContentSize().width + 10)
			rate:setPositionX(name2:getPositionX() + name2:getContentSize().width + 10)
		end
	end

	self._rewardPanel:removeAllChildren()

	local rewards = self:getRewards()

	for i = 1, #rewards do
		local scale = 0.8
		local reward = rewards[i]

		if reward then
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				isWidget = true
			})

			self._rewardPanel:addChild(rewardIcon)
			rewardIcon:setScaleNotCascade(scale)
			IconFactory:bindClickHander(rewardIcon, IconTouchHandler:new(self), reward, {
				touchDisappear = true,
				swallowTouches = true
			})
			table.insert(self._rewards, rewardIcon)
		end
	end
end

function ActivityBlockFudaiMediator:refreshUI()
	self._listTitleText:setString(Strings:get("NewYear_LuckyBag_UI07"))
	self._rewardTtitleText:setString(Strings:get("NewYear_LuckyBag_UI16"))

	local state = self:getFudaiOpenState()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local curData = TimeUtil:remoteDate("*t", remoteTimestamp)

	local function checkTimeFunc()
		remoteTimestamp = gameServerAgent:remoteTimestamp()

		local remainTime = 0

		state = self:getFudaiOpenState()

		if state == state_fudai.State_Fudai_NotOpen then
			remainTime = self._startTime - remoteTimestamp
		elseif state == state_fudai.State_Fudai_Opening then
			remainTime = self._endTime - remoteTimestamp
		else
			self:refreshButtonShow()
			self._timer:stop()

			self._timer = nil

			return
		end

		if state == state_fudai.State_Fudai_NotOpen then
			self._timeshowText:setString(TimeUtil:formatTime(Strings:get("NewYear_LuckyBag_UI04"), remainTime))
		elseif state == state_fudai.State_Fudai_Opening then
			self._timeshowText:setString(TimeUtil:formatTime(Strings:get("NewYear_LuckyBag_UI05"), remainTime))
		end
	end

	if state == state_fudai.State_Fudai_NotOpen then
		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	elseif state == state_fudai.State_Fudai_Opening then
		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	else
		self._timeshowText:setString(Strings:get("NewYear_LuckyBag_UI10"))
	end

	self:refreshButtonShow()
end

function ActivityBlockFudaiMediator:refreshButtonShow()
	self._buyDesText:setString(Strings:get("NewYear_LuckyBag_UI14"))

	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
	local symbol, price = payOffSystem:getPaySymbolAndPrice(self._packageShopConfig:getPayId())

	self._priceNowText:setString(symbol .. " " .. price)
	self._priceText:setString("¥ " .. self._price)
	self._buyBtn:setGray(false)

	local state = self:getFudaiOpenState()

	if state == state_fudai.State_Fudai_NotOpen then
		self._buyBtn:setGray(true)
	elseif state == state_fudai.State_Fudai_Opening then
		if not self._packageShop then
			self._buyBtn:setGray(true)
			self._priceText:setString(Strings:get("NewYear_LuckyBag_UI11"))
			self._lineImage:setVisible(false)
		elseif not self._packageShop:getCanBuy() then
			self._buyBtn:setGray(true)
			self._priceText:setString(Strings:get("NewYear_LuckyBag_UI11"))
			self._lineImage:setVisible(false)
		end
	else
		self._buyBtn:setGray(true)
		self._timeshowText:setString(Strings:get("NewYear_LuckyBag_UI10"))
	end
end

function ActivityBlockFudaiMediator:buySucceedDone()
	self._packageShop = self._shopSystem:getPackageById(self._purchaseId)

	self:refreshButtonShow()
end

function ActivityBlockFudaiMediator:startAnim()
	local anim = cc.MovieClip:create("jiemian_newyearfudai")

	anim:addTo(self._main):center(self._main:getContentSize()):offset(-45, -27)

	local mc_list = anim:getChildByName("mc_list")
	local mc_button = anim:getChildByName("mc_button")
	local mc_close = anim:getChildByName("mc_close")

	self._panelRate:changeParent(mc_list):center(mc_list:getContentSize()):offset(-10, 0)
	self._panelButton:changeParent(mc_button):center(mc_button:getContentSize())
	self._closeButton:changeParent(mc_close):center(mc_close:getContentSize())

	for i = 1, #self._rewards do
		self._rewards[i]:changeParent(anim:getChildByName("mc_icon" .. i)):center(anim:getChildByName("mc_icon" .. i):getContentSize())
	end

	anim:gotoAndPlay(1)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)
end

function ActivityBlockFudaiMediator:getFudaiOpenState()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()

	if remoteTimestamp < self._startTime then
		return state_fudai.State_Fudai_NotOpen
	elseif remoteTimestamp > self._endTime then
		return state_fudai.State_Fudai_End
	else
		return state_fudai.State_Fudai_Opening
	end
end

function ActivityBlockFudaiMediator:onPreviewClicked()
	local desinfo = self._activityFudai:getActivityConfig().Translate
	local showrate = self._activityFudai:getActivityConfig().ShowRate
	local showdes = desinfo.ShowDesc
	local view = self:getInjector():getInstance("ActivityBlockFudaiPreview")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rewards = showdes,
		rate = showrate
	}))
end

function ActivityBlockFudaiMediator:getRewards()
	local rewardId = self._packageShopConfig:getItem()

	return (RewardSystem:getRewardsById(rewardId))
end

function ActivityBlockFudaiMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ActivityBlockFudaiMediator:onBuyClicked()
	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)

	local tips = ""
	local state = self:getFudaiOpenState()

	if state == state_fudai.State_Fudai_NotOpen then
		tips = Strings:get("NewYear_LuckyBag_UI08")
	elseif state == state_fudai.State_Fudai_End then
		tips = Strings:get("NewYear_LuckyBag_UI15")
	elseif self._packageShop then
		local canBuy = self._packageShop:getCanBuy()

		if not canBuy then
			tips = Strings:get("NewYear_LuckyBag_UI12")
		end
	else
		tips = Strings:get("NewYear_LuckyBag_UI12")
	end

	if tips ~= "" then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return
	end

	local activityId = self._activityFudai:getId()
	local param = {
		doActivityType = 101,
		packageId = self._purchaseId
	}

	self._activitySystem:requestDoChildActivity(self._activity:getId(), activityId, param, function(response)
		local payOffSystem = self:getInjector():getInstance(PayOffSystem)

		payOffSystem:payOffToSdk(response.data)
	end)
end
