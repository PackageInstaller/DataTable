-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hundred_raffle_extra.lua

module("logicconfig.config.t_hundred_raffle_extra", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"activityId",
		"13001"
	}
}
local t_hundred_raffle_extra = {
	activityId = dataList[1]
}

t_hundred_raffle_extra.dataList = dataList

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

return t_hundred_raffle_extra
