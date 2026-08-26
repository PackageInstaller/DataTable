-- chunkname: @modules/logic/rouge/model/rpcmo/RougeHeroLifeMO.lua

module("modules.logic.rouge.model.rpcmo.RougeHeroLifeMO", package.seeall)

local RougeHeroLifeMO = pureTable("RougeHeroLifeMO")

function RougeHeroLifeMO:init(info)
	self.heroId = info.heroId
	self.life = info.life
end

function RougeHeroLifeMO:update(info)
	self.heroId = info.heroId
	self.life = info.life
end

return RougeHeroLifeMO
