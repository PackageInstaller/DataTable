-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessMasterSkillMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessMasterSkillMo", package.seeall)

local AutoChessMasterSkillMo = pureTable("AutoChessMasterSkillMo")

function AutoChessMasterSkillMo:init(data)
	self.id = data.id
	self.unlock = data.unlock
	self.abilities = GameUtil.rpcInfosToList(data.abilities, AutoChessMasterAbilityMo)
	self.roundUseCounts = GameUtil.rpcInfosToList(data.roundUseCounts, AutoChessSkillRoundUseCountMo)
	self.canUse = data.canUse

	if self.id ~= 0 then
		self.config = AutoChessConfig.instance:getLeaderSkillCfg(self.id)
	end
end

return AutoChessMasterSkillMo
