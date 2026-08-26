-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiView.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiView", package.seeall)

local GMYeShuMeiView = class("GMYeShuMeiView", BaseView)

function GMYeShuMeiView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "btnroot/#btn_add")
	self._btnaddline = gohelper.findChildButtonWithAudio(self.viewGO, "btnroot/#btn_addline")
	self._btnload = gohelper.findChildButtonWithAudio(self.viewGO, "btnroot/#btn_load")
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "btnroot/#btn_save")
	self._nodeRoot = gohelper.findChild(self.viewGO, "noderoot")
	self._gonode = gohelper.findChild(self.viewGO, "noderoot/#go_node")
	self._lineRoot = gohelper.findChild(self.viewGO, "lineroot")
	self._goline = gohelper.findChild(self.viewGO, "lineroot/#go_line")
	self._orderRoot = gohelper.findChild(self.viewGO, "btnroot/orderroot")
	self._goorder = gohelper.findChild(self.viewGO, "btnroot/orderroot/orderitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._inpActId = gohelper.findChildInputField(self.viewGO, "btnroot/input/Input_actId")
	self._inpLineOrder = gohelper.findChildInputField(self.viewGO, "btnroot/orderinput/Input_order")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMYeShuMeiView:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnload:AddClickListener(self._btnloadOnClick, self)
	self._btnsave:AddClickListener(self._btnsaveOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnaddline:AddClickListener(self._btnaddlineOnClick, self)
end

function GMYeShuMeiView:removeEvents()
	self._btnadd:RemoveClickListener()
	self._btnload:RemoveClickListener()
	self._btnsave:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnaddline:RemoveClickListener()
end

function GMYeShuMeiView:_btncloseOnClick()
	self:closeThis()
end

function GMYeShuMeiView:_btnaddOnClick()
	if not self._curLevelData then
		return
	end

	local point
	local mo = GMYeShuMeiModel.instance:addPoint()

	if not mo then
		return
	end

	if self.pointItems == nil then
		self.pointItems = self:getUserDataTb_()
	end

	point = self:createPoint(mo.id)

	if point and mo then
		point.comp:updateInfo(mo)
	end
end

function GMYeShuMeiView:_btnaddlineOnClick()
	local orderstr = self._inpLineOrder:GetText()

	if not self._curLevelData then
		return
	end

	if not GMYeShuMeiModel.instance:addOrders(orderstr) then
		return
	end

	if self.orderItems == nil then
		self.orderItems = self:getUserDataTb_()
	end

	local order = self:createOrder()

	if order and orderstr then
		order.comp:initOrder(orderstr)
	end

	self:switchOrder(orderstr)
end

function GMYeShuMeiView:_btnloadOnClick()
	local levelId = tonumber(self._inpActId:GetText())

	self._curLevelData = GMYeShuMeiModel.instance:setCurLevelId(levelId)

	self:refreshView()
end

function GMYeShuMeiView:_btnsaveOnClick()
	GMYeShuMeiModel.instance:saveAndExport()
end

function GMYeShuMeiView:_editableInitView()
	return
end

function GMYeShuMeiView:onUpdateParam()
	return
end

function GMYeShuMeiView:onOpen()
	return
end

function GMYeShuMeiView:refreshView()
	if self._curLevelData == nil then
		return
	end

	self:_clearLine()
	self:_initPoint()
	self:_initLine()
	self:_initOrder()
end

function GMYeShuMeiView:_initOrder()
	local initOrderData = string.split(self._curLevelData.orderstr, "|")

	if self.orderItems == nil then
		self.orderItems = self:getUserDataTb_()

		for _, orderstr in ipairs(initOrderData) do
			GMYeShuMeiModel.instance:addOrders(orderstr)

			local order = self:createOrder()

			order.comp:initOrder(orderstr)
		end

		self:switchOrder(initOrderData[1])
	else
		for _, order in ipairs(self.orderItems) do
			order.comp:onDestroy()
		end

		tabletool.clear(self.orderItems)

		for index, orderstr in ipairs(initOrderData) do
			local order = self.orderItems[index]

			order = order or self:createOrder()

			order.comp:initOrder(orderstr)
		end
	end
end

function GMYeShuMeiView:createOrder()
	local order = self:getUserDataTb_()

	order.go = gohelper.clone(self._goorder, self._orderRoot, "order")
	order.comp = MonoHelper.addNoUpdateLuaComOnceToGo(order.go, GMYeShuMeiOrder)

	order.comp:addDeleteCb(self.deleteOrder, self)
	order.comp:addSwitchCb(self.switchOrder, self)
	table.insert(self.orderItems, order)

	return order
end

function GMYeShuMeiView:deleteOrder(orderstr)
	for index, order in ipairs(self.orderItems) do
		if order.comp:getOrder() == orderstr then
			GMYeShuMeiModel.instance:deleteOrders(orderstr)
			order.comp:onDestroy()
			table.remove(self.orderItems, index)

			if #self.orderItems > 0 then
				GMYeShuMeiModel.instance:setCurLevelOrder(self.orderItems[1].comp:getOrder())
				self:switchOrder(self.orderItems[1].comp:getOrder())
			end
		end
	end
end

function GMYeShuMeiView:switchOrder(orderstr)
	GMYeShuMeiModel.instance:setCurLevelOrder(orderstr)

	local orderList = string.splitToNumber(orderstr, "#")
	local count = #orderList

	self:_clearLine()

	for i = 1, count - 1 do
		local beginPoint = self:getPointById(orderList[i])
		local endPoint = self:getPointById(orderList[i + 1])

		if not beginPoint then
			logError("请检查节点" .. orderList[i])

			return
		end

		if not endPoint then
			logError("请检查节点" .. orderList[i + 1])

			return
		end

		if beginPoint and endPoint and not GMYeShuMeiModel.instance:checkLineExist(beginPoint.id, endPoint.id) then
			local roundData = GMYeShuMeiModel.instance:addLines()
			local line = self:createLine(roundData.id)

			line:initData(roundData)
			line:updatePoint(beginPoint, endPoint)

			self._lineItem[roundData.id] = line
		end
	end

	self:_refreshOrder()
end

function GMYeShuMeiView:_refreshOrder()
	for index, order in ipairs(self.orderItems) do
		order.comp:updateOrder()
	end
end

function GMYeShuMeiView:_initPoint()
	local initPointData = self._curLevelData.points

	if self.pointItems == nil then
		self.pointItems = self:getUserDataTb_()

		for index, pointCo in ipairs(initPointData) do
			local point = self:createPoint(index)

			point.comp:updateInfo(pointCo)
		end
	else
		for _, point in ipairs(self.pointItems) do
			point.comp:onDestroy()
		end

		tabletool.clear(self.pointItems)

		for index, pointCo in ipairs(initPointData) do
			local point = self.pointItems[index]

			point = point or self:createPoint(index)

			point.comp:updateInfo(pointCo)
		end
	end
end

function GMYeShuMeiView:createPoint(index)
	local point = self:getUserDataTb_()

	point.go = gohelper.clone(self._gonode, self._nodeRoot, "point" .. index)
	point.comp = MonoHelper.addNoUpdateLuaComOnceToGo(point.go, GMYeShuMeiPoint)

	table.insert(self.pointItems, point)
	point.comp:addDeleteCb(self.deletePoint, self)
	point.comp:addRefreshLineCb(self.refreshAllLine, self)

	return point
end

function GMYeShuMeiView:deletePoint(pointId)
	for _, lineItem in pairs(self._lineItem) do
		if lineItem._point1 and lineItem._point1.id == pointId or lineItem._point2 and lineItem._point2.id == pointId then
			lineItem:onDestroy()
			self:deleteLines(lineItem._lineData.id)
		end
	end

	GMYeShuMeiModel.instance:deletePoint(pointId)

	for index, point in ipairs(self.pointItems) do
		if point.comp:checkPointId(pointId) then
			point.comp:onDestroy()
			table.remove(self.pointItems, index)
		end
	end
end

function GMYeShuMeiView:_initLine()
	self._lineItem = self:getUserDataTb_()

	local allLines = self._curLevelData.lines

	if self._lineItem ~= nil then
		for _, v in pairs(self._lineItem) do
			v:onDestroy()
		end

		tabletool.clear(self._lineItem)
	else
		self._lineItem = self:getUserDataTb_()
	end

	for i = 1, #allLines do
		local roundData = allLines[i]

		if roundData ~= nil then
			local line = self:createLine(roundData.id)

			line:initData(roundData)

			local beginPoint = self:getPointById(roundData._beginPointId)
			local endPoint = self:getPointById(roundData._endPointId)

			line:updatePoint(beginPoint, endPoint)

			self._lineItem[roundData.id] = line
		end
	end
end

function GMYeShuMeiView:createLine(id)
	if not self._curLevelData then
		return
	end

	local go = gohelper.clone(self._goline, self._lineRoot, "line" .. id)
	local line = MonoHelper.addNoUpdateLuaComOnceToGo(go, GMYeShuMeiLine)

	gohelper.setActive(go, true)
	line:addAddCb(self.relyAddLine, self)
	line:addGetIndexCb(self.getIndexOfLine, self)

	return line
end

function GMYeShuMeiView:deleteLines(id)
	if self._lineItem[id] ~= nil then
		self._lineItem[id]:onDestroy()

		self._lineItem[id] = nil
	end

	self:refreshAllLine()
end

function GMYeShuMeiView:getIndexOfLine(id)
	if not self._lineItem or #self._lineItem == 0 then
		return
	end

	local count = 0

	for _, line in pairs(self._lineItem) do
		count = count + 1

		if id == line._lineData.id then
			return count
		end
	end
end

function GMYeShuMeiView:relyAddLine(line)
	if self._lineItem == nil then
		self._lineItem = self:getUserDataTb_()
	end

	self._lineItem[line._lineData.id] = line
end

function GMYeShuMeiView:getPointById(pointId)
	for _, pointData in pairs(self.pointItems) do
		if pointData.comp.id == pointId then
			return pointData.comp
		end
	end

	return nil
end

function GMYeShuMeiView:refreshAllLine()
	if self._lineItem and #self._lineItem > 0 then
		for _, lineItem in pairs(self._lineItem) do
			if lineItem then
				lineItem:updateByPoint()
			end
		end
	end
end

function GMYeShuMeiView:_clearLine()
	if self._lineItem and #self._lineItem > 0 then
		for index, line in pairs(self._lineItem) do
			line:onDestroy()
		end

		tabletool.clear(self._lineItem)
	end
end

function GMYeShuMeiView:onClose()
	GMYeShuMeiModel.instance:clearData()

	if self.pointItems and #self.pointItems > 0 then
		for index, point in ipairs(self.pointItems) do
			point.comp:onDestroy()
		end
	end

	self:_clearLine()
end

function GMYeShuMeiView:onDestroyView()
	return
end

return GMYeShuMeiView
