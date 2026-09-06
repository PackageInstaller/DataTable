-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_festive_flower_activity.lua

module("logicconfig.config.t_festive_flower_activity", package.seeall)

local title = {
	cacheMaxRecordCD = 5,
	cacheMaxCD = 4,
	ratio = 2,
	cacheMaxLength = 3,
	activityId = 1
}
local dataList = {
	{
		174001,
		1,
		100,
		180,
		30
	},
	{
		174002,
		1,
		100,
		180,
		30
	},
	{
		174003,
		1,
		100,
		180,
		30
	},
	{
		174004,
		1,
		100,
		180,
		30
	},
	{
		174005,
		1,
		100,
		180,
		30
	},
	{
		174006,
		1,
		100,
		180,
		30
	},
	{
		174007,
		1,
		100,
		180,
		30
	},
	{
		174008,
		1,
		100,
		180,
		30
	},
	{
		174009,
		1,
		100,
		180,
		30
	},
	{
		174010,
		1,
		100,
		180,
		30
	},
	{
		174011,
		1,
		100,
		180,
		30
	},
	{
		174012,
		1,
		100,
		180,
		30
	},
	{
		174013,
		1,
		100,
		180,
		30
	},
	{
		174014,
		1,
		100,
		180,
		30
	}
}
local t_festive_flower_activity = {
	[174001] = dataList[1],
	[174002] = dataList[2],
	[174003] = dataList[3],
	[174004] = dataList[4],
	[174005] = dataList[5],
	[174006] = dataList[6],
	[174007] = dataList[7],
	[174008] = dataList[8],
	[174009] = dataList[9],
	[174010] = dataList[10],
	[174011] = dataList[11],
	[174012] = dataList[12],
	[174013] = dataList[13],
	[174014] = dataList[14]
}

t_festive_flower_activity.dataList = dataList

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

return t_festive_flower_activity
