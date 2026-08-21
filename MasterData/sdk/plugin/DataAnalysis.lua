-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\DataAnalysis.lua

local DataAnalysis = {}
local PluginConfig = require("SDK/Plugin/PluginConfig")
local DeviceHelper = require("Helper/DeviceHelper")
local DataAnalysisAgent = Framework.Plugin.DataAnalysisAgent
local platform = DeviceHelper.runtimePlatform
local INVALID_PARAM = "Unknown"

function DataAnalysis.setStrategyList(newStrategyNoList)
	DataAnalysisAgent.SetStrategyList(newStrategyNoList or {
		0
	})
end

function DataAnalysis.initList(newStrategyNoList)
	local channelID = ChannelUtil.getChannelID()
	local subChannelID = ChannelUtil.getSubChannelID()

	if subChannelID and subChannelID ~= "" then
		channelID = string.format("%s-%s", channelID, subChannelID)
	end

	for _, strategyNo in ipairs(newStrategyNoList) do
		local appID = PluginConfig.DATA_ANALYSIS_APP_ID[strategyNo]

		if type(appID) == "table" then
			appID = appID[platform] or ""
		end

		DataAnalysisAgent.OnInit(strategyNo, appID, channelID)
	end
end

function DataAnalysis.onStart()
	DataAnalysisAgent.OnStart()
end

function DataAnalysis.onEnd()
	DataAnalysisAgent.OnEnd()
end

function DataAnalysis.onPause()
	DataAnalysisAgent.OnPause()
end

function DataAnalysis.onResume()
	DataAnalysisAgent.OnResume()
end

function DataAnalysis.setNewAccount(openID)
	local _openID = tostring(openID) or INVALID_PARAM

	DataAnalysisAgent.SetNewAccount(_openID)
end

function DataAnalysis.setAccount(openID)
	local _openID = tostring(openID) or INVALID_PARAM

	DataAnalysisAgent.SetAccount(_openID)
end

function DataAnalysis.setGameServer(serverID)
	local _serverID = tostring(serverID) or INVALID_PARAM

	DataAnalysisAgent.SetGameServer(_serverID)
end

function DataAnalysis.setLevel(level)
	local _level = tonumber(level) or 0

	DataAnalysisAgent.SetLevel(_level)
end

function DataAnalysis.missionBegin(missionID)
	local _missionID = tostring(missionID) or INVALID_PARAM

	DataAnalysisAgent.MissionBegin(_missionID)
end

function DataAnalysis.missionFailed(missionID, reason)
	local _missionID = tostring(missionID) or INVALID_PARAM
	local _reason = tostring(reason) or INVALID_PARAM

	DataAnalysisAgent.MissionFailed(_missionID, _reason)
end

function DataAnalysis.missionCompleted(missionID)
	local _missionID = tostring(missionID) or INVALID_PARAM

	DataAnalysisAgent.MissionCompleted(_missionID)
end

function DataAnalysis.paymentStart(transactionId, paymentType, currencyType, currencyAmount)
	local _transactionId = tostring(transactionId) or INVALID_PARAM

	DataAnalysisAgent.SetPaymentStart(_transactionId, paymentType, currencyType, currencyAmount)
end

function DataAnalysis.paymentSucc(transactionId, paymentType, currencyType, currencyAmount)
	local _transactionId = tostring(transactionId) or INVALID_PARAM

	DataAnalysisAgent.SetPaymentSucc(_transactionId, paymentType, currencyType, currencyAmount)
end

function DataAnalysis.CustomEvent(eventName, extraInfo)
	local _eventName = tostring(eventName) or INVALID_PARAM

	DataAnalysisAgent.CustomEvent(_eventName, _extraInfo)
end

return DataAnalysis
