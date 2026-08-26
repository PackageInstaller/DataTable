-- chunkname: @modules/logic/room/model/map/RoomCharacterPlaceMO.lua

module("modules.logic.room.model.map.RoomCharacterPlaceMO", package.seeall)

local RoomCharacterPlaceMO = pureTable("RoomCharacterPlaceMO")

function RoomCharacterPlaceMO:init(info)
	self.id = info.heroId
	self.use = info.use
	self.heroMO = HeroModel.instance:getByHeroId(self.id)
	self.heroId = self.heroMO.heroId
	self.skinId = self.heroMO.skin
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
	self.skinConfig = SkinConfig.instance:getSkinCo(self.skinId)
end

return RoomCharacterPlaceMO
