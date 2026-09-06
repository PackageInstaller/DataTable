-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_popularity_list_base.lua

module("logicconfig.config.t_popularity_list_base", package.seeall)

local title = {
	fameHallActId = 3,
	comPlanId = 2,
	activityId = 1
}
local dataList = {
	{
		72001,
		1,
		0
	},
	{
		72002,
		1,
		0
	},
	{
		72003,
		1,
		0
	},
	{
		72004,
		1,
		0
	},
	{
		72005,
		1,
		0
	},
	{
		72006,
		1,
		541001
	}
}
local t_popularity_list_base = {
	[72001] = dataList[1],
	[72002] = dataList[2],
	[72003] = dataList[3],
	[72004] = dataList[4],
	[72005] = dataList[5],
	[72006] = dataList[6]
}

t_popularity_list_base.dataList = dataList

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

return t_popularity_list_base
