-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_hero_rank_prize.lua

module("logicconfig.config.t_ao_qi_attack_force_hero_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		436001,
		{
			1,
			100
		},
		"1-100名",
		"2:207:1#104:2:1000#8:1:1000000"
	},
	{
		436001,
		{
			101,
			500
		},
		"101-500名",
		"2:207:1#104:2:800#8:1:800000"
	},
	{
		436001,
		{
			501,
			1000
		},
		"501-1000名",
		"2:207:1#104:2:500#8:1:500000"
	},
	{
		436001,
		{
			1001,
			5000
		},
		"1001-5000名",
		"2:207:1#104:2:200#8:1:200000"
	},
	{
		436002,
		{
			1,
			100
		},
		"1-100名",
		"2:207:1#104:2:1000#8:1:1000000"
	},
	{
		436002,
		{
			101,
			500
		},
		"101-500名",
		"2:207:1#104:2:800#8:1:800000"
	},
	{
		436002,
		{
			501,
			1000
		},
		"501-1000名",
		"2:207:1#104:2:500#8:1:500000"
	},
	{
		436002,
		{
			1001,
			5000
		},
		"1001-5000名",
		"2:207:1#104:2:200#8:1:200000"
	}
}
local t_ao_qi_attack_force_hero_rank_prize = {
	[436001] = {
		[{
			1,
			100
		}] = dataList[1],
		[{
			101,
			500
		}] = dataList[2],
		[{
			501,
			1000
		}] = dataList[3],
		[{
			1001,
			5000
		}] = dataList[4]
	},
	[436002] = {
		[{
			1,
			100
		}] = dataList[5],
		[{
			101,
			500
		}] = dataList[6],
		[{
			501,
			1000
		}] = dataList[7],
		[{
			1001,
			5000
		}] = dataList[8]
	}
}

t_ao_qi_attack_force_hero_rank_prize.dataList = dataList

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

return t_ao_qi_attack_force_hero_rank_prize
