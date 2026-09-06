-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_wu_normal_clg_progress.lua

module("logicconfig.config.t_kun_wu_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		444001,
		1,
		1,
		"4:90004:1"
	},
	{
		444001,
		2,
		3,
		"4:262:5"
	},
	{
		444001,
		3,
		6,
		"8:1:1000000"
	},
	{
		444001,
		4,
		9,
		"4:262:5"
	},
	{
		444001,
		5,
		12,
		"4:262:10"
	}
}
local t_kun_wu_normal_clg_progress = {
	[444001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_kun_wu_normal_clg_progress.dataList = dataList

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

return t_kun_wu_normal_clg_progress
