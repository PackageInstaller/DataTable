-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_cube_level_config.lua

module("logicconfig.config.t_magic_cube_level_config", package.seeall)

local title = {
	levelPrize = 3,
	raceTipId = 5,
	raceIdList = 6,
	taskType = 8,
	funcTipId = 4,
	beginScore = 2,
	onekeyIdList = 7,
	level = 1
}
local dataList = {
	{
		1,
		0,
		"4:25:2",
		0,
		0
	},
	{
		2,
		1000,
		"4:25:2",
		0,
		0
	},
	{
		3,
		2000,
		"4:25:2",
		0,
		0
	},
	{
		4,
		3000,
		"4:25:2",
		0,
		0
	},
	{
		5,
		4200,
		"4:25:2",
		0,
		0
	},
	{
		6,
		5700,
		"4:25:2",
		0,
		0
	},
	{
		7,
		7900,
		"4:25:2",
		0,
		0
	},
	{
		8,
		11700,
		"4:25:2",
		0,
		0
	},
	{
		9,
		14000,
		"4:25:2",
		0,
		0
	},
	{
		10,
		15800,
		"4:25:2",
		0,
		0
	},
	{
		11,
		18600,
		"4:25:2",
		0,
		0
	},
	{
		12,
		23800,
		"4:25:2",
		0,
		0
	},
	{
		13,
		25800,
		"4:25:2",
		0,
		0
	},
	{
		14,
		30100,
		"4:25:2",
		0,
		0
	},
	{
		15,
		35500,
		"4:25:2",
		0,
		0
	},
	{
		16,
		37100,
		"4:25:2",
		0,
		0
	},
	{
		17,
		39900,
		"4:25:2",
		0,
		0
	},
	{
		18,
		45100,
		"4:25:2",
		0,
		0
	},
	{
		19,
		46700,
		"4:25:2",
		0,
		0
	},
	{
		20,
		53800,
		"4:25:2",
		0,
		0
	},
	{
		21,
		56700,
		"4:25:2",
		0,
		0
	}
}
local t_magic_cube_level_config = {
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
	dataList[21]
}

t_magic_cube_level_config.dataList = dataList

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

return t_magic_cube_level_config
