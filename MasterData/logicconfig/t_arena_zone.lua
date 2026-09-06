-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_arena_zone.lua

module("logicconfig.config.t_arena_zone", package.seeall)

local title = {
	zoneName = 2,
	maxCapacity = 3,
	zoneId = 1
}
local dataList = {
	{
		1,
		"001战区",
		10000
	},
	{
		2,
		"002战区",
		10000
	},
	{
		3,
		"003战区",
		10000
	},
	{
		4,
		"004战区",
		10000
	},
	{
		5,
		"005战区",
		10000
	},
	{
		6,
		"006战区",
		10000
	},
	{
		7,
		"007战区",
		10000
	},
	{
		8,
		"008战区",
		10000
	},
	{
		9,
		"009战区",
		10000
	},
	{
		10,
		"010战区",
		10000
	},
	{
		11,
		"011战区",
		10000
	},
	{
		12,
		"012战区",
		10000
	},
	{
		13,
		"013战区",
		10000
	},
	{
		14,
		"014战区",
		10000
	},
	{
		15,
		"015战区",
		10000
	},
	{
		16,
		"016战区",
		10000
	},
	{
		17,
		"017战区",
		10000
	},
	{
		18,
		"018战区",
		10000
	},
	{
		19,
		"019战区",
		10000
	},
	{
		20,
		"020战区",
		10000
	},
	{
		21,
		"021战区",
		10000
	},
	{
		22,
		"022战区",
		10000
	},
	{
		23,
		"023战区",
		10000
	},
	{
		24,
		"024战区",
		10000
	},
	{
		25,
		"025战区",
		10000
	}
}
local t_arena_zone = {
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
	dataList[25]
}

t_arena_zone.dataList = dataList

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

return t_arena_zone
