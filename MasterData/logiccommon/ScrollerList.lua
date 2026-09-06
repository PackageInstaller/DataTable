-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/ScrollerList.lua

module("logiccommon.common.viewlib.usualviews.ScrollerList", package.seeall)

local ScrollerList = class("ScrollerList")
local circle_horizontal = 1
local circle_vertical = 2
local circle_horizontal_onlyPos = 3
local b_horizontal = 1
local b_vertical = 2

function ScrollerList:ctor()
	self.tagCellList = {}
	self._updateCellCallBack = nil
	self._getCellSizeCallBack = nil
	self._reloadFinishCallBack = nil
	self._clearCellCallBack = nil
	self._getTagByIdxCallBack = nil
	self._circleOffsetState = 0
	self._isOnlyCircleOfeesetPos = false
	self._isMoveCellsCenterOnNotFullScreen = false
end

function ScrollerList.create(scrollerGo, cellGos, updateCellCallBack, clearCellCallBack)
	local list = ScrollerList.New()

	list:init(scrollerGo, cellGos, updateCellCallBack, clearCellCallBack)

	return list
end

function ScrollerList:init(scrollerGo, cellGos, updateCellCallBack, clearCellCallBack)
	self._updateCellCallBack = updateCellCallBack
	self._clearCellCallBack = clearCellCallBack
	self._scrollerGo = scrollerGo.gameObject
	self._tableview = self._scrollerGo:GetComponent("UITableview")

	if cellGos and type(cellGos) == "table" then
		for i, v in ipairs(cellGos) do
			self:setTagCell(v, i)
		end
	else
		self:setTagCell(cellGos, 1)
	end

	self:registCallbacks()
end

function ScrollerList:setStartAndEndButton(startGo, endGo)
	self._startGo = startGo
	self._endGo = endGo
end

function ScrollerList:dragNotifyParent()
	if self._drag == nil then
		self.parentSVs = self._scrollerGo:GetComponentsInParent(typeof(UnityEngine.UI.ScrollRect))

		if self.parentSVs ~= nil and self.parentSVs.Length > 0 then
			self._drag = Framework.UIDragTrigger.Get(self._scrollerGo)

			self._drag:AddDragListener(self._onDragInside, self)
			self._drag:AddBeginDragListener(self._onBeginDragInside, self)
			self._drag:AddEndDragListener(self._onEndDragInside, self)
		end
	end
end

function ScrollerList:removeDragNotifyParent()
	if self._drag then
		self._drag:RemoveDragListener()
		self._drag:RemoveBeginDragListener()
		self._drag:RemoveEndDragListener()

		self._drag = nil
	end
end

function ScrollerList:_onDragInside(eventData)
	if self.parentSVs ~= nil and self.parentSVs.Length > 0 then
		for i = 1, self.parentSVs.Length do
			local sv = self.parentSVs[i - 1]

			if sv.gameObject ~= self._scrollerGo then
				sv:OnDrag(eventData)
			end
		end
	end
end

function ScrollerList:_onBeginDragInside(eventData)
	if self.parentSVs ~= nil and self.parentSVs.Length > 0 then
		for i = 1, self.parentSVs.Length do
			local sv = self.parentSVs[i - 1]

			if sv.gameObject ~= self._scrollerGo then
				sv:OnBeginDrag(eventData)
			end
		end
	end
end

function ScrollerList:_onEndDragInside(eventData)
	if self.parentSVs ~= nil and self.parentSVs.Length > 0 then
		for i = 1, self.parentSVs.Length do
			local sv = self.parentSVs[i - 1]

			if sv.gameObject ~= self._scrollerGo then
				sv:OnEndDrag(eventData)
			end
		end
	end
end

function ScrollerList:setTagCell(cellGo, tag)
	if cellGo then
		tag = tag or 1
		self.tagCellList[tag] = cellGo

		GameUtil.SetActive(cellGo, false)
	end
end

function ScrollerList:getCellByTag(tag)
	return self.tagCellList[tag]
end

function ScrollerList:getTagByIdx(data, idx)
	if self._getTagByIdxCallBack then
		return self._getTagByIdxCallBack(data, idx)
	else
		return 1
	end
end

function ScrollerList:regGetTagByIdx(cb)
	self._getTagByIdxCallBack = cb
end

function ScrollerList:regGetCellSize(getCellSizeCallBack)
	self._getCellSizeCallBack = getCellSizeCallBack
end

function ScrollerList:regGetDataLen(cb)
	self._getDataLenCallBack = cb
end

function ScrollerList:regReloadFinish(reloadFinishCallBack)
	self._reloadFinishCallBack = reloadFinishCallBack
end

function ScrollerList:regValueChanged(onValueChanged)
	self._onValueChangedCallBack = onValueChanged
end

function ScrollerList:registCallbacks()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	self._tableview:RegisterOnUpdatePositionCallback(function(self, view)
		self:_onUpdatePosition(view)
	end)

	local sr = Framework.ScrollRectAdapter.Get(self._scrollerGo)

	if sr then
		sr:AddOnValueChanged(self.OnScrollRectValueChange, self)
	end
end

function ScrollerList:_onUpdatePosition(tableView)
	self:OnScrollRectValueChange()
end

function ScrollerList:OnScrollRectValueChange()
	if self._tableview and self._tableview.isReady then
		if self._circleOffsetState == circle_horizontal then
			ScrollerList._onScrollValueCircleHorizontalChange(self._tableview, self._circleOffset, self._circleCellContentName)
		end

		if self._circleOffsetState == circle_vertical then
			ScrollerList._onScrollValueCircleVerticalChange(self._tableview, self._circleOffset, self._circleCellContentName)
		end

		if self._circleOffsetState == circle_horizontal_onlyPos then
			ScrollerList._onScrollValueCircleHorizontalOnlyPosChange(self._tableview, self._circleOffset, self._circleCellContentName)
		end

		if self._beizierOffset == true then
			ScrollerList._onScrollValueBeizierHorizontalChange(self._tableview, self._beizierPoints, self._beizierLineOffset, self._beizierContentName)
		end

		if self._bezierThroughPoints then
			ScrollerList._onScrollValueBeizierThroughChange(self._tableview, self._bezierThroughPoints, self._beizierContentName, self._bezierState)
		end

		if self._onValueChangedCallBack then
			self._onValueChangedCallBack(self._tableview)
		end

		if self._startGo then
			GameUtil.SetActive(self._startGo, not self:isShowBeginCell())
		end

		if self._endGo then
			GameUtil.SetActive(self._endGo, not self:isShowFinishCell())
		end
	end
end

function ScrollerList:_numInView()
	if self._getDataLenCallBack then
		return self._getDataLenCallBack()
	else
		if not self._curViewDatas then
			return 0
		end

		return #self._curViewDatas
	end
end

function ScrollerList:getData()
	return self._curViewDatas
end

function ScrollerList:_cellSize(view, index)
	if self._getCellSizeCallBack ~= nil then
		return self._getCellSizeCallBack(view, index)
	end

	return 100, 100
end

function ScrollerList:_cellAtIndex(view, idx)
	local cell
	local data = self._curViewDatas[idx + 1]
	local tag = self:getTagByIdx(data, idx)
	local cell = view:DequeueCellByTag(tag)

	if not cell then
		local cellGo = self:getCellByTag(tag)

		cell = view:AddChild(cellGo, tag)
	end

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data, tag)

	return cell
end

function ScrollerList:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1

	local tag = self:getTagByIdx(data, idx)

	self:_updateCell(view, cell, data, tag)
end

function ScrollerList:_updateCell(view, cell, data, tag)
	if self._updateCellCallBack then
		self._updateCellCallBack(view, cell, data, tag)
	end

	if not string.nilorempty(self._dragCellGoName) then
		local go = goutil.findChild(cell, self._dragCellGoName)

		if go then
			self:_regDragEvent(view, cell, data, tag)
		end
	end
end

function ScrollerList:setDragCallBack(dragCellGoName, onBeginDrag, onDragMove, onDragEnd)
	self._dragCellGoName = dragCellGoName
	self._onBeginDrag = onBeginDrag
	self._onDragMove = onDragMove
	self._onDragEnd = onDragEnd
	self._isDragOuting = false
end

function ScrollerList:_regDragEvent(view, cell, data, tag)
	if not string.nilorempty(self._dragCellGoName) then
		local con = goutil.findChild(cell, self._dragCellGoName)

		if con then
			local dragTrigger = Framework.UIDragTrigger.Get(con)

			if dragTrigger then
				local obj = {}

				obj.data = data
				obj.cell = cell

				dragTrigger:RemoveDragListener()
				dragTrigger:RemoveBeginDragListener()
				dragTrigger:RemoveEndDragListener()
				dragTrigger:AddBeginDragListener(self._OnDragBeginInner, self, obj)
				dragTrigger:AddDragListener(self._OnDragMovedInner, self, obj)
				dragTrigger:AddEndDragListener(self._OnDragEndedInner, self, obj)
			end
		end
	end
end

function ScrollerList:_OnDragBeginInner(eventData, obj)
	local drag = math.abs(eventData.delta.y) > math.abs(eventData.delta.x) and self:GetScrollRect().horizontal or math.abs(eventData.delta.y) < math.abs(eventData.delta.x) and self:GetScrollRect().vertical

	if drag then
		self._isDragOuting = true

		local data = obj.data
		local cell = obj.cell

		if self._onBeginDrag then
			self._onBeginDrag(eventData, data, cell)
		end
	else
		self._isDragOuting = nil

		self:GetScrollRect():OnBeginDrag(eventData)
		self._tableview:OnBeginDrag(eventData)
	end
end

function ScrollerList:_OnDragMovedInner(eventData, obj)
	if self._isDragOuting then
		local data = obj.data
		local cell = obj.cell

		if self._onDragMove then
			self._onDragMove(eventData, data, cell)
		end
	else
		self:GetScrollRect():OnDrag(eventData)
	end
end

function ScrollerList:_OnDragEndedInner(eventData, obj)
	if self._isDragOuting then
		local data = obj.data
		local cell = obj.cell

		if self._onDragEnd then
			self._onDragEnd(eventData, data, cell)
		end
	elseif self._tableview and self:GetScrollRect() and eventData then
		self:GetScrollRect():OnEndDrag(eventData)
		self._tableview:OnEndDrag(eventData)
	end
end

function ScrollerList:_onReloadFinish()
	self.reloadFinish = true

	self:MoveCellInView(self.moveIdx)
	self:MoveCellToCenter(self.centerMoveIdx)
	self:MoveCellToBegin(self.beginMoveIdx, self.beginMoveNeedAnim)
	self:SetOffset(self._offset, self._spring)

	if self._sliderAdapter and self._curValue and self._scoreList then
		self:updateUnderSlider(self._sliderAdapter, self._curValue, self._scoreList, self._myStepList)

		self._sliderAdapter = nil
		self._curValue = nil
		self._scoreList = nil
		self._myStepList = nil
	end

	if self._reloadFinishCallBack then
		self._reloadFinishCallBack()
	end

	self:_moveCenterOnLessCells()
end

function ScrollerList:reloadData(list)
	self.reloadFinish = false
	self._curViewDatas = list

	self._tableview:ReloadData()
end

function ScrollerList:refresh(list)
	if list then
		self._curViewDatas = list
	end

	if self._curViewDatas then
		self._tableview:Refresh()
	end
end

function ScrollerList:updateCellAtIndex(idx)
	idx = checknumber(idx)

	self._tableview:UpdateCellAtIndex(idx)
end

function ScrollerList:updateCellInViewByIndex(idx)
	idx = checknumber(idx)

	local cell = self._tableview:GetCellAtIndex(idx)

	if cell then
		self._tableview:UpdateCellAtIndex(idx)
	end
end

function ScrollerList:tryTransList(list)
	if #list ~= table.nums(list) then
		local sortArr = {}

		for k, v in pairs(list) do
			table.insert(sortArr, k)
		end

		ArraySort.sortOn(sortArr)

		local tem = {}

		for i, v in ipairs(sortArr) do
			table.insert(tem, list[v])
		end

		list = tem
	end

	return list
end

function ScrollerList:dispose()
	self:removeDragNotifyParent()
	self._tableview:Travel(self._clearTableview, self)
end

function ScrollerList:MoveCellInView(idx, isMotion)
	self.moveIdx = idx

	if self.reloadFinish then
		if self._curViewDatas then
			if not #self._curViewDatas then
				local count = 0

				if self.moveIdx and count > 0 then
					self._tableview:MoveCellInView(self.moveIdx, checkbool(isMotion))

					self.moveIdx = nil
				end
			end
		end
	end
end

function ScrollerList:MoveCellToCenter(idx)
	self.centerMoveIdx = idx

	if self.reloadFinish then
		if self._curViewDatas then
			if not #self._curViewDatas then
				local count = 0

				if self.centerMoveIdx and count > 0 then
					self._tableview:MoveCellToCebter(self.centerMoveIdx)

					self.centerMoveIdx = nil
				end
			end
		end
	end
end

function ScrollerList:MoveCellToBegin(idx, bNeedAnim)
	self.beginMoveIdx = idx
	self.beginMoveNeedAnim = bNeedAnim

	if self.reloadFinish and self.beginMoveIdx ~= nil and self.beginMoveIdx >= 0 then
		if self._curViewDatas then
			if not #self._curViewDatas then
				local count = 0

				if count > 0 then
					self.beginMoveIdx = Mathf.Clamp(self.beginMoveIdx, 0, count)

					local offset = self._tableview:GetOffsetByIndex(self.beginMoveIdx)
					local minOffset = self._tableview:GetMinOffset()
					local maxOffset = self._tableview:GetMaxOffset()
					local move = Mathf.Clamp(offset, minOffset, maxOffset)

					self._tableview:SetOffset(move, self.beginMoveNeedAnim == true)

					self.beginMoveIdx = nil
					self.beginMoveNeedAnim = nil
				end
			end
		end
	end
end

function ScrollerList:SetOffset(offset, spring)
	self._offset = offset
	self._spring = checkbool(spring)

	if self.reloadFinish and self._offset ~= nil then
		if self._curViewDatas then
			if not #self._curViewDatas then
				local count = 0

				if count > 0 then
					self._tableview:SetOffset(self._offset, self._spring)
				end

				self._offset = nil
				self._spring = nil
			end
		end
	end
end

function ScrollerList:setCenterMode(isCenter)
	self._isMoveCellsCenterOnNotFullScreen = isCenter
	self._tableview.disableDragIfFits = isCenter
end

function ScrollerList:_moveCenterOnLessCells()
	if self._isMoveCellsCenterOnNotFullScreen then
		local viewSize = self._tableview:GetViewSize()
		local contentSize = self._tableview:GetContentSize()
		local scrollRect = self:GetScrollRect()

		if scrollRect.horizontal then
			local cellStartX = (viewSize - contentSize) / 2
			local cellSpacingX = self._tableview.cellSpacing.x
			local isCanMiddle = contentSize <= viewSize

			if isCanMiddle then
				local tableViewName = tolua.typename(self._tableview)
				local curVisibleCount = self._tableview:GetVisibleCount()

				if self._curViewDatas then
					if not #self._curViewDatas then
						local addWidth = 0

						for i = 1, curVisibleCount do
							local cell = self._tableview:GetCellByIndex(i - 1)
							local cellWidth = 0

							if tableViewName == "UITableGrid" then
								cellWidth = self._tableview.gridWidth
							else
								local width, _ = self:_cellSize(self._tableview, cell.index)

								cellWidth = width
							end

							local cellRectTrans = cell:GetComponent(goutil.Type_RectTransform)
							local newCellX = cellStartX + (i - 1) * cellSpacingX + addWidth

							cellRectTrans:SetInsetAndSizeFromParentEdge(UnityEngine.RectTransform.Edge.Left, newCellX, cellWidth)

							addWidth = addWidth + cellWidth
						end
					end
				end
			end
		else
			local cellStartY = (viewSize - contentSize) / 2
			local cellSpacingY = self._tableview.cellSpacing.y
			local isCanMiddle = contentSize <= viewSize

			if isCanMiddle then
				local tableViewName = tolua.typename(self._tableview)
				local curVisibleCount = self._tableview:GetVisibleCount()

				if self._curViewDatas then
					if not #self._curViewDatas then
						local addHeight = 0

						for i = 1, curVisibleCount do
							local cell = self._tableview:GetCellByIndex(i - 1)
							local cellHeight = 0

							if tableViewName == "UITableGrid" then
								cellHeight = self._tableview.gridHeight
							else
								local _, height = self:_cellSize(self._tableview, cell.index)

								cellHeight = height
							end

							local cellRectTrans = cell:GetComponent(goutil.Type_RectTransform)
							local newCellY = cellStartY + (i - 1) * cellSpacingY + addHeight

							cellRectTrans:SetInsetAndSizeFromParentEdge(UnityEngine.RectTransform.Edge.Top, newCellY, cellHeight)

							addHeight = addHeight + cellHeight
						end
					end
				end
			end
		end
	end
end

function ScrollerList:getView()
	return self._tableview
end

function ScrollerList:GetScrollRect()
	if self._scrollRect == nil then
		self._scrollRect = self._scrollerGo:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	end

	if self._scrollRect == nil then
		self._scrollRect = self._scrollerGo:GetComponentInParent(typeof(UnityEngine.UI.ScrollRect))
	end

	return self._scrollRect
end

function ScrollerList:GetContent()
	local scrollRect = self:GetScrollRect()

	if scrollRect then
		return scrollRect.content
	end

	return nil
end

function ScrollerList:updateUnderSlider(sliderAdapter, curValue, scoreList, mystepList)
	self._sliderAdapter = sliderAdapter
	self._curValue = curValue
	self._scoreList = scoreList
	self._myStepList = mystepList

	if not self.reloadFinish then
		return
	end

	local total = 0
	local step = 0
	local offset = 0
	local tableView = self:getView()
	local content = self:GetContent()
	local horizontal = self:GetScrollRect().horizontal
	local vertical = self:GetScrollRect().vertical

	if horizontal and vertical then
		printError("只支持一种方向")

		return
	end

	if horizontal and not vertical then
		step = tableView.gridWidth + tableView.cellSpacing.x
		offset = tableView.cellOffset.x
	end

	if not horizontal and vertical then
		step = tableView.gridHeight + tableView.cellSpacing.y
		offset = tableView.cellOffset.y
	end

	total = (#scoreList - 1) * step + offset

	if (#scoreList - 1) * step + offset == 0 then
		total = 1
	end

	if mystepList == nil then
		local sliderWidth = 0
		local sliderParetWidth = 0
		local sliderLocalPosX = 0
		local sliderLocalStarPosX = 0
		local x, y = Framework.TransformUtil.GetAnchoredPos(sliderAdapter.transform, 0, 0)

		if horizontal then
			sliderWidth = GameUtil.getWidth(sliderAdapter.gameObject)
			sliderParetWidth = GameUtil.getWidth(sliderAdapter.transform.parent.gameObject)
			sliderLocalPosX = x
		else
			sliderWidth = GameUtil.getHeight(sliderAdapter.gameObject)
			sliderLocalPosX = y
			sliderLocalStarPosX = GameUtil.getHeight(sliderAdapter.transform.parent.gameObject) / 2 + sliderLocalPosX - sliderWidth / 2
		end

		local sliderOffestX = GameUtil.getHeight(sliderAdapter.transform.parent.gameObject) / 2 - sliderWidth / 2 + sliderLocalPosX

		total = total - sliderOffestX

		local valueList = {}
		local stepList = {}
		local firstStepValue = (offset - sliderOffestX) / total

		table.insert(valueList, 0)
		table.insert(stepList, 0)

		for i, v in ipairs(scoreList) do
			table.insert(valueList, v)
			table.insert(stepList, firstStepValue + step / total * (i - 1))
		end

		GameUtil.setProgress(sliderAdapter, checknumber(curValue), valueList, stepList)
	else
		local valueList = {}

		table.insert(valueList, 0)

		for i, v in ipairs(scoreList) do
			table.insert(valueList, v)
		end

		GameUtil.setProgress(sliderAdapter, checknumber(curValue), valueList, mystepList)
	end
end

function ScrollerList:_clearTableview(cell)
	if self._clearCellCallBack then
		self._clearCellCallBack(cell)
	end
end

function ScrollerList:closeCircleWithOffset()
	self._circleOffsetState = 0
	self._isOnlyCircleOffsetPos = false
end

function ScrollerList:setOnlyCircleOffsetPos(state)
	self._isOnlyCircleOffsetPos = state
end

function ScrollerList:extendCircleWithOffset(offset, cellContentName)
	self._circleOffsetState = 0
	self._circleOffset = offset
	self._circleCellContentName = cellContentName

	local horizontal = self:GetScrollRect().horizontal
	local vertical = self:GetScrollRect().vertical

	if horizontal and not vertical then
		self._circleOffsetState = circle_horizontal

		if self._isOnlyCircleOffsetPos then
			self._circleOffsetState = circle_horizontal_onlyPos
		end
	end

	if not horizontal and vertical then
		self._circleOffsetState = circle_vertical
	end
end

function ScrollerList:setBeizierOffset(state, points, lineOffset, name)
	self._beizierOffset = state
	self._beizierPoints = points
	self._beizierContentName = name
	self._beizierLineOffset = lineOffset
end

function ScrollerList:setBeizierThrough(points, name)
	local list = {}

	for i, v in ipairs(points) do
		local v3d = Vector3.New()

		v3d.x = checknumber(v.x)
		v3d.y = checknumber(v.y)
		v3d.z = checknumber(v.z)

		table.insert(list, v3d)
	end

	self._bezierState = 0

	local rect = self:GetScrollRect()
	local horizontal = rect.horizontal
	local vertical = rect.vertical

	if horizontal and not vertical then
		self._bezierState = b_horizontal
	end

	if not horizontal and vertical then
		self._bezierState = b_vertical
	end

	if horizontal and vertical then
		self._bezierState = b_horizontal
	end

	self._bezierThroughPoints = GameUtil.bezierThroughPoints(list)
	self._beizierContentName = name
end

function ScrollerList._onScrollValueCircleHorizontalChange(tableview, offsetY, cellContentName)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, _, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local width = goutil.getWidth(viewPortTrans)

	if offsetY == 0 then
		offsetY = 1
	end

	local offsetYABS = math.abs(offsetY)
	local hw = width * 0.5
	local R = offsetYABS + hw * hw / offsetYABS
	local r = R * 0.5
	local a = hw
	local b = -(offsetY / offsetYABS) * r + offsetY
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofx = conX + locx
			local xx = ofx - a
			local ta = math.atan2(-b, xx)
			local yy = r * math.sin(ta) + b
			local angle = math.deg(ta)
			local cellContent = goutil.findChild(cell, cellContentName)

			GameUtil.setLocalPos(cellContent.transform, 0, yy, 0)
			GameUtil.setLocalRotation(cellContent, 0, 0, angle - 90)
		end
	end
end

function ScrollerList._onScrollValueCircleHorizontalOnlyPosChange(tableview, offsetY, cellContentName)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, _, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local width = goutil.getWidth(viewPortTrans)

	if offsetY == 0 then
		offsetY = 1
	end

	local offsetYABS = math.abs(offsetY)
	local hw = width * 0.5
	local R = offsetYABS + hw * hw / offsetYABS
	local r = R * 0.5
	local a = hw
	local b = -(offsetY / offsetYABS) * r + offsetY
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofx = conX + locx
			local xx = ofx - a
			local ta = math.atan2(-b, xx)
			local yy = r * math.sin(ta) + b
			local cellContent = goutil.findChild(cell, cellContentName)

			GameUtil.setLocalPos(cellContent.transform, 0, yy, 0)
		end
	end
end

function ScrollerList._onScrollValueCircleVerticalChange(tableview, offsetX, cellContentName)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local _, conY, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local height = goutil.getHeight(viewPortTrans)

	if offsetX == 0 then
		offsetX = 1
	end

	local offsetXABS = math.abs(offsetX)
	local hh = height * 0.5
	local R = offsetXABS + hh * hh / offsetXABS
	local r = R * 0.5
	local a = -(offsetX / offsetXABS) * r + offsetX
	local b = -hh
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofy = conY + locy
			local yy = ofy - b
			local ta = math.atan2(yy, -a)
			local xx = r * math.cos(ta) + a
			local cellContent = goutil.findChild(cell, cellContentName)

			GameUtil.setLocalPos(cellContent.transform, xx, 0, 0)
		end
	end
end

function ScrollerList._onScrollValueParabolaChange(tableview, offsetA, offsetB, offsetC, cellContentName)
	local content = tableview:GetContent()
	local _, conY, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local yy = locy + conY
			local xx = offsetA * yy * yy + offsetB * yy + offsetC
			local cellContent = goutil.findChild(cell, cellContentName)

			GameUtil.setLocalPos(cellContent.transform, xx, 0, 0)
		end
	end
end

function ScrollerList:isShowFinishCell()
	if self._curViewDatas and self._tableview:GetCellAtIndex(#self._curViewDatas - 1) then
		return true
	end

	return false
end

function ScrollerList:isShowBeginCell()
	if self._tableview:GetCellAtIndex(0) then
		return true
	else
		return false
	end
end

function ScrollerList._onScrollValueBeizierHorizontalChange(tableview, plist, lineOffset, cellContentName)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local contentPos = GameUtil.getAnchoredPos(content)
	local contentWidth, contentHeight = GameUtil.getWidth(content), GameUtil.getHeight(content)
	local conX = contentPos.x + contentWidth / 2
	local conY = contentPos.y - contentHeight / 2
	local width = goutil.getWidth(viewPortTrans)
	local n = #plist - 1
	local comb = GameUtil.precomputeCombination(n)
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local cellPos = GameUtil.getAnchoredPos(cell)
			local locx, locy = cellPos.x, cellPos.y
			local cellWidth, cellHeight = GameUtil.getWidth(cell), GameUtil.getHeight(cell)
			local ofx = conX + locx

			ofx = Mathf.Clamp(ofx, -cellWidth / 2, width + cellWidth)

			local rate = (ofx + cellWidth / 2) / (width + cellWidth)
			local posx, posy = GameUtil.bezierCurveOptimized(plist, rate, comb)
			local xx = posx - (conX + locx)
			local yy = posy - (conY + locy)
			local cellContent = goutil.findChild(cell, cellContentName)

			GameUtil.setAnchoredPos(cellContent, xx + lineOffset, yy)
		end
	end
end

function ScrollerList._onScrollValueBeizierThroughChange(tableview, posList, cellContentName, state)
	local viewPortTrans = tableview:GetViewport().transform
	local total = 1

	if state == 1 then
		total = goutil.getWidth(viewPortTrans)
	elseif state == 2 then
		total = goutil.getHeight(viewPortTrans)
	end

	local count = tableview:GetVisibleCount()
	local v3d = Vector3.New()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local x, y, z = Framework.TransformUtil.GetPos(cell.transform, 0, 0, 0)

			v3d.x = x
			v3d.y = y
			v3d.z = z

			local localPos = viewPortTrans:InverseTransformPoint(v3d)
			local rate = 0

			rate = state == 1 and localPos.x / total or localPos.y / total

			local cellPos = GameUtil.getAnchoredPos(cell)
			local locx, locy = cellPos.x, cellPos.y

			GameUtil.SetActive(cell, rate <= 1)

			rate = Mathf.Clamp(rate, 0, 1)

			local point = GameUtil.getBezierThroughCurPoint(rate, posList)

			if point then
				local worldSpacePosition = viewPortTrans:TransformPoint(point)
				local pos = cell.gameObject.transform:InverseTransformPoint(worldSpacePosition)
				local cellContent = goutil.findChild(cell, cellContentName)

				GameUtil.setLocalPos(cellContent, pos.x, pos.y)
			end
		end
	end
end

return ScrollerList
