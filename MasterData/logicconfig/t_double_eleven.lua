-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_double_eleven.lua

module("logicconfig.config.t_double_eleven", package.seeall)

local title = {
	reportBehavior = 7,
	tabName = 2,
	funcId = 4,
	tabId = 1,
	tagName = 9,
	redIds = 5,
	params = 8,
	viewName = 3,
	sort = 6
}
local dataList = {
	{
		1,
		"连续充值",
		"continuousrecharge",
		735,
		"158",
		2,
		201367,
		"79:79004",
		""
	},
	{
		2,
		"秒杀专区",
		"seckillzone",
		736,
		"c12",
		3,
		201368,
		"210:210003",
		"热"
	},
	{
		3,
		"免单专区",
		"freezone",
		737,
		"c13",
		1,
		201369,
		"211:211002",
		""
	}
}
local t_double_eleven = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_double_eleven.dataList = dataList

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

return t_double_eleven
