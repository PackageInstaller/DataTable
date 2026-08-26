-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianLevelMo.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianLevelMo", package.seeall)

local LuSiJianLevelMo = class("LuSiJianLevelMo")

function LuSiJianLevelMo:ctor(id)
	self.id = id
	self.points = {}
	self.lines = {}
	self.orders = {}
	self._curOrderIndex = 1
end

function LuSiJianLevelMo:init(data)
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

function LuSiJianLevelMo:_initPoint(data)
	if data.points ~= nil then
		for _, pointData in pairs(data.points) do
			local point = YeShuMeiPointMo.New(pointData)

			point:updatePos(pointData.posX, pointData.posY)
			table.insert(self.points, point)
		end
	end
end

return LuSiJianLevelMo
