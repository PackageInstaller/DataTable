-- chunkname: @/tmp/or_script/lua_compile/dm/utils/CollectionViewUtils.lua

CollectionViewUtils = class("CollectionViewUtils", objectlua.Object)

function CollectionViewUtils:initialize(data)
	super.initialize(self)

	self._view = data.view
	self._delegate = data.delegate
	self._cellNumSize = data.cellNumSize or cc.size(0, 0)
	self._cellData = data.cellData or {}
	self._cellSize = data.cellSize
	self._isReuse = data.isReuse
	self._isSchedule = data.isSchedule
	self._extraOffset = data.extraOffset or 0
	self._minScale = data.minScale or 0
	self._maxScale = data.maxScale or 1
	self._reloadDataSchedule = data.reloadDataSchedule
	self._moveTimeForPerCell = data.moveTimeForPerCell or 0
	self._isCreateAll = data.isCreateAll
	self._viewSize = self._view:getContentSize()
	self._visibleRect = cc.rect(0, 0, self._viewSize.width, self._viewSize.height)
	self._innerContainerSize = cc.size(self._cellSize.width * self._cellNumSize.width, self._cellSize.height * self._cellNumSize.height)

	self._view:setInnerContainerSize(self._innerContainerSize)

	self._scheduleTime = self._moveTimeForPerCell / (self._viewSize.width / self._cellSize.width + self._viewSize.height / self._cellSize.height + 2) * 0.5
	self._isCreating = false
	self._createdCellMap = {}
	self._waitCreateQueue = {}
	self._recycleQueue = {}
	self._frameIndexInfo = {
		0,
		0,
		0,
		0
	}
	self._isReload = false
	self._isCreateAllOver = false
	self._zoomIng = false

	function self._view.stopAllActions()
		assert(false, "CollectionViewUtils将会利用动作执行队列加载，不能调用停止所有动作方法，请精确暂停某个动作")
	end

	self._view:addEventListener(function(sender, eventType)
		if self._delegate.onEventForCollectionView then
			self._delegate:onEventForCollectionView(sender, eventType)
		end

		if not self._isReload then
			return
		end

		if self._zoomIng then
			return
		end

		self:checkUpdateCell()
	end)
end

function CollectionViewUtils:reloadData()
	self._isCreating = false
	self._isCreateAllOver = false

	for i, v in pairs(self._createdCellMap) do
		if v ~= true then
			v:removeFromParent(true)
		end
	end

	for i, v in pairs(self._recycleQueue) do
		for i, cell in ipairs(v) do
			cell:removeFromParent(true)
		end
	end

	self._recycleQueue = {}
	self._createdCellMap = {}
	self._waitCreateQueue = {}
	self._frameIndexInfo = {
		0,
		0,
		0,
		0
	}

	self._view:stopActionByTag(101)

	if self._delegate.numSizeOfCells then
		self._cellNumSize = self._delegate:numSizeOfCells()
	end

	local container = self._view:getInnerContainer()
	local pos = self._view:getInnerContainerPosition()
	local scale = container:getScale()

	self._innerContainerSize = cc.size(self._cellSize.width * self._cellNumSize.width, self._cellSize.height * self._cellNumSize.height)

	local curSize = cc.size(self._innerContainerSize.width * scale, self._innerContainerSize.height * scale)

	self._view:setInnerContainerSize(curSize)
	self._view:setInnerContainerPosition(pos)

	self._isReload = true

	self:checkUpdateCell(not self._reloadDataSchedule)
end

function CollectionViewUtils:setExtraOffset(extraOffset)
	self._extraOffset = extraOffset
end

function CollectionViewUtils:getCellByRowAndCol(row, col)
	local index = row * self._cellNumSize.width + col

	return self._createdCellMap[index]
end

function CollectionViewUtils:dequeueCellByKey(key)
	key = key or "def"

	local queue = self._recycleQueue[key]

	if queue and #queue > 0 then
		return table.remove(queue)
	end

	return nil
end

function CollectionViewUtils:getCountOfCell()
	local count = 0

	for i, v in pairs(self._createdCellMap) do
		if v ~= true then
			count = count + 1
		end
	end

	return count
end

function CollectionViewUtils:getCurrentCells()
	local cells = {}

	for i, v in pairs(self._createdCellMap) do
		if v ~= true then
			table.insert(cells, v)
		end
	end

	return cells
end

function CollectionViewUtils:zoomScaleByTime(scale, center, time)
	local container = self._view:getInnerContainer()

	center = center or self._view:convertToWorldSpace(cc.p(self._viewSize.width * 0.5, self._viewSize.height * 0.5))

	if scale == container:getScale() then
		return
	end

	local curScale = container:getScale()
	local scaleOffset = scale - curScale
	local startTime = app.getTime()

	self._view:stopActionByTag(1001)

	local action = schedule(self._view, function()
		local timeOffset = app.getTime() - startTime
		local timePercent = timeOffset / time

		timePercent = timePercent > 1 and 1 or timePercent

		local targetScale = curScale + scaleOffset * timePercent

		self:setZoomScale(targetScale, center)

		if timePercent >= 1 then
			self._view:stopActionByTag(1001)
		end
	end, 0)

	action:setTag(1001)
end

function CollectionViewUtils:zoomScaleToCenterByTime(scale, center, showCenter, time, callfun, callfunTime, endCallfun)
	center = center or self._view:convertToWorldSpace(cc.p(self._viewSize.width * 0.5, self._viewSize.height * 0.5))
	showCenter = showCenter or center

	local container = self._view:getInnerContainer()
	local curScale = container:getScale()
	local scaleOffset = 0

	if scale and scale > 0 then
		scaleOffset = scale - curScale
	end

	local showOffset = cc.p(showCenter.x - center.x, showCenter.y - center.y)
	local startTime = app.getTime()
	local updateTime = startTime

	self._view:stopActionByTag(1001)

	self._zoomIng = true

	local action = schedule(self._view, function()
		local timeNow = app.getTime()
		local timeEnd = timeNow

		if timeNow - startTime > time then
			timeEnd = startTime + time
		end

		local timeOffset = timeEnd - updateTime

		updateTime = timeEnd

		local timePercent = timeOffset / time

		if callfunTime and timeNow - startTime >= callfunTime then
			if callfun then
				callfun()
			end

			callfun = nil
		end

		if timeNow - startTime >= time then
			self._view:stopActionByTag(1001)

			if callfun then
				callfun()
			end

			callfun = nil

			if endCallfun then
				endCallfun()
			end

			endCallfun = nil
		end

		local moveOffset = cc.p(showOffset.x * timePercent, showOffset.y * timePercent)
		local targetPos = self._view:getInnerContainerPosition()
		local curSize

		if scaleOffset ~= 0 then
			local scale = curScale + scaleOffset * timePercent
			local realScale = math.max(self._minScale, math.min(self._maxScale, scale))

			curScale = scale
			curSize = cc.size(self._innerContainerSize.width * realScale, self._innerContainerSize.height * realScale)

			if curSize.height < self._viewSize.height or curSize.width < self._viewSize.width then
				return
			end

			self._zoomIng = true

			local oldCenter = container:convertToNodeSpace(center)

			container:setScale(realScale)
			self._view:setInnerContainerSize(curSize)

			local newCenter = container:convertToWorldSpace(oldCenter)
			local offset = cc.pSub(center, newCenter)
			local newOffset = cc.pAdd(moveOffset, offset)

			center = cc.pAdd(center, moveOffset)
			targetPos = cc.pAdd(self._view:getInnerContainerPosition(), newOffset)
		else
			self._zoomIng = true
			curSize = cc.size(self._innerContainerSize.width, self._innerContainerSize.height)
			center = cc.pAdd(center, moveOffset)
			targetPos = cc.pAdd(targetPos, moveOffset)
		end

		targetPos.x = targetPos.x > 0 and 0 or targetPos.x
		targetPos.y = targetPos.y > 0 and 0 or targetPos.y

		local minX = self._viewSize.width - curSize.width
		local minY = self._viewSize.height - curSize.height

		targetPos.x = minX > targetPos.x and minX or targetPos.x
		targetPos.y = minY > targetPos.y and minY or targetPos.y

		self._view:setInnerContainerPosition(targetPos)

		self._zoomIng = false

		self:checkUpdateCell()
	end, 0)

	action:setTag(1001)
end

function CollectionViewUtils:setZoomScale(scale, center)
	local container = self._view:getInnerContainer()

	center = center or self._view:convertToWorldSpace(cc.p(self._viewSize.width * 0.5, self._viewSize.height * 0.5))

	if scale == container:getScale() then
		return
	end

	local realScale = math.max(self._minScale, math.min(self._maxScale, scale))
	local curSize = cc.size(self._innerContainerSize.width * realScale, self._innerContainerSize.height * realScale)

	if curSize.height < self._viewSize.height or curSize.width < self._viewSize.width then
		return
	end

	self._zoomIng = true

	local oldCenter = container:convertToNodeSpace(center)

	container:setScale(realScale)
	self._view:setInnerContainerSize(curSize)

	local newCenter = container:convertToWorldSpace(oldCenter)
	local offset = cc.pSub(center, newCenter)
	local targetPos = cc.pAdd(self._view:getInnerContainerPosition(), offset)

	targetPos.x = targetPos.x > 0 and 0 or targetPos.x
	targetPos.y = targetPos.y > 0 and 0 or targetPos.y

	local minX = self._viewSize.width - curSize.width
	local minY = self._viewSize.height - curSize.height

	targetPos.x = minX > targetPos.x and minX or targetPos.x
	targetPos.y = minY > targetPos.y and minY or targetPos.y

	self._view:setInnerContainerPosition(targetPos)

	self._zoomIng = false

	self:checkUpdateCell()
end

function CollectionViewUtils:checkUpdateCell(immediately)
	if not self._isReload then
		return
	end

	local container = self._view:getInnerContainer()
	local scale = container:getScale()
	local pos = self._view:getInnerContainerPosition()

	self._visibleRect.x = -pos.x < 0 and 0 or -pos.x
	self._visibleRect.y = -pos.y < 0 and 0 or -pos.y
	self._visibleRect.x = self._visibleRect.x / scale
	self._visibleRect.y = self._visibleRect.y / scale
	self._visibleRect.height = self._viewSize.height / scale
	self._visibleRect.width = self._viewSize.width / scale
	self._visibleRect.x = math.min(self._visibleRect.x, self._innerContainerSize.width - self._viewSize.width / scale)
	self._visibleRect.y = math.min(self._visibleRect.y, self._innerContainerSize.height - self._viewSize.height / scale)

	local top = self._visibleRect.y + self._visibleRect.height
	local bottom = self._visibleRect.y
	local left = self._visibleRect.x
	local right = self._visibleRect.x + self._visibleRect.width

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
	self._frameIndexInfo = {
		fromXIndex,
		toXIndex,
		fromYindex,
		toYindex
	}

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
					local cell = self._delegate:cellAtIndex(self._view, row, col, self)

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

	if #self._waitCreateQueue > 0 and immediately then
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

	if self._isCreateAll and not self._isCreateAllOver then
		for i = 0, self._cellNumSize.height - 1 do
			for j = 0, self._cellNumSize.width - 1 do
				local row, col = i, j
				local index = row * self._cellNumSize.width + col

				if not self._createdCellMap[index] then
					self._createdCellMap[index] = true

					table.insert(self._waitCreateQueue, {
						i,
						j
					})
				end
			end
		end

		self._isCreateAllOver = true
	end

	self:createCellByQueue()

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

							self._createdCellMap[i] = nil
							self._recycleQueue[key] = queue
						end
					end
				end
			elseif not self._isCreateAll then
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
end

function CollectionViewUtils:createCellByQueue()
	if #self._waitCreateQueue > 0 and not self._isCreating then
		local action

		self._isCreating = true

		local prevTime = app.getTime()

		schedule(self._view, function()
			local function stepFunc()
				local info = table.remove(self._waitCreateQueue)

				if not info then
					self._view:stopActionByTag(101)

					self._isCreating = false

					return false
				end

				self:createCellByInfo(info, true)

				return true
			end

			while stepFunc() and app.getTime() - prevTime < 0.06666666666666667 do
				-- block empty
			end

			prevTime = app.getTime()
		end, (not self._scheduleTime or nil) and 0):setTag(101)
	end
end

function CollectionViewUtils:reFreshCurCells(immediately)
	for i, v in pairs(self._createdCellMap) do
		local row = math.floor(i / self._cellNumSize.width)
		local col = i % self._cellNumSize.width

		if v ~= true and not v.isHide then
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

					self._createdCellMap[i] = nil
					self._recycleQueue[key] = queue
				end
			end
		end
	end

	self:checkUpdateCell(immediately)
end

function CollectionViewUtils:createCellByInfo(info, needCheck)
	local index = info[1] * self._cellNumSize.width + info[2]
	local cell = self._delegate:cellAtIndex(self._view, info[1], info[2], self)

	cell:setAnchorPoint(0, 0)
	cell:setPosition(info[2] * self._cellSize.width, info[1] * self._cellSize.height)

	if not cell:getParent() then
		self._view:addChild(cell)
	end

	self._createdCellMap[index] = cell

	cell:setVisible(false)

	cell.isHide = true

	if needCheck and (info[2] < self._frameIndexInfo[1] or info[2] > self._frameIndexInfo[2] or info[1] < self._frameIndexInfo[3] or info[1] > self._frameIndexInfo[4]) then
		return
	end

	cell:setVisible(true)

	cell.isHide = false

	if self._delegate.cellWillShow then
		self._delegate:cellWillShow(self._view, info[1], info[2], cell)
	end
end
