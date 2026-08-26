-- chunkname: @modules/logic/common/view/ListScrollAnimRemoveItem.lua

module("modules.logic.common.view.ListScrollAnimRemoveItem", package.seeall)

local ListScrollAnimRemoveItem = class("ListScrollAnimRemoveItem", LuaCompBase)

function ListScrollAnimRemoveItem:init(go)
	self.goScroll = go
	self.rectScroll = self.goScroll.transform
	self.rectViewPort = gohelper.findChild(self.goScroll, "Viewport").transform
end

function ListScrollAnimRemoveItem.Get(luaListScrollView)
	local csListScroll = luaListScrollView._csListScroll

	if gohelper.isNil(csListScroll) then
		logError("ListScrollView 还没初始化")

		return
	end

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(csListScroll.gameObject, ListScrollAnimRemoveItem)

	comp:setListModel(luaListScrollView)

	return comp
end

function ListScrollAnimRemoveItem:setListModel(luaListScrollView)
	self._luaListScrollView = luaListScrollView
	self._listModel = luaListScrollView._model
	self._csListScroll = luaListScrollView._csListScroll
	self._listParam = luaListScrollView._param
	self._scrollDir = self._listParam.scrollDir
	self._cellSizeAndSpace = 0

	if self._scrollDir == ScrollEnum.ScrollDirH then
		self._cellSizeAndSpace = self._listParam.cellWidth + self._listParam.cellSpaceH
	elseif self._scrollDir == ScrollEnum.ScrollDirV then
		self._cellSizeAndSpace = self._listParam.cellHeight + self._listParam.cellSpaceV
	end

	self:changeGameObjectNode()
end

function ListScrollAnimRemoveItem:changeGameObjectNode(changeNum)
	changeNum = changeNum or 1

	if self._scrollDir == ScrollEnum.ScrollDirH then
		local width = recthelper.getWidth(self.rectScroll)
		local addWidth = self._listParam.cellWidth + self._listParam.cellSpaceH

		recthelper.setWidth(self.rectScroll, width + addWidth)

		self.rectViewPort.offsetMax = Vector2(addWidth * changeNum, 0)
	elseif self._scrollDir == ScrollEnum.ScrollDirV then
		local height = recthelper.getHeight(self.rectScroll)
		local addHeight = self._listParam.cellHeight + self._listParam.cellSpaceV

		recthelper.setHeight(self.rectScroll, height + addHeight)

		self.rectViewPort.offsetMin = Vector2(0, addHeight * changeNum)
	end
end

function ListScrollAnimRemoveItem:_getListModel()
	return self._listModel
end

function ListScrollAnimRemoveItem:setMoveInterval(interval)
	self.moveInterval = interval
end

function ListScrollAnimRemoveItem:getMoveInterval()
	return self.moveInterval or 0.05
end

function ListScrollAnimRemoveItem:setMoveAnimationTime(time)
	self.moveAnimationTime = time
end

function ListScrollAnimRemoveItem:getMoveAnimationTime()
	return self.moveAnimationTime or 0.15
end

function ListScrollAnimRemoveItem:removeById(id, callback, callbackObj)
	local mo = self._listModel:getById(id)
	local index = self._listModel:getIndex(mo)

	self:removeByIndexs({
		index
	}, callback, callbackObj)
end

function ListScrollAnimRemoveItem:removeByIds(ids, callback, callbackObj)
	local tb = {}

	for _, id in ipairs(ids) do
		local mo = self._listModel:getById(id)
		local index = self._listModel:getIndex(mo)

		table.insert(tb, index)
	end

	table.sort(tb, function(a, b)
		return a < b
	end)
	self:removeByIndexs(tb, callback, callbackObj)
end

function ListScrollAnimRemoveItem:removeByIndex(index, callback, callbackObj)
	self:removeByIndexs({
		index
	}, callback, callbackObj)
end

function ListScrollAnimRemoveItem:removeByIndexs(indexs, callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	local oldMoList = self._listModel:getList()

	self.newMoList = tabletool.copy(oldMoList)

	local new2old = {}

	for i, _ in ipairs(oldMoList) do
		new2old[i] = i
	end

	for i = #indexs, 1, -1 do
		local index = indexs[i]

		for j = index, #new2old do
			new2old[j] = new2old[j + 1]
		end

		table.remove(self.newMoList, index)
	end

	self._flow = FlowParallel.New()

	local delayCounter = 0

	for i = 1, #self.newMoList do
		local newIndex = i
		local oldIndex = new2old[i]
		local isVisible = self._csListScroll:IsVisual(newIndex - 1)

		if newIndex ~= oldIndex and isVisible then
			local rect = self._csListScroll:GetRenderCellRect(oldIndex - 1)

			if gohelper.isNil(rect) then
				break
			end

			local newPosX, newPosY = recthelper.getAnchor(self._csListScroll:GetRenderCellRect(newIndex - 1))
			local oldPosX, oldPosY = recthelper.getAnchor(rect)

			recthelper.setAnchor(rect, oldPosX, oldPosY)

			local work = TweenWork.New({
				type = "DOAnchorPos",
				tr = rect,
				tox = newPosX,
				toy = newPosY,
				t = self:getMoveAnimationTime(),
				ease = EaseType.Linear
			})
			local sequence = FlowSequence.New()

			self._flow:addWork(sequence)

			if self:getMoveInterval() > 0 then
				sequence:addWork(WorkWaitSeconds.New(self:getMoveInterval() * delayCounter))
			end

			sequence:addWork(work)

			delayCounter = delayCounter + 1
		end
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.ListScrollAnimRemoveItem)
	self._flow:registerDoneListener(self._onDone, self)
	self._flow:start()
	TaskDispatcher.runDelay(self._delayRemoveBlock, self, 2)
end

function ListScrollAnimRemoveItem:_delayRemoveBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)
end

function ListScrollAnimRemoveItem:_onDone()
	TaskDispatcher.cancelTask(self._delayRemoveBlock, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)

	self._flow = nil
	self.newMoList = nil

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj)
		else
			self._callback()
		end

		self._callback = nil
		self._callbackObj = nil
	end
end

function ListScrollAnimRemoveItem:onDestroy()
	TaskDispatcher.cancelTask(self._delayRemoveBlock, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)

	self._csListScroll = nil
	self.newMoList = nil

	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end

	self._callback = nil
	self._callbackObj = nil
end

return ListScrollAnimRemoveItem
