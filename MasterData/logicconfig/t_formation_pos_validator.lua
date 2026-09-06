-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_pos_validator.lua

module("logicconfig.config.t_formation_pos_validator", package.seeall)

local title = {
	ban = 2,
	id = 1,
	validator = 4,
	allow = 3,
	desc = 5
}
local dataList = {
	{
		1,
		true,
		true,
		"",
		"该位置于此关卡被禁用"
	},
	{
		2,
		false,
		true,
		"RaceType$火",
		"该位置必须上阵火属性的精灵"
	},
	{
		3,
		false,
		true,
		"Job$英雄",
		"该位置必须上阵英雄职业的精灵"
	},
	{
		4,
		false,
		true,
		"Race$10032",
		"该位置必须上阵精灵当当"
	},
	{
		5,
		false,
		false,
		"RaceType$火",
		"该位置不允许上阵火属性的精灵"
	},
	{
		6,
		false,
		false,
		"Job$利爪|Job$英雄",
		"该位置不允许上阵利爪及英雄职业的精灵"
	},
	{
		7,
		false,
		true,
		"Job$利爪|Job$英雄",
		"该位置必须上阵英雄或利爪职业的精灵"
	},
	{
		8,
		false,
		true,
		"Job$利爪&RaceType$火",
		"该位置必须上阵火属性且为利爪职业的精灵"
	},
	{
		9,
		false,
		true,
		"Job$英雄|RaceType$火",
		"该位置须上阵英或火属性精灵"
	},
	{
		10,
		false,
		true,
		"Race$10032|Job$英雄",
		"该位置必须上阵当当或任意英雄"
	},
	{
		11,
		false,
		true,
		"",
		"该位置必须有精灵上阵"
	},
	{
		12,
		false,
		true,
		"RaceType$水",
		"该位置必须上阵水属性的精灵"
	},
	{
		13,
		false,
		true,
		"RaceType$草",
		"该位置必须上阵草属性的精灵"
	},
	{
		14,
		false,
		true,
		"RaceType$光",
		"该位置必须上阵光属性的精灵"
	},
	{
		15,
		false,
		true,
		"RaceType$暗",
		"该位置必须上阵暗属性的精灵"
	},
	{
		16,
		false,
		true,
		"RaceType$水|RaceType$光",
		"只能上阵水属性或光属性的精灵"
	},
	{
		17,
		false,
		true,
		"RaceType$水|RaceType$火|RaceType$草|RaceType$光|RaceType$暗|RaceType$空|RaceType$创",
		"该位置必须上阵一只任意属性的精灵"
	},
	{
		18,
		false,
		true,
		"Race$15014",
		"该位置必须上阵精灵轮回之神·正理"
	}
}
local t_formation_pos_validator = {
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

t_formation_pos_validator.dataList = dataList

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

return t_formation_pos_validator
