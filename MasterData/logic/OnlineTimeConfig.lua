-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/config/OnlineTimeConfig.lua

module("logic.extensions.onlinetime.config.OnlineTimeConfig", package.seeall)

local OnlineTimeConfig = class("OnlineTimeConfig", BaseConfig)

OnlineTimeConfig.TIME_MIN = 60
OnlineTimeConfig.GIFT_TIME_ARR = {
	5,
	15,
	30,
	35,
	40,
	50
}

local json = require("cjson")

function OnlineTimeConfig:getFaceId()
	local kp = ActivityParamsConfig.instance:getOnlineTimeCfgByKey("showPet")

	return kp.faceId
end

OnlineTimeConfig.instance = OnlineTimeConfig.New()

return OnlineTimeConfig
