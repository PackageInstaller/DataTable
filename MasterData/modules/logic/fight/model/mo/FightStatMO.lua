-- chunkname: @modules/logic/fight/model/mo/FightStatMO.lua

module("modules.logic.fight.model.mo.FightStatMO", package.seeall)

local FightStatMO = pureTable("FightStatMO")

function FightStatMO:init(info)
	self.entityId = info.heroUid
	self.harm = tonumber(info.harm)
	self.hurt = tonumber(info.hurt)
	self.heal = tonumber(info.heal)
	self.cards = {}

	for i, v in ipairs(info.cards) do
		local tab = {}

		tab.skillId = v.skillId
		tab.useCount = v.useCount

		table.insert(self.cards, tab)
	end
end

return FightStatMO
