-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/config/HeroFilterRuleConfig.lua

module("logic.extensions.characterdepot.config.HeroFilterRuleConfig", package.seeall)

local M = class("HeroFilterRuleConfig", BaseConfig)

function M:onInit()
	self._cfgInfo = false
end

function M:getNames()
	return {
		ConfigName.HeroFilterRule
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.HeroFilterRule then
		self._cfgInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getCfgInfoByID(code)
	local dataCO = self._cfgInfo[code]

	if code > 0 and not dataCO and enableErrorLog then
		printError(string.format("HeroFilterRuleConfig::cannot find hero filter config for id[%s]", code))
	end

	return dataCO
end

function M:getCampFilterType()
	if not self._campFilterTab then
		local rule_cfg = self._cfgInfo[CommEnum.FilterKind.CampFilter]

		self._campFilterTab = self:parseTypeCfg(rule_cfg)
	end

	return self._campFilterTab
end

function M:getCareerFilterType()
	if not self._carrerFilterTab then
		local rule_cfg = self._cfgInfo[CommEnum.FilterKind.CareerFilter]

		self._carrerFilterTab = self:parseTypeCfg(rule_cfg)
	end

	return self._carrerFilterTab
end

function M:getQualityFilterType()
	if not self._qualityFilterTab then
		local rule_cfg = self._cfgInfo[CommEnum.FilterKind.QualityFilter]

		self._qualityFilterTab = self:parseTypeCfg(rule_cfg)
	end

	return self._qualityFilterTab
end

function M:parseTypeCfg(rule)
	local split_char = "#"

	return string.splitToNumber(rule.filters, split_char)
end

M.instance = M.New()

return M
