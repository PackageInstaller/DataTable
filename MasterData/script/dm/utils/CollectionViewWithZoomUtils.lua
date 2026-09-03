-- chunkname: @/tmp/or_script/lua_compile/dm/utils/CollectionViewWithZoomUtils.lua

CollectionViewWithZoomUtils = class("CollectionViewWithZoomUtils", objectlua.Object)

function CollectionViewWithZoomUtils:initialize(data)
	super.initialize(self)

	self._view = data.view
	self._delegate = data.delegate
	self._cellNumSize = data.cellNumSize or cc.size(0, 0)
	self._cellSize = data.cellSize
	self._isReuse = data.isReuse
	self._isSchedule = data.isSchedule
	self._extraOffset = data.extraOffset or 0
	self._reloadDataSchedule = data.reloadDataSchedule
	self._moveTimeForPerCell = data.moveTimeForPerCell or 0
	self._viewSize = self._view:getViewSize()

	self._view:setMinScale(0)
	self._view:setMaxScale(1)

	self._visibleRect = cc.rect(0, 0, self._viewSize.width, self._viewSize.height)
	self._innerContainerSize = cc.size(self._cellSize.width * self._cellNumSize.width, self._cellSize.height * self._cellNumSize.height)

	self._view:setContentSize(self._innerContainerSize)

	self._scheduleTime = self._moveTimeForPerCell / (self._viewSize.width / self._cellSize.width + self._viewSize.height / self._cellSize.height + 2) * 0.5
	self._isCreating = false
	self._createdCellMap = {}
	self._waitCreateQueue = {}
	self._recycleQueue = {}
	self._isReload = false

	function self._view.stopAllActions()
		assert(false, "CollectionViewWithZoomUtils将会利用动作执行队列加载，不能调用停止所有动作方法，请精确暂停某个动作")
	end

	local function onEvent(...)
		if self._delegate.onEventForCollectionView then
			self._delegate:onEventForCollectionView(...)
		end

		if not self._isReload then
			return
		end

		self:checkUpdateCell()
	end

	self._view:setDirection(cc.SCROLLVIEW_DIRECTION_BOTH)
	self._view:setBounceable(flase)
	self._view:setDelegate()
	self._view:registerScriptHandler(onEvent, 0)
	self._view:registerScriptHandler(onEvent, 1)
end

function CollectionViewWithZoomUtils:reloadData()
	self._isCreating = false

	for i, v in pairs(self._createdCellMap) do
		if v ~= true then
			v:removeFromParent(true)
		end
	end

	local queue = self._recycleQueue[key]

	if queue and #queue > 0 then
		return table.remove(queue)
	end

	for i, v in pairs(self._recycleQueue) do
		for i, cell in ipairs(v) do
			cell:removeFromParent(true)
		end
	end

	self._recycleQueue = {}
	self._createdCellMap = {}
	self._waitCreateQueue = {}

	self._view:stopActionByTag(101)

	if self._delegate.numSizeOfCells then
		self._cellNumSize = self._delegate:numSizeOfCells()
	end

	local pos = self._view:getContentOffset()

	self._innerContainerSize = cc.size(self._cellSize.width * self._cellNumSize.width, self._cellSize.height * self._cellNumSize.height)

	self._view:setContentSize(self._innerContainerSize)
	self._view:setContentOffset(pos)

	self._isReload = true

	self:checkUpdateCell(not self._reloadDataSchedule)
end

function CollectionViewWithZoomUtils:setExtraOffset(extraOffset)
	self._extraOffset = extraOffset
end

function CollectionViewWithZoomUtils:getCellByRowAndCol(row, col)
	local index = row * self._cellNumSize.width + col

	return self._createdCellMap[index]
end

function CollectionViewWithZoomUtils:dequeueCellByKey(key)
	key = key or "def"

	local queue = self._recycleQueue[key]

	if queue and #queue > 0 then
		return table.remove(queue)
	end

	return nil
end

function CollectionViewWithZoomUtils:getCountOfCell()
	local count = 0

	for i, v in pairs(self._createdCellMap) do
		if v ~= true then
			count = count + 1
		end
	end

	return count
end

function CollectionViewWithZoomUtils:getCurrentCells()
	local cells = {}

	for i, v in pairs(self._createdCellMap) do
		if v ~= true then
			table.insert(cells, v)
		end
	end

	return cells
end

function CollectionViewWithZoomUtils:checkUpdateCell(immediately)
	local pos = self._view:getContentOffset()

	self._visibleRect.x = -pos.x < 0 and 0 or -pos.x
	self._visibleRect.y = -pos.y < 0 and 0 or -pos.y
	self._visibleRect.x = math.min(self._visibleRect.x, self._innerContainerSize.width - self._viewSize.width)
	self._visibleRect.y = math.min(self._visibleRect.y, self._innerContainerSize.height - self._viewSize.height)

	local zoomScale = self._view:getZoomScale()
	local top = self._visibleRect.y + self._visibleRect.height / zoomScale
	local bottom = self._visibleRect.y
	local left = self._visibleRect.x
	local right = self._visibleRect.x + self._visibleRect.width / zoomScale

	if self._extraOffset then
		if top + self._extraOffset <= self._innerContainerSize.height then
			top = top + self._extraOffset
		end

		if bottom - self._extraOffset >= 0 then
			bottom = bottom - self._extraOffset
		end

		if left - self._extraOffset >= 0 then
			left = left - self._extraOffset
		end

		if right + self._extraOffset <= self._innerContainerSize.width then
			right = right + self._extraOffset
		end
	end

	local fromXIndex = math.floor(left / self._cellSize.width)
	local toXIndex = math.ceil(right / self._cellSize.width)

	toXIndex = toXIndex - 1

	local fromYindex = math.floor(bottom / self._cellSize.height)
	local toYindex = math.ceil(top / self._cellSize.height)

	toYindex = toYindex - 1

	for i = fromXIndex, toXIndex do
		for j = fromYindex, toYindex do
			local row, col = j, i
			local index = row * self._cellNumSize.width + col
			local tempCell = self._createdCellMap[index]

			if not tempCell then
				if self._isSchedule and not immediately then
					self._createdCellMap[index] = true

					table.insert(self._waitCreateQueue, 1, {
						row,
						col
					})
				else
					local cell = self._delegate:cellAtIndex(self._view, row, col)

					cell:setAnchorPoint(0, 0)
					cell:setVisible(true)

					if self._delegate.cellWillShow then
						self._delegate:cellWillShow(self._view, row, col, cell)
					end

					cell.isHide = false

					cell:setPosition(col * self._cellSize.width, row * self._cellSize.height)

					if not cell:getParent() then
						self._view:addChild(cell)
					end

					self._createdCellMap[index] = cell
				end
			elseif tempCell ~= true and tempCell.isHide then
				tempCell:setVisible(true)

				if self._delegate.cellWillShow then
					self._delegate:cellWillShow(self._view, row, col, tempCell)
				end

				tempCell.isHide = false
			end
		end
	end

	if #self._waitCreateQueue > 0 and (immediately or not self._isSchedule) then
		while true do
			local info = table.remove(self._waitCreateQueue)

			if not info then
				self._view:stopActionByTag(101)

				self._isCreating = false

				break
			end

			self:createCellByInfo(info)
		end
	end

	if #self._waitCreateQueue > 0 and not self._isCreating then
		local action

		self._isCreating = true

		schedule(self._view, function()
			local info = table.remove(self._waitCreateQueue)

			if not info then
				self._view:stopActionByTag(101)

				self._isCreating = false

				return
			end

			self:createCellByInfo(info)
		end, self._scheduleTime or 0):setTag(101)
	end

	local removeKeys = {}

	for i, v in pairs(self._createdCellMap) do
		local row = math.floor(i / self._cellNumSize.width)
		local col = i % self._cellNumSize.width
		local indexRect = cc.rect(fromXIndex, fromYindex, toXIndex - fromXIndex, toYindex - fromYindex)

		if not cc.rectContainsPoint(indexRect, cc.p(col, row)) then
			if v ~= true then
				if not v.isHide then
					v:setVisible(false)

					if self._delegate.cellWillHide then
						self._delegate:cellWillHide(self._view, row, col, v)
					end

					v.isHide = true

					if self._isReuse then
						local key = v:getName()

						if #key == 0 then
							key = "def"
						end

						if not self._recycleQueue[key] then
							local queue = {}

							table.insert(queue, v)
							table.insert(removeKeys, i)

							self._recycleQueue[key] = queue
						end
					end
				end
			else
				for j, info in ipairs(self._waitCreateQueue) do
					local index = info[1] * self._cellNumSize.width + info[2]

					if i == index then
						table.remove(self._waitCreateQueue, j)

						self._createdCellMap[index] = nil

						break
					end
				end
			end
		end
	end

	for i = 1, #removeKeys do
		self._createdCellMap[removeKeys[i]] = nil
	end
end

function CollectionViewWithZoomUtils:createCellByInfo(info)
	local index = info[1] * self._cellNumSize.width + info[2]
	local cell = self._delegate:cellAtIndex(self._view, info[1], info[2])

	cell:setAnchorPoint(0, 0)
	cell:setVisible(true)

	cell.isHide = false

	if self._delegate.cellWillShow then
		self._delegate:cellWillShow(self._view, info[1], info[2], cell)
	end

	cell:setPosition(info[2] * self._cellSize.width, info[1] * self._cellSize.height)

	if not cell:getParent() then
		self._view:addChild(cell)
	end

	self._createdCellMap[index] = cell
end
