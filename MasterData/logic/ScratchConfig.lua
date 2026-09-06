-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/config/ScratchConfig.lua

module("logic.extensions.scratch.config.ScratchConfig", package.seeall)

local ScratchConfig = class("ScratchConfig", BaseConfig)

function ScratchConfig:onInit()
	ScratchConfig.super.onInit(self)

	self._scratchActivityCfg = nil
	self._scratchTaskCfg = nil
	self._scratchParamsCfg = nil
	self._scratchBigPrizeCfg = nil
	self._scratchNormalPrizeCfg = nil
end

function ScratchConfig:getNames()
	return {
		"scratch_activity",
		"scratch_task",
		"scratch_params",
		"scratch_big_prize",
		"scratch_normal_prize"
	}
end

function ScratchConfig:handleConfig(name, content)
	if name == "scratch_activity" then
		self._scratchActivityCfg = content
	elseif name == "scratch_task" then
		self._scratchTaskCfg = content
	elseif name == "scratch_params" then
		self._scratchParamsCfg = content
	elseif name == "scratch_big_prize" then
		self._scratchBigPrizeCfg = content
	elseif name == "scratch_normal_prize" then
		self._scratchNormalPrizeCfg = content
	end
end

function ScratchConfig:getScratchActivityCfgById(id)
	return self._scratchActivityCfg[id]
end

function ScratchConfig:getScratchPrizeCfg(planId, id, isBigPrize)
	if isBigPrize then
		if self._scratchBigPrizeCfg[planId] then
			return self._scratchBigPrizeCfg[planId][id]
		end

		return nil
	else
		if self._scratchNormalPrizeCfg[planId] then
			return self._scratchNormalPrizeCfg[planId][id]
		end

		return nil
	end
end

function ScratchConfig:getBigPrizeSortCfgs(planId)
	if self._bigPrizeSortCfgs and self._bigPrizeSortCfgs[planId] then
		return self._bigPrizeSortCfgs[planId]
	else
		self._bigPrizeSortCfgs = self._bigPrizeSortCfgs or {}
		self._bigPrizeSortCfgs[planId] = self._bigPrizeSortCfgs[planId] or {}

		for i, v in ipairs(self._scratchBigPrizeCfg.dataList) do
			if v.planId == planId then
				table.insert(self._bigPrizeSortCfgs[planId], v)
			end
		end

		return self._bigPrizeSortCfgs[planId]
	end
end

function ScratchConfig:getScratchTaskCfg(id)
	return self._scratchTaskCfg[id]
end

function ScratchConfig:getScratchParamsCfg(key)
	return self._scratchParamsCfg[key]
end

ScratchConfig.instance = ScratchConfig.New()

return ScratchConfig
