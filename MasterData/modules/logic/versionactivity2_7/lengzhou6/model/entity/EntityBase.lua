-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/entity/EntityBase.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EntityBase", package.seeall)

local EntityBase = class("EntityBase")

function EntityBase:ctor()
	self._hp = 0
	self._skills = {}
	self._buffs = {}
	self._configId = 0
	self._damageComp = nil
	self._treatmentComp = nil
	self._camp = -1
	self._icon = ""
	self._name = ""
end

function EntityBase:init(configId, skillList, buffList)
	self._configId = configId

	self:initByConfig()
end

function EntityBase:initByConfig()
	return
end

function EntityBase:changeHp(diff)
	self._hpDiff = diff
	self._hp = math.max(0, self._hp + diff)
end

function EntityBase:getCurDiff()
	return self._hpDiff
end

function EntityBase:getHp()
	return self._hp
end

function EntityBase:setHp(hp)
	self._hp = hp
end

function EntityBase:getConfigId()
	return self._configId
end

function EntityBase:getDamageComp()
	return self._damageComp
end

function EntityBase:getTreatmentComp()
	return self._treatmentComp
end

function EntityBase:triggerBuffAndSkill()
	if self._skills then
		for i = 1, #self._skills do
			local skill = self._skills[i]

			if skill ~= nil and skill:getSkillType() == LengZhou6Enum.SkillType.passive then
				skill:execute()
			end
		end
	end

	if self._buffs then
		for i = 1, #self._buffs do
			local buff = self._buffs[i]

			if buff ~= nil then
				buff:execute()
			end
		end
	end
end

function EntityBase:getCamp()
	return self._camp
end

function EntityBase:calDamage()
	return
end

function EntityBase:calTreatment()
	return
end

function EntityBase:getIcon()
	return self._icon
end

function EntityBase:getName()
	return self._name
end

function EntityBase:addBuff(buff)
	table.insert(self._buffs, buff)
end

function EntityBase:getBuffByConfigId(configId)
	for i = 1, #self._buffs do
		local buff = self._buffs[i]

		if buff._configId == configId then
			return buff
		end
	end

	return nil
end

function EntityBase:getBuffs()
	return self._buffs
end

function EntityBase:clear()
	self._hp = nil
	self._configId = nil

	if self._skills ~= nil then
		tabletool.clear(self._skills)

		self._skills = nil
	end

	if self._buffs ~= nil then
		tabletool.clear(self._buffs)

		self._buffs = nil
	end

	self._damageComp = nil
	self._treatmentComp = nil
	self._camp = -1
	self._icon = nil
	self._name = nil
	self._config = nil
end

return EntityBase
