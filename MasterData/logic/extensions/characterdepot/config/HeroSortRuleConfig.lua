-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/config/HeroSortRuleConfig.lua

module("logic.extensions.characterdepot.config.HeroSortRuleConfig", package.seeall)

local M = class("HeroSortRuleConfig", BaseConfig)

M._heroDepot = 1
M._team = 2
M._display = 3

function M:onInit()
	self._cfgInfo = false
end

function M:getNames()
	return {
		ConfigName.HeroSortRule,
		ConfigName.HeroFilterConst
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.HeroSortRule then
		self._cfgInfo = content
	elseif name == ConfigName.HeroFilterConst then
		self._filterConst = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getFilterConst()
	return self._filterConst
end

function M:getDepotFilterTagIds()
	local const = self:getFilterConst()

	return const.DepotTagList.numValues
end

function M:getCfgInfoByID(code)
	local dataCO = self._cfgInfo[code]

	if code > 0 and not dataCO and enableErrorLog then
		printError(string.format("HeroSortRuleConfig::cannot find hero sort config for id[%s]", code))
	end

	return dataCO
end

function M:getHeroDepotRule()
	if not self._heroDepotRuleTab then
		local rule_cfg = self._cfgInfo[M._heroDepot]

		self._heroDepotRuleTab = self:parseRuleCfg(rule_cfg)
	end

	return self._heroDepotRuleTab
end

function M:getTeamRule()
	if not self._teamRuleTab then
		local rule_cfg = self._cfgInfo[M._team]

		self._teamRuleTab = self:parseRuleCfg(rule_cfg)
	end

	return self._teamRuleTab
end

function M:getDisplayRule()
	if not self._displayRuleTab then
		local rule_cfg = self._cfgInfo[M._display]

		self._displayRuleTab = self:parseRuleCfg(rule_cfg)
	end

	return self._displayRuleTab
end

function M:getShowExtraState(sortType)
	if not self._sortExtraRule then
		local sortExtra = ConstConfig.instance:getStrValueByKey(ConstConfigKeyEnum.TeamSortExtra)

		self._sortExtraRule = self:_parseConstRuleCfg(sortExtra)
	end

	for _, v in pairs(self._sortExtraRule) do
		if sortType == v then
			return true
		end
	end

	return false
end

function M:_parseConstRuleCfg(rule)
	local split_char = "#"

	return string.splitToNumber(rule, split_char)
end

function M:parseRuleCfg(rule)
	local ret = {}
	local split_char = "#"

	ret[CommEnum.HeroSortFieldType.Id] = string.splitToNumber(rule.code, split_char)
	ret[CommEnum.HeroSortFieldType.Default] = string.splitToNumber(rule.defaultRule, split_char)
	ret[CommEnum.HeroSortFieldType.Level] = string.splitToNumber(rule.level, split_char)
	ret[CommEnum.HeroSortFieldType.Authority] = string.splitToNumber(rule.authority, split_char)
	ret[CommEnum.HeroSortFieldType.Quality] = string.splitToNumber(rule.quality, split_char)
	ret[CommEnum.HeroSortFieldType.Breakthrough] = string.splitToNumber(rule.breakthrough, split_char)
	ret[CommEnum.HeroSortFieldType.Tacit] = string.splitToNumber(rule.tacit, split_char)
	ret[CommEnum.HeroSortFieldType.MaxHp] = string.splitToNumber(rule.maxHp, split_char)
	ret[CommEnum.HeroSortFieldType.Atk] = string.splitToNumber(rule.attack, split_char)
	ret[CommEnum.HeroSortFieldType.Def] = string.splitToNumber(rule.defense, split_char)
	ret[CommEnum.HeroSortFieldType.MagicAtk] = string.splitToNumber(rule.yitaiAttack, split_char)
	ret[CommEnum.HeroSortFieldType.MagicDef] = string.splitToNumber(rule.yitaiDefense, split_char)
	ret[CommEnum.HeroSortFieldType.Sanity] = string.splitToNumber(rule.sanity, split_char)

	return ret
end

M.instance = M.New()

return M
