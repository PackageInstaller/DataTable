-- chunkname: @projbooter/config/GameChannelConfig.lua

module("projbooter.config.GameChannelConfig", package.seeall)

local GameChannelConfig = class("GameChannelConfig")

GameChannelConfig.SDKType = {
	xfsdk = 2,
	longcheng = 8,
	previewsdk = 5,
	gp_japan = 6,
	efun = 7,
	bilibili = 3,
	slsdk = 1,
	gp_global = 4
}
GameChannelConfig.ServerType = {
	OutDevelop2 = 7,
	OutDevelop5 = 10,
	OutDevelop4 = 9,
	OutDevelop6 = 11,
	OutRelease = 4,
	OutDevelop3 = 8,
	OutExperience = 5,
	OutPreview = 3,
	OutDevelop1 = 6,
	OutDevelop = 2,
	Develop = 1
}
GameChannelConfig._cfg = {
	[GameChannelConfig.SDKType.xfsdk] = {
		gameCode = "ssgame",
		packageName = "com.bluepoch.m.reverse1999",
		channelId = "100",
		packageNamewin = "com.bluepoch.m.reverse1999.win",
		gameId = "50001"
	},
	[GameChannelConfig.SDKType.slsdk] = {
		gameCode = "ssgame",
		packageName = "com.shenlan.m.proj1",
		channelId = "100",
		packageNamewin = "com.shenlan.m.proj1.shenlanwin",
		gameId = "50001"
	},
	[GameChannelConfig.SDKType.bilibili] = {
		gameCode = "ssgame",
		subChannelId = "1",
		channelId = "101",
		packageNamewin = "com.shenlan.m.reverse1999.bilibiliwin",
		gameId = "50001"
	}
}

function GameChannelConfig.isSlsdk()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.slsdk
end

function GameChannelConfig.isXfsdk()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.xfsdk
end

function GameChannelConfig.isBilibili()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.bilibili
end

function GameChannelConfig.isGpGlobal()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.gp_global
end

function GameChannelConfig.isGpJapan()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.gp_japan
end

function GameChannelConfig.isLongCheng()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.longcheng
end

function GameChannelConfig.isEfun()
	return GameConfig:GetCurSDKType() == GameChannelConfig.SDKType.efun
end

function GameChannelConfig._getCurCfg()
	return GameChannelConfig._cfg[GameConfig:GetCurSDKType()]
end

function GameChannelConfig.getGameId()
	return GameChannelConfig._getCurCfg().gameId
end

function GameChannelConfig.getPackageName()
	if BootNativeUtil.isWindows() then
		return GameChannelConfig._getCurCfg().packageNamewin
	end

	return GameChannelConfig._getCurCfg().packageName
end

function GameChannelConfig.getChannelId()
	return GameChannelConfig._getCurCfg().channelId
end

function GameChannelConfig.getSubChannelId()
	if BootNativeUtil.isAndroid() then
		return "1002"
	end

	if BootNativeUtil.isIOS() then
		return "1004"
	end

	if BootNativeUtil.isWindows() then
		return "1003"
	end

	return "1003"
end

function GameChannelConfig.getGameCode()
	return GameChannelConfig._getCurCfg().gameCode
end

function GameChannelConfig.getServerType()
	local serverType = GameConfig:GetCurServerType()

	if serverType == 6 or serverType == 7 then
		serverType = 2
	end

	if serverType == 8 then
		serverType = 5
	end

	return serverType
end

function GameChannelConfig.isExternalTest()
	local serverType = GameConfig:GetCurServerType()

	return serverType == 6
end

return GameChannelConfig
