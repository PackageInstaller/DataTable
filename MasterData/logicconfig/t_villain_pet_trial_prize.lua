-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_villain_pet_trial_prize.lua

module("logicconfig.config.t_villain_pet_trial_prize", package.seeall)

local title = {
	index = 2,
	socre = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		20,
		"4:111:10"
	},
	{
		1,
		2,
		60,
		"4:111:10"
	},
	{
		1,
		3,
		120,
		"24:100441:1"
	},
	{
		1,
		4,
		140,
		"4:30006:10"
	},
	{
		1,
		5,
		180,
		"24:100442:1"
	},
	{
		1,
		6,
		220,
		"4:30006:10"
	},
	{
		1,
		7,
		240,
		"4:30006:10"
	},
	{
		1,
		8,
		270,
		"24:100443:1"
	},
	{
		1,
		9,
		300,
		"4:30006:10"
	},
	{
		1,
		10,
		330,
		"4:30006:10"
	},
	{
		1,
		11,
		360,
		"4:30006:10"
	},
	{
		1,
		12,
		375,
		"24:100444:1"
	}
}
local t_villain_pet_trial_prize = {
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
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_villain_pet_trial_prize.dataList = dataList

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

return t_villain_pet_trial_prize
