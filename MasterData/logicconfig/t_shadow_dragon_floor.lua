-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shadow_dragon_floor.lua

module("logicconfig.config.t_shadow_dragon_floor", package.seeall)

local title = {
	stageId = 2,
	ruleDesc = 5,
	floorType = 4,
	tabName = 3,
	activityId = 1
}
local dataList = {
	{
		527001,
		1,
		"现在",
		1,
		"1、通关当前层任意关卡后，上阵精灵将被锁定：阵亡精灵进入「过去空间」，存活精灵进入「未来空间」。下一层中，过去关卡仅可使用过去空间的精灵，未来关卡仅可使用未来空间的精灵，请谨慎选择上阵精灵。\r\n2、现在层关卡开始前，需从三个选项中选择一个进入关卡：直接挑战、「回响」、「缩影」。其中选择“回响”或“缩影”后，所对应的debuff将在关卡中生效；且二者可在第二层作为buff道具使用，具体效果详见规则说明。"
	},
	{
		527001,
		2,
		"过去未来",
		2,
		"1、本层过去关仅可使用「过去空间」中的精灵，未来关仅可使用「未来空间」中的精灵。\r\n2、过去关和未来关中敌阵各有不同效果，详见说明规则和局内说明。\r\n3、挑战过去关时可以使用缩影，挑战未来关时可以使用回响，每一关仅可使用一个，挑战通关则扣除，二者效果详见规则说明或布阵界面内buff说明"
	}
}
local t_shadow_dragon_floor = {
	[527001] = {
		dataList[1],
		dataList[2]
	}
}

t_shadow_dragon_floor.dataList = dataList

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

return t_shadow_dragon_floor
