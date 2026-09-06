-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_wishes_collect_prize.lua

module("logicconfig.config.t_birthday_wishes_collect_prize", package.seeall)

local title = {
	prizeId = 2,
	needTokens = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		223008,
		1,
		{
			33,
			34,
			35,
			36
		},
		"4:12102:10"
	},
	{
		223008,
		2,
		{
			37,
			38,
			39,
			40
		},
		"4:11002:30000"
	},
	{
		223008,
		3,
		{
			41,
			42,
			43,
			44
		},
		"4:400002:100"
	},
	{
		223008,
		4,
		{
			45,
			46,
			47,
			48
		},
		"4:510022:5"
	},
	{
		223008,
		5,
		{
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40,
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			48
		},
		"4:30006:100"
	}
}
local t_birthday_wishes_collect_prize = {
	[223008] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_birthday_wishes_collect_prize.dataList = dataList

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

return t_birthday_wishes_collect_prize
