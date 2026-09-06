-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_convoy_box_upgrade_cost.lua

module("logicconfig.config.t_convoy_box_upgrade_cost", package.seeall)

local title = {
	consume = 2,
	times = 1
}
local dataList = {
	{
		1,
		""
	},
	{
		2,
		""
	},
	{
		3,
		""
	},
	{
		4,
		"8:1:2000"
	},
	{
		5,
		"8:1:2000"
	},
	{
		6,
		"8:1:3000"
	},
	{
		7,
		"8:1:3000"
	},
	{
		8,
		"8:1:5000"
	},
	{
		9,
		"8:1:5000"
	},
	{
		10,
		"8:1:5000"
	},
	{
		11,
		"105:138:5"
	},
	{
		12,
		"105:138:5"
	},
	{
		13,
		"105:138:5"
	},
	{
		14,
		"105:138:5"
	},
	{
		15,
		"105:138:5"
	},
	{
		16,
		"105:138:10"
	},
	{
		17,
		"105:138:10"
	},
	{
		18,
		"105:138:10"
	},
	{
		19,
		"105:138:10"
	},
	{
		20,
		"105:138:10"
	},
	{
		21,
		"105:138:10"
	},
	{
		22,
		"105:138:10"
	},
	{
		23,
		"105:138:10"
	},
	{
		24,
		"105:138:10"
	},
	{
		25,
		"105:138:10"
	},
	{
		26,
		"105:138:10"
	},
	{
		27,
		"105:138:10"
	},
	{
		28,
		"105:138:10"
	},
	{
		29,
		"105:138:10"
	},
	{
		30,
		"105:138:10"
	}
}
local t_convoy_box_upgrade_cost = {
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
	dataList[28],
	dataList[29],
	dataList[30]
}

t_convoy_box_upgrade_cost.dataList = dataList

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

return t_convoy_box_upgrade_cost
