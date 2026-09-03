-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopBuyPackageMediator.lua

ShopBuyPackageMediator = class("ShopBuyPackageMediator", DmPopupViewMediator, _M)

ShopBuyPackageMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopBuyPackageMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopBuyPackageMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")

local kBtnHandlers = {
	["main.btnBuy"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedBuyBtn"
	},
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
	["main.slider_panel.min_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedMinBtn"
	}
}

function ShopBuyPackageMediator:initialize()
	super.initialize(self)
end

function ShopBuyPackageMediator:dispose()
	super.dispose(self)
end

function ShopBuyPackageMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function ShopBuyPackageMediator:enterWithData(data)
	self._data = data.item
	self._callBack = data.callback or nil

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ShopBuyPackageMediator:initMember()
	self._bagSystem = self._developSystem:getBagSystem()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._iconLayout = mainPanel:getChildByFullName("iconPanel")
	self._iconName = mainPanel:getChildByFullName("iconName")
	self._moneySymbol = mainPanel:getChildByFullName("moneySymbol")
	self._moneyNum = mainPanel:getChildByFullName("moneyNum")
	self._moneyIcon = mainPanel:getChildByFullName("money_icon")
	self._freeText = mainPanel:getChildByFullName("getText")
	self._discont = mainPanel:getChildByFullName("discont")
	self._listView = mainPanel:getChildByFullName("goods_listview")

	self._listView:setScrollBarEnabled(false)

	self._buyTimes = mainPanel:getChildByFullName("buyTimes")
	self._cellClone = mainPanel:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._btnBuy = mainPanel:getChildByFullName("btnBuy")
	self._desc = mainPanel:getChildByFullName("desc")

	self._desc:setVisible(false)

	self._descListView = mainPanel:getChildByFullName("descListView")
	self._sliderPanel = mainPanel:getChildByFullName("slider_panel")

	self._sliderPanel:setTouchEnabled(true)
	self._sliderPanel:setVisible(false)

	self._buyTimesPanel = self._sliderPanel:getChildByFullName("timesnode")
	self._onePriceNode = self._sliderPanel:getChildByFullName("Node_price")
	self._leftBtn = self._sliderPanel:getChildByFullName("left_btn")
	self._rightBtn = self._sliderPanel:getChildByFullName("right_btn")
	self._maxBtn = self._sliderPanel:getChildByFullName("max_btn")
	self._minBtn = self._sliderPanel:getChildByFullName("min_btn")
	self._moneyIconSum = self._onePriceNode:getChildByFullName("money_icon")
	self._selectCount = self._buyTimesPanel:getChildByFullName("changetime_text_cur_count")
	self._totalPrice = self._onePriceNode:getChildByFullName("money_text")
end

function ShopBuyPackageMediator:refreshData()
	self._isFree = self._data:getIsFree()

	if self._isFree == KShopBuyType.KCoin then
		self._storage = self._data:getStorage()
		self._maxNumber = self._data:getLeftCount()

		if self._storage == -1 then
			local amount = self._data:getGameCoin().amount
			local costType = self._data:getGameCoin().type
			local maxMoney = self._bagSystem:getItemCount(costType)
			local costPrice = tonumber(amount)
			local maxNum = math.floor(maxMoney / costPrice)

			maxNum = maxNum <= 0 and 1 or maxNum
			self._maxNumber = maxNum
		end

		if self._maxNumber == 0 then
			self._curNumber = 0
			self._minNumber = 0
		else
			self._curNumber = 1
			self._minNumber = 1
		end
	end
end

function ShopBuyPackageMediator:refreshView()
	self:refreshIcon()

	local descString = self._data:getDesc()

	self._descListView:removeAllChildren()
	self._descListView:setScrollBarEnabled(false)

	local node = self._desc:clone()

	node:setPosition(cc.p(0, 0))
	node:setVisible(true)
	node:setString(descString)
	node:getVirtualRenderer():setDimensions(self._descListView:getContentSize().width, 0)

	local fontSize = node:getContentSize()

	self._descListView:pushBackCustomItem(node)

	if fontSize.height >= 25 then
		self._descListView:setTouchEnabled(true)
		self._descListView:setPositionY(139)
	else
		self._descListView:setTouchEnabled(false)
		self._descListView:setPositionY(122)
	end

	local name = self._data:getName()

	self._iconName:setString(name)
	self._freeText:setVisible(false)
	self._moneySymbol:setString("")
	self._moneyNum:setString("")
	self._moneyIcon:removeAllChildren()
	self._moneyIconSum:removeAllChildren()
	self._listView:removeAllChildren()

	if self._isFree == KShopBuyType.KCoin then
		local goldIcon = IconFactory:createResourcePic({
			id = self._data:getGameCoin().type
		})

		goldIcon:addTo(self._moneyIcon):center(self._moneyIcon:getContentSize()):offset(0, 0)
		self._moneyNum:setString(tostring(self._data:getGameCoin().amount))

		local goldIcon1 = IconFactory:createResourcePic({
			id = self._data:getGameCoin().type
		})

		goldIcon1:addTo(self._moneyIconSum):setScale(0.8)
		self._sliderPanel:setVisible(true)
		self:refreshMoney()
	elseif self._isFree == KShopBuyType.KFree then
		self._freeText:setVisible(true)
	else
		local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
		local symbol, price = payOffSystem:getPaySymbolAndPrice(self._data._payId)

		self._moneySymbol:setString(symbol)
		self._moneyNum:setString(price)
		self._moneySymbol:setPositionX(714)
		self._moneyNum:setPositionX(714 + self._moneySymbol:getContentSize().width + 2)
	end

	local rewardId = self._data:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)

	self._discont:setVisible(false)

	if self._data:getCostOff() ~= nil then
		self._discont:setVisible(true)
		self._discont:getChildByFullName("number"):setString(tostring(self._data:getCostOff() * 100) .. "%")
	end

	self._buyTimes:setVisible(false)

	if self._data:getStorage() > 0 then
		self._buyTimes:setVisible(true)
		self._buyTimes:getChildByFullName("good_number"):setString(Strings:get("Shop_BuyNumLimit") .. "(" .. self._data:getLeftCount() .. "/" .. self._data:getStorage() .. ")")
	end

	for i = 1, #rewards do
		local data = rewards[i]
		local node = self._cellClone:clone()

		node:setVisible(true)
		node:setPosition(cc.p(0, 0))

		local str = "x" .. tostring(data.amount)

		node:getChildByFullName("good_number"):setString((data.type == 3 or nil) and "x1")

		local name = node:getChildByFullName("good_name")

		name:setString(RewardSystem:getName(data))

		local quality = ConfigReader:getDataByNameIdAndKey("ItemConfig", data.code, "Quality")
		local iconPanel = node:getChildByFullName("icon")
		local icon = IconFactory:createRewardIcon(data, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = false,
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), data, {
			needDelay = true
		})
		icon:setScale(0.49)
		icon:addTo(iconPanel):center(iconPanel:getContentSize())
		self._listView:pushBackCustomItem(node)
	end
end

function ShopBuyPackageMediator:refreshIcon()
	self._iconLayout:removeAllChildren()

	local icon = ccui.ImageView:create(self._data:getBuyIcon(), ccui.TextureResType.localType)

	if icon then
		self._iconLayout:addChild(icon)

		local scale = self._data._config.WindowIcon ~= "" and 0.7 or 1

		icon:setScale(scale)
		icon:setAnchorPoint(cc.p(0.5, 0.5))

		local pos = cc.p(self._iconLayout:getContentSize().width / 2, self._iconLayout:getContentSize().height / 2)

		icon:setPosition(pos)
	end
end

function ShopBuyPackageMediator:onClickedBuyBtn()
	if self._shopSystem:getVersionCanBuy(self._data, Strings:get("Activity_Version_Tips1")) then
		if self._data.getCondition then
			local condition = self._data:getCondition()

			if self._data.getCondition and self._data.getCondition.heroid then
				local heroNames = {}
				local ret = false

				for i, v in ipairs(self._data.getCondition.heroid) do
					local heroInfo = self._heroSystem:getHeroInfoById(v)

					if not self._heroSystem:hasHero(v) then
						table.insert(heroNames, heroInfo.name)

						ret = true
					end
				end

				if ret then
					if #heroNames == 1 then
						if not heroNames[1] then
							local tips = table.concat(heroNames, ", ")

							self:dispatch(ShowTipEvent({
								tip = Strings:get("Error_suipian1", {
									hero = tips
								})
							}))

							return
						end
					end
				end
			end

			if self._isFree == KShopBuyType.KCoin then
				if self._maxNumber == 0 then
					AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
					self:dispatch(ShowTipEvent({
						tip = Strings:get("SHOP_BUY_TIMES_UNENOUGH")
					}))

					return
				end

				local costId = self._data:getGameCoin().type
				local amount = self._data:getGameCoin().amount

				if CurrencySystem:checkEnoughCurrency(self, costId, tonumber(amount), {
					type = "tip"
				}) then
					AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
					self._shopSystem:requestBuyPackageShopCount(self._data:getId(), self._curNumber, nil, self._isFree)
					self:close()
				end
			else
				AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
				self._shopSystem:requestBuyPackageShop(self._data:getId(), nil, self._isFree)
				self:close()
			end
		end
	end
end

function ShopBuyPackageMediator:onClickedRightBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._curNumber + 1

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyPackageMediator:onClickedLeftBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._curNumber - 1

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyPackageMediator:onClickedMaxBtn()
	if self._curNumber >= self._maxNumber then
		self._curNumber = self._maxNumber

		return
	end

	self._curNumber = self._maxNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyPackageMediator:onClickedMinBtn()
	if self._curNumber <= self._minNumber then
		self._curNumber = self._minNumber

		return
	end

	self._curNumber = self._minNumber

	self:refreshBtnState()
	self:refreshMoney()
end

function ShopBuyPackageMediator:refreshBtnState()
	return
end

function ShopBuyPackageMediator:refreshMoney()
	if self._data then
		local costPrice = tonumber(self._data:getGameCoin().amount)
		local costSum = self._curNumber * costPrice

		self._selectCount:setString(self._curNumber)
		self._totalPrice:setString(costSum)
	end
end
