-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessMasterAbilityMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessMasterAbilityMo", package.seeall)

local AutoChessMasterAbilityMo = pureTable("AutoChessMasterAbilityMo")

function AutoChessMasterAbilityMo:init(data)
	self.type = data.type
	self.extraInt1 = data.extraInt1
	self.extraInt2 = data.extraInt2
	self.extraStr = data.extraStr
end

return AutoChessMasterAbilityMo
