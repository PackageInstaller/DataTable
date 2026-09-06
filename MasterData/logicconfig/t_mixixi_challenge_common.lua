-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mixixi_challenge_common.lua

module("logicconfig.config.t_mixixi_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"35"
	},
	{
		"JUMP_FUNC_ID",
		"467"
	},
	{
		"SHOW_ITEM",
		"13:81:1"
	}
}
local t_mixixi_challenge_common = {
	CHALLENGE_ID = dataList[1],
	JUMP_FUNC_ID = dataList[2],
	SHOW_ITEM = dataList[3]
}

t_mixixi_challenge_common.dataList = dataList

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

return t_mixixi_challenge_common
