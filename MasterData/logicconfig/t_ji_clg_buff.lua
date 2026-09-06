-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_buff.lua

module("logicconfig.config.t_ji_clg_buff", package.seeall)

local title = {
	descBossBuff = 2,
	bgBuff = 6,
	buffId = 1,
	titleColor = 4,
	iconBuff = 5,
	descBuff = 3
}
local dataList = {
	{
		1,
		"奇迹诺亚全属性+300%\r\n5个大回合后结束战斗",
		"诺亚破执#获得诺亚助战\r\n5个大回合后结束战斗",
		"#FFBD54-#FFFFFF",
		"board_icon_01",
		"board_lis_05"
	},
	{
		2,
		"奇迹帝释天全属性+300%\r\n己阵攻击附带自身攻击力*200%的伤害",
		"帝释天破执#获得帝释天助战\r\n己阵攻击附带攻击力200%的伤害",
		"#72A2FF-#FFFFFF",
		"board_icon_05",
		"board_lis_09"
	},
	{
		3,
		"奇迹阿瑞斯全属性+300%\r\nBOSS每次受击极限伤害变为100万",
		"阿瑞斯破执#获得阿瑞斯助战\r\nBOSS每次受击极限伤害变为100万",
		"#9FE462-#FFFFFF",
		"board_icon_04",
		"board_lis_07"
	},
	{
		4,
		"奇迹修尔全属性+300%\r\n己阵每个大回合开始时获得100点气势",
		"修尔破执#获得修尔助战\r\n己阵每个大回合开始时获得100点气势",
		"#C48FFF-#FFFFFF",
		"board_icon_03",
		"board_lis_08"
	},
	{
		5,
		"奇迹龙炎全属性+300%\r\n己阵精灵全属性+100%",
		"龙炎破执#获得龙炎助战\r\n己阵精灵全属性+100%",
		"#FF7272-#FFFFFF",
		"board_icon_02",
		"board_lis_06"
	}
}
local t_ji_clg_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_ji_clg_buff.dataList = dataList

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

return t_ji_clg_buff
