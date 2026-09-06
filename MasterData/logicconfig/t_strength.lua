-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_strength.lua

module("logicconfig.config.t_strength", package.seeall)

local title = {
	dailyLimit = 5,
	effect = 8,
	name = 2,
	quality = 3,
	desc = 9,
	maxQuantity = 4,
	id = 1,
	icon = 6,
	showLimit = 7
}
local dataList = {
	{
		1,
		"体力",
		4,
		999999999,
		9999999,
		"icon_tili",
		0,
		"",
		"在奥奇大陆冒险时，所需消耗的身体能量。"
	}
}
local t_strength = {
	dataList[1]
}

t_strength.dataList = dataList

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

return t_strength
