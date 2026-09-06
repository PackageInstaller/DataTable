-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_powers_clg_common_stage.lua

module("logicconfig.config.t_origin_powers_clg_common_stage", package.seeall)

local title = {
	creepsMasterId = 3,
	signBuffId = 4,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		576001,
		1,
		{
			1001,
			1002,
			1003
		},
		0
	},
	{
		576001,
		2,
		{
			1001,
			1002,
			1003
		},
		0
	},
	{
		576001,
		3,
		{
			1001,
			1002,
			1003
		},
		0
	}
}
local t_origin_powers_clg_common_stage = {
	[576001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_powers_clg_common_stage.dataList = dataList

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

return t_origin_powers_clg_common_stage
