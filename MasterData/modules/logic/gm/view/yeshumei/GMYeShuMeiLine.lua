-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiLine.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiLine", package.seeall)

local GMYeShuMeiLine = class("GMYeShuMeiLine", LuaCompBase)

function GMYeShuMeiLine:init(go)
	self.go = go
	self._tr = go.transform
	self._btnDelete = gohelper.findChildButton(go, "btn/btn_delete")
	self._txtname = gohelper.findChildText(go, "#txt_name")
end

function GMYeShuMeiLine:addEventListeners()
	self._btnDelete:AddClickListener(self._onDeleteClick, self)
end

function GMYeShuMeiLine:removeEventListeners()
	self._btnDelete:RemoveClickListener()
end

function GMYeShuMeiLine:_onDeleteClick()
	if self._point2 == nil or self._point1 == nil and GMYeShuMeiModel.instance:getCurLine() ~= nil then
		self:onDestroy()
		GMYeShuMeiModel.instance:deleteLines(self._lineData.id)
		GMYeShuMeiModel.instance:setCurLine(nil)

		return
	end

	if self._lineData == nil then
		return
	end

	local id = self._lineData.id

	GMYeShuMeiModel.instance:deleteLines(id)

	if self._deleteCb ~= nil then
		self._deleteCb(self._deleteObj, id)
	end
end

function GMYeShuMeiLine:initData(data)
	self._lineData = data
	self.id = data.id
end

function GMYeShuMeiLine:updatePoint(point1, point2)
	self._point1 = point1
	self._point2 = point2

	self:updateByPoint()
end

function GMYeShuMeiLine:addPoint(point)
	if self._point1 == nil then
		self._point1 = point
	end

	if self._point2 == nil and self._point1.id ~= point.id then
		self._point2 = point
	end

	self:updateByPoint()

	if self._point1 ~= nil and self._point2 ~= nil then
		if self._okCb ~= nil then
			self._okCb(self._okObj, self)
		end

		GMYeShuMeiModel.instance:setCurLine(nil)
	end
end

function GMYeShuMeiLine:updateByPoint()
	if self._point1 ~= nil and self._point2 ~= nil then
		local pos1X, pos1Y = self._point1:getLocalPos()
		local pos2X, pos2Y = self._point2:getLocalPos()

		self:updateItem(pos1X, pos1Y, pos2X, pos2Y)
		self._lineData:updatePos(pos1X, pos1Y, pos2X, pos2Y)
		self._lineData:updatePoint(self._point1.id, self._point2.id)

		local index = self._getIndexCb(self._getIndexObj, self._lineData.id)

		self._txtname.text = string.format("%s - %s", self._point1.id, self._point2.id)
	end
end

function GMYeShuMeiLine:addDeleteCb(cb, obj)
	self._deleteCb = cb
	self._deleteObj = obj
end

function GMYeShuMeiLine:addAddCb(cb, obj)
	self._okCb = cb
	self._okObj = obj
end

function GMYeShuMeiLine:addGetIndexCb(cb, obj)
	self._getIndexCb = cb
	self._getIndexObj = obj
end

function GMYeShuMeiLine:updateItem(beginX, beginY, endX, endY)
	transformhelper.setLocalPosXY(self._tr, beginX, beginY)

	local width = MathUtil.vec2_length(beginX, beginY, endX, endY)

	recthelper.setWidth(self._tr, width)

	local angle = MathUtil.calculateV2Angle(endX, endY, beginX, beginY)

	transformhelper.setEulerAngles(self._tr, 0, 0, angle)

	local index = self._getIndexCb(self._getIndexObj, self._lineData.id)

	self._txtname.text = string.format("%s - %s", self._point1.id, self._point2.id)
end

function GMYeShuMeiLine:onDestroy()
	gohelper.destroy(self.go)
	GMYeShuMeiModel.instance:deleteLines(self.id)
end

return GMYeShuMeiLine
