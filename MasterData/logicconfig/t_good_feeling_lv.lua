-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_feeling_lv.lua

module("logicconfig.config.t_good_feeling_lv", package.seeall)

local title = {
	lv = 1,
	exp = 2
}
local dataList = {
	{
		1,
		0
	},
	{
		2,
		50
	},
	{
		3,
		150
	},
	{
		4,
		300
	},
	{
		5,
		500
	},
	{
		6,
		800
	},
	{
		7,
		1200
	},
	{
		8,
		1700
	},
	{
		9,
		2300
	},
	{
		10,
		3000
	},
	{
		11,
		3850
	},
	{
		12,
		4850
	},
	{
		13,
		6000
	},
	{
		14,
		7300
	},
	{
		15,
		8800
	},
	{
		16,
		10500
	},
	{
		17,
		12400
	},
	{
		18,
		14500
	},
	{
		19,
		16800
	},
	{
		20,
		19300
	},
	{
		21,
		22300
	},
	{
		22,
		25800
	},
	{
		23,
		29800
	},
	{
		24,
		34300
	},
	{
		25,
		39300
	},
	{
		26,
		44800
	},
	{
		27,
		50800
	},
	{
		28,
		57300
	},
	{
		29,
		64300
	},
	{
		30,
		71800
	}
}
local t_good_feeling_lv = {
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

t_good_feeling_lv.dataList = dataList

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

return t_good_feeling_lv
