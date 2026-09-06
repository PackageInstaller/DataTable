-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_slack_off_game_prize.lua

module("logicconfig.config.t_slack_off_game_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		442001,
		1,
		1,
		"4:36:5"
	},
	{
		442001,
		2,
		2,
		"4:30006:40"
	},
	{
		442001,
		3,
		4,
		"4:11002:10000"
	},
	{
		442001,
		4,
		8,
		"4:12102:5"
	},
	{
		442001,
		5,
		12,
		"4:400002:25"
	},
	{
		442001,
		6,
		16,
		"4:30006:40"
	},
	{
		442001,
		7,
		20,
		"4:400002:25"
	},
	{
		442001,
		8,
		24,
		"4:11002:10000"
	},
	{
		442001,
		9,
		28,
		"4:510022:5"
	},
	{
		442001,
		10,
		32,
		"4:30006:40"
	},
	{
		442001,
		11,
		36,
		"4:36:5"
	},
	{
		442001,
		12,
		40,
		"4:11002:10000"
	},
	{
		442001,
		13,
		44,
		"4:400002:25"
	},
	{
		442001,
		14,
		48,
		"4:30006:40"
	},
	{
		442001,
		15,
		52,
		"4:12102:5"
	},
	{
		442001,
		16,
		56,
		"4:400002:25"
	},
	{
		442001,
		17,
		60,
		"4:30006:40"
	}
}
local t_slack_off_game_prize = {
	[442001] = {
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
		dataList[15],
		dataList[16],
		dataList[17]
	}
}

t_slack_off_game_prize.dataList = dataList

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

return t_slack_off_game_prize
