-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_wheel_revert_awaken.lua

module("logicconfig.config.t_time_wheel_revert_awaken", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"price",
		"1000"
	},
	{
		"needAwakenLv",
		"1"
	}
}
local t_time_wheel_revert_awaken = {
	price = dataList[1],
	needAwakenLv = dataList[2]
}

t_time_wheel_revert_awaken.dataList = dataList

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

return t_time_wheel_revert_awaken
