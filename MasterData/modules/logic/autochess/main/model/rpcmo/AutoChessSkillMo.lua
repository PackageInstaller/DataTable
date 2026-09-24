-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessSkillMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessSkillMo", package.seeall)

local AutoChessSkillMo = pureTable("AutoChessSkillMo")

function AutoChessSkillMo:init(data)
	self.skillId = data.skillId
end

return AutoChessSkillMo
