-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightBuffMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightBuffMo", package.seeall)

local DiceHeroFightBuffMo = pureTable("DiceHeroFightBuffMo")

function DiceHeroFightBuffMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.layer = data.layer
	self.co = lua_dice_buff.configDict[self.id]
end

return DiceHeroFightBuffMo
