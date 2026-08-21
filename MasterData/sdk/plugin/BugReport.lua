-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\BugReport.lua

local BugReport = {}
local PluginConfig = require("SDK/Plugin/PluginConfig")
local BugReportAgent = Framework.Plugin.BugReportAgent
local VersionUtils = require("System/VersionUtils")
local INVALID_PARAM = "Unknown"

function BugReport.setStrategy(newStrategyNo)
	BugReportAgent.SetStrategy(newStrategyNo or 0)
end

function BugReport.init(newStrategyNo)
	local strategyNo = newStrategyNo or 0
	local appID

	if strategyNo == PluginConfig.BUG_REPORT_STRAT_BUGLY then
		appID = PluginConfig.getBuglyAppID() or "_INVALID_BUGLY_KEY"
	elseif strategyNo == PluginConfig.BUG_REPORT_STRAT_DUMMY then
		appID = "BugReportAppIDDummy"
	end

	local reporterType = 1
	local logLevel = 1
	local channel = string.format("%s|%s", ChannelUtil.getChannelID(), ChannelUtil.getSubChannelID())
	local version = tostring(VersionUtils.getDocumentPatchVersion())
	local SDKAppUtils = require("SDK/SDKAppUtils")
	local user = SDKAppUtils.getNativeDeviceID() or ""

	BugReportAgent.ConfigCrashReporter(reporterType, logLevel, 0, channel, version, user)
	BugReportAgent.ConfigDebugMode(false)
	BugReportAgent.Init(appID)

	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		BugReportAgent.EnableExceptionHandler()
	end
end

function BugReport.setUserId(userId)
	local _userId = tostring(userId) or INVALID_PARAM

	BugReportAgent.SetUserId(_userId)
end

function BugReport.setScene(sceneId)
	local _sceneId = tonumber(sceneId) or 0

	BugReportAgent.SetScene(_sceneId)
end

function BugReport.configDebugMode(enable)
	local _enable = enable == true

	BugReportAgent.ConfigDebugMode(_enable)
end

function BugReport.configCrashReporter(type, logLevel)
	local _type = tonumber(type) or 0
	local _logLevel = tonumber(logLevel) or 1

	BugReportAgent.ConfigCrashReporter(_type, _logLevel)
end

function BugReport.reportException(name, message, stackTrace)
	local _name = tostring(name) or INVALID_PARAM
	local _message = tostring(message) or INVALID_PARAM
	local _stackTrace = tostring(stackTrace) or INVALID_PARAM

	BugReportAgent.ReportException(_name, _message, _stackTrace)
end

function BugReport.addSceneData(key, value)
	BugReportAgent.AddSceneData(key, tostring(value))
end

return BugReport
