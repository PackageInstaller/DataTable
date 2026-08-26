-- chunkname: @modules/logic/partygamelobby/model/rpcmo/FriendInfoMO.lua

module("modules.logic.partygamelobby.model.rpcmo.FriendInfoMO", package.seeall)

local FriendInfoMO = pureTable("FriendInfoMO")

function FriendInfoMO:init(info)
	self.userId = info.userId
	self.state = info.state
end

return FriendInfoMO
