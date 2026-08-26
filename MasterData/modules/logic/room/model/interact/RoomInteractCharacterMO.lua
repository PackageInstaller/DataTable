-- chunkname: @modules/logic/room/model/interact/RoomInteractCharacterMO.lua

module("modules.logic.room.model.interact.RoomInteractCharacterMO", package.seeall)

local RoomInteractCharacterMO = pureTable("RoomInteractCharacterMO")

function RoomInteractCharacterMO:init(info)
	self.id = info.heroId
	self.use = info.use
	self.heroMO = HeroModel.instance:getByHeroId(self.id)
	self.heroId = self.heroMO.heroId
	self.skinId = self.heroMO.skin
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
	self.skinConfig = SkinConfig.instance:getSkinCo(self.skinId)
end

return RoomInteractCharacterMO
