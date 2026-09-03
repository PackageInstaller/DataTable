-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopBuyMediator.lua

ShopBuyMediator = class("ShopBuyMediator", DmPopupViewMediator, _M)

ShopBuyMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopBuyMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {
	["main.slider_panel.node.right_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedRightBtn"
	},
	["main.slider_panel.node.left_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedLeftBtn"
	},
	["main.slider_panel.node.max_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedMaxBtn"
	}
}

function ShopBuyMediator:initialize()
	super.initialize(self)
end

function ShopBuyMediator:dispose()
	if self._timeSchel then
		self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

		self._timeSchel = nil
	end

	super.dispose(self)
end

function ShopBuyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshByRset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_REFRESH_SUCC, self, self.onRefreshShopSuccess)

	self._buyBtn = self:bindWidget("main.slider_panel.btn_buy", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickedBuyBtn, self)
		}
	})

	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("SHOP_Text_13"),
		title1 = Strings:get("UITitle_EN_Goumai"),
		bgSize = {
			width = 840,
			height = 476
		}
	})
end

function ShopBuyMediator:enterWithData(data)
	if data.buyType then
		self._buyType = data.buyType
		self._itemid = data.itemid
		self._costType = data.costType
		self._costSum = data.cost
		self._buyFun = data.bufFun
	end

	self._itemData = data.itemData
	self._callBack = data.callback or nil
	self._skipStatus = false

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ShopBuyMediator:refreshByRset(event)
	self:refreshData()
	self:refreshView()
end

function ShopBuyMediator:onRefreshShopSuccess(event)
	self:refreshData()
	self:refreshView()
end

function ShopBuyMediator:onCloseClicked()
	self:close()
end

function ShopBuyMediator:refreshData()
	if self._buyType == 2 then
		self._maxNumber = 1
		self._curNumber = 0
	else
		self._maxNumber = self._itemData:getStock()
		self._curNumber = self._maxNumber == 0 and 0 or 1
	end
end

function ShopBuyMediator:initMember()
	self._bagSystem = self._developSystem:getBagSystem()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._bgImg = mainPanel:getChildByFullName("bg")
	self._iconLayout = mainPanel:getChildByFullName("icon_panel")
	self._sliderPanel = mainPanel:getChildByFullName("slider_panel")
	self._buyTimesPanel = self._sliderPanel:getChildByFullName("timesnode")
	self._sliderNode = self._sliderPanel:getChildByFullName("node")
	self._moneyNode = self._sliderPanel:getChildByFullName("costNode")
	self._moneyIcon = self._moneyNode:getChildByFullName("money_icon")
	self._moneyText = self._moneyNode:getChildByFullName("money_text")
	self._nameText = mainPanel:getChildByFullName("name_text")
	self._itemCountText = self._buyTimesPanel:getChildByFullName("changetime_text1")
	self._buyTitleText = self._buyTimesPanel:getChildByFullName("changetitlelabel")
	self._slider = self._sliderNode:getChildByFullName("slider")

	self._slider:setScale9Enabled(true)
	self._slider:setCapInsets(cc.rect(43, 2, 32, 2))
	self._slider:setCapInsetsBarRenderer(cc.rect(1, 1, 1, 1))
	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)

	self._numberPanel = mainPanel:getChildByFullName("number_panel")
	self._numberText = self._numberPanel:getChildByFullName("item_count")
	self._desc = mainPanel:getChildByFullName("desc")

	self._desc:setVisible(false)

	self._descListView = mainPanel:getChildByFullName("descListView")
	self._leftBtn = self._sliderNode:getChildByFullName("left_btn")
	self._rightBtn = self._sliderNode:getChildByFullName("right_btn")
	self._maxBtn = self._sliderNode:getChildByFullName("max_btn")
	self._timePanel = mainPanel:getChildByFullName("timepanel")

	if self._buyType == 2 then
		self._timePanel:setVisible(false)
		self._timePanel:getChildByFullName("")
		self._sliderNode:setVisible(false)
	end

	self._soldOut = mainPanel:getChildByFullName("soldout")
	self._onePriceNode = mainPanel:getChildByFullName("Node_price")

	if self._buyType == 2 then
		self._buyTimesPanel:setVisible(false)
	end

	self._itemCountText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._buyTitleText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyNode:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._onePriceNode:getChildByFullName("count_text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._onePriceNode:getChildByFullName("money_text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function ShopBuyMediator:createSchel()
	if self._timeSchel then
		return
	end

	local function checkTimeFunc()
		self:refreshView()
	end

	self._timeSchel = self:getView():getScheduler():scheduleScriptFunc(checkTimeFunc, 1, false)
end

function ShopBuyMediator:onSliderChanged(event)
	self._curNumber = math.round(self._slider:getPercent() / 100 * (self._maxNumber - 1)) + 1

	self:refreshSliderText()
	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyMediator:refreshSliderText()
	self._itemCountText:setString(tostring(self._curNumber) .. "/" .. tostring(self._maxNumber))
end

function ShopBuyMediator:refreshSlider()
	local cur = self._curNumber
	local max = self._maxNumber

	if max == 0 then
		max = cur + 1
	end

	self._slider:setPercent(tonumber(max == 1 and cur == 1 and 100 or math.round((cur - 1) / (max - 1) * 100)))
end

function ShopBuyMediator:refreshBaseShowView()
	local descString

	if self._itemData then
		self._moneyIcon:removeAllChildren()
		self._numberText:setString(tostring(self._bagSystem:getItemCount(self._itemData:getItemId())))
		self._nameText:setString(self._itemData:getName())

		if self._itemData:getEquipInfo() then
			self._numberPanel:setVisible(false)
			GameStyle:setRarityText(self._nameText, self._itemData:getEquipInfo().rarity)

			descString = Strings:get(self._itemData:getItemConfig().Desc)
		else
			GameStyle:setQualityText(self._nameText, self._itemData:getQuality())

			descString = Strings:get(self._itemData:getItemConfig().FunctionDesc)
		end
	elseif self._buyType == 2 then
		local config = ConfigReader:requireRecordById("ItemConfig", self._itemid)

		self._numberText:setString(0)

		descString = Strings:get(config.Desc) or ""

		local goldIcon = IconFactory:createResourcePic({
			id = self._costType
		}, {
			scale = 0.4
		})

		goldIcon:addTo(self._moneyIcon)

		local name = Strings:get(config.Name)
		local quality = config.Quality

		self._nameText:setString(name)
		GameStyle:setQualityText(self._nameText, quality)
	end

	self._descListView:removeAllChildren()
	self._descListView:setScrollBarEnabled(false)

	local node = self._desc:clone()

	node:setPosition(cc.p(0, 0))
	node:setVisible(true)
	node:setString(descString)
	node:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	node:getVirtualRenderer():setDimensions(self._descListView:getContentSize().width, 0)
	self._descListView:pushBackCustomItem(node)

	if string.len(descString) < 80 then
		self._descListView:setEnabled(false)
	else
		self._descListView:setEnabled(true)
	end
end

function ShopBuyMediator:refreshBottomView()
	if self._buyType == 2 then
		self._soldOut:setVisible(false)
		self._onePriceNode:setVisible(false)
		self._moneyText:setString(self._costSum.amount)

		return
	end

	local times1 = self._itemData:getStock()
	local times2 = self._itemData:getStorage()

	self._soldOut:setVisible(false)
	self._sliderPanel:setVisible(true)
	self._sliderNode:setVisible(false)
	self._timePanel:setVisible(false)
	self._buyBtn:setVisible(true)

	local updateTime = self._itemData:getUpdateTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local hasTimeRecover = self._itemData:getUpdateTime() > gameServerAgent:remoteTimestamp() and times1 < times2

	if self._maxNumber == 0 and self._itemData:getCDTime() == nil then
		self._soldOut:setVisible(true)
		self._sliderPanel:setVisible(false)
		self._onePriceNode:setVisible(false)

		return
	end

	local lastTime = updateTime - gameServerAgent:remoteTimestamp()

	if lastTime <= 0 and self._timeSchel then
		self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

		self._timeSchel = nil
	end

	if self._itemData:getCDTime() == nil then
		self._moneyNode:setVisible(false)
		self._onePriceNode:setVisible(true)
		self._buyTimesPanel:setVisible(false)
		self._buyTitleText:setString(Strings:get("SHOP_Text_16"))
		self:refreshOneMoney()
	else
		self._sliderNode:setVisible(true)
		self._onePriceNode:setVisible(false)
		self:refreshSliderText()
		self:refreshSlider()
		self:refreshMoney()
		self._buyTitleText:setString(Strings:get("Shop_Text13"))
	end

	self._itemCountText:setVisible(true)

	if hasTimeRecover and times1 == 0 then
		self:createSchel()
		self._itemCountText:setVisible(false)

		local newCountLabel = self._buyTitleText:clone()

		newCountLabel:setAnchorPoint(cc.p(1, 0.5))
		newCountLabel:setString(self._curNumber .. "/" .. self._maxNumber)
		newCountLabel:setTag(346)
		self._buyTitleText:getParent():addChild(newCountLabel)
		newCountLabel:setPosition(self._buyTitleText:getPositionX(), self._buyTitleText:getPositionY())
		newCountLabel:offset(self._buyTitleText:getContentSize().width + 14, 0)

		local newTimeLabel = self._buyTitleText:clone()

		newTimeLabel:setAnchorPoint(cc.p(1, 0.5))
		newTimeLabel:setString(TimeUtil:formatTime("(${MM}:${SS})", lastTime))
		newTimeLabel:setTag(345)
		self._buyTitleText:getParent():addChild(newTimeLabel)
		newTimeLabel:setPosition(newCountLabel:getPosition())
		newTimeLabel:offset(newCountLabel:getContentSize().width + 5, 0)
	end

	if times1 == 0 then
		self._timePanel:setVisible(true)
		self._sliderNode:setVisible(false)
		self._buyBtn:setVisible(false)
	end

	if self._maxNumber == 0 or self._maxNumber == 1 then
		self._sliderNode:setVisible(false)
	end
end

function ShopBuyMediator:refreshView()
	if self._timeSchel then
		self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

		self._timeSchel = nil
	end

	self:refreshIcon()
	self._buyTimesPanel:removeChildByTag(345, true)
	self._buyTimesPanel:removeChildByTag(346, true)
	self:refreshBaseShowView()
	self:refreshBottomView()
	self:refreshBtnState()
end

function ShopBuyMediator:refreshIcon()
	self._iconLayout:removeAllChildren()

	local icon

	if self._iconLayout and self._itemData then
		local info = self._itemData:getEquipInfo()

		icon = info and IconFactory:createRewardEquipIcon(info, {
			hideLevel = true
		}) or IconFactory:createIcon({
			id = self._itemData:getItemId(),
			amount = self._itemData:getAmount()
		})
	elseif self._buyType == 2 then
		icon = IconFactory:createIcon({
			amount = 1,
			id = self._itemid
		})
	end

	icon:setScale(0.8)
	icon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
end

function ShopBuyMediator:onClickedRightBtn()
	self._curNumber = self._curNumber + 1

	if self._curNumber > self._maxNumber then
		self._curNumber = self._maxNumber
	end

	self:refreshSlider()
	self:refreshSliderText()
	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyMediator:onClickedLeftBtn()
	self._curNumber = self._curNumber - 1

	if self._curNumber < 0 then
		self._curNumber = 1
	end

	self:refreshSlider()
	self:refreshSliderText()
	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyMediator:onClickedMaxBtn()
	if self._curNumber ~= self._maxNumber then
		self._curNumber = self._maxNumber

		self:refreshSlider()
		self:refreshSliderText()
		self:refreshBtnState()
		self:refreshMoney()
	end
end

function ShopBuyMediator:onClickedBuyBtn()
	if self._buyType == 2 then
		self._buyBtn:getButton():setTouchEnabled(false)
		self._buyFun()
		self:close()

		return
	end

	local costType = self._itemData:getCostType()
	local costPrice = self._itemData:getPrice()
	local costSum = self._curNumber * costPrice

	if self._maxNumber == 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("SHOP_BUY_TIMES_UNENOUGH")
		}))

		return
	elseif self._bagSystem:checkCostEnough(costType, costSum, {
		type = "tip"
	}) then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._buyBtn:getButton():setTouchEnabled(false)

		if self._callBack then
			self._callBack()
		else
			local params = {
				shopId = tostring(self._itemData:getShopId()),
				positionId = tostring(self._itemData:getPositionId()),
				count = self._curNumber
			}

			self._shopSystem:requestBuy(params)
		end

		self:close()
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end
end

function ShopBuyMediator:refreshBtnState()
	self._leftBtn:setEnabled(self._curNumber > 1)
	self._rightBtn:setEnabled(self._curNumber < self._maxNumber)
	self._maxBtn:setEnabled(self._curNumber < self._maxNumber)
	self._buyBtn:getButton():setEnabled(self._maxNumber ~= 0)
end

function ShopBuyMediator:refreshMoney()
	if self._itemData then
		local costPrice = self._itemData:getPrice()
		local costSum = self._curNumber * costPrice

		costSum = costSum == 0 and Strings:get("Recruit_Free") or costSum

		self._moneyText:setString(costSum)

		local colorNum = 1

		self._moneyText:setTextColor(GameStyle:getColor(colorNum))
	end
end

function ShopBuyMediator:refreshOneMoney()
	if self._itemData then
		local costType = self._itemData:getCostType()
		local costPrice = self._itemData:getPrice()
		local costSum = self._curNumber * costPrice
		local moneyText = self._onePriceNode:getChildByFullName("money_text")

		moneyText:setString(tostring(costSum))

		local colorNum = 1

		moneyText:setTextColor(GameStyle:getColor(colorNum))

		local moneyIcon = self._onePriceNode:getChildByFullName("money_icon")

		moneyIcon:removeAllChildren()

		local goldIcon = IconFactory:createPic({
			id = costType
		})

		goldIcon:addTo(moneyIcon)

		local buyText = self._onePriceNode:getChildByFullName("count_text")

		buyText:setString(Strings:get("Shop_Text16", {
			num = self._itemData:getAmount()
		}))
	end
end
