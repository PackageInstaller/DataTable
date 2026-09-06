-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_cube_channel.lua

module("logicconfig.config.t_family_cube_channel", package.seeall)

local title = {
	maxCount = 3,
	channelId = 1,
	name = 2
}
local dataList = {
	{
		1,
		"房间一",
		15
	},
	{
		2,
		"房间二",
		15
	},
	{
		3,
		"房间三",
		15
	},
	{
		4,
		"房间四",
		15
	}
}
local t_family_cube_channel = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_family_cube_channel.dataList = dataList

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

return t_family_cube_channel
