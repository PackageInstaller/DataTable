-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_correct_principle_challenge_common.lua

module("logicconfig.config.t_correct_principle_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CUR_CHALLENGE_ID",
		"62"
	},
	{
		"JUMP_RANK",
		"func#618#15014"
	},
	{
		"JUMP_LOTTERY",
		"ui#publicdragontabview#3"
	},
	{
		"JUMP_SHOP",
		"mibao#xinchun2"
	}
}
local t_correct_principle_challenge_common = {
	CUR_CHALLENGE_ID = dataList[1],
	JUMP_RANK = dataList[2],
	JUMP_LOTTERY = dataList[3],
	JUMP_SHOP = dataList[4]
}

t_correct_principle_challenge_common.dataList = dataList

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

return t_correct_principle_challenge_common
