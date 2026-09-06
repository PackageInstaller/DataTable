-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/config/TimeServerPetGainConfig.lua

module("logic.extensions.timeserverpetgain.config.TimeServerPetGainConfig", package.seeall)

local TimeServerPetGainConfig = class("TimeServerPetGainConfig", BaseConfig)

function TimeServerPetGainConfig:onInit()
	TimeServerPetGainConfig.super.onInit(self)

	self.time_server_pet_gain = nil
	self.time_server_pet_gain_progress = nil
	self.time_server_pet_gain_buff = nil
end

function TimeServerPetGainConfig:getNames()
	return {
		"time_server_pet_gain",
		"time_server_pet_gain_progress",
		"time_server_pet_gain_buff"
	}
end

function TimeServerPetGainConfig:handleConfig(name, content)
	if name == "time_server_pet_gain" then
		self.time_server_pet_gain = content
	elseif name == "time_server_pet_gain_progress" then
		self.time_server_pet_gain_progress = content
	elseif name == "time_server_pet_gain_buff" then
		self.time_server_pet_gain_buff = content
	end
end

function TimeServerPetGainConfig:getActivityCfg(id)
	return self.time_server_pet_gain[id]
end

function TimeServerPetGainConfig:getProgressCfgList(progressPlanId)
	return self.time_server_pet_gain_progress[progressPlanId]
end

function TimeServerPetGainConfig:getBuffCfg(buffPlanId)
	return self.time_server_pet_gain_buff[buffPlanId]
end

TimeServerPetGainConfig.instance = TimeServerPetGainConfig.New()

return TimeServerPetGainConfig
