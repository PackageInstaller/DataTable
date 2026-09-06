-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_upcoming_unlock_person_prize.lua

module("logicconfig.config.t_upcoming_unlock_person_prize", package.seeall)

local title = {
	prizeId = 2,
	num = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		181009,
		1,
		1,
		"60:1:500"
	},
	{
		181009,
		2,
		2,
		"60:1:500"
	},
	{
		181009,
		3,
		3,
		"60:1:500"
	},
	{
		181009,
		4,
		4,
		"60:1:500"
	},
	{
		181009,
		5,
		5,
		"60:1:500"
	},
	{
		181009,
		6,
		6,
		"60:1:500"
	},
	{
		181012,
		1,
		1,
		"104:2:100"
	},
	{
		181012,
		2,
		2,
		"104:2:100"
	},
	{
		181012,
		3,
		3,
		"104:2:100"
	},
	{
		181012,
		4,
		4,
		"104:2:100"
	},
	{
		181012,
		5,
		5,
		"104:2:100"
	},
	{
		181012,
		6,
		6,
		"104:2:100"
	}
}
local t_upcoming_unlock_person_prize = {
	[181009] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[181012] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_upcoming_unlock_person_prize.dataList = dataList

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

return t_upcoming_unlock_person_prize
