-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_potluck_dinner_npc.lua

module("logicconfig.config.t_potluck_dinner_npc", package.seeall)

local title = {
	npcId = 2,
	activityId = 1,
	foodType = 3
}
local dataList = {
	{
		196001,
		10011037,
		1
	},
	{
		196001,
		10011038,
		1
	},
	{
		196001,
		10011039,
		1
	},
	{
		196001,
		10011040,
		1
	},
	{
		196001,
		10011041,
		1
	},
	{
		196001,
		10011042,
		1
	},
	{
		196001,
		10011043,
		2
	},
	{
		196001,
		10011044,
		2
	},
	{
		196001,
		10011045,
		2
	},
	{
		196001,
		10011046,
		2
	},
	{
		196001,
		10011047,
		2
	},
	{
		196001,
		10011048,
		2
	},
	{
		196001,
		10011052,
		2
	},
	{
		196001,
		10011053,
		2
	},
	{
		196001,
		10011054,
		2
	},
	{
		196001,
		10011055,
		2
	},
	{
		196001,
		10011056,
		3
	},
	{
		196001,
		10011057,
		3
	},
	{
		196001,
		10011058,
		3
	},
	{
		196001,
		10011059,
		3
	},
	{
		196001,
		10011060,
		3
	},
	{
		196001,
		10011061,
		3
	},
	{
		196001,
		10011062,
		3
	},
	{
		196001,
		10011063,
		3
	},
	{
		196001,
		10011064,
		3
	},
	{
		196001,
		10011065,
		3
	}
}
local t_potluck_dinner_npc = {
	[196001] = {
		[10011037] = dataList[1],
		[10011038] = dataList[2],
		[10011039] = dataList[3],
		[10011040] = dataList[4],
		[10011041] = dataList[5],
		[10011042] = dataList[6],
		[10011043] = dataList[7],
		[10011044] = dataList[8],
		[10011045] = dataList[9],
		[10011046] = dataList[10],
		[10011047] = dataList[11],
		[10011048] = dataList[12],
		[10011052] = dataList[13],
		[10011053] = dataList[14],
		[10011054] = dataList[15],
		[10011055] = dataList[16],
		[10011056] = dataList[17],
		[10011057] = dataList[18],
		[10011058] = dataList[19],
		[10011059] = dataList[20],
		[10011060] = dataList[21],
		[10011061] = dataList[22],
		[10011062] = dataList[23],
		[10011063] = dataList[24],
		[10011064] = dataList[25],
		[10011065] = dataList[26]
	}
}

t_potluck_dinner_npc.dataList = dataList

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

return t_potluck_dinner_npc
