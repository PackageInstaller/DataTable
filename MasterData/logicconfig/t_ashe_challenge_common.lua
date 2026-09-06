-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashe_challenge_common.lua

module("logicconfig.config.t_ashe_challenge_common", package.seeall)

local title = {
	parameter = 1,
	value = 2
}
local dataList = {
	{
		"SELECT_BUFF_TYPE_1_NUM",
		"3"
	},
	{
		"SELECT_BUFF_TYPE_2_NUM",
		"3"
	},
	{
		"REFRESH_ENEMY_COST",
		"105:6054:50"
	}
}
local t_ashe_challenge_common = {
	SELECT_BUFF_TYPE_1_NUM = dataList[1],
	SELECT_BUFF_TYPE_2_NUM = dataList[2],
	REFRESH_ENEMY_COST = dataList[3]
}

t_ashe_challenge_common.dataList = dataList

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

return t_ashe_challenge_common
