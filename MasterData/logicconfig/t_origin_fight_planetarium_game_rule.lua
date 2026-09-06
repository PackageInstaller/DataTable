-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_planetarium_game_rule.lua

module("logicconfig.config.t_origin_fight_planetarium_game_rule", package.seeall)

local title = {
	txtRule = 4,
	pageId = 2,
	rulePlanId = 1,
	picturePath = 3
}
local dataList = {
	{
		1,
		1,
		"board_gxzb_guizhe01",
		"点击【切换轨道】来改变当前选择的轨道"
	},
	{
		1,
		2,
		"board_gxzb_guizhe02",
		"点击【旋转星图】后，当前选择的轨道则会旋转，可以以最外层为基准，将每个轨道的【关键部位】对齐"
	},
	{
		1,
		3,
		"board_gxzb_guizhe03",
		"当所有部位都如图所示完成衔接，星图复原就大功告成啦！"
	}
}
local t_origin_fight_planetarium_game_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_fight_planetarium_game_rule.dataList = dataList

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

return t_origin_fight_planetarium_game_rule
