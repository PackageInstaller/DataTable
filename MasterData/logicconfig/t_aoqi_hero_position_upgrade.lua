-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_position_upgrade.lua

module("logicconfig.config.t_aoqi_hero_position_upgrade", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		450001,
		1,
		""
	},
	{
		450001,
		2,
		"10:450002:20"
	},
	{
		450001,
		3,
		"10:450002:30"
	},
	{
		450001,
		4,
		"10:450002:40"
	},
	{
		450001,
		5,
		"10:450002:60"
	},
	{
		450001,
		6,
		"10:450002:80"
	},
	{
		450001,
		7,
		"10:450002:100"
	},
	{
		450001,
		8,
		"10:450002:120"
	},
	{
		450001,
		9,
		"10:450002:140"
	},
	{
		450001,
		10,
		"10:450002:160"
	},
	{
		450001,
		11,
		"10:450002:180"
	},
	{
		450001,
		12,
		"10:450002:200"
	},
	{
		450001,
		13,
		"10:450002:225"
	},
	{
		450001,
		14,
		"10:450002:250"
	},
	{
		450001,
		15,
		"10:450002:275"
	},
	{
		450001,
		16,
		"10:450002:300"
	},
	{
		450001,
		17,
		"10:450002:350"
	},
	{
		450001,
		18,
		"10:450002:400"
	},
	{
		450001,
		19,
		"10:450002:450"
	},
	{
		450001,
		20,
		"10:450002:500"
	}
}
local t_aoqi_hero_position_upgrade = {
	[450001] = {
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
		dataList[20]
	}
}

t_aoqi_hero_position_upgrade.dataList = dataList

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

return t_aoqi_hero_position_upgrade
