-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_game.lua

module("logicconfig.config.t_maintain_power_pillar_game", package.seeall)

local title = {
	gameType = 3,
	eventId = 1,
	prize = 2,
	gameParams = 4
}
local dataList = {
	{
		7101,
		"104:2:250",
		1,
		"171002#1"
	},
	{
		7102,
		"104:2:250",
		1,
		"171002#2"
	},
	{
		7103,
		"104:2:250",
		1,
		"171002#3"
	},
	{
		7104,
		"104:2:250",
		1,
		"171002#4"
	}
}
local t_maintain_power_pillar_game = {
	[7101] = dataList[1],
	[7102] = dataList[2],
	[7103] = dataList[3],
	[7104] = dataList[4]
}

t_maintain_power_pillar_game.dataList = dataList

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

return t_maintain_power_pillar_game
