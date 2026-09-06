-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_party_prize_check_in.lua

module("logicconfig.config.t_party_prize_check_in", package.seeall)

local title = {
	reward = 4,
	dayText = 3,
	posterName = 5,
	entranceBgName = 6,
	posterText = 7,
	checkInPlanId = 1,
	posterTitle = 8,
	day = 2
}
local dataList = {
	{
		1,
		1,
		"",
		"4:10:120",
		"",
		"",
		"",
		""
	},
	{
		1,
		2,
		"",
		"4:30002:20",
		"",
		"",
		"",
		""
	},
	{
		1,
		3,
		"",
		"4:91007:1",
		"",
		"",
		"",
		""
	},
	{
		1,
		4,
		"",
		"4:90100:4",
		"",
		"",
		"",
		""
	},
	{
		1,
		5,
		"",
		"4:112:10",
		"",
		"",
		"",
		""
	},
	{
		1,
		6,
		"",
		"4:71:2",
		"",
		"",
		"",
		""
	},
	{
		1,
		7,
		"",
		"4:90031:1",
		"",
		"",
		"",
		""
	}
}
local t_party_prize_check_in = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_party_prize_check_in.dataList = dataList

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

return t_party_prize_check_in
