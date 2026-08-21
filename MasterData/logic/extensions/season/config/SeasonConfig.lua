-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/config/SeasonConfig.lua

module("logic.extensions.season.config.SeasonConfig", package.seeall)

local M = class("SeasonConfig", BaseConfig)

function M:onInit()
	self._dictLoopCount = {}
end

function M:getNames()
	return {
		ConfigName.Season,
		ConfigName.SeasonLv,
		ConfigName.SeasonTask,
		ConfigName.SeasonConst,
		ConfigName.SeasonLabelSchedule
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.SeasonLv then
		self:_initLoopCount()
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getConfigByDoubleKey(cfgName, key1, key2)
	local cfg = self:getConfigByKey(cfgName, key1)

	if cfg then
		return cfg[key2]
	end
end

function M:_initLoopCount()
	local cfgList = self:getConfigList(ConfigName.Season)

	for _, cfg in ipairs(cfgList) do
		local seasonId = cfg.id

		for i = 1, 99 do
			if self:getConfigByDoubleKey(ConfigName.SeasonLv, seasonId, -i) then
				self._dictLoopCount[seasonId] = i
			else
				break
			end
		end
	end
end

function M:getLevelCfg(seasonId, lv)
	local limitLv = self:getLimitLv(seasonId)
	local loopCount = self:getLoopCount(seasonId)

	if limitLv < lv then
		local v = math.fmod(lv - limitLv, loopCount)

		v = v == 0 and loopCount or v

		return self:getConfigByDoubleKey(ConfigName.SeasonLv, seasonId, -v)
	else
		return self:getConfigByDoubleKey(ConfigName.SeasonLv, seasonId, lv)
	end
end

function M:getTaskCfgList(seasonId, type)
	local list = {}
	local cfgList = self:getConfigList(ConfigName.SeasonTask)

	for _, cfg in ipairs(cfgList) do
		if cfg.label == type and cfg.seasonId == seasonId then
			table.insert(list, cfg)
		end
	end

	return list
end

function M:getLimitLv(seasonId)
	local cfg = self:getConfigByKey(ConfigName.Season, seasonId)

	return cfg.loopStartLv
end

function M:getFinalRewardContent(seasonId)
	local cfg = self:getConfigByKey(ConfigName.Season, seasonId)

	return cfg and cfg.finalRewardContent
end

function M:getFinalRewardLv(seasonId)
	local cfg = self:getConfigByKey(ConfigName.Season, seasonId)

	return cfg and cfg.finalRewardLv
end

function M:getSeasonName(seasonId)
	local cfg = self:getConfigByKey(ConfigName.Season, seasonId)

	return cfg and cfg.name
end

function M:getPreviewRewrad(seasonId)
	local cfg = self:getConfigByKey(ConfigName.Season, seasonId)

	return cfg and cfg.previewRewrad
end

function M:getLoopCount(seasonId)
	return self._dictLoopCount[seasonId]
end

function M:getMaxLv()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "MaxLv")

	return cfg.numValue
end

function M:getScorePerLv()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "UpgradePoint")

	return cfg.numValue
end

function M:getUpgradeLvMoneyCode()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "LvMoney")

	return cfg.numValue
end

function M:getUpgradeLvMoneyNum()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "LvMoneyNum")

	return cfg.numValue
end

function M:getVipCostCode()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "VipMoney")

	return cfg.numValue
end

function M:getVip1Cost()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "Vip1")

	return cfg.numValue
end

function M:getVip2Cost()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "Vip2")

	return cfg.numValue
end

function M:getVip2HalfCost()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "Vip2_1")

	return cfg.numValue
end

function M:getVip2GiveLv()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "Vip2GiveLv")

	return cfg.numValue
end

function M:getSpecialLvInterval()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "SpecialLvInterval")

	return cfg.numValue
end

function M:getLoopRewardAddLvCount()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "LoopAddLv")

	return cfg.numValue
end

function M:getVip1GoodsId()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "Vip1GoodsId")

	return cfg.numValue
end

function M:getUpgradeVip2GoodsId()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "UpgradeVip2GoodsId")

	return cfg.numValue
end

function M:getVip2GoodsId()
	local cfg = self:getConfigByKey(ConfigName.SeasonConst, "Vip2GoodsId")

	return cfg.numValue
end

function M:getLabelSchedule()
	return self:getConfig(ConfigName.SeasonLabelSchedule)
end

function M:getDailyProgressReward(seasonId)
	local scheduleCO = self:getLabelSchedule()
	local seasonProgress = scheduleCO[seasonId]
	local result = {}

	for _, co in ipairs(seasonProgress or {}) do
		if co.label == SeasonEnum.TaskType.dayOnce then
			table.insert(result, co)
		end
	end

	return result
end

function M:getWeeklyProgressReward(seasonId)
	local scheduleCO = self:getLabelSchedule()
	local seasonProgress = scheduleCO[seasonId]
	local result = {}

	for _, co in ipairs(seasonProgress) do
		if co.label == SeasonEnum.TaskType.Weekly then
			table.insert(result, co)
		end
	end

	return result
end

M.instance = M.New()

return M
