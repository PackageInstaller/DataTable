-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_time_progress.lua

module("logicconfig.config.t_activity_summary_time_progress", package.seeall)

local title = {
	picturePath = 6,
	name = 3,
	lightPicturePath = 7,
	endTime = 5,
	index = 2,
	activityId = 1,
	startTime = 4
}
local dataList = {
	{
		17081,
		1,
		"第一站",
		"2023-07-28T05:00:00",
		"2023-08-04T05:00:00",
		"ui/icon/activitypro/board_xrdzz_03",
		"ui/icon/activitypro/board_xrdzz_02"
	},
	{
		17081,
		2,
		"第二站",
		"2023-08-04T05:00:00",
		"2023-08-11T05:00:00",
		"ui/icon/activitypro/board_xrdzz_03",
		"ui/icon/activitypro/board_xrdzz_02"
	},
	{
		17081,
		3,
		"第三站",
		"2023-08-11T05:00:00",
		"2023-08-18T05:00:00",
		"ui/icon/activitypro/board_xrdzz_03",
		"ui/icon/activitypro/board_xrdzz_02"
	},
	{
		17081,
		4,
		"第四站",
		"2023-08-18T05:00:00",
		"2023-08-25T05:00:00",
		"ui/icon/activitypro/board_xrdzz_03",
		"ui/icon/activitypro/board_xrdzz_02"
	}
}
local t_activity_summary_time_progress = {
	[17081] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_activity_summary_time_progress.dataList = dataList

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

return t_activity_summary_time_progress
