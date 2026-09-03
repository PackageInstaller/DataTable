-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopSellMediator.lua

require("dm.gameplay.shop.view.component.ShopSellItem")

ShopSellMediator = class("ShopSellMediator", DmPopupViewMediator, _M)

ShopSellMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopSellMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local LAYOUT_WIDTH = 648
local LAYOUT_HEIGHT = 144

function ShopSellMediator:initialize()
	super.initialize(self)
end

function ShopSellMediator:dispose()
	super.dispose(self)
end

function ShopSellMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
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
		title = Strings:get("SHOP_Text_12"),
		title1 = Strings:get("UITitle_EN_Chushou"),
		bgSize = {
			width = 840,
			height = 504
		}
	})
end

function ShopSellMediator:enterWithData(data)
	self:initMember()
	self:initListView()
	self:refreshMoney()
end

function ShopSellMediator:initMember()
	local view = self:getView()

	self._yesBtn = view:getChildByFullName("main.yes_btn")

	local moneyPanel = view:getChildByFullName("main.money_panel")

	self._descLabel = moneyPanel:getChildByFullName("money_desc")
	self._moneyText = moneyPanel:getChildByFullName("money")
	self._moneyImg = moneyPanel:getChildByFullName("money_icon")
	self._money = 0

	view:getChildByFullName("main.desc"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._descLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function ShopSellMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ShopSellMediator:onYesBtnClicked(sender, eventType)
	self._sellBtn:getButton():setTouchEnabled(false)
	AudioEngine:getInstance():playEffect("Se_Alert_Sell", false)

	if self._function then
		self._function()
	else
		self._shopSystem:requestAutoSell()
	end

	self:close()
end

function ShopSellMediator:initListView()
	local mainPanel = self:getView():getChildByFullName("main")

	self._listView = mainPanel:getChildByFullName("goods_listview")

	self._listView:setScrollBarEnabled(false)

	local node = cc.CSLoader:createNode("asset/ui/shopSellItem.csb")
	local template = node:getChildByName("main")

	self._money = 0

	if self._entryFunction then
		local var_8_0 = self._entryFunction()

		if not var_8_0 then
			var_8_0 = self._shopSystem:getCanSellBagEntrys()

			local entrys = var_8_0
			local length = math.ceil(#entrys / 4)

			for i = 1, length do
				local layout = ccui.Layout:create()

				layout:ignoreContentAdaptWithSize(false)
				layout:setContentSize(cc.size(LAYOUT_WIDTH, LAYOUT_HEIGHT))
				self._listView:pushBackCustomItem(layout)

				for j = 1, 4 do
					local index = 4 * (i - 1) + j
					local id = entrys[index]
					local data = self._bagSystem:getEntryById(id)

					if data and data.item then
						self._money = self._money + data.item:getSellNumber() * data.count

						local item = ShopSellItem:new()

						item:setInfo(data, template:clone())
						layout:addChild(item:getView())
						item:getView():setPosition(cc.p(LAYOUT_WIDTH / 4 * (j - 1), 0))
					end
				end
			end
		end
	end
end

function ShopSellMediator:refreshMoney()
	local goldIcon = IconFactory:createResourcePic({
		id = CurrencyIdKind.kGold
	})

	goldIcon:addTo(self._moneyImg)
	self._moneyText:setString(self._money)
end
