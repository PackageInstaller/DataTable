-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jackpot_activity.lua

module("logicconfig.config.t_jackpot_activity", package.seeall)

local title = {
	id = 1,
	jackpot = 2,
	activityItem = 3
}
local dataList = {
	{
		3001,
		1,
		"10:3001:250"
	},
	{
		3002,
		1,
		"10:3002:250"
	},
	{
		3003,
		1,
		"10:3003:250"
	},
	{
		3004,
		1,
		"10:3004:250"
	},
	{
		3010,
		2,
		"10:3010:100"
	},
	{
		3011,
		3,
		"10:3011:9"
	}
}
local t_jackpot_activity = {
	[3001] = dataList[1],
	[3002] = dataList[2],
	[3003] = dataList[3],
	[3004] = dataList[4],
	[3010] = dataList[5],
	[3011] = dataList[6]
}

t_jackpot_activity.dataList = dataList

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

return t_jackpot_activity
