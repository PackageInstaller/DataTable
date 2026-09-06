-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ares_mom_clg_normal_stage.lua

module("logicconfig.config.t_origin_ares_mom_clg_normal_stage", package.seeall)

local title = {
	creepsMasterIds = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		549001,
		1,
		{
			1007,
			1008,
			1009
		}
	},
	{
		549001,
		2,
		{
			1010,
			1011,
			1012
		}
	},
	{
		549001,
		3,
		{
			1013,
			1014,
			1015
		}
	},
	{
		549001,
		4,
		{
			1016,
			1017,
			1018
		}
	}
}
local t_origin_ares_mom_clg_normal_stage = {
	[549001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_origin_ares_mom_clg_normal_stage.dataList = dataList

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

return t_origin_ares_mom_clg_normal_stage
