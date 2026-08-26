-- chunkname: @modules/logic/rouge/model/rpcmo/RougeBattleHeroMO.lua

module("modules.logic.rouge.model.rpcmo.RougeBattleHeroMO", package.seeall)

local RougeBattleHeroMO = pureTable("RougeBattleHeroMO")

function RougeBattleHeroMO:init(info)
	self.index = info.index
	self.heroId = info.heroId
	self.equipUid = info.equipUid
	self.supportHeroId = info.supportHeroId
	self.supportHeroSkill = info.supportHeroSkill
end

return RougeBattleHeroMO
