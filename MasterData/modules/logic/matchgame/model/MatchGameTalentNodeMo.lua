-- chunkname: @modules/logic/matchgame/model/MatchGameTalentNodeMo.lua

module("modules.logic.matchgame.model.MatchGameTalentNodeMo", package.seeall)

local MatchGameTalentNodeMo = pureTable("MatchGameTalentNodeMo")

function MatchGameTalentNodeMo:init(info)
	self.nodeId = info.nodeId
	self.nodeCo = lua_activity244_talent.configDict[self.nodeId]
	self.status = MatchGameEnum.TalentNodeStatus.Lock
	self.branchType = self.nodeCo and self.nodeCo.branch
	self.costList = string.splitToNumber(self.nodeCo.costItemId, "#")
end

function MatchGameTalentNodeMo:updateInfo(info)
	self.status = MatchGameEnum.TalentNodeStatus.Lock
end

return MatchGameTalentNodeMo
