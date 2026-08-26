-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheHandBookBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheHandBookBoxMo", package.seeall)

local SodacheHandBookBoxMo = pureTable("SodacheHandBookBoxMo")

function SodacheHandBookBoxMo:init(data)
	self.handBookMap = GameUtil.rpcInfosToMap(data.handBooks, SodacheHandBookMo, "id")
end

function SodacheHandBookBoxMo:isActive(id)
	if self.handBookMap[id] then
		return true
	else
		return false
	end
end

return SodacheHandBookBoxMo
