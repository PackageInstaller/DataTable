-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_TalentMo.lua

module("modules.logic.rouge2.outside.model.Rouge2_TalentMo", package.seeall)

local Rouge2_TalentMo = pureTable("Rouge2_TalentMo")

function Rouge2_TalentMo:init(id, config)
	self.id = id
	self.config = config and config or Rouge2_OutSideConfig.instance:getTalentConfigById(id)
	self.isActive = false
end

return Rouge2_TalentMo
