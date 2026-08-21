-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\CustomerService.lua

local CustomerService = {}
local PluginConfig = require("SDK/Plugin/PluginConfig")
local CustomerServiceAgent = Framework.Plugin.CustomerServiceAgent
local INVALID_PARAM = "Unknown"

function CustomerService.setStrategy(newStrategyNo)
	CustomerServiceAgent.SetStrategy(newStrategyNo or 0)
end

function CustomerService.init(strategyNo)
	local strategyNo = strategyNo or 0
	local appKey, domain, appID

	if strategyNo == PluginConfig.CUSTOMER_SERVICE_STRAT_ELVA then
		appKey = PluginConfig.CUSTOMER_SERVICE_ELVA_APP_KEY
		domain = PluginConfig.CUSTOMER_SERVICE_ELVA_DOMAIN
		appID = PluginConfig.CUSTOMER_SERVICE_ELVA_APP_ID
	elseif strategyNo == PluginConfig.CUSTOMER_SERVICE_STRAT_DUMMY then
		appKey = "CustomerServiceAppKeyDummy"
		domain = "CustomerServiceAppKeyDomain"
		appID = "CustomerServiceAppKeyAppID"
	end

	CustomerServiceAgent.Init("appKey", "domain", "appID")
end

function CustomerService.showMain(showConversation)
	local deviceID = UnityEngine.SystemInfo.deviceUniqueIdentifier
	local uid = CurAvatar and CurAvatar.uid or deviceID or INVALID_PARAM
	local name = deviceID or INVALID_PARAM
	local NetService = require("Framework/NetService")
	local serverID = NetService._serviceName or "UN_SELECTED_SERVER"

	CustomerServiceAgent.ShowMain(uid, name, serverID, showConversation or "1")
end

function CustomerService.showFAQs()
	CustomerServiceAgent.showFAQs()
end

function CustomerService.setName(name)
	local _name = tostring(name) or INVALID_PARAM

	CustomerServiceAgent.SetName(_name)
end

function CustomerService.setUserId(uid)
	local _uid = tostring(uid) or INVALID_PARAM

	CustomerServiceAgent.SetUserId(_uid)
end

function CustomerService.setUserName(userName)
	local _userName = tostring(userName) or INVALID_PARAM

	CustomerServiceAgent.SetUserName(_userName)
end

function CustomerService.setServerId(serverID)
	local _serverID = tostring(serverID) or INVALID_PARAM

	CustomerServiceAgent.SetServerId(_serverID)
end

return CustomerService
