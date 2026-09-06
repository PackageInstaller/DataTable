-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_finals_rank_view.lua

module("logicconfig.config.t_martial_contest_finals_rank_view", package.seeall)

local title = {
	param = 3,
	name = 5,
	viewname = 4,
	tabId = 1,
	txtTips = 6,
	rootTabId = 2,
	roundIds = 7
}
local dataList = {
	{
		1,
		0,
		"",
		"",
		"战区积分赛",
		"",
		{
			1
		}
	},
	{
		2,
		1,
		"1",
		"martialcontestfinalrankscoreview",
		"积分排行榜",
		"积分排名前500即可进入全服晋级赛",
		{
			1
		}
	},
	{
		3,
		1,
		"1",
		"martialcontestfinalrankpetview",
		"精灵上阵榜",
		"只显示前100名，上场次数≥100才上榜",
		{
			1
		}
	},
	{
		4,
		1,
		"1#1",
		"martialcontestfinalrankpetview",
		"精灵胜率榜",
		"只显示前100名，上场次数≥100才上榜",
		{
			1
		}
	},
	{
		5,
		0,
		"",
		"",
		"全服晋级赛",
		"",
		{
			2
		}
	},
	{
		6,
		2,
		"2",
		"martialcontestfinalrankscoreview",
		"积分排行榜",
		"积分排名前64即可进入全服决赛",
		{
			2
		}
	},
	{
		7,
		2,
		"2",
		"martialcontestfinalrankpetview",
		"精灵上阵榜",
		"只显示前100名，上场次数≥100才上榜",
		{
			2
		}
	},
	{
		8,
		2,
		"2#1",
		"martialcontestfinalrankpetview",
		"精灵胜率榜",
		"只显示前100名，上场次数≥100才上榜",
		{
			2
		}
	},
	{
		9,
		0,
		"",
		"martialcontestfinalrankjuesaiview",
		" 全服总决赛",
		"按三天的决赛积分总和进行排名\r\n排名优先级：总积分＞胜场数＞进入决赛时的最高战力",
		{
			3,
			5
		}
	}
}
local t_martial_contest_finals_rank_view = {
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

t_martial_contest_finals_rank_view.dataList = dataList

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

return t_martial_contest_finals_rank_view
