-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/config/StickCoupletConfig.lua

module("logic.extensions.stickcouplet.config.StickCoupletConfig", package.seeall)

local StickCoupletConfig = class("StickCoupletConfig", BaseConfig)

function StickCoupletConfig:onInit()
	StickCoupletConfig.super.onInit(self)
end

function StickCoupletConfig:getNames()
	return {
		"stick_couplet_activity",
		"stick_couplet_progress_prize",
		"stick_couplet_normal",
		"stick_couplet_hard"
	}
end

function StickCoupletConfig:handleConfig(name, content)
	if name == "stick_couplet_activity" then
		self._stick_couplet_activity = content
	elseif name == "stick_couplet_progress_prize" then
		self._stick_couplet_progress_prize = content
	elseif name == "stick_couplet_normal" then
		self._stick_couplet_normal = content
	elseif name == "stick_couplet_hard" then
		self._stick_couplet_hard = content
	end
end

function StickCoupletConfig:getSCActData(activityId)
	return self._stick_couplet_activity[activityId]
end

function StickCoupletConfig:getSCProgressData(activityId)
	return self._stick_couplet_progress_prize[activityId]
end

function StickCoupletConfig:getSCNormalData()
	return self._stick_couplet_normal
end

function StickCoupletConfig:getSCHardData()
	return self._stick_couplet_hard
end

StickCoupletConfig.instance = StickCoupletConfig.New()

return StickCoupletConfig
