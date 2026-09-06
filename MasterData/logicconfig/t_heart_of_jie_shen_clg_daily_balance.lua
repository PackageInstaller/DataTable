-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_jie_shen_clg_daily_balance.lua

module("logicconfig.config.t_heart_of_jie_shen_clg_daily_balance", package.seeall)

local title = {
	id = 2,
	dateRange = 3,
	activityId = 1,
	des = 4
}
local dataList = {
	{
		389001,
		1,
		"2024-07-26 05:00:00#2024-08-02 05:00:00",
		"首周每日前200名"
	},
	{
		389001,
		2,
		"2026-04-17 05:00:00#2026-04-24 05:00:00",
		"每日前500名获得次元之心"
	},
	{
		389002,
		1,
		"2025-09-26 05:00:00#2025-10-03 05:00:00",
		"截止第100名没有离阳龙脉·敖九的玩家之前的所有玩家"
	}
}
local t_heart_of_jie_shen_clg_daily_balance = {
	[389001] = {
		dataList[1],
		dataList[2]
	},
	[389002] = {
		dataList[3]
	}
}

t_heart_of_jie_shen_clg_daily_balance.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_heart_of_jie_shen_clg_daily_balance
