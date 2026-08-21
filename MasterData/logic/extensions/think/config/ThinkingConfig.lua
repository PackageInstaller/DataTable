-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/config/ThinkingConfig.lua

module("logic.extensions.think.config.ThinkingConfig", package.seeall)

local M = class("ThinkingConfig", BaseConfig)

function M:onInit()
	self._cfgThinking = false
	self._cfgThinkingSkillUpgrade = false
	self._cfgThinkingUnlockCost = false
end

function M:getNames()
	return {
		ConfigName.Thinking,
		ConfigName.ThinkingSkillUpgrade,
		ConfigName.ThinkingUnlockCost
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Thinking then
		self._cfgThinking = content
	elseif name == ConfigName.ThinkingSkillUpgrade then
		self._cfgThinkingSkillUpgrade = content
	elseif name == ConfigName.ThinkingUnlockCost then
		self._cfgThinkingUnlockCost = content
	end
end

function M:getThinkingCfg()
	return self._cfgThinking
end

function M:getThinkingCO(code)
	return self._cfgThinking[code]
end

function M:getThinkingOnline(code)
	local online = false
	local cfg = self:getThinkingCO(code)

	if cfg then
		online = cfg.online > 0
	end

	return online
end

function M:getThinkingSkillTotalLevel(skills)
	local total = 0

	for i, v in ipairs(skills) do
		total = total + self:_getLevelBySkillId(v)
	end

	return total
end

function M:_getLevelBySkillId(skillId)
	local total = 0

	for i, v in ipairs(self._cfgThinkingSkillUpgrade.dataList) do
		if v.skillId == skillId then
			total = total + 1
		end
	end

	return total
end

function M:getThinkingSkillCfg(skillId)
	return self._cfgThinkingSkillUpgrade[skillId]
end

function M:getMaxThinkingSkillLevel(skillId)
	local skillEnhance = self._cfgThinkingSkillUpgrade[skillId]

	return #skillEnhance
end

function M:getThinkingUnlockCfg(count)
	return self._cfgThinkingUnlockCost[count]
end

function M:getSkillUpgradeCost(skillId, targetLevel)
	local costLzb = 0
	local costItem = {}

	if self._cfgThinkingSkillUpgrade[skillId] and self._cfgThinkingSkillUpgrade[skillId][targetLevel] then
		local costList = self._cfgThinkingSkillUpgrade[skillId][targetLevel].cost or {}

		for _, v in ipairs(costList) do
			local itemId = v.id
			local itemCount = v.num

			if itemId == CommEnum.CurrencyCodeEnum.LzbCode then
				costLzb = itemCount
			else
				table.insert(costItem, ItemUtil.createItemData({
					itemId = itemId,
					count = itemCount
				}))
			end
		end
	end

	return costLzb, costItem
end

function M:getSkillActiveCost(skillId, targetLevel)
	local costItem = {}

	if self._cfgThinkingSkillUpgrade[skillId] and self._cfgThinkingSkillUpgrade[skillId][targetLevel] then
		local costList = self._cfgThinkingSkillUpgrade[skillId][targetLevel].cost or {}

		for _, v in ipairs(costList) do
			local itemId = v.id
			local itemCount = v.num

			table.insert(costItem, ItemUtil.createItemData({
				itemId = itemId,
				count = itemCount
			}))
		end
	end

	return costItem
end

M.instance = M.New()

return M
