-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_dark_dragon_buff_stage.lua

module("logicconfig.config.t_god_dark_dragon_buff_stage", package.seeall)

local title = {
	stageId = 3,
	myBuffDesc = 5,
	enemyBuffDesc = 6,
	name = 7,
	creepsMasterId = 4,
	ballName = 8,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		331001,
		1,
		1,
		2001,
		"己阵存活精灵",
		"己阵出手次数",
		"星昼球-1",
		"星昼球"
	},
	{
		331001,
		1,
		2,
		2002,
		"己阵存活精灵",
		"己阵出手次数",
		"星昼球-2",
		"星昼球"
	},
	{
		331001,
		1,
		3,
		2003,
		"己阵闪避次数",
		"敌阵超杀次数",
		"王者球-1",
		"王者球"
	},
	{
		331001,
		1,
		4,
		2004,
		"己阵闪避次数",
		"敌阵超杀次数",
		"王者球-2",
		"王者球"
	},
	{
		331001,
		2,
		1,
		2005,
		"己阵存活精灵",
		"己阵出手次数",
		"星昼球-1",
		"星昼球"
	},
	{
		331001,
		2,
		2,
		2006,
		"己阵存活精灵",
		"己阵出手次数",
		"星昼球-2",
		"星昼球"
	},
	{
		331001,
		2,
		3,
		2007,
		"己阵闪避次数",
		"敌阵超杀次数",
		"王者球-1",
		"王者球"
	},
	{
		331001,
		2,
		4,
		2008,
		"己阵闪避次数",
		"敌阵超杀次数",
		"王者球-2",
		"王者球"
	},
	{
		331001,
		3,
		1,
		2009,
		"己阵存活精灵",
		"己阵出手次数",
		"星昼球-1",
		"星昼球"
	},
	{
		331001,
		3,
		2,
		2010,
		"己阵存活精灵",
		"己阵出手次数",
		"星昼球-2",
		"星昼球"
	},
	{
		331001,
		3,
		3,
		2011,
		"己阵闪避次数",
		"敌阵超杀次数",
		"王者球-1",
		"王者球"
	},
	{
		331001,
		3,
		4,
		2012,
		"己阵闪避次数",
		"敌阵超杀次数",
		"王者球-2",
		"王者球"
	}
}
local t_god_dark_dragon_buff_stage = {
	[331001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_god_dark_dragon_buff_stage.dataList = dataList

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

return t_god_dark_dragon_buff_stage
