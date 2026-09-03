-- chunkname: @/tmp/or_script/lua_compile/dm/assets/uicomponents/LuaTableView.lua

local actiopnTag = 15353

LuaTableView = class("LuaTableView", _G.DisposableObject)

LuaTableView:has("_direction", {
	is = "rw"
})
LuaTableView:has("_verticalFillOrder", {
	is = "rw"
})
LuaTableView:has("_cellNumFunc", {
	is = "rw"
})
LuaTableView:has("_cellSizeFunc", {
	is = "rw"
})
LuaTableView:has("_cellAtIndexFunc", {
	is = "rw"
})
LuaTableView:has("_refreshCellValid", {
	is = "rw"
})
LuaTableView:has("_view", {
	is = "r"
})
LuaTableView:has("_seqUpdateTime", {
	is = "rw"
})
LuaTableView:has("_viewSeqStyle", {
	is = "rw"
})

function LuaTableView:initialize(info, delegates, style)
	super.initialize(self)

	info = info or {}
	delegates = delegates or {}
	style = style or {}
	self._size = info.size or cc.size(100, 100)
	self._seqUpdateTime = 0.2
	self._direction = style.direction or cc.SCROLLVIEW_DIRECTION_VERTICAL
	self._verticalFillOrder = style.verticalFillOrder or cc.TABLEVIEW_FILL_TOPDOWN
	self._viewShowStyle = style.viewStyle or TableViewShowStyle.kFadeIn
	self._viewSeqStyle = style.viewSeqStyle or TableViewSeqStyle.kDownUp
	self._cellNumFunc = delegates.cellNumFunc
	self._cellSizeFunc = delegates.cellSizeFunc
	self._cellAtIndexFunc = delegates.cellAtIndexFunc
	self._scroll = delegates.scroll
	self._cellTouch = delegates.cellTouch
	self._didScroll = delegates.didScroll
	self._isInit = false
	self._canCheckInnerSizeOverFloor = false
	self._refreshCellValid = false
	self._actionNode = cc.Node:create()
	self._view = cc.TableView:create(self._size)

	self._actionNode:addTo(self._view)
	self:_initTableView()
end

function LuaTableView:setCanCheckInnerSizeOverFloor(canCheck)
	self._canCheckInnerSizeOverFloor = canCheck
end

function LuaTableView:_initTableView()
	local function numberOfCells(view)
		if self._cellNumFunc then
			return self._cellNumFunc(view)
		end
	end

	local function cellSize(table, idx)
		if self._cellSizeFunc then
			return self._cellSizeFunc(table, idx)
		end
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:setColorTransform(ColorTransform(1, 1, 1, 1))

		cell.idx = idx

		if cell and self._refreshCellValid and self._cellAtIndexFunc then
			self._cellAtIndexFunc(table, cell, idx)
		end

		return cell
	end

	local function scroll(table)
		if self._scroll then
			return self._scroll(table)
		end
	end

	local function didScroll(table)
		if self._didScroll then
			return self._didScroll(table)
		end
	end

	self._view:setDirection(self._direction)
	self._view:setVerticalFillOrder(self._verticalFillOrder)
	self._view:setDelegate()

	if self._cellNumFunc then
		self._view:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	end

	if self._cellSizeFunc then
		self._view:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	end

	if self._cellAtIndexFunc then
		self._view:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	end

	if self._scroll then
		self._view:registerScriptHandler(scroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	end

	if self._didScroll then
		self._view:registerScriptHandler(didScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	end

	if self._cellTouch then
		self._view:registerScriptHandler(self._cellTouch, cc.TABLECELL_TOUCHED)
	end

	self._view:setMaxBounceOffset(self._view:getViewSize().height / 2)
	self._view:setDeaccelRate(0.94)
end

function LuaTableView:reloadData(seqFinishDelegate)
	self._refreshCellValid = false

	self._view:reloadData()

	self._refreshCellValid = true

	if seqFinishDelegate then
		self:refreshSeqShowCells(seqFinishDelegate)
	else
		self:refreshShowCells()
	end
end

function LuaTableView:setContentSizeAndUpdate(offset, animated)
	self._refreshCellValid = true

	self:setContentOffset(offset, animated)
end

function LuaTableView:reloadLayoutData()
	self._refreshCellValid = false

	self._view:reloadData()

	self._refreshCellValid = true
end

function LuaTableView:stopScroll()
	self._view:stopScroll()
end

function LuaTableView:setTouchEnabled(enabled)
	self._view:setTouchEnabled(enabled)
end

function LuaTableView:setBounceable(enabled)
	self._view:setBounceable(enabled)
end

function LuaTableView:setDeaccelRate(rate)
	self._view:setDeaccelRate(rate)
end

function LuaTableView:updateLayout()
	self._view:updateLayout()
end

function LuaTableView:cellAtIndex(index)
	return self._view:cellAtIndex(index)
end

function LuaTableView:updateCellAtIndex(index)
	return self._view:updateCellAtIndex(index)
end

function LuaTableView:isInnerSizeOverFlowWinSize()
	local innerSize = self:getContainer():getContentSize()
	local viewSize = self:getViewSize()

	if self._verticalFillOrder == cc.TABLEVIEW_FILL_TOPDOWN then
		return innerSize.height > viewSize.height
	else
		return innerSize.width > viewSize.width
	end
end

function LuaTableView:getContainer()
	return self._view:getContainer()
end

function LuaTableView:setViewSize(size)
	self._view:setViewSize(size)
end

function LuaTableView:getViewSize()
	return self._view:getViewSize()
end

function LuaTableView:getContentSize()
	return self._view:getContentSize()
end

function LuaTableView:refreshShowCells()
	local children = self._view:getContainer():getChildren()

	for index = 1, #children do
		local cell = children[index]

		if cell.idx then
			cell:setColorTransform(ColorTransform(1, 1, 1, 1))
			self._cellAtIndexFunc(self._view, cell, cell.idx)
		end
	end
end

function LuaTableView:refreshSeqShowCells(seqFinishDelegate)
	if self._viewSeqStyle == TableViewSeqStyle.kNormal then
		self:refreshSeqNormalShowCells(seqFinishDelegate)
	else
		self:refreshSeqDownUpShowCells(seqFinishDelegate)
	end
end

function LuaTableView:getChildren()
	return self:getContainer():getChildren()
end

function LuaTableView:getContainer()
	return self._view:getContainer()
end

function LuaTableView:removeCellAtIndex(idx)
	return self._view:removeCellAtIndex(idx)
end

function LuaTableView:insertCellAtIndex(idx)
	return self._view:insertCellAtIndex(idx)
end

function LuaTableView:updateCellAtIndex(idx)
	return self._view:updateCellAtIndex(idx)
end

function LuaTableView:setVisible(visible)
	self._view:setVisible(visible)
end

function LuaTableView:setIsFirstEnter(isFirstEnter)
	self._isFirstEnter = isFirstEnter
end

function LuaTableView:getIsFirstEnter()
	return self._isFirstEnter
end

function LuaTableView:reloadDataWithAnim(finishCallback)
	if not self._isFirstEnter then
		self:reloadData(function()
			if finishCallback then
				finishCallback()
			end
		end)

		self._isFirstEnter = true
	else
		self:reloadData()
		self:runShowAction()
	end
end

local showTransition = {
	[TableViewShowStyle.kNormal] = 1,
	[TableViewShowStyle.kFadeIn] = TableViewFadeInTransition,
	[TableViewShowStyle.kOffWidthCell] = TableViewOffWidthTransition,
	[TableViewShowStyle.kOffHeightCell] = TableViewOffHeightTransition,
	[TableViewShowStyle.kReboundXCell] = TableViewReboundXTransition,
	[TableViewShowStyle.kReboundLeftToRightCell] = TableViewReboundLeftToRightTransition
}

function LuaTableView:runShowAction(style, finishCallback)
	style = style or self._viewShowStyle

	self._view:setVisible(false)
	self._actionNode:runAction(DelayAction:create(function()
		self._view:setVisible(true)

		if showTransition[style] then
			local transition = showTransition[style]:new()

			transition:runTransitionAnimation(self._view, finishCallback)
		end
	end, 0))
end

function LuaTableView:getContentOffset()
	return self._view:getContentOffset()
end

function LuaTableView:setContentOffset(offset, animated)
	self._view:setContentOffset(offset, animated)
end

function LuaTableView:setLayoutOffset(offset)
	self._refreshCellValid = false

	self:setContentOffset(offset)

	self._refreshCellValid = true
end

function LuaTableView:reloadDataWithAnimAndOffset(offset)
	self:reloadLayoutData()

	if offset then
		self:setLayoutOffset(offset)
	end

	self._isFirstEnter = false

	if not self._isFirstEnter then
		self:refreshSeqShowCells()

		self._isFirstEnter = true
	else
		self:refreshShowCells()
	end
end

function LuaTableView:reloadDataAndOffset(offset)
	self:reloadLayoutData()

	if offset then
		self:setLayoutOffset(offset)
	end

	self:refreshShowCells()
end

function LuaTableView:setContentOffsetInDuration(offset, dt)
	self._view:setContentOffsetInDuration(offset, dt)
end

function LuaTableView:scrollToBottom()
	self._refreshCellValid = false

	self:setContentOffset(cc.p(0, 0))

	self._refreshCellValid = true

	self:refreshShowCells()
end

function LuaTableView:scrollToTop()
	self._refreshCellValid = false

	local viewSize = self:getViewSize()
	local containerSize = self._view:getContainer():getContentSize()

	self:setContentOffset(cc.p(0, -containerSize.height + viewSize.height))

	self._refreshCellValid = true

	self:refreshShowCells()
end

function LuaTableView:scrollToIndex(index, allCount, height)
	if not self:isInnerSizeOverFlowWinSize() then
		return
	end

	self._refreshCellValid = false

	local viewSize = self:getViewSize()
	local containerSize = self._view:getContainer():getContentSize()

	if allCount < index then
		return
	end

	local initOff = -containerSize.height + viewSize.height
	local offset = -containerSize.height + (index - 1) * height + viewSize.height

	offset = offset < initOff and initOff or offset

	self:setContentOffset(cc.p(0, offset))

	self._refreshCellValid = true

	self:refreshShowCells()
end

function LuaTableView:runRemoveAnim(removeIndex, offsetY, animEndFunc)
	self._view:setTouchEnabled(false)

	local delay = 0.2
	local children = self._view:getContainer():getChildren()
	local oldPosCahce = {}

	for index = 1, #children do
		local cell = children[index]

		cell:setVisible(true)

		offsetY = offsetY or cell:getContentSize().height
		oldPosCahce[index] = cc.p(cell:getPosition())

		local function actionEndFunc()
			cell:setVisible(true)
		end

		if cell.idx and removeIndex == cell.idx then
			cell:setVisible(false)
		else
			local moveAction = cc.EaseSineIn:create(cc.MoveBy:create(delay, cc.p(0, offsetY)))

			cell:runAction(moveAction)

			function actionEndFunc()
				cell:offset(0, -offsetY)
				cell:setVisible(true)

				if animEndFunc and index == #children then
					self._view:setTouchEnabled(true)
					animEndFunc()
				end
			end
		end

		cell:runAction(cc.Sequence:create(cc.DelayTime:create(delay), cc.CallFunc:create(actionEndFunc)))
	end
end

function LuaTableView:refreshSeqNormalShowCells(seqFinishDelegate)
	local children = self._view:getContainer():getChildren()
	local cache = {}

	for index = 1, #children do
		local cell = children[index]

		cell:setColorTransform(ColorTransform(1, 1, 1, 0))

		if cell.idx then
			cache[#cache + 1] = cell
		end
	end

	for i = 1, #cache do
		local cell = cache[i]
		local delayTime = self._seqUpdateTime - 0.1
		local action = DelayAction:create(function()
			self._cellAtIndexFunc(self._view, cell, cell.idx, delayTime * 0.9)

			if i == #cache and seqFinishDelegate and type(seqFinishDelegate) == "function" then
				self._view:getContainer():runAction(DelayAction:create(function()
					seqFinishDelegate()
				end, delayTime + 0.2))
			end

			cell:runAction(CascadeFadeTo:create(0.15, 1))
		end, (i - 1) * delayTime)

		action:setTag(actiopnTag)
		self._view:getContainer():runAction(action)
	end
end

function LuaTableView:refreshSeqDownUpShowCells(seqFinishDelegate)
	local children = self._view:getContainer():getChildren()
	local cache = {}

	for index = 2, #children do
		local cell = children[index]

		cell:setColorTransform(ColorTransform(1, 1, 1, 0))
		cell:setPositionX(0)
		cell:stopAllActions()

		if cell.idx then
			cache[#cache + 1] = cell
		end
	end

	LuaTableView:runViewEnterAnim(self._view, function(idx, time)
		local cell = cache[idx]

		self._cellAtIndexFunc(self._view, cell, cell.idx, time * 0.9)
	end, seqFinishDelegate)
end

function LuaTableView.class:runViewEnterAnim(listView, refreshSingleCellFunc, seqFinishDelegate)
	local children = listView:getContainer():getChildren()
	local cache = {}

	for index = 2, #children do
		local cell = children[index]

		cell:setColorTransform(ColorTransform(1, 1, 1, 0))
		cell:stopAllActions()

		cache[#cache + 1] = cell
	end

	local actionTime = 0.2

	for i = 1, #cache do
		local cell = cache[i]
		local offset = 20
		local action = DelayAction:create(function()
			if refreshSingleCellFunc then
				refreshSingleCellFunc(i, actionTime)
			end

			if i == #cache and seqFinishDelegate and type(seqFinishDelegate) == "function" then
				listView:getContainer():runAction(DelayAction:create(function()
					seqFinishDelegate()
				end, actionTime + 0.2))
			end

			cell:runAction(CascadeFadeTo:create(0.2, 1))
			cell:offset(0, -offset)

			local cellTime = actionTime - 0.1

			cell:runAction(cc.EaseSineIn:create(cc.MoveBy:create(cellTime, cc.p(0, offset))))
		end, (i - 1) * (actionTime - 0.16))

		cell:runAction(action)
	end
end
