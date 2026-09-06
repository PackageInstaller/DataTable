-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_doppelganger_clg.lua

module("logicconfig.config.t_dragon_king_doppelganger_clg", package.seeall)

local title = {
	guardCount = 3,
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		315001,
		525,
		2
	}
}
local t_dragon_king_doppelganger_clg = {
	[315001] = dataList[1]
}

t_dragon_king_doppelganger_clg.dataList = dataList

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

return t_dragon_king_doppelganger_clg
