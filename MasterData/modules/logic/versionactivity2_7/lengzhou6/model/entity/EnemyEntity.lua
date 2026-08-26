-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/entity/EnemyEntity.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyEntity", package.seeall)

local EnemyEntity = class("EnemyEntity", EntityBase)

function EnemyEntity:ctor()
	EnemyEntity.super.ctor(self)

	self._action = EnemyActionData.New()
	self._camp = LengZhou6Enum.entityCamp.enemy
end

function EnemyEntity:init(configId, skillList, buffList)
	EnemyEntity.super.init(self, configId, skillList, buffList)
end

function EnemyEntity:initByConfig()
	self._config = LengZhou6Config.instance:getEliminateBattleEnemy(self._configId)

	if self._config == nil then
		logError("eliminate_battle_enemy config is nil" .. self._configId)
	end

	self._icon = self._config.icon
	self._name = self._config.name

	self:setHp(self._config.hp)
	self:initAction()

	local loop = self._config.loop

	if not string.nilorempty(loop) then
		local loopIndexList = string.splitToNumber(loop, "#")

		self._action:initLoopIndex(loopIndexList[1], loopIndexList[2])
	end
end

function EnemyEntity:initAction()
	self._action:init(self._configId)
end

function EnemyEntity:setActionStepIndexAndRound(index, round)
	if self._action ~= nil and index ~= nil and round ~= nil then
		self._action:setCurBehaviorId(index)
		self._action:setCurRound(round)
	end
end

function EnemyEntity:getCurSkillList()
	local curBehavior = self._action:getCurBehavior()

	return curBehavior and curBehavior:getSkillList() or nil
end

function EnemyEntity:getAllCanUseSkillId()
	if self._buffs ~= nil then
		for i = 1, #self._buffs do
			local buff = self._buffs[i]

			if buff:getBuffEffect() == LengZhou6Enum.BuffEffect.petrify and buff:execute(true) then
				return nil, self._action:calCurResidueCd()
			end
		end
	end

	self:clearInvalidBuff()

	local skillList = self._action:getSkillList()
	local residueCd = self._action:calCurResidueCd()

	if skillList ~= nil then
		for i = 1, #skillList do
			local skill = skillList[i]

			self._skills[skill._id] = skill
		end

		residueCd = 0
	end

	return skillList, residueCd
end

function EnemyEntity:clearInvalidBuff()
	local needRemoveIndex = {}

	if self._buffs ~= nil then
		for i = 1, #self._buffs do
			local buff = self._buffs[i]

			if buff:getBuffEffect() == 0 then
				table.insert(needRemoveIndex, i)
			end
		end
	end

	for i = #needRemoveIndex, 1, -1 do
		local index = needRemoveIndex[i]

		if self._buffs[index] ~= nil then
			self._buffs[index] = nil
		end
	end
end

function EnemyEntity:getAction()
	return self._action
end

function EnemyEntity:havePoisonBuff()
	if self._buffs then
		for _, buff in ipairs(self._buffs) do
			if buff._configId == 1001 then
				return true
			end
		end
	end

	return false
end

function EnemyEntity:useSkill(skillId)
	if self._skills[skillId] ~= nil then
		self._skills[skillId]:execute()
	end

	self._skills[skillId] = nil
end

return EnemyEntity
