-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_ao_jiu_clg_stage.lua

module("logicconfig.config.t_heart_of_ao_jiu_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	activityId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		505001,
		1,
		1001,
		"敖九之心 I"
	},
	{
		505001,
		2,
		1002,
		"敖九之心 II"
	},
	{
		505001,
		3,
		1003,
		"敖九之心 III"
	},
	{
		505001,
		4,
		1004,
		"敖九之心 IV"
	}
}
local t_heart_of_ao_jiu_clg_stage = {
	[505001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_heart_of_ao_jiu_clg_stage.dataList = dataList

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

return t_heart_of_ao_jiu_clg_stage
