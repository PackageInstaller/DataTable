-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/entity/PlayerEntity.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.entity.PlayerEntity", package.seeall)

local PlayerEntity = class("PlayerEntity", EntityBase)

function PlayerEntity:ctor()
	PlayerEntity.super.ctor(self)

	self._camp = LengZhou6Enum.entityCamp.player
	self._activeSkill = {}
end

function PlayerEntity:init(configId, skillList, buffList)
	PlayerEntity.super.init(self, configId, skillList, buffList)

	self._damageComp = EliminateDamageComp.New()
	self._treatmentComp = EliminateTreatmentComp.New()
end

function PlayerEntity:initByConfig()
	self._config = LengZhou6Config.instance:getEliminateBattleCharacter(self._configId)
	self._icon = self._config.icon
	self._name = self._config.name

	self:setHp(self:getRealConfigHp())
	self:_initDefaultSkill()
	LocalEliminateChessModel.instance:resetCreateWeight()

	local skillId = self._config.skill

	self:createAndInitPlayerSkill(skillId)
end

function PlayerEntity:getRealConfigHp()
	return (LengZhou6Enum.enterGM or nil) and (LengZhou6Enum.DebugPlayerHp or self._config.hp)
end

function PlayerEntity:changeHp(diff)
	self._hpDiff = diff

	local maxHp = self:getRealConfigHp()

	self._hp = math.max(0, math.min(self._hp + diff, maxHp))
end

function PlayerEntity:resetData(skillIdList)
	if self._damageComp ~= nil then
		self._damageComp:reset()
	end

	if self._treatmentComp ~= nil then
		self._treatmentComp:reset()
	end

	if self._skills ~= nil then
		tabletool.clear(self._skills)
	end

	if self._buffs ~= nil then
		tabletool.clear(self._buffs)
	end

	self:_initDefaultSkill()
	LocalEliminateChessModel.instance:resetCreateWeight()

	for i = 1, #skillIdList do
		local skillId = skillIdList[i]

		self:createAndInitPlayerSkill(skillId)
	end

	tabletool.clear(self._activeSkill)
end

function PlayerEntity:createAndInitPlayerSkill(skillId)
	if skillId == nil or skillId == 0 then
		return
	end

	self:_addSkill(skillId)
	self:initSpecialAttrBySkillId(skillId)
	LengZhou6StatHelper.instance:addUseSkillId(skillId)
end

function PlayerEntity:_initDefaultSkill()
	for i = 1, 4 do
		local skillId = LengZhou6Config.instance:getEliminateBattleCost(i)

		self:_addSkill(skillId)
	end
end

function PlayerEntity:_addSkill(skillId)
	local skill = LengZhou6SkillUtils.instance.createSkill(skillId)

	table.insert(self._skills, skill)
end

function PlayerEntity:initSpecialAttrBySkillId(skillId)
	local allSpecialAttr = LengZhou6Config.instance:getAllSpecialAttr()

	if allSpecialAttr == nil then
		return
	end

	for id, value in pairs(allSpecialAttr) do
		if id == skillId then
			local effect = value.effect
			local chessType = value.chessType
			local num = value.value

			if effect == "fixColorWeight" then
				LocalEliminateChessModel.instance:changeCreateWeight(chessType, num)
			end
		end
	end
end

function PlayerEntity:getActiveSkills()
	if self._activeSkill == nil then
		self._activeSkill = {}
	end

	if #self._activeSkill == 0 then
		for i = 1, #self._skills do
			local skill = self._skills[i]

			if skill:getSkillType() == LengZhou6Enum.SkillType.active or skill:getSkillType() == LengZhou6Enum.SkillType.passive and not LengZhou6Config.instance:isPlayerChessPassive(skill:getConfig().id) then
				table.insert(self._activeSkill, skill)
			end
		end
	end

	return self._activeSkill
end

function PlayerEntity:updateActiveSkillCD()
	if self._activeSkill == nil then
		return
	end

	for i = 1, #self._activeSkill do
		local skill = self._activeSkill[i]

		skill:updateCD()
	end
end

function PlayerEntity:calDamage(eliminateRecordData)
	return self._damageComp:damage(eliminateRecordData)
end

function PlayerEntity:calTreatment(eliminateRecordData)
	return self._treatmentComp:treatment(eliminateRecordData)
end

function PlayerEntity:clearActiveSkillAndSkill()
	if self._activeSkill ~= nil then
		tabletool.clear(self._activeSkill)

		self._activeSkill = nil
	end

	if self._skills ~= nil then
		tabletool.clear(self._skills)
	end
end

function PlayerEntity:clear()
	PlayerEntity.super.clear(self)
	self:clearActiveSkill()
end

return PlayerEntity
