-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheFunctionBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheFunctionBoxMo", package.seeall)

local SodacheFunctionBoxMo = pureTable("SodacheFunctionBoxMo")

function SodacheFunctionBoxMo:init(data)
	self.functionIds = data.functionIds
end

return SodacheFunctionBoxMo
