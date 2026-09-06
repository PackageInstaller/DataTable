-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scope_consume_plus_activity.lua

module("logicconfig.config.t_scope_consume_plus_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 3,
	signInConsume = 2
}
local dataList = {
	{
		324001,
		600,
		534
	},
	{
		324002,
		600,
		534
	},
	{
		324003,
		600,
		534
	}
}
local t_scope_consume_plus_activity = {
	[324001] = dataList[1],
	[324002] = dataList[2],
	[324003] = dataList[3]
}

t_scope_consume_plus_activity.dataList = dataList

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

return t_scope_consume_plus_activity
