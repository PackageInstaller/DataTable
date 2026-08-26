-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/config/TitleAppointmentConfig.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.config.TitleAppointmentConfig", package.seeall)

local TitleAppointmentConfig = class("TitleAppointmentConfig", BaseConfig)

function TitleAppointmentConfig:ctor()
	self._constConfig = nil
	self._milestoneBonusConfig = nil
	self._titleConfig = nil
end

function TitleAppointmentConfig:reqConfigNames()
	return {
		"activity224_const",
		"activity224_milestone_bonus",
		"activity224_title"
	}
end

function TitleAppointmentConfig:onConfigLoaded(configName, configTable)
	if configName == "activity224_const" then
		self._constConfig = configTable
	elseif configName == "activity224_milestone_bonus" then
		self._milestoneBonusConfig = configTable
	elseif configName == "activity224_title" then
		self._titleConfig = configTable
	end
end

function TitleAppointmentConfig:getConstCO(constId, actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint

	return self._constConfig.configDict[id][constId]
end

function TitleAppointmentConfig:getMilestoneBonusCos(actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint

	return self._milestoneBonusConfig.configDict[id]
end

function TitleAppointmentConfig:getMilestoneBonusCo(rewardId, actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint

	return self._milestoneBonusConfig.configDict[id][rewardId]
end

function TitleAppointmentConfig:getTitleCo(titleId)
	return self._titleConfig.configDict[titleId]
end

TitleAppointmentConfig.instance = TitleAppointmentConfig.New()

return TitleAppointmentConfig
