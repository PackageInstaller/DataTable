-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiGameMo.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiGameMo", package.seeall)

local YeShuMeiGameMo = class("YeShuMeiGameMo", YeShuMeiLevelMo)

function YeShuMeiGameMo.create(id)
	local instance = YeShuMeiGameMo.New()

	instance.id = id

	return instance
end

function YeShuMeiGameMo:_initPoint(data)
	if data.points ~= nil then
		for _, pointData in pairs(data.points) do
			self.points[pointData.id] = YeShuMeiPointMo.New(pointData)
		end
	end
end

function YeShuMeiGameMo:getAllPoint()
	return self.points
end

function YeShuMeiGameMo:getAllLine()
	return self.lines
end

function YeShuMeiGameMo:getPointById(id)
	if self.points == nil then
		return nil
	end

	return self.points[id]
end

function YeShuMeiGameMo:getPointByConfigId(configId)
	if self.points == nil then
		return nil
	end

	for _, point in pairs(self.points) do
		if point.configId == configId then
			return point
		end
	end

	return nil
end

function YeShuMeiGameMo:haveLine(pointIdA, pointIdB)
	if self.lines == nil then
		return false
	end

	for _, line in pairs(self.lines) do
		if line:havePoint(pointIdA, pointIdB) then
			return true
		end
	end

	return false
end

function YeShuMeiGameMo:checkLineExist(beginPointId, endPointId)
	if self.lines == nil then
		return false
	end

	for _, linemo in ipairs(self.lines) do
		if linemo:havePoint(beginPointId, endPointId) then
			return true
		end
	end

	return false
end

function YeShuMeiGameMo:setOrderIndex()
	self:_initOrder()

	self._curOrderIndex = 1

	local orderstr = self.orders[self._curOrderIndex]

	self:_initCurrentOrder(orderstr)
end

function YeShuMeiGameMo:_initCurrentOrder(orderstr)
	self._sequenceOrder = string.splitToNumber(orderstr, "#")
	self._reverseOrder = self:_getReverseOrder(self._sequenceOrder)
end

function YeShuMeiGameMo:_initOrder()
	if self.orderstr ~= nil then
		self.orders = string.split(self.orderstr, "|")
	end
end

function YeShuMeiGameMo:_getReverseOrder(order)
	local list = {}

	for i = #order, 1, -1 do
		list[#list + 1] = order[i]
	end

	return list
end

function YeShuMeiGameMo:getStartPointIds()
	if not self._sequenceOrder or #self._sequenceOrder < 0 then
		return
	end

	return {
		self._sequenceOrder[1],
		self._reverseOrder[1]
	}
end

function YeShuMeiGameMo:getCurrentStartOrder(pointId)
	if not self._sequenceOrder or #self._sequenceOrder < 0 then
		return
	end

	if pointId == self._sequenceOrder[1] then
		return self._sequenceOrder
	elseif pointId == self._reverseOrder[1] then
		return self._reverseOrder
	end
end

function YeShuMeiGameMo:destroy()
	if self.points ~= nil then
		for _, point in pairs(self.points) do
			if point then
				point:destroy()
			end
		end

		self.points = nil
	end
end

return YeShuMeiGameMo
