-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_infinite_future_helper_pet.lua

module("logicconfig.config.t_infinite_future_helper_pet", package.seeall)

local title = {
	lv = 5,
	creepsName = 4,
	creepsId = 2,
	onlyUseExtProperties = 7,
	raceId = 3,
	extproperties = 6,
	planId = 1,
	faceId = 8
}
local dataList = {
	{
		1,
		1000000001,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+134639#攻击+27878#物防+8315#魔防+8315#速度+3564",
		true,
		""
	},
	{
		2,
		1000000002,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+179519#攻击+37170#物防+11087#魔防+11087#速度+4752",
		true,
		""
	},
	{
		3,
		1000000003,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+233376#攻击+48323#物防+14414#魔防+14414#速度+6176",
		true,
		""
	},
	{
		4,
		1000000004,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+296207#攻击+61331#物防+18294#魔防+18294#速度+7841",
		true,
		""
	},
	{
		5,
		1000000005,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+359039#攻击+74341#物防+22175#魔防+22175#速度+9504",
		true,
		""
	},
	{
		6,
		1000000006,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+412895#攻击+85493#物防+25501#魔防+25501#速度+10929",
		true,
		""
	},
	{
		7,
		1000000007,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+430848#攻击+89211#物防+26611#魔防+26611#速度+11404",
		true,
		""
	},
	{
		8,
		1000000008,
		12005,
		"迷魇之主·维蕾塔",
		100,
		"生命+448800#攻击+92927#物防+27719#魔防+27719#速度+11879",
		true,
		""
	}
}
local t_infinite_future_helper_pet = {
	{
		[1000000001] = dataList[1]
	},
	{
		[1000000002] = dataList[2]
	},
	{
		[1000000003] = dataList[3]
	},
	{
		[1000000004] = dataList[4]
	},
	{
		[1000000005] = dataList[5]
	},
	{
		[1000000006] = dataList[6]
	},
	{
		[1000000007] = dataList[7]
	},
	{
		[1000000008] = dataList[8]
	}
}

t_infinite_future_helper_pet.dataList = dataList

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

return t_infinite_future_helper_pet
