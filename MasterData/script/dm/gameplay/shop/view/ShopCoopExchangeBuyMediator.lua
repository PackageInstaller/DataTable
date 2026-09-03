-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopCoopExchangeBuyMediator.lua

ShopCoopExchangeBuyMediator = class("ShopCoopExchangeBuyMediator", DmPopupViewMediator, _M)

ShopCoopExchangeBuyMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopCoopExchangeBuyMediator:has("_shopSystem", {
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
	"sd_tc_dj_bg_6.png",
	nil,
	nil,
	nil,
	"sd_tc_dj_bg.png",
	"sd_tc_dj_bg_2.png",
	"sd_tc_dj_bg_3.png",
	"sd_tc_dj_bg_4.png",
	"sd_tc_dj_bg_5.png"
}

function ShopCoopExchangeBuyMediator:initialize()
	super.initialize(self)
end

function ShopCoopExchangeBuyMediator:dispose()
	super.dispose(self)
end

function ShopCoopExchangeBuyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ShopCoopExchangeBuyMediator:enterWithData(data)
	self._activity = data.activity
	self._itemData = data.itemData
	self._callBack = data.callback or nil

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ShopCoopExchangeBuyMediator:onCloseClicked()
	self:close()
end

function ShopCoopExchangeBuyMediator:refreshData()
	local haveAmount = self._activity:getExchangeAmount(self._itemData.id)
	local enoughAmount = self._activity:getExchangeCountById(self._itemData.id)

	self._curNumber = 1

	local maxNum = math.max(self._activity:getExchangeCountById(self._itemData.id), 1)

	self._maxNumber = math.min(maxNum, haveAmount)
	self._minNumber = 1
end

function ShopCoopExchangeBuyMediator:initMember()
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

function ShopCoopExchangeBuyMediator:refreshBaseShowView()
	self._moneyIcon:removeAllChildren()
	self._moneyIconSum:removeAllChildren()

	local config = self._itemData.config
	local targetList = ConfigReader:getDataByNameIdAndKey("Reward", config.Target, "Content")

	self._numberText:setString(tostring(self._bagSystem:getItemCount(targetList[1].code)))
	self._nameText:setString(RewardSystem:getName(targetList[1]))
	self._nameText_1:setString(RewardSystem:getName(targetList[1]))

	local descString = RewardSystem:getDesc(targetList[1])
	local rarity = RewardSystem:getQuality(targetList[1])

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

	local costItem = config.Cost[1]
	local goldIcon = IconFactory:createRewardIcon(costItem, {
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	goldIcon:addTo(self._moneyIcon):setScale(0.5)

	local goldIcon1 = IconFactory:createRewardIcon(costItem, {
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	goldIcon1:addTo(self._moneyIconSum):setScale(0.25)
	self._soldOut:setVisible(false)
	self._sliderPanel:setVisible(true)
	self._buyBtn:setVisible(true)
	self._curCount:setString("x" .. targetList[1].amount)

	if targetList[1].type == RewardType.kHero then
		self._curCount:setString("x1")
	end

	self:refreshMoney()
end

function ShopCoopExchangeBuyMediator:refreshView()
	self:refreshIcon()
	self:refreshBaseShowView()
end

function ShopCoopExchangeBuyMediator:refreshIcon()
	self._iconLayout:removeAllChildren()

	local config = self._itemData.config
	local targetList = ConfigReader:getDataByNameIdAndKey("Reward", config.Target, "Content")
	local icon = IconFactory:createRewardIcon(targetList[1], {
		hideLevel = true,
		showAmount = false,
		notShowQulity = true,
		isWidget = true
	})

	icon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
	icon:setScale(1.3)
	self._icon:removeAllChildren()

	local icon = IconFactory:createRewardIcon(targetList[1], {
		hideLevel = true,
		showAmount = false,
		isWidget = true
	})

	icon:setScale(0.6)
	icon:addTo(self._icon):center(self._icon:getContentSize())
	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), targetList[1], {
		needDelay = true
	})
end

function ShopCoopExchangeBuyMediator:onClickedRightBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._curNumber + 1

	self:refreshMoney()
end

function ShopCoopExchangeBuyMediator:onClickedLeftBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._curNumber - 1

	self:refreshMoney()
end

function ShopCoopExchangeBuyMediator:onClickedMaxBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._maxNumber

	self:refreshMoney()
end

function ShopCoopExchangeBuyMediator:onClickedMinBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._minNumber

	self:refreshMoney()
end

function ShopCoopExchangeBuyMediator:onClickedBuyBtn()
	if self._itemData then
		local config = self._itemData.config
		local costPrice = config.Cost[1].amount
		local costSum = self._curNumber * costPrice

		if self._maxNumber == 0 then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("SHOP_BUY_TIMES_UNENOUGH")
			}))

			return
		elseif self._bagSystem:checkCostEnough(config.Cost[1].code, costSum, {
			type = "tip"
		}) then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if self._callBack then
				self._callBack(self._activity:getId(), self._itemData.id, self._curNumber)
			end

			self:close()
		else
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		end
	end
end

function ShopCoopExchangeBuyMediator:refreshMoney()
	if self._itemData then
		local config = self._itemData.config
		local costPrice = config.Cost[1].amount
		local costSum = self._curNumber * costPrice

		self._price:setString(costPrice)
		self._selectCount:setString(self._curNumber)
		self._remainCount:setString(self._activity:getExchangeAmount(self._itemData.id))
		self._totalPrice:setString(costSum)
		self._remainCount:setVisible(true)
		self._buyTitleText:setVisible(true)
	end
end
