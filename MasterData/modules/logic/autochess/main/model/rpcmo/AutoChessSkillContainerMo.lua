-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessSkillContainerMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessSkillContainerMo", package.seeall)

local AutoChessSkillContainerMo = pureTable("AutoChessSkillContainerMo")

function AutoChessSkillContainerMo:init(data)
	self.skills = GameUtil.rpcInfosToList(data.skills, AutoChessSkillMo)
end

return AutoChessSkillContainerMo
