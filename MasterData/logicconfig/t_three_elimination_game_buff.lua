-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_elimination_game_buff.lua

module("logicconfig.config.t_three_elimination_game_buff", package.seeall)

local title = {
	unlockCost = 3,
	name = 6,
	buffId = 2,
	activityId = 1,
	clientEffect = 5,
	buffResName = 8,
	serverEffect = 4,
	desc = 7
}
local dataList = {
	{
		339001,
		1,
		"10:339001:5000",
		"PET_INC_ZDL$1,10",
		"",
		"战力提升-希望",
		"希望提升10万战斗力",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		339001,
		2,
		"10:339001:5000",
		"PET_INC_ZDL$2,10",
		"",
		"战力提升-正义",
		"正义提升10万战斗力",
		"ui/icon/expevents/icon_expedition_chaoshatisheng.png"
	},
	{
		339001,
		3,
		"10:339001:5000",
		"PET_INC_ZDL$3,10",
		"",
		"战力提升-正理",
		"正理提升10万战斗力",
		"ui/icon/expevents/icon_expedition_xieli01.png"
	},
	{
		339001,
		4,
		"10:339001:25000",
		"HANG_UP_INC_RATE$2",
		"",
		"挂机提升",
		"挂机收益提升2倍",
		"ui/icon/items/icon_expedition_shanbilv_2.png"
	},
	{
		339001,
		5,
		"10:339001:50000",
		"",
		"USE_ADD_SUPPLY$1",
		"概率提升",
		"掉落紫、橙色卡牌的概率提升",
		"ui/icon/expevents/icon_expedition_yuanjun.png"
	},
	{
		339002,
		1,
		"10:339004:5000",
		"PET_INC_ZDL$1,10",
		"",
		"战力提升-无问",
		"无问提升10万战斗力",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		339002,
		2,
		"10:339004:5000",
		"PET_INC_ZDL$2,10",
		"",
		"战力提升-余灰",
		"余灰提升10万战斗力",
		"ui/icon/expevents/icon_expedition_chaoshatisheng.png"
	},
	{
		339002,
		3,
		"10:339004:5000",
		"PET_INC_ZDL$3,10",
		"",
		"战力提升-法纳斯",
		"法纳斯提升10万战斗力",
		"ui/icon/expevents/icon_expedition_xieli01.png"
	},
	{
		339002,
		4,
		"10:339004:25000",
		"HANG_UP_INC_RATE$2",
		"",
		"挂机提升",
		"挂机收益提升2倍",
		"ui/icon/items/icon_expedition_shanbilv_2.png"
	},
	{
		339002,
		5,
		"10:339004:50000",
		"",
		"USE_ADD_SUPPLY$1",
		"概率提升",
		"掉落紫、橙色卡牌的概率提升",
		"ui/icon/expevents/icon_expedition_yuanjun.png"
	},
	{
		339003,
		1,
		"10:339006:5000",
		"PET_INC_ZDL$1,10",
		"",
		"战力提升-神曜殛主·安",
		"神曜殛主·安提升10万战斗力",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		339003,
		2,
		"10:339006:5000",
		"PET_INC_ZDL$2,10",
		"",
		"战力提升-神曜时空·龙尊",
		"神曜时空·龙尊提升10万战斗力",
		"ui/icon/expevents/icon_expedition_chaoshatisheng.png"
	},
	{
		339003,
		3,
		"10:339006:5000",
		"PET_INC_ZDL$3,10",
		"",
		"战力提升-神曜花语·伊丽莎白",
		"神曜花语·伊丽莎白提升10万战斗力",
		"ui/icon/expevents/icon_expedition_xieli01.png"
	},
	{
		339003,
		4,
		"10:339006:25000",
		"HANG_UP_INC_RATE$2",
		"",
		"挂机提升",
		"挂机收益提升2倍",
		"ui/icon/items/icon_expedition_shanbilv_2.png"
	},
	{
		339003,
		5,
		"10:339006:50000",
		"",
		"USE_ADD_SUPPLY$1",
		"概率提升",
		"掉落紫、橙色卡牌的概率提升",
		"ui/icon/expevents/icon_expedition_yuanjun.png"
	},
	{
		339004,
		1,
		"10:339008:5000",
		"PET_INC_ZDL$1,10",
		"",
		"战力提升-星律辉冠·星绛",
		"星律辉冠·星绛提升10万战斗力",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		339004,
		2,
		"10:339008:5000",
		"PET_INC_ZDL$2,10",
		"",
		"战力提升-桃心娇兔·秩序神女",
		"桃心娇兔·秩序神女提升10万战斗力",
		"ui/icon/expevents/icon_expedition_chaoshatisheng.png"
	},
	{
		339004,
		3,
		"10:339008:5000",
		"PET_INC_ZDL$3,10",
		"",
		"战力提升-微醺兔调·秩序",
		"微醺兔调·秩序提升10万战斗力",
		"ui/icon/expevents/icon_expedition_xieli01.png"
	},
	{
		339004,
		4,
		"10:339008:25000",
		"HANG_UP_INC_RATE$2",
		"",
		"挂机提升",
		"挂机收益提升2倍",
		"ui/icon/items/icon_expedition_shanbilv_2.png"
	},
	{
		339004,
		5,
		"10:339008:50000",
		"",
		"USE_ADD_SUPPLY$1",
		"概率提升",
		"掉落紫、橙色卡牌的概率提升",
		"ui/icon/expevents/icon_expedition_yuanjun.png"
	}
}
local t_three_elimination_game_buff = {
	[339001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[339002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[339003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[339004] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_three_elimination_game_buff.dataList = dataList

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

return t_three_elimination_game_buff
