-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessTurnMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessTurnMo", package.seeall)

local AutoChessTurnMo = pureTable("AutoChessTurnMo")

function AutoChessTurnMo:init(data)
	self.step = GameUtil.rpcInfosToList(data.step, AutoChessFightStepMo)
end

return AutoChessTurnMo
