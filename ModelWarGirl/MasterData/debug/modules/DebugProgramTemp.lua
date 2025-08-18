-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugProgramTemp.lua

local DebugConst = require("Debug/DebugConst")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local UserData = require("Helper/UserData")
local ChannelUtil = require("SDK/ChannelUtil")
local DeviceHelper = require("Helper/DeviceHelper")
local EventConst = require("EventConst")
local PluginManager = require("SDK/Plugin/PluginManager")
local SubpackageHelper = require("Helper/SubpackageHelper")
local LuaToolkit = Framework.Tools.LuaToolkit
local DebugModule = {}

DebugModule.ENTRY_NAME = "程序自主测试"

if not IsGLDeclared("DebugProgramTemp") or not DebugModule then
	GLDeclare("DebugProgramTemp", DebugModule)
end

function DebugModule.resetAvgActionId(sender, menu, value)
	if CurAvatar then
		CurAvatar:setStageActionIndex(0)
	end
end

local InCaching = false
local Cached = {}

local function _packAndSend(clientPkg)
	table.insert(Cached, utils.deepcopy(clientPkg))
end

function DebugModule.cachedRPC(sender, menu, value)
	if InCaching then
		RPC._packAndSend = InCaching
		InCaching = false

		MsgManager.notice("释放缓存的rpc协议" .. #Cached .. "条")

		for _, pkg in ipairs(Cached) do
			RPC._packAndSend(pkg)
		end

		Cached = {}
	else
		InCaching = RPC._packAndSend
		RPC._packAndSend = _packAndSend
		Cached = {}

		MsgManager.notice("开始缓存rpc协议")
	end
end

function DebugModule.testBackUI()
	local closeState = UIManager.closeNowCanvas()

	if closeState == nil then
		Framework.SDK.U3DOceanSDK.ExitGame()
	elseif closeState == false then
		MsgManager.notice("此处无法返回")
	end
end

local stratIndex = 1

function DebugModule.testRemoteDebug()
	if stratIndex == 1 then
		stratIndex = 2

		MsgManager.notice("开启")
	elseif stratIndex == 2 then
		stratIndex = 1

		MsgManager.notice("关闭")
	end

	PluginManager._initPlugin(9, stratIndex)
end

local remoteControllerIndex = 1

function DebugModule.turnRemoteController()
	if remoteControllerIndex == 1 then
		remoteControllerIndex = 2

		MsgManager.notice("开启")
	elseif remoteControllerIndex == 2 then
		remoteControllerIndex = 1

		MsgManager.notice("关闭")
	end

	PluginManager._initPlugin(10, remoteControllerIndex)
end

function DebugModule.testRemoteController()
	local RemoteController = require("SDK/Plugin/RemoteController")

	RemoteController.initChannel("bilibili")
	RemoteController.setExtraData("isV15", "true")
	RemoteController.initUrl("www.baidu.com")
	RemoteController.getToken(DebugModule._onGetToken)
end

function DebugModule._onGetToken(token)
	token = token or "nil"

	MsgManager.notice("token:" .. token)
end

function DebugModule.testRemoteReport()
	local RemoteDebug = require("SDK/Plugin/RemoteDebug")

	RemoteDebug.report("userId", "userName", "userAccount", "userServer", "reportDesc", 1, 0)
end

function DebugModule.testTraceRoute(sender, menu, value)
	if value == nil or value == "" then
		value = "www.baidu.com"
	end

	Framework.Tools.LuaToolkit.TraceRoute(value, DebugModule._onTraceRoute)
end

function DebugModule.testDownloadByFilePath(sender, menu, value)
	local hasDownload, subJob = SubpackageHelper.checkDownloadFileByPath(value)

	if hasDownload then
		-- block empty
	else
		SubpackageHelper.tryDownloadJob(subJob, Functor(DebugModule.downloadSuccessCallback, value), Slot(DebugModule.downloadFailCallback, value))
	end
end

function DebugModule.testDownloadByGroupID(sender, menu, value)
	local hasDownload, subJob = SubpackageHelper.checkDownloadFileByID(tonumber(value))

	if hasDownload then
		-- block empty
	else
		SubpackageHelper.tryDownloadJob(subJob, Functor(DebugModule.downloadSuccessCallback, value), Slot(DebugModule.downloadFailCallback, value))
	end
end

function DebugModule.downloadSuccessCallback(value)
	return
end

function DebugModule.downloadFailCallback(value)
	return
end

function DebugModule.clearPlotRewindData()
	local PlotRewindUtils = require("UI/PlotRewind/PlotRewindUtils")

	UserData.clearCommonData(CurAvatar.uid .. PlotRewindUtils.HasClickedString)
	UserData.clearCommonData(CurAvatar.uid .. PlotRewindUtils.ClickTimeString)

	local ClientAvatar = require("Avatar/ClientAvatar")

	ClientAvatar:checkPlotRewindRedHint()
end

function DebugModule.openRandomSeed()
	Const.openRandomSeed = true
end

function DebugModule.doScript(sender, menu, value)
	local f = loadstring(value)

	f()
end

function DebugModule.switchCheckText()
	if not pcall(function()
		local try = LuaToolkit.GetCheckTextToolEnable
	end) then
		return
	end

	if IS_EDITOR then
		MsgManager.notice("【文本超框】编辑器下建议使用[本地化/运行时检查超框文本]开关")
	end

	local enable = LuaToolkit.GetCheckTextToolEnable()

	enable = not enable

	LuaToolkit.SetCheckTextToolEnable(enable)

	if enable then
		MsgManager.notice("【文本超框】已开启文本超框检查")
	else
		MsgManager.notice("【文本超框】已关闭文本超框检查")
	end
end

function DebugModule.logTextCheckInfo(textSet)
	for i = 0, textSet.Count - 1 do
		local value = textSet[i]

		MsgManager.notice("【文本超框】" .. textSet[i])
	end
end

function DebugModule.showException()
	Const.SHOW_ERROR_LOG = true
end

DebugModule.FUNC_MENU = {
	{
		name = "重置战斗前AVG",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.resetAvgActionId
	},
	{
		name = "缓存/释放RPC协议",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.cachedRPC
	},
	{
		name = "安卓返回按钮",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testBackUI
	},
	{
		name = "开启/关闭亲情系统",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testRemoteDebug
	},
	{
		name = "开启/关闭兄弟系统",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.turnRemoteController
	},
	{
		name = "测试送花",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testRemoteController
	},
	{
		name = "测试点赞1",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testRemoteReport
	},
	{
		name = "测试TR",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testTraceRoute
	},
	{
		name = "按资源名分包下载",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testDownloadByFilePath
	},
	{
		name = "清除剧情回看数据",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.clearPlotRewindData
	},
	{
		name = "开启战斗随机种子监控",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.openRandomSeed
	},
	{
		name = "执行自定义脚本",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.doScript
	},
	{
		name = "开启/关闭超框检查",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.switchCheckText
	},
	{
		name = "显示协议报错",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.showException
	}
}

return DebugModule
