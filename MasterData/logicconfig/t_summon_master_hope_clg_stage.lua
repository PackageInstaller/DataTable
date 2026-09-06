-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_hope_clg_stage.lua

module("logicconfig.config.t_summon_master_hope_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		403001,
		1,
		1001
	},
	{
		403001,
		2,
		1002
	},
	{
		403001,
		3,
		1003
	},
	{
		403001,
		4,
		1004
	},
	{
		403001,
		5,
		1005
	},
	{
		403001,
		6,
		1006
	}
}
local t_summon_master_hope_clg_stage = {
	[403001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_summon_master_hope_clg_stage.dataList = dataList

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

return t_summon_master_hope_clg_stage
