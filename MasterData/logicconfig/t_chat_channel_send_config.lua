-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chat_channel_send_config.lua

module("logicconfig.config.t_chat_channel_send_config", package.seeall)

local title = {
	supportVoice = 2,
	sendDecMaterial = 3,
	id = 1,
	sendCd = 4
}
local dataList = {
	{
		1,
		true,
		"4:23:1",
		2000
	},
	{
		2,
		false,
		"4:23:1",
		0
	},
	{
		3,
		true,
		"",
		1000
	},
	{
		6,
		false,
		"4:22:1",
		2000
	},
	{
		8,
		false,
		"4:22:1",
		0
	},
	{
		9,
		false,
		"",
		5000
	},
	{
		10,
		false,
		"",
		5000
	},
	{
		12,
		false,
		"",
		5000
	},
	{
		13,
		false,
		"",
		5000
	},
	{
		14,
		false,
		"",
		5000
	},
	{
		15,
		false,
		"",
		5000
	},
	{
		16,
		false,
		"",
		5000
	}
}
local t_chat_channel_send_config = {
	dataList[1],
	dataList[2],
	dataList[3],
	[6] = dataList[4],
	[8] = dataList[5],
	[9] = dataList[6],
	[10] = dataList[7],
	[12] = dataList[8],
	[13] = dataList[9],
	[14] = dataList[10],
	[15] = dataList[11],
	[16] = dataList[12]
}

t_chat_channel_send_config.dataList = dataList

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

return t_chat_channel_send_config
