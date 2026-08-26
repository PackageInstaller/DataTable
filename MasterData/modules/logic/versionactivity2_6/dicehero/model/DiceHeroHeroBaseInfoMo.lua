-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/DiceHeroHeroBaseInfoMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroHeroBaseInfoMo", package.seeall)

local DiceHeroHeroBaseInfoMo = pureTable("DiceHeroHeroBaseInfoMo")

function DiceHeroHeroBaseInfoMo:init(data)
	self.id = data.id
	self.hp = tonumber(data.hp) or 0
	self.shield = tonumber(data.shield) or 0
	self.power = tonumber(data.power) or 0
	self.maxHp = tonumber(data.maxHp) or 0
	self.maxShield = tonumber(data.maxShield) or 0
	self.maxPower = tonumber(data.maxPower) or 0
	self.relicIds = data.relicIds

	if self.id ~= 0 then
		self.co = lua_dice_character.configDict[self.id]
	end
end

return DiceHeroHeroBaseInfoMo
