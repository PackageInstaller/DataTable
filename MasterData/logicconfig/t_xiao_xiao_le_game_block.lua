-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_xiao_le_game_block.lua

module("logicconfig.config.t_xiao_xiao_le_game_block", package.seeall)

local title = {
	id = 1,
	idx = 2,
	extScore = 3
}
local dataList = {
	{
		1,
		0,
		0
	},
	{
		2,
		1,
		10
	},
	{
		3,
		2,
		20
	},
	{
		4,
		3,
		50
	}
}
local t_xiao_xiao_le_game_block = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_xiao_xiao_le_game_block.dataList = dataList

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

return t_xiao_xiao_le_game_block
