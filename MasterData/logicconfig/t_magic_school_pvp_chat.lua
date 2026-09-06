-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_chat.lua

module("logicconfig.config.t_magic_school_pvp_chat", package.seeall)

local title = {
	chatId = 1,
	value = 2
}
local dataList = {
	{
		1,
		"换位！换位！"
	},
	{
		2,
		"记得调整布阵！"
	},
	{
		3,
		"下局游戏还希望遇到你"
	},
	{
		4,
		"再见了，我会想念大家"
	},
	{
		5,
		"真正的菜鸟比高手难对付"
	},
	{
		6,
		"我去一号位~"
	},
	{
		7,
		"我二号位跟上跟上"
	},
	{
		8,
		"我三号位全力输出！"
	}
}
local t_magic_school_pvp_chat = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_magic_school_pvp_chat.dataList = dataList

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

return t_magic_school_pvp_chat
