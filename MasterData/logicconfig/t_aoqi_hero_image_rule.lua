-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_hero_image_rule.lua

module("logicconfig.config.t_aoqi_hero_image_rule", package.seeall)

local title = {
	resName = 4,
	typeId = 1,
	id = 2,
	title = 3,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_02.png",
		"战前需先完成守阵的布置，战斗中保护我方水晶不被敌军击败，水晶的血量等于我方全部上阵精灵的血量总和，点击【编辑队伍】可以调整我方上阵精灵，替换精灵后等级继承。"
	},
	{
		1,
		2,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_01.png",
		"战斗中，需要在限定回合内击杀所有敌人，己阵每只精灵的操作时间有限，请及时完成操作，从下方拉出精灵可释放技能造成伤害且积攒怒气，怒气满时可释放超杀，怒气为己阵全部精灵共享。敌阵会先移动到攻击距离内才释放技能。"
	},
	{
		2,
		1,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_02.png",
		"战前需先完成守阵的布置，战斗中保护我方水晶不被敌军击败，水晶的血量等于我方全部上阵精灵的血量总和，点击【编辑队伍】可以调整我方上阵精灵，替换精灵后等级继承。"
	},
	{
		2,
		2,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_01.png",
		"战斗中，需要在限定回合内击杀所有敌人，己阵每只精灵的操作时间有限，请及时完成操作，从下方拉出精灵可释放技能造成伤害且积攒怒气，怒气满时可释放超杀，怒气为己阵全部精灵共享。敌阵会先移动到攻击距离内才释放技能。"
	},
	{
		3,
		1,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_04.png",
		"布阵前请先选择使用的攻阵地图，提前布置我方的攻阵精灵，战斗中，我方攻阵精灵将由系统操控进行战斗，匹配对手进入战斗后，将以己方预设的攻阵对战敌方的守阵。"
	},
	{
		3,
		2,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_02.png",
		"匹配对手后，将以我方守阵应对敌人的攻阵，战斗中保护我方水晶不被敌军击败，水晶的血量等于我方全部上阵精灵的血量总和，替换精灵后等级继承。"
	},
	{
		3,
		3,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_01.png",
		"战斗中，需要在限定回合内击杀所有敌人，己阵每只精灵的操作时间有限，请及时完成操作，从下方拉出精灵可释放技能造成伤害且积攒怒气，怒气满时可释放超杀，怒气为己阵全部精灵共享。敌阵会先移动到攻击距离内才释放技能。"
	},
	{
		3,
		4,
		"战斗规则",
		"ui/bigbg/aoqiyongshituan/board_aoqiyongshituanguize_03.png",
		"战斗结束时，根据双方水晶的剩余血量判定胜负，血量高的一方获胜，相同则为平局。"
	}
}
local t_aoqi_hero_image_rule = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_aoqi_hero_image_rule.dataList = dataList

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

return t_aoqi_hero_image_rule
