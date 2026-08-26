-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheAttrValueMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheAttrValueMo", package.seeall)

local SodacheAttrValueMo = pureTable("SodacheAttrValueMo")

function SodacheAttrValueMo:init(data)
	self.id = data.id
	self.finalVal = data.finalVal
end

return SodacheAttrValueMo
