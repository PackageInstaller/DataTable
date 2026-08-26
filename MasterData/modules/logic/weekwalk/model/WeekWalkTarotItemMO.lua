-- chunkname: @modules/logic/weekwalk/model/WeekWalkTarotItemMO.lua

module("modules.logic.weekwalk.model.WeekWalkTarotItemMO", package.seeall)

local WeekWalkTarotItemMO = pureTable("WeekWalkTarotItemMO")

function WeekWalkTarotItemMO:init(buffId, type, heroId)
	self.tarotId = buffId
	self.type = type
	self.heroId = heroId
end

return WeekWalkTarotItemMO
