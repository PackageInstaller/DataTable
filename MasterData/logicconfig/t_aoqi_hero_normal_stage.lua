-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_normal_stage.lua

module("logicconfig.config.t_aoqi_hero_normal_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	raceId = 6,
	creepsMasterId = 3,
	prize = 4,
	unlock = 5
}
local dataList = {
	{
		450001,
		1,
		101,
		"10:450002:200#10:450001:100",
		true,
		10196
	},
	{
		450001,
		2,
		102,
		"10:450002:240#10:450001:100",
		false,
		10196
	},
	{
		450001,
		3,
		103,
		"10:450002:280#10:450001:100",
		true,
		10196
	},
	{
		450001,
		4,
		104,
		"10:450002:320#10:450001:100",
		false,
		13016
	},
	{
		450001,
		5,
		105,
		"10:450002:360#10:450001:100",
		true,
		11025
	},
	{
		450001,
		6,
		106,
		"10:450002:400#10:450001:100",
		false,
		16027
	},
	{
		450001,
		7,
		107,
		"10:450002:440#10:450001:100",
		false,
		14018
	},
	{
		450001,
		8,
		108,
		"10:450002:480#10:450001:100",
		false,
		10196
	},
	{
		450001,
		9,
		109,
		"10:450002:520#10:450001:100",
		false,
		10037
	},
	{
		450001,
		10,
		110,
		"10:450002:560#10:450001:100",
		false,
		10330
	},
	{
		450001,
		11,
		111,
		"10:450002:600#10:450001:100",
		false,
		15018
	},
	{
		450001,
		12,
		112,
		"10:450002:650#10:450001:100",
		false,
		16029
	},
	{
		450001,
		13,
		113,
		"10:450002:700#10:450001:100",
		false,
		11021
	},
	{
		450001,
		14,
		114,
		"10:450002:750#10:450001:100",
		false,
		12025
	},
	{
		450001,
		15,
		115,
		"10:450002:800#10:450001:100",
		false,
		12019
	},
	{
		450001,
		16,
		116,
		"10:450002:900#10:450001:100",
		false,
		15028
	},
	{
		450001,
		17,
		117,
		"10:450002:1000#10:450001:100",
		false,
		16029
	},
	{
		450001,
		18,
		118,
		"10:450002:1200#10:450001:100",
		false,
		13016
	},
	{
		450001,
		19,
		119,
		"10:450002:1400#10:450001:100",
		false,
		11022
	},
	{
		450001,
		20,
		120,
		"10:450002:1600#10:450001:100",
		false,
		12019
	}
}
local t_aoqi_hero_normal_stage = {
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

t_aoqi_hero_normal_stage.dataList = dataList

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

return t_aoqi_hero_normal_stage
