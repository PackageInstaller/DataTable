-- chunkname: @modules/logic/matchgame/fight/model/MatchGameEnemyFightMo.lua

module("modules.logic.matchgame.fight.model.MatchGameEnemyFightMo", package.seeall)

local MatchGameEnemyFightMo = pureTable("MatchGameEnemyFightMo")

function MatchGameEnemyFightMo:ctor()
	self.id = 0
	self.enemySkillInfoList = {}
	self.maxHp = 100
	self.hp = self.maxHp
	self.attack = 0
	self.attackRate = 1
	self.def = 0
	self.career = 1
	self.level = 1
	self.heal = 0
	self.skillUserType = MatchGameFightEnum.SkillUserType.Enemy
	self.skillBuffMoMap = {}
	self.giddyState = false
end

function MatchGameEnemyFightMo:initData(coData)
	self.enemyCoData = coData

	self:initFightInfo(self.enemyCoData)
end

function MatchGameEnemyFightMo:initFightInfo(data)
	self.id = self.enemyCoData.config.id
	self.enemySkillInfoList = {}

	local enemyActiveSkillList = not string.nilorempty(data.skillTemplateConfig.activeSkill) and string.splitToNumber(data.skillTemplateConfig.activeSkill, "#")

	for index, skillId in ipairs(enemyActiveSkillList) do
		local enemySkillInfo = {}

		enemySkillInfo.index = index
		enemySkillInfo.skillId = skillId
		enemySkillInfo.skillConfig = MatchGameFightConfig.instance:getMonsterSkillConfig(skillId)
		enemySkillInfo.curSkillCD = 0
		self.enemySkillInfoList[index] = enemySkillInfo
	end

	self.name = data.config.name
	self.maxHp = data.attrConfig.hp
	self.hp = self.maxHp
	self.attack = data.attrConfig.attack
	self.attackRate = 1
	self.skillAttackRate = 0
	self.def = data.attrConfig.defense
	self.career = data.config.career
	self.level = data.config.level
	self.giddyState = false
end

function MatchGameEnemyFightMo:updateFightInfo(info)
	if self.id <= 0 then
		return
	end

	self.maxHp = info.maxHp or self.maxHp
	self.hp = Mathf.Min(info.hp or self.hp, self.maxHp)
	self.def = info.def or self.def
	self.attack = info.attack or self.attack
	self.heal = info.heal or self.heal
	self.attackRate = info.attackRate or self.attackRate
	self.skillAttackRate = info.skillAttackRate or self.skillAttackRate
end

function MatchGameEnemyFightMo:setGiddyState(state)
	self.giddyState = state
end

return MatchGameEnemyFightMo
