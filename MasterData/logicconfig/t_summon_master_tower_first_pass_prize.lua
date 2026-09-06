-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_first_pass_prize.lua

module("logicconfig.config.t_summon_master_tower_first_pass_prize", package.seeall)

local title = {
	prizeId = 2,
	stageReq = 3,
	seasonId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		10,
		"4:112:1#4:11:30#10:199001:1000"
	},
	{
		1,
		2,
		20,
		"4:112:1#4:11:30#10:199001:1000"
	},
	{
		1,
		3,
		30,
		"4:112:1#4:11:30#10:199001:1000"
	},
	{
		2,
		1,
		10,
		"4:112:1#4:11:30#10:199001:1000"
	},
	{
		2,
		2,
		20,
		"4:112:1#4:11:30#10:199001:1000"
	},
	{
		2,
		3,
		30,
		"4:112:1#4:11:30#10:199001:1000"
	},
	{
		3,
		1,
		10,
		"4:112:1#4:11:30#10:199002:1000"
	},
	{
		3,
		2,
		20,
		"4:112:1#4:11:30#10:199002:1000"
	},
	{
		3,
		3,
		30,
		"4:112:1#4:11:30#10:199002:1000"
	},
	{
		4,
		1,
		10,
		"4:112:1#4:11:30#10:85003:1000"
	},
	{
		4,
		2,
		20,
		"4:112:1#4:11:30#10:85003:1000"
	},
	{
		4,
		3,
		30,
		"4:112:1#4:11:30#10:85003:1000"
	},
	{
		5,
		1,
		10,
		"4:112:1#4:11:30#10:85004:1000"
	},
	{
		5,
		2,
		20,
		"4:112:1#4:11:30#10:85004:1000"
	},
	{
		5,
		3,
		30,
		"4:112:1#4:11:30#10:85004:1000"
	},
	{
		6,
		1,
		10,
		"4:112:1#4:11:30#10:85005:1000"
	},
	{
		6,
		2,
		20,
		"4:112:1#4:11:30#10:85005:1000"
	},
	{
		6,
		3,
		30,
		"4:112:1#4:11:30#10:85005:1000"
	}
}
local t_summon_master_tower_first_pass_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_summon_master_tower_first_pass_prize.dataList = dataList

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

return t_summon_master_tower_first_pass_prize
