-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_strengthen_star_god_filter.lua

module("logicconfig.config.t_pay_strengthen_star_god_filter", package.seeall)

local title = {
	defineId = 1,
	prize = 2
}
local dataList = {
	{
		1,
		"18:601:1"
	},
	{
		2,
		"18:602:1"
	},
	{
		3,
		"18:603:1"
	},
	{
		4,
		"18:604:1"
	},
	{
		5,
		"18:605:1"
	},
	{
		6,
		"18:606:1"
	},
	{
		7,
		"18:607:1"
	},
	{
		8,
		"18:608:1"
	},
	{
		9,
		"18:609:1"
	},
	{
		10,
		"18:610:1"
	}
}
local t_pay_strengthen_star_god_filter = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_pay_strengthen_star_god_filter.dataList = dataList

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

return t_pay_strengthen_star_god_filter
