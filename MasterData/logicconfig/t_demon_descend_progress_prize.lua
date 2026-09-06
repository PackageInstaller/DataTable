-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_demon_descend_progress_prize.lua

module("logicconfig.config.t_demon_descend_progress_prize", package.seeall)

local title = {
	progressId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		497001,
		1,
		100000,
		"4:12102:10"
	},
	{
		497001,
		2,
		1000000,
		"4:36:20"
	},
	{
		497001,
		3,
		10000000,
		"4:11002:30000"
	},
	{
		497001,
		4,
		100000000,
		"4:388:20"
	},
	{
		497001,
		5,
		300000000,
		"4:36:20"
	}
}
local t_demon_descend_progress_prize = {
	[497001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_demon_descend_progress_prize.dataList = dataList

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

return t_demon_descend_progress_prize
