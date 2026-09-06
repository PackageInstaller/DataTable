-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_capsule_progress_prize.lua

module("logicconfig.config.t_time_capsule_progress_prize", package.seeall)

local title = {
	id = 1,
	leftProgress = 2,
	reward = 3
}
local dataList = {
	{
		1,
		3,
		"1:10008:-1:1#1:11008:-1:1"
	},
	{
		2,
		6,
		"1:10009:-1:1#1:11009:-1:1"
	},
	{
		3,
		10,
		"1:10010:-1:1#1:11010:-1:1"
	},
	{
		4,
		15,
		"1:10007:-1:1#1:11007:-1:1"
	},
	{
		5,
		20,
		"8:8:1000"
	},
	{
		6,
		25,
		"4:3019:1"
	},
	{
		7,
		30,
		"4:5103:60"
	},
	{
		8,
		35,
		"4:3101:10"
	},
	{
		9,
		40,
		"4:41003:1"
	}
}
local t_time_capsule_progress_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_time_capsule_progress_prize.dataList = dataList

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

return t_time_capsule_progress_prize
