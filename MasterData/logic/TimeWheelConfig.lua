-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/config/TimeWheelConfig.lua

module("logic.extensions.timewheel.config.TimeWheelConfig", package.seeall)

local TimeWheelConfig = class("TimeWheelConfig", BaseConfig)

function TimeWheelConfig:onInit()
	TimeWheelConfig.super.onInit(self)

	self._timeWheelDecomposePetCfg = nil
	self._timeWheelResetStrengthen = nil
	self._timeWheelRevertAwaken = nil
	self._timeWheelExplain = nil
	self._resetLevelTimes = nil
	self._petOverflowCfg = nil
	self._timeWheelFilter = nil
end

function TimeWheelConfig:getNames()
	return {
		"time_wheel_decompose_pet",
		"time_wheel_reset_strengthen",
		"time_wheel_revert_awaken",
		"time_wheel_explain",
		"time_wheel_reset_level_times",
		"pet_overflow",
		"time_wheel_filter"
	}
end

function TimeWheelConfig:handleConfig(name, content)
	if name == "time_wheel_decompose_pet" then
		self._timeWheelDecomposePetCfg = content
	elseif name == "time_wheel_reset_strengthen" then
		self._timeWheelResetStrengthen = content
	elseif name == "time_wheel_revert_awaken" then
		self._timeWheelRevertAwaken = content
	elseif name == "time_wheel_explain" then
		self._timeWheelExplain = content
	elseif name == "time_wheel_reset_level_times" then
		self._resetLevelTimes = content
	elseif name == "pet_overflow" then
		self._petOverflowCfg = content
	elseif name == "time_wheel_filter" then
		self._timeWheelFilter = content
	end
end

function TimeWheelConfig:getDecomposeParamCfg(str)
	return self._timeWheelDecomposePetCfg[str]
end

function TimeWheelConfig:getResetParamCfg(str)
	return self._timeWheelResetStrengthen[str]
end

function TimeWheelConfig:getRevertParamCfg(str)
	return self._timeWheelRevertAwaken[str]
end

function TimeWheelConfig:getExplainCfg(id)
	return self._timeWheelExplain[id]
end

function TimeWheelConfig:getResetCount(roleLevel)
	if self._resetLevelTimes[roleLevel] then
		return self._resetLevelTimes[roleLevel].paramValue
	else
		return 1
	end
end

function TimeWheelConfig:getScoreNum(rare)
	if self._petOverflowCfg[rare] then
		return self._petOverflowCfg[rare].scoreNum
	else
		return 0
	end
end

function TimeWheelConfig:getPetFilterCfg(raceId)
	return self._timeWheelFilter[raceId]
end

function TimeWheelConfig:getPetListByType(index)
	local list = {}

	for i, v in ipairs(self._timeWheelFilter.dataList) do
		if v[index] == true then
			table.insert(list, v)
		end
	end

	return list
end

TimeWheelConfig.instance = TimeWheelConfig.New()

return TimeWheelConfig
