-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_chat_prize.lua

module("logicconfig.config.t_goddess_chat_prize", package.seeall)

local title = {
	feeling = 4,
	score = 3,
	prize = 5,
	id = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		5,
		20,
		"8:1:1000"
	},
	{
		1,
		2,
		10,
		25,
		"8:1:1000"
	},
	{
		1,
		3,
		15,
		30,
		"8:1:1000"
	}
}
local t_goddess_chat_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_goddess_chat_prize.dataList = dataList

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

return t_goddess_chat_prize
