-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mizong_clg_stage.lua

module("logicconfig.config.t_divine_mizong_clg_stage", package.seeall)

local title = {
	stageId = 2,
	starPrizePlan = 5,
	specialPetBuff = 3,
	skinId = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		477001,
		1,
		"20063901:1",
		1001,
		1,
		16025
	},
	{
		477001,
		2,
		"20063901:1",
		1002,
		1,
		16019
	},
	{
		477001,
		3,
		"20063901:1",
		1003,
		1,
		17018
	},
	{
		477001,
		4,
		"20063901:1",
		1004,
		1,
		17019
	},
	{
		477001,
		5,
		"20063901:1",
		1005,
		1,
		11014
	},
	{
		477001,
		6,
		"20063901:1",
		1006,
		1,
		12028
	},
	{
		477001,
		7,
		"20063901:1",
		1007,
		1,
		16031
	},
	{
		477001,
		8,
		"20063901:1",
		1008,
		1,
		16027
	},
	{
		477001,
		9,
		"20063901:1",
		1009,
		1,
		14026
	},
	{
		477001,
		10,
		"20063901:1",
		1010,
		1,
		12024
	},
	{
		477001,
		11,
		"20063901:1",
		1011,
		1,
		13023
	},
	{
		477001,
		12,
		"20063901:1",
		1012,
		1,
		14032
	}
}
local t_divine_mizong_clg_stage = {
	[477001] = {
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
		dataList[12]
	}
}

t_divine_mizong_clg_stage.dataList = dataList

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

return t_divine_mizong_clg_stage
