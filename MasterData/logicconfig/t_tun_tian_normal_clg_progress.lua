-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_normal_clg_progress.lua

module("logicconfig.config.t_tun_tian_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		289001,
		1,
		50,
		"8:1:1000000"
	},
	{
		289001,
		2,
		100,
		"4:197:5"
	},
	{
		289001,
		3,
		200,
		"4:90004:1"
	},
	{
		289001,
		4,
		400,
		"4:197:5"
	},
	{
		289001,
		5,
		600,
		"4:30006:40"
	},
	{
		289001,
		6,
		800,
		"4:197:10"
	},
	{
		289002,
		1,
		50,
		"8:1:1000"
	},
	{
		289002,
		2,
		100,
		"8:1:1000"
	},
	{
		289002,
		3,
		200,
		"8:1:1000"
	},
	{
		289002,
		4,
		400,
		"8:1:1000"
	},
	{
		289002,
		5,
		600,
		"8:1:1000"
	},
	{
		289002,
		6,
		800,
		"8:1:1000"
	}
}
local t_tun_tian_normal_clg_progress = {
	[289001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[289002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_tun_tian_normal_clg_progress.dataList = dataList

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

return t_tun_tian_normal_clg_progress
