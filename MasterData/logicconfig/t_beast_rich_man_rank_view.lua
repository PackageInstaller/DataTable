-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_rank_view.lua

module("logicconfig.config.t_beast_rich_man_rank_view", package.seeall)

local title = {
	param = 5,
	name = 4,
	tabId = 2,
	activityId = 1,
	tabType = 3
}
local dataList = {
	{
		558001,
		1,
		"rank_total",
		"瑞兽总榜",
		""
	},
	{
		558001,
		2,
		"rank_gain",
		"收益总榜",
		""
	},
	{
		558001,
		3,
		"rank_sub",
		"狐仙-创世神女",
		"2#1"
	},
	{
		558001,
		4,
		"rank_sub",
		"白泽-诺亚",
		"1#1"
	},
	{
		558001,
		5,
		"rank_sub",
		"鲛人-超神神女",
		"1#2"
	},
	{
		558001,
		6,
		"rank_sub",
		"青雀-永恒神女",
		"2#2"
	},
	{
		558001,
		7,
		"rank_sub",
		"句芒-无烬神女",
		"1#3"
	},
	{
		558001,
		8,
		"rank_sub",
		"陆吾-末炎",
		"1#4"
	},
	{
		558001,
		9,
		"rank_sub",
		"金乌-火次元",
		"2#3"
	}
}
local t_beast_rich_man_rank_view = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_beast_rich_man_rank_view.dataList = dataList

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

return t_beast_rich_man_rank_view
