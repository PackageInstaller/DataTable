-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassBuyLevelMediator.lua

PassBuyLevelMediator = class("PassBuyLevelMediator", DmPopupViewMediator, _M)

PassBuyLevelMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassBuyLevelMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kNum = 5
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.btnNodes.minBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickMin"
	},
	["main.btnNodes.maxBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickMax"
	},
	["main.btnNodes.leftBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.btnNodes.rightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.btnNodes.buyBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBuy"
	}
}

function PassBuyLevelMediator:initialize()
	super.initialize(self)
end

function PassBuyLevelMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function PassBuyLevelMediator:onRemove()
	super.onRemove(self)
end

function PassBuyLevelMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshWithData)
end

function PassBuyLevelMediator:enterWithData()
	self:initData()
	self:initWidget()
	self:initTableView()
	self:initLevelNode()
end

function PassBuyLevelMediator:initData()
	self._currentlevel = self._passSystem:getCurrentLevel()
	self._buylevelCount = 1
	self._maxBuyLevel = self._passSystem:getMaxRewardLevel() - self._currentlevel
	self._minBuyLevel = 1

	if self._currentlevel < self._passSystem:getMaxRewardLevel() then
		self._tolevel = self._currentlevel + self._buylevelCount or self._passSystem:getMaxRewardLevel()
	end

	self._rewards = self._passSystem:getRewardsFromXLevelToYLevel(self._currentlevel, self._tolevel)
end

function PassBuyLevelMediator:initWidget()
	self._viewPanel = self:getView():getChildByFullName("main.panel")
	self._btnNodes = self:getView():getChildByFullName("main.btnNodes")
	self._topDesNode = self:getView():getChildByFullName("main.topDesNode")

	self:getView():getChildByFullName("main.text2"):setVisible(false)
end

function PassBuyLevelMediator:refreshWithData()
	self:updateData()
	self:updateView()
end

function PassBuyLevelMediator:updateData()
	if self._currentlevel < self._passSystem:getMaxRewardLevel() then
		self._tolevel = self._currentlevel + self._buylevelCount or self._passSystem:getMaxRewardLevel()
	end

	self._rewards = self._passSystem:getRewardsFromXLevelToYLevel(self._currentlevel, self._tolevel)
end

function PassBuyLevelMediator:updateView()
	self._tableView:reloadData()
	self:initLevelNode()
end

function PassBuyLevelMediator:initTableView()
	local viewSize = self._viewPanel:getContentSize()

	self._cellHeight = 93

	local width, height = viewSize.width, self._cellHeight

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function numberOfCells(view)
		return math.ceil(#self._rewards / kNum)
	end

	local function cellSize(table, idx)
		return width, height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		local index = idx + 1

		self:createCell(cell, index)

		return cell
	end

	local tableView = cc.TableView:create(cc.size(viewSize.width, viewSize.height - 20))

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._viewPanel):posite(0, 10)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()

	self._tableView = tableView
end

function PassBuyLevelMediator:createCell(cell, index)
	cell:removeAllChildren()

	for i = 1, kNum do
		local data = self._rewards[kNum * (index - 1) + i]

		if data then
			local rewardIcon = IconFactory:createRewardIcon(data, {
				isWidget = true
			})

			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
				needDelay = true
			})
			cell:addChild(rewardIcon)
			rewardIcon:setScaleNotCascade(0.65)

			local posX = 70 + 90 * (i - 1)

			rewardIcon:setPosition(cc.p(posX, self._cellHeight / 2))
		end
	end
end

function PassBuyLevelMediator:initLevelNode()
	local curLevel = self._btnNodes:getChildByFullName("curLevel")

	curLevel:setString(self._buylevelCount)

	self._price = self._passSystem:getAllPriceByBuyCount(self._buylevelCount)

	local buyBtn = self._btnNodes:getChildByFullName("buyBtn")
	local cost = buyBtn:getChildByFullName("cost")

	cost:setString(self._price)

	if not cost:getChildByFullName("CostType") then
		local icon = IconFactory:createResourcePic({
			id = CurrencyIdKind.kDiamond
		})

		icon:addTo(cost):posite(-20, 16)
	end

	self._topDesNode:removeAllChildren()

	local str = Strings:get("Pass_UI24", {
		curLevel = self._currentlevel,
		targetLevel = self._tolevel,
		fontName = TTF_FONT_FZYH_R
	})
	local label = ccui.RichText:createWithXML(str, {})

	label:addTo(self._topDesNode)

	self._btnNodes = self:getView():getChildByFullName("main.btnNodes")

	local desc = self._btnNodes:getChildByFullName("desc")

	desc:removeAllChildren()

	local str = Strings:get("Pass_UI40", {
		num = self._buylevelCount,
		fontName = TTF_FONT_FZYH_R
	})
	local label = ccui.RichText:createWithXML(str, {})

	label:addTo(desc)
end

function PassBuyLevelMediator:onClickLeft()
	if self._buylevelCount > self._minBuyLevel then
		self._buylevelCount = self._buylevelCount - 1

		self:refreshWithData()
	end
end

function PassBuyLevelMediator:onClickRight()
	if self._buylevelCount < self._maxBuyLevel then
		self._buylevelCount = self._buylevelCount + 1

		self:refreshWithData()
	end
end

function PassBuyLevelMediator:onClickMin()
	if self._buylevelCount ~= self._minBuyLevel then
		self._buylevelCount = self._minBuyLevel

		self:refreshWithData()
	end
end

function PassBuyLevelMediator:onClickMax()
	if self._buylevelCount ~= self._maxBuyLevel then
		self._buylevelCount = self._maxBuyLevel

		self:refreshWithData()
	end
end

function PassBuyLevelMediator:onClickBuy()
	if CurrencySystem:checkEnoughCurrency(self, CurrencyIdKind.kDiamond, self._price, {
		type = "tip"
	}) then
		self._passSystem:requestBuyLevel(self._buylevelCount, function(data)
			if checkDependInstance(self) then
				self:close()
			end
		end)
	end
end

function PassBuyLevelMediator:onClickClose()
	self:close()
end
