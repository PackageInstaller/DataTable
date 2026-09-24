-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameTalentMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameTalentMo", package.seeall)

local MatchGameTalentMo = pureTable("MatchGameTalentMo")

function MatchGameTalentMo:init(info)
	self.talentId = info.talentId
	self.talentCo = lua_activity244_talent.configDict[self.talentId]
	self.skillId = self.talentCo and self.talentCo.skillId
end

return MatchGameTalentMo
