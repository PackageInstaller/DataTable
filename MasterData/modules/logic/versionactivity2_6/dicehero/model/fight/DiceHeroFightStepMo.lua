-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightStepMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightStepMo", package.seeall)

local DiceHeroFightStepMo = pureTable("DiceHeroFightStepMo")

function DiceHeroFightStepMo:init(data)
	self.actionType = data.actionType
	self.reasonId = data.reasonId
	self.fromId = data.fromId
	self.toId = data.toId
	self.effect = {}

	for k, v in ipairs(data.effect) do
		self.effect[k] = DiceHeroFightEffectMo.New()

		self.effect[k]:init(v, self)
	end

	self.isByCard = false
	self.isByHero = false

	if self.actionType == 1 then
		local gameData = DiceHeroFightModel.instance:getGameData()
		local skillMo = gameData.skillCardsBySkillId[tonumber(self.reasonId)]

		self.isByCard = skillMo and skillMo.co.type ~= DiceHeroEnum.CardType.Hero
		self.isByHero = gameData.allyHero.uid == self.fromId
	end
end

return DiceHeroFightStepMo
