-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_music_game_activity.lua

module("logicconfig.config.t_music_game_activity", package.seeall)

local title = {
	itemId = 4,
	imageRules = 6,
	gamePlanId = 3,
	redPointId = 7,
	dailyTimes = 2,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		370001,
		3,
		1,
		"10:370001",
		"musicgamemainview_rule",
		{
			{
				url = "ui/bigbg/redset/board_shezhi01.png"
			},
			{
				url = "ui/bigbg/redset/board_shezhi03.png"
			}
		},
		590
	},
	{
		370002,
		3,
		1,
		"10:370002",
		"musicgamemainview_rule",
		{
			{
				url = "ui/bigbg/musicgame/board_xiaoyouxi_shenyaochen04.png"
			},
			{
				url = "ui/bigbg/musicgame/board_xiaoyouxi_shenyaochen05.png"
			}
		},
		590
	},
	{
		370003,
		3,
		1,
		"10:370003",
		"musicgamemainview_rule",
		{
			{
				url = "ui/bigbg/musicgame/board_xiaoyouxi_shenyaochen04.png"
			},
			{
				url = "ui/bigbg/musicgame/board_xiaoyouxi_shenyaochen05.png"
			}
		},
		590
	}
}
local t_music_game_activity = {
	[370001] = dataList[1],
	[370002] = dataList[2],
	[370003] = dataList[3]
}

t_music_game_activity.dataList = dataList

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

return t_music_game_activity
