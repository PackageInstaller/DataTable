-- chunkname: @modules/logic/partygamelobby/model/rpcmo/PartyPlayerInfoMO.lua

module("modules.logic.partygamelobby.model.rpcmo.PartyPlayerInfoMO", package.seeall)

local PartyPlayerInfoMO = pureTable("PartyPlayerInfoMO")

function PartyPlayerInfoMO:init(info)
	self.id = info.userId
	self.level = info.level or 0
	self.userId = info.userId
	self.status = info.status
	self.isRoomOwner = info.isRoomOwner
	self.name = info.name
	self.portrait = info.portrait
	self.wearClothIds = {}
	self.version = info.version

	self:updateWearClothIds(info.wearClothIds)

	self.pos = {}
end

function PartyPlayerInfoMO:updateWearClothIds(ids)
	for i, v in ipairs(ids) do
		table.insert(self.wearClothIds, v)
	end
end

return PartyPlayerInfoMO
