-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_common.lua

module("logicconfig.config.t_survival_king_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_MEMBER",
		"16"
	},
	{
		"MIN_MEMBER",
		"8"
	},
	{
		"SIGN_UP_PROTECT_TIME",
		"10"
	}
}
local t_survival_king_common = {
	MAX_MEMBER = dataList[1],
	MIN_MEMBER = dataList[2],
	SIGN_UP_PROTECT_TIME = dataList[3]
}

t_survival_king_common.dataList = dataList

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

return t_survival_king_common
