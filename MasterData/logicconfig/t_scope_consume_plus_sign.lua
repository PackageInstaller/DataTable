-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scope_consume_plus_sign.lua

module("logicconfig.config.t_scope_consume_plus_sign", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		324001,
		1,
		"4:90125:1#4:510135:1#4:36:10#8:1:100000#4:30001:220"
	},
	{
		324001,
		2,
		"4:36:10#4:31:20#60:1:360#8:1:500000"
	},
	{
		324001,
		3,
		"4:36:10#4:510022:5#4:30006:100#60:1:360#8:1:1000000"
	},
	{
		324002,
		1,
		"4:90125:1#60:1:360#4:36:10#4:31:10"
	},
	{
		324002,
		2,
		"4:510243:3#60:1:360#4:36:10#4:31:10"
	},
	{
		324002,
		3,
		"4:30006:100#60:1:360#4:36:10#4:31:10"
	},
	{
		324003,
		1,
		"4:90125:1#60:1:360#4:36:10#4:31:10"
	},
	{
		324003,
		2,
		"4:510243:3#60:1:360#4:36:10#4:31:10"
	},
	{
		324003,
		3,
		"100:10145:40:1#4:30006:100#4:36:10#4:31:10"
	}
}
local t_scope_consume_plus_sign = {
	[324001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[324002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[324003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_scope_consume_plus_sign.dataList = dataList

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

return t_scope_consume_plus_sign
