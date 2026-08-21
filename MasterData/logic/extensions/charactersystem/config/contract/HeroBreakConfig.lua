-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/contract/HeroBreakConfig.lua

module("logic.extensions.charactersystem.config.contract.HeroBreakConfig", package.seeall)

local M = class("HeroBreakConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.HeroBreak,
		ConfigName.HeroBreakAttr
	}
end

function M:getInfo(id)
	local tableInfo = self._dict[ConfigName.HeroBreak]
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

function M:getAllHeroBreak()
	return self._dict[ConfigName.HeroBreak]
end

function M:getAttrCO(heroId, breakLv)
	if self._dict[ConfigName.HeroBreakAttr] and self._dict[ConfigName.HeroBreakAttr][heroId] then
		return self._dict[ConfigName.HeroBreakAttr][heroId][breakLv]
	end

	return nil
end

function M:getBreakAttGrowEnhance(heroId, breakLv)
	local enhancePercent = 0

	if self._dict[ConfigName.HeroBreakAttr] and self._dict[ConfigName.HeroBreakAttr][heroId] then
		for _, cfg in pairs(self._dict[ConfigName.HeroBreakAttr][heroId]) do
			if breakLv >= cfg.breakLv then
				enhancePercent = enhancePercent + cfg.attrGrowEnhance
			end
		end
	end

	return enhancePercent
end

function M:getBreakSkillEnhanceIds(heroId)
	local cfgMap = {}

	if self._dict[ConfigName.HeroBreakAttr] and self._dict[ConfigName.HeroBreakAttr][heroId] then
		for _, cfg in pairs(self._dict[ConfigName.HeroBreakAttr][heroId]) do
			if cfg.skillId > 0 then
				cfgMap[cfg.breakLv] = cfg
			end
		end
	end

	return cfgMap
end

function M:getMaxBreakLevel()
	local tableInfo = self._dict[ConfigName.HeroBreak]

	return #tableInfo
end

function M:getSkillEnhanceCodes(heroId, skillId)
	local enhanceCodes = {}

	if self._dict[ConfigName.HeroBreakAttr] and self._dict[ConfigName.HeroBreakAttr][heroId] then
		for _, cfg in pairs(self._dict[ConfigName.HeroBreakAttr][heroId]) do
			if cfg.skillId == skillId and cfg.skillEnhanceId > 0 then
				table.insert(enhanceCodes, cfg.skillEnhanceId)
			end
		end
	end

	return enhanceCodes
end

M.instance = M.New()

return M
