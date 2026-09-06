-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_cast_challenge_params.lua

module("logicconfig.config.t_big_cast_challenge_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CANDIDATE_RANK",
		"5"
	},
	{
		"ZDL_THRESHOLD",
		"700000"
	}
}
local t_big_cast_challenge_params = {
	CANDIDATE_RANK = dataList[1],
	ZDL_THRESHOLD = dataList[2]
}

t_big_cast_challenge_params.dataList = dataList

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

return t_big_cast_challenge_params
