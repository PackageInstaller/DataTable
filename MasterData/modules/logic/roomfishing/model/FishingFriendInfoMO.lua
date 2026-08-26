-- chunkname: @modules/logic/roomfishing/model/FishingFriendInfoMO.lua

module("modules.logic.roomfishing.model.FishingFriendInfoMO", package.seeall)

local FishingFriendInfoMO = pureTable("FishingFriendInfoMO")

function FishingFriendInfoMO:init(info)
	self.type = info.type
	self.userId = info.userId
	self.name = info.name
	self.portrait = info.portrait
	self.poolId = info.poolId
end

return FishingFriendInfoMO
