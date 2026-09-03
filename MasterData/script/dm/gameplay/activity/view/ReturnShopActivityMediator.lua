-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ReturnShopActivityMediator.lua

ReturnShopActivityMediator = class("ReturnShopActivityMediator", DmPopupViewMediator, _M)

ReturnShopActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ReturnShopActivityMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ReturnShopActivityMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ReturnShopActivityMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")

local btnHandlers = {}

function ReturnShopActivityMediator:initialize()
	super.initialize(self)
end

function ReturnShopActivityMediator:dispose()
	super.dispose(self)
end

function ReturnShopActivityMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(btnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.setUpPackageState)
end

function ReturnShopActivityMediator:onRemove()
	super.onRemove(self)
end

function ReturnShopActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator
	self._activityConfig = self._activity:getConfig().ActivityConfig

	self:setupView()
end

function ReturnShopActivityMediator:setupView()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._list = self._main:getChildByFullName("list")
	self._packageCell = self._view:getChildByFullName("packageClone")
	self._titleLab = self._main:getChildByFullName("title.desc")

	self._titleLab:setString(Strings:get(self._activity:getDesc()))

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(254, 248, 179, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._titleLab:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local showHero = self._activityConfig.showHero
	local heroPanel = self._main:getChildByName("heroPanel")

	heroPanel:getChildByFullName("Image_33"):setVisible(not showHero)

	if showHero and showHero.modelId ~= "no" then
		heroPanel:removeAllChildren()

		local heroSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = showHero.modelId,
			useAnim = showHero.anim == "1" and true or false
		})

		heroSprite:setScale(showHero.scale or 0.85)
		heroSprite:setPosition(cc.p(showHero.pos.x or 355, showHero.pos.y or 140))
		heroSprite:addTo(heroPanel)
	end

	self:setUpPackageState()
end

function ReturnShopActivityMediator:setUpPackageState()
	local timePurchaseIds = self._activityConfig.TimePurchaseId

	table.sort(timePurchaseIds, function(a, b)
		local aShop = self._shopSystem:getPackageById(a)
		local bShop = self._shopSystem:getPackageById(b)
		local times1 = aShop:getLeftCount()
		local isEmpty1 = 10

		if (aShop:getTimeTypeType() == "limit" or aShop:getTimeTypeType() == "day") and times1 <= 0 then
			isEmpty1 = 5
		end

		local times2 = bShop:getLeftCount()
		local isEmpty2 = 10

		if (bShop:getTimeTypeType() == "limit" or bShop:getTimeTypeType() == "day") and times2 <= 0 then
			isEmpty2 = 5
		end

		if isEmpty1 ~= isEmpty2 then
			return isEmpty2 < isEmpty1
		end

		return aShop:getSort() < bShop:getSort()
	end)
	self._list:removeAllChildren()
	self._list:setScrollBarEnabled(false)

	for i = 1, #timePurchaseIds do
		local packageId = timePurchaseIds[i]
		local itemUI = self._packageCell:clone()

		self._list:pushBackCustomItem(itemUI)

		local packageShop = self._shopSystem:getPackageById(packageId)

		if itemUI then
			itemUI:setName(packageId)
			self:setPackageItemInfo(itemUI, packageShop)
			itemUI:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:onBuyItem(packageId)
				end
			end)
		end
	end
end

function ReturnShopActivityMediator:setPackageItemInfo(cell, data)
	local panel = cell:getChildByFullName("cell")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local money_icon = panel:getChildByFullName("money_layout.money_icon")

	money_icon:removeAllChildren()

	local moneyText = panel:getChildByFullName("money_layout.money")
	local leaveTimesText = panel:getChildByFullName("info_panel.duihuan_text")
	local mask = cell:getChildByFullName("mask")
	local bg_buy = panel:getChildByName("bg_buy")
	local bg = panel:getChildByName("bg")
	local isFree = data:getIsFree()

	nameText:setString(data:getName())

	if isFree == 1 then
		moneyText:setString(Strings:get("Recruit_Free"))
		moneyText:setPositionX(65)
		xian:setVisible(false)
	elseif isFree == 2 then
		local goldIcon = IconFactory:createResourcePic({
			id = data:getGameCoin().type
		})

		goldIcon:addTo(money_icon):center(money_icon:getContentSize()):offset(0, 0)
		moneyText:setString(tostring(data:getGameCoin().amount))
		moneyText:setPositionX(60)

		local goldIcon2 = IconFactory:createResourcePic({
			id = data:getGameCoin().type
		})

		goldIcon2:setScale(0.7)
	else
		local symbol, price = data:getPaySymbolAndPrice(data:getPayId())

		moneyText:setString(symbol .. price)
		moneyText:setPositionX(40)
	end

	local rewardId = data:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)

	iconLayout:removeAllChildren()
	iconLayout:setAnchorPoint(cc.p(0.5, 0.5))

	local icon = IconFactory:createRewardIcon(rewards[1], {
		showAmount = true,
		isWidget = true
	})

	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewards[1], {
		touchDisappear = true,
		swallowTouches = true
	})
	iconLayout:addChild(icon)
	icon:setAnchorPoint(cc.p(0.5, 0.5))

	local pos = cc.p(iconLayout:getContentSize().width / 2, iconLayout:getContentSize().height / 2)

	icon:setPosition(pos)
	icon:setScale(0.8)

	local rewardPanel = panel:getChildByFullName("rewardPanel")

	rewardPanel:removeAllChildren()

	local rewardId = data:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)
	local rewardCount = #rewards - 1
	local offset = rewardCount == 1 and 62 or rewardCount == 2 and 33 or rewardCount == 3 and 2 or 0
	local scale = 0.5
	local cellWidth = 62

	for i = 1, 4 do
		local reward = rewards[i + 1]

		if reward then
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				isWidget = true
			})

			rewardPanel:addChild(rewardIcon)
			rewardIcon:setScaleNotCascade(scale)
			rewardIcon:setPosition((i - 1) * cellWidth + offset, 8)
			rewardIcon:setAnchorPoint(0, 0)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
				touchDisappear = true,
				swallowTouches = true
			})
		end
	end

	local times1 = data:getLeftCount()
	local times2 = data:getStorage()

	if data:getTimeTypeType() == "limit" then
		leaveTimesText:setVisible(true)
		leaveTimesText:setString(Strings:get("LimitPack_TotalLimit", {
			cur = times1,
			total = times2
		}))
	elseif data:getTimeTypeType() == "day" then
		leaveTimesText:setVisible(true)
		leaveTimesText:setString(Strings:get("LimitPack_TodayLimit", {
			cur = times1,
			total = times2
		}))
	elseif data:getTimeTypeType() == "unlimit" then
		leaveTimesText:setVisible(false)
	end

	if times1 <= 0 and data:getTimeTypeType() ~= "unlimit" then
		bg:setVisible(false)
		bg_buy:setVisible(true)
		mask:setVisible(true)
		cell:setTouchEnabled(false)
		moneyText:enableShadow(cc.c4b(49, 49, 49, 255), cc.size(0, -3), 3)
	else
		bg:setVisible(true)
		bg_buy:setVisible(false)
		mask:setVisible(false)
		cell:setTouchEnabled(true)
	end
end

function ReturnShopActivityMediator:onBuyItem(packageId)
	local packageShop = self._shopSystem:getPackageById(packageId)
	local isFree = packageShop:getIsFree()

	if isFree == KShopBuyType.KCoin then
		local gameCoin = packageShop:getGameCoin()
		local amount = gameCoin.amount
		local costType = gameCoin.type
		local curCoin = self._bagSystem:getItemCount(costType)

		if curCoin < amount then
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == "ok" then
					outSelf._shopSystem:tryEnter({
						shopId = "Shop_Mall"
					})
				elseif data.response == "cancel" then
					-- block empty
				elseif data.response == "close" then
					-- block empty
				end
			end

			local data = {
				title1 = "Tips",
				title = Strings:get("Tip_Remind"),
				content = Strings:get("LimitPack_DiamondTip"),
				sureBtn = {},
				cancelBtn = {}
			}
			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))

			return
		end
	end

	local params = {
		doActivityType = 101,
		packageId = packageId
	}
	local baseActivity = self._activitySystem:getActivityByComplexUI(ActivityType.KReturn)

	self._activitySystem:requestDoChildActivity(baseActivity:getId(), self._activity:getId(), params, function(response)
		if response.resCode == GS_SUCCESS then
			if isFree == KShopBuyType.KFree or isFree == KShopBuyType.KCoin then
				if DisposableObject:isDisposed(self._parentMediator) or DisposableObject:isDisposed(self._parentMediator:getView()) then
					return
				end

				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = response.data.rewards
				}))
				self:setUpPackageState()

				return
			end

			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:payOffToSdk(response.data)
		end
	end)
end
