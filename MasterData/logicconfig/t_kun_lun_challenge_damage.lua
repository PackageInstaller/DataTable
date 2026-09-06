-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_damage.lua

module("logicconfig.config.t_kun_lun_challenge_damage", package.seeall)

local title = {
	prizeId = 2,
	bossLeftHp = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		304001,
		1,
		8000,
		"8:1:250000"
	},
	{
		304001,
		2,
		7000,
		"4:30006:20"
	},
	{
		304001,
		3,
		6000,
		"8:1:250000"
	},
	{
		304001,
		4,
		5000,
		"4:30006:20"
	},
	{
		304001,
		5,
		4000,
		"8:1:500000"
	},
	{
		304001,
		6,
		3000,
		"4:205:10"
	},
	{
		304001,
		7,
		2000,
		"4:90004:1"
	},
	{
		304001,
		8,
		1000,
		"4:205:10"
	},
	{
		304001,
		9,
		0,
		"4:11002:10000"
	},
	{
		304002,
		1,
		8000,
		"8:1:1"
	},
	{
		304002,
		2,
		7000,
		"8:1:1"
	},
	{
		304002,
		3,
		6000,
		"8:1:1"
	},
	{
		304002,
		4,
		5000,
		"8:1:1"
	},
	{
		304002,
		5,
		4000,
		"8:1:1"
	},
	{
		304002,
		6,
		3000,
		"8:1:1"
	},
	{
		304002,
		7,
		2000,
		"8:1:1"
	},
	{
		304002,
		8,
		1000,
		"8:1:1"
	},
	{
		304002,
		9,
		0,
		"8:1:1"
	}
}
local t_kun_lun_challenge_damage = {
	[304001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[304002] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_kun_lun_challenge_damage.dataList = dataList

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

return t_kun_lun_challenge_damage
