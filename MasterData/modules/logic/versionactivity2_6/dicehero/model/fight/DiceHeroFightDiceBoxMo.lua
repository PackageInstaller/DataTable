-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightDiceBoxMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightDiceBoxMo", package.seeall)

local DiceHeroFightDiceBoxMo = pureTable("DiceHeroFightDiceBoxMo")

function DiceHeroFightDiceBoxMo:init(data)
	self.capacity = data.capacity
	self.dices = {}
	self.dicesByUid = self.dicesByUid or {}

	for k, v in ipairs(data.dices) do
		self.dices[k] = self.dicesByUid[v.uid] or DiceHeroFightDiceMo.New()

		self.dices[k]:init(v, k)

		self.dicesByUid[v.uid] = self.dices[k]
	end

	self.resetTimes = data.resetTimes
	self.maxResetTimes = data.maxResetTimes
end

function DiceHeroFightDiceBoxMo:getDiceMoByUid(uid)
	return self.dicesByUid[uid]
end

return DiceHeroFightDiceBoxMo
