-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_god_dragon_buff.lua

module("logicconfig.config.t_divine_god_dragon_buff", package.seeall)

local title = {
	buffDesc = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		346001,
		1,
		"初始气势+100"
	},
	{
		346001,
		2,
		"攻击+100%"
	},
	{
		346001,
		3,
		"暴击率+100%"
	},
	{
		346001,
		4,
		"初始气势+100"
	},
	{
		346001,
		5,
		"攻击+100%"
	},
	{
		346001,
		6,
		"暴击率+100%"
	},
	{
		346001,
		7,
		"初始气势+100"
	},
	{
		346001,
		8,
		"攻击+100%"
	},
	{
		346001,
		9,
		"暴击率+100%"
	},
	{
		346001,
		10,
		"初始气势+100"
	},
	{
		346001,
		11,
		"攻击+100%"
	},
	{
		346001,
		12,
		"暴击率+100%"
	},
	{
		346001,
		13,
		"初始气势+100"
	},
	{
		346001,
		14,
		"攻击+100%"
	},
	{
		346002,
		1,
		"初始气势+100"
	},
	{
		346002,
		2,
		"攻击+100%"
	},
	{
		346002,
		3,
		"暴击率+100%"
	},
	{
		346002,
		4,
		"初始气势+100"
	},
	{
		346002,
		5,
		"攻击+100%"
	},
	{
		346002,
		6,
		"暴击率+100%"
	},
	{
		346002,
		7,
		"初始气势+100"
	},
	{
		346002,
		8,
		"攻击+100%"
	},
	{
		346002,
		9,
		"暴击率+100%"
	},
	{
		346002,
		10,
		"初始气势+100"
	},
	{
		346002,
		11,
		"攻击+100%"
	},
	{
		346002,
		12,
		"暴击率+100%"
	},
	{
		346002,
		13,
		"初始气势+100"
	},
	{
		346002,
		14,
		"攻击+100%"
	}
}
local t_divine_god_dragon_buff = {
	[346001] = {
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
	[346002] = {
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

t_divine_god_dragon_buff.dataList = dataList

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

return t_divine_god_dragon_buff
