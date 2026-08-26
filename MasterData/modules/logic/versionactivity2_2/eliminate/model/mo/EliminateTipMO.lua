-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/EliminateTipMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateTipMO", package.seeall)

local EliminateTipMO = class("EliminateTipMO")

function EliminateTipMO:ctor()
	self.from = {}
	self.to = {}
	self.eliminate = {}
end

function EliminateTipMO:updateInfoByServer(info)
	if info == nil or info.from == nil then
		return
	end

	self.from.x = info.from.x + 1
	self.from.y = info.from.y + 1
	self.to.x = info.to.x + 1
	self.to.y = info.to.y + 1

	tabletool.clear(self.eliminate)

	local eliminate = info.eliminate

	if eliminate then
		for _, v in ipairs(eliminate.coordinate) do
			self.eliminate[#self.eliminate + 1] = v.x + 1
			self.eliminate[#self.eliminate + 1] = v.y + 1
		end
	end
end

function EliminateTipMO:getEliminateCount()
	return tabletool.len(self.eliminate)
end

return EliminateTipMO
