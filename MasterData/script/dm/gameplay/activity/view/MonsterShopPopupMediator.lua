-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/MonsterShopPopupMediator.lua

MonsterShopPopupMediator = class("MonsterShopPopupMediator", DmPopupViewMediator, _M)

MonsterShopPopupMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
MonsterShopPopupMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local LAYOUT_WIDTH = 648
local LAYOUT_HEIGHT = 144
local kNum = 3

function MonsterShopPopupMediator:initialize()
	super.initialize(self)
end

function MonsterShopPopupMediator:dispose()
	super.dispose(self)
end

function MonsterShopPopupMediator:onRegister()
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
		title = "",
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		bgSize = {
			width = 840,
			height = 504
		}
	})
end

function MonsterShopPopupMediator:enterWithData(data)
	self:initData(data)
	self:initMember()
	self:initListView()
	self:refreshMoney()
end

function MonsterShopPopupMediator:initData(data)
	if data then
		if data.func then
			self._function = data.func
		end

		if data.filter then
			self._entryFunction = data.filter
		end

		self._moneyFunc = data.moneyFunc
		self._rewards = data.rewards
		self._num = data.lineNum or kNum
		self._title = data.title
		self._title1 = data.title1
		self._descString = data.desc
		self._overflowString = data.overflowString
		self._callback = data.callback
	end
end

function MonsterShopPopupMediator:initMember()
	local view = self:getView()

	self._yesBtn = view:getChildByFullName("main.yes_btn")
	self._moneyPanel = view:getChildByFullName("main.money_panel")
	self._descLabel = self._moneyPanel:getChildByFullName("money_desc")
	self._moneyText = self._moneyPanel:getChildByFullName("money")
	self._moneyImg = self._moneyPanel:getChildByFullName("money_icon")
	self._money = 0

	view:getChildByFullName("main.desc"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._descLabel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._moneyText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	if self._descString then
		view:getChildByFullName("main.desc"):setString(self._descString)
	end

	local var_6_0 = {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		}
	}

	var_6_0.title = self._title or Strings:get("SHOP_Text_12")
	var_6_0.title1 = self._title1 or Strings:get("UITitle_EN_Chushou")
	var_6_0.bgSize = {
		width = 840,
		height = 504
	}

	self:bindWidget("main.bg", PopupNormalWidget, var_6_0)
end

function MonsterShopPopupMediator:onCloseClicked(sender, eventType)
	self:close({
		callback = self._callback
	})
end

function MonsterShopPopupMediator:onYesBtnClicked(sender, eventType)
	self._sellBtn:getButton():setTouchEnabled(false)
	AudioEngine:getInstance():playEffect("Se_Alert_Sell", false)

	if self._function then
		self:_function()
	end

	self:close({
		callback = self._callback
	})
end

function MonsterShopPopupMediator:initListView()
	local mainPanel = self:getView():getChildByFullName("main")

	self._listView = mainPanel:getChildByFullName("goods_listview")

	self._listView:setScrollBarEnabled(false)

	self._money = 0

	local entrys = {}

	if self._rewards then
		for i = 1, #self._rewards do
			local reward = RewardSystem:parseInfo(self._rewards[i])

			entrys[#entrys + 1] = {
				id = reward.id,
				amount = reward.amount
			}
		end
	else
		entrys = self._entryFunction and self:_entryFunction() or {}
	end

	if #entrys < self._num then
		self._num = #entrys or 1
	end

	local length = math.ceil(#entrys / self._num)

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:ignoreContentAdaptWithSize(false)
		layout:setContentSize(cc.size(LAYOUT_WIDTH, LAYOUT_HEIGHT))
		self._listView:pushBackCustomItem(layout)

		for j = 1, self._num do
			local index = self._num * (i - 1) + j

			if not entrys[index].id then
				local id = entrys[index]
				local data = self._bagSystem:getEntryById(id)

				if data and data.item then
					local iconNode = cc.Node:create()

					layout:addChild(iconNode)

					if not entrys[index].amount then
						local amount = self._bagSystem:getItemCount(id)
						local icon = IconFactory:createIcon({
							id = id,
							amount = amount
						}, {
							showAmount = true,
							isWidget = true
						})

						icon:setScale(0.8)
						IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), {
							code = id,
							amount = amount,
							type = RewardType.kItem
						}, {
							swallowTouches = true,
							needDelay = true
						})
						icon:addTo(iconNode):center(iconNode:getContentSize()):offset(0, 30)

						local itemConfig = self._bagSystem:getItemConfig(id)

						if itemConfig then
							::label_9_0::

							local name = Strings:get(itemConfig.Name)
							local nameText = cc.Label:createWithTTF(name, TTF_FONT_FZYH_M, 16, cc.size(100, 60))

							nameText:setAlignment(1, 0)
							nameText:setAnchorPoint(cc.p(0.5, 1))
							nameText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
							nameText:addTo(iconNode):center(iconNode:getContentSize()):offset(0, -50)
							nameText:setOverflow(cc.LabelOverflow.SHRINK)
							nameText:setDimensions(100, 50)
							iconNode:setPosition(cc.p(j * 160 + 80 * (kNum - self._num), 50))
						end
					end
				end
			end
		end
	end
end

function MonsterShopPopupMediator:refreshMoney()
	if self._moneyFunc then
		local moneyId1, moneyNum, overflow = self:_moneyFunc()
		local temp = self._moneyPanel:getChildByFullName("overflow")

		if temp then
			temp:removeFromParent()
		end

		if self._overflowString and overflow then
			local text = ccui.Text:create(self._overflowString, TTF_FONT_FZYH_R, 18)

			text:setColor(cc.c3b(195, 195, 195))
			text:setAnchorPoint(cc.p(0.5, 0.5))
			text:addTo(self._moneyImg):setPosition(0, 42):setName("overflow")
		end

		self._money = moneyNum or 0

		local goldIcon = IconFactory:createResourcePic({
			id = moneyId1
		})

		goldIcon:addTo(self._moneyImg)
		self._moneyText:setString(self._money)
		self._moneyPanel:setVisible(true)
	else
		self._moneyPanel:setVisible(false)
	end
end
