-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scope_consume_sign_prize.lua

module("logicconfig.config.t_scope_consume_sign_prize", package.seeall)

local title = {
	day = 3,
	prize = 4,
	activityId = 1,
	consumeMoney = 2
}
local dataList = {
	{
		8001,
		600,
		1,
		"100:10309:40:1#4:32:2#4:90039:1#8:1:50000"
	},
	{
		8001,
		600,
		2,
		"4:40004:2#8:1:50000#4:30002:20"
	},
	{
		8001,
		600,
		3,
		"4:40005:1#8:1:100000#4:30002:30"
	},
	{
		8002,
		600,
		1,
		"4:90125:1#4:90126:1#8:1:100000#4:30001:30"
	},
	{
		8002,
		600,
		2,
		"4:31:10#4:32:1#8:1:100000#4:30001:30"
	},
	{
		8002,
		600,
		3,
		"4:31:10#4:32:1#8:1:100000#4:30001:30"
	},
	{
		8003,
		600,
		1,
		"4:90125:1#4:510135:1#8:1:100000#4:30001:220"
	},
	{
		8003,
		600,
		2,
		"4:31:10#60:1:120#8:1:100000#8:8:1000"
	},
	{
		8003,
		600,
		3,
		"4:31:10#60:1:120#8:1:100000#4:502:86"
	}
}
local t_scope_consume_sign_prize = {
	[8001] = {
		[600] = {
			dataList[1],
			dataList[2],
			dataList[3]
		}
	},
	[8002] = {
		[600] = {
			dataList[4],
			dataList[5],
			dataList[6]
		}
	},
	[8003] = {
		[600] = {
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_scope_consume_sign_prize.dataList = dataList

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

return t_scope_consume_sign_prize
