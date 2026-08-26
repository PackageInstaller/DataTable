-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightData.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightData", package.seeall)

local DiceHeroFightData = class("DiceHeroFightData")

function DiceHeroFightData:ctor(data)
	self:init(data)
end

function DiceHeroFightData:init(data)
	self.round = data.round
	self.status = data.status
	self.allyHero = DiceHeroFightEntityMo.New()

	self.allyHero:init(data.allyHero)

	if self.allyHero.id ~= 0 then
		self.allyHero.co = lua_dice_character.configDict[self.allyHero.id]
	end

	self.enemyHeros = {}
	self.enemyHerosByUid = self.enemyHerosByUid or {}

	for k, v in ipairs(data.enemyHeros) do
		self.enemyHeros[k] = self.enemyHerosByUid[v.uid] or DiceHeroFightEntityMo.New()

		self.enemyHeros[k]:init(v)

		self.enemyHerosByUid[v.uid] = self.enemyHeros[k]

		self.enemyHeros[k]:clearBehavior()

		if self.enemyHeros[k].id ~= 0 then
			self.enemyHeros[k].co = lua_dice_enemy.configDict[self.enemyHeros[k].id]
		end
	end

	self.enemyHerosByUid = {}

	for _, v in pairs(self.enemyHeros) do
		self.enemyHerosByUid[v.uid] = v
	end

	self.skillCards = {}
	self.heroSkillCards = {}
	self.skillCardsBySkillId = self.skillCardsBySkillId or {}

	for k, v in ipairs(data.skillCards) do
		if not self.skillCardsBySkillId[v.skillId] then
			local skillCardMo = DiceHeroFightSkillCardMo.New()

			self.skillCardsBySkillId[v.skillId]:init(v, self.round)

			self.skillCardsBySkillId[v.skillId] = self.skillCardsBySkillId[v.skillId]

			if self.skillCardsBySkillId[v.skillId].co.type == DiceHeroEnum.CardType.Hero then
				table.insert(self.heroSkillCards, self.skillCardsBySkillId[v.skillId])
			else
				table.insert(self.skillCards, self.skillCardsBySkillId[v.skillId])
			end
		end
	end

	self.skillCardsBySkillId = {}

	for _, v in pairs(self.skillCards) do
		self.skillCardsBySkillId[v.skillId] = v
	end

	for _, v in pairs(self.heroSkillCards) do
		self.skillCardsBySkillId[v.skillId] = v
	end

	self.allyHero:setSkills(self.heroSkillCards)

	self.diceBox = DiceHeroFightDiceBoxMo.New()

	self.diceBox:init(data.diceBox)

	self.confirmed = data.confirmed

	for _, v in ipairs(data.behaviors) do
		if self.enemyHerosByUid[v.fromId] then
			self.enemyHerosByUid[v.fromId]:addBehavior(v, self.allyHero.uid)
		end
	end

	self.curSelectCardMo = nil
	self.curSelectEnemyMo = nil

	for k, v in ipairs(self.skillCards) do
		v:initMatchDices(self.diceBox.dices, self.allyHero:isMixDice())
	end

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardSelectChange)

	self._autoSelectEnemyUid = self._autoSelectEnemyUid
end

function DiceHeroFightData:setCurSelectCard(cardMo)
	if self.curSelectCardMo then
		self.curSelectCardMo:clearSelects()
	end

	self.curSelectEnemyMo = nil
	self.curSelectCardMo = cardMo

	if self.curSelectCardMo and self.curSelectCardMo.co.aim1 == DiceHeroEnum.SkillCardTargetType.SingleEnemy then
		local enemyMo = self.enemyHerosByUid[self._autoSelectEnemyUid]

		if not enemyMo or enemyMo.hp <= 0 then
			self._autoSelectEnemyUid = nil
			enemyMo = nil
		else
			self.curSelectEnemyMo = enemyMo
		end

		if not enemyMo then
			for _, enemyHero in ipairs(self.enemyHeros) do
				if enemyHero.hp > 0 then
					self.curSelectEnemyMo = enemyHero
					self._autoSelectEnemyUid = enemyHero.uid

					break
				end
			end
		end
	end

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardSelectChange)
end

function DiceHeroFightData:getCardMoBySkillId(skillId)
	return self.skillCardsBySkillId[skillId]
end

function DiceHeroFightData:onStepEnd()
	for k, v in ipairs(self.skillCards) do
		v:initMatchDices(self.diceBox.dices, self.allyHero:isMixDice())
	end

	self:setCurSelectCard(nil)
end

function DiceHeroFightData:setCurEnemy(enemyMo)
	if not self.curSelectCardMo or self.curSelectCardMo.co.aim1 ~= DiceHeroEnum.SkillCardTargetType.SingleEnemy then
		return
	end

	if enemyMo and enemyMo.hp == 0 then
		return
	end

	self.curSelectEnemyMo = enemyMo
	self._autoSelectEnemyUid = enemyMo.uid

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.EnemySelectChange)
end

return DiceHeroFightData
