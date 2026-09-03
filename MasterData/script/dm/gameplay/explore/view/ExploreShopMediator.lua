-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreShopMediator.lua

ExploreShopMediator = class("ExploreShopMediator", DmPopupViewMediator, _M)

ExploreShopMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreShopMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ExploreShopMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")

local kBtnHandlers = {}
local ItemNums = 4

function ExploreShopMediator:initialize()
	super.initialize(self)
end

function ExploreShopMediator:dispose()
	super.dispose(self)
end

function ExploreShopMediator:onRemove()
	super.onRemove(self)
end

function ExploreShopMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_END_SUCC, self, self.refreshView)
end

function ExploreShopMediator:enterWithData(data)
	self._data = data
	self._shopGroup = self._shopSystem:getShopGroupById(self._data.shopId)

	self:initData()
	self:initView()
	self:initItemView()
	self:refreshCost()
end

function ExploreShopMediator:refreshView()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("SHOP_BUY_SUCCESS")
	}))
	self:refreshCost()

	self._itemList = self._shopGroup:getGoodsList()

	self._itemView:reloadData()
end

function ExploreShopMediator:initData()
	self._itemList = self._shopGroup:getGoodsList()
end

function ExploreShopMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._viewLayer = self._main:getChildByFullName("tableView")
	self._cloneNode = self._main:getChildByFullName("cloneNode")

	self._cloneNode:setVisible(false)

	self._tipImg = self._main:getChildByFullName("tipImg")
	self._currency = self._main:getChildByFullName("currency")

	self._currency:setVisible(false)

	local bgNode = self._main:getChildByFullName("bgNode")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("EXPLORE_UI51"),
		bgSize = {
			width = 746,
			height = 474
		}
	})
	self:bindBackBtnFlash(self._main, cc.p(868, 471))

	self._itemWidth = self._cloneNode:getContentSize().width
end

function ExploreShopMediator:initItemView()
	local function cellSizeForTable(table, idx)
		return self._itemWidth * ItemNums, self._cloneNode:getContentSize().height
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._itemList / ItemNums)
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createTeamCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._viewLayer:getContentSize())

	self._itemView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._viewLayer:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function ExploreShopMediator:createTeamCell(cell, index)
	cell:removeAllChildren()

	local layer = cc.Layer:create()

	layer:setContentSize(cell:getContentSize())
	layer:addTo(cell)

	for i = 1, ItemNums do
		local itemData = self._itemList[ItemNums * (index - 1) + i]
		local panel = self._cloneNode:clone()

		panel:setVisible(true)
		panel:addTo(layer)
		panel:setPosition(cc.p(self._itemWidth * (i - 1), 0))

		local iconPanel = panel:getChildByName("icon")

		iconPanel:setSwallowTouches(false)
		iconPanel:addClickEventListener(function()
			self:onClickItem(itemData)
		end)

		local info = {
			id = itemData:getItemId(),
			amount = itemData:getAmount()
		}
		local icon = IconFactory:createIcon(info)

		iconPanel:addChild(icon)
		icon:setAnchorPoint(cc.p(0.5, 0.5))
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2, iconPanel:getContentSize().height / 2))

		local costType = panel:getChildByName("costType")
		local costIcon = IconFactory:createPic({
			id = itemData:getCostType()
		})

		costIcon:addTo(costType):center(costType:getContentSize())

		local costNum = panel:getChildByName("costNum")

		costNum:setString(itemData:getPrice())
		costNum:setTextColor(GameStyle:getColor(11))

		if not self._bagSystem:checkCostEnough(itemData:getCostType(), itemData:getPrice()) then
			costNum:setTextColor(GameStyle:getColor(12))
		end

		local times1 = itemData:getStock()
		local soldOutImg = panel:getChildByName("soldout_img")
		local maskImg = panel:getChildByName("maskimg")

		soldOutImg:setVisible(false)
		maskImg:setVisible(false)

		if times1 == 0 and itemData:getCDTime() == nil then
			soldOutImg:setVisible(true)
			maskImg:setVisible(true)
		end
	end
end

function ExploreShopMediator:refreshCost()
	if self._shopGroup:getReShow() then
		self._currency:setVisible(true)
		self._currency:getChildByName("money"):setString(self._bagSystem:getCountByCurrencyType(self._shopGroup:getReShow()))

		local iconPanel = self._currency:getChildByName("icon")

		iconPanel:removeAllChildren()

		local icon = IconFactory:createPic({
			id = self._shopGroup:getReShow()
		})

		icon:addTo(iconPanel):center(iconPanel:getContentSize())
	end
end

function ExploreShopMediator:onClickClose(sender, eventType)
	self:close()
end

function ExploreShopMediator:onClickItem(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local function callback()
		self._exploreSystem:endTrigger(function(response)
			return
		end, {
			objectId = self._data.objectId,
			params = {
				count = 1,
				positionId = data:getPositionId()
			}
		}, true)
	end

	local view = self:getInjector():getInstance("ShopBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemData = data,
		callback = callback
	}))
end
