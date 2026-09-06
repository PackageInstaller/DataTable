-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ci_yuan_universal_signin_price.lua

module("logicconfig.config.t_divine_ci_yuan_universal_signin_price", package.seeall)

local title = {
	price = 3,
	activityId = 1,
	days = 2
}
local dataList = {
	{
		302001,
		1,
		"204:22000313:100"
	},
	{
		302001,
		2,
		"204:22000313:200"
	},
	{
		302001,
		3,
		"204:22000313:300"
	},
	{
		302001,
		4,
		"204:22000313:400"
	},
	{
		302001,
		5,
		"204:22000313:500"
	},
	{
		302001,
		6,
		"204:22000313:600"
	},
	{
		302001,
		7,
		"204:22000313:700"
	},
	{
		302001,
		8,
		"204:22000313:800"
	},
	{
		302001,
		9,
		"204:22000313:900"
	},
	{
		302001,
		10,
		"204:22000313:1000"
	},
	{
		302001,
		11,
		"204:22000313:1100"
	},
	{
		302001,
		12,
		"204:22000313:1200"
	},
	{
		302001,
		13,
		"204:22000313:1300"
	},
	{
		302001,
		14,
		"204:22000313:1400"
	},
	{
		302002,
		1,
		"204:22000313:100"
	},
	{
		302002,
		2,
		"204:22000313:200"
	},
	{
		302002,
		3,
		"204:22000313:300"
	},
	{
		302002,
		4,
		"204:22000313:400"
	},
	{
		302002,
		5,
		"204:22000313:500"
	},
	{
		302002,
		6,
		"204:22000313:600"
	},
	{
		302002,
		7,
		"204:22000313:700"
	},
	{
		302002,
		8,
		"204:22000313:800"
	},
	{
		302002,
		9,
		"204:22000313:900"
	},
	{
		302002,
		10,
		"204:22000313:1000"
	},
	{
		302002,
		11,
		"204:22000313:1100"
	},
	{
		302002,
		12,
		"204:22000313:1200"
	},
	{
		302002,
		13,
		"204:22000313:1300"
	},
	{
		302002,
		14,
		"204:22000313:1400"
	}
}
local t_divine_ci_yuan_universal_signin_price = {
	[302001] = {
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
	[302002] = {
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

t_divine_ci_yuan_universal_signin_price.dataList = dataList

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

return t_divine_ci_yuan_universal_signin_price
