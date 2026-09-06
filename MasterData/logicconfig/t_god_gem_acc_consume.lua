-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_gem_acc_consume.lua

module("logicconfig.config.t_god_gem_acc_consume", package.seeall)

local title = {
	realityPrizeProgressReq = 3,
	sendLimitCost = 5,
	realityPrizeName = 4,
	activityId = 1,
	realityPrizeLimit = 2
}
local dataList = {
	{
		114001,
		900,
		9880,
		"小诺银饰",
		1000
	},
	{
		114002,
		0,
		0,
		"",
		6480
	},
	{
		114003,
		0,
		0,
		"",
		6480
	},
	{
		114004,
		0,
		0,
		"",
		9999999
	},
	{
		114005,
		0,
		0,
		"",
		9999999
	},
	{
		114006,
		0,
		0,
		"",
		9999999
	},
	{
		114007,
		0,
		0,
		"",
		9999999
	},
	{
		114008,
		0,
		0,
		"",
		9999999
	},
	{
		114009,
		0,
		0,
		"",
		9999999
	},
	{
		114010,
		0,
		0,
		"",
		9999999
	},
	{
		114011,
		0,
		0,
		"",
		9999999
	},
	{
		114012,
		0,
		0,
		"",
		9999999
	},
	{
		114013,
		0,
		0,
		"",
		9999999
	},
	{
		114014,
		0,
		0,
		"",
		9999999
	},
	{
		114015,
		0,
		0,
		"",
		9999999
	},
	{
		114016,
		0,
		0,
		"",
		9999999
	},
	{
		114017,
		0,
		0,
		"",
		9999999
	},
	{
		114018,
		0,
		0,
		"",
		9999999
	},
	{
		114019,
		0,
		0,
		"",
		0
	}
}
local t_god_gem_acc_consume = {
	[114001] = dataList[1],
	[114002] = dataList[2],
	[114003] = dataList[3],
	[114004] = dataList[4],
	[114005] = dataList[5],
	[114006] = dataList[6],
	[114007] = dataList[7],
	[114008] = dataList[8],
	[114009] = dataList[9],
	[114010] = dataList[10],
	[114011] = dataList[11],
	[114012] = dataList[12],
	[114013] = dataList[13],
	[114014] = dataList[14],
	[114015] = dataList[15],
	[114016] = dataList[16],
	[114017] = dataList[17],
	[114018] = dataList[18],
	[114019] = dataList[19]
}

t_god_gem_acc_consume.dataList = dataList

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

return t_god_gem_acc_consume
