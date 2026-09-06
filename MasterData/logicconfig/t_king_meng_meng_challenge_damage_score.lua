-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_damage_score.lua

module("logicconfig.config.t_king_meng_meng_challenge_damage_score", package.seeall)

local title = {
	score = 4,
	damage = 3,
	activityId = 1,
	damageId = 2
}
local dataList = {
	{
		278001,
		1,
		50000,
		40
	},
	{
		278001,
		2,
		100000,
		60
	},
	{
		278001,
		3,
		200000,
		80
	},
	{
		278001,
		4,
		400000,
		100
	},
	{
		278001,
		5,
		600000,
		120
	},
	{
		278001,
		6,
		800000,
		160
	},
	{
		278001,
		7,
		1000000,
		200
	},
	{
		278002,
		1,
		50000,
		40
	},
	{
		278002,
		2,
		100000,
		60
	},
	{
		278002,
		3,
		200000,
		80
	},
	{
		278002,
		4,
		400000,
		100
	},
	{
		278002,
		5,
		600000,
		120
	},
	{
		278002,
		6,
		800000,
		160
	},
	{
		278002,
		7,
		1000000,
		200
	}
}
local t_king_meng_meng_challenge_damage_score = {
	[278001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[278002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_king_meng_meng_challenge_damage_score.dataList = dataList

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

return t_king_meng_meng_challenge_damage_score
