-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/config/NianNianWelfareConfig.lua

module("logic.extensions.niannianwelfare.config.NianNianWelfareConfig", package.seeall)

local NianNianWelfareConfig = class("NianNianWelfareConfig", BaseConfig)

function NianNianWelfareConfig:onInit()
	NianNianWelfareConfig.super.onInit(self)
end

function NianNianWelfareConfig:getNames()
	return {
		"nian_nian_benefits_activity",
		"nian_nian_benefits_parts",
		"nian_nian_benefits_achievement"
	}
end

function NianNianWelfareConfig:handleConfig(name, content)
	if name == "nian_nian_benefits_activity" then
		self._activity = content
	elseif name == "nian_nian_benefits_parts" then
		self._parts = content
	elseif name == "nian_nian_benefits_achievement" then
		self._achievement = content
	end
end

function NianNianWelfareConfig:getActivity()
	return self._activity.dataList
end

function NianNianWelfareConfig:getPartByPlanId(planId)
	return self._parts[planId]
end

function NianNianWelfareConfig:getAchievementByPlanId(planId)
	return self._achievement[planId]
end

NianNianWelfareConfig.instance = NianNianWelfareConfig.New()

return NianNianWelfareConfig
