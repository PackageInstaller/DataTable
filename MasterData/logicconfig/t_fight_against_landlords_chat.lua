-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_chat.lua

module("logicconfig.config.t_fight_against_landlords_chat", package.seeall)

local title = {
	chatId = 1,
	chatScence = 2,
	value = 5,
	chatChannel = 3,
	identity = 4
}
local dataList = {
	{
		1,
		1,
		0,
		0,
		"就这…"
	},
	{
		2,
		1,
		0,
		0,
		"快点吧，等到花儿都谢了"
	},
	{
		3,
		1,
		0,
		0,
		"别怂，往死里猜"
	},
	{
		4,
		1,
		0,
		0,
		"此时不炸更待何时"
	},
	{
		5,
		1,
		0,
		0,
		"真正的菜鸟比高手难对付"
	},
	{
		6,
		1,
		0,
		0,
		"下局游戏还希望遇到你"
	},
	{
		7,
		1,
		0,
		0,
		"再见了，我会想念大家"
	},
	{
		8,
		1,
		0,
		0,
		"不要吵，专心玩游戏"
	},
	{
		9,
		1,
		0,
		0,
		"大家好，很高兴见到各位"
	},
	{
		10,
		1,
		0,
		0,
		"交个朋友吧"
	},
	{
		11,
		2,
		0,
		2,
		"上个肉！"
	},
	{
		12,
		2,
		0,
		2,
		"凑CP羁绊！"
	},
	{
		13,
		2,
		0,
		2,
		"注意阵容搭配！"
	},
	{
		14,
		2,
		0,
		2,
		"注意属性克制！"
	},
	{
		15,
		2,
		0,
		2,
		"输出不够 试试别的"
	},
	{
		16,
		2,
		1,
		1,
		"就这…"
	},
	{
		17,
		2,
		1,
		1,
		"想输想赢随你们便…"
	},
	{
		18,
		2,
		1,
		1,
		"给阿姨倒一杯卡布奇诺~"
	}
}
local t_fight_against_landlords_chat = {
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

t_fight_against_landlords_chat.dataList = dataList

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

return t_fight_against_landlords_chat
