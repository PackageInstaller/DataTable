-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_dishitian_actiivty.lua

module("logicconfig.config.t_dragon_dishitian_actiivty", package.seeall)

local title = {
	challengeId = 3,
	name = 2,
	jumpTo2 = 5,
	jumpTo1 = 4,
	actDesc = 8,
	jumpToAct = 7,
	activityId = 1,
	jumpTo3 = 6
}
local dataList = {
	{
		343001,
		"龙皇帝释天挑战",
		152,
		"func#1040",
		"mibao#liudaojijie5",
		"func#618#16023",
		"",
		""
	},
	{
		343002,
		"黄金龙皇阿瑞斯挑战",
		246,
		"func#1263",
		"mibao#liudaojijie5",
		"func#618#14036",
		"",
		""
	}
}
local t_dragon_dishitian_actiivty = {
	[343001] = dataList[1],
	[343002] = dataList[2]
}

t_dragon_dishitian_actiivty.dataList = dataList

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

return t_dragon_dishitian_actiivty
