-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\ChannelUtil.lua

local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local DeviceHelper = require("Helper/DeviceHelper")
local SDKConst = require("SDK/SDKConst")
local SDKUtils = require("SDK/SDKUtils")
local RechargeConst = require("System/Recharge/RechargeConst")
local VersionUtils = require("System/VersionUtils")
local LuaToolkit = Framework.Tools.LuaToolkit
local AttName = SDKConst.AttName
local ChannelID = SDKConst.ChannelID
local ChannelUtil = {}

if not IsGLDeclared("ChannelUtil") or not ChannelUtil then
	GLDeclare("ChannelUtil", ChannelUtil)
end

local RECHARGE_PATH_DIR = "System/Recharge/"
local CHANNEL_FALLBACK = "fallback"

ChannelUtil.DebugChannelID = nil
ChannelUtil.DebugSubChannelID = nil

local CHANNEL_INFO_DICT = {
	[CHANNEL_FALLBACK] = {
		currencySign = "￥",
		timeZone = 8,
		currencyCode = "CNY"
	}
}

function ChannelUtil.getChannelID()
	return ChannelUtil.DebugChannelID or U3DOceanSDK.GetChannelID()
end

function ChannelUtil.getSubChannelID()
	if ChannelUtil.DebugSubChannelID ~= nil then
		return ChannelUtil.DebugSubChannelID
	end

	if ChannelUtil._subChannelID == nil then
		local SDKCore = require("SDK/SDKCore")
		local platformData = SDKCore.getPlatformData()

		ChannelUtil._subChannelID = platformData and platformData[AttName.SUB_CHANNEL_ID] or ""
	end

	return ChannelUtil._subChannelID
end

function ChannelUtil.updateChannelProperty()
	local channelId = ChannelUtil.getChannelID()

	ChannelUtil.isFlow = channelId == ChannelID.FLOW
	ChannelUtil.isPlat = channelId == ChannelID.PLAT
	ChannelUtil.isMulti = channelId == ChannelID.MULTI
	ChannelUtil.isByted = channelId == ChannelID.BYTED
	ChannelUtil.isBilibili = channelId == ChannelID.KOMOE
	ChannelUtil.isBiliKorea = channelId == ChannelID.BILIKOREA
	ChannelUtil.isBiliSea = channelId == ChannelID.BILISEA
	ChannelUtil.isBT = channelId == ChannelID.BT
	ChannelUtil.channelInfo = ChannelUtil._getChannelInfo()
	ChannelUtil.rechargeChannelInfo = ChannelUtil._getRechargeChannelInfo()
end

function ChannelUtil._getRechargeChannelInfo()
	local info
	local channelID = ChannelUtil.getChannelID()
	local RECHARGE_CHANNEL_DICT = RechargeConst.RECHARGE_CHANNEL_DICT

	for rechargeName, rechargeInfo in pairs(RechargeConst.RECHARGE_CHANNEL_DICT) do
		if rechargeInfo.bindChannel == channelID then
			info = rechargeInfo

			break
		end
	end

	if info == nil and ChannelUtil.isFlow then
		if DeviceHelper.isIOS() then
			info = RECHARGE_CHANNEL_DICT.XGJOY_IAP
		elseif DeviceHelper.isAndroid() then
			info = RECHARGE_CHANNEL_DICT.XGJOY_PAYTYPE
		end
	end

	if info == nil then
		info = RechargeConst.RECHARGE_CHANNEL_INFO_EDITOR
	end

	return info
end

function ChannelUtil._getChannelInfo()
	local info
	local channelID = ChannelUtil.getChannelID()

	info = CHANNEL_INFO_DICT[channelID]

	if info == nil then
		info = CHANNEL_INFO_DICT[CHANNEL_FALLBACK]
	end

	return info
end

function ChannelUtil.getRechargeChannel()
	return ChannelUtil.rechargeChannelInfo.id
end

function ChannelUtil.getRechargeImpPath()
	return RECHARGE_PATH_DIR .. ChannelUtil.rechargeChannelInfo.imp
end

function ChannelUtil.getRechargeProductMethod()
	return ChannelUtil.rechargeChannelInfo.productMethod
end

function ChannelUtil.getRechargeIDChannel()
	return ChannelUtil.rechargeChannelInfo.rechargeIDChannel
end

function ChannelUtil.getServerTimeZone()
	return ChannelUtil.channelInfo.timeZone
end

function ChannelUtil.getCurrencyCode()
	return ChannelUtil.channelInfo.currencyCode
end

function ChannelUtil.getCurrencySign()
	return ChannelUtil.channelInfo.currencySign
end

function ChannelUtil.isQQGame()
	return ChannelUtil.isFlow and ChannelUtil.getSubChannelID() == ChannelID.SUB_QQGAME
end

function ChannelUtil.isDMMGame()
	local result = false

	return result
end

function ChannelUtil.isSteam()
	local result = false

	if RegionUtils.isSEA() and DeviceHelper.isWindows() and not IS_EDITOR then
		result = true
	end

	return result
end

function ChannelUtil.isHuawei()
	return ChannelUtil.isFlow and ChannelUtil.getSubChannelID() == ChannelID.SUB_HUAWEI
end

function ChannelUtil.isCNOfficialChannel()
	if not RegionUtils.isCN() then
		return false
	end

	if DeviceHelper.isIOS() then
		return true
	end

	if DeviceHelper.isAndroid() and (ChannelUtil.getSubChannelID() == "taptap" or ChannelUtil.getSubChannelID() == "haoyoukuaibao" or ChannelUtil.getSubChannelID() == "xy") then
		return true
	end

	return false
end

function ChannelUtil.doAnyFunction(funcName, data)
	local succ = true
	local stringData
	local dataType = type(data)

	if dataType == "table" then
		stringData = ClientUtils.table2String(data)
	elseif dataType == "string" then
		stringData = data
	elseif dataType == "number" then
		stringData = tostring(data)
	else
		stringData = ""
	end

	local str = U3DOceanSDK.DoAnyFunction(funcName, stringData)
	local data = ClientUtils.string2Table(str)

	succ = SDKUtils.isReturnTrue(data)

	local result = data[AttName.EXTRA]

	return succ, result
end

function ChannelUtil.isFatigueEnabled()
	local ret = false

	return ret
end

function ChannelUtil.isFlowFatigueUserInfo()
	local ret = false

	return ret
end

function ChannelUtil.setDebugChannel(channelID, subChannelID)
	ChannelUtil.DebugChannelID = channelID
	ChannelUtil.DebugSubChannelID = subChannelID

	ChannelUtil.updateChannelProperty()
	SDKAgent.init()
end

function ChannelUtil.getDownLoadUrl()
	if DeviceHelper.isIOS() then
		return "itms-apps://itunes.apple.com/app/id1514321617"
	else
		return ChannelID.DOWNLOAD_URL_CONFIG[ChannelUtil.getSubChannelID()]
	end
end

ChannelUtil.updateChannelProperty()

function ChannelUtil.getLogicChannelName()
	local result

	if RegionUtils.isJP() then
		if DeviceHelper.isAndroid() and VersionUtils.hasAbilityDMMSuccession() then
			local succ, channel = ChannelUtil.doAnyFunction("getBytedanceChannel", {})

			if succ and channel == "dmm" then
				result = "DMM-Android"
			end
		elseif DeviceHelper.isWindows() and VersionUtils.hasAbilityDMMSuccession() then
			local succ, channel = ChannelUtil.doAnyFunction("getBytedanceChannel", {})

			if succ and channel == "dmm" then
				result = "DMM-PC"
			end
		end
	end

	local succ, channel = ChannelUtil.doAnyFunction("getBytedancePayChannel", {})

	if succ and channel == "amazon" then
		result = "amazon"
	end

	return result
end

return ChannelUtil
