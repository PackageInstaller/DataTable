-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_normal_stage.lua

module("logicconfig.config.t_summon_master_ji_normal_stage", package.seeall)

local title = {
	stageId = 2,
	addNormalProgress = 5,
	chapterId = 3,
	creepsMasterId = 6,
	chapterName = 4,
	activityId = 1
}
local dataList = {
	{
		348001,
		1,
		1,
		"Ⅰ",
		10,
		1001
	},
	{
		348001,
		2,
		1,
		"Ⅰ",
		10,
		1002
	},
	{
		348001,
		3,
		1,
		"Ⅰ",
		10,
		1003
	},
	{
		348001,
		4,
		2,
		"Ⅱ",
		10,
		1004
	},
	{
		348001,
		5,
		2,
		"Ⅱ",
		10,
		1005
	},
	{
		348001,
		6,
		2,
		"Ⅱ",
		10,
		1006
	},
	{
		348001,
		7,
		3,
		"Ⅲ",
		10,
		1007
	},
	{
		348001,
		8,
		3,
		"Ⅲ",
		10,
		1008
	},
	{
		348001,
		9,
		3,
		"Ⅲ",
		10,
		1009
	}
}
local t_summon_master_ji_normal_stage = {
	[348001] = {
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

t_summon_master_ji_normal_stage.dataList = dataList

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

return t_summon_master_ji_normal_stage
