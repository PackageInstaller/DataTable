-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueVendingMachineView.lua

module("logic.extensions.roguelike.view.explore.RogueVendingMachineView", package.seeall)

local RogueVendingPropItem = class("RogueVendingPropItem")

function RogueVendingPropItem:ctor(compContainer)
	self._go = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go.gameObject)
end

function RogueVendingPropItem:Awake()
	self:onInit()
end

function RogueVendingPropItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function RogueVendingPropItem:onInit()
	local go = self._go

	self._txtCost = goutil.findChildTextComponent(go, "btnBuy/txtNum")
	self._txtContent = goutil.findChildTextComponent(go, "txtContent")
	self._costIcon1 = goutil.findChildImageComponent(go, "btnBuy/txtNum/icon")
	self._goSellOut = goutil.findChild(go, "btnBuy/sellOut")
	self._goNormal = goutil.findChild(go, "btnBuy/normal")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnBuy"))
	self._goItem = goutil.findChild(self._go, "cell/backpack_item")

	self._btnClick:AddClickListener(self._onClick, self)
end

function RogueVendingPropItem:_onClick()
	if self._callback then
		self._callback()
	end
end

function RogueVendingPropItem:updateData(data)
	self._callback = data.callback
	self._txtCost.text = data.price
	self._txtContent.text = data.co.name
	self._co = data.co

	local propCo = RoguelikeConfig.instance:getPropById(data.co.id)

	if propCo then
		-- block empty
	end

	goutil.setActive(self._goSellOut, data.isTaken)
	goutil.setActive(self._goNormal, not data.isTaken)
	goutil.setActive(self._goItem, true)
	self:setActive(true)
end

function RogueVendingPropItem:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

local M = class("RogueVendingMachineView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._propItems = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._traContent = self:getGo("vending_machine_view_600660171")
	self._btnProp = self:getBtn("vending_machine_view_90432489")
	self._txtCoin = self:getText("vending_machine_view_1150181449")
	self._goPropItemPrefab = goutil.findChild(self._traContent, "vending_props_item")

	self:initPropItems()
	self:initOwnPropTips()
	self:initThrowPropTips()
end

function M:initPropItems()
	self._goPropItems = {}
	self._propItems = {}

	for i = 1, 6 do
		local go = goutil.findChild(self._traContent, "item" .. i)

		self._goPropItems[i] = go

		local itemGo = goutil.cloneAndSetParent(self._goPropItemPrefab, go.transform)
		local item = Astral.LuaComponentContainer.Add(itemGo, RoguePropCardItem)

		self._propItems[i] = item
	end

	local hpItem = goutil.findChild(self._traContent, "lifeItem")

	table.insert(self._propItems, Astral.LuaComponentContainer.Add(hpItem, RogueVendingPropItem))

	local sanItem = goutil.findChild(self._traContent, "sanityItem")

	table.insert(self._propItems, Astral.LuaComponentContainer.Add(sanItem, RogueVendingPropItem))
end

function M:destroyUI()
	self._ownPropTips:OnDestroy()
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnProp:AddClickListener(self._onClickProp, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnProp:RemoveClickListener()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_ROOM_PRIZES, self._onShowRoomPrizes, self)
	GlobalDispatcher:addEventListener(EventType.ROGUE_SHOP_BUY_SUCCESS, self._onShopBuySuccess, self)
	GlobalDispatcher:addEventListener(EventType.ROGUE_ADD_PROP_SUCCESS, self._onAddPropSuccess, self)
	GlobalDispatcher:addEventListener(EventType.ROGUE_ROOM_PRICE_REFRESH, self._onPriceRefresh, self)
	GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
	GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_ROOM_PRIZES, self._onShowRoomPrizes, self)
	GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOP_BUY_SUCCESS, self._onShopBuySuccess, self)
	GlobalDispatcher:removeEventListener(EventType.ROGUE_ADD_PROP_SUCCESS, self._onAddPropSuccess, self)
	GlobalDispatcher:removeEventListener(EventType.ROGUE_ROOM_PRICE_REFRESH, self._onPriceRefresh, self)
	GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
	GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
end

function M:onEnter()
	self:_bindEvents()

	if RogueMgr.instance:getHackToolModel() then
		local msg = RoguelikeModel.instance:getCurHackToolRoomInfo()
		local prizes = msg.prize
		local goods = {}

		for k, v in ipairs(prizes) do
			table.insert(goods, v)
		end

		self:showAllGoods(goods)
	else
		local roomMo = self:getFirstParam()

		self._coordinate = roomMo:getCoordinateStr()

		RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
	end

	self:updateGoldNum()
	self:_onPropRefresh()
end

function M:_onShopBuySuccess()
	FloatWordMgr.instance:show(lang("tip_r_prop_buy_success"))
end

function M:_onAddPropSuccess()
	if RogueMgr.instance:getHackToolModel() then
		return
	end

	RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
end

function M:_onPriceRefresh(sender, msg)
	if msg.room == RoguelikeModel.instance:getCurRoomMo():getCoordinateStr() then
		local prizes = msg.prize
		local goods = {}

		for k, v in ipairs(prizes) do
			table.insert(goods, v)
		end

		self:showAllGoods(goods)
	end
end

function M:_onShowRoomPrizes(sender, msg)
	local curRoomPrize

	for k, v in pairs(msg.roomPrize) do
		if v.room == RoguelikeModel.instance:getCurRoomMo():getCoordinateStr() then
			curRoomPrize = v
		end
	end

	if curRoomPrize == nil then
		return
	end

	msg = curRoomPrize

	local prizes = msg.prize
	local goods = {}

	for k, v in ipairs(prizes) do
		table.insert(goods, v)
	end

	self:showAllGoods(goods)
end

function M:showAllGoods(goods)
	if goods and #goods < 8 then
		return
	end

	for k, v in pairs(self._propItems) do
		v:setActive(false)
	end

	for k, v in ipairs(goods or {}) do
		local data = {}

		data.co = RoguelikeConfig.instance:getPropById(v.id)
		data.price = v.price
		data.isTaken = v.taken and k <= #goods - 2

		function data.callback()
			local coinNum = RoguelikeModel.instance:getGold() or 0

			if data.isTaken then
				FloatWordMgr.instance:show(lang("tip_r_prop_sell_out"))

				return
			end

			if coinNum < data.price then
				FloatWordMgr.instance:show(lang("tip_r_not_enough_coin"))

				return
			end

			RoguelikeAgent.instance:sendMallBuyRequest(v.id, k >= #goods - 2)
		end

		local item = self._propItems[k]

		if not item then
			item = Astral.LuaComponentContainer.Add(self._goPropItems[k], RoguePropCardItem)
			self._propItems[k] = item
		end

		if not item then
			printError("道具显示错误", k, #self._goPropItems)
		end

		item:updateData(data)
	end
end

function M:onExit()
	self:_unbindEvents()
	self._ownPropTips:setActive(false)
end

function M:initOwnPropTips()
	local content = self:getGo("vending_machine_view_600660171")
	local tips = goutil.findChild(content, "propScroll")

	self._ownPropTips = Astral.LuaComponentContainer.Add(tips, RogueVendingMachineOwnPropTips)
	self._txtBtnPropCount = goutil.findChildComponent(self._btnProp.gameObject, "Text1", UIComponentType.Text)

	self._ownPropTips:setItemClickCallback(function(propNo)
		self._throwPropTips:updateData(propNo)
		self._throwPropTips:setActive(true)
	end)
end

function M:initThrowPropTips()
	local content = self:getGo("vending_machine_view_600660171")
	local tips = goutil.findChild(content, "props_throw_tips")

	self._throwPropTips = Astral.LuaComponentContainer.Add(tips, RogueThorwPropTips)
end

function M:_onPropRefresh()
	local allProp = RoguelikeModel.instance:getAllPropNOs()
	local maxCount = 6

	self._txtBtnPropCount.text = string.format("%d", #allProp)

	self._ownPropTips:updateData()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickProp()
	self._ownPropTips:setActive(true)
end

function M:_onRefreshGold()
	self:updateGoldNum()
end

function M:updateGoldNum()
	self._txtCoin.text = RoguelikeModel.instance:getGold()
end

return M
