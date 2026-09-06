-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_noah_challenge_params.lua

module("logicconfig.config.t_noah_challenge_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"NEED_LEVEL",
		"100"
	},
	{
		"NUOYA_GOODS_ID",
		"527"
	}
}
local t_noah_challenge_params = {
	NEED_LEVEL = dataList[1],
	NUOYA_GOODS_ID = dataList[2]
}

t_noah_challenge_params.dataList = dataList

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

return t_noah_challenge_params
