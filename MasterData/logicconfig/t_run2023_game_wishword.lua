-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run2023_game_wishword.lua

module("logicconfig.config.t_run2023_game_wishword", package.seeall)

local title = {
	Id = 2,
	planId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"升值加薪"
	},
	{
		1,
		2,
		"身体健康"
	},
	{
		1,
		3,
		"万事如意"
	},
	{
		1,
		4,
		"抽卡欧皇"
	}
}
local t_run2023_game_wishword = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_run2023_game_wishword.dataList = dataList

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

return t_run2023_game_wishword
