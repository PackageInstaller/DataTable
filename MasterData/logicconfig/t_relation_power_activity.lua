-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_relation_power_activity.lua

module("logicconfig.config.t_relation_power_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		354001,
		565
	},
	{
		354002,
		565
	},
	{
		354003,
		565
	},
	{
		354004,
		565
	},
	{
		354005,
		565
	},
	{
		354006,
		565
	},
	{
		354007,
		565
	},
	{
		354008,
		565
	},
	{
		354009,
		565
	}
}
local t_relation_power_activity = {
	[354001] = dataList[1],
	[354002] = dataList[2],
	[354003] = dataList[3],
	[354004] = dataList[4],
	[354005] = dataList[5],
	[354006] = dataList[6],
	[354007] = dataList[7],
	[354008] = dataList[8],
	[354009] = dataList[9]
}

t_relation_power_activity.dataList = dataList

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

return t_relation_power_activity
