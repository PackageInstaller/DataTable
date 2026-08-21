-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_heroSortRule.lua

module("logic.config.t_heroSortRule", package.seeall)

local title = {
	defense = 9,
	quality = 5,
	authority = 4,
	maxHp = 12,
	yitaiAttack = 10,
	yitaiDefense = 11,
	breakthrough = 6,
	sanity = 13,
	defaultRule = 2,
	tacit = 7,
	attack = 8,
	code = 1,
	level = 3
}
local dataList = {
	{
		1,
		"2#3#4#5#6#8#9#10#11#12#13#14#15#1",
		"2#4#3#5#6#8#9#10#11#12#13#14#15#1",
		"3#4#2#5#6#8#9#10#11#12#13#14#15#1",
		"4#2#3#5#6#8#9#10#11#12#13#14#15#1",
		"5#4#2#3#6#8#9#10#11#12#13#14#15#1",
		"6#4#2#5#3#8#9#10#11#12#13#14#15#1",
		"9#4#3#5#6#8#2#10#11#12#13#14#15#1",
		"10#4#3#5#6#8#9#2#11#12#13#14#15#1",
		"11#4#3#5#6#8#9#10#2#12#13#14#15#1",
		"12#4#3#5#6#8#9#10#11#2#13#14#15#1",
		"8#4#3#5#6#2#9#10#11#12#13#14#15#1",
		"13#4#3#5#6#8#9#10#11#12#2#14#15#1"
	},
	{
		2,
		"2#3#4#5#6#8#9#10#11#12#13#14#15#1",
		"2#4#3#5#6#8#9#10#11#12#13#14#15#1",
		"3#4#2#5#6#8#9#10#11#12#13#14#15#1",
		"4#2#3#5#6#8#9#10#11#12#13#14#15#1",
		"5#4#2#3#6#8#9#10#11#12#13#14#15#1",
		"6#4#2#5#3#8#9#10#11#12#13#14#15#1",
		"9#4#3#5#6#8#2#10#11#12#13#14#15#1",
		"10#4#3#5#6#8#9#2#11#12#13#14#15#1",
		"11#4#3#5#6#8#9#10#2#12#13#14#15#1",
		"12#4#3#5#6#8#9#10#11#2#13#14#15#1",
		"8#4#3#5#6#2#9#10#11#12#13#14#15#1",
		"13#4#3#5#6#8#9#10#11#12#2#14#15#1"
	},
	{
		3,
		"4#6#14#1",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
}
local t_heroSortRule = {}

t_heroSortRule.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_heroSortRule[v[1]] = v

	setmetatable(v, mt)
end

return t_heroSortRule
