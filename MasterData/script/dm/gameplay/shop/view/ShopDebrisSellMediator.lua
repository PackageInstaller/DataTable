-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopDebrisSellMediator.lua

require("dm.gameplay.shop.view.component.ShopSellItem")

ShopDebrisSellMediator = class("ShopDebrisSellMediator", DmPopupViewMediator, _M)

ShopDebrisSellMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopDebrisSellMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local LAYOUT_WIDTH = 648
local LAYOUT_HEIGHT = 144
local FragmentChange = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Fragment_Change", "content")
local ExchangeConsume = {
	"IR_Fragment",
	"IR_FragmentSSR"
}

function ShopDebrisSellMediator:initialize()
	super.initialize(self)
end

function ShopDebrisSellMediator:dispose()
	super.dispose(self)
end

function ShopDebrisSellMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._sellBtn = self:bindWidget("main.yes_btn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onYesBtnClicked, self)
		}
	})
	self._selectBtn = self:bindWidget("main.selectBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onSelectBtnClicked, self)
		}
	})

	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("shop_UI39"),
		title1 = Strings:get("UITitle_EN_Suipianduihuan"),
		bgSize = {
			width = 840,
			height = 504
		}
	})
end

function ShopDebrisSellMediator:enterWithData(data)
	self._money = {}

	for i = 1, #ExchangeConsume do
		self._money[ExchangeConsume[i]] = 0
	end

	self._items = {}
	self._selectItems = {}
	self._entries = self._shopSystem:getCanExchangeBagEntries()

	self:initMember()
	self:initListView()
	self:refreshMoney()
end

function ShopDebrisSellMediator:initMember()
	local view = self:getView()

	self._yesBtn = view:getChildByFullName("main.yes_btn")

	local moneyPanel = view:getChildByFullName("main.money_panel")

	self._descLabel = moneyPanel:getChildByFullName("money_desc")
	self._moneyText = moneyPanel:getChildByFullName("money")
	self._moneyImg = moneyPanel:getChildByFullName("money_icon")
	self._moneyText1 = moneyPanel:getChildByFullName("money_1")
	self._moneyImg1 = moneyPanel:getChildByFullName("money_icon_1")
	self._cellClone = view:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
	view:getChildByFullName("main.desc"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._descLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyText1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function ShopDebrisSellMediator:initListView()
	local mainPanel = self:getView():getChildByFullName("main")

	self._listView = mainPanel:getChildByFullName("goods_listview")

	self._listView:setScrollBarEnabled(false)

	local length = math.ceil(#self._entries / 4)

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:ignoreContentAdaptWithSize(false)
		layout:setContentSize(cc.size(LAYOUT_WIDTH, LAYOUT_HEIGHT))
		self._listView:pushBackCustomItem(layout)

		for j = 1, 4 do
			local index = 4 * (i - 1) + j
			local data = self._entries[index]

			if data then
				local item = self._cellClone:clone()

				item:setVisible(true)
				self:createCell(item, data)
				layout:addChild(item)
				item:setPosition(cc.p(LAYOUT_WIDTH / 4 * (j - 1), 0))

				self._items[data.item:getId()] = {
					item = item,
					data = data
				}
			end
		end
	end
end

function ShopDebrisSellMediator:createCell(panel, data)
	local iconLayout = panel:getChildByFullName("icon_panel")
	local name = panel:getChildByFullName("good_name")
	local selectBtn = panel:getChildByFullName("selectBtn")

	selectBtn:setSwallowTouches(false)
	selectBtn:addClickEventListener(function()
		self:onClickSelect(selectBtn, data)
	end)
	selectBtn:getChildByFullName("image"):setVisible(false)
	iconLayout:removeAllChildren()
	name:setString(data.item:getName())
	GameStyle:setQualityText(name, data.item:getQuality())

	local icon = IconFactory:createIcon({
		id = data.item:getId(),
		amount = data.amount
	})

	icon:addTo(iconLayout):center(iconLayout:getContentSize())
	icon:setScale(0.8)
end

function ShopDebrisSellMediator:refreshMoney()
	for i, v in pairs(self._money) do
		self._money[i] = 0
	end

	for id, v in pairs(self._selectItems) do
		local item = v.item
		local count = v.count
		local heroId = item:getTargetId()
		local hero = self._heroSystem:getHeroById(heroId)
		local rarity = hero:getRarity()
		local rewardId = FragmentChange[tostring(rarity)]
		local rewards = RewardSystem:getRewardsById(rewardId)

		for i = 1, #rewards do
			local costType = rewards[i].code
			local costAmount = rewards[i].amount

			self._money[costType] = self._money[costType] or 0
			self._money[costType] = self._money[costType] + costAmount * count
		end
	end

	self._moneyImg:removeAllChildren()
	self._moneyImg1:removeAllChildren()
	self._moneyText:setString("")
	self._moneyText1:setString("")

	local goldIcon = IconFactory:createResourcePic({
		id = ExchangeConsume[1]
	})

	goldIcon:addTo(self._moneyImg)
	self._moneyText:setString(self._money[ExchangeConsume[1]])

	goldIcon = IconFactory:createResourcePic({
		id = ExchangeConsume[2]
	})

	goldIcon:addTo(self._moneyImg1)
	self._moneyText1:setString(self._money[ExchangeConsume[2]])
end

function ShopDebrisSellMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ShopDebrisSellMediator:onYesBtnClicked(sender, eventType)
	if table.nums(self._selectItems) == 0 then
		return
	end

	self._sellBtn:getButton():setTouchEnabled(false)
	AudioEngine:getInstance():playEffect("Se_Alert_Sell", false)

	local params = {}

	for id, v in pairs(self._selectItems) do
		params[id] = v.count
	end

	self._shopSystem:requestDebrisSell({
		items = params
	})
	self:close()
end

function ShopDebrisSellMediator:onSelectBtnClicked(sender, eventType)
	for id, v in pairs(self._items) do
		local node = v.item

		node:getChildByFullName("selectBtn.image"):setVisible(true)

		self._selectItems[id] = v.data
	end

	self:refreshMoney()
end

function ShopDebrisSellMediator:onClickSelect(selectBtn, data)
	local id = data.item:getId()

	if self._selectItems[id] then
		self._selectItems[id] = nil

		selectBtn:getChildByFullName("image"):setVisible(false)
	else
		self._selectItems[id] = data

		selectBtn:getChildByFullName("image"):setVisible(true)
	end

	self:refreshMoney()
end
