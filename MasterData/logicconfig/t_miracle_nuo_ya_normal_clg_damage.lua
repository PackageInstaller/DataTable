-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_nuo_ya_normal_clg_damage.lua

module("logicconfig.config.t_miracle_nuo_ya_normal_clg_damage", package.seeall)

local title = {
	score = 4,
	damageRange = 3,
	desc = 5,
	activityId = 1,
	subId = 2
}
local dataList = {
	{
		382001,
		1,
		{
			10000,
			5000000
		},
		20,
		"1万-500万获得积分"
	},
	{
		382001,
		2,
		{
			5000000,
			8000000
		},
		30,
		"500万-800万获得积分"
	},
	{
		382001,
		3,
		{
			8000000,
			10000000
		},
		50,
		"800万-1000万获得积分"
	},
	{
		382001,
		4,
		{
			10000000,
			30000000
		},
		100,
		"1000万-3000万获得积分"
	},
	{
		382001,
		5,
		{
			30000000,
			999999999
		},
		150,
		"3000万及以上伤害获得积分"
	},
	{
		382002,
		1,
		{
			10000,
			5000000
		},
		20,
		"1万-500万获得积分"
	},
	{
		382002,
		2,
		{
			5000000,
			8000000
		},
		30,
		"500万-800万获得积分"
	},
	{
		382002,
		3,
		{
			8000000,
			10000000
		},
		50,
		"800万-1000万获得积分"
	},
	{
		382002,
		4,
		{
			10000000,
			30000000
		},
		100,
		"1000万-3000万获得积分"
	},
	{
		382002,
		5,
		{
			30000000,
			999999999
		},
		150,
		"3000万及以上伤害获得积分"
	}
}
local t_miracle_nuo_ya_normal_clg_damage = {
	[382001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[382002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_miracle_nuo_ya_normal_clg_damage.dataList = dataList

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

return t_miracle_nuo_ya_normal_clg_damage
