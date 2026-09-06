-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_buff.lua

module("logicconfig.config.t_seek_food_buff", package.seeall)

local title = {
	desc = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		282001,
		1,
		"全属性+<color=#20b376>10%</color>"
	},
	{
		282001,
		2,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		3,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		4,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		5,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		6,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		7,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		8,
		"全属性+<color=#20b376>10%</color>"
	},
	{
		282001,
		9,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		10,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		11,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		12,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		13,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		14,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		15,
		"全属性+<color=#20b376>10%</color>"
	},
	{
		282001,
		16,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		17,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		18,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		19,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		20,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		21,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		22,
		"全属性+<color=#20b376>10%</color>"
	},
	{
		282001,
		23,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		24,
		"全属性+<color=#20b376>20%</color>"
	},
	{
		282001,
		25,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		26,
		"全属性+<color=#20b376>30%</color>"
	},
	{
		282001,
		27,
		"全属性+<color=#20b376>40%</color>"
	},
	{
		282001,
		28,
		"全属性+<color=#20b376>40%</color>"
	}
}
local t_seek_food_buff = {
	[282001] = {
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

t_seek_food_buff.dataList = dataList

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

return t_seek_food_buff
