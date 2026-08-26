-- chunkname: @modules/logic/optionpackage/utils/OptionPackageHelper.lua

module("modules.logic.optionpackage.utils.OptionPackageHelper", package.seeall)

local OptionPackageHelper = {}

function OptionPackageHelper.formatLangPackName(lang, packeName)
	return string.format("%s-%s", lang, packeName)
end

function OptionPackageHelper.getLeftSizeMBorGB(size, localSize)
	localSize = localSize or 0

	local leftSize = math.max(0, size - localSize)
	local denominator = 1073741824
	local ret = leftSize / denominator
	local units = "GB"

	if ret < 0.1 then
		denominator = 1048576
		ret = leftSize / 1048576
		units = "MB"

		if leftSize / 1048576 < 0.01 then
			ret = 0.01
		end
	end

	return ret, math.max(0.01, size / denominator), units
end

function OptionPackageHelper.getLeftSizeMBNum(size, localSize)
	localSize = localSize or 0

	local leftSize = math.max(0, size - localSize)
	local denominator = 1048576
	local ret = leftSize / denominator

	if ret < 0.01 then
		ret = 0.01
	end

	return ret
end

return OptionPackageHelper
