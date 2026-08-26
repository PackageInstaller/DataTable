-- chunkname: @modules/logic/player/model/PlayerClothMO.lua

module("modules.logic.player.model.PlayerClothMO", package.seeall)

local PlayerClothMO = pureTable("PlayerClothMO")

function PlayerClothMO:ctor()
	self.id = nil
	self.clothId = nil
	self.level = nil
	self.exp = nil
	self.has = nil
end

function PlayerClothMO:initFromConfig(co)
	self.id = co.id
	self.clothId = co.id
	self.level = 0
	self.exp = 0
end

function PlayerClothMO:init(info)
	self.level = info.level
	self.exp = info.exp
	self.has = true
end

return PlayerClothMO
