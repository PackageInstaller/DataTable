-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_collector_bless.lua

module("logicconfig.config.t_goddess_collector_bless", package.seeall)

local title = {
	jumpTo = 4,
	name = 2,
	openDesc = 5,
	funcId = 3,
	id = 1
}
local dataList = {
	{
		1,
		"破阵天下",
		18,
		"func#18",
		"3.4-4.1开启\r\n女神加成   挑战次数翻倍"
	},
	{
		2,
		"世界Boss",
		93,
		"func#93",
		"3.4-3.18全天开放\r\n女神加成   魔王徽记翻倍"
	},
	{
		3,
		"失落遗迹",
		52,
		"func#52",
		"3.18-4.1开启\r\n女神加成   神器币提升50%"
	}
}
local t_goddess_collector_bless = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_goddess_collector_bless.dataList = dataList

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

return t_goddess_collector_bless
