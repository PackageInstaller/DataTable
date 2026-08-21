-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_manual_info.lua

module("logic.config.t_manual_info", package.seeall)

local title = {
	code = 1,
	name = 2,
	describe = 6,
	skills = 5,
	monstercode = 4,
	icon = 3
}
local dataList = {
	{
		1,
		"厄运预告",
		"gzxd_manual_0001",
		17100101,
		{
			1217101,
			1217103,
			1217102
		},
		"厄运预告每回合开始时会对场上随机目标进行预告#预告在回合开始时仅预告部分内#在玩家阶段结束时会预告完整内容#预告的效果完全随机#厄运预告每回合开始时会随机召唤数个精英怪物#击败这些精英怪物即可获得战斗胜利"
	},
	{
		2,
		"见不得光的雕像",
		"gzxd_manual_0003",
		17102101,
		{
			1217121,
			1217122,
			1217124
		},
		"雕像将在黑暗中移动，寻找战场中的仪式柱，进行邪恶召唤#当战场中3根仪式柱被点亮时，召唤完成，玩家战斗失败#通过攻击场景中的探照灯，可以照亮地板，形成【弱光】#雕像在弱光环境下受到正常伤害，且移动力下降#地板被重复照亮时，地板将形成【强光】#雕像位于【强光】格子时，直接死亡"
	},
	{
		3,
		"容易害羞的钢琴",
		"gzxd_manual_0002",
		17104101,
		{
			1217141,
			1217142
		},
		"每回合开始时，钢琴会播放一节优美旋律#根据旋律的音符，全地图会随机生成地形效果#每种音符对应一种效果，该效果将在敌方阶段触发#效果跟根据音符的顺序和数量依次触发#同音符会重复触发#Do：使钢琴获得1层【锋刃】#Re：使自身移动力-1#Mi：使自身获得1层【高昂】#Fa：扣除自身10%血量，钢琴扣除等量血量#So：使自身位移到3格范围随机空格#La：治疗自身和钢琴10%血量#Si：使钢琴获得1层【瓦解】和【破甲】"
	}
}
local t_manual_info = {}

t_manual_info.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_manual_info[v[1]] = v

	setmetatable(v, mt)
end

return t_manual_info
