-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg_progress_prize.lua

module("logicconfig.config.t_divine_mi_ya_clg_progress_prize", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		399001,
		1,
		3,
		"4:248:25"
	},
	{
		399001,
		2,
		6,
		"4:248:25"
	},
	{
		399001,
		3,
		9,
		"4:248:25"
	},
	{
		399001,
		4,
		12,
		"4:248:25"
	}
}
local t_divine_mi_ya_clg_progress_prize = {
	[399001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_mi_ya_clg_progress_prize.dataList = dataList

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

return t_divine_mi_ya_clg_progress_prize
