-- chunkname: @projbooter/utils/VersionUtil.lua

module("projbooter.utils.VersionUtil", package.seeall)

local VersionUtil = {}

function VersionUtil.versionStrToNumber(versionStr)
	local numArray = string.splitToNumber(versionStr, ".")

	return numArray[1] * 10000 + numArray[2] * 100 + numArray[3]
end

function VersionUtil.compareVersion(versionAStr, versionBStr)
	local versionANum = VersionUtil.versionStrToNumber(versionAStr)
	local versionBNum = VersionUtil.versionStrToNumber(versionBStr)

	if versionANum < versionBNum then
		return -1
	elseif versionBNum < versionANum then
		return 1
	end

	return 0
end

function VersionUtil.isVersionLarger(targetVersionStr)
	local currentVersionStr = UnityEngine.Application.version
	local result = VersionUtil.compareVersion(currentVersionStr, targetVersionStr)

	return result > 0
end

function VersionUtil.isVersionLargeEqual(targetVersionStr)
	local currentVersionStr = UnityEngine.Application.version
	local result = VersionUtil.compareVersion(currentVersionStr, targetVersionStr)

	return result >= 0
end

function VersionUtil.isVersionLess(targetVersionStr)
	local currentVersionStr = UnityEngine.Application.version
	local result = VersionUtil.compareVersion(currentVersionStr, targetVersionStr)

	return result < 0
end

function VersionUtil.isVersionLessEqual(targetVersionStr)
	local currentVersionStr = UnityEngine.Application.version
	local result = VersionUtil.compareVersion(currentVersionStr, targetVersionStr)

	return result <= 0
end

function VersionUtil.isVersionEqual(targetVersionStr)
	local currentVersionStr = UnityEngine.Application.version
	local result = VersionUtil.compareVersion(currentVersionStr, targetVersionStr)

	return result == 0
end

function VersionUtil.isVersionNotEqual(targetVersionStr)
	local currentVersionStr = UnityEngine.Application.version
	local result = VersionUtil.compareVersion(currentVersionStr, targetVersionStr)

	return result ~= 0
end

return VersionUtil
