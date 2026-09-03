-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassRewardsPreviewMediator.lua

PassRewardsPreviewMediator = class("PassRewardsPreviewMediator", DmPopupViewMediator, _M)

PassRewardsPreviewMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")

local kBtnHandlers = {
	["main.buyButton"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onBuyClick"
	},
	["main.backButton"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onBackClick"
	}
}

function PassRewardsPreviewMediator:initialize()
	super.initialize(self)
end

function PassRewardsPreviewMediator:dispose()
	super.dispose(self)
end

function PassRewardsPreviewMediator:onRemove()
	super.onRemove(self)
end

function PassRewardsPreviewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView()
end

function PassRewardsPreviewMediator:enterWithData()
	self._nomalrewards = ConfigReader:getRecordById("Reward", self._passSystem:getFreeRoad()).Content
	self._remarkablerewards = ConfigReader:getRecordById("Reward", self._passSystem:getPayRoad()).Content
	self._haveExtraRewardMap1 = false

	local payConfig = self._passSystem:getPayConfig()

	self._leftPayInfo = payConfig[1]
	self._rightPayInfo = self._passSystem:getHasRemarkableStatus() > 0 and payConfig[3] or payConfig[2]

	if self._leftPayInfo.reward ~= nil then
		self._extraRewardMap1 = ConfigReader:getRecordById("Reward", self._leftPayInfo.reward).Content
		self._haveExtraRewardMap1 = true
	end

	if self._rightPayInfo.reward ~= nil then
		self._extraRewardMap2 = ConfigReader:getRecordById("Reward", self._rightPayInfo.reward).Content
	end

	self:initView()
end

function PassRewardsPreviewMediator:initView()
	local panel1 = self:getView():getChildByFullName("main.panel1")
	local panel2 = self:getView():getChildByFullName("main.panel2")
	local panel3 = self:getView():getChildByFullName("main.panel3")
	local panel4 = self:getView():getChildByFullName("main.panel4")
	local extraNode = self:getView():getChildByFullName("main.extraNode")
	local extraText = self:getView():getChildByFullName("main.extraText")

	self:createTableView(panel1, self._nomalrewards)
	self:createTableView(panel2, self._remarkablerewards)

	if self._haveExtraRewardMap1 == true then
		self:createTableView(panel3, self._extraRewardMap1)
	else
		extraNode:setVisible(false)
		extraText:setPosition(cc.p(extraText:getContentSize().width / 2 + 30, 115))
		panel4:setPosition(cc.p(30, 20))
		panel4:setContentSize(cc.size(740, 84))
	end

	self:createTableView(panel4, self._extraRewardMap2)
end

function PassRewardsPreviewMediator:createTableView(node, rewardMap)
	local function numberOfCells(view)
		return #rewardMap
	end

	local function cellSize(table, idx)
		return 76, 84
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		local index = idx + 1

		self:createCell(cell, rewardMap[index])

		return cell
	end

	local tableView = cc.TableView:create(node:getContentSize())

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setDelegate()
	tableView:addTo(node)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function PassRewardsPreviewMediator:createCell(cell, data)
	cell:removeAllChildren()

	data.showEquipAmount = true

	local rewardIcon = IconFactory:createRewardIcon(data, {
		isWidget = true
	})

	IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), data, {
		needDelay = true
	})
	cell:addChild(rewardIcon)
	rewardIcon:setPosition(cc.p(38, 42))
	rewardIcon:setScaleNotCascade(0.6)
end

function PassRewardsPreviewMediator:onBuyClick()
	self:close()
	self._passSystem:showBuyView()
end

function PassRewardsPreviewMediator:onBackClick()
	self:close()
end
