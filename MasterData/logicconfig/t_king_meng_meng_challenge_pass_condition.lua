-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_pass_condition.lua

module("logicconfig.config.t_king_meng_meng_challenge_pass_condition", package.seeall)

local title = {
	conditionId = 2,
	passDesc = 3,
	activityId = 1
}
local dataList = {
	{
		278001,
		122,
		"1号位的精灵必须存活"
	},
	{
		278001,
		123,
		"2号位的精灵必须存活"
	},
	{
		278001,
		124,
		"3号位的精灵必须存活"
	},
	{
		278001,
		125,
		"4号位的精灵必须存活"
	},
	{
		278001,
		126,
		"5号位的精灵必须存活"
	},
	{
		278001,
		127,
		"6号位的精灵必须存活"
	},
	{
		278001,
		128,
		"7号位的精灵必须存活"
	},
	{
		278001,
		129,
		"8号位的精灵必须存活"
	},
	{
		278001,
		130,
		"9号位的精灵必须存活"
	},
	{
		278001,
		73,
		"5回合内击败敌阵"
	},
	{
		278001,
		74,
		"4回合内击败敌阵"
	},
	{
		278001,
		75,
		"3回合内击败敌阵"
	},
	{
		278001,
		55,
		"至少存活5只精灵"
	},
	{
		278001,
		56,
		"至少存活4只精灵"
	},
	{
		278001,
		57,
		"至少存活3只精灵"
	},
	{
		278002,
		122,
		"1号位的精灵必须存活"
	},
	{
		278002,
		123,
		"2号位的精灵必须存活"
	},
	{
		278002,
		124,
		"3号位的精灵必须存活"
	},
	{
		278002,
		125,
		"4号位的精灵必须存活"
	},
	{
		278002,
		126,
		"5号位的精灵必须存活"
	},
	{
		278002,
		127,
		"6号位的精灵必须存活"
	},
	{
		278002,
		128,
		"7号位的精灵必须存活"
	},
	{
		278002,
		129,
		"8号位的精灵必须存活"
	},
	{
		278002,
		130,
		"9号位的精灵必须存活"
	},
	{
		278002,
		73,
		"5回合内击败敌阵"
	},
	{
		278002,
		74,
		"4回合内击败敌阵"
	},
	{
		278002,
		75,
		"3回合内击败敌阵"
	},
	{
		278002,
		55,
		"至少存活5只精灵"
	},
	{
		278002,
		56,
		"至少存活4只精灵"
	},
	{
		278002,
		57,
		"至少存活3只精灵"
	}
}
local t_king_meng_meng_challenge_pass_condition = {
	[278001] = {
		[122] = dataList[1],
		[123] = dataList[2],
		[124] = dataList[3],
		[125] = dataList[4],
		[126] = dataList[5],
		[127] = dataList[6],
		[128] = dataList[7],
		[129] = dataList[8],
		[130] = dataList[9],
		[73] = dataList[10],
		[74] = dataList[11],
		[75] = dataList[12],
		[55] = dataList[13],
		[56] = dataList[14],
		[57] = dataList[15]
	},
	[278002] = {
		[122] = dataList[16],
		[123] = dataList[17],
		[124] = dataList[18],
		[125] = dataList[19],
		[126] = dataList[20],
		[127] = dataList[21],
		[128] = dataList[22],
		[129] = dataList[23],
		[130] = dataList[24],
		[73] = dataList[25],
		[74] = dataList[26],
		[75] = dataList[27],
		[55] = dataList[28],
		[56] = dataList[29],
		[57] = dataList[30]
	}
}

t_king_meng_meng_challenge_pass_condition.dataList = dataList

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

return t_king_meng_meng_challenge_pass_condition
