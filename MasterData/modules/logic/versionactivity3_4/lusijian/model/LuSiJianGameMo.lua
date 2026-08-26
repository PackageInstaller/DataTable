-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianGameMo.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianGameMo", package.seeall)

local LuSiJianGameMo = class("LuSiJianGameMo")

function LuSiJianGameMo:ctor(id)
	self.id = id
	self.points = {}
	self.orders = {}
	self._curOrderIndex = 1
end

function LuSiJianGameMo:init(data)
	if data == nil then
		return
	end

	self.id = data.id
	self.orderstr = data.orderstr

	if self.orderstr ~= nil then
		self.orders = string.split(self.orderstr, "|")
	end

	self:_initPoint(data)
end

function LuSiJianGameMo:_initPoint(data)
	if data.points ~= nil then
		for _, pointData in pairs(data.points) do
			self.points[pointData.id] = LuSiJianPointMo.New(pointData)
		end
	end
end

function LuSiJianGameMo:getAllPoint()
	return self.points
end

function LuSiJianGameMo:getPointById(id)
	if self.points == nil then
		return nil
	end

	return self.points[id]
end

function LuSiJianGameMo:getPointByConfigId(configId)
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

function LuSiJianGameMo:setOrderIndex()
	self:_initOrder()

	self._curOrderIndex = 1

	local orderstr = self.orders[self._curOrderIndex]

	self:_initCurrentOrder(orderstr)
end

function LuSiJianGameMo:_initCurrentOrder(orderstr)
	self._sequenceOrder = string.splitToNumber(orderstr, "#")
	self._reverseOrder = self:_getReverseOrder(self._sequenceOrder)
end

function LuSiJianGameMo:_initOrder()
	if self.orderstr ~= nil then
		self.orders = string.split(self.orderstr, "|")
	end
end

function LuSiJianGameMo:_getReverseOrder(order)
	local list = {}

	for i = #order, 1, -1 do
		list[#list + 1] = order[i]
	end

	return list
end

function LuSiJianGameMo:getStartPointIds()
	if not self._sequenceOrder or #self._sequenceOrder < 0 then
		return
	end

	return {
		self._sequenceOrder[1],
		self._reverseOrder[1]
	}
end

function LuSiJianGameMo:getCurrentStartOrder(pointId)
	if not self._sequenceOrder or #self._sequenceOrder < 0 then
		return
	end

	if pointId == self._sequenceOrder[1] then
		return self._sequenceOrder
	elseif pointId == self._reverseOrder[1] then
		return self._reverseOrder
	end
end

function LuSiJianGameMo:destroy()
	if self.points ~= nil then
		for _, point in pairs(self.points) do
			if point then
				point:destroy()
			end
		end

		self.points = nil
	end
end

return LuSiJianGameMo
