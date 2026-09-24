-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessPositionMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessPositionMo", package.seeall)

local AutoChessPositionMo = pureTable("AutoChessPositionMo")

function AutoChessPositionMo:init(data)
	self.index = data.index
	self.teamType = data.teamType
	self.chess = GameUtil.rpcInfoToMo(data.chess, AutoChessMo)
end

return AutoChessPositionMo
