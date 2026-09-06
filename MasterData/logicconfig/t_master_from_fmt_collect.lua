-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_from_fmt_collect.lua

module("logicconfig.config.t_master_from_fmt_collect", package.seeall)

local title = {
	fmtId = 1,
	petList = 4,
	collectPrize = 5,
	fmtType = 2,
	fmtName = 3
}
local dataList = {
	{
		1,
		1,
		"草",
		{
			37,
			38,
			39,
			40,
			41,
			42
		},
		"8:1:100"
	},
	{
		2,
		2,
		"空",
		{
			166,
			167,
			168,
			169,
			170,
			171
		},
		"8:1:100"
	},
	{
		3,
		3,
		"究",
		{
			54,
			71,
			110,
			111,
			112,
			113
		},
		"8:1:100"
	},
	{
		4,
		4,
		"梦",
		{
			240,
			241,
			242,
			243,
			244,
			245
		},
		"8:1:100"
	},
	{
		5,
		5,
		"尘",
		{
			138,
			149,
			150,
			151,
			152,
			153
		},
		"8:1:100"
	}
}
local t_master_from_fmt_collect = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_master_from_fmt_collect.dataList = dataList

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

return t_master_from_fmt_collect
