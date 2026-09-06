-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_genre.lua

module("logicconfig.config.t_mahjong_battle_genre", package.seeall)

local title = {
	petList = 4,
	genreId = 2,
	teamName = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		571001,
		1,
		"龙队",
		{
			1,
			2,
			3,
			5,
			6
		},
		"龙队恐怖来袭"
	},
	{
		571001,
		2,
		"吞天队",
		{
			11,
			12,
			13,
			14,
			15
		},
		"变身队，畅快变身"
	},
	{
		571001,
		3,
		"源起光暗队",
		{
			18,
			19,
			20,
			21,
			22
		},
		"源起三色降临"
	},
	{
		571001,
		4,
		"源起空队",
		{
			24,
			25,
			26,
			27,
			28
		},
		"源起空队来袭"
	},
	{
		571001,
		5,
		"源起草队",
		{
			29,
			30,
			31,
			32,
			33
		},
		"源起草队降临"
	},
	{
		571001,
		6,
		"源起火队",
		{
			34,
			36,
			37,
			38,
			39
		},
		"源起火队，快速炸阵"
	},
	{
		571001,
		7,
		"源起水队",
		{
			40,
			41,
			42,
			43,
			44
		},
		"源起水队，打击后排"
	}
}
local t_mahjong_battle_genre = {
	[571001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_mahjong_battle_genre.dataList = dataList

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

return t_mahjong_battle_genre
