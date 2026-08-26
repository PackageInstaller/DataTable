-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiLineItem.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiLineItem", package.seeall)

local YeShuMeiLineItem = class("YeShuMeiLineItem", LuaCompBase)

function YeShuMeiLineItem:init(go)
	self.go = go
	self._tr = go.transform

	gohelper.setActive(self.go, false)

	self._godisturb = gohelper.findChild(go, "#go_disturb")
	self._goconnected = gohelper.findChild(go, "#go_connected")
end

function YeShuMeiLineItem:addEventListeners()
	return
end

function YeShuMeiLineItem:removeEventListeners()
	return
end

function YeShuMeiLineItem:initData(data)
	self._mo = data
	self.id = data.id

	self:updateUI()
end

function YeShuMeiLineItem:updateUI()
	local iswrong = self._mo:getState() ~= YeShuMeiEnum.StateType.Noraml

	gohelper.setActive(self._goconnected, not iswrong)
	gohelper.setActive(self._godisturb, iswrong)
end

function YeShuMeiLineItem:updatePoint(point1, point2)
	self._point1 = point1
	self._point2 = point2

	self:updateByPoint()
end

function YeShuMeiLineItem:addPoint(point)
	if self._point1 == nil then
		self._point1 = point
	end

	if self._point2 == nil and self._point1.id ~= point.id then
		self._point2 = point
	end

	self:updateByPoint()
end

function YeShuMeiLineItem:updateByPoint()
	if self._point1 ~= nil and self._point2 ~= nil then
		local pos1X, pos1Y = self._point1:getLocalPos()
		local pos2X, pos2Y = self._point2:getLocalPos()

		self:updateItem(pos1X, pos1Y, pos2X, pos2Y)
		self._mo:updatePos(pos1X, pos1Y, pos2X, pos2Y)
		self._mo:updatePoint(self._point1.id, self._point2.id)
	end
end

function YeShuMeiLineItem:updateItem(beginX, beginY, endX, endY)
	transformhelper.setLocalPosXY(self._tr, beginX, beginY)

	local width = MathUtil.vec2_length(beginX, beginY, endX, endY)

	recthelper.setWidth(self._tr, width)

	local angle = MathUtil.calculateV2Angle(endX, endY, beginX, beginY)

	transformhelper.setEulerAngles(self._tr, 0, 0, angle)
end

function YeShuMeiLineItem:onDestroy()
	gohelper.destroy(self.go)
end

return YeShuMeiLineItem
