-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueHeroLifeMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueHeroLifeMO", package.seeall)

local RogueHeroLifeMO = pureTable("RogueHeroLifeMO")

function RogueHeroLifeMO:init(info)
	self.heroId = info.heroId
	self.life = info.life
	self.lifePercent = info.life / 10
end

return RogueHeroLifeMO
