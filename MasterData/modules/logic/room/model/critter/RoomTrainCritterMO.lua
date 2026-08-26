-- chunkname: @modules/logic/room/model/critter/RoomTrainCritterMO.lua

module("modules.logic.room.model.critter.RoomTrainCritterMO", package.seeall)

local RoomTrainCritterMO = pureTable("RoomTrainCritterMO")

function RoomTrainCritterMO:init(info)
	self.id = info.id
	self.critterMO = CritterModel.instance:getCritterMOByUid(self.id)
	self.heroId = self.heroMO.heroId
	self.skinId = self.heroMO.skin
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
	self.skinConfig = SkinConfig.instance:getSkinCo(self.skinId)
end

return RoomTrainCritterMO
