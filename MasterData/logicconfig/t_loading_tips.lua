-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_loading_tips.lua

module("logicconfig.config.t_loading_tips", package.seeall)

local title = {
	id = 1,
	funcId = 4,
	weight = 3,
	des = 2
}
local dataList = {
	{
		1,
		"奥奇城的浮空船可以自由前往各个大陆，快乘坐浮空船去寻找珍稀精灵吧。",
		10,
		0
	},
	{
		2,
		"运用属性克制的技巧去布阵，能够更轻松地战胜敌人。",
		10,
		0
	},
	{
		3,
		"英雄职业的精灵，上阵触发英雄技后，可大幅度提升全阵战斗力！",
		10,
		9
	},
	{
		4,
		"让精灵食用经验果，可以快速提升精灵等级，进而提升战斗力。",
		10,
		9
	},
	{
		5,
		"精灵攻击或被攻击都会增加50点气势，达150点后，下次出手自动释放超杀。",
		10,
		9
	},
	{
		6,
		"肉盾职业的精灵最好放置在前排，能够抵挡大量伤害。",
		10,
		9
	},
	{
		7,
		"每只精灵都可升级天赋，获得技能提升，并开启更高的等级上限。",
		10,
		9
	},
	{
		8,
		"时间之轮可重置大于1级的任意品质精灵，返还所有的天赋和等级养成材料。",
		10,
		9
	},
	{
		9,
		"使用“力量之核”，可以瞬间获得“战力排名第五的精灵“的相同等级和天赋。",
		10,
		9
	},
	{
		10,
		"只要通过传说挑战的特定关卡，即可获得该只传说精灵。",
		10,
		9
	}
}
local t_loading_tips = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_loading_tips.dataList = dataList

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

return t_loading_tips
