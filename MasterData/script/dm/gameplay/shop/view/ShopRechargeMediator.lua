-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopRechargeMediator.lua

ShopRechargeMediator = class("ShopRechargeMediator", DmAreaViewMediator, _M)

ShopRechargeMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopRechargeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopRechargeMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")

local kNums = 4
local kCellWidth = 948

function ShopRechargeMediator:initialize()
	super.initialize(self)
end

function ShopRechargeMediator:dispose()
	self:getView():stopAllActions()
	self:stopItemActions()
	super.dispose(self)
end

function ShopRechargeMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function ShopRechargeMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DIAMOND_RECHARGE_SUCC, self, self.onRechargeSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
end

function ShopRechargeMediator:onRemove()
	super.onRemove(self)
end

function ShopRechargeMediator:setupView()
	self:initMember()
end

function ShopRechargeMediator:refreshData()
	local items = self._rechargeSystem:getRechargeGoodsList()

	self._bestItem = items[1]
	self._curShopItems = {}

	for i = 1, #items do
		table.insert(self._curShopItems, items[i])
	end
end

function ShopRechargeMediator:initMember()
	local panel = self:getView()

	self._cellClone = panel:getChildByFullName("rechargeClone")

	self._cellClone:setVisible(false)

	self._mainPanel = panel:getChildByFullName("main")

	self._cellClone:getChildByFullName("cell.touch_panel"):setLocalZOrder(10)
	self._cellClone:getChildByFullName("cell.touch_panel"):setTouchEnabled(true)
	self._cellClone:getChildByFullName("cell.touch_panel"):setSwallowTouches(false)
	self:adjustView()
end

function ShopRechargeMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentHeight = winSize.height - 50

	self._scrollView = self._mainPanel:getChildByName("scrollView")

	self._scrollView:setContentSize(cc.size(kCellWidth, currentHeight))
	self._scrollView:setScrollBarEnabled(false)

	self._cellHeight = self._cellClone:getContentSize().height
end

function ShopRechargeMediator:clearView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()
end

function ShopRechargeMediator:refreshView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()

	local length = math.ceil(#self._curShopItems / kNums)
	local viewHeight = self._scrollView:getContentSize().height
	local allHeight = math.max(viewHeight, self._cellHeight * length)

	self._scrollView:setInnerContainerSize(cc.size(kCellWidth, allHeight))
	self._scrollView:setInnerContainerPosition(cc.p(0, viewHeight - allHeight))

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(kCellWidth, self._cellHeight))
		layout:addTo(self._scrollView)
		layout:setTag(i)
		layout:setAnchorPoint(cc.p(0, 1))
		layout:setPosition(cc.p(0, allHeight - (i - 1) * self._cellHeight))
		layout:setTouchEnabled(false)
		self:createCell(layout, i)
	end

	self:runListAnim()
end

function ShopRechargeMediator:createCell(cell, index)
	for i = 1, kNums do
		local itemIndex = kNums * (index - 1) + i
		local itemData = self._curShopItems[itemIndex]

		if itemData then
			local clonePanel = self._cellClone:clone()

			clonePanel:setVisible(true)
			cell:addChild(clonePanel)
			clonePanel:setPosition((i - 1) * 227, 0)
			clonePanel:setTag(i)
			self:setInfo(clonePanel, itemData)
		end
	end
end

function ShopRechargeMediator:setInfo(panel, data)
	panel = panel:getChildByFullName("cell")

	local first = panel:getChildByFullName("first")
	local extra = panel:getChildByFullName("extra")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local moneyLayout = panel:getChildByFullName("money_layout")
	local moneyText = moneyLayout:getChildByFullName("money")
	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickItem(sender, eventType, data)
	end)
	iconLayout:removeAllChildren()
	first:setVisible(false)
	extra:setVisible(false)

	local symbol, price = data:getPaySymbolAndPrice()

	moneyText:setString(symbol .. "" .. price)

	local name = data:getName()

	nameText:setString(name)

	local under = ccui.ImageView:create(data:getIconAnim(), 1)

	under:addTo(iconLayout):center(iconLayout:getContentSize())

	if data:getIsFirstRecharge() then
		first:setVisible(true)
		extra:setVisible(true)

		local n = tostring(data:getFirstbuynumber())

		n = data:getGiftnumber2() > 0 and n .. "+" .. tostring(data:getGiftnumber2()) or n

		extra:getChildByFullName("text"):setString(Strings:get("BuyDiamondInMall_FirstDouble_Text", {
			num = n
		}))
	elseif data:getGiftnumber() > 0 or data:getGiftnumber2() > 0 then
		extra:setVisible(true)

		local n = data:getGiftnumber() > 0 and data:getGiftnumber2() > 0 and tostring(data:getGiftnumber()) .. "+" .. tostring(data:getGiftnumber2()) or data:getGiftnumber() > 0 and tostring(data:getGiftnumber()) or tostring(data:getGiftnumber2())

		extra:getChildByFullName("text"):setString(Strings:get("BuyDiamondInMall_FirstDouble_Text", {
			num = n
		}))
	end
end

function ShopRechargeMediator:refreshShopData()
	self:refreshData()

	local offsetY = self._scrollView:getInnerContainerPosition().y

	self:refreshView()
	self._scrollView:setInnerContainerPosition(cc.p(0, offsetY))
end

function ShopRechargeMediator:onClickItem(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		if CommonUtils.GetSwitch("fn_recharge_diamond_function") then
			self._rechargeSystem:requestRechargeDiamonds(data:getId())
		else
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Error_12410")
			}))
		end
	end
end

function ShopRechargeMediator:onRechargeSuccCallback(event)
	self:refreshShopData()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("VIP_RechargeSuccess")
	}))
	AudioEngine:getInstance():playEffect("Se_Alert_Recharge", false)

	if self._from == "monthSignIn" then
		local monthSignInSystem = self:getInjector():getInstance(MonthSignInSystem)

		monthSignInSystem:receiveVipReward()
	end
end

function ShopRechargeMediator:stopItemActions()
	local allCells = self._scrollView:getChildren()

	for i = 1, 5 do
		local child = allCells[i]

		if child then
			for j = 1, 3 do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					node:stopAllActions()
				end
			end
		end
	end
end

function ShopRechargeMediator:runListAnim()
	self._scrollView:setTouchEnabled(false)

	local allCells = self._scrollView:getChildren()

	for i = 1, 5 do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					node:setOpacity(0)
				end
			end
		end
	end

	local length = math.min(5, #allCells)
	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667

	for i = 1, 5 do
		local child = allCells[i]

		if child then
			for j = 1, kNums do
				local node = child:getChildByTag(j)

				if node and node:getChildByFullName("cell") then
					node = node:getChildByFullName("cell")

					local time = (i - 1) * delayTime + (j - 1) * delayTime1
					local delayAction = cc.DelayTime:create(time)
					local callfunc = cc.CallFunc:create(function()
						CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
					end)
					local callfunc1 = cc.CallFunc:create(function()
						node:setOpacity(255)

						if length == i then
							self._scrollView:setTouchEnabled(true)
						end
					end)
					local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

					self:getView():runAction(seq)
				end
			end
		end
	end
end
