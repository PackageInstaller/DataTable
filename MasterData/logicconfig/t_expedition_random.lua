-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_random.lua

module("logicconfig.config.t_expedition_random", package.seeall)

local title = {
	id = 1,
	name = 2,
	icon = 4,
	desc = 3
}
local dataList = {
	{
		1,
		"回1血",
		"恢复小奥奇1点血量",
		"icon_expedition_chaofang"
	},
	{
		2,
		"回2血",
		"恢复小奥奇2点血量",
		"icon_expedition_chaofang"
	},
	{
		3,
		"气势满",
		"下次战斗，己方满气势",
		"icon_expedition_chaofang"
	},
	{
		4,
		"奖励",
		"直接获得一次奖励",
		"icon_expedition_chaofang"
	},
	{
		5,
		"圣器",
		"直接获得一个圣器",
		"icon_expedition_chaofang"
	}
}
local t_expedition_random = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_expedition_random.dataList = dataList

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

return t_expedition_random
