-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_awaken_oath_ancestor_progress_prize.lua

module("logicconfig.config.t_awaken_oath_ancestor_progress_prize", package.seeall)

local title = {
	progressId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		496001,
		1,
		1,
		"4:36:10"
	},
	{
		496001,
		2,
		2,
		"4:36:10"
	},
	{
		496001,
		3,
		4,
		"4:36:10"
	},
	{
		496001,
		4,
		6,
		"4:7008:100"
	},
	{
		496001,
		5,
		8,
		"4:510549:2"
	}
}
local t_awaken_oath_ancestor_progress_prize = {
	[496001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_awaken_oath_ancestor_progress_prize.dataList = dataList

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

return t_awaken_oath_ancestor_progress_prize
