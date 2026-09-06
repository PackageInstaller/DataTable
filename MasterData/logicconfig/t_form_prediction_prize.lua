-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_prediction_prize.lua

module("logicconfig.config.t_form_prediction_prize", package.seeall)

local title = {
	prizeId = 2,
	needScore = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		10,
		"4:510022:1#4:30006:20#4:90316:1#4:12102:5#4:11002:10000#4:31:5#8:1:1000000"
	},
	{
		1,
		2,
		30,
		"4:510022:2#4:30006:20#4:90316:1#4:12102:5#4:11002:10000#4:31:5#8:1:1000000"
	},
	{
		1,
		3,
		60,
		"4:510022:2#4:30006:30#4:90316:1#4:12102:5#4:11002:10000#4:31:5#8:1:1000000"
	},
	{
		1,
		4,
		90,
		"4:510022:2#4:30006:30#4:90316:1#4:12102:5#4:11002:15000#4:31:5#8:1:1000000"
	},
	{
		1,
		5,
		120,
		"4:510022:2#4:30006:40#4:90316:1#4:12102:5#4:11002:15000#4:31:5#8:1:1000000"
	},
	{
		1,
		6,
		150,
		"4:510022:2#4:30006:50#4:90316:1#4:12102:5#4:11002:15000#4:31:5#8:1:1000000"
	},
	{
		2,
		1,
		10,
		"4:510022:1#4:30006:20#4:90316:1#4:12102:5#4:11002:10000#4:31:5#8:1:1000000"
	},
	{
		2,
		2,
		30,
		"4:510022:2#4:30006:20#4:90316:1#4:12102:5#4:11002:10000#4:31:5#8:1:1000000"
	},
	{
		2,
		3,
		60,
		"4:510022:2#4:30006:30#4:90316:1#4:12102:5#4:11002:10000#4:31:5#8:1:1000000"
	},
	{
		2,
		4,
		90,
		"4:510022:2#4:30006:30#4:90316:1#4:12102:5#4:11002:15000#4:31:5#8:1:1000000"
	},
	{
		2,
		5,
		120,
		"4:510022:2#4:30006:40#4:90316:1#4:12102:5#4:11002:15000#4:31:5#8:1:1000000"
	},
	{
		2,
		6,
		150,
		"4:510022:3#4:30006:50#4:90316:1#4:12102:5#4:11002:15000#4:31:5#8:1:1000000"
	}
}
local t_form_prediction_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_form_prediction_prize.dataList = dataList

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

return t_form_prediction_prize
