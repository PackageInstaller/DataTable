-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/config/SpecialtrainingConfig.lua

module("logic.extensions.specialtraining.config.SpecialtrainingConfig", package.seeall)

local M = class("SpecialtrainingConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.TrainPlan,
		ConfigName.TrainStage,
		ConfigName.TrainTask
	}
end

function M:getTrainPlanCfgAll()
	local cfgs = self._dict[ConfigName.TrainPlan].dataList

	return cfgs
end

function M:getTrainPlanCfg(code)
	local cfgs = self._dict[ConfigName.TrainPlan].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.id == tonumber(code) then
			return cfg
		end
	end
end

function M:getTrainStageCfg(code)
	local cfgs = self._dict[ConfigName.TrainStage].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.id == tonumber(code) then
			return cfg
		end
	end
end

function M:getTrainTaskCfg(code)
	local cfgs = self._dict[ConfigName.TrainTask].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.id == tonumber(code) then
			return cfg
		end
	end
end

function M:getTrainTaskAllCfg()
	return self._dict[ConfigName.TrainTask].dataList
end

M.instance = M.New()

return M
