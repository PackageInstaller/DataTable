-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameTeamMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameTeamMo", package.seeall)

local MatchGameTeamMo = pureTable("MatchGameTeamMo")

function MatchGameTeamMo:init(info)
	self.index = info.index
	self.heroIds = info.heroId
end

return MatchGameTeamMo
