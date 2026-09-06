-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_number_game_chat.lua

module("logicconfig.config.t_number_game_chat", package.seeall)

local title = {
	content = 2,
	chatMsgId = 1
}
local dataList = {
	{
		1,
		"就这…？"
	},
	{
		2,
		"快点吧，等到花儿都谢了"
	},
	{
		3,
		"别怂，往死里猜"
	},
	{
		4,
		"此时不炸更待何时"
	},
	{
		5,
		"真正的菜鸟比真正的高手难对付"
	},
	{
		6,
		"下局游戏还希望遇到你"
	},
	{
		7,
		"再见了，我会想念大家"
	},
	{
		8,
		"不要吵，专心玩游戏"
	},
	{
		9,
		"大家好，很高兴见到各位"
	},
	{
		10,
		"交个朋友吧"
	}
}
local t_number_game_chat = {
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

t_number_game_chat.dataList = dataList

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

return t_number_game_chat
