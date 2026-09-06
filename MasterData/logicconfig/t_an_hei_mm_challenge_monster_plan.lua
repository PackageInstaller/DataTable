-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_an_hei_mm_challenge_monster_plan.lua

module("logicconfig.config.t_an_hei_mm_challenge_monster_plan", package.seeall)

local title = {
	btlBg = 5,
	name = 2,
	enableGainExp = 7,
	skipTime = 4,
	creepsMasterId = 1,
	creepMasterHeadIcon = 3,
	heroSkillId = 6,
	btlMode = 8
}
local dataList = {
	{
		1,
		"简单1",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		2,
		"简单2",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		3,
		"简单3",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		4,
		"适中1",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		5,
		"适中2",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		6,
		"适中3",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		7,
		"困难1",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		8,
		"困难2",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		9,
		"困难3",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		10,
		"深渊1",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		11,
		"深渊2",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		12,
		"深渊3",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		13,
		"地狱1",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		14,
		"地狱2",
		10339,
		15,
		"",
		"",
		false,
		""
	},
	{
		15,
		"地狱3",
		10339,
		15,
		"",
		"",
		false,
		""
	}
}
local t_an_hei_mm_challenge_monster_plan = {
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

t_an_hei_mm_challenge_monster_plan.dataList = dataList

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

return t_an_hei_mm_challenge_monster_plan
