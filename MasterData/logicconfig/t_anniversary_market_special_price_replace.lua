-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_market_special_price_replace.lua

module("logicconfig.config.t_anniversary_market_special_price_replace", package.seeall)

local title = {
	pricePlanId = 3,
	activityId = 1,
	days = 2
}
local dataList = {
	{
		467001,
		1,
		2
	},
	{
		467001,
		2,
		2
	},
	{
		467001,
		3,
		2
	},
	{
		467001,
		4,
		2
	},
	{
		467001,
		5,
		2
	},
	{
		467001,
		6,
		2
	},
	{
		467001,
		7,
		2
	},
	{
		467002,
		1,
		2
	},
	{
		467002,
		2,
		2
	},
	{
		467002,
		3,
		2
	},
	{
		467002,
		4,
		2
	},
	{
		467002,
		5,
		2
	},
	{
		467002,
		6,
		2
	},
	{
		467002,
		7,
		2
	},
	{
		467003,
		1,
		2
	},
	{
		467003,
		2,
		2
	},
	{
		467003,
		3,
		2
	},
	{
		467003,
		4,
		2
	},
	{
		467003,
		5,
		2
	},
	{
		467003,
		6,
		2
	},
	{
		467003,
		7,
		2
	},
	{
		467004,
		1,
		2
	},
	{
		467004,
		2,
		2
	},
	{
		467004,
		3,
		2
	},
	{
		467004,
		4,
		2
	},
	{
		467004,
		5,
		2
	},
	{
		467004,
		6,
		2
	},
	{
		467004,
		7,
		2
	}
}
local t_anniversary_market_special_price_replace = {
	[467001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[467002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[467003] = {
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	},
	[467004] = {
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28]
	}
}

t_anniversary_market_special_price_replace.dataList = dataList

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

return t_anniversary_market_special_price_replace
