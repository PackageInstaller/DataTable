-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_buff.lua

module("logicconfig.config.t_king_meng_meng_challenge_buff", package.seeall)

local title = {
	activityId = 1,
	name = 3,
	buffId = 2,
	des = 4
}
local dataList = {
	{
		278001,
		1,
		"BUFF1",
		"空属性精灵初始气势+30"
	},
	{
		278001,
		2,
		"BUFF2",
		"光属性精灵克制伤害+15%"
	},
	{
		278001,
		3,
		"BUFF3",
		"暗属性精灵全属性加成+10%"
	},
	{
		278001,
		4,
		"BUFF4",
		"创属性精灵超杀伤害+15%"
	},
	{
		278001,
		5,
		"BUFF5",
		"水属性精灵攻击吸血+10%"
	},
	{
		278001,
		6,
		"BUFF6",
		"火属性精灵伤害减免+10%"
	},
	{
		278001,
		7,
		"BUFF7",
		"草属性精灵格挡率+20%"
	},
	{
		278001,
		8,
		"BUFF8",
		"空属性精灵克制伤害+15%"
	},
	{
		278001,
		9,
		"BUFF9",
		"光属性精灵全属性加成+10%"
	},
	{
		278001,
		10,
		"BUFF10",
		"暗属性精灵超杀伤害+15%"
	},
	{
		278001,
		11,
		"BUFF11",
		"创属性精灵攻击吸血+10%"
	},
	{
		278001,
		12,
		"BUFF12",
		"水属性精灵伤害减免+10%"
	},
	{
		278001,
		13,
		"BUFF13",
		"火属性精灵格挡率+20%"
	},
	{
		278001,
		14,
		"BUFF14",
		"草属性精灵初始气势+30"
	},
	{
		278002,
		1,
		"BUFF1",
		"空属性精灵初始气势+30"
	},
	{
		278002,
		2,
		"BUFF2",
		"光属性精灵克制伤害+15%"
	},
	{
		278002,
		3,
		"BUFF3",
		"暗属性精灵全属性加成+10%"
	},
	{
		278002,
		4,
		"BUFF4",
		"创属性精灵超杀伤害+15%"
	},
	{
		278002,
		5,
		"BUFF5",
		"水属性精灵攻击吸血+10%"
	},
	{
		278002,
		6,
		"BUFF6",
		"火属性精灵伤害减免+10%"
	},
	{
		278002,
		7,
		"BUFF7",
		"草属性精灵格挡率+20%"
	},
	{
		278002,
		8,
		"BUFF8",
		"空属性精灵克制伤害+15%"
	},
	{
		278002,
		9,
		"BUFF9",
		"光属性精灵全属性加成+10%"
	},
	{
		278002,
		10,
		"BUFF10",
		"暗属性精灵超杀伤害+15%"
	},
	{
		278002,
		11,
		"BUFF11",
		"创属性精灵攻击吸血+10%"
	},
	{
		278002,
		12,
		"BUFF12",
		"水属性精灵伤害减免+10%"
	},
	{
		278002,
		13,
		"BUFF13",
		"火属性精灵格挡率+20%"
	},
	{
		278002,
		14,
		"BUFF14",
		"草属性精灵初始气势+30"
	}
}
local t_king_meng_meng_challenge_buff = {
	[278001] = {
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
		dataList[14]
	},
	[278002] = {
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28]
	}
}

t_king_meng_meng_challenge_buff.dataList = dataList

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

return t_king_meng_meng_challenge_buff
