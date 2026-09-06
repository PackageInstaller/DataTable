-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_summon_command_progress_prize.lua

module("logicconfig.config.t_family_summon_command_progress_prize", package.seeall)

local title = {
	id = 2,
	score = 3,
	progressPrizePlanId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		2000,
		"4:10:120"
	},
	{
		1,
		2,
		10000,
		"8:27:750"
	},
	{
		1,
		3,
		20000,
		"4:10:120"
	},
	{
		1,
		4,
		30000,
		"8:27:750"
	},
	{
		1,
		5,
		40000,
		"4:10:120"
	},
	{
		1,
		6,
		50000,
		"8:27:750"
	},
	{
		1,
		7,
		60000,
		"4:10:120"
	},
	{
		1,
		8,
		70000,
		"8:27:750"
	},
	{
		1,
		9,
		80000,
		"4:10:120"
	},
	{
		1,
		10,
		100000,
		"1:12012:-1:1"
	}
}
local t_family_summon_command_progress_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_family_summon_command_progress_prize.dataList = dataList

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

return t_family_summon_command_progress_prize
