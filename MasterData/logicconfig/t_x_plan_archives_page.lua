-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_x_plan_archives_page.lua

module("logicconfig.config.t_x_plan_archives_page", package.seeall)

local title = {
	activityId = 1,
	pageType = 4,
	tabIdx = 2,
	page = 3
}
local dataList = {
	{
		378001,
		1,
		1,
		1
	},
	{
		378001,
		1,
		2,
		1
	},
	{
		378001,
		1,
		3,
		1
	},
	{
		378001,
		1,
		4,
		1
	},
	{
		378001,
		1,
		5,
		1
	},
	{
		378001,
		1,
		6,
		1
	},
	{
		378001,
		1,
		7,
		1
	},
	{
		378001,
		1,
		8,
		1
	},
	{
		378001,
		1,
		9,
		1
	},
	{
		378001,
		1,
		10,
		1
	},
	{
		378001,
		1,
		11,
		1
	},
	{
		378001,
		1,
		12,
		1
	},
	{
		378001,
		2,
		1,
		1
	},
	{
		378001,
		2,
		2,
		1
	},
	{
		378001,
		2,
		3,
		1
	},
	{
		378001,
		2,
		4,
		1
	},
	{
		378001,
		2,
		5,
		1
	},
	{
		378001,
		2,
		6,
		1
	},
	{
		378001,
		2,
		7,
		1
	},
	{
		378001,
		2,
		8,
		1
	}
}
local t_x_plan_archives_page = {
	[378001] = {
		{
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
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		}
	}
}

t_x_plan_archives_page.dataList = dataList

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

return t_x_plan_archives_page
