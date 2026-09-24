-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameItemMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameItemMo", package.seeall)

local MatchGameItemMo = pureTable("MatchGameItemMo")

function MatchGameItemMo:init(info)
	self.itemId = info.itemId
	self.itemCo = lua_activity244_item.configDict[self.itemId]
	self.num = info.num
end

return MatchGameItemMo
