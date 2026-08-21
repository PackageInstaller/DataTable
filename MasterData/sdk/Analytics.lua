-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Analytics.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local AnalyticUtils = Framework.SDK.AnalyticUtils
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local UserData = require("Helper/UserData")
local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local SDKAppUtils = require("SDK/SDKAppUtils")
local json = require("cjson")
local NetService = require("Network/NetService")
local DeviceHelper = require("Helper/DeviceHelper")
local ChannelUtil = require("SDK/ChannelUtil")
local EventConst = require("EventConst")
local VersionUtils = require("System/VersionUtils")
local RemoteDebug = require("SDK/Plugin/RemoteDebug")
local ClientUtils = ClientUtils
local HttpUtils = Framework.Network.HttpUtils
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local AttName = SDKConst.AttName
local EventType = SDKConst.EventType
local IS_FORCE_INTRANET = LuaToolkit.IsForceIntranet()
local Analytics = {}
local log = log
local Const = Const
local RequestCmdID = {
	Cmd_GetHTPVersion = 7,
	Cmd_GetEmulatorName = 1,
	Cmd_IsRootDevice = 2
}
local MONITOR_EVENT_TYPE = {
	PATCH = "patch",
	DOWNLOAD = "download",
	CLIENT_ERROR = "client_error",
	CLIENT_WARNING = "client_warning",
	CLIENT_EVENT = "client_event",
	RECHARGE = "recharge",
	CONVERSION = "conversion"
}
local _cacheTable = {}

function Analytics.init()
	Analytics._ossUdpValid = false
	Analytics._cachedSendRoleInfoAttempts = {}
	Analytics._roleInfoReady = false
	Analytics._ossCache = {}
end

function Analytics.onAccountLogin()
	local dataUpdate = {}

	dataUpdate[AttName.OPEN_ID] = AccountManager.getOpenID()

	SDKCore.addUserData(dataUpdate)
	Analytics.logConversionEvent(SDKConst.KeyEvent.LOGIN_ACCOUNT_FINISH)
end

function Analytics.onRoleLoginStart()
	if RegionUtils.isJP() then
		Analytics.sendByteLoginRoleStartEvent()
	end
end

function Analytics.onRoleLogin()
	Analytics.updateSDKUserData()
	Analytics.logConversionEvent(SDKConst.KeyEvent.LOGIN_ROLE_FINISH)
	Analytics._checkOSSUpd()
	Analytics.sendRoleInfoNetSecProtect()
end

function Analytics.onRoleLevelUp()
	Analytics.updateSDKUserData({
		AttName.ROLE_LEVEL,
		AttName.ROLE_LEVELUP_TIME
	})
	Analytics.sendRoleInfo(SDKConst.RoleInfoType.LEVEL_UP)
end

function Analytics.onCreateName()
	Analytics.updateSDKUserData({
		AttName.ROLE_NAME
	})
	Analytics.sendRoleInfo(SDKConst.RoleInfoType.CREATE_NAME)
end

function Analytics.onStageChanged()
	Analytics.updateSDKUserData({
		AttName.STAGE_PROGRESS
	})
end

function Analytics.sendRoleInfo(eventName, ignoreReadyState)
	if not Analytics._roleInfoReady and not ignoreReadyState then
		table.insert(Analytics._cachedSendRoleInfoAttempts, eventName)

		return
	end

	local eventType = EventType.GAME_EVENT_SEND_ROLE_INFO

	U3DOceanSDK.SendRoleInfo(eventName)
end

function Analytics.sendPurchaseInfo(price, currencyCode, productId, openOrderId)
	local data = {
		[AttName.REAL_PRICE] = price,
		[AttName.CURRENCY_CODE] = currencyCode,
		[AttName.ITEM_SERVER_ID] = productId,
		[AttName.OPEN_ORDER_ID] = openOrderId or ""
	}

	SDKCore.doAnyFunction("sendPurchaseInfo", data)
end

function Analytics.logConversionEvent(eventName)
	U3DOceanSDK.LogConversionEvent(eventName)
end

function Analytics.logClientError(name, ...)
	U3DOceanSDK.LogKeyEvent(MONITOR_EVENT_TYPE.CLIENT_ERROR, name, ...)
end

function Analytics.logRechargeError(name, ...)
	U3DOceanSDK.LogKeyEvent(MONITOR_EVENT_TYPE.RECHARGE, name, ...)
end

function Analytics.updateSDKUserData(attrList)
	local ca = CurAvatar

	if not ca then
		return
	end

	local dataUpdate = {}

	if attrList then
		for _, attr in ipairs(attrList) do
			local func = Analytics.getAttrMethod[attr]

			if func then
				dataUpdate[attr] = func(ca)
			end
		end
	else
		local excludeDict = Analytics._defaultExcludedAttrs

		for attr, func in pairs(Analytics.getAttrMethod) do
			if not excludeDict[attr] and func then
				dataUpdate[attr] = func(ca)
			end
		end
	end

	SDKCore.addUserData(dataUpdate)
end

function Analytics.addUserData(userData)
	SDKCore.addUserData(userData)
end

function Analytics._checkOSSUpd()
	local _, svr, port = SvrListManager.getOSSSvrs()

	if svr and port then
		HttpUtils.UpdSendAndRecv(svr, port, "ping", Analytics._onOSSUpdCheck)
	end
end

function Analytics._onOSSUpdCheck(succ, data)
	if succ and data == "pong" then
		Analytics._ossUdpValid = true
	end
end

function Analytics.sendOSSLog(eventType, param1, param2, param3)
	Analytics._updateOSSData()

	local data = Analytics._ossCache

	data.event_type = eventType
	data.param_1 = param1 and tostring(param1)
	data.param_2 = param2 and tostring(param2)
	data.param_3 = param3 and tostring(param3)

	local str = ClientUtils.table2String(data)
	local done = false
	local url, svr, port = SvrListManager.getOSSSvrs()

	if Analytics._ossUdpValid and svr and port then
		HttpUtils.UpdSend(svr, port, str, nil)

		done = true
	end

	if not done and url then
		HttpHelper.post(url, str, nil, 1)

		done = true
	end
end

Analytics._ossUID = 0

function Analytics._updateOSSData()
	local ca = CurAvatar

	if not ca then
		return
	end

	local data = Analytics._ossCache

	data.t_name = "xg_client_glog"
	Analytics._ossUID = (Analytics._ossUID + 1) % 10
	data.idx = ca.uid .. ClientUtils.getServerTime() .. Analytics._ossUID
	data.openid = Analytics.getAttrMethod[AttName.OPEN_ID](ca)
	data.mid = SDKAgent.getUserID()
	data.create_tick = Analytics.getAttrMethod[AttName.ROLE_CREATE_TIME](ca)
	data.channel_id = ChannelUtil.getChannelID()
	data.sub_channel_id = ChannelUtil.getSubChannelID()
	data.platform = DeviceHelper.isIOS() and 2 or 1
	data.device_id = SDKAppUtils.getNativeDeviceID()
	data.world_id = Analytics.getAttrMethod[AttName.SERVER_ID](ca)
	data.character_id = Analytics.getAttrMethod[AttName.ROLE_ID](ca)
	data.character_name = Analytics.getAttrMethod[AttName.ROLE_NAME](ca)
	data.character_level = Analytics.getAttrMethod[AttName.ROLE_LEVEL](ca)
	data.test_type = ca.testType

	if ca.mainStageCur then
		data.character_stage = ca.mainStageCur and ca.mainStageCur.level
		data.character_chapter = ca.mainStageCur and ca.mainStageCur.chapter
		data.character_season = ca.mainStageCur and ca.mainStageCur.season
	end
end

Analytics.getAttrMethod = {
	[AttName.ROLE_ID] = function(ca)
		return ca.uid or "0"
	end,
	[AttName.ROLE_NAME] = function(ca)
		local name = ca.name

		return (name == nil or name == "") and "empty" or name
	end,
	[AttName.ROLE_LEVEL] = function(ca)
		return ca.getLevel and ca:getLevel() or 1
	end,
	[AttName.ROLE_GENDER] = function(ca)
		return ca.playerGender
	end,
	[AttName.ROLE_CREATE_TIME] = function(ca)
		return ca.roleCreateTick or 0
	end,
	[AttName.SERVER_NAME] = function(ca)
		local serverInfo = SvrListManager.getSelectedSvrInfo()

		return serverInfo.name
	end,
	[AttName.SERVER_ID] = function(ca)
		local serverInfo = SvrListManager.getSelectedSvrInfo()

		return serverInfo.id
	end,
	[AttName.PARTY_ID] = function(ca)
		local guildData = ca.mInGuild and ca.mGuildData or {}

		return guildData.clangid or ""
	end,
	[AttName.PARTY_NAME] = function(ca)
		local guildData = ca.mInGuild and ca.mGuildData or {}

		return guildData.name or ""
	end,
	[AttName.PARTY_ROLE_ID] = function(ca)
		return ca.mGuildDuty == Const.GUILD_DUTY_LEADER and 1 or 0
	end,
	[AttName.ROLE_LEVELUP_TIME] = function(ca)
		return ClientUtils.getServerTime()
	end,
	[AttName.SAVED_BALANCE] = function(ca)
		return ca.getJade and ca:getJade() or 0
	end,
	[AttName.VIP_LEVEL] = function(ca)
		return ca.vipLevel or 0
	end,
	[AttName.OPEN_ID] = function(ca)
		return AccountManager.getOpenID()
	end,
	[AttName.USER_ID] = function(ca)
		return SDKAgent.getUserID()
	end,
	[AttName.STAGE_PROGRESS] = function(ca)
		return Analytics._getStageProgress(ca)
	end,
	[AttName.FRIEND_LIST] = function(ca)
		local friendInfoList = {}
		local friendList = ca.friendList or {}

		for _, friend in pairs(friendList) do
			local friendInfo = {
				[AttName.ROLE_ID] = friend.uid,
				[AttName.ROLE_NAME] = friend.name,
				[AttName.ROLE_GENDER] = friend.gender,
				[AttName.ROLE_LEVEL] = friend.level
			}

			table.insert(friendInfoList, friendInfo)
		end

		local friendListString = json.encode(friendInfoList)

		return friendListString
	end
}
Analytics._defaultExcludedAttrs = {
	[AttName.ROLE_LEVELUP_TIME] = true,
	[AttName.FRIEND_LIST] = true,
	[AttName.PARTY_ID] = true,
	[AttName.PARTY_NAME] = true,
	[AttName.PARTY_ROLE_ID] = true
}

function Analytics._clearSendRoleInfoAttempts()
	Analytics._setRoleInfoReadyState(false)

	Analytics._cachedSendRoleInfoAttempts = {}
end

function Analytics._setRoleInfoReadyState(isReady)
	Analytics._roleInfoReady = isReady == true

	Analytics._trySendCachedRoleInfo()
end

function Analytics._trySendCachedRoleInfo()
	if Analytics._roleInfoReady then
		if Analytics._cachedSendRoleInfoAttempts then
			for _, roleInfoType in ipairs(Analytics._cachedSendRoleInfoAttempts) do
				Analytics.sendRoleInfo(roleInfoType)
			end
		end

		Analytics._cachedSendRoleInfoAttempts = {}
	end
end

function Analytics._onWarnFinish()
	return
end

function Analytics.getDeviceInfoForOpenSvr()
	local openID = AccountManager.getOpenID()
	local nativeDeviceID = SDKAppUtils.getNativeDeviceID()
	local unityDeviceID = UnityEngine.SystemInfo.deviceUniqueIdentifier
	local operationSystem = LuaToolkit.GetOperatingSystem()
	local deviceModel = LuaToolkit.GetDeviceModel()
	local systemMemorySize = LuaToolkit.GetSystemMemorySize()
	local processorType = LuaToolkit.GetProcessorType()
	local graphicsShaderLevel = LuaToolkit.GetGraphicsShaderLevel()
	local screenResolution = string.format("%dx%d", DeviceHelper.screenWidth, DeviceHelper.screenHeight)
	local deviceInfo = {}

	deviceInfo.openid = openID
	deviceInfo.nativedevid = nativeDeviceID
	deviceInfo.unitydevid = unityDeviceID
	deviceInfo.ostype = operationSystem
	deviceInfo.devicetype = deviceModel
	deviceInfo.cputype = processorType
	deviceInfo.memsize = systemMemorySize
	deviceInfo.graphylv = graphicsShaderLevel
	deviceInfo.resolution = screenResolution

	return deviceInfo
end

function Analytics.getJsonForGameSvr()
	if VersionUtils.hasAbilityNetserviceJson() then
		local data = {}

		data.token0 = Analytics.getLoginToken0()

		if RegionUtils.isTW() or RegionUtils.isKR() or RegionUtils.isSEA() then
			data.model = DeviceHelper.deviceModel
			data.os_version = UnityEngine.SystemInfo.operatingSystem
			data.network = DeviceHelper.getNetworkTypeText(true)
			data.mac = SDKAgent.getMac()
			data.cp_param = ""
			data.b_tour_indicator = SDKAgent.isGuest() and 1 or 0

			local gameID = tonumber(SDKAgent.getAppID())

			data.b_game_id = gameID or -1
			data.b_channel_id = gameID or -1
			data.b_sdk_udid = SDKAgent.getSDKDeviceID()
			data.sdk_acctype = tonumber(SDKCore.getUserValue(AttName.SDK_ACCTYPE))
		elseif RegionUtils.isJP() then
			data.sdk_open_id = SDKAgent.getUserID()

			local GameSettings = require("Helper/GameSettings")

			data.game_quality = GameSettings.getCurGameQuality()
			data.device_id = SDKCore.getUserValue(AttName.DEVICE_ID)

			if IS_FORCE_INTRANET then
				MsgManager.notice(data.device_id)
			end

			if DeviceHelper.isIOS() then
				data.channel_op = "ios"
			elseif DeviceHelper.isAndroid() then
				data.channel_op = "android"
			else
				data.channel_op = "windows"
			end
		end

		return ClientUtils.table2String(data)
	else
		return nil
	end
end

function Analytics.sendMonitorWarning(name, ...)
	U3DOceanSDK.LogKeyEvent(SDKConst.KeyEvent.MONITOR_TYPE_CLIENT_WARNING, name, ...)
end

function Analytics.sendMonitorLog(name, ...)
	U3DOceanSDK.LogKeyEvent(SDKConst.KeyEvent.MONITOR_TYPE_CLIENT_LOG, name, ...)
end

function Analytics.updateDeviceInfoToOpenSvr()
	local deviceInfo = Analytics.getDeviceInfoForOpenSvr()
end

function Analytics.sendRoleInfoNetSecProtect()
	local ca = CurAvatar

	if not ca then
		return
	end

	local roleId = Analytics.getAttrMethod[AttName.ROLE_ID](ca)
	local roleName = Analytics.getAttrMethod[AttName.ROLE_NAME](ca)
	local roleAccount = Analytics.getAttrMethod[AttName.OPEN_ID](ca)
	local roleServer = Analytics.getAttrMethod[AttName.SERVER_ID](ca)

	RemoteDebug.setRoleInfo(roleId, roleName, roleAccount, roleServer, "")

	local isEmulator = RemoteDebug.htpIoctl(RequestCmdID.Cmd_GetEmulatorName, "")
	local isRoot = RemoteDebug.htpIoctl(RequestCmdID.Cmd_IsRootDevice, "")
	local getHTPVersion = RemoteDebug.htpIoctl(RequestCmdID.Cmd_GetHTPVersion, "")

	RemoteDebug.Imploctl()
	RemoteDebug.registInfoReceiver()
end

function Analytics.onNewAccountCreate()
	if RegionUtils.isTW() or RegionUtils.isSEA() then
		local data = {}

		data.model = LuaToolkit.GetDeviceModel()
		data.os_version = UnityEngine.SystemInfo.operatingSystem
		data.network = DeviceHelper.getNetworkTypeText(true)
		data.mac = SDKAgent.getMac()

		local dataStr = ClientUtils.table2String(data)

		if RegionUtils.isTW() then
			AnalyticUtils.SendLogKomoe("create_account", dataStr)
		else
			AnalyticUtils.SendLogSea("create_account", dataStr)
		end
	end
end

function Analytics.sendGuideFlow(guideID, subID, guideType, guideName, ext)
	local data = Analytics._getDataCache()

	if RegionUtils.isTW() or RegionUtils.isKR() or RegionUtils.isSEA() then
		data.guide_id = guideID
		data.guide_subid = subID
		data.guide_type = guideType
		data.guide_name = guideName
		data.guide_time = os.time()
		data.role_name = Analytics.getAttrMethod[AttName.ROLE_NAME](CurAvatar)
		data.cp_param = ext and "End" or "Start"

		local dataStr = ClientUtils.table2String(data)

		if RegionUtils.isTW() then
			AnalyticUtils.SendLogKomoe("guide_flow", dataStr)
		elseif RegionUtils.isSEA() then
			AnalyticUtils.SendLogSea("guide_flow", dataStr)
		else
			AnalyticUtils.SendLogKorea("guide_flow", dataStr)
		end
	elseif RegionUtils.isJP() and CurAvatar then
		data.time = os.time()
		data.app_id = 4255
		data.role_id = CurAvatar.uid
		data.server_id = SvrListManager.getSelectedSvrID()
		data.user_unique_id = SDKAgent.getUserID()
		data.current_server_id = CurAvatar.current_server_id
		data.role_sid = CurAvatar.shortUid or ""
		data.tutorial_id = tostring(guideID)
		data.action = ext and "2" or "1"
		data.sub_tutorial_id = tostring(subID)

		Analytics.sendLogByted("tutorial_flow", ClientUtils.table2String(data))
	end
end

local TW_CHAT_TYPE = {
	[Const.CHANNEL_WORLD] = 1,
	[Const.CHANNEL_AOI] = 2,
	[Const.CHANNEL_GUILD] = 3,
	[Const.CHANNEL_PRIVATE] = 4,
	[Const.CHANNEL_SERVER] = 5
}

function Analytics.onChatSend(channel, uid, gid, msg)
	local data = Analytics._getDataCache()

	if RegionUtils.isTW() or RegionUtils.isKR() or RegionUtils.isSEA() then
		data.chat_type = TW_CHAT_TYPE[channel] or 0
		data.chat_contents = msg

		local receiveID = channel == Const.CHANNEL_PRIVATE and uid or channel == Const.CHANNEL_WORLD and "0" or gid

		data.receive_id = receiveID
		data.cp_param = nil

		local dataStr = ClientUtils.table2String(data)

		if RegionUtils.isTW() then
			AnalyticUtils.SendLogKomoe("chat_flow", dataStr)
		elseif RegionUtils.isSEA() then
			AnalyticUtils.SendLogSea("chat_flow", dataStr)
		else
			AnalyticUtils.SendLogKorea("chat_flow", dataStr)
		end
	end
end

function Analytics.onShare(shareChannel, stageID)
	local data = Analytics._getDataCache()

	if RegionUtils.isTW() or RegionUtils.isKR() or RegionUtils.isSEA() then
		if stageID ~= nil then
			data.share_type = 1
			data.stage_id = tostring(stageID)
		else
			data.share_type = 2
			data.share_id = shareChannel
		end

		data.cp_param = nil

		local dataStr = ClientUtils.table2String(data)

		if RegionUtils.isTW() then
			AnalyticUtils.SendLogKomoe("share", dataStr)
		elseif RegionUtils.isSEA() then
			AnalyticUtils.SendLogSea("share", dataStr)
		else
			AnalyticUtils.SendLogKorea("share", dataStr)
		end
	end
end

function Analytics.sendLogByted(logType, data)
	if VersionUtils.getEngineVersion() < 121957 then
		return
	end

	if type(data) == "table" then
		data = ClientUtils.table2String(data)
	end

	AnalyticUtils.SendLogByted(logType, data)
end

function Analytics._getStageProgress(ca)
	local stageInfo = ca and ca.mainStageCur

	if stageInfo then
		return string.format("%s-%s-%s", stageInfo.season, stageInfo.chapter, stageInfo.level)
	else
		return "unknown"
	end
end

function Analytics._getDataCache()
	for k, _ in pairs(_cacheTable) do
		_cacheTable[k] = nil
	end

	return _cacheTable
end

function Analytics.getLoginToken0()
	local token = UserData.loadCommonData(Const.UD_KEY_LOGIN_TOKEN0)

	if token == nil or token == "" then
		token = Analytics._generateLoginToken0()

		UserData.saveCommonData(Const.UD_KEY_LOGIN_TOKEN0, token)
	end

	return token
end

function Analytics._generateLoginToken0()
	local token = LuaToolkit.GetOpenDataUUID()

	token = token and token .. string.format("%05d", os.clock() % 100 * 1000)

	return token
end

function Analytics.sendWindowOperaLog(isOpen, windowName, windowInfo)
	if RegionUtils.isJP() and CurAvatar then
		local data = Analytics.getByteSendLogPubParameter()

		if isOpen then
			data.action = "1"
		else
			data.action = "0"
		end

		data.page_id = windowName
		data.info = windowInfo

		Analytics.sendLogByted("page_flow", ClientUtils.table2String(data))
	end
end

function Analytics.sendButtonOperaLog(clickButton)
	if RegionUtils.isJP() and CurAvatar then
		local data = Analytics.getByteSendLogPubParameter()

		data.action = "2"

		Analytics.sendLogByted("page_flow", ClientUtils.table2String(data))
	end
end

function Analytics.sendPlotFlowLog(plotID, duration, plotNum, isSkip, isFirst)
	if RegionUtils.isJP() and CurAvatar then
		local data = Analytics.getByteSendLogPubParameter()

		data.plot_id = plotID
		data.duration = duration
		data.plot_num = plotNum
		data.is_skip = isSkip

		Analytics.sendLogByted("plot_flow", ClientUtils.table2String(data))
	end
end

function Analytics.sendByteLoginRoleStartEvent()
	local data = Analytics.getByteLogParamNoUser()

	data.event = "guide_flow"
	data.guide_id = 120
	data.duration = 0

	Analytics.sendLogByted("guide_flow", ClientUtils.table2String(data))
end

function Analytics.getByteSendLogPubParameter()
	local data = Analytics._getDataCache()

	data.time = os.time()
	data.app_id = 4255
	data.role_id = CurAvatar.uid
	data.server_id = SvrListManager.getSelectedSvrID()
	data.current_server_id = CurAvatar.current_server_id
	data.role_sid = CurAvatar.shortUid or ""
	data.user_unique_id = SDKAgent.getUserID()

	return data
end

function Analytics.getByteLogParamNoUser()
	local data = Analytics._getDataCache()

	data.time = os.time()
	data.app_id = 4255
	data.user_unique_id = string.format("%x___", math.random(1, 1000))
	data.real_package_name = "___"

	return data
end

function Analytics.getBiliSeaSendLogPubParameter()
	local data = Analytics._getDataCache()

	data.uid = SDKAgent.getSDKUserID()
	data.role_id = CurAvatar and CurAvatar.uid or ""
	data.username = CurAvatar and CurAvatar.name or ""

	return data
end

return Analytics
