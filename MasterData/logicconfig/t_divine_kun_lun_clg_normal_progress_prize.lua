-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_kun_lun_clg_normal_progress_prize.lua

module("logicconfig.config.t_divine_kun_lun_clg_normal_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		464001,
		1,
		5,
		"4:90004:1"
	},
	{
		464001,
		2,
		10,
		"4:271:5"
	},
	{
		464001,
		3,
		15,
		"8:1:1000000"
	},
	{
		464001,
		4,
		20,
		"4:271:5"
	},
	{
		464001,
		5,
		30,
		"4:271:10"
	}
}
local t_divine_kun_lun_clg_normal_progress_prize = {
	[464001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_kun_lun_clg_normal_progress_prize.dataList = dataList

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

return t_divine_kun_lun_clg_normal_progress_prize
