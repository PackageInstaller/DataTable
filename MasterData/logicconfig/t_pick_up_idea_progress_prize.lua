-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pick_up_idea_progress_prize.lua

module("logicconfig.config.t_pick_up_idea_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		338001,
		1,
		1,
		"4:36:5"
	},
	{
		338001,
		2,
		2,
		"4:510022:5"
	},
	{
		338001,
		3,
		3,
		"60:1:300"
	},
	{
		338001,
		4,
		4,
		"4:112:5"
	},
	{
		338001,
		5,
		5,
		"4:11002:15000"
	},
	{
		338001,
		6,
		6,
		"4:12102:10"
	},
	{
		338001,
		7,
		7,
		"4:60005:1"
	},
	{
		338001,
		8,
		8,
		"60:1:300"
	},
	{
		338001,
		9,
		9,
		"8:1:1000000"
	},
	{
		338001,
		10,
		10,
		"4:36:5"
	},
	{
		338001,
		11,
		12,
		"4:112:5"
	},
	{
		338001,
		12,
		14,
		"4:11002:15000"
	},
	{
		338001,
		13,
		16,
		"60:1:600"
	},
	{
		338001,
		14,
		18,
		"4:30006:100"
	},
	{
		338001,
		15,
		20,
		"4:7008:100"
	}
}
local t_pick_up_idea_progress_prize = {
	[338001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_pick_up_idea_progress_prize.dataList = dataList

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

return t_pick_up_idea_progress_prize
