-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gulas_clg_activity.lua

module("logicconfig.config.t_gulas_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 3,
	effPath = 12,
	skinId = 9,
	jumpStrThree = 6,
	battleDesc = 13,
	popupDesc = 11,
	jumpStrTwo = 5,
	jumpStrOne = 4,
	bubbleItem = 10,
	redPointId = 2,
	jumpStrFive = 8,
	jumpStrFour = 7,
	activityId = 1
}
local dataList = {
	{
		437001,
		0,
		"4:420",
		"func#618#11025",
		"mibao#anxishenyao4",
		"func#1163",
		"mibao#anxishenyao4",
		"",
		11025,
		"4:420",
		"",
		"fx_ui_jinglinggezi/fx_ui_buzhen_04.prefab",
		"1、<color=#C54949>缠怨</color>：攻击敌方精灵将被眩晕1个回合。\r\n2、<color=#C54949>暗蚀之陷</color>：开战时，己方某一格变为黑洞，黑洞处必须上阵精灵。在每个大回合结束时，黑洞会根据己方被缠怨眩晕的精灵数量造成特殊效果。\r\nX=1时，给黑洞上的精灵造成10%自身最大生命值伤害。\r\nX=2时，黑洞向相邻精灵扩散并且从造成伤害-30%，无法回血，防御-25%和受伤加深30%中随机添加2个给自身及相邻精灵。\r\nX=3时，黑洞向相邻精灵扩散并且给全阵精灵造成30%自身最大生命值伤害\r\n3、<color=#C54949>不公天秤</color>：可以在布阵时达成限制来削弱暗蚀之陷，使其无法触发第三阶段的效果。"
	},
	{
		437002,
		0,
		"4:510680",
		"func#618#13027",
		"mibao#anxishenyao4",
		"ui#lottery",
		"func#545#52",
		"",
		13027,
		"4:510680",
		"",
		"fx_ui_jinglinggezi/fx_ui_buzhen_04.prefab",
		"1、<color=#C54949>蛮效果</color>：敌阵精灵每个大回合内首次受击必定格挡\r\n2、<color=#C54949>荒效果</color>：开战时，己方某一格变为黑洞，黑洞处必须上阵精灵。在每个大回合结束时，黑洞会根据己阵触发蛮效果的次数造成特殊效果。\r\nX=5时，令黑洞中的精灵在本大回合内造成伤害减少20%，受到的伤害增加20%。（第一阶段）\r\nX=4时，黑洞向相邻精灵扩散并且令自身及相邻精灵气势降为0并获得沉默（1回合）。（第二阶段）\r\nX=3时，黑洞向相邻精灵扩散并且给全阵精灵造成30%自身最大生命值伤害（第三阶段）\r\n3、<color=#C54949>蛮荒战神</color>：可以在布阵时达成限制来削弱荒效果，使其无法触发第三阶段的效果。"
	}
}
local t_gulas_clg_activity = {
	[437001] = dataList[1],
	[437002] = dataList[2]
}

t_gulas_clg_activity.dataList = dataList

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

return t_gulas_clg_activity
