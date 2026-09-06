-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_item.lua

module("logicconfig.config.t_unique_world_item", package.seeall)

local title = {
	effects = 3,
	name = 2,
	itemId = 1,
	matStr = 5,
	desc = 4
}
local dataList = {
	{
		1,
		"回血丹",
		"addHp$1#300000",
		"回复一只精灵的部分血量。",
		"1004:1613"
	},
	{
		2,
		"复活丹",
		"recover$1",
		"可解除1只精灵的疲劳状态并满血。",
		"1004:1614"
	},
	{
		3,
		"全属性提升",
		"buff$1#2",
		"使用后的2场战斗获得全属性+50%增益",
		"1004:1615"
	},
	{
		4,
		"获得气势",
		"buff$2#2",
		"使用后的2场战斗获得50气势增益",
		"1004:1616"
	},
	{
		5,
		"暴击率提升",
		"buff$3#2",
		"使用后的2场战斗获得暴击率+50%增益",
		"1004:1617"
	},
	{
		6,
		"闪避率提升",
		"buff$4#2",
		"使用后的2场战斗获得闪避率+50%增益",
		"1004:1618"
	}
}
local t_unique_world_item = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_unique_world_item.dataList = dataList

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

return t_unique_world_item
