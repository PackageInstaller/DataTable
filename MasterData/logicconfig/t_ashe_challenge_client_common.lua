-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashe_challenge_client_common.lua

module("logicconfig.config.t_ashe_challenge_client_common", package.seeall)

local title = {
	parameter = 2,
	comPlanId = 1,
	value = 3
}
local dataList = {
	{
		1,
		"RULE",
		"asheenterview"
	},
	{
		1,
		"JUMP_TO_1",
		"ui#publicdragontabview#4#2"
	},
	{
		1,
		"JUMP_TO_2",
		"func#618#10330"
	},
	{
		1,
		"JUMP_TO_3",
		"func#191#246#246001"
	},
	{
		1,
		"SHOW_COIN",
		"4:169"
	},
	{
		1,
		"RACE_ID",
		"10330"
	},
	{
		1,
		"JUMP_TO_4",
		"mibao#qixitehui2"
	},
	{
		2,
		"RULE",
		"luciferview"
	},
	{
		2,
		"JUMP_TO_1",
		"ui#publicdragontabview#9#1"
	},
	{
		2,
		"JUMP_TO_2",
		"func#618#12011"
	},
	{
		2,
		"JUMP_TO_3",
		"func#191#246#246002"
	},
	{
		2,
		"SHOW_COIN",
		"4:185"
	},
	{
		2,
		"RACE_ID",
		"12011"
	},
	{
		2,
		"JUMP_TO_4",
		"mibao#honglianyaoshi3"
	},
	{
		2,
		"JUMP_TO_5",
		"func#545#3"
	},
	{
		3,
		"RULE",
		"yuanhuangChallenge_rules"
	},
	{
		3,
		"JUMP_TO_1",
		"ui#publicdragontabview#24#1"
	},
	{
		3,
		"JUMP_TO_2",
		"func#618#14021"
	},
	{
		3,
		"JUMP_TO_3",
		"func#191#246#246003"
	},
	{
		3,
		"SHOW_COIN",
		"4:216"
	},
	{
		3,
		"RACE_ID",
		"14021"
	},
	{
		3,
		"JUMP_TO_4",
		"mibao#shengrihui5"
	},
	{
		3,
		"JUMP_TO_5",
		"func#545#3"
	},
	{
		4,
		"RULE",
		"shenyaoyilishabaiChallenge_rules"
	},
	{
		4,
		"JUMP_TO_1",
		"ui#publicdragontabview#24#1"
	},
	{
		4,
		"JUMP_TO_2",
		"func#618#15028"
	},
	{
		4,
		"JUMP_TO_3",
		"func#191#246#246004"
	},
	{
		4,
		"SHOW_COIN",
		"4:256"
	},
	{
		4,
		"RACE_ID",
		"15028"
	},
	{
		4,
		"JUMP_TO_4",
		"ui#lottery"
	},
	{
		4,
		"JUMP_TO_5",
		"func#545#3"
	}
}
local t_ashe_challenge_client_common = {
	{
		RULE = dataList[1],
		JUMP_TO_1 = dataList[2],
		JUMP_TO_2 = dataList[3],
		JUMP_TO_3 = dataList[4],
		SHOW_COIN = dataList[5],
		RACE_ID = dataList[6],
		JUMP_TO_4 = dataList[7]
	},
	{
		RULE = dataList[8],
		JUMP_TO_1 = dataList[9],
		JUMP_TO_2 = dataList[10],
		JUMP_TO_3 = dataList[11],
		SHOW_COIN = dataList[12],
		RACE_ID = dataList[13],
		JUMP_TO_4 = dataList[14],
		JUMP_TO_5 = dataList[15]
	},
	{
		RULE = dataList[16],
		JUMP_TO_1 = dataList[17],
		JUMP_TO_2 = dataList[18],
		JUMP_TO_3 = dataList[19],
		SHOW_COIN = dataList[20],
		RACE_ID = dataList[21],
		JUMP_TO_4 = dataList[22],
		JUMP_TO_5 = dataList[23]
	},
	{
		RULE = dataList[24],
		JUMP_TO_1 = dataList[25],
		JUMP_TO_2 = dataList[26],
		JUMP_TO_3 = dataList[27],
		SHOW_COIN = dataList[28],
		RACE_ID = dataList[29],
		JUMP_TO_4 = dataList[30],
		JUMP_TO_5 = dataList[31]
	}
}

t_ashe_challenge_client_common.dataList = dataList

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

return t_ashe_challenge_client_common
