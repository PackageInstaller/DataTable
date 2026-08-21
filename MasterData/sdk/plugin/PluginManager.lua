-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\PluginManager.lua

local PluginManager = {}
local PluginConfig = require("SDK/Plugin/PluginConfig")
local CustomService = require("SDK/Plugin/CustomerService")
local DataAnalysis = require("SDK/Plugin/DataAnalysis")
local BugReport = require("SDK/Plugin/BugReport")
local PushNotification = require("SDK/Plugin/PushNotification")
local LocalNotification = require("SDK/Plugin/LocalNotification")
local NotificationManager = require("SDK/Plugin/NotificationManager")
local WebView = require("SDK/Plugin/WebView")
local SocialShare = require("SDK/Plugin/SocialShare")
local RemoteDebug = require("SDK/Plugin/RemoteDebug")
local SDKUtils = require("SDK/SDKUtils")
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local SDKAppUtils = require("SDK/SDKAppUtils")
local EventConst = require("EventConst")
local ARHelper = require("Helper/ARHelper")
local RemoteController = require("SDK/Plugin/RemoteController")
local PerformanceMonitor = require("SDK/Plugin/PerformanceMonitor")
local NativeHelper = require("Helper/NativeHelper")
local BugReportAgent = Framework.Plugin.BugReportAgent
local PermissionManager = Framework.Plugin.PermissionManager
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local platform = DeviceHelper.runtimePlatform
local stratIndex = IS_PUBLISH_VERSION and 2 or 1
local PluginType = {
	CUSTOMER_SERVICE = 1,
	WEB_VIEW = 7,
	GPM = 11,
	PUSH_NOTIFICATION = 5,
	REMOTE_DEBUG = 9,
	DATA_ANALYSIS = 2,
	LOCAL_NOTIFICATION = 4,
	SOCIAL_SHARE = 8,
	BUG_REPORT = 3,
	REMOTE_CONTROLLER = 10
}
local PluginStrategy = {
	[PluginType.CUSTOMER_SERVICE] = {
		PluginConfig.CUSTOMER_SERVICE_STRAT_DUMMY,
		PluginConfig.CUSTOMER_SERVICE_STRAT_DUMMY
	},
	[PluginType.DATA_ANALYSIS] = {
		{},
		{}
	},
	[PluginType.BUG_REPORT] = {
		PluginConfig.BUG_REPORT_STRAT_BUGLY,
		PluginConfig.BUG_REPORT_STRAT_BUGLY
	},
	[PluginType.LOCAL_NOTIFICATION] = {
		PluginConfig.LOCAL_NOTIFICATION_STRAT_STAN,
		PluginConfig.LOCAL_NOTIFICATION_STRAT_STAN
	},
	[PluginType.PUSH_NOTIFICATION] = {
		PluginConfig.PUSH_NOTIFICATION_STRAT_DUMMY,
		PluginConfig.PUSH_NOTIFICATION_STRAT_DUMMY
	},
	[PluginType.WEB_VIEW] = {
		PluginConfig.WEB_VIEW_STRAT_UNI,
		PluginConfig.WEB_VIEW_STRAT_UNI
	},
	[PluginType.SOCIAL_SHARE] = {
		PluginConfig.SOCIAL_SHARE_STRAT_MOB,
		PluginConfig.SOCIAL_SHARE_STRAT_MOB
	},
	[PluginType.REMOTE_DEBUG] = {
		PluginConfig.REMOTE_DEBUG_STRAT_DUMMY,
		PluginConfig.REMOTE_DEBUG_STRAT_DUMMY
	},
	[PluginType.REMOTE_CONTROLLER] = {
		PluginConfig.REMOTE_CONTROLLER_STRAT_DUMMY,
		PluginConfig.REMOTE_CONTROLLER_STRAT_DUMMY
	},
	[PluginType.GPM] = {
		PluginConfig.GPM_STRAT_DUMMY,
		PluginConfig.GPM_STRAT_MOB
	}
}
local PluginClass = {
	[PluginType.CUSTOMER_SERVICE] = CustomService,
	[PluginType.DATA_ANALYSIS] = DataAnalysis,
	[PluginType.BUG_REPORT] = BugReport,
	[PluginType.LOCAL_NOTIFICATION] = LocalNotification,
	[PluginType.PUSH_NOTIFICATION] = PushNotification,
	[PluginType.WEB_VIEW] = WebView,
	[PluginType.SOCIAL_SHARE] = SocialShare,
	[PluginType.REMOTE_DEBUG] = RemoteDebug,
	[PluginType.REMOTE_CONTROLLER] = RemoteController,
	[PluginType.GPM] = PerformanceMonitor
}

function PluginManager.init()
	NativeHelper.initPermissionRationale()
	NativeHelper.checkEmulator()
	PluginManager._initPlugin(PluginType.CUSTOMER_SERVICE)
	PluginManager._initPlugin(PluginType.DATA_ANALYSIS)

	if GameConfig.getChannelConfig(Const.REMOTE_CONFIG_CLOSE_BUGLY) then
		PluginStrategy[PluginType.BUG_REPORT] = {
			PluginConfig.BUG_REPORT_STRAT_DUMMY,
			PluginConfig.BUG_REPORT_STRAT_DUMMY
		}
	end

	PluginManager._initPlugin(PluginType.BUG_REPORT)
	PluginManager._initPlugin(PluginType.LOCAL_NOTIFICATION)
	NotificationManager.init()
	PluginManager._initPlugin(PluginType.PUSH_NOTIFICATION)
	PluginManager._initPlugin(PluginType.WEB_VIEW)

	if VersionUtils.getEngineVersion() >= 135234 then
		PluginManager._initPlugin(PluginType.GPM)
	end

	DataAnalysis.onStart()
	EventCenter.addEventListener(EventConst.ACCOUNT_LOGIN_FINISH, PluginManager.onAccountLogin)
end

function PluginManager._initPlugin(pluginType, newStratIndex)
	if newStratIndex == nil then
		newStratIndex = stratIndex
	end

	local strat = PluginStrategy[pluginType] and PluginStrategy[pluginType][newStratIndex]

	if strat then
		local pluginClass = PluginClass[pluginType]

		if type(strat) == "table" then
			pluginClass.setStrategyList(strat)
			pluginClass.initList(strat)
		else
			pluginClass.setStrategy(strat)
			pluginClass.init(strat)
		end
	end
end

local _remoteInited = false

function PluginManager.initBeforeLogin()
	if _remoteInited then
		return
	end

	_remoteInited = true

	PluginManager._initPlugin(PluginType.REMOTE_DEBUG)
	PluginManager._initPlugin(PluginType.REMOTE_CONTROLLER)
end

function PluginManager.initAfterLogin()
	return
end

local _socialShareInited = false

function PluginManager.tryInitShare()
	if RegionUtils.isCN() and not IS_PUBLISH_VERSION then
		PluginStrategy[PluginType.SOCIAL_SHARE] = {
			PluginConfig.SOCIAL_SHARE_STRAT_DUMMY,
			PluginConfig.SOCIAL_SHARE_STRAT_DUMMY
		}
	end

	if not _socialShareInited then
		_socialShareInited = true

		PluginManager._initPlugin(PluginType.SOCIAL_SHARE)
	end
end

function PluginManager.onAccountLogin(succ)
	if succ then
		NotificationManager.onAccountLogin()
	end
end

function PluginManager.onRoleCreate()
	local openID = AccountManager.getOpenID()

	DataAnalysis.setNewAccount(openID)
	NotificationManager.onRoleCreate()
end

function PluginManager.onRoleLogin()
	local openID = AccountManager.getOpenID()
	local deviceID = SDKAppUtils.getNativeDeviceID()

	BugReport.setUserId(string.format("%s|%s", openID, deviceID))
	BugReport.setScene(1)
	BugReport.addSceneData("patchVersion", VersionUtils.getDocumentPatchVersion())
	PushNotification.onRoleLogin()
	NotificationManager.onRoleLogin()
end

function PluginManager.onRoleLoginLater()
	local name = ""
	local playerLv = "1"
	local uid = ""
	local serverId, serverName = nil, ""
	local ca = CurAvatar
	local openID = AccountManager.getOpenID()

	if ca then
		name = ca.name
		playerLv = ca.getLevel and ca:getLevel()
		uid = ca.uid

		local serverInfo = SvrListManager.getSelectedSvrInfo()

		serverName = serverInfo.name
	end

	DataAnalysis.setAccount(openID)
	DataAnalysis.setGameServer(serverName)
	DataAnalysis.setLevel(playerLv)
end

function PluginManager.onRoleLevelUp()
	local ca = CurAvatar
	local playerLv = ca.getLevel and ca:getLevel() or 0

	if playerLv then
		DataAnalysis.setLevel(playerLv)
		NotificationManager.onRoleLevelUp(playerLv)
	end
end

function PluginManager.onPause()
	NotificationManager.onPause()
end

function PluginManager.onResume()
	return
end

function PluginManager.onExit()
	NotificationManager.onPause()

	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		BugReportAgent.DisableExceptionHandler()
	end
end

function PluginManager.onBuyProductSucc(transId, paymentType, currencyType, currencyAmount)
	DataAnalysis.paymentStart(transId, paymentType, currencyType, currencyAmount)
end

function PluginManager.onPurchaseSucc(transId, paymentType, currencyType, currencyAmount)
	DataAnalysis.paymentSucc(transId, paymentType, currencyType, currencyAmount)
end

return PluginManager
