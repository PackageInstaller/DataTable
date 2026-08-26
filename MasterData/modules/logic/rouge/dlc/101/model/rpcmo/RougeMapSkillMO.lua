-- chunkname: @modules/logic/rouge/dlc/101/model/rpcmo/RougeMapSkillMO.lua

module("modules.logic.rouge.dlc.101.model.rpcmo.RougeMapSkillMO", package.seeall)

local RougeMapSkillMO = pureTable("RougeMapSkillMO")

function RougeMapSkillMO:init(info)
	self.id = info.id
	self.useCount = info.useCount
	self.stepRecord = info.stepRecord
end

function RougeMapSkillMO:getUseCount()
	return self.useCount
end

function RougeMapSkillMO:getStepRecord()
	return self.stepRecord
end

return RougeMapSkillMO
