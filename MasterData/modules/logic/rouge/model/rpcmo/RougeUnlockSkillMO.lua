-- chunkname: @modules/logic/rouge/model/rpcmo/RougeUnlockSkillMO.lua

module("modules.logic.rouge.model.rpcmo.RougeUnlockSkillMO", package.seeall)

local RougeUnlockSkillMO = pureTable("RougeUnlockSkillMO")

function RougeUnlockSkillMO:init(info)
	self.type = info.type
	self.idMap = self:_listToMap(info.ids)
end

function RougeUnlockSkillMO:_listToMap(list)
	if not list then
		return {}
	end

	local map = {}

	for _, v in ipairs(list) do
		map[v] = v
	end

	return map
end

function RougeUnlockSkillMO:isSkillUnlock(skillId)
	return self.idMap and self.idMap[skillId] ~= nil
end

function RougeUnlockSkillMO:onNewSkillUnlock(skillId)
	if not skillId then
		return
	end

	self.idMap[skillId] = true
end

return RougeUnlockSkillMO
