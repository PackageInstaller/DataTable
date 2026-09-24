-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessWarZoneMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessWarZoneMo", package.seeall)

local AutoChessWarZoneMo = pureTable("AutoChessWarZoneMo")

function AutoChessWarZoneMo:init(data)
	self.id = data.id
	self.type = data.type
	self.positions = GameUtil.rpcInfosToList(data.positions, AutoChessPositionMo)
end

return AutoChessWarZoneMo
