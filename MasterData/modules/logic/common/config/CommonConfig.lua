-- chunkname: @modules/logic/common/config/CommonConfig.lua

module("modules.logic.common.config.CommonConfig", package.seeall)

local CommonConfig = class("CommonConfig", BaseConfig)

function CommonConfig:reqConfigNames()
	return {
		"const",
		"cpu_level",
		"gpu_level",
		"toast",
		"messagebox",
		"gm_command",
		"activity155_drop",
		"activity155_const"
	}
end

function CommonConfig:onConfigLoaded(configName, configTable)
	if configName == "cpu_level" then
		self._cpuLevelDict = {}

		for _, co in ipairs(configTable.configList) do
			local name = self:_getStr(co.name)

			self._cpuLevelDict[name] = co.level
		end
	elseif configName == "gpu_level" then
		self._gpuLevelDict = {}

		for _, co in ipairs(configTable.configList) do
			local name = self:_getStr(co.name)

			self._gpuLevelDict[name] = co.level
		end
	end
end

function CommonConfig:getCPULevel(cpuName)
	cpuName = self:_getStr(cpuName)

	if LuaUtil.isEmptyStr(cpuName) then
		return ModuleEnum.Performance.Undefine
	end

	local level = self._cpuLevelDict[cpuName]

	if level then
		return level
	end

	for oneName, level in pairs(self._cpuLevelDict) do
		if string.find(oneName, cpuName) or string.find(cpuName, oneName) then
			return level
		end
	end

	return ModuleEnum.Performance.Undefine
end

function CommonConfig:getGPULevel(gpuName)
	gpuName = self:_getStr(gpuName)

	if LuaUtil.isEmptyStr(gpuName) then
		return ModuleEnum.Performance.Undefine
	end

	local level = self._gpuLevelDict[gpuName]

	if level then
		return level
	end

	for oneName, level in pairs(self._gpuLevelDict) do
		if string.find(oneName, gpuName) or string.find(gpuName, oneName) then
			return level
		end
	end

	return ModuleEnum.Performance.Undefine
end

function CommonConfig:_getStr(str)
	return string.gsub(string.lower(str), "%s+", "")
end

function CommonConfig:getConstNum(constId)
	local constStr = self:getConstStr(constId)

	if string.nilorempty(constStr) then
		return 0
	else
		return tonumber(constStr)
	end
end

function CommonConfig:getConstStr(constId)
	local constCO = lua_const.configDict[constId]

	if not constCO then
		printError("const not exist: ", constId)

		return nil
	end

	local value = constCO.value

	if not string.nilorempty(value) then
		return value
	end

	return constCO.value2
end

function CommonConfig:getAct155CurrencyRatio()
	local co = lua_activity155_const.configDict[1]
	local ratio = string.splitToNumber(co.value2, "#")

	return (ratio or nil) and (ratio[2] or 0)
end

function CommonConfig:getAct155EpisodeDisplay()
	local co = lua_activity155_const.configDict[3]
	local ratio = string.splitToNumber(co.value2, "#")

	return ratio[1], ratio[2]
end

CommonConfig.instance = CommonConfig.New()

return CommonConfig
