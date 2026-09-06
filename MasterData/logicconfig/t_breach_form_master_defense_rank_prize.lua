-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_defense_rank_prize.lua

module("logicconfig.config.t_breach_form_master_defense_rank_prize", package.seeall)

local title = {
	stepId = 2,
	prize = 5,
	rank = 4,
	id = 3,
	activityId = 1
}
local dataList = {
	{
		593001,
		1,
		1,
		{
			1,
			8
		},
		"2:313:1#1:400050:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		2,
		1,
		{
			1,
			8
		},
		"2:313:1#1:400050:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		3,
		1,
		{
			1,
			8
		},
		"2:313:1#1:400050:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		4,
		1,
		{
			1,
			8
		},
		"2:313:1#1:400050:-1:1#104:2:1000#8:1:1000000"
	}
}
local t_breach_form_master_defense_rank_prize = {
	[593001] = {
		{
			dataList[1]
		},
		{
			dataList[2]
		},
		{
			dataList[3]
		},
		{
			dataList[4]
		}
	}
}

t_breach_form_master_defense_rank_prize.dataList = dataList

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

return t_breach_form_master_defense_rank_prize
