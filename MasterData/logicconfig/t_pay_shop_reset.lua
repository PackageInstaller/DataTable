-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_reset.lua

module("logicconfig.config.t_pay_shop_reset", package.seeall)

local title = {
	id = 1,
	resetTime = 2,
	order = 3
}
local dataList = {
	{
		401,
		"2021-07-02T05:00:00",
		1
	},
	{
		402,
		"2021-07-02T05:00:00",
		1
	},
	{
		403,
		"2021-07-02T05:00:00",
		1
	},
	{
		404,
		"2021-07-02T05:00:00",
		1
	},
	{
		405,
		"2021-07-02T05:00:00",
		1
	},
	{
		406,
		"2021-07-02T05:00:00",
		1
	},
	{
		407,
		"2021-07-02T05:00:00",
		1
	},
	{
		411,
		"2022-04-01T05:00:00",
		1
	},
	{
		412,
		"2022-04-01T05:00:00",
		1
	},
	{
		413,
		"2022-04-01T05:00:00",
		1
	},
	{
		414,
		"2022-04-01T05:00:00",
		1
	},
	{
		411,
		"2022-12-23T05:00:00",
		1
	},
	{
		412,
		"2022-12-23T05:00:00",
		1
	},
	{
		413,
		"2022-12-23T05:00:00",
		1
	},
	{
		414,
		"2022-12-23T05:00:00",
		1
	}
}
local t_pay_shop_reset = {
	[401] = {
		["2021-07-02T05:00:00"] = dataList[1]
	},
	[402] = {
		["2021-07-02T05:00:00"] = dataList[2]
	},
	[403] = {
		["2021-07-02T05:00:00"] = dataList[3]
	},
	[404] = {
		["2021-07-02T05:00:00"] = dataList[4]
	},
	[405] = {
		["2021-07-02T05:00:00"] = dataList[5]
	},
	[406] = {
		["2021-07-02T05:00:00"] = dataList[6]
	},
	[407] = {
		["2021-07-02T05:00:00"] = dataList[7]
	},
	[411] = {
		["2022-04-01T05:00:00"] = dataList[8],
		["2022-12-23T05:00:00"] = dataList[12]
	},
	[412] = {
		["2022-04-01T05:00:00"] = dataList[9],
		["2022-12-23T05:00:00"] = dataList[13]
	},
	[413] = {
		["2022-04-01T05:00:00"] = dataList[10],
		["2022-12-23T05:00:00"] = dataList[14]
	},
	[414] = {
		["2022-04-01T05:00:00"] = dataList[11],
		["2022-12-23T05:00:00"] = dataList[15]
	}
}

t_pay_shop_reset.dataList = dataList

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

return t_pay_shop_reset
