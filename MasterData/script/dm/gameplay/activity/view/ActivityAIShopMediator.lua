-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityAIShopMediator.lua

ActivityAIShopMediator = class("ActivityAIShopMediator", BaseActivityMediator, _M)

ActivityAIShopMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityAIShopMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
ActivityAIShopMediator:has("_payOffSystem", {
	is = "r"
}):injectWith("PayOffSystem")

local kBtnHandlers = {
	["main.btn_change"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChange"
	}
}
local cjson = require("cjson.safe")

function ActivityAIShopMediator:initialize()
	super.initialize(self)
end

function ActivityAIShopMediator:dispose()
	if self._delayTask then
		cancelDelayCall(self._delayTask)
	end

	super.dispose(self)
end

function ActivityAIShopMediator:onRemove()
	super.onRemove(self)
end

function ActivityAIShopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function ActivityAIShopMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITYT_PAY_SUCC, self, self.onBuyPackageSuss)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	TimeUtil:getLocalTimeZone()
	StatisticSystem:send({
		button_id = "welfare_button",
		point = "client_click",
		type = "client_click",
		page_id = "home_page",
		refresh_times = self._page - 1,
		product_list = self._activity:getStatisticPackageList()
	})
end

function ActivityAIShopMediator:setupView()
	self._packageList = self._activity:getPackageList()
	self._page = self._activity:getPage()

	local count = table.nums(self._packageList)

	self._maxPage = math.ceil(count / 3)

	self:initPackages()
	self:refreshPackages()
end

function ActivityAIShopMediator:initPackages()
	local randomData = self:getRandomBgData()

	for i = 1, 3 do
		local index = i + (self._page - 1) * 3
		local packageData = self._packageList[tostring(index - 1)]
		local cell = self._main:getChildByName("cell" .. i)
		local diImg = cell:getChildByName("Image_di")
		local namediImg = cell:getChildByName("Image_namedi")
		local name1Text = cell:getChildByName("Text_name1")
		local name2Text = cell:getChildByName("Text_name2")
		local priceText = cell:getChildByName("Text_price")
		local bgData = {}

		if i == randomData.randomIndex then
			local bgList = self._activity:getSpecialBgListByIndex(i)

			bgData = bgList[randomData.bgIndex]
		else
			bgData = self._activity:getBaseBgByIndex(i)
		end

		diImg:loadTexture("asset/ui/activity/" .. bgData.PicBg .. ".png")
		namediImg:loadTexture(bgData.NamePg .. ".png", 1)
		name1Text:setString(Strings:get(bgData.Name))
		name2Text:setString(Strings:get(bgData.SubTitle))

		local payId = self:getPayIdByProductId(packageData:getProductId())
		local symbol, price = self._payOffSystem:getPaySymbolAndPrice(payId)

		priceText:setString(symbol .. price)

		local buyBtn = cell:getChildByName("btn_buy")

		local function buyFunc()
			self:onClickBuyPackage(i)
		end

		mapButtonHandlerClick(nil, buyBtn, {
			func = buyFunc
		})

		local rewardNode = cell:getChildByName("reward")

		rewardNode:removeAllChildren()

		if packageData:getRewards() then
			local count = #packageData:getRewards()
			local initX = 31 - (count - 1) * 28

			for i, reward in pairs(packageData:getRewards()) do
				local icon = IconFactory:createRewardIcon(reward, {
					isWidget = true
				})

				icon:setScaleNotCascade(0.45)
				icon:addTo(rewardNode):posite(initX + (i - 1) * 56, 28)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					swallowTouches = true,
					needDelay = true
				})
			end
		end
	end
end

function ActivityAIShopMediator:getPayIdByProductId(productId)
	local payTable = ConfigReader:getDataTable("Pay")

	for i, v in pairs(payTable) do
		if v.ProductId == productId then
			return v.Id
		end
	end
end

function ActivityAIShopMediator:getRandomBgData()
	local data = cjson.decode(self._customDataSystem:getValue(PrefixType.kGlobal, self._activity:getId(), "{}"))

	if not data.isRandom then
		data.isRandom = true

		local prob = self._activity:getProbability() * 100
		local random = math.random(1, 100)

		data.randomIndex = 0

		if random <= prob then
			data.randomIndex = math.random(1, 3)
		end

		if data.randomIndex > 0 then
			local bgList = self._activity:getSpecialBgListByIndex(data.randomIndex)

			data.bgIndex = math.random(1, #bgList)
		end

		self._customDataSystem:setValue(PrefixType.kGlobal, self._activity:getId(), cjson.encode(data))
	end

	return data
end

function ActivityAIShopMediator:refreshPackages()
	for i = 1, 3 do
		local index = i + (self._page - 1) * 3
		local packageData = self._packageList[tostring(index - 1)]
		local cell = self._main:getChildByName("cell" .. i)
		local buyBtn = cell:getChildByName("btn_buy")
		local buttonText = buyBtn:getChildByName("Text_name")

		if packageData:getTimes() == 0 then
			buttonText:setString(Strings:get("shop_UI43"))
			buyBtn:setGray(true)
		else
			buttonText:setString(Strings:get("shop_UI48"))
			buyBtn:setGray(false)
		end
	end
end

function ActivityAIShopMediator:onClickChange()
	if self._page == self._maxPage then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Aishop_UI_1")
		}))

		return
	end

	local param = {
		doActivityType = 101
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), param, function()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:resetRandomData()
		self:setupView()
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ActivityBlock_UI_22")
		}))
		StatisticSystem:send({
			button_id = "refresh_button",
			point = "client_click",
			type = "client_click",
			page_id = "active_page",
			refresh_times = self._page - 1,
			product_list = self._activity:getStatisticPackageList()
		})
	end)
end

function ActivityAIShopMediator:onClickBuyPackage(index)
	local realIndex = index + (self._page - 1) * 3
	local packageData = self._packageList[tostring(realIndex - 1)]
	local times = packageData:getTimes()

	if times == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_10143")
		}))

		return
	end

	local param = {
		doActivityType = 102,
		index = index
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), param, function(response)
		if DisposableObject:isDisposed(self) then
			return
		end

		local payOffSystem = self:getInjector():getInstance(PayOffSystem)

		payOffSystem:payOffToSdk(response.data)
	end)
end

function ActivityAIShopMediator:onBuyPackageSuss(event)
	local data = event:getData()

	if data.activityId == self._activity:getId() then
		local rewards = data.rewards

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end

		self:refreshPackages()
	end
end

function ActivityAIShopMediator:doReset()
	self._delayTask = delayCallByTime(3000, function()
		self._activitySystem:requestActicityById(self._activity:getId(), function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:resetRandomData()
			self:setupView()
		end)
	end)
end

function ActivityAIShopMediator:resetRandomData()
	local data = {}

	data.isRandom = false
	data.randomIndex = 0
	data.bgIndex = 0

	self._customDataSystem:setValue(PrefixType.kGlobal, self._activity:getId(), cjson.encode(data), nil, nil, true)
end
