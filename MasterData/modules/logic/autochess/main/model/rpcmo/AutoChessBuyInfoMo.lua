-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessBuyInfoMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessBuyInfoMo", package.seeall)

local AutoChessBuyInfoMo = pureTable("AutoChessBuyInfoMo")

function AutoChessBuyInfoMo:init(data)
	self.chessId = data.chessId
	self.num = data.num
end

return AutoChessBuyInfoMo
