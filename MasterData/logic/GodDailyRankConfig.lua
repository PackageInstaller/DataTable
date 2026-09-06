-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/config/GodDailyRankConfig.lua

module("logic.extensions.goddailyrank.config.GodDailyRankConfig", package.seeall)

local GodDailyRankConfig = class("GodDailyRankConfig", BaseConfig)

function GodDailyRankConfig:getNames()
	return {
		"god_daily_rank_daily_limit",
		"god_daily_rank_define"
	}
end

function GodDailyRankConfig:handleConfig(name, content)
	if name == "god_daily_rank_daily_limit" then
		self._god_daily_rank_daily_limit = content
	elseif name == "god_daily_rank_define" then
		self._god_daily_rank_define = content
	end
end

function GodDailyRankConfig:getRankCfgById(activityId)
	return self._god_daily_rank_define[activityId]
end

GodDailyRankConfig.instance = GodDailyRankConfig.New()

return GodDailyRankConfig
