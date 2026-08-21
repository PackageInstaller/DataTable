-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/exp/CharacterExpConfig.lua

module("logic.extensions.charactersystem.config.exp.CharacterExpConfig", package.seeall)

local M = class("CharacterExpConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.CharacterUpgrade,
		ConfigName.CharacterUpgradeConst,
		ConfigName.CharacterLevelLimit
	}
end

function M:getInfo(id)
	local tableInfo = self._dict[ConfigName.CharacterUpgrade]
	local findInfo = tableInfo and tableInfo[id] or false

	if not findInfo then
		printError(string.format("没有对应等级%d升级配置", id))
	end

	return findInfo
end

function M:getUpgradeCO()
	return self._dict[ConfigName.CharacterUpgrade]
end

function M:getUpgradeExpByLevelAndQuality(level, quality)
	local upgradeCO = self:getUpgradeCO()

	return upgradeCO[level][self:qualityToQualityStr(quality)]
end

function M:isMaxLevel(level)
	local upgradeCO = self:getUpgradeCO()
	local maxLength = #upgradeCO
	local maxLevel = upgradeCO[maxLength].level

	return level == maxLevel
end

function M:calcLevelProgress(level, quality, exp)
	local upgradeExp = self:getUpgradeExpByLevelAndQuality(level, quality)

	return exp / upgradeExp
end

function M:getIncreaseExp(characterParam)
	local upgradeLevelExp = 0

	if characterParam.newLevel == characterParam.oldLevel then
		upgradeLevelExp = self:getUpgradeExpByLevelAndQuality(characterParam.oldLevel, characterParam.quality)

		return math.max(characterParam.newExp - characterParam.oldExp, 0), false, upgradeLevelExp
	elseif characterParam.newLevel > characterParam.oldLevel then
		local levelTotalExp = 0

		for i = characterParam.oldLevel, characterParam.newLevel - 1 do
			levelTotalExp = levelTotalExp + self:getUpgradeExpByLevelAndQuality(i, characterParam.quality)
		end

		upgradeLevelExp = levelTotalExp
		levelTotalExp = levelTotalExp - characterParam.oldExp
		levelTotalExp = levelTotalExp + characterParam.newExp

		return levelTotalExp, true, upgradeLevelExp
	else
		return 0, false, upgradeLevelExp
	end
end

function M:getUpgradeConst(key)
	local tableInfo = self._dict[ConfigName.CharacterUpgradeConst]
	local findInfo = tableInfo and tableInfo[key] or false

	return findInfo.value
end

function M:getPowerLvAndQualityToLvLimit(powerLv, quality)
	local tableInfo = self._dict[ConfigName.CharacterLevelLimit]

	powerLv = powerLv + 1

	if powerLv == 0 then
		powerLv = 1
	end

	local maxLevel = 0

	for i = 1, powerLv do
		local findInfo = tableInfo and tableInfo[i] or false

		if not findInfo then
			printWarn(i, quality)
		end

		if findInfo[self:qualityToQualityStr(quality)] ~= 0 then
			maxLevel = findInfo[self:qualityToQualityStr(quality)]
		end
	end

	return maxLevel
end

function M:getMaxPowerLevelByQuality(quality)
	local tableInfo = self._dict[ConfigName.CharacterLevelLimit]

	for i = 1, #tableInfo do
		local findInfo = tableInfo and tableInfo[i] or false

		if not findInfo then
			printWarn(i, quality)
		end

		if findInfo[self:qualityToQualityStr(quality)] == 0 then
			return i - 1
		end
	end

	return #tableInfo - 1
end

function M:getPowerLvById(powerLv)
	local tableInfo = self._dict[ConfigName.CharacterLevelLimit]

	for idx, v in ipairs(tableInfo) do
		if v.powerLv == powerLv then
			return v.powerLv
		end
	end

	return self:getLowestPowerLv()
end

function M:getLowestPowerLv()
	return 1
end

function M:qualityToQualityStr(quality)
	return "qua" .. CommEnum.Quality2Name[quality]
end

M.instance = M.New()

return M
