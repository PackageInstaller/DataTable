-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/ChatData.lua

local chatData = {
	{
		WORLD = {
			messages = {
				{
					time = 1500287130,
					messageType = 2,
					id = 1,
					sender = "100021_2",
					content = "<font face='asset/font/MFLiHei.ttf' size='18' color='#ffffff'>你是谁？</font>",
					channelIds = {
						"WORLD"
					},
					params = {}
				},
				{
					time = 1500287131,
					messageType = 2,
					id = 2,
					sender = "100021_1",
					content = "<font face='asset/font/MFLiHei.ttf' size='18' color='#ffff00'>我是你哥！我是你哥！我是你哥！我是你哥！我是你哥！</font>",
					channelIds = {
						"WORLD"
					},
					params = {}
				},
				{
					id = 3,
					configId = "system1",
					messageType = 1,
					time = 1500287133
				},
				{
					time = 1500287131,
					messageType = 2,
					id = 4,
					sender = "100021_1",
					content = "<font face='asset/font/MFLiHei.ttf' size='18' color='#ffff00'>我是你哥！我是你哥！我是你哥！我是你哥！我是你哥！</font>",
					channelIds = {
						"WORLD"
					},
					params = {}
				},
				{
					id = 5,
					configId = "system1",
					messageType = 1,
					time = 1500287133
				},
				{
					time = 1500287131,
					messageType = 2,
					id = 6,
					sender = "100021_1",
					content = "<font face='asset/font/MFLiHei.ttf' size='18' color='#ffff00'>我是你哥！我是你哥！我是你哥！我是你哥！我是你哥！</font>",
					channelIds = {
						"WORLD"
					},
					params = {}
				},
				{
					id = 7,
					configId = "system1",
					messageType = 1,
					time = 1500287133
				}
			}
		}
	}
}
local activeMembersData = {
	["100021_1"] = {
		vipLevel = 7,
		name = "凯",
		rid = "100021_1",
		level = 20
	},
	["100021_2"] = {
		vipLevel = 7,
		name = "露娜",
		rid = "100021_2",
		level = 20
	}
}

ChatTest = {}

function ChatTest:getChatData()
	return chatData
end

function ChatTest:getActiveMembers()
	return activeMembersData
end
