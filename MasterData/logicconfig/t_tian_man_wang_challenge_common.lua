-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_common.lua

module("logicconfig.config.t_tian_man_wang_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"18"
	},
	{
		"RANK_SIZE",
		"5999"
	},
	{
		"RANK_PRIZE",
		"14:36:1"
	},
	{
		"GOODS_ID",
		"50024"
	}
}
local t_tian_man_wang_challenge_common = {
	CHALLENGE_ID = dataList[1],
	RANK_SIZE = dataList[2],
	RANK_PRIZE = dataList[3],
	GOODS_ID = dataList[4]
}

t_tian_man_wang_challenge_common.dataList = dataList

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

return t_tian_man_wang_challenge_common
