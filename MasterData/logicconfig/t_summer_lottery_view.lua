-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_lottery_view.lua

module("logicconfig.config.t_summer_lottery_view", package.seeall)

local title = {
	viewPlanId = 1,
	viewId = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
	{
		2,
		1
	},
	{
		2,
		2
	},
	{
		3,
		1
	},
	{
		3,
		2
	},
	{
		4,
		1
	},
	{
		4,
		2
	},
	{
		5,
		1
	},
	{
		5,
		2
	},
	{
		6,
		1
	},
	{
		6,
		2
	}
}
local t_summer_lottery_view = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	}
}

t_summer_lottery_view.dataList = dataList

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

return t_summer_lottery_view
