-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_dragon_nuo_ya_clg.lua

module("logicconfig.config.t_ci_yuan_dragon_nuo_ya_clg", package.seeall)

local title = {
	extremeClgPrize = 3,
	jumpStrOne = 4,
	skinId = 9,
	jumpStrThree = 6,
	bubbleItem = 10,
	jumpStrTwo = 5,
	redPointId = 2,
	jumpStrFive = 8,
	jumpStrFour = 7,
	activityId = 1
}
local dataList = {
	{
		408001,
		587,
		"",
		"func#618#14030",
		"mibao#shenyaonuoya6",
		"func#1134",
		"",
		"",
		14030,
		""
	}
}
local t_ci_yuan_dragon_nuo_ya_clg = {
	[408001] = dataList[1]
}

t_ci_yuan_dragon_nuo_ya_clg.dataList = dataList

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

return t_ci_yuan_dragon_nuo_ya_clg
