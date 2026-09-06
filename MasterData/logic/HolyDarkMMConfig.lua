-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/config/HolyDarkMMConfig.lua

module("logic.extensions.holydarkmm.config.HolyDarkMMConfig", package.seeall)

local HolyDarkMMConfig = class("HolyDarkMMConfig", BaseConfig)

function HolyDarkMMConfig:onInit()
	HolyDarkMMConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function HolyDarkMMConfig:getNames()
	return {
		"holy_dark_mm_challenge_activity",
		"holy_dark_mm_challenge_plan",
		"holy_dark_mm_challenge_stage",
		"holy_dark_mm_challenge_form",
		"holy_dark_mm_challenge_buff",
		"holy_dark_mm_challenge_master",
		"holy_dark_mm_challenge_creeps"
	}
end

function HolyDarkMMConfig:handleConfig(name, content)
	if name == "holy_dark_mm_challenge_activity" then
		self._HolyDarkMMActCfg = content
	elseif name == "holy_dark_mm_challenge_plan" then
		self._HolyDarkMMPlaneCfg = content
	elseif name == "holy_dark_mm_challenge_stage" then
		self._HolyDarkMMStageCfg = content
	elseif name == "holy_dark_mm_challenge_form" then
		self._HolyDarkMMFormCfg = content
	elseif name == "holy_dark_mm_challenge_buff" then
		self._HolyDarkMMBuffCfg = content
	elseif name == "holy_dark_mm_challenge_master" then
		self._HolyDarkMMMasterCfg = content
	elseif name == "holy_dark_mm_challenge_creeps" then
		self._HolyDarkMMCreepCfg = content
	end
end

function HolyDarkMMConfig:getHolyDarkMMActCfg(activityId)
	return self._HolyDarkMMActCfg[activityId]
end

function HolyDarkMMConfig:getHolyDarkMMPlanCfg(activityId)
	return self._HolyDarkMMPlaneCfg[activityId]
end

function HolyDarkMMConfig:getHolyDarkMMStageCfg(activityId, stageId)
	return self._HolyDarkMMStageCfg[activityId][stageId]
end

function HolyDarkMMConfig:getHolyDarkMMBuffCfg(activityId, num)
	local data
	local cfg = self._HolyDarkMMBuffCfg[activityId]

	if cfg then
		for _, v in ipairs(cfg) do
			if num >= v.num then
				data = v
			else
				break
			end
		end
	end

	return data
end

function HolyDarkMMConfig:getHolyDarkMMMasterCfg(creepsMasterId)
	return self._HolyDarkMMMasterCfg[creepsMasterId]
end

function HolyDarkMMConfig:getHolyDarkFormCfg(formPlanId)
	return self._HolyDarkMMFormCfg[formPlanId]
end

function HolyDarkMMConfig:getHolyDarkFormGroupCfg(formPlanId, angleId)
	return self._HolyDarkMMFormCfg[formPlanId][angleId]
end

function HolyDarkMMConfig:getHolyDarkMMFormCfg(formPlanIds)
	local formPlan = {}

	for _, planId in ipairs(formPlanIds) do
		table.insert(formPlan, self._HolyDarkMMFormCfg[planId][1])
	end

	return formPlan
end

function HolyDarkMMConfig:getHolyDarkMMCreepGroupCfg(creepsMasterId)
	return self._HolyDarkMMCreepCfg[creepsMasterId]
end

function HolyDarkMMConfig:getHolyDarkMMCreepCfg(creepsMasterId, creepsId)
	return self._HolyDarkMMCreepCfg[creepsMasterId][creepsId]
end

HolyDarkMMConfig.instance = HolyDarkMMConfig.New()

return HolyDarkMMConfig
