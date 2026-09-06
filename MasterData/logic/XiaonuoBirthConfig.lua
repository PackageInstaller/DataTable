-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/config/XiaonuoBirthConfig.lua

module("logic.extensions.bonus.config.XiaonuoBirthConfig", package.seeall)

local XiaonuoBirthConfig = class("XiaonuoBirthConfig", BaseConfig)

function XiaonuoBirthConfig:getNames()
	return {
		"xiao_nuo_summary_sign_in",
		"xiao_nuo_summary_tab",
		"xiao_nuo_summary_common",
		"xiao_nuo_summary_lottery",
		"xiao_nuo_summary_light_fmt",
		"xiao_nuo_summary_right",
		"xiao_nuo_summary_items",
		"xiao_nuo_summary_return",
		"xiao_nuo_summary_activity",
		"summary_bgandjump",
		"xiao_nuo_summary_daily_like",
		"xiao_nuo_summary_sign_in_time",
		"summary_activity_list",
		"xiao_nuo_summary_artifact",
		"xiao_nuo_summary_fulllevelmission",
		"xiao_nuo_summary_passporttask"
	}
end

function XiaonuoBirthConfig:handleConfig(name, content)
	if name == "xiao_nuo_summary_sign_in" then
		self.xiao_nuo_summary_sign_inCfg = content
	elseif name == "xiao_nuo_summary_tab" then
		self.xiao_nuo_summary_tabCfg = content
	elseif name == "xiao_nuo_summary_common" then
		self.xiao_nuo_summary_commonCfg = content
	elseif name == "xiao_nuo_summary_lottery" then
		self.xiao_nuo_summary_lotteryCfg = content
	elseif name == "xiao_nuo_summary_light_fmt" then
		self.xiao_nuo_summary_light_fmtCfg = content
	elseif name == "xiao_nuo_summary_right" then
		self.xiao_nuo_summary_rightCfg = content
	elseif name == "xiao_nuo_summary_items" then
		self.xiao_nuo_summary_itemsCfg = content
	elseif name == "xiao_nuo_summary_return" then
		self.xiao_nuo_summary_returnCfg = content
	elseif name == "xiao_nuo_summary_activity" then
		self.xiao_nuo_summary_activityCfg = content
		self.xiao_nuo_summary_activityDataList = content.dataList
	elseif name == "summary_bgandjump" then
		self.summary_bgandjump = content
	elseif name == "xiao_nuo_summary_daily_like" then
		self.summary_daily_like = content
	elseif name == "xiao_nuo_summary_sign_in_time" then
		self.xiao_nuo_summary_sign_in_timeCfg = content
	elseif name == "summary_activity_list" then
		self.summary_activity_listCfg = content
	elseif name == "xiao_nuo_summary_artifact" then
		self.xiao_nuo_summary_artifact = content
	elseif name == "xiao_nuo_summary_fulllevelmission" then
		self.xiao_nuo_summary_fulllevelmission = content
	elseif name == "xiao_nuo_summary_passporttask" then
		self.xiao_nuo_summary_passporttask = content
	end
end

function XiaonuoBirthConfig:getActivityDataList()
	return self.xiao_nuo_summary_activityDataList
end

function XiaonuoBirthConfig:getActivity(actId)
	return self.xiao_nuo_summary_activityCfg[actId]
end

function XiaonuoBirthConfig:getTabList(actId)
	return self.xiao_nuo_summary_tabCfg[actId]
end

function XiaonuoBirthConfig:getSignInList(actId)
	return self.xiao_nuo_summary_sign_inCfg[actId]
end

function XiaonuoBirthConfig:getSignInDayData(actId, signInDays)
	return self.xiao_nuo_summary_sign_inCfg[actId][signInDays]
end

function XiaonuoBirthConfig:getLotteryList()
	return self.xiao_nuo_summary_lotteryCfg.dataList
end

function XiaonuoBirthConfig:getLightFmtList()
	return self.xiao_nuo_summary_light_fmtCfg.dataList
end

function XiaonuoBirthConfig:getLightFmtCfg(idx)
	return self.xiao_nuo_summary_light_fmtCfg[idx] or {}
end

function XiaonuoBirthConfig:getRightList()
	return self.xiao_nuo_summary_rightCfg.dataList
end

function XiaonuoBirthConfig:getItemsList()
	return self.xiao_nuo_summary_itemsCfg.dataList
end

function XiaonuoBirthConfig:getReturnList()
	return self.xiao_nuo_summary_returnCfg.dataList
end

function XiaonuoBirthConfig:getCommonValue(key)
	if self.xiao_nuo_summary_commonCfg[key] then
		return self.xiao_nuo_summary_commonCfg[key].value
	end

	return ""
end

function XiaonuoBirthConfig:getBgAndJumpCfg(actId, tab)
	if self.summary_bgandjump[actId] then
		return self.summary_bgandjump[actId][tab]
	end
end

function XiaonuoBirthConfig:getSummaryActivityUpdateList(actId)
	return self.summary_activity_listCfg[actId]
end

function XiaonuoBirthConfig:getDailyLikeCfg(actId, tab)
	if self.summary_daily_like[actId] then
		return self.summary_daily_like[actId][tab]
	end

	return nil
end

function XiaonuoBirthConfig:getDailyLikeCfgs(actId)
	return self.summary_daily_like[actId] or {}
end

function XiaonuoBirthConfig:getSignInTimeCfg(timePlanId)
	return self.xiao_nuo_summary_sign_in_timeCfg[timePlanId]
end

function XiaonuoBirthConfig:getSignInTimeData(timePlanId, signInDays)
	return self.xiao_nuo_summary_sign_in_timeCfg[timePlanId][signInDays]
end

function XiaonuoBirthConfig:getSignInTimeDataById(activityId, signInDays)
	local timePlanId = self:getSignInDayData(activityId, signInDays).timePlanId

	return self.xiao_nuo_summary_sign_in_timeCfg[timePlanId]
end

function XiaonuoBirthConfig:getArtifactCfg()
	local length = #self.xiao_nuo_summary_artifact.dataList

	for i = length, 1, -1 do
		if self.xiao_nuo_summary_artifact[i] then
			local cfgTime = GameUtil.string2time(self.xiao_nuo_summary_artifact[i].startTime)
			local time = ServerTime.now()

			if cfgTime <= time then
				return self.xiao_nuo_summary_artifact[i]
			end
		end
	end
end

function XiaonuoBirthConfig:getArtifactCfgById(artifactId)
	if artifactId == nil then
		return self:getArtifactCfg()
	end

	if self.xiao_nuo_summary_artifact[artifactId] then
		local cfgTime = GameUtil.string2time(self.xiao_nuo_summary_artifact[artifactId].startTime)
		local time = ServerTime.now()

		if cfgTime <= time then
			return self.xiao_nuo_summary_artifact[artifactId]
		end
	end
end

function XiaonuoBirthConfig:getFullMissionCfgById(id)
	return self.xiao_nuo_summary_fulllevelmission[id]
end

function XiaonuoBirthConfig:getPassporttaskById(activityId, id)
	return self.xiao_nuo_summary_passporttask[activityId][id]
end

XiaonuoBirthConfig.instance = XiaonuoBirthConfig.New()

return XiaonuoBirthConfig
