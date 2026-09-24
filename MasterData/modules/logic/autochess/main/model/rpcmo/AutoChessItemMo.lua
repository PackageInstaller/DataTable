-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessItemMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessItemMo", package.seeall)

local AutoChessItemMo = pureTable("AutoChessItemMo")

function AutoChessItemMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.freeze = data.freeze
	self.chess = GameUtil.rpcInfoToMo(data.chess, AutoChessMo)
	self.skillId = data.skillId
	self.fixCost = data.fixCost
	self.config = AutoChessConfig.instance:getMallItemCfg(self.id)
end

return AutoChessItemMo
