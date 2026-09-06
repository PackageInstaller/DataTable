-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_huarongroad_progress.lua

module("logicconfig.config.t_huarongroad_progress", package.seeall)

local title = {
	progress = 2,
	operaId = 3,
	challengePlanId = 1
}
local dataList = {
	{
		1,
		0,
		4290014
	},
	{
		1,
		4,
		4290015
	},
	{
		1,
		8,
		4290016
	},
	{
		1,
		12,
		4290017
	},
	{
		1,
		15,
		4290018
	},
	{
		5,
		0,
		4660001
	}
}
local t_huarongroad_progress = {
	{
		[0] = dataList[1],
		[4] = dataList[2],
		[8] = dataList[3],
		[12] = dataList[4],
		[15] = dataList[5]
	},
	[5] = {
		[0] = dataList[6]
	}
}

t_huarongroad_progress.dataList = dataList

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

return t_huarongroad_progress
