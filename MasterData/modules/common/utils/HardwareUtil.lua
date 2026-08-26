-- chunkname: @modules/common/utils/HardwareUtil.lua

module("modules.common.utils.HardwareUtil", package.seeall)

local HardwareUtil = _M
local curLevel
local by = "none"

function HardwareUtil.getPerformanceGrade()
	if not curLevel then
		local deviceName = UnityEngine.SystemInfo.deviceModel
		local cpuName = BootNativeUtil.getCpuName()
		local gpuName = UnityEngine.SystemInfo.graphicsDeviceName
		local memory = UnityEngine.SystemInfo.systemMemorySize

		logNormal("DeviceName: " .. (deviceName or "nil") .. "\nCPU: " .. (cpuName or "nil") .. "\n" .. "GPU: " .. (gpuName or "nil") .. "\n" .. "Memory: " .. (memory or "nil"))

		local cpuLevel = CommonConfig.instance:getCPULevel(cpuName or "")
		local gpuLevel = CommonConfig.instance:getGPULevel(gpuName or "")

		curLevel = ModuleEnum.Performance.High

		if cpuLevel ~= ModuleEnum.Performance.Undefine then
			curLevel = cpuLevel
			by = "cpu"
		elseif gpuLevel ~= ModuleEnum.Performance.Undefine then
			curLevel = gpuLevel
			by = "gpu"
		elseif memory then
			if BootNativeUtil.isIOS() then
				if memory <= 2048 then
					curLevel = ModuleEnum.Performance.Low
				elseif memory <= 4096 then
					curLevel = ModuleEnum.Performance.Middle
				end
			elseif memory <= 3072 then
				curLevel = ModuleEnum.Performance.Low
			elseif memory <= 5120 then
				curLevel = ModuleEnum.Performance.Middle
			end

			by = "memory"
		end
	end

	return curLevel, by
end

return HardwareUtil
