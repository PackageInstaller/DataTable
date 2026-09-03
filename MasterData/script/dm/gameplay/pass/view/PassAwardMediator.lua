-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassAwardMediator.lua

PassAwardMediator = class("PassAwardMediator", DmPopupViewMediator, _M)

PassAwardMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassAwardMediator:has("_passListModel", {
	is = "r"
}):injectWith("PassListModel")
PassAwardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function PassAwardMediator:initialize()
	super.initialize(self)
end

function PassAwardMediator:dispose()
	self:getView():stopAllActions()
	super.dispose(self)
end

function PassAwardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_REFRESH, self, self.doPassPortRefresh)
end

function PassAwardMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function PassAwardMediator:stopEffect()
	return
end

function PassAwardMediator:setTabIndex(index)
	self._tabIndex = index
end

function PassAwardMediator:setupView(parent)
	self._parent = parent

	self:initData()
	self:initWidget()
	self:initTableView()
	self:setOffSetToCurrentLevel()
end

function PassAwardMediator:doPassPortRefresh(data)
	self:refreshData()
	self:refreshView()
end

function PassAwardMediator:initData()
	self._rewards = self._passListModel:getLevelRewardList()
	self._excellentRewardIndex = 1
end

function PassAwardMediator:initWidget()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._viewPanel = self._mainPanel:getChildByName("panel")
	self._rewardNode = self._mainPanel:getChildByName("rewardNode")
	self._levelNode = self._mainPanel:getChildByName("levelNode")
	self._cloneCell = self._mainPanel:getChildByName("cloneCell")

	self._cloneCell:setVisible(false)

	local iconNode2 = self._levelNode:getChildByName("node2")

	self._lockImage = iconNode2:getChildByName("lockImage")

	if self._passSystem:getHasRemarkableStatus() > 0 then
		self._lockImage:setVisible(false)
	else
		self._lockImage:setVisible(true)
	end
end

function PassAwardMediator:initTableView()
	local width, height = self._cloneCell:getContentSize().width, self._cloneCell:getContentSize().height

	local function scrollViewDidScroll(table)
		self._isReturn = false

		if table:isTouchMoved() then
			self:refreshExcellentRewardNode()
		end
	end

	local function numberOfCells(view)
		return #self._rewards
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

		self:createCell(cell, self._rewards[index], false)

		return cell
	end

	self._tableViewSize = self._viewPanel:getContentSize()

	local tableView = cc.TableView:create(self._tableViewSize)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setDelegate()
	tableView:addTo(self._viewPanel)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(20)
	tableView:setBounceable(false)

	self._tableView = tableView
end

function PassAwardMediator:createCell(cell, data, isSpecial)
	local bassPanel

	if isSpecial == false then
		cell:removeAllChildren()

		bassPanel = self._cloneCell:clone()

		bassPanel:setVisible(true)
		bassPanel:setTag(123)
		bassPanel:addTo(cell):posite(0, 0)
	else
		bassPanel = cell:getChildByFullName("cloneCell")
	end

	local panel = bassPanel:getChildByFullName("cell")

	self._tableCellSize = panel:getContentSize()

	local levelStr = panel:getChildByName("levelStr")
	local level = panel:getChildByName("level")

	level:setString(data:getLevel())
	levelStr:setPositionX(level:getPositionX() - level:getContentSize().width / 2 - 2)

	local touch1 = panel:getChildByName("touch1")

	touch1:setTouchEnabled(true)
	touch1:setSwallowTouches(false)
	touch1:setTag(0)

	if isSpecial == false and data:getStatus() == 1 then
		touch1:setTouchEnabled(true)
		touch1:addTouchEventListener(function(sender, eventType)
			self:onClickGetReward(sender, eventType, data)
		end)
	else
		touch1:setTouchEnabled(false)
	end

	local touch2 = panel:getChildByName("touch2")

	touch2:setTouchEnabled(true)
	touch2:setSwallowTouches(false)
	touch2:setTag(1)

	if isSpecial == false and data:getExcellentStatus() == 1 then
		touch2:setTouchEnabled(true)
		touch2:addTouchEventListener(function(sender, eventType)
			self:onClickGetReward(sender, eventType, data)
		end)
	else
		touch2:setTouchEnabled(false)
	end

	local rewardPanel1 = panel:getChildByName("rewardPanel1")

	rewardPanel1:removeAllChildren()

	local posX = rewardPanel1:getContentSize().width / 2 + 2
	local posY = rewardPanel1:getContentSize().height / 2 - 2
	local oneReward = #data:getRewardsItems1() == 1

	for i = 1, #data:getRewardsItems1() do
		local reward = data:getRewardsItems1()[i]
		local baseRewardNode = cc.Node:create()

		rewardPanel1:addChild(baseRewardNode)
		baseRewardNode:setPositionX(posX)

		if oneReward then
			baseRewardNode:setPositionY(posY)
		elseif i == 1 then
			baseRewardNode:setPositionY(posY + 32)
		else
			baseRewardNode:setPositionY(posY - 35)
		end

		reward.showEquipAmount = true

		local rewardIcon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parent), reward, {
			needDelay = true
		})
		baseRewardNode:addChild(rewardIcon)
		rewardIcon:setScaleNotCascade(0.5)

		if isSpecial == false then
			local cellWidth = rewardIcon:getContentSize().width

			self:checkMarkForReward(baseRewardNode, data:getStatus(), cellWidth)
		end
	end

	local rewardPanel2 = panel:getChildByName("rewardPanel2")

	rewardPanel2:removeAllChildren()

	local oneReward = #data:getRewardsItems2() == 1

	for i = 1, #data:getRewardsItems2() do
		local reward = data:getRewardsItems2()[i]
		local baseRewardNode = cc.Node:create()

		rewardPanel2:addChild(baseRewardNode)
		baseRewardNode:setPositionX(posX)

		if oneReward then
			baseRewardNode:setPositionY(posY)
		elseif i == 1 then
			baseRewardNode:setPositionY(posY + 32)
		else
			baseRewardNode:setPositionY(posY - 35)
		end

		reward.showEquipAmount = true

		local rewardIcon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parent), reward, {
			needDelay = true
		})
		baseRewardNode:addChild(rewardIcon)
		rewardIcon:setScaleNotCascade(0.5)

		if isSpecial == false then
			local cellWidth = rewardIcon:getContentSize().width

			self:checkMarkForReward(baseRewardNode, data:getExcellentStatus(), cellWidth)
		end
	end
end

function PassAwardMediator:checkMarkForReward(node, status, cellWidth)
	if status == 0 then
		local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 102))

		maskLayer:setContentSize(cc.size(cellWidth, cellWidth))
		maskLayer:setTouchEnabled(false)
		maskLayer:setScale(0.5)
		maskLayer:addTo(node):posite(-cellWidth / 2, -cellWidth / 2)
	end

	if status == 1 then
		local fangAnim = cc.MovieClip:create("fang_tongxingzheng")

		fangAnim:addTo(node):posite(-6, 1)
	end

	if status == 2 then
		local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 102))

		maskLayer:setContentSize(cc.size(cellWidth, cellWidth))
		maskLayer:setTouchEnabled(false)
		maskLayer:setScale(0.5)
		maskLayer:addTo(node):posite(-cellWidth / 2, -cellWidth / 2)

		local mark = ccui.ImageView:create("hd_14r_btn_go.png", ccui.TextureResType.plistType)

		mark:setAnchorPoint(cc.p(0.5, 0.5))
		mark:setScale(0.5)
		node:addChild(mark)
	end
end

function PassAwardMediator:refreshData(fromParent)
	self._rewards = self._passListModel:getLevelRewardList()
end

function PassAwardMediator:refreshView(hasAni)
	if self._passSystem:getHasRemarkableStatus() > 0 then
		self._lockImage:setVisible(false)
	else
		self._lockImage:setVisible(true)
	end

	if not self._tableView then
		self:initTableView()
	end

	self._tableView:reloadData()
	self._tableView:setTouchEnabled(true)
	self:setOffSetToCurrentLevel()
	self:refreshExcellentRewardNode()

	if hasAni then
		self:runStartAction()

		return
	end
end

function PassAwardMediator:setOffSetToCurrentLevel()
	local width = self._cloneCell:getContentSize().width
	local rewardLevel = self._passSystem:getMinCanGainReawrdLevel()

	if rewardLevel <= 0 then
		rewardLevel = self._passSystem:getCurrentLevel()
	end

	if rewardLevel > 3 then
		self._tableView:setContentOffset(cc.p(-width * (rewardLevel - 3), 0), false)
	end
end

function PassAwardMediator:onClickGetReward(sender, eventType, passReward)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		local type = sender:getTag()

		self._passSystem:requestGetReward(type, passReward:getLevel(), nil)
	end
end

function PassAwardMediator:refreshExcellentRewardNode()
	local panel = self._rewardNode:getChildByFullName("cloneCell")

	if not panel then
		panel = self._cloneCell:clone()

		panel:setVisible(true)
		panel:addTo(self._rewardNode):posite(-3, 0)
		self._rewardNode:setName("cloneCell")
	end

	local tableViewWidth = self._tableViewSize.width
	local tableCellWidth = self._tableCellSize.width
	local offsetX = self._tableView:getContentOffset().x
	local maxShowIndex = math.ceil((tableViewWidth - offsetX) / tableCellWidth)

	if maxShowIndex > 0 and maxShowIndex <= #self._rewards then
		local currentReward = self._rewards[maxShowIndex]
		local goodLevel = currentReward:getGoodLevel()

		if self._excellentRewardIndex ~= goodLevel and goodLevel > 0 and goodLevel <= #self._rewards then
			self:createCell(self._rewardNode, self._rewards[goodLevel], true)

			self._excellentRewardIndex = goodLevel
		end
	end
end

function PassAwardMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action1 = cc.CSLoader:createTimeline("asset/ui/PassReward.csb")

	self._mainPanel:runAction(action1)
	action1:clearFrameEventCallFunc()
	action1:gotoFrameAndPlay(0, 30, false)
	action1:setTimeSpeed(1)
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self:runListAnim()
	end, 0.16666666666666666)
end

function PassAwardMediator:runListAnim()
	local showNum = 6

	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()
	local length = math.min(showNum, #allCells)
	local delayTime = 0.06666666666666667

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)

			child:stopAllActions()
			child:setOpacity(0)

			local time = (i - 1) * delayTime
			local delayAction = cc.DelayTime:create(time)
			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(child, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
			end)
			local callfunc1 = cc.CallFunc:create(function()
				child:setOpacity(255)

				if length == i then
					self._tableView:setTouchEnabled(true)
				end
			end)
			local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

			child:runAction(seq)
		end
	end
end
