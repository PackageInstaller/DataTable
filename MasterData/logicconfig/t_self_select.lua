-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_self_select.lua

module("logicconfig.config.t_self_select", package.seeall)

local title = {
	activityId = 1,
	dailyPrize = 2
}
local dataList = {
	{
		57001,
		"8:1:10000"
	},
	{
		57002,
		"8:1:10000"
	},
	{
		57003,
		"8:1:10000"
	}
}
local t_self_select = {
	[57001] = dataList[1],
	[57002] = dataList[2],
	[57003] = dataList[3]
}

t_self_select.dataList = dataList

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

return t_self_select
