-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_auto_show_mall.lua

module("logicconfig.config.t_pay_auto_show_mall", package.seeall)

local title = {
	activityType = 2,
	id = 1,
	shopId = 3
}
local dataList = {
	{
		1,
		123001,
		33007
	},
	{
		2,
		123001,
		33008
	},
	{
		3,
		123001,
		33009
	},
	{
		4,
		123001,
		33010
	},
	{
		5,
		123001,
		33011
	},
	{
		6,
		123001,
		33012
	},
	{
		7,
		126001,
		36001
	},
	{
		8,
		126001,
		36002
	},
	{
		9,
		126001,
		36003
	},
	{
		10,
		126001,
		36004
	},
	{
		11,
		126001,
		36005
	},
	{
		12,
		126001,
		36006
	},
	{
		13,
		126001,
		36007
	},
	{
		14,
		96009,
		38055
	},
	{
		15,
		96009,
		38056
	},
	{
		16,
		96009,
		38057
	},
	{
		17,
		96009,
		38058
	},
	{
		18,
		96009,
		38059
	},
	{
		19,
		96009,
		38060
	},
	{
		20,
		96009,
		38061
	},
	{
		21,
		1,
		70001
	},
	{
		22,
		1,
		70002
	},
	{
		23,
		1,
		70003
	},
	{
		24,
		1,
		70004
	},
	{
		25,
		1,
		70005
	},
	{
		26,
		1,
		70006
	},
	{
		27,
		1,
		4001
	},
	{
		28,
		1,
		13001
	},
	{
		29,
		1,
		13002
	},
	{
		30,
		1,
		13003
	}
}
local t_pay_auto_show_mall = {
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

t_pay_auto_show_mall.dataList = dataList

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

return t_pay_auto_show_mall
