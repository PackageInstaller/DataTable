-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_attack_rank_prize.lua

module("logicconfig.config.t_breach_form_master_attack_rank_prize", package.seeall)

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
			10
		},
		"2:312:1#1:400051:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		1,
		2,
		{
			11,
			100
		},
		"2:312:1#1:400051:-1:1#104:2:800#8:1:800000"
	},
	{
		593001,
		1,
		3,
		{
			101,
			1000
		},
		"2:312:1#1:400051:-1:1#104:2:600#8:1:600000"
	},
	{
		593001,
		1,
		4,
		{
			1001,
			1500
		},
		"2:312:1#1:400051:-1:1#104:2:400#8:1:400000"
	},
	{
		593001,
		1,
		5,
		{
			1501,
			2000
		},
		"104:2:400#8:1:400000"
	},
	{
		593001,
		2,
		1,
		{
			1,
			10
		},
		"2:312:1#1:400051:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		2,
		2,
		{
			11,
			100
		},
		"2:312:1#1:400051:-1:1#104:2:800#8:1:800000"
	},
	{
		593001,
		2,
		3,
		{
			101,
			1000
		},
		"2:312:1#1:400051:-1:1#104:2:600#8:1:600000"
	},
	{
		593001,
		2,
		4,
		{
			1001,
			1500
		},
		"2:312:1#1:400051:-1:1#104:2:400#8:1:400000"
	},
	{
		593001,
		2,
		5,
		{
			1501,
			2000
		},
		"104:2:400#8:1:400000"
	},
	{
		593001,
		3,
		1,
		{
			1,
			10
		},
		"2:312:1#1:400051:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		3,
		2,
		{
			11,
			100
		},
		"2:312:1#1:400051:-1:1#104:2:800#8:1:800000"
	},
	{
		593001,
		3,
		3,
		{
			101,
			1000
		},
		"2:312:1#1:400051:-1:1#104:2:600#8:1:600000"
	},
	{
		593001,
		3,
		4,
		{
			1001,
			1500
		},
		"2:312:1#1:400051:-1:1#104:2:400#8:1:400000"
	},
	{
		593001,
		3,
		5,
		{
			1501,
			2000
		},
		"104:2:400#8:1:400000"
	},
	{
		593001,
		4,
		1,
		{
			1,
			10
		},
		"2:312:1#1:400051:-1:1#104:2:1000#8:1:1000000"
	},
	{
		593001,
		4,
		2,
		{
			11,
			100
		},
		"2:312:1#1:400051:-1:1#104:2:800#8:1:800000"
	},
	{
		593001,
		4,
		3,
		{
			101,
			1000
		},
		"2:312:1#1:400051:-1:1#104:2:600#8:1:600000"
	},
	{
		593001,
		4,
		4,
		{
			1001,
			1500
		},
		"2:312:1#1:400051:-1:1#104:2:400#8:1:400000"
	},
	{
		593001,
		4,
		5,
		{
			1501,
			2000
		},
		"104:2:400#8:1:400000"
	}
}
local t_breach_form_master_attack_rank_prize = {
	[593001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		}
	}
}

t_breach_form_master_attack_rank_prize.dataList = dataList

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

return t_breach_form_master_attack_rank_prize
