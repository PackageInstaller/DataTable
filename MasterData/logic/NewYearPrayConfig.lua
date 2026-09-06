-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/config/NewYearPrayConfig.lua

module("logic.extensions.newyearpray.config.NewYearPrayConfig", package.seeall)

local NewYearPrayConfig = class("NewYearPrayConfig", BaseConfig)

function NewYearPrayConfig:onInit()
	NewYearPrayConfig.super.onInit(self)
end

function NewYearPrayConfig:getNames()
	return {
		"new_year_pray_activity",
		"new_year_pray_common",
		"new_year_pray_progress",
		"new_year_pray_step",
		"new_year_pray_wishing_tab",
		"new_year_pray_wishing_lantern",
		"new_year_pray_burn",
		"new_year_pray_burn_point",
		"new_year_pray_burn_progress",
		"new_year_pray_bubble"
	}
end

function NewYearPrayConfig:handleConfig(name, content)
	if name == "new_year_pray_activity" then
		self._nypActCfg = content
	elseif name == "new_year_pray_common" then
		self._nypCommonCfg = content
	elseif name == "new_year_pray_progress" then
		self._nypProgressCfgs = content
	elseif name == "new_year_pray_step" then
		self._nypStepCfgss = content
	elseif name == "new_year_pray_wishing_tab" then
		self._nypWishingTabCfgs = content
	elseif name == "new_year_pray_wishing_lantern" then
		self._nypWishingLanternCfg = content
	elseif name == "new_year_pray_burn" then
		self._nypBurnCfg = content
	elseif name == "new_year_pray_burn_point" then
		self._nypBurnPointCfgs = content
	elseif name == "new_year_pray_burn_progress" then
		self._nypBurnProgressCfgs = content
	elseif name == "new_year_pray_bubble" then
		self._nypBubbleCfg = content
	end
end

function NewYearPrayConfig:getNypActData(activityId)
	return self._nypActCfg[activityId]
end

function NewYearPrayConfig:getNypCommonData(activityId)
	local actData = self:getNypActData(activityId)

	if actData then
		return self._nypCommonCfg[actData.comPlanId]
	end
end

function NewYearPrayConfig:getNypCommonValue(activityId, key)
	local data = self:getNypCommonData(activityId)

	if data then
		return data[key]
	end
end

function NewYearPrayConfig:getNypProgressCfg(activityId)
	return self._nypProgressCfgs[activityId]
end

function NewYearPrayConfig:getNypProgressData(activityId, dataBitId)
	if self._nypProgressCfgs[activityId] then
		return self._nypProgressCfgs[activityId][dataBitId]
	end
end

function NewYearPrayConfig:getNypStepCfgs(activityId)
	return self._nypStepCfgss[activityId]
end

function NewYearPrayConfig:getNypStepCfg(activityId, stepId)
	if self._nypStepCfgss[activityId] then
		return self._nypStepCfgss[activityId][stepId]
	end
end

function NewYearPrayConfig:getNypStepData(activityId, stepId, choiceId)
	if self._nypStepCfgss[activityId] and self._nypStepCfgss[activityId][stepId] then
		return self._nypStepCfgss[activityId][stepId][choiceId]
	end
end

function NewYearPrayConfig:getNypWishingTabCfgByAct(activityId)
	local actData = self:getNypActData(activityId)

	if actData then
		return self._nypWishingTabCfgs[actData.wishingPlanId]
	end
end

function NewYearPrayConfig:getNypWishingTabDataByAct(activityId, tabId)
	local cfg = self:getNypWishingTabCfgByAct(activityId)

	if cfg then
		return cfg[tabId]
	end
end

function NewYearPrayConfig:getNypWishingLanternData(lanternId)
	return self._nypWishingLanternCfg[lanternId]
end

function NewYearPrayConfig:getNypBurnDataByAct(activityId)
	local actData = self:getNypActData(activityId)

	if actData then
		return self._nypBurnCfg[actData.burnPlanId]
	end
end

function NewYearPrayConfig:getNypBurnPointCfgByAct(activityId)
	local actData = self:getNypActData(activityId)

	if actData then
		return self._nypBurnPointCfgs[actData.burnPlanId]
	end
end

function NewYearPrayConfig:getNypBurnPointDataByAct(activityId, burnPointId)
	local cfg = self:getNypBurnPointCfgByAct(activityId)

	if cfg then
		return cfg[burnPointId]
	end
end

function NewYearPrayConfig:getNypBurnProgressCfgByAct(activityId)
	local actData = self:getNypActData(activityId)

	if actData then
		return self._nypBurnProgressCfgs[actData.burnPlanId]
	end
end

function NewYearPrayConfig:getNypBurnProgressDataByAct(activityId, burnProgressId)
	local cfg = self:getNypBurnProgressCfgByAct(activityId)

	if cfg then
		return cfg[burnProgressId]
	end
end

function NewYearPrayConfig:getNypBubbleData(bubbleId)
	return self._nypBubbleCfg[bubbleId]
end

NewYearPrayConfig.instance = NewYearPrayConfig.New()

return NewYearPrayConfig
