-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_activity.lua

module("logicconfig.config.t_annuity_activity", package.seeall)

local title = {
	forwardPayOpenTime = 5,
	activityId = 1,
	mainview = 9,
	headIconId = 11,
	forwardPayEndTime = 6,
	redPointId = 10,
	forwardPayExtraPrize = 7,
	year = 8,
	fixedGain = 3,
	price = 2,
	weeklyGain = 4
}
local dataList = {
	{
		8001,
		19800,
		"100:10313:40:1#4:36:10",
		"104:2:500",
		nil,
		nil,
		"",
		2021,
		"yearcardmainview",
		46,
		1
	},
	{
		8002,
		19800,
		"",
		"104:2:500#8:1:30000#4:503:7#4:30003:6#4:3:4",
		nil,
		nil,
		"",
		2022,
		"yearcardmain2022view",
		190,
		1
	},
	{
		8003,
		19800,
		"",
		"4:30006:50#4:510126:1#104:2:500#8:1:30000#4:503:7#4:30003:6#4:3:4",
		"2022-12-23T05:00:00",
		"2022-12-30T05:00:00",
		"4:90341:4#4:90342:2",
		2023,
		"yearcardmain2023view",
		438,
		115
	},
	{
		8004,
		19800,
		"",
		"4:30006:100#4:510243:3#104:2:500#8:1:1000000#4:503:70#4:30003:60#4:3:40#4:12102:7",
		nil,
		nil,
		"",
		2024,
		"yearcardmain2024view",
		543,
		219
	},
	{
		8005,
		19800,
		"",
		"4:30006:100#4:510243:3#104:2:500#8:1:1000000#4:503:70#4:30003:60#4:3:40#4:12102:7",
		nil,
		nil,
		"",
		2025,
		"yearcardmain2025view",
		438,
		348
	},
	{
		8006,
		19800,
		"",
		"4:400004:15#4:30006:100#4:510243:3#104:2:500#4:12102:7#4:90274:450",
		nil,
		nil,
		"",
		2026,
		"yearcardmain2026view",
		543,
		492
	}
}
local t_annuity_activity = {
	[8001] = dataList[1],
	[8002] = dataList[2],
	[8003] = dataList[3],
	[8004] = dataList[4],
	[8005] = dataList[5],
	[8006] = dataList[6]
}

t_annuity_activity.dataList = dataList

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

return t_annuity_activity
