-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_rank_prize.lua

module("logicconfig.config.t_big_rank_prize", package.seeall)

local title = {
	startRank = 2,
	rankId = 1,
	prize = 4,
	endRank = 3
}
local dataList = {}
local t_big_rank_prize = {}

t_big_rank_prize.dataList = dataList

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

return t_big_rank_prize
