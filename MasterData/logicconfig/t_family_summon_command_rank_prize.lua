-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_summon_command_rank_prize.lua

module("logicconfig.config.t_family_summon_command_rank_prize", package.seeall)

local title = {
	rankPrizePlanId = 1,
	id = 2,
	medalId = 5,
	top = 3,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		10,
		"",
		11
	},
	{
		1,
		2,
		50,
		"",
		10
	},
	{
		1,
		3,
		100,
		"",
		9
	},
	{
		1,
		4,
		200,
		"",
		8
	},
	{
		1,
		5,
		300,
		"",
		7
	}
}
local t_family_summon_command_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_family_summon_command_rank_prize.dataList = dataList

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

return t_family_summon_command_rank_prize
