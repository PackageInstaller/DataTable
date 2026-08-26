-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightEffectMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightEffectMo", package.seeall)

local DiceHeroFightEffectMo = pureTable("DiceHeroFightEffectMo")

function DiceHeroFightEffectMo:init(data, parent)
	self.effectType = data.effectType
	self.fromId = data.fromId
	self.targetId = data.targetId
	self.effectNum = tonumber(data.effectNum) or 0
	self.extraData = data.extraData
	self.nextFightStep = DiceHeroFightStepMo.New()

	self.nextFightStep:init(data.nextFightStep)

	self.buff = DiceHeroFightBuffMo.New()

	self.buff:init(data.buff)

	self.targetIds = data.targetIds
	self.skillCards = data.skillCards
	self.diceBox = data.diceBox
	self.parent = parent
end

return DiceHeroFightEffectMo
