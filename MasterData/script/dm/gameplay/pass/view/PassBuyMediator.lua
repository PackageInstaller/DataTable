-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassBuyMediator.lua

PassBuyMediator = class("PassBuyMediator", DmPopupViewMediator, _M)

PassBuyMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassBuyMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kNum = 4
local kBtnHandlers = {
	["node_1.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBuy"
	},
	["node_2.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBuy"
	}
}

function PassBuyMediator:initialize()
	super.initialize(self)
end

function PassBuyMediator:initData()
	local nomalRewardId = self._passSystem:getPayRoad()

	self._nomalRewardMap = ConfigReader:getRecordById("Reward", nomalRewardId).Content
	self._payConfig = self._passSystem:getPayConfig()
	self._leftPayInfo = self._payConfig[1]
	self._rightPayInfo = self._passSystem:getHasRemarkableStatus() == 1 and self._payConfig[3] or self._payConfig[2]

	if self._leftPayInfo.reward ~= nil then
		self._extraRewardMap1 = ConfigReader:getRecordById("Reward", self._leftPayInfo.reward).Content
	end

	if self._rightPayInfo.reward ~= nil then
		self._extraRewardMap2 = ConfigReader:getRecordById("Reward", self._rightPayInfo.reward).Content
	end
end

function PassBuyMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function PassBuyMediator:onRemove()
	super.onRemove(self)
end

function PassBuyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_REFRESH, self, self.doPassPortRefresh)

	self._main = self:getView()
end

function PassBuyMediator:enterWithData()
	self:initData()
	self:initView()
end

function PassBuyMediator:initView()
	self:createNode1(self._main:getChildByName("node_1"))
	self:createNode2(self._main:getChildByName("node_2"))
	self:doPassPortRefresh()

	local animNode = self._main:getChildByFullName("node_2.animNode")
	local fangAnim = cc.MovieClip:create("sao_tongxingzheng")

	fangAnim:addTo(animNode)
	fangAnim:setPosition(cc.p(167, 280))
end

function PassBuyMediator:createNode1(node)
	local descNode = node:getChildByName("descNode")
	local text_12 = descNode:getChildByName("Text_12")

	text_12:setString(Strings:get("Pass_UI53"))

	local button = node:getChildByName("button")

	button:setTag(1)
	self:createBtn(button, self._leftPayInfo)

	local hideExtra = false
	local extraNode = node:getChildByName("extraNode")
	local extraReward = extraNode:getChildByName("extraReward")

	if self._extraRewardMap1 == nil or #self._extraRewardMap1 <= 0 then
		extraNode:setVisible(false)
		text_12:setVisible(false)

		hideExtra = true
	else
		self:createExtraNode(self._extraRewardMap1, extraReward)
	end

	local rewardNode = node:getChildByName("rewardNode")

	rewardNode:removeAllChildren()
	self:createNomalRewardNode(rewardNode, hideExtra)
end

function PassBuyMediator:createNode2(node)
	local descNode = node:getChildByName("descNode")
	local button = node:getChildByName("button")

	button:setTag(2)
	self:createBtn(button, self._rightPayInfo)

	local hideExtra = false
	local extraNode = node:getChildByName("extraNode")
	local extraReward = extraNode:getChildByName("extraReward")

	if self._extraRewardMap2 == nil or #self._extraRewardMap2 <= 0 then
		extraNode:setVisible(false)

		hideExtra = true
	else
		self:createExtraNode(self._extraRewardMap2, extraReward)
	end

	local rewardNode = node:getChildByName("rewardNode")

	rewardNode:removeAllChildren()
	self:createNomalRewardNode(rewardNode, hideExtra)
end

function PassBuyMediator:createNomalRewardNode(rewardNode, hideExtra)
	local length = math.ceil(#self._nomalRewardMap / kNum)
	local lineLimit = hideExtra and 3 or 2

	if length <= lineLimit then
		for index = 1, length do
			for i = 1, kNum do
				local data = self._nomalRewardMap[kNum * (index - 1) + i]

				if data then
					data.showEquipAmount = true

					local rewardIcon = IconFactory:createRewardIcon(data, {
						isWidget = true
					})

					IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
						needDelay = true
					})
					rewardNode:addChild(rewardIcon)
					rewardIcon:setAnchorPoint(cc.p(0, 0))

					local posX = 5 + 72 * (i - 1)
					local posY = -60 - 77 * (index - 1)

					rewardIcon:setPosition(cc.p(posX, posY))
					rewardIcon:setScaleNotCascade(0.5)
				end
			end
		end
	else
		local size = hideExtra and cc.size(290, 220) or cc.size(290, 140)
		local s_posY = hideExtra and 220 or 140
		local rewardScrollView = ccui.ScrollView:create()

		rewardScrollView:setTouchEnabled(true)
		rewardScrollView:setBounceEnabled(true)
		rewardScrollView:setDirection(ccui.ScrollViewDir.vertical)
		rewardScrollView:setContentSize(size)
		rewardScrollView:setPosition(cc.p(0, -s_posY))
		rewardScrollView:setAnchorPoint(cc.p(0, 0))
		rewardScrollView:setScrollBarWidth(7)
		rewardScrollView:setScrollBarPositionFromCorner(cc.p(2, 2))
		rewardNode:addChild(rewardScrollView)

		local contentNode = cc.Node:create()

		rewardScrollView:addChild(contentNode)

		local allHeight = 65 + 77 * (length - 1)

		contentNode:setPosition(cc.p(0, allHeight))

		for index = 1, length do
			for i = 1, kNum do
				local data = self._nomalRewardMap[kNum * (index - 1) + i]

				if data then
					local rewardIcon = IconFactory:createRewardIcon(data, {
						isWidget = true
					})

					IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
						needDelay = true
					})
					contentNode:addChild(rewardIcon)
					rewardIcon:setAnchorPoint(cc.p(0, 0))

					local posX = 5 + 72 * (i - 1)
					local posY = -60 - 77 * (index - 1)

					rewardIcon:setPosition(cc.p(posX, posY))
					rewardIcon:setScaleNotCascade(0.5)
				end
			end
		end

		local size = rewardScrollView:getContentSize()

		size.height = allHeight
		size.width = 290

		rewardScrollView:setInnerContainerSize(size)
	end
end

function PassBuyMediator:createExtraNode(extraRewardMap, rewardNode)
	if #extraRewardMap <= 4 then
		local rewards = extraRewardMap
		local posY = rewardNode:getContentSize().height / 2 - 25

		for i = 1, #rewards do
			local data = rewards[i]

			if data then
				local rewardIcon = IconFactory:createRewardIcon(data, {
					isWidget = true
				})

				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
					needDelay = true
				})
				rewardNode:addChild(rewardIcon)
				rewardIcon:setAnchorPoint(cc.p(0, 0))
				rewardIcon:setPosition(cc.p(4 + 72 * (i - 1), posY))
				rewardIcon:setScaleNotCascade(0.5)
			end
		end

		rewardNode:setContentSize(cc.size(72 * #rewards, rewardNode:getContentSize().height))
	else
		local size = rewardNode:getContentSize()
		local rewardScrollView = ccui.ScrollView:create()

		rewardScrollView:setTouchEnabled(true)
		rewardScrollView:setBounceEnabled(true)
		rewardScrollView:setDirection(ccui.ScrollViewDir.horizontal)
		rewardScrollView:setContentSize(size)
		rewardScrollView:setPosition(cc.p(0, 0))
		rewardScrollView:setAnchorPoint(cc.p(0, 0))
		rewardScrollView:setScrollBarWidth(7)
		rewardScrollView:setScrollBarPositionFromCorner(cc.p(2, 2))
		rewardNode:addChild(rewardScrollView)

		local rewards = extraRewardMap
		local posY = rewardNode:getContentSize().height / 2 - 25
		local allWidth = 57 + 72 * (#rewards - 1)

		for i = 1, #rewards do
			local data = rewards[i]

			if data then
				local rewardIcon = IconFactory:createRewardIcon(data, {
					isWidget = true
				})

				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
					needDelay = true
				})
				rewardScrollView:addChild(rewardIcon)
				rewardIcon:setAnchorPoint(cc.p(0, 0))
				rewardIcon:setPosition(cc.p(1 + 72 * (i - 1), posY))
				rewardIcon:setScaleNotCascade(0.5)
			end
		end

		local size = rewardScrollView:getContentSize()

		size.height = rewardNode:getContentSize().height
		size.width = allWidth

		rewardScrollView:setInnerContainerSize(size)
	end
end

function PassBuyMediator:createBtn(btn, data)
	local payId = data.PayId
	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
	local symbol, price = payOffSystem:getPaySymbolAndPrice(payId)
	local priceNum = price
	local priceTypeStr = symbol
	local discountNode = btn:getChildByName("discountNode")
	local priceType = btn:getChildByName("priceType")
	local price = btn:getChildByName("price")

	price:setString(priceNum)
	priceType:setString(priceTypeStr)
	discountNode:setVisible(false)
end

function PassBuyMediator:onClickBuy(sender, eventType)
	local type = sender:getTag()

	if self._passSystem:getHasRemarkableStatus() == 2 or type == 1 and self._passSystem:getHasRemarkableStatus() == 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Pass_UI56")
		}))

		return
	end

	self._passSystem:requestBuyGiftBag((type == 2 or nil) and (self._passSystem:getHasRemarkableStatus() > 0 and 2 or 1), nil)
end

function PassBuyMediator:doPassPortRefresh()
	if self._passSystem:getHasRemarkableStatus() >= 1 then
		self._rightPayInfo = self._payConfig[3]

		local button = self._main:getChildByFullName("node_1.button")

		button:setVisible(false)
	else
		self._rightPayInfo = self._payConfig[2]
	end

	local button = self._main:getChildByFullName("node_2.button")

	self:createBtn(button, self._rightPayInfo)

	if self._passSystem:getHasRemarkableStatus() == 2 then
		local button = self._main:getChildByFullName("node_2.button")

		button:setVisible(false)
	end
end
