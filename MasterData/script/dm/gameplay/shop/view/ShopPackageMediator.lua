-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopPackageMediator.lua

ShopPackageMediator = class("ShopPackageMediator", DmPopupViewMediator, _M)

ShopPackageMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {}

function ShopPackageMediator:initialize()
	super.initialize(self)
end

function ShopPackageMediator:dispose()
	super.dispose(self)
end

function ShopPackageMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._sellBtn = self:bindWidget("main.yes_btn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onYesBtnClicked, self)
		}
	})

	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("shop_UI28"),
		title1 = Strings:get("UITitle_EN_Libao"),
		bgSize = {
			width = 840,
			height = 504
		}
	})
end

function ShopPackageMediator:enterWithData(data)
	self:initMember()

	if data then
		self._shopId = data.shopId or nil
	end

	if data then
		self._item = data.item or nil
	end

	self:initListView()
	self:refreshMoney()
end

function ShopPackageMediator:initMember()
	self._main = self:getView():getChildByFullName("main")
	self._listView = self._main:getChildByFullName("goods_listview")

	self._listView:setScrollBarEnabled(false)

	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._yesBtn = self._main:getChildByFullName("yes_btn")
	self._soldout = self._main:getChildByFullName("soldout")

	self._soldout:setVisible(false)

	self._text = self._main:getChildByFullName("text")
	self._iconNode = self._main:getChildByFullName("iconNode")
	self._iconName = self._main:getChildByFullName("goods_name_1")
	self._moneyPanel = self._main:getChildByFullName("money_panel")
	self._descLabel = self._moneyPanel:getChildByFullName("money_desc")
	self._moneyText = self._moneyPanel:getChildByFullName("money")
	self._moneyImg = self._moneyPanel:getChildByFullName("money_icon")
	self._totalMoney = self._moneyPanel:getChildByFullName("totalMoney")

	self._totalMoney:setVisible(false)
	self._totalMoney:setString("")

	self._lineImage = self._moneyPanel:getChildByFullName("lineImage")

	self._lineImage:setVisible(false)
	self._main:getChildByFullName("countLabel"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("desc"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._cellClone:getChildByFullName("good_number"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._descLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._totalMoney:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function ShopPackageMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ShopPackageMediator:onYesBtnClicked()
	self._sellBtn:getButton():setTouchEnabled(false)
	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
	self._shopSystem:requestBuyPackageShop(self._item:getId(), nil, self._item:getIsFree())
	self:close()
end

function ShopPackageMediator:initListView()
	self._iconNode:removeAllChildren()

	local iconPath = self._item:getIcon()
	local icon = ccui.ImageView:create(iconPath, 1)

	icon:addTo(self._iconNode):center(self._iconNode:getContentSize())

	local name = self._item:getName()

	self._iconName:setString(name)
	GameStyle:setQualityText(self._iconName, self._item:getQuality())

	local showTime = self._shopSystem:checkTimeTagShow(self._item)
	local times1 = self._item:getLeftCount()
	local times2 = self._item:getStorage()

	if times1 == -1 then
		self._text:setVisible(false)
	end

	if not showTime or times1 == 0 then
		self._moneyPanel:setVisible(false)
		self._soldout:setVisible(true)
		self._yesBtn:setVisible(false)
	else
		self._moneyPanel:setVisible(true)
		self._yesBtn:setVisible(true)

		local str = times1 == -1 and "" or times1 .. "/" .. times2

		self._main:getChildByFullName("countLabel"):setString(str)
	end

	local rewardId = self._item:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)
	local isFree = self._item:getIsFree()

	if isFree == 1 and self._item:getTimeTypeType() == "day" then
		local var_8_0 = Strings:get("FreePackageShopUI")

		if not var_8_0 then
			var_8_0 = Strings:get("shop_UI33")

			local s = var_8_0

			self:getView():getChildByFullName("main.desc"):setString(s)

			for i = 1, #rewards do
				local data = rewards[i]
				local node = self._cellClone:clone()

				node:setVisible(true)
				node:setPosition(cc.p(0, 0))

				local str = "X" .. tostring(data.amount)

				node:getChildByFullName("good_number"):setString((data.type == 3 or nil) and "X1")

				local name = node:getChildByFullName("good_name")

				name:setString(RewardSystem:getName(data))

				local quality = ConfigReader:getDataByNameIdAndKey("ItemConfig", data.code, "Quality")

				GameStyle:setQualityText(name, quality)

				local iconPanel = node:getChildByFullName("icon_panel")

				iconPanel:removeAllChildren()

				local icon = IconFactory:createRewardIcon(data, {
					showAmount = false,
					isWidget = true
				})

				icon:addTo(iconPanel):center(iconPanel:getContentSize())
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), data, {
					needDelay = true
				})
				icon:setScaleNotCascade(0.8)
				self._listView:pushBackCustomItem(node)
			end
		end
	end
end

function ShopPackageMediator:refreshMoney()
	if not self._item then
		return
	end

	local symbol, price = self._item:getPaySymbolAndPrice(self._item:getPayId())

	self._moneyImg:setVisible(false)

	local isFree = self._item:getIsFree()
	local price = price

	price = isFree == 1 and Strings:get("Recruit_Free") or symbol .. price

	self._moneyText:setString(price)

	local costOff = self._item:getCostOff()

	if costOff ~= 1 then
		local totalPrice = price

		if costOff * 10 ~= 0 then
			totalPrice = math.ceil(totalPrice / costOff)
		end

		self._totalMoney:setString(totalPrice)
		self._totalMoney:setVisible(true)
		self._lineImage:setVisible(true)
	else
		self._totalMoney:setString("")
		self._totalMoney:setVisible(false)
		self._lineImage:setVisible(false)
	end

	local width1 = self._moneyText:getContentSize().width
	local width2 = self._totalMoney:getContentSize().width

	self._totalMoney:setPositionX(self._moneyText:getPositionX() + width1 + 10)
	self._lineImage:setPositionX(self._totalMoney:getPositionX() + width2 / 2)
	self._lineImage:setContentSize(cc.size(width2 + 20, 16))
end
