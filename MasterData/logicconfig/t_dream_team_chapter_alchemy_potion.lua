-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_alchemy_potion.lua

module("logicconfig.config.t_dream_team_chapter_alchemy_potion", package.seeall)

local title = {
	materialStr = 6,
	quality = 3,
	needMaterial = 5,
	potionId = 2,
	activityId = 1,
	successScore = 4
}
local dataList = {
	{
		595001,
		1,
		1,
		30,
		{
			1,
			6,
			9,
			9,
			9,
			12
		},
		"1004:1635"
	},
	{
		595001,
		2,
		2,
		20,
		{
			3,
			5,
			5,
			10,
			11
		},
		"1004:1636"
	},
	{
		595001,
		3,
		2,
		20,
		{
			1,
			1,
			2,
			2,
			8,
			8
		},
		"1004:1637"
	},
	{
		595001,
		4,
		3,
		10,
		{
			4,
			4,
			12
		},
		"1004:1638"
	},
	{
		595001,
		5,
		3,
		10,
		{
			3,
			3,
			7
		},
		"1004:1639"
	}
}
local t_dream_team_chapter_alchemy_potion = {
	[595001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_dream_team_chapter_alchemy_potion.dataList = dataList

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

return t_dream_team_chapter_alchemy_potion
