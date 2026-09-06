-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_monster_wave_plan.lua

module("logicconfig.config.t_defend_carrot_monster_wave_plan", package.seeall)

local title = {
	monsterPlanId = 1,
	waveGroupList = 2
}
local dataList = {
	{
		1,
		"1#2#3"
	},
	{
		2,
		"1#2#3#4#5#6"
	},
	{
		3,
		"1#2#3#4#5#6#7#8#9"
	},
	{
		4,
		"10#11#12"
	},
	{
		5,
		"10#11#12#13#14#15"
	},
	{
		6,
		"10#11#12#13#14#15#16#17#18"
	},
	{
		7,
		"19#20#21"
	},
	{
		8,
		"19#20#21#22#23#24"
	},
	{
		9,
		"19#20#21#22#23#24#25#26#27"
	},
	{
		10,
		"28#29#30"
	},
	{
		11,
		"28#29#30#31#32#33"
	},
	{
		12,
		"28#29#30#31#32#33#34#35#36"
	},
	{
		13,
		"37#38#39"
	},
	{
		14,
		"37#38#39#40#41#42"
	},
	{
		15,
		"37#38#39#40#41#42#43#44#45"
	},
	{
		16,
		"1#2#3#4#5#6#7#8#9#16#17#18#25#26#27#34#35#36#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45"
	},
	{
		17,
		"19#20#21#22#23#24#25#26#27#34#35#36#34#35#36#34#35#36#34#35#36#34#35#36#34#35#36#34#35#36"
	},
	{
		18,
		"37#38#39#40#41#42#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45#43#44#45"
	}
}
local t_defend_carrot_monster_wave_plan = {
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
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18]
}

t_defend_carrot_monster_wave_plan.dataList = dataList

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

return t_defend_carrot_monster_wave_plan
