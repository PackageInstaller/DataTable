-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_infinite_future_clg_value.lua

module("logicconfig.config.t_origin_infinite_future_clg_value", package.seeall)

local title = {
	buffId = 3,
	valueWanPercent = 4,
	activityId = 1,
	type = 2
}
local dataList = {
	{
		619001,
		1,
		20074802,
		500
	},
	{
		619001,
		2,
		20074804,
		300
	},
	{
		619001,
		3,
		20074806,
		1000
	}
}
local t_origin_infinite_future_clg_value = {
	[619001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_infinite_future_clg_value.dataList = dataList

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

return t_origin_infinite_future_clg_value
