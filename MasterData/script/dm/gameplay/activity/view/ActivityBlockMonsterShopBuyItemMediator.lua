-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockMonsterShopBuyItemMediator.lua

ActivityBlockMonsterShopBuyItemMediator = class("ActivityBlockMonsterShopBuyItemMediator", DmPopupViewMediator, _M)

ActivityBlockMonsterShopBuyItemMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockMonsterShopBuyItemMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")
ActivityBlockMonsterShopBuyItemMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.slider_panel.right_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedRightBtn"
	},
	["main.slider_panel.left_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedLeftBtn"
	},
	["main.slider_panel.max_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedMaxBtn"
	},
	["main.slider_panel.btn_buy"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedBuyBtn"
	},
	["main.slider_panel.min_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedMinBtn"
	}
}

function ActivityBlockMonsterShopBuyItemMediator:initialize()
	super.initialize(self)
end

function ActivityBlockMonsterShopBuyItemMediator:dispose()
	super.dispose(self)
end

function ActivityBlockMonsterShopBuyItemMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivityBlockMonsterShopBuyItemMediator:enterWithData(data)
	self._itemData = data.itemData
	self._shopType = data.shopType
	self._activityId = data.activityId
	self._subActivityId = data.subActivityId

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ActivityBlockMonsterShopBuyItemMediator:onCloseClicked()
	self:close()
end

function ActivityBlockMonsterShopBuyItemMediator:refreshData()
	self._storage = self._itemData.amount

	local costType = self._itemData.costId
	local maxMoney = self._bagSystem:getItemCount(costType)
	local costPrice = self._itemData.price
	local maxNum = math.floor(maxMoney / costPrice)

	maxNum = maxNum <= 0 and 1 or maxNum
	self._maxNumber = self._storage == -1 and maxNum or math.min(self._itemData.amount, maxNum)

	if self._maxNumber == 0 then
		self._curNumber = 0
		self._minNumber = 0
	else
		self._curNumber = 1
		self._minNumber = 1
	end

	self._targetItemId = self._itemData.targetItem or self._itemData.targetInfo.code
end

function ActivityBlockMonsterShopBuyItemMediator:initMember()
	self._bagSystem = self._developSystem:getBagSystem()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._iconLayout = mainPanel:getChildByFullName("icon_panel")
	self._sliderPanel = mainPanel:getChildByFullName("slider_panel")

	self._sliderPanel:setTouchEnabled(true)

	self._buyBtn = mainPanel:getChildByFullName("slider_panel.btn_buy")
	self._buyTimesPanel = self._sliderPanel:getChildByFullName("timesnode")
	self._moneyNode = self._sliderPanel:getChildByFullName("costNode")
	self._nameText = mainPanel:getChildByFullName("name_text")
	self._nameText_1 = mainPanel:getChildByFullName("name_text_1")
	self._buyTitleText = self._buyTimesPanel:getChildByFullName("changetitlelabel")
	self._numberPanel = mainPanel:getChildByFullName("number_panel")
	self._numberText = self._numberPanel:getChildByFullName("item_count")
	self._desc = self._view:getChildByFullName("main.desc")

	self._desc:setVisible(false)

	self._descListView = mainPanel:getChildByFullName("descListView")
	self._leftBtn = self._sliderPanel:getChildByFullName("left_btn")
	self._rightBtn = self._sliderPanel:getChildByFullName("right_btn")
	self._maxBtn = self._sliderPanel:getChildByFullName("max_btn")
	self._minBtn = self._sliderPanel:getChildByFullName("min_btn")
	self._soldOut = mainPanel:getChildByFullName("soldout")
	self._onePriceNode = mainPanel:getChildByFullName("Node_price")
	self._moneyIcon = self._moneyNode:getChildByFullName("money_icon")
	self._moneyIconSum = self._onePriceNode:getChildByFullName("money_icon")
	self._price = self._moneyNode:getChildByFullName("money_text_one")
	self._curCount = mainPanel:getChildByFullName("name_text_count")
	self._selectCount = self._buyTimesPanel:getChildByFullName("changetime_text_cur_count")
	self._remainCount = self._buyTimesPanel:getChildByFullName("changetime_text1")
	self._totalPrice = self._onePriceNode:getChildByFullName("money_text")

	self._numberPanel:setVisible(false)
end

function ActivityBlockMonsterShopBuyItemMediator:refreshBaseShowView()
	self._moneyIcon:removeAllChildren()
	self._moneyIconSum:removeAllChildren()

	local targetInfo = self._itemData.targetInfo

	if targetInfo.amount then
		if not targetInfo.amount then
			local curCount = 1

			self._numberText:setString(tostring(self._bagSystem:getItemCount(self._targetItemId)))
			self._nameText:setString(RewardSystem:getName(targetInfo))
			self._nameText_1:setString(RewardSystem:getName(targetInfo))

			local info = RewardSystem:parseInfo(self._itemData.targetInfo)
			local rarity = RewardSystem:getQuality(self._itemData.targetInfo)
			local descString = ""

			if info.rewardType == RewardType.kEquip then
				self._numberPanel:setVisible(false)
			elseif info.rewardType == RewardType.kHero then
				local config = ConfigReader:getRecordById("HeroBase", tostring(info.id))

				rarity = config.Rareity
			else
				rarity = rarity + 9
			end

			GameStyle:setRarityText(self._nameText, rarity, true)
			GameStyle:setRarityText(self._nameText_1, rarity, true)

			descString = Strings:get(RewardSystem:getDesc(targetInfo))

			self._descListView:removeAllChildren()
			self._descListView:setScrollBarEnabled(false)

			local node = self._desc:clone()

			node:setPosition(cc.p(0, 0))
			node:setVisible(true)
			node:setString(descString)
			node:getVirtualRenderer():setDimensions(self._descListView:getContentSize().width, 0)
			self._descListView:pushBackCustomItem(node)

			if string.len(descString) < 80 then
				self._descListView:setEnabled(false)
			else
				self._descListView:setEnabled(true)
			end

			local var_8_1 = {}

			var_8_1.id = self._itemData.costId or CurrencyIdKind.kGold

			local goldIcon = IconFactory:createResourcePic(var_8_1)

			goldIcon:addTo(self._moneyIcon):setScale(1.1)

			local var_8_2 = {}

			var_8_2.id = self._itemData.costId or CurrencyIdKind.kGold

			local goldIcon1 = IconFactory:createResourcePic(var_8_2)

			goldIcon1:addTo(self._moneyIconSum):setScale(0.8)
			self._soldOut:setVisible(false)
			self._sliderPanel:setVisible(true)
			self._buyBtn:setVisible(true)

			if info.rewardType == RewardType.kHero then
				self._curCount:setString("x" .. 1)
			else
				self._curCount:setString("x" .. curCount)
			end

			self:refreshMoney()
		end
	end
end

function ActivityBlockMonsterShopBuyItemMediator:refreshView()
	self:refreshIcon()
	self:refreshBaseShowView()
	self:refreshBtnState()
end

function ActivityBlockMonsterShopBuyItemMediator:refreshIcon()
	self._iconLayout:removeAllChildren()

	local icon
	local info = RewardSystem:parseInfo(self._itemData.targetInfo)

	icon = IconFactory:createIcon(info, {
		hideLevel = true,
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	if info.rewardType == RewardType.kHero then
		icon:setScale(1.5)
	else
		icon:setScale(1.7)
	end

	icon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
end

function ActivityBlockMonsterShopBuyItemMediator:onClickedRightBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._curNumber + 1

	self:refreshBtnState()
	self:refreshMoney()
end

function ActivityBlockMonsterShopBuyItemMediator:onClickedLeftBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._curNumber - 1

	self:refreshBtnState()
	self:refreshMoney()
end

function ActivityBlockMonsterShopBuyItemMediator:onClickedMaxBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._maxNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function ActivityBlockMonsterShopBuyItemMediator:onClickedMinBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._minNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function ActivityBlockMonsterShopBuyItemMediator:onClickedBuyBtn()
	local costType = self._itemData.costId
	local costPrice = self._itemData.price
	local costSum = self._curNumber * costPrice

	if self._maxNumber == 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("ActivityCommon_Tip01")
		}))

		return
	elseif self._bagSystem:checkCostEnough(costType, costSum, {
		type = "tip"
	}) then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local var_15_0 = {
			goodsId = self._itemData.id
		}

		var_15_0.index = self._itemData.index or 1
		var_15_0.goodsNum = self._curNumber or 1

		local data = var_15_0
		local activity = self._activitySystem:getActivityById(self._activityId)

		if activity:getType() ~= ActivityType.KMonsterShop then
			self._activitySystem:monsterShopGoodsExchange(self._activityId, self._subActivityId, data, function()
				if checkDependInstance(self) then
					self:close()
				end
			end)
		else
			self._activitySystem:monsterShopGoodsExchange(self._activityId, nil, data, function()
				if checkDependInstance(self) then
					self:close()
				end
			end)
		end
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end
end

function ActivityBlockMonsterShopBuyItemMediator:onGetRewardCallback(response)
	local data = response.data.reward

	self:dispatch(Event:new(EVT_PASSPORT_REFRESH))

	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = data
	}))
end

function ActivityBlockMonsterShopBuyItemMediator:refreshBtnState()
	self._leftBtn:setEnabled(self._curNumber > 1)
	self._rightBtn:setEnabled(self._curNumber < self._maxNumber)
	self._maxBtn:setEnabled(self._curNumber < self._maxNumber)
	self._buyBtn:setEnabled(self._maxNumber ~= 0)
end

function ActivityBlockMonsterShopBuyItemMediator:refreshMoney()
	if self._itemData then
		local costPrice = self._itemData.price
		local costSum = self._curNumber * costPrice

		self._price:setString(costPrice)
		self._selectCount:setString(self._curNumber)
		self._remainCount:setString(self._itemData.amount)
		self._totalPrice:setString(costSum)
		self._remainCount:setVisible(true)
		self._buyTitleText:setVisible(true)

		if self._storage == -1 then
			self._buyTitleText:setVisible(false)
			self._remainCount:setVisible(false)
		end
	end
end
