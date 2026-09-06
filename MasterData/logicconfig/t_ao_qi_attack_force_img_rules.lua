-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_img_rules.lua

module("logicconfig.config.t_ao_qi_attack_force_img_rules", package.seeall)

local title = {
	sortId = 2,
	desc = 4,
	activityId = 1,
	imgPath = 3
}
local dataList = {
	{
		436001,
		1,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize08.png",
		"在兵刃宗师玩法中，小奥奇需要先通过进阶试炼提升装备、解锁buff\r\n建议优先解锁和提升<color=#C54949>盾牌、匕首</color>来确保生存与输出"
	},
	{
		436001,
		2,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize01.png",
		"需要<color=#C54949>手动解锁、上阵装备</color>，才可在战斗内刷出对应的装备\r\n升级装备，解锁<color=#C54949>冷却减少</color>类型的buff可获得强力提升"
	},
	{
		436001,
		3,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize02.png",
		"在合成阶段只有<color=#C54949>相同颜色、相同类型</color>的武器才能合成，每次合成可获得强力提升"
	},
	{
		436001,
		4,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize04.png",
		"在合成阶段也可以刷出背包格子，可放入背包内扩充\r\n<color=#C54949>若空间不足，格子无法放入</color>"
	},
	{
		436001,
		5,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize05.png",
		"钱袋无法养成等级，仅在合成阶段获得\r\n钱袋放入背包，可在每次战斗胜利后<color=#C54949>获得额外结算货币</color>"
	},
	{
		436001,
		6,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize06.png",
		"不同武器合成等级体现为不同的颜色，顺序如下：\r\n<color=#C54949>白<绿<蓝<紫<红</color>"
	},
	{
		436001,
		7,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize07.png",
		"在战斗阶段，小奥奇将发射当前放入背包的武器，战胜敌人\r\n特定关卡将会出现boss怪物，努力提升后击败吧！"
	},
	{
		436002,
		1,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize08.png",
		"在兵刃宗师玩法中，小奥奇需要先通过进阶试炼提升装备、解锁buff\r\n建议优先解锁和提升<color=#C54949>盾牌、匕首</color>来确保生存与输出"
	},
	{
		436002,
		2,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize01.png",
		"需要<color=#C54949>手动解锁、上阵装备</color>，才可在战斗内刷出对应的装备\r\n升级装备，解锁<color=#C54949>冷却减少</color>类型的buff可获得强力提升"
	},
	{
		436002,
		3,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize02.png",
		"在合成阶段只有<color=#C54949>相同颜色、相同类型</color>的武器才能合成，每次合成可获得强力提升"
	},
	{
		436002,
		4,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize04.png",
		"在合成阶段也可以刷出背包格子，可放入背包内扩充\r\n<color=#C54949>若空间不足，格子无法放入</color>"
	},
	{
		436002,
		5,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize05.png",
		"钱袋无法养成等级，仅在合成阶段获得\r\n钱袋放入背包，可在每次战斗胜利后<color=#C54949>获得额外结算货币</color>"
	},
	{
		436002,
		6,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize06.png",
		"不同武器合成等级体现为不同的颜色，顺序如下：\r\n<color=#C54949>白<绿<蓝<紫<红</color>"
	},
	{
		436002,
		7,
		"ui/bigbg/aoqiattackforce/board_bingrenzongshi_guize07.png",
		"在战斗阶段，小奥奇将发射当前放入背包的武器，战胜敌人\r\n特定关卡将会出现boss怪物，努力提升后击败吧！"
	}
}
local t_ao_qi_attack_force_img_rules = {
	[436001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[436002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_ao_qi_attack_force_img_rules.dataList = dataList

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

return t_ao_qi_attack_force_img_rules
