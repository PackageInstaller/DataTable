-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/config/LanternFestivalConfig.lua

module("logic.extensions.lanternfestival.config.LanternFestivalConfig", package.seeall)

local LanternFestivalConfig = class("LanternFestivalConfig", BaseConfig)

function LanternFestivalConfig:getNames()
	return {
		"lantern_festival_group",
		"lantern_festival_channel_prize",
		"lantern_festival_collection_prize",
		"lantern_festival_activity",
		"lantern_festival_question_plan",
		"lantern_festival_question_person_plan"
	}
end

function LanternFestivalConfig:handleConfig(name, content)
	if name == "lantern_festival_group" then
		self._lantern_festival_group = content
	elseif name == "lantern_festival_channel_prize" then
		self._lantern_festival_channel_prize = content
	elseif name == "lantern_festival_collection_prize" then
		self._lantern_festival_collection_prize = content
	elseif name == "lantern_festival_activity" then
		self._lantern_festival_activity = content
	elseif name == "lantern_festival_question_plan" then
		self._lantern_festival_question_plan = content
	elseif name == "lantern_festival_question_person_plan" then
		self._lantern_festival_question_person_plan = content
	end
end

function LanternFestivalConfig:getActivityCfg(activityId)
	return self._lantern_festival_activity[activityId]
end

function LanternFestivalConfig:getGroupCfg(activityId, groupId)
	if self._lantern_festival_group[activityId] then
		return self._lantern_festival_group[activityId][groupId]
	end
end

function LanternFestivalConfig:getGroupCfgs(activityId)
	return self._lantern_festival_group[activityId] or {}
end

function LanternFestivalConfig:getChannelPrize(activityId, dayOfWeek)
	if self._lantern_festival_channel_prize[activityId] and self._lantern_festival_channel_prize[activityId][dayOfWeek] then
		return self._lantern_festival_channel_prize[activityId][dayOfWeek].prize
	end

	return ""
end

function LanternFestivalConfig:getCollectionPrizeCfgs(activityId)
	return self._lantern_festival_collection_prize[activityId]
end

function LanternFestivalConfig:getQuestionPlanCfgs(planId, day)
	if not self._lantern_festival_question_plan[planId] then
		local planCfg = {}

		if not planCfg then
			return {}
		end

		local groupId = day % #planCfg

		if groupId == 0 then
			groupId = #planCfg
		end

		return planCfg[groupId] or {}
	end
end

function LanternFestivalConfig:getPersonQuestionPlanCfgs(planId, day)
	if not self._lantern_festival_question_person_plan[planId] then
		local planCfg = {}

		if not planCfg then
			return {}
		end

		local groupId = day % #planCfg

		if groupId == 0 then
			groupId = #planCfg
		end

		return planCfg[groupId] or {}
	end
end

LanternFestivalConfig.instance = LanternFestivalConfig.New()

return LanternFestivalConfig
