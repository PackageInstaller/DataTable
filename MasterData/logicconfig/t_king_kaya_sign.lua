-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_kaya_sign.lua

module("logicconfig.config.t_king_kaya_sign", package.seeall)

local title = {
	positionBuff = 4,
	iconPath = 5,
	signId = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		371001,
		1,
		"圣盾",
		"20055601:99",
		"ui/bigbg/kingkaya/board_kaya_03"
	},
	{
		371001,
		2,
		"曙光",
		"20055604:99",
		"ui/bigbg/kingkaya/board_kaya_04"
	},
	{
		371002,
		1,
		"圣盾",
		"20055601:99",
		"ui/bigbg/kingkaya/board_kaya_03"
	},
	{
		371002,
		2,
		"曙光",
		"20055604:99",
		"ui/bigbg/kingkaya/board_kaya_04"
	}
}
local t_king_kaya_sign = {
	[371001] = {
		dataList[1],
		dataList[2]
	},
	[371002] = {
		dataList[3],
		dataList[4]
	}
}

t_king_kaya_sign.dataList = dataList

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

return t_king_kaya_sign
