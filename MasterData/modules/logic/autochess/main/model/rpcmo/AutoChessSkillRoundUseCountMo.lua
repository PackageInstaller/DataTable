-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessSkillRoundUseCountMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessSkillRoundUseCountMo", package.seeall)

local AutoChessSkillRoundUseCountMo = pureTable("AutoChessSkillRoundUseCountMo")

function AutoChessSkillRoundUseCountMo:init(data)
	self.round = data.round
	self.count = data.count
end

return AutoChessSkillRoundUseCountMo
