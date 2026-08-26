-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheHandBookMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheHandBookMo", package.seeall)

local SodacheHandBookMo = pureTable("SodacheHandBookMo")

function SodacheHandBookMo:init(data)
	self.id = data.id
end

return SodacheHandBookMo
