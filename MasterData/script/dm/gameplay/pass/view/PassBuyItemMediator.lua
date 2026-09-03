-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassBuyItemMediator.lua

PassBuyItemMediator = class("PassBuyItemMediator", DmPopupViewMediator, _M)

PassBuyItemMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PassBuyItemMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
PassBuyItemMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassBuyItemMediator:has("_activitySystem", {
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

function PassBuyItemMediator:initialize()
	super.initialize(self)
end

function PassBuyItemMediator:dispose()
	super.dispose(self)
end

function PassBuyItemMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PassBuyItemMediator:enterWithData(data)
	self._itemData = data.itemData
	self._shopType = data.shopType
	self._activityId = data.activityId
	self._subActivityId = data.subActivityId

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function PassBuyItemMediator:onCloseClicked()
	self:close()
end

function PassBuyItemMediator:refreshData()
	self._storage = self._itemData:getExchangeCount()
	self._maxNumber = self._itemData:getLeftExchangeCount()

	local costItemId = self._itemData:getCostItemId()
	local maxMoney = self._bagSystem:getItemCount(costItemId)
	local costPrice = self._itemData:getCostItem().amount
	local maxNum = math.floor(maxMoney / costPrice)

	maxNum = maxNum <= 0 and 1 or maxNum
	self._maxNumber = self._storage == -1 and maxNum or math.min(self._maxNumber, maxNum)

	if self._maxNumber == 0 then
		self._curNumber = 0
		self._minNumber = 0
	else
		self._curNumber = 1
		self._minNumber = 1
	end
end

function PassBuyItemMediator:initMember()
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
end

function PassBuyItemMediator:refreshBaseShowView()
	self._moneyIcon:removeAllChildren()
	self._moneyIconSum:removeAllChildren()
	self._numberText:setString(tostring(self._bagSystem:getItemCount(self._itemData:getTargetItemId())))
	self._nameText:setString(self._itemData:getName())
	self._nameText_1:setString(self._itemData:getName())

	local descString

	if self._itemData:getEquipInfo() then
		self._numberPanel:setVisible(false)
		GameStyle:setRarityText(self._nameText, self._itemData:getEquipInfo().rarity, true)
		GameStyle:setRarityText(self._nameText_1, self._itemData:getEquipInfo().rarity, true)

		descString = Strings:get(self._itemData:getItemConfig().Desc)
	else
		GameStyle:setQualityText(self._nameText, self._itemData:getQuality(), true)
		GameStyle:setQualityText(self._nameText_1, self._itemData:getQuality(), true)

		descString = Strings:get(self._itemData:getItemConfig().FunctionDesc)

		if descString == nil or descString == "" then
			descString = Strings:get(self._itemData:getItemConfig().Desc)
		end

		if descString == nil then
			descString = ""
		end
	end

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

	if self._itemData:getCostType() == 2 then
		local costItem = self._itemData:getCostItem()
		local icon = IconFactory:createIcon({
			id = costItem.code,
			amount = costItem.amount
		}, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = true,
			isWidget = false
		})

		icon:addTo(self._moneyIcon):setScale(0.3)

		local icon2 = IconFactory:createIcon({
			id = costItem.code,
			amount = costItem.amount
		}, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = true,
			isWidget = false
		})

		icon2:addTo(self._moneyIconSum):setScale(0.2)
	else
		local goldIcon = IconFactory:createResourcePic({
			id = self._itemData:getCostType()
		})

		goldIcon:addTo(self._moneyIcon):setScale(1.1)

		local goldIcon1 = IconFactory:createResourcePic({
			id = self._itemData:getCostType()
		})

		goldIcon1:addTo(self._moneyIconSum):setScale(0.8)
	end

	self._soldOut:setVisible(false)
	self._sliderPanel:setVisible(true)
	self._buyBtn:setVisible(true)
	self._curCount:setString("x1")
	self:refreshMoney()
end

function PassBuyItemMediator:refreshView()
	self:refreshIcon()
	self:refreshBaseShowView()
	self:refreshBtnState()
end

function PassBuyItemMediator:refreshIcon()
	self._iconLayout:removeAllChildren()

	local icon
	local info = self._itemData:getEquipInfo()

	if info then
		icon = IconFactory:createRewardEquipIcon(info, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = true,
			isWidget = true
		})
	else
		icon = IconFactory:createIcon({
			rewardType = self._itemData:getTargetType(),
			id = self._itemData:getTargetItemId(),
			amount = self._itemData:getAmount()
		}, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = true,
			isWidget = true
		})

		if self._itemData:getTargetType() == RewardType.kHero then
			icon:setScale(1.5)
		else
			icon:setScale(1.7)
		end
	end

	icon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
end

function PassBuyItemMediator:onClickedRightBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._curNumber + 1

	self:refreshBtnState()
	self:refreshMoney()
end

function PassBuyItemMediator:onClickedLeftBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._curNumber - 1

	self:refreshBtnState()
	self:refreshMoney()
end

function PassBuyItemMediator:onClickedMaxBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._maxNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function PassBuyItemMediator:onClickedMinBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._minNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function PassBuyItemMediator:onClickedBuyBtn()
	local costType = self._itemData:getCostType()

	if costType == 2 then
		costType = self._itemData:getCostItemId()
	end

	local costPrice = self._itemData:getPrice()
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

		local data = {
			doActivityType = 101,
			exchangeId = self._itemData:getExchangeId(),
			exchangeAmount = self._curNumber
		}

		if self._shopType == 1 then
			local soldOut = self._curNumber >= self._maxNumber

			self._passSystem:requestBuyItemChildActivity(self._activityId, self._subActivityId, data, soldOut, function(data)
				if checkDependInstance(self) then
					self:close()
				end
			end)
		end

		if self._shopType == 2 then
			local soldOut = self._curNumber >= self._maxNumber

			self._passSystem:requestBuyItemActivity(self._activityId, data, soldOut, function(data)
				if checkDependInstance(self) then
					self:close()
				end
			end)
		end
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end
end

function PassBuyItemMediator:onGetRewardCallback(response)
	local data = response.data.reward

	self:dispatch(Event:new(EVT_PASSPORT_REFRESH))

	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = data
	}))
end

function PassBuyItemMediator:refreshBtnState()
	return
end

function PassBuyItemMediator:refreshMoney()
	if self._itemData then
		local costPrice = self._itemData:getPrice()
		local costSum = self._curNumber * costPrice

		self._price:setString(costPrice)
		self._selectCount:setString(self._curNumber)
		self._remainCount:setString(self._itemData:getLeftExchangeCount())
		self._totalPrice:setString(costSum)
		self._remainCount:setVisible(true)
		self._buyTitleText:setVisible(true)

		if self._storage == -1 then
			self._buyTitleText:setVisible(false)
			self._remainCount:setVisible(false)
		end
	end
end
