-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tarot_lottery_big_prize.lua

module("logicconfig.config.t_tarot_lottery_big_prize", package.seeall)

local title = {
	prize = 3,
	item = 4,
	activityId = 1,
	tarotId = 2
}
local dataList = {
	{
		345001,
		1,
		"",
		"1004:1351:1"
	},
	{
		345001,
		2,
		"",
		"1004:1352:1"
	},
	{
		345001,
		3,
		"",
		"1004:1353:1"
	},
	{
		345001,
		4,
		"",
		"1004:1354:1"
	},
	{
		345001,
		5,
		"",
		"1004:1355:1"
	},
	{
		345001,
		6,
		"",
		"1004:1356:1"
	},
	{
		345001,
		7,
		"",
		"1004:1357:1"
	},
	{
		345001,
		8,
		"",
		"1004:1358:1"
	},
	{
		345001,
		9,
		"",
		"1004:1359:1"
	},
	{
		345001,
		10,
		"",
		"1004:1360:1"
	},
	{
		345001,
		11,
		"",
		"1004:1361:1"
	},
	{
		345001,
		12,
		"",
		"1004:1362:1"
	}
}
local t_tarot_lottery_big_prize = {
	[345001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_tarot_lottery_big_prize.dataList = dataList

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

return t_tarot_lottery_big_prize
