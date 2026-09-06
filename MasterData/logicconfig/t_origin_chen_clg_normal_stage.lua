-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_chen_clg_normal_stage.lua

module("logicconfig.config.t_origin_chen_clg_normal_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	creepsMasterId = 3,
	prize = 4,
	tagBuff = 5
}
local dataList = {
	{
		620001,
		1,
		1010,
		"8:1:1000000",
		1
	},
	{
		620001,
		2,
		1011,
		"4:445:5",
		2
	},
	{
		620001,
		3,
		1012,
		"4:445:5",
		3
	},
	{
		620001,
		4,
		1013,
		"4:445:5",
		4
	},
	{
		620001,
		5,
		1014,
		"4:445:5",
		1
	},
	{
		620001,
		6,
		1015,
		"4:90004:1",
		2
	},
	{
		620001,
		7,
		1016,
		"4:30006:10",
		3
	},
	{
		620001,
		8,
		1017,
		"4:30006:10",
		4
	},
	{
		620001,
		9,
		1018,
		"4:30006:20",
		1
	}
}
local t_origin_chen_clg_normal_stage = {
	[620001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_origin_chen_clg_normal_stage.dataList = dataList

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

return t_origin_chen_clg_normal_stage
