-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugAR.lua

local UIUtils = require("Framework.UI.UIUtils")
local ResScene = require("ClientData/ResScene")
local PluginManager = require("SDK/Plugin/PluginManager")
local SocialShare = require("SDK/Plugin/SocialShare")
local ChannelUtil = require("SDK/ChannelUtil")
local DebugConst = require("Debug/DebugConst")
local SDKCore = require("SDK/SDKCore")
local SDKConst = require("SDK/SDKConst")
local RemoteConfig = require("Helper/RemoteConfig")
local EventType = SDKConst.EventType
local DebugModule = {}

DebugModule.ENTRY_NAME = "AR测试"

local CameraManager = Framework.CameraSystem.CameraManager
local GameObject = UnityEngine.GameObject

function DebugModule.openUI(sender, menu, value)
	UIManager.getUI("arDlg", true)
end

local subChannel = {
	"bilibili",
	"haoyoukuaibao",
	"taptap",
	"xy"
}
local inx = 1

function DebugModule.QRChannel()
	ChannelUtil._subChannelID = subChannel[inx]
	inx = inx + 1

	if inx == 5 then
		inx = 1
	end
end

function DebugModule.otherChannel(sender, menu, value)
	ChannelUtil._subChannelID = value

	RemoteConfig.init()
	MsgManager.notice(ChannelUtil._subChannelID)
end

function DebugModule.socialShare(sender, menu, value)
	PluginManager.tryInitShare()

	local picPath
	local imgURL = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603440111233&di=ba528f9efc2868ca2b760c017aa7b49e&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg"
	local url = "https://figurestory.sh-game.com/"

	if value == "1" then
		MsgManager.notice("QQ")
		SocialShare.shareWebpage(24, 4, "zys title", "zys text", nil, url, imgURL, picPath, false)
	elseif value == "2" then
		MsgManager.notice("QQ空间")
		SocialShare.shareWebpage(6, 4, "zys title", "zys text", nil, url, imgURL, picPath, false)
	elseif value == "3" then
		MsgManager.notice("微信")
		SocialShare.shareWebpage(22, 4, "zys title", "zys text", nil, url, imgURL, picPath, false)
	elseif value == "4" then
		MsgManager.notice("微信朋友圈")
		SocialShare.shareWebpage(23, 4, "zys title", "zys text", nil, url, imgURL, picPath, false)
	end
end

function DebugModule.testOpenForum()
	SDKAgent.openForum()
end

function DebugModule.testGetBBSMsg()
	SDKAgent.getBBSNum()
end

function DebugModule.getNotifyShare()
	local jsonStr = "{\"other_msg_type\":\"BBSShare\",\"url\":\"https://www.jianshu.com/p/3cb256de46d3\",\"imgUrl\":\"https://img.yzcdn.cn/vant/cat.jpeg\",\"content\":\"没魔没魔\",\"title\":\"测试\",\"share_channel\":\"1\"}"

	SDKCore.onGetSDKEvent(EventType.EVENT_GET_OTHER_MSG, jsonStr)
end

function DebugModule.getNotifyNum()
	if VersionUtils.IsJPOpreateChangeVersion() then
		local timeA = tonumber(RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_JP_TIME_A)) or Const.TIMESTAMP_2099_2_16
		local timeB = tonumber(RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_JP_TIME_B)) or Const.TIMESTAMP_2099_2_24

		Framework.Tools.LuaToolkit.LogEx("jp remote config get time: " .. RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_JP_TIME_A) .. ", " .. RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_JP_TIME_B))

		local notice = UIManager.getUI("confirmNotice")

		if notice then
			notice:show()
		end
	end
end

function DebugModule.changeTableIcon(sender, menu, value)
	local function yesfunc()
		local isForce = value == "1"
		local NativeUtils = Framework.Plugin.NativeUtils

		NativeUtils.ChangeTableIcon("com.xgjoy.plugin.oceanplat.MainActivity", "com.xgjoy.plugin.oceanplat.icon", isForce)

		local spinner = UIManager.getUI("loginSpinner", true, true)
	end

	local message = "大约需要10秒配置系统，图标更新后需要手动重启游戏。确认更换游戏图标吗？"

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "更换图标", message, yesfunc, nil, nil, "确定", "取消")
end

DebugModule.FUNC_MENU = {
	{
		name = "AR界面",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.openUI
	},
	{
		name = "四个渠道",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.QRChannel
	},
	{
		name = "其他渠道",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.otherChannel
	},
	{
		name = "分享",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.socialShare
	},
	{
		name = "测试论坛",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testOpenForum
	},
	{
		name = "论坛消息",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testGetBBSMsg
	},
	{
		name = "回调分享",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getNotifyShare
	},
	{
		name = "日本运营变更",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getNotifyNum
	},
	{
		name = "切换icon",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.changeTableIcon
	}
}

return DebugModule
