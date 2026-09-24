-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessBuffMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessBuffMo", package.seeall)

local AutoChessBuffMo = pureTable("AutoChessBuffMo")

function AutoChessBuffMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.layer = data.layer
	self.duration = data.duration
	self.config = AutoChessConfig.instance:getBuffCfg(self.id)
end

function AutoChessBuffMo:update(data)
	self.layer = data.layer
	self.duration = data.duration
end

return AutoChessBuffMo
