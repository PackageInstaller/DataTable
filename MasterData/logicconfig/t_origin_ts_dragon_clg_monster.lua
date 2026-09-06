-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ts_dragon_clg_monster.lua

module("logicconfig.config.t_origin_ts_dragon_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 13,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 12,
	ruleDesc = 11,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"1-1",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"1-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"1-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"4",
		"7"
	},
	{
		1004,
		"2-1",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"2-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"2-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"3-1",
		3,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"",
		"6",
		"7"
	},
	{
		1008,
		"3-2",
		3,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"3-3",
		3,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_origin_ts_dragon_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9]
}

t_origin_ts_dragon_clg_monster.dataList = dataList

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

return t_origin_ts_dragon_clg_monster
