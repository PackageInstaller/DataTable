-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugTools.lua

local DebugConst = require("Debug/DebugConst")
local mri = require("Debug/MemoryReferenceInfo")
local RechargeManager = require("System/Recharge/RechargeManager")
local ChatService = require("Network/ChatService")
local SubpackageHelper = require("Helper/SubpackageHelper")
local PluginManager = require("SDK/Plugin/PluginManager")
local UrlConfig = require("Network/UrlConfig")
local DebugHelper = DebugHelper
local DebugModule = {}

DebugModule.ENTRY_NAME = "程序工具"

local preLuaSnapshot, preFuncSnapShot, preUserdataSnapShot

function DebugModule.snapshotLuaMemory(sender, menu, value)
	DebugHelper.GCCShap()
	collectgarbage("collect")

	local curLuaSnapshot, curFuncSnapShot, curUserdataSnapShot = mri.m_cMethods.DumpMemorySnapshot("./", "AllMemoryRef", -1, nil, nil, preLuaSnapshot, preFuncSnapShot, preUserdataSnapShot)

	for typeName, info in pairs(curLuaSnapshot) do
		local nowCount = info[1]
	end

	preLuaSnapshot = curLuaSnapshot
	preFuncSnapShot = curFuncSnapShot
	preUserdataSnapShot = curUserdataSnapShot

	DebugHelper.GCCShap()
	collectgarbage("collect")
end

function DebugModule.testRecharge(sender, menu, value)
	RechargeManager.startRecharge(100020)
end

function DebugModule.openDebugLogUI(sender, menu, value)
	DebugHelper.OpenDebugLogUI()
end

function DebugModule.LogDiamondCount(sender, menu, value)
	return
end

function DebugModule.testLogin(sender, menu, value)
	SDKAgent.testSDKLogin(value)
end

function DebugModule.hideUI(sender, menu, value)
	local root = UnityEngine.GameObject.Find("UIRoot")

	if root then
		root:SetActive(false)
	end
end

function DebugModule.switchSvrMark(sender, menu, value)
	local SwitchServerHelper = require("Helper/SwitchServerHelper")
	local serverInfo = SvrListManager.getSelectedSvrInfo()

	serverInfo.svrMark = value

	SwitchServerHelper.changeSvrAndTryReset(serverInfo)
end

function DebugModule.openStarUpAnimation(sender, menu, value)
	local getNewHeroDlg = UIManager.getUI("getNewHeroDlg", nil, false)

	if getNewHeroDlg then
		getNewHeroDlg:setVisible(false)
	else
		local getNewHeroDlg = UIManager.getUI("getNewHeroDlg", true)
		local hero = BaseObject.GetObject(211001)

		hero.star = tonumber(value)

		getNewHeroDlg:setHero(hero)
	end
end

local Relic = require("Common/Object/Relic")

function DebugModule.openRelicUpgradeResult(sender, menu, value)
	local relicUpgradeResultDlg = UIManager.getUI("relicUpgradeResultDlg", true)
	local upServerData = {}

	upServerData.id = 710003
	upServerData.level = 1

	local upRelic = Relic(upServerData)

	relicUpgradeResultDlg:setRelic(upRelic)
end

function DebugModule.openActivityBingoEfx(sender, menu, value)
	local activityBingoEfxDlg = UIManager.getUI("activityBingoEfxDlg", nil, false)

	if activityBingoEfxDlg then
		activityBingoEfxDlg:setVisible(false)
	else
		local activityBingoEfxDlg = UIManager.getUI("activityBingoEfxDlg", true)
	end
end

DebugModule._chatToken = nil

function DebugModule.connectWS(sender, menu, value)
	if DebugModule._chatToken == nil then
		DebugModule._chatToken = ChatService._token
	end

	ChatService.connect(DebugModule._chatToken, function()
		MsgManager.notice("连接成功!")
	end)
end

function DebugModule.disconnectWS(sender, menu, value)
	if DebugModule._chatToken == nil then
		DebugModule._chatToken = ChatService._token
	end

	ChatService.disconnect()
end

function DebugModule.showWSState(sender, menu, value)
	MsgManager.notice("当前连接：" .. (ChatService.isConnected() and "Yes" or "No"))
end

function DebugModule.setLoaderLinger(sender, menu, value)
	local time = tonumber(value) or 0

	Framework.Resource.LoaderFactory.LingerMaxTime = time

	MsgManager.notice("LingerMaxTime:" .. tostring(time))
end

function DebugModule.testWebView(sender, menu, value)
	local WebView = require("SDK/Plugin/WebView")

	if not value then
		WebView.openWebView("http://www.163.com")
	else
		WebView.openWebView(value)
	end
end

function DebugModule.openUrl(sender, menu, value)
	local WebView = require("SDK/Plugin/WebView")

	if not value then
		WebView.unityOpenUrl("http://www.163.com")
	else
		WebView.unityOpenUrl(value)
	end
end

function DebugModule.testNotification(sender, menu, value)
	local NotificationManager = require("SDK/Plugin/NotificationManager")

	if value == "1" then
		Framework.Plugin.PermissionManager.CheckNotificationEnabled()
	else
		NotificationManager.cancelAll()
		NotificationManager.scheduleNewMsg(0.003, 0, tonumber(value))
	end
end

function DebugModule.enableDebugLogin(sender, menu, value)
	SDKAgent.forceLoginMode = 0
	UrlConfig.Const.URL_ACCOUNT = "account/token"

	UrlConfig.updateUrls()

	local loginDlg = UIManager.getUI("login")

	loginDlg._isDebugLoginMode = true

	loginDlg:setVisible(false)
	UIManager.getUI("login", true)
end

function DebugModule.openIdLogin(sender, menu, value)
	local info = utils.splitString(value, ",")

	UIManager.getUI("debugLogin", false, false)

	UrlConfig.Const.URL_ACCOUNT = "account/token/fake"

	UrlConfig.updateUrls()
	SDKAgent.openIdLogin(info[1], info[2], info[3])
end

function DebugModule.disableDebugLogin(sender, menu, value)
	SDKAgent.forceLoginMode = 1

	local loginDlg = UIManager.getUI("login")

	loginDlg._isDebugLoginMode = false

	loginDlg:setVisible(false)
	UIManager.getUI("login", true)
end

function DebugModule.checkEmulator()
	local NativeHelper = require("Helper/NativeHelper")

	NativeHelper.checkEmulator()
end

function DebugModule.switchDebugInstant(sender, menu, value)
	SDKAgent.instantModeInDebug = not SDKAgent.instantModeInDebug

	local tip = SDKAgent.instantModeInDebug and "关闭正式流程" or "开启正式流程"

	MsgManager.notice(tip)
end

function DebugModule.capture(sender, menu, value)
	PluginManager.tryInitShare()

	local captureDlg = UIManager.getUI("captureDlg", true)

	captureDlg:capture(nil, {
		frameType = 0
	})
end

DebugModule._md5Async = false

function DebugModule.changeMD5Async(sender, menu, value)
	DebugModule._md5Async = not DebugModule._md5Async

	Framework.Download.SubpackageUtils.SetMD5Async(DebugModule._md5Async)
	MsgManager.notice("setAsync:" .. tostring(DebugModule._md5Async))
end

function DebugModule.testSvrMark(sender, menu, value)
	local NetService = require("Network/NetService")

	NetService._testSvrMark = true
end

local fps

function DebugModule.hideFPS(sender, menu, value)
	fps = fps or UnityEngine.GameObject.Find("Advanced FPS Counter")

	if fps then
		fps:SetActive(not fps.activeSelf)
	end
end

local debugEntry

function DebugModule.hideDebug(sender, menu, value)
	debugEntry = debugEntry or UnityEngine.GameObject.Find("DebugEntry")

	if debugEntry then
		debugEntry:SetActive(not debugEntry.activeSelf)
	end
end

function DebugModule.openPoco(sender, menu, value)
	local obj = UnityEngine.GameObject.Find("PocoManager")

	if obj then
		local poco = obj.transform:Find("PocoChild")

		if poco then
			local isActive = poco.gameObject.activeSelf

			poco.gameObject:SetActive(not isActive)

			if isActive then
				MsgManager.notice("关闭Poco")
			else
				MsgManager.notice("开启Poco")
			end
		end
	end
end

function DebugModule.openRank(sender, menu, value)
	local ui = UIManager.createUI("rentTaskWriteLetterDlg", true)

	ui:setData()
end

function DebugModule.switchBackgroundDownload(sender, menu, value)
	local debugSwitch = SubpackageHelper.debugBackgroundDownload

	if debugSwitch == nil then
		debugSwitch = true
	end

	debugSwitch = not debugSwitch
	SubpackageHelper.debugBackgroundDownload = debugSwitch

	MsgManager.notice(debugSwitch and "开启后台下载" or "关闭后台下载")
end

DebugModule._gcTimer = nil

function DebugModule.switchGC(sender, menu, value)
	if DebugModule._gcTimer then
		DebugModule._gcTimer:Stop()

		DebugModule._gcTimer = nil
	else
		DebugModule._gcTimer = Timer.New(Framework.Tools.LuaToolkit.UnityGC, 60, -1)

		DebugModule._gcTimer:Restart()
	end

	MsgManager.notice(DebugModule._gcTimer and "开启定时GC" or "关闭定时GC")
end

DebugModule._speedUpTimer = nil
DebugModule._speedUpValue = nil

function DebugModule.speedUp(sender, menu, value)
	if DebugModule._speedUpTimer then
		DebugModule._speedUpTimer:Stop()

		DebugModule._speedUpTimer = nil
		UnityEngine.Time.timeScale = 1

		MsgManager.notice("关闭加速")
	else
		DebugModule._speedUpValue = tonumber(value) or 5
		DebugModule._speedUpTimer = Timer.New(DebugModule._onSpeedTick, 0.5, -1)

		DebugModule._speedUpTimer:Start()
		MsgManager.notice("开启加速")
	end
end

function DebugModule._onSpeedTick()
	UnityEngine.Time.timeScale = DebugModule._speedUpValue
end

function DebugModule.isEmulator()
	local SDKImpByted = require("SDK/SDKImp/SDKImpByted")

	SDKImpByted:isEmulator()
end

DebugModule.FUNC_MENU = {
	{
		name = "Lua内存快照",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.snapshotLuaMemory
	},
	{
		name = "测试支付",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testRecharge
	},
	{
		name = "查看log界面",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.openDebugLogUI
	},
	{
		name = "模拟登陆",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testLogin
	},
	{
		name = "隐藏UI",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.hideUI
	},
	{
		name = "切换svrMark",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.switchSvrMark
	},
	{
		name = "打印当前钻石数量",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.LogDiamondCount
	},
	{
		name = "全局加速",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.speedUp
	},
	{
		name = "定时GC",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.switchGC
	},
	{
		name = "打开获得英雄界面",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.openStarUpAnimation
	},
	{
		name = "打开宾果特效界面",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.openActivityBingoEfx
	},
	{
		name = "设置Loader缓存时间",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.setLoaderLinger
	},
	{
		name = "内置浏览器",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testWebView
	},
	{
		name = "系统浏览器",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.openUrl
	},
	{
		name = "测试推送",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testNotification
	},
	{
		name = "开启Debug登录",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.enableDebugLogin
	},
	{
		name = "openId登录",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.openIdLogin
	},
	{
		name = "强制sdk登录",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.disableDebugLogin
	},
	{
		name = "是否是模拟器",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.checkEmulator
	},
	{
		name = "打开截屏",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.capture
	},
	{
		name = "切换后台下载",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.switchBackgroundDownload
	},
	{
		name = "隐藏/显示FPS",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.hideFPS
	},
	{
		name = "隐藏/显示Debug",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.hideDebug
	}
}

return DebugModule
