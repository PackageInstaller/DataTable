-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_poster_stickers_gain_activity.lua

module("logicconfig.config.t_poster_stickers_gain_activity", package.seeall)

local title = {
	posterId = 3,
	redPointId = 2,
	prizePosterStickers = 4,
	spaceCountLimit = 5,
	showTips = 6,
	activityId = 1
}
local dataList = {
	{
		585001,
		766,
		1045,
		"37:1:1",
		9999,
		""
	},
	{
		585002,
		767,
		1044,
		"37:2:1",
		9999,
		""
	},
	{
		585003,
		766,
		1052,
		"37:3:1",
		9999,
		""
	},
	{
		585004,
		767,
		1058,
		"37:4:1",
		9999,
		""
	}
}
local t_poster_stickers_gain_activity = {
	[585001] = dataList[1],
	[585002] = dataList[2],
	[585003] = dataList[3],
	[585004] = dataList[4]
}

t_poster_stickers_gain_activity.dataList = dataList

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

return t_poster_stickers_gain_activity
