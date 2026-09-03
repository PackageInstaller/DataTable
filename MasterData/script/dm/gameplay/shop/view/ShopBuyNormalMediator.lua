-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopBuyNormalMediator.lua

ShopBuyNormalMediator = class("ShopBuyNormalMediator", DmPopupViewMediator, _M)

ShopBuyNormalMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopBuyNormalMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

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
local rarityShopNormalBuyBgMap = {
	"sd_tc_dj_bg.png",
	"sd_tc_dj_bg_2.png",
	"sd_tc_dj_bg_3.png",
	"sd_tc_dj_bg_4.png",
	"sd_tc_dj_bg_5.png",
	"sd_tc_dj_bg_6.png"
}

function ShopBuyNormalMediator:initialize()
	super.initialize(self)
end

function ShopBuyNormalMediator:dispose()
	if self._timeSchel then
		self:getView():getScheduler():unscheduleScriptEntry(self._timeSchel)

		self._timeSchel = nil
	end

	super.dispose(self)
end

function ShopBuyNormalMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshByRset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_REFRESH_SUCC, self, self.onRefreshShopSuccess)
end

function ShopBuyNormalMediator:enterWithData(data)
	self._itemData = data.itemData
	self._callBack = data.callback or nil

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ShopBuyNormalMediator:refreshByRset(event)
	self:refreshData()
	self:refreshView()
end

function ShopBuyNormalMediator:onRefreshShopSuccess(event)
	self:refreshData()
	self:refreshView()
end

function ShopBuyNormalMediator:onCloseClicked()
	self:close()
end

function ShopBuyNormalMediator:refreshData()
	self._storage = self._itemData:getStorage()
	self._maxNumber = self._itemData:getStock()

	local costType = self._itemData:getCostType()
	local maxMoney = self._bagSystem:getItemCount(costType)
	local costPrice = self._itemData:getPrice()
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

function ShopBuyNormalMediator:initMember()
	self._bagSystem = self._developSystem:getBagSystem()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._iconLayout = mainPanel:getChildByFullName("icon_panel")
	self._icon = mainPanel:getChildByFullName("icon")
	self._sliderPanel = mainPanel:getChildByFullName("slider_panel")

	self._sliderPanel:setTouchEnabled(true)

	self._buyBtn = mainPanel:getChildByFullName("slider_panel.btn_buy")
	self._buyTimesPanel = self._sliderPanel:getChildByFullName("timesnode")
	self._moneyNode = self._sliderPanel:getChildByFullName("costNode")
	self._nameText = mainPanel:getChildByFullName("name_text")
	self._nameText_1 = mainPanel:getChildByFullName("name_text_1")
	self._imageBg = mainPanel:getChildByFullName("ImageBg")
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

function ShopBuyNormalMediator:refreshBaseShowView()
	self._moneyIcon:removeAllChildren()
	self._moneyIconSum:removeAllChildren()
	self._numberText:setString(tostring(self._bagSystem:getItemCount(self._itemData:getItemId())))
	self._nameText:setString(self._itemData:getName())
	self._nameText_1:setString(self._itemData:getName())

	local descString
	local rarity = 11

	if self._itemData:getEquipInfo() then
		self._numberPanel:setVisible(false)

		rarity = tonumber(self._itemData:getEquipInfo().rarity)
		descString = Strings:get(self._itemData:getItemConfig().Desc)
	else
		rarity = tonumber(self._itemData:getQuality())
		descString = Strings:get(self._itemData:getItemConfig().FunctionDesc)
	end

	self._imageBg:loadTexture(rarityShopNormalBuyBgMap[rarity], ccui.TextureResType.plistType)
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

	local goldIcon = IconFactory:createResourcePic({
		id = self._itemData:getCostType()
	})

	goldIcon:addTo(self._moneyIcon):setScale(1.1)

	local goldIcon1 = IconFactory:createResourcePic({
		id = self._itemData:getCostType()
	})

	goldIcon1:addTo(self._moneyIconSum):setScale(0.8)

	local times1 = self._itemData:getStock()
	local times2 = self._itemData:getStorage()

	self._soldOut:setVisible(false)
	self._sliderPanel:setVisible(true)
	self._buyBtn:setVisible(true)

	local updateTime = self._itemData:getUpdateTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local hasTimeRecover = self._itemData:getUpdateTime() > gameServerAgent:remoteTimestamp() and times1 < times2

	self._curCount:setString("x" .. self._itemData:getAmount())
	self:refreshMoney()
end

function ShopBuyNormalMediator:refreshView()
	self:refreshIcon()
	self:refreshBaseShowView()
	self:refreshBtnState()
end

function ShopBuyNormalMediator:refreshIcon()
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
			id = self._itemData:getItemId(),
			amount = self._itemData:getAmount()
		}, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = true,
			isWidget = true
		})

		icon:setScale(1.5)
	end

	icon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
	self._icon:removeAllChildren()

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
			id = self._itemData:getItemId(),
			amount = self._itemData:getAmount()
		}, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = false,
			isWidget = true
		})

		icon:setScale(0.5)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), {
			code = self._itemData:getItemId(),
			type = RewardType.kItem,
			amount = self._itemData:getAmount()
		}, {
			swallowTouches = true,
			needDelay = true
		})
	end

	icon:addTo(self._icon):center(self._icon:getContentSize())
end

function ShopBuyNormalMediator:onClickedRightBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._curNumber + 1

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyNormalMediator:onClickedLeftBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._curNumber - 1

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyNormalMediator:onClickedMaxBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._maxNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyNormalMediator:onClickedMinBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._minNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyNormalMediator:onClickedBuyBtn()
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

function ShopBuyNormalMediator:refreshBtnState()
	return
end

function ShopBuyNormalMediator:refreshMoney()
	if self._itemData then
		local costPrice = self._itemData:getPrice()
		local costSum = self._curNumber * costPrice

		self._price:setString(costPrice)
		self._selectCount:setString(self._curNumber)
		self._remainCount:setString(self._itemData:getStock())
		self._totalPrice:setString(costSum)
		self._remainCount:setVisible(true)
		self._buyTitleText:setVisible(true)

		if self._storage == -1 then
			self._buyTitleText:setVisible(false)
			self._remainCount:setVisible(false)
		end
	end
end
