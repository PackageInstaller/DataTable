-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_phantom_space_buff.lua

module("logicconfig.config.t_phantom_space_buff", package.seeall)

local title = {
	activityId = 1,
	buffPrize = 4,
	buffLv = 2,
	desc = 3
}
local dataList = {
	{
		516001,
		1,
		"敌阵全属性+<color=#20b376>10%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		2,
		"敌阵全属性+<color=#20b376>20%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		3,
		"敌阵全属性+<color=#20b376>30%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		4,
		"敌阵全属性+<color=#20b376>40%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		5,
		"敌阵全属性+<color=#20b376>50%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		6,
		"敌阵全属性+<color=#20b376>100%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		7,
		"敌阵全属性+<color=#20b376>150%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		8,
		"敌阵全属性+<color=#20b376>200%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		9,
		"敌阵全属性+<color=#20b376>250%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		10,
		"敌阵全属性+<color=#20b376>300%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		11,
		"敌阵全属性+<color=#20b376>500%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		12,
		"敌阵全属性+<color=#20b376>800%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516001,
		13,
		"敌阵全属性+<color=#20b376>1200%</color>",
		"10:287015:100#8:1:15000000"
	},
	{
		516002,
		1,
		"敌阵全属性+<color=#20b376>10%</color>",
		"10:287016:100"
	},
	{
		516002,
		2,
		"敌阵全属性+<color=#20b376>20%</color>",
		"10:287016:100"
	},
	{
		516002,
		3,
		"敌阵全属性+<color=#20b376>30%</color>",
		"10:287016:100"
	},
	{
		516002,
		4,
		"敌阵全属性+<color=#20b376>40%</color>",
		"10:287016:100"
	},
	{
		516002,
		5,
		"敌阵全属性+<color=#20b376>50%</color>",
		"10:287016:100"
	},
	{
		516002,
		6,
		"敌阵全属性+<color=#20b376>100%</color>",
		"10:287016:100"
	},
	{
		516002,
		7,
		"敌阵全属性+<color=#20b376>150%</color>",
		"10:287016:100"
	},
	{
		516002,
		8,
		"敌阵全属性+<color=#20b376>200%</color>",
		"10:287016:100"
	},
	{
		516002,
		9,
		"敌阵全属性+<color=#20b376>250%</color>",
		"10:287016:100"
	},
	{
		516002,
		10,
		"敌阵全属性+<color=#20b376>300%</color>",
		"10:287016:100"
	},
	{
		516002,
		11,
		"敌阵全属性+<color=#20b376>500%</color>",
		"10:287016:100"
	},
	{
		516002,
		12,
		"敌阵全属性+<color=#20b376>800%</color>",
		"10:287016:100"
	},
	{
		516002,
		13,
		"敌阵全属性+<color=#20b376>1200%</color>",
		"10:287016:100"
	}
}
local t_phantom_space_buff = {
	[516001] = {
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
		dataList[13]
	},
	[516002] = {
		dataList[14],
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
		dataList[26]
	}
}

t_phantom_space_buff.dataList = dataList

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

return t_phantom_space_buff
