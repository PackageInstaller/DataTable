-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_puzzle_jigsaw_prize.lua

module("logicconfig.config.t_puzzle_jigsaw_prize", package.seeall)

local title = {
	gainDay = 2,
	finalPrize = 3,
	planId = 1
}
local dataList = {
	{
		1,
		8,
		"104:2:300#4:106:1#8:1:99999"
	}
}
local t_puzzle_jigsaw_prize = {
	dataList[1]
}

t_puzzle_jigsaw_prize.dataList = dataList

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

return t_puzzle_jigsaw_prize
