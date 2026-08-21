-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/EquipSuitData.lua

module("logic.extensions.equipment.data.EquipSuitData", package.seeall)

local M = class("EquipSuitData")

function M:ctor(suitCo)
	self.id = suitCo.id
	self._name = suitCo.name
	self._suitEffect = suitCo.suitEffect
	self._totalNum = {
		0,
		0,
		0
	}
	self._isOwner = false
	self._sort = suitCo.sort
	self._isFilter = suitCo.isFilter
end

function M:getId()
	return self.id
end

function M:getIsOwner()
	return self._isOwner
end

function M:setIsOwner(res)
	self._isOwner = res
end

function M:getName()
	return self._name
end

function M:getSuitEffect()
	return self._suitEffect
end

function M:getSort()
	return self._sort
end

function M:isFilter()
	return self._isFilter == 1
end

function M:getSuitEffectDesc()
	if not self._suitEffect or self._suitEffect == 0 then
		return ""
	end

	local activeSkillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._suitEffect)
	local desc = activeSkillCOWrapper and activeSkillCOWrapper:getDescription() or ""

	return StringUtil.replaceMiddleBracketsToColor(desc)
end

function M:getSuit3DescList(highLightTagIds)
	if not self._suitEffect or self._suitEffect == 0 then
		return ""
	end

	local activeSkillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._suitEffect)
	local desc = ""

	if activeSkillCOWrapper then
		if highLightTagIds and #highLightTagIds > 0 then
			desc = activeSkillCOWrapper:getDescriptionHighLightTag(highLightTagIds)
		else
			desc = activeSkillCOWrapper:getDescription()
		end
	end

	local contentList = string.split(desc, "\n")

	for i, skill in ipairs(contentList) do
		local skillNotDot = string.gsub(skill, "·", "")

		contentList[i] = skillNotDot
	end

	return contentList
end

function M:getSuitDefault()
	local activeSkillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._suitEffect)
	local desc = activeSkillCOWrapper and activeSkillCOWrapper:getDescription() or ""
	local name = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentSuit, self.id).name

	return name, desc
end

function M:clearTotalNum()
	self._totalNum = {
		0,
		0,
		0
	}
end

function M:addPartNum(part)
	self._totalNum[part] = self._totalNum[part] + 1
end

function M:getPartNum()
	return self._totalNum
end

function M:getAllPartNum()
	local num = 0

	for k, v in pairs(self._totalNum) do
		num = num + v
	end

	return num
end

function M:getNum(part)
	return self._totalNum[part] or 0
end

return M
