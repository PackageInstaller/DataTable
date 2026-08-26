-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightDiceMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightDiceMo", package.seeall)

local DiceHeroFightDiceMo = pureTable("DiceHeroFightDiceMo")

function DiceHeroFightDiceMo:init(data, index)
	self.index = index
	self.uid = data.uid
	self.status = data.status
	self.suitId = data.suitId
	self.num = data.num
	self.diceId = data.diceId
	self.deleted = data.deleted
end

return DiceHeroFightDiceMo
