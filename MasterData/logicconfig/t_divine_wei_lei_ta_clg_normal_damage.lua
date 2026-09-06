-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_wei_lei_ta_clg_normal_damage.lua

module("logicconfig.config.t_divine_wei_lei_ta_clg_normal_damage", package.seeall)

local title = {
	score = 3,
	activityId = 1,
	damage = 2
}
local dataList = {
	{
		433001,
		10000,
		20
	},
	{
		433001,
		5000000,
		30
	},
	{
		433001,
		8000000,
		50
	},
	{
		433001,
		10000000,
		100
	},
	{
		433001,
		30000000,
		150
	},
	{
		433002,
		10000,
		20
	},
	{
		433002,
		5000000,
		30
	},
	{
		433002,
		8000000,
		50
	},
	{
		433002,
		10000000,
		100
	},
	{
		433002,
		30000000,
		150
	}
}
local t_divine_wei_lei_ta_clg_normal_damage = {
	[433001] = {
		[10000] = dataList[1],
		[5000000] = dataList[2],
		[8000000] = dataList[3],
		[10000000] = dataList[4],
		[30000000] = dataList[5]
	},
	[433002] = {
		[10000] = dataList[6],
		[5000000] = dataList[7],
		[8000000] = dataList[8],
		[10000000] = dataList[9],
		[30000000] = dataList[10]
	}
}

t_divine_wei_lei_ta_clg_normal_damage.dataList = dataList

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

return t_divine_wei_lei_ta_clg_normal_damage
