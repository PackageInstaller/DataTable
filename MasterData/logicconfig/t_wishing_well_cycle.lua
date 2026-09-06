-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishing_well_cycle.lua

module("logicconfig.config.t_wishing_well_cycle", package.seeall)

local title = {
	prizePlanId = 3,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		101
	},
	{
		1,
		11,
		102
	},
	{
		2,
		1,
		201
	},
	{
		2,
		11,
		202
	},
	{
		3,
		1,
		301
	},
	{
		3,
		11,
		302
	}
}
local t_wishing_well_cycle = {
	{
		dataList[1],
		[11] = dataList[2]
	},
	{
		dataList[3],
		[11] = dataList[4]
	},
	{
		dataList[5],
		[11] = dataList[6]
	}
}

t_wishing_well_cycle.dataList = dataList

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

return t_wishing_well_cycle
