-- chunkname: @modules/logic/versionactivity3_3/arcade/model/develop/ArcadeTalentMO.lua

module("modules.logic.versionactivity3_3.arcade.model.develop.ArcadeTalentMO", package.seeall)

local ArcadeTalentMO = class("ArcadeTalentMO")

function ArcadeTalentMO:ctor(id, coList)
	self.id = id
	self.coList = coList

	self:setLevel(0)
end

function ArcadeTalentMO:refreshInfo(info)
	self:setLevel((info or nil) and (info.level or 0))
end

function ArcadeTalentMO:setLevel(level)
	self._level = level
end

function ArcadeTalentMO:getLevel()
	return self._level
end

function ArcadeTalentMO:getMaxLevel()
	if not self._maxLevel then
		self._maxLevel = 0

		for level, co in ipairs(self.coList) do
			self._maxLevel = math.max(self._maxLevel, level)
		end
	end

	return self._maxLevel or 0
end

function ArcadeTalentMO:getLevelCo(level)
	return self.coList[level]
end

function ArcadeTalentMO:getCurLevelCo()
	return self:getLevelCo(self._level)
end

function ArcadeTalentMO:getNextLevelCo()
	return self:getLevelCo(self._level + 1)
end

function ArcadeTalentMO:getDisplayType()
	local co = self:getCurLevelCo()

	return co and co.displayType
end

function ArcadeTalentMO:getSkillIdsByLevel(level)
	self._skillIds = self._skillIds or {}

	local skillIds = self._skillIds[level]

	if skillIds then
		return skillIds
	end

	local co = self:getLevelCo(level)

	if not co or string.nilorempty(co.skill) then
		return
	end

	local skillIds = string.splitToNumber(co.skill, "#")

	self._skillIds[level] = skillIds

	return skillIds
end

function ArcadeTalentMO:getCost()
	local nextCo = self:getNextLevelCo()

	return (nextCo or nil) and (nextCo.cost or 0)
end

function ArcadeTalentMO:isLock()
	return self._level < 1
end

function ArcadeTalentMO:isMaxLevel()
	return self:getNextLevelCo() == nil
end

function ArcadeTalentMO:canUpLV()
	if self:isMaxLevel() then
		return false
	end

	local values = ArcadeOutSizeModel.instance:getAttrValues(ArcadeEnum.AttributeConst.DiamondCount)
	local curNum = values or 0

	return curNum >= self:getCost()
end

function ArcadeTalentMO:getIconCo()
	local iconCo = lua_arcade_talent_icon.configDict[self.id]

	if iconCo then
		if not iconCo.icon then
			return "v3a3_eliminate_skillicon_1_1"
		end
	end
end

return ArcadeTalentMO
