-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/fight/DiceHeroFightEntityMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightEntityMo", package.seeall)

local DiceHeroFightEntityMo = pureTable("DiceHeroFightEntityMo")

function DiceHeroFightEntityMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.status = data.status
	self.hp = tonumber(data.hp) or 0
	self.shield = tonumber(data.shield) or 0
	self.power = tonumber(data.power) or 0
	self.maxHp = tonumber(data.maxHp) or 0
	self.maxShield = tonumber(data.maxShield) or 0
	self.maxPower = tonumber(data.maxPower) or 0
	self.buffs = {}
	self.buffsByUid = {}

	if self.hp > 0 then
		for k, v in ipairs(data.buffContainer.buffs) do
			local buffMo = DiceHeroFightBuffMo.New()

			buffMo:init(v)

			if buffMo.co.visible == 1 then
				table.insert(self.buffs, buffMo)
			end

			self.buffsByUid[v.uid] = buffMo
		end
	end

	self.relicIds = data.relicIds
	self.behaviors = {}
end

function DiceHeroFightEntityMo:setHp(hp)
	self.hp = hp

	if self.hp <= 0 then
		self.behaviors = {}
		self.buffs = {}
		self.buffsByUid = {}
	end
end

function DiceHeroFightEntityMo:setSkills(skills)
	self.skills = skills
end

function DiceHeroFightEntityMo:clearBehavior()
	self.behaviors = {}
end

function DiceHeroFightEntityMo:addBehavior(data, heroUid)
	if self.hp <= 0 then
		return
	end

	if not self.behaviors.type then
		self:setBehaviorData(self.behaviors, data, heroUid)
	else
		self.behaviors.exList = self.behaviors.exList or {}

		local behavior = {}

		self:setBehaviorData(behavior, data, heroUid)
		table.insert(self.behaviors.exList, behavior)
	end
end

function DiceHeroFightEntityMo:setBehaviorData(behavior, data, heroUid)
	behavior.type = data.type
	behavior.value = data.value
	behavior.isToSelf = data.fromId == data.targetIds[1]
	behavior.isToHero = heroUid == data.targetIds[1]
	behavior.isToAll = #data.targetIds > 1
	behavior.isToFriend = not behavior.isToAll and not behavior.isToSelf and not behavior.isToHero
end

function DiceHeroFightEntityMo:isMixDice()
	for _, v in pairs(self.buffsByUid) do
		if v.co.effect == DiceHeroEnum.SkillEffectType.DiceMix then
			return true
		end
	end

	return false
end

function DiceHeroFightEntityMo:isBanSkillCard(cardType)
	for _, v in pairs(self.buffsByUid) do
		if v.co.effect == DiceHeroEnum.SkillEffectType.BanSkillCard then
			local banType = tonumber(v.co.param) or 0

			return banType == cardType or banType == 0
		end
	end

	return false
end

function DiceHeroFightEntityMo:addOrUpdateBuff(buffMo)
	if self.hp <= 0 then
		return
	end

	if self.buffsByUid[buffMo.uid] then
		self.buffsByUid[buffMo.uid]:init(buffMo)
	else
		local newBuffMo = DiceHeroFightBuffMo.New()

		newBuffMo:init(buffMo)

		self.buffsByUid[buffMo.uid] = newBuffMo

		if newBuffMo.co.visible == 1 then
			table.insert(self.buffs, newBuffMo)
		end
	end
end

function DiceHeroFightEntityMo:isAddLayer(buffMo)
	local oldBuffMo = self.buffsByUid[buffMo.uid]

	if not oldBuffMo then
		return true
	end

	return oldBuffMo.layer < buffMo.layer
end

function DiceHeroFightEntityMo:removeBuff(buffUid)
	if self.buffsByUid[buffUid] then
		tabletool.removeValue(self.buffs, self.buffsByUid[buffUid])

		self.buffsByUid[buffUid] = nil
	end
end

function DiceHeroFightEntityMo:canUseHeroSkill()
	if self.power < self.maxPower then
		return false
	end

	if self:isBanSkillCard(DiceHeroEnum.CardType.Hero) then
		return false
	end

	if not self.skills then
		return false
	end

	for _, skill in ipairs(self.skills) do
		if skill.co.spiritskilltype == DiceHeroEnum.HeroCardType.ActiveSkill then
			return true
		end
	end

	return false
end

function DiceHeroFightEntityMo:canUsePassiveSkill()
	if self.power <= 0 then
		return
	end

	if self:isBanSkillCard(DiceHeroEnum.CardType.Hero) then
		return false
	end

	if not self.skills then
		return false
	end

	for _, skill in ipairs(self.skills) do
		if skill.co.spiritskilltype == DiceHeroEnum.HeroCardType.PassiveSkill then
			return true
		end
	end

	return false
end

function DiceHeroFightEntityMo:haveBuff2()
	for _, v in pairs(self.buffsByUid) do
		if v.co.id == 2 then
			return true
		end
	end

	return false
end

return DiceHeroFightEntityMo
