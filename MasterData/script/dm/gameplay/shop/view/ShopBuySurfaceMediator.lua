-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopBuySurfaceMediator.lua

ShopBuySurfaceMediator = class("ShopBuySurfaceMediator", DmPopupViewMediator, _M)

ShopBuySurfaceMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopBuySurfaceMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {
	["main.buyBtn"] = {
		ignoreClickAudio = true,
		func = "onClickedBuyBtn"
	}
}

function ShopBuySurfaceMediator:initialize()
	super.initialize(self)
end

function ShopBuySurfaceMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ShopBuySurfaceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_BUY_SUCC, self, self.onRefreshShopSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_SURFACE_SUCC, self, self.onRefreshShopSuccess)
end

function ShopBuySurfaceMediator:enterWithData(data)
	self._itemData = data.item

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ShopBuySurfaceMediator:onRefreshShopSuccess(event)
	self:close()
end

function ShopBuySurfaceMediator:refreshData()
	return
end

function ShopBuySurfaceMediator:initMember()
	self._bagSystem = self._developSystem:getBagSystem()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._limitPanel = mainPanel:getChildByFullName("limitPanel")

	self._limitPanel:setVisible(false)

	self._surfaceName = mainPanel:getChildByFullName("surface_name")
	self._surfaceDesc = mainPanel:getChildByFullName("surface_desc")
	self._listView = mainPanel:getChildByFullName("surface_desc_listView")
	self._moneyText = mainPanel:getChildByFullName("Node_price.money_text")
	self._moneyIcon = mainPanel:getChildByFullName("Node_price.money_icon")
	self._iconPanel = mainPanel:getChildByFullName("icon_panel")
end

function ShopBuySurfaceMediator:refreshView()
	self._roleId = self._itemData:getTargetHeroId()

	self._iconPanel:removeAllChildren()

	local roleModel = self._itemData:getModel()
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe16",
		id = roleModel
	})

	img:addTo(self._iconPanel):center(self._iconPanel:getContentSize())
	self._surfaceName:setString(self._itemData:getName())
	self._listView:removeAllChildren()
	self._listView:setScrollBarEnabled(false)
	self._surfaceDesc:setVisible(false)

	local node = self._surfaceDesc:clone()

	node:setPosition(cc.p(0, 0))
	node:setVisible(true)
	node:setString(self._itemData:getDesc())
	node:getVirtualRenderer():setDimensions(self._listView:getContentSize().width, 0)
	node:getVirtualRenderer():setLineSpacing(5)
	self._listView:pushBackCustomItem(node)

	local price = self._itemData:getPrice()

	price = price == 0 and Strings:get("Recruit_Free") or price

	self._moneyText:setString(price)

	local goldIcon = IconFactory:createResourcePic({
		id = self._itemData:getCostType()
	})

	goldIcon:addTo(self._moneyIcon):setScale(1.3)
	self:setRecommendImg()
end

function ShopBuySurfaceMediator:setRecommendImg(panel, tagData)
	local isLimit = self._itemData:getIsLimit()

	if not isLimit or self._itemData:getStock() == 0 then
		if self._timer then
			self._timer:stop()

			self._timer = nil
		end

		self._limitPanel:setVisible(false)

		return
	end

	self._limitPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._itemData:getEndMills()

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			endMills = self._itemData:getEndMills()

			local remainTime = endMills - remoteTimestamp

			if remainTime <= 0 then
				self._shopSystem:requestGetSurfaceShop()
				self._timer:stop()

				self._timer = nil

				self._limitPanel:setVisible(false)

				return
			end

			local str = ""
			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

			self._limitPanel:getChildByFullName("time"):setString(Strings:get("shop_UI45", {
				time = str
			}))
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ShopBuySurfaceMediator:onClickedBuyBtn()
	local costType = self._itemData:getCostType()
	local costPrice = self._itemData:getPrice()

	if self._bagSystem:checkCostEnough(costType, costPrice, {
		type = "tip"
	}) then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local param = {
			shopId = self._itemData:getId()
		}

		self._shopSystem:requestBuySurfaceShop(param)
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end
end
