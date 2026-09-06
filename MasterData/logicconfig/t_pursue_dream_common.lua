-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pursue_dream_common.lua

module("logicconfig.config.t_pursue_dream_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PET_RANK_PRIZE",
		"14:15:1"
	},
	{
		"MAT_TICKET",
		"10:39011:1"
	}
}
local t_pursue_dream_common = {
	PET_RANK_PRIZE = dataList[1],
	MAT_TICKET = dataList[2]
}

t_pursue_dream_common.dataList = dataList

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

return t_pursue_dream_common
