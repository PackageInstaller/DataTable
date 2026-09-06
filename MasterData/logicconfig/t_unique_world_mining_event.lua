-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_mining_event.lua

module("logicconfig.config.t_unique_world_mining_event", package.seeall)

local title = {
	prize = 3,
	eventId = 1,
	randomCoinCount = 2
}
local dataList = {
	{
		2001,
		{
			30,
			50
		},
		""
	},
	{
		2002,
		{
			60,
			90
		},
		""
	},
	{
		2003,
		{
			150,
			200
		},
		""
	}
}
local t_unique_world_mining_event = {
	[2001] = dataList[1],
	[2002] = dataList[2],
	[2003] = dataList[3]
}

t_unique_world_mining_event.dataList = dataList

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

return t_unique_world_mining_event
