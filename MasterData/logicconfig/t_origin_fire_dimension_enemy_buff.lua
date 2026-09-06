-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fire_dimension_enemy_buff.lua

module("logicconfig.config.t_origin_fire_dimension_enemy_buff", package.seeall)

local title = {
	zoneDesc = 3,
	range = 2,
	activityId = 1,
	showDesc = 4
}
local dataList = {
	{
		560001,
		4,
		"4-7",
		"敌阵减伤、非伤减伤及全属性+10%"
	},
	{
		560001,
		8,
		"8-11",
		"敌阵减伤、非伤减伤及全属性+20%"
	},
	{
		560001,
		12,
		"12-15",
		"敌阵减伤、非伤减伤及全属性+30%"
	},
	{
		560001,
		16,
		"16-19",
		"敌阵减伤、非伤减伤+50%，全属性+30%且免疫所有负面状态"
	},
	{
		560001,
		20,
		"20以上",
		"敌阵减伤、非伤减伤+50%，全属性+30%且首次受到致命伤害时，解除无法回血状态并恢复50%的生命值"
	}
}
local t_origin_fire_dimension_enemy_buff = {
	[560001] = {
		[4] = dataList[1],
		[8] = dataList[2],
		[12] = dataList[3],
		[16] = dataList[4],
		[20] = dataList[5]
	}
}

t_origin_fire_dimension_enemy_buff.dataList = dataList

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

return t_origin_fire_dimension_enemy_buff
