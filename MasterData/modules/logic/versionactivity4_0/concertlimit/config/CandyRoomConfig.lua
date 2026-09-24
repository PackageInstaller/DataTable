-- chunkname: @modules/logic/versionactivity4_0/concertlimit/config/CandyRoomConfig.lua

module("modules.logic.versionactivity4_0.concertlimit.config.CandyRoomConfig", package.seeall)

local CandyRoomConfig = class("CandyRoomConfig", BaseConfig)

function CandyRoomConfig:reqConfigNames()
	return {
		"activity245",
		"activity245_const",
		"activity245_turntable"
	}
end

function CandyRoomConfig:onInit()
	return
end

function CandyRoomConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function CandyRoomConfig:getActivity245Co(actId)
	return lua_activity245.configDict[actId]
end

function CandyRoomConfig:getActivity245Const(constId)
	return lua_activity245_const.configDict[constId]
end

function CandyRoomConfig:getActivity245RewardCos(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local cos = {}

	for _, co in pairs(lua_activity245_turntable.configDict) do
		if co.activityId == actId then
			table.insert(cos, co)
		end
	end

	return cos
end

function CandyRoomConfig:getActivity245RewardCo(rewardId)
	return lua_activity245_turntable.configDict[rewardId]
end

CandyRoomConfig.instance = CandyRoomConfig.New()

return CandyRoomConfig
