-- chunkname: @/tmp/or_script/lua_compile/sdk/DPSAnySdk-mac.lua

require("sdk.IDPSAnySdk")
require("sdk.DPSAnySdkUtils")

DPSAnySdk = class("DPSAnySdk", legs.Actor)

function DPSAnySdk:initialize()
	super.initialize(self)
end

function DPSAnySdk:setGameContext(gameContext)
	self._gameContext = gameContext
end

function DPSAnySdk:callMethod(methodName, ...)
	return
end

function DPSAnySdk:setOpenId(openId)
	return ""
end

function DPSAnySdk:getOpenId()
	return ""
end

function DPSAnySdk:getVendor()
	return ""
end

function DPSAnySdk:getSdkSource(default)
	return default or ""
end

function DPSAnySdk:getChannelID()
	return ""
end

function DPSAnySdk:getStatisticsBaseInfo()
	return ""
end

function DPSAnySdk:switchAccount(data)
	return
end

function DPSAnySdk:logOut(data)
	return
end

function DPSAnySdk:payOff(data)
	return
end

function DPSAnySdk:getVerifyData()
	return ""
end

function DPSAnySdk:getGlobalData(openId)
	return ""
end

function DPSAnySdk:getGameId()
	return ""
end

function DPSAnySdk:getPlayerId()
	return ""
end

function DPSAnySdk:setLanguage(language)
	return
end

function DPSAnySdk:requestReviewInApp(data)
	return
end
