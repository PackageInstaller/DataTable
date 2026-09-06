-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_monster_wave_plan.lua

module("logicconfig.config.t_origin_material_game_monster_wave_plan", package.seeall)

local title = {
	monsterPlanId = 1,
	waveGroupList = 2
}
local dataList = {
	{
		1,
		"1#2#3#4#5#6#7#8#9"
	},
	{
		2,
		"10#11#12#13#14#15#16#17#18"
	},
	{
		3,
		"19#20#21#22#23#24#25#26#27"
	},
	{
		4,
		"28#29#30#31#32#33#34#35#36"
	},
	{
		5,
		"37#38#39#40#41#42#43#44#45"
	},
	{
		6,
		"46#47#48"
	}
}
local t_origin_material_game_monster_wave_plan = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_origin_material_game_monster_wave_plan.dataList = dataList

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

return t_origin_material_game_monster_wave_plan
