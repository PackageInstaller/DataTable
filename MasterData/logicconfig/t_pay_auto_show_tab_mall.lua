-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_auto_show_tab_mall.lua

module("logicconfig.config.t_pay_auto_show_tab_mall", package.seeall)

local title = {
	activityType = 2,
	id = 1,
	shopId = 3
}
local dataList = {
	{
		1,
		1,
		70001
	},
	{
		2,
		1,
		70002
	},
	{
		3,
		1,
		70003
	},
	{
		4,
		1,
		70004
	},
	{
		5,
		1,
		70005
	},
	{
		6,
		1,
		70006
	},
	{
		7,
		9,
		4001
	},
	{
		8,
		10,
		13001
	},
	{
		9,
		10,
		13002
	},
	{
		10,
		10,
		13003
	},
	{
		11,
		8,
		12051
	}
}
local t_pay_auto_show_tab_mall = {
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
	dataList[11]
}

t_pay_auto_show_tab_mall.dataList = dataList

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

return t_pay_auto_show_tab_mall
