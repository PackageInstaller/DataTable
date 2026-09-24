-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessFightStepMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessFightStepMo", package.seeall)

local AutoChessFightStepMo = pureTable("AutoChessFightStepMo")

function AutoChessFightStepMo:init(data)
	self.actionType = data.actionType
	self.reasonId = data.reasonId
	self.fromId = data.fromId
	self.toId = data.toId
	self.effect = GameUtil.rpcInfosToList(data.effect, AutoChessEffectMo)
end

return AutoChessFightStepMo
