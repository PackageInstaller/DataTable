-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/config/LuckyDrawConfig.lua

module(..., package.seeall)

local LuckyDrawConfig = class("LuckyDrawConfig", BaseConfig)

function LuckyDrawConfig:onInit()
	return
end

function LuckyDrawConfig:getNames()
	return {
		"lucky_draw_activity",
		"lucky_draw_prize",
		"lucky_draw_times_plan",
		"lucky_draw_point_plan",
		"luck_draw_common",
		"lucky_draw_process_prize",
		"lucky_draw_skin_pos_scale",
		"lucky_draw_skin_2_bg"
	}
end

function LuckyDrawConfig:handleConfig(name, content)
	if name == "lucky_draw_activity" then
		self._act_cfg = content
	elseif name == "lucky_draw_prize" then
		self._prize_cfg = content
	elseif name == "lucky_draw_times_plan" then
		self._draw_times_plan_cfg = {}

		for k, v in ipairs(content.dataList) do
			self._draw_times_plan_cfg[v.activityId] = self._draw_times_plan_cfg[v.activityId] or {}

			table.insert(self._draw_times_plan_cfg[v.activityId], v)
		end
	elseif name == "lucky_draw_point_plan" then
		self._lucky_draw_point_plan_cfg = {}

		for k, v in ipairs(content.dataList) do
			self._lucky_draw_point_plan_cfg[v.activityId] = self._lucky_draw_point_plan_cfg[v.activityId] or {}

			table.insert(self._lucky_draw_point_plan_cfg[v.activityId], v)
		end
	elseif name == "luck_draw_common" then
		self._commonCfgs = content
	elseif name == "lucky_draw_process_prize" then
		self._lucky_draw_process_prize = content
	elseif name == "lucky_draw_skin_pos_scale" then
		self._lucky_draw_skin_pos_scale = content
	elseif name == "lucky_draw_skin_2_bg" then
		self._lucky_draw_skin_2_bg = content
	end
end

function LuckyDrawConfig:getActCfg(activityId)
	return self._act_cfg[activityId]
end

function LuckyDrawConfig:getPrizeCfg(activityId)
	return self._prize_cfg[activityId]
end

function LuckyDrawConfig:getDrawTimesPlanCfg(activityId)
	return self._draw_times_plan_cfg[activityId]
end

function LuckyDrawConfig:getLuckyDrawPointPlanCfg(activityId)
	return self._lucky_draw_point_plan_cfg[activityId]
end

function LuckyDrawConfig:getLuckDrawPointActId()
	return checkint(self._commonCfgs.SCORE_STATE_ACTID.value)
end

function LuckyDrawConfig:getLuckDrawTimesActId()
	return checkint(self._commonCfgs.TIME_STATE_ACTID.value)
end

function LuckyDrawConfig:getLuckDrawAddTimesActId()
	return checkint(self._commonCfgs.TIME_STATE_ADD_ACTID.value)
end

function LuckyDrawConfig:getLuckDrawTimesPreviewActId()
	return checkint(self._commonCfgs.SKIN_PREVIEW_ACTID.value)
end

function LuckyDrawConfig:isExistCommonValue(key)
	return self._commonCfgs[key]
end

function LuckyDrawConfig:getCommonValue(key)
	return self._commonCfgs[key].value
end

function LuckyDrawConfig:getProgressRewardCfgs(activityId)
	return self._lucky_draw_process_prize[activityId]
end

function LuckyDrawConfig:getSkinPosScale(skinId)
	return self._lucky_draw_skin_pos_scale[skinId]
end

function LuckyDrawConfig:getBgName(skinId)
	return self._lucky_draw_skin_2_bg[skinId].bgName
end

LuckyDrawConfig.instance = LuckyDrawConfig.New()

return LuckyDrawConfig
