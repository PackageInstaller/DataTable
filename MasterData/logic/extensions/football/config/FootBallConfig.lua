-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/config/FootBallConfig.lua

module("logic.extensions.football.config.FootBallConfig", package.seeall)

local M = class("FootBallConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.FootballConstant
	}
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConstNum(key)
	local cfg = self:getConfig(ConfigName.FootballConstant)

	if cfg then
		return cfg[key].numValue or 0
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.FootballConstant, key))
end

function M:getConstNumList(key)
	local cfg = self:getConfig(ConfigName.FootballConstant)

	if cfg then
		return cfg[key].numValues or 0
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.FootballConstant, key))
end

function M:getConstString(key)
	local cfg = self:getConfig(ConfigName.FootballConstant)

	if cfg then
		return cfg[key].strValue
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.FootballConstant, key))
end

function M:getConstJson(key)
	local cfg = self:getConfig(ConfigName.FootballConstant)

	if cfg then
		return cfg[key].jsonObjects
	end

	printError(string.format("在表：t_%s中找不到对应配置,%s", ConfigName.FootballConstant, key))
end

M.instance = M.New()

return M
