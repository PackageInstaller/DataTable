-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_chat_time.lua

module("logicconfig.config.t_goddess_chat_time", package.seeall)

local title = {
	id = 1,
	range = 2
}
local dataList = {
	{
		1,
		{
			120,
			240
		}
	},
	{
		2,
		{
			300,
			480
		}
	},
	{
		3,
		{
			600,
			900
		}
	}
}
local t_goddess_chat_time = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_goddess_chat_time.dataList = dataList

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

return t_goddess_chat_time
