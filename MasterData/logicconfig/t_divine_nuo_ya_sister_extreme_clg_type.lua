-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_extreme_clg_type.lua

module("logicconfig.config.t_divine_nuo_ya_sister_extreme_clg_type", package.seeall)

local title = {
	name = 3,
	typeId = 2,
	activityId = 1
}
local dataList = {
	{
		407001,
		1,
		"日"
	},
	{
		407001,
		2,
		"夜"
	},
	{
		407002,
		1,
		"日"
	},
	{
		407002,
		2,
		"夜"
	}
}
local t_divine_nuo_ya_sister_extreme_clg_type = {
	[407001] = {
		dataList[1],
		dataList[2]
	},
	[407002] = {
		dataList[3],
		dataList[4]
	}
}

t_divine_nuo_ya_sister_extreme_clg_type.dataList = dataList

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

return t_divine_nuo_ya_sister_extreme_clg_type
