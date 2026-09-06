-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_fighting_chess_skill.lua

module("logicconfig.config.t_beast_fighting_chess_skill", package.seeall)

local title = {
	param = 6,
	name = 3,
	unlock = 5,
	skillId = 2,
	iconPath = 7,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		412001,
		1,
		"格挡",
		"己方棋子增加【格挡】标签，己方棋子下次被吃时发动，己方棋子免疫1次被吃，所有棋子共享1次生效",
		0,
		"",
		"ui/icon/expevents/icon_expedition_chushouqianjianshang"
	},
	{
		412001,
		2,
		"先知",
		"立即可以查看场上3个未知棋子，棋子增加【先知】标签，查看到的棋子仍需要手动翻开",
		3,
		"3",
		"ui/icon/expevents/icon_expedition_numu01"
	},
	{
		412001,
		3,
		"隐身",
		"随机选择己方1枚未翻开棋子增加【隐身】标签，该棋子在对手视野始终不可见",
		6,
		"",
		"ui/icon/expevents/icon_expedition_kaichangqishi"
	},
	{
		412001,
		4,
		"连击",
		"选择1枚棋子增加【连击】标签，该棋子在本回合可连续行动2次",
		9,
		"",
		"ui/icon/expevents/icon_expedition_meilunkouxue"
	},
	{
		412001,
		5,
		"反击",
		"己方棋子增加【反击】标签，己方棋子下次被吃时发动，吃掉该棋子的敌方棋子被禁止行动1回合，所有棋子共享1次生效",
		12,
		"1",
		"ui/icon/expevents/icon_expedition_dikang_quan"
	},
	{
		412001,
		6,
		"转火",
		"选择2枚棋子，使2个棋子的位置马上交换",
		15,
		"",
		"ui/icon/expevents/icon_expedition_zhenying_01"
	},
	{
		412002,
		1,
		"格挡",
		"己方棋子增加【格挡】标签，己方棋子下次被吃时发动，己方棋子免疫1次被吃，所有棋子共享1次生效",
		0,
		"",
		"ui/icon/expevents/icon_expedition_chushouqianjianshang"
	},
	{
		412002,
		2,
		"先知",
		"立即可以查看场上3个未知棋子，棋子增加【先知】标签，查看到的棋子仍需要手动翻开",
		3,
		"3",
		"ui/icon/expevents/icon_expedition_numu01"
	},
	{
		412002,
		3,
		"隐身",
		"随机选择己方1枚未翻开棋子增加【隐身】标签，该棋子在对手视野始终不可见",
		3,
		"",
		"ui/icon/expevents/icon_expedition_kaichangqishi"
	},
	{
		412002,
		4,
		"连击",
		"选择1枚棋子增加【连击】标签，该棋子在本回合可连续行动2次",
		3,
		"",
		"ui/icon/expevents/icon_expedition_meilunkouxue"
	},
	{
		412002,
		5,
		"反击",
		"己方棋子增加【反击】标签，己方棋子下次被吃时发动，吃掉该棋子的敌方棋子被禁止行动1回合，所有棋子共享1次生效",
		3,
		"1",
		"ui/icon/expevents/icon_expedition_dikang_quan"
	},
	{
		412002,
		6,
		"转火",
		"选择2枚棋子，使2个棋子的位置马上交换",
		3,
		"",
		"ui/icon/expevents/icon_expedition_zhenying_01"
	},
	{
		412003,
		1,
		"格挡",
		"己方棋子增加【格挡】标签，己方棋子下次被吃时发动，己方棋子免疫1次被吃，所有棋子共享1次生效",
		0,
		"",
		"ui/icon/expevents/icon_expedition_chushouqianjianshang"
	},
	{
		412003,
		2,
		"先知",
		"立即可以查看场上3个未知棋子，棋子增加【先知】标签，查看到的棋子仍需要手动翻开",
		3,
		"3",
		"ui/icon/expevents/icon_expedition_numu01"
	},
	{
		412003,
		3,
		"隐身",
		"随机选择己方1枚未翻开棋子增加【隐身】标签，该棋子在对手视野始终不可见",
		3,
		"",
		"ui/icon/expevents/icon_expedition_kaichangqishi"
	},
	{
		412003,
		4,
		"连击",
		"选择1枚棋子增加【连击】标签，该棋子在本回合可连续行动2次",
		3,
		"",
		"ui/icon/expevents/icon_expedition_meilunkouxue"
	},
	{
		412003,
		5,
		"反击",
		"己方棋子增加【反击】标签，己方棋子下次被吃时发动，吃掉该棋子的敌方棋子被禁止行动1回合，所有棋子共享1次生效",
		3,
		"1",
		"ui/icon/expevents/icon_expedition_dikang_quan"
	},
	{
		412003,
		6,
		"转火",
		"选择2枚棋子，使2个棋子的位置马上交换",
		3,
		"",
		"ui/icon/expevents/icon_expedition_zhenying_01"
	},
	{
		412004,
		1,
		"格挡",
		"己方棋子增加【格挡】标签，己方棋子下次被吃时发动，己方棋子免疫1次被吃，所有棋子共享1次生效",
		0,
		"",
		"ui/icon/expevents/icon_expedition_chushouqianjianshang"
	},
	{
		412004,
		2,
		"先知",
		"立即可以查看场上3个未知棋子，棋子增加【先知】标签，查看到的棋子仍需要手动翻开",
		3,
		"3",
		"ui/icon/expevents/icon_expedition_numu01"
	},
	{
		412004,
		3,
		"隐身",
		"随机选择己方1枚未翻开棋子增加【隐身】标签，该棋子在对手视野始终不可见",
		3,
		"",
		"ui/icon/expevents/icon_expedition_kaichangqishi"
	},
	{
		412004,
		4,
		"连击",
		"选择1枚棋子增加【连击】标签，该棋子在本回合可连续行动2次",
		3,
		"",
		"ui/icon/expevents/icon_expedition_meilunkouxue"
	},
	{
		412004,
		5,
		"反击",
		"己方棋子增加【反击】标签，己方棋子下次被吃时发动，吃掉该棋子的敌方棋子被禁止行动1回合，所有棋子共享1次生效",
		3,
		"1",
		"ui/icon/expevents/icon_expedition_dikang_quan"
	},
	{
		412004,
		6,
		"转火",
		"选择2枚棋子，使2个棋子的位置马上交换",
		3,
		"",
		"ui/icon/expevents/icon_expedition_zhenying_01"
	}
}
local t_beast_fighting_chess_skill = {
	[412001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[412002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[412003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[412004] = {
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_beast_fighting_chess_skill.dataList = dataList

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

return t_beast_fighting_chess_skill
