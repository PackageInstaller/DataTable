-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugSetServerList.lua

local UrlConfig = require("Network/UrlConfig")
local DebugModule = {}
local self = DebugModule

DebugModule.SpMarkConst = {
	["盛和测试 designer"] = "designer",
	["东南亚test sea"] = "iseatest_sea",
	东南亚test = "iseatest",
	东南亚主eu = "iseamain_eu",
	["韩国test ikotest"] = "ikotest",
	["韩国主 ikomain"] = "ikomain",
	["B站审核 ibilimainreview"] = "ibilimainreview",
	["字节测试 ibytecbreview"] = "ibytecbreview",
	["东南亚主review sea"] = "iseamainreview_sea",
	东南亚主na = "iseamain_na",
	sdk内网地址 = "sdkdev",
	["B站主 ibilimain"] = "ibilimain",
	["字节商务 ibytebusiness"] = "ibytebusiness",
	["东南亚test review"] = "iseatestreview",
	["字节cb ibytecb"] = "ibytecb",
	东南亚主sea = "iseamain_sea",
	["字节测试 ibytemainreview"] = "ibytemainreview",
	["韩国cb ikocb"] = "ikocb",
	["字节主 ibytemain"] = "ibytemain",
	["盛和审核 shmainreview2"] = "shmainreview2",
	["大陆盛和 shmain"] = "shmain",
	东南亚商务sea = "iseabusiness_sea",
	["盛和测试 zjtest"] = "zjtest",
	["韩国review ikoreview"] = "ikoreview",
	["B站测试 ibilibili"] = "ibilibili",
	["字节测试 ibyted"] = "ibyted",
	内网 = "__dev",
	["盛和测试 cmptest"] = "cmptest",
	[""] = "__dev"
}

function DebugModule.setIsPublish(sender, menu, value)
	if value == "true" then
		UrlConfig.isPublish = true
	else
		UrlConfig.isPublish = false
	end

	UrlConfig.updateUrls()
	MsgManager.notice("设置<b>isPublish</b>为【" .. value .. "】成功")
end

function DebugModule.setPlatform(sender, menu, value)
	UrlConfig.platform = value

	UrlConfig.updateUrls()
	MsgManager.notice("设置<b>platform</b>为【" .. value .. "】成功")
end

function DebugModule.setDebugSpMark(sender, menu, value)
	UrlConfig._debugSpMark = DebugModule.SpMarkConst[value]

	UrlConfig.updateUrls()
	MsgManager.notice("设置<b>_debugSpMark</b>为【" .. UrlConfig._debugSpMark .. "】成功")
end

function DebugModule.setPostfix(sender, menu, value)
	local postfix = value

	if postfix == "默认" then
		postfix = "_default"
	end

	UrlConfig.postfix = value
	UrlConfig.isPre = UrlConfig.postfix == "pre"

	UrlConfig.updateUrls()
	MsgManager.notice("设置<b>postfix</b>为【" .. value .. "】成功")
end

return DebugModule
