-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiLevelMo.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiLevelMo", package.seeall)

local YeShuMeiLevelMo = class("YeShuMeiLevelMo", YeShuMeiLevelMo)

function YeShuMeiLevelMo:ctor(id)
	self.id = id
	self.points = {}
	self.lines = {}
	self.orders = {}
	self._curOrderIndex = 1
end

function YeShuMeiLevelMo:init(data)
	if data == nil then
		return
	end

	self.id = data.id
	self.orderstr = data.orderstr

	if self.orderstr ~= nil then
		self.orders = string.split(self.orderstr, "|")
	end

	self:_initPoint(data)
	self:_initLine(data)
end

function YeShuMeiLevelMo:_initPoint(data)
	if data.points ~= nil then
		for _, pointData in pairs(data.points) do
			local point = YeShuMeiPointMo.New(pointData)

			point:updatePos(pointData.posX, pointData.posY)
			table.insert(self.points, point)
		end
	end
end

function YeShuMeiLevelMo:_initLine(data)
	if data.lines ~= nil then
		for _, lineData in pairs(data.lines) do
			local line = YeShuMeiLineMo.New(lineData.id)

			line:updatePos(lineData.beginPosX, lineData.beginPosY, lineData.endPosX, lineData.endPosY)
			line:updatePoint(lineData.beginPointId, lineData.endPointId)
			table.insert(self.lines, line)
		end
	end
end

function YeShuMeiLevelMo:getStr()
	local str = string.format("id = %d ,", self.id)

	if self.points ~= nil then
		str = str .. "points = { "

		for _, point in pairs(self.points) do
			str = str .. "{ " .. point:getStr() .. " }, "
		end

		str = str .. "}, "
	end

	if self.lines ~= nil then
		str = str .. "lines = { "

		for _, line in pairs(self.lines) do
			str = str .. "{ " .. line:getStr() .. " }, "
		end

		str = str .. "}, "
	end

	if self.orders ~= nil and #self.orders > 0 then
		local orderstr = ""
		local count = #self.orders

		if count > 1 then
			for i = 1, count - 1 do
				orderstr = self.orders[i] .. "|" .. self.orders[i + 1]
			end
		else
			orderstr = self.orders[1]
		end

		str = str .. string.format("orderstr = '%s' ,", orderstr)
	end

	return str
end

return YeShuMeiLevelMo
