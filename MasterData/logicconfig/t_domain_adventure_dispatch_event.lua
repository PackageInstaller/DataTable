-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_dispatch_event.lua

module("logicconfig.config.t_domain_adventure_dispatch_event", package.seeall)

local title = {
	levelPlan = 4,
	skinPlan = 5,
	skinId = 7,
	prizePlanId = 3,
	dispatchId = 2,
	activityId = 1,
	awakenPlan = 6
}
local dataList = {
	{
		402001,
		3001,
		2,
		1,
		2,
		3,
		14023
	},
	{
		402001,
		3002,
		2,
		1,
		2,
		3,
		14024
	},
	{
		402001,
		3003,
		2,
		1,
		2,
		3,
		12020
	},
	{
		402001,
		3004,
		2,
		1,
		2,
		3,
		12021
	},
	{
		402001,
		3005,
		2,
		1,
		2,
		3,
		14013
	},
	{
		402001,
		3006,
		2,
		1,
		2,
		3,
		13008
	},
	{
		402001,
		3007,
		2,
		1,
		2,
		3,
		14023
	},
	{
		402001,
		3008,
		2,
		1,
		2,
		3,
		11020
	},
	{
		402001,
		3009,
		2,
		1,
		2,
		3,
		11019
	},
	{
		402001,
		3010,
		2,
		1,
		2,
		3,
		11021
	},
	{
		402001,
		3011,
		2,
		1,
		2,
		3,
		11023
	},
	{
		402001,
		3012,
		2,
		1,
		2,
		3,
		16024
	},
	{
		402001,
		3013,
		2,
		1,
		2,
		3,
		11021
	},
	{
		402001,
		3014,
		2,
		1,
		2,
		3,
		11023
	},
	{
		402001,
		3015,
		2,
		1,
		2,
		3,
		16024
	},
	{
		402001,
		3016,
		2,
		1,
		2,
		3,
		11023
	},
	{
		402001,
		3017,
		2,
		1,
		2,
		3,
		16024
	},
	{
		402001,
		3018,
		2,
		1,
		2,
		3,
		11021
	},
	{
		402001,
		3019,
		2,
		1,
		2,
		3,
		11023
	},
	{
		402001,
		3020,
		2,
		1,
		2,
		3,
		16024
	}
}
local t_domain_adventure_dispatch_event = {
	[402001] = {
		[3001] = dataList[1],
		[3002] = dataList[2],
		[3003] = dataList[3],
		[3004] = dataList[4],
		[3005] = dataList[5],
		[3006] = dataList[6],
		[3007] = dataList[7],
		[3008] = dataList[8],
		[3009] = dataList[9],
		[3010] = dataList[10],
		[3011] = dataList[11],
		[3012] = dataList[12],
		[3013] = dataList[13],
		[3014] = dataList[14],
		[3015] = dataList[15],
		[3016] = dataList[16],
		[3017] = dataList[17],
		[3018] = dataList[18],
		[3019] = dataList[19],
		[3020] = dataList[20]
	}
}

t_domain_adventure_dispatch_event.dataList = dataList

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

return t_domain_adventure_dispatch_event
