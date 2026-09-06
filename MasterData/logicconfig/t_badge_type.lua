-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_badge_type.lua

module("logicconfig.config.t_badge_type", package.seeall)

local title = {
	typeName = 3,
	badgeType = 1,
	sortParam = 2,
	badgeList = 4
}
local dataList = {
	{
		1,
		1,
		"荣誉徽章",
		{
			1009,
			1010,
			1011,
			1012
		}
	},
	{
		2,
		2,
		"奥奇徽章",
		{
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008
		}
	},
	{
		3,
		3,
		"九宫八阵",
		{
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			48
		}
	},
	{
		4,
		4,
		"精灵挑战",
		{
			29,
			30,
			31,
			32,
			33,
			49,
			34,
			35,
			24,
			25,
			26,
			27,
			28,
			19,
			20,
			21,
			22,
			23,
			36,
			37,
			38,
			39,
			10,
			9,
			11,
			12,
			13,
			15,
			14,
			16,
			17,
			18,
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			51,
			52,
			53,
			54,
			56,
			59,
			55,
			57,
			58,
			61,
			60
		}
	}
}
local t_badge_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_badge_type.dataList = dataList

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

return t_badge_type
