-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_boss_damage_plan.lua

module("logicconfig.config.t_king_ciyuan_boss_damage_plan", package.seeall)

local title = {
	id = 2,
	prize = 4,
	damage = 3,
	dmgPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1000000,
		"10:241001:100"
	},
	{
		1,
		2,
		2000000,
		"10:241001:200"
	},
	{
		1,
		3,
		4000000,
		"10:241001:300"
	},
	{
		1,
		4,
		6000000,
		"10:241001:400"
	},
	{
		1,
		5,
		8000000,
		"10:241001:500"
	},
	{
		1,
		6,
		10000000,
		"10:241001:600"
	}
}
local t_king_ciyuan_boss_damage_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_king_ciyuan_boss_damage_plan.dataList = dataList

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

return t_king_ciyuan_boss_damage_plan
