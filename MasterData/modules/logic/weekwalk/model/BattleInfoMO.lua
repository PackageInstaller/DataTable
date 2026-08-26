-- chunkname: @modules/logic/weekwalk/model/BattleInfoMO.lua

module("modules.logic.weekwalk.model.BattleInfoMO", package.seeall)

local BattleInfoMO = pureTable("BattleInfoMO")

function BattleInfoMO:init(info)
	self.battleId = info.battleId
	self.star = info.star
	self.maxStar = info.maxStar
	self.heroIds = {}
	self.heroGroupSelect = info.heroGroupSelect or 0
	self.elementId = info.elementId

	for i, v in ipairs(info.heroIds) do
		table.insert(self.heroIds, v)
	end
end

function BattleInfoMO:setIndex(index)
	self.index = index
end

return BattleInfoMO
