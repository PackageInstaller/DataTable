-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_card_common.lua

module("logicconfig.config.t_saint_knight_card_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RANK_KEYS",
		"12004,12005"
	}
}
local t_saint_knight_card_common = {
	RANK_KEYS = dataList[1]
}

t_saint_knight_card_common.dataList = dataList

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

return t_saint_knight_card_common
