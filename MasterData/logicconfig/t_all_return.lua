-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_all_return.lua

module("logicconfig.config.t_all_return", package.seeall)

local title = {
	cost = 2,
	prize = 3,
	activityId = 1,
	returnPrizeTime = 4
}
local dataList = {
	{
		107001,
		"8:1:5000",
		"8:1:5000",
		"2022-01-28T05:00:00"
	}
}
local t_all_return = {
	[107001] = dataList[1]
}

t_all_return.dataList = dataList

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

return t_all_return
