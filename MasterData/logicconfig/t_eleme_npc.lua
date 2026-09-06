-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eleme_npc.lua

module("logicconfig.config.t_eleme_npc", package.seeall)

local title = {
	index = 1,
	npcId = 3,
	sceneName = 2,
	name = 4
}
local dataList = {
	{
		1,
		"曙光森林",
		1171028,
		"爱吃薯条的小白鸡"
	},
	{
		2,
		"梦之岛",
		1061019,
		"唯爱汉堡的小白鸡"
	},
	{
		3,
		"召唤师大陆",
		1071007,
		"喜欢肥宅水的小白鸡"
	},
	{
		4,
		"砂之国",
		1111010,
		"爱吃套餐的小白鸡"
	},
	{
		5,
		"蓝龙湾",
		1141029,
		"爱吃甜筒的小白鸡"
	}
}
local t_eleme_npc = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_eleme_npc.dataList = dataList

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

return t_eleme_npc
