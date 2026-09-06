-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_stargod_level.lua

module("logicconfig.config.t_dragon_awaken_stargod_level", package.seeall)

local title = {
	cost = 4,
	starGodLv = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		419001,
		0,
		1,
		""
	},
	{
		419001,
		1,
		5,
		"10:419002:80"
	},
	{
		419001,
		2,
		10,
		"10:419002:80"
	},
	{
		419001,
		3,
		15,
		"10:419002:160"
	},
	{
		419001,
		4,
		20,
		"10:419002:160"
	},
	{
		419001,
		5,
		25,
		"10:419002:240"
	},
	{
		419001,
		6,
		30,
		"10:419002:240"
	},
	{
		419001,
		7,
		35,
		"10:419002:320"
	},
	{
		419001,
		8,
		40,
		"10:419002:320"
	},
	{
		419001,
		9,
		45,
		"10:419002:400"
	},
	{
		419001,
		10,
		50,
		"10:419002:400"
	},
	{
		419002,
		0,
		1,
		""
	},
	{
		419002,
		1,
		5,
		"10:419005:80"
	},
	{
		419002,
		2,
		10,
		"10:419005:80"
	},
	{
		419002,
		3,
		15,
		"10:419005:160"
	},
	{
		419002,
		4,
		20,
		"10:419005:160"
	},
	{
		419002,
		5,
		25,
		"10:419005:240"
	},
	{
		419002,
		6,
		30,
		"10:419005:240"
	},
	{
		419002,
		7,
		35,
		"10:419005:320"
	},
	{
		419002,
		8,
		40,
		"10:419005:320"
	},
	{
		419002,
		9,
		45,
		"10:419005:400"
	},
	{
		419002,
		10,
		50,
		"10:419005:400"
	}
}
local t_dragon_awaken_stargod_level = {
	[419001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	},
	[419002] = {
		[0] = dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	}
}

t_dragon_awaken_stargod_level.dataList = dataList

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

return t_dragon_awaken_stargod_level
