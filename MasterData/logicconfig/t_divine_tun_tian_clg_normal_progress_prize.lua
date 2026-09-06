-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tun_tian_clg_normal_progress_prize.lua

module("logicconfig.config.t_divine_tun_tian_clg_normal_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		508001,
		1,
		3,
		"4:90004:1"
	},
	{
		508001,
		2,
		5,
		"4:393:5"
	},
	{
		508001,
		3,
		10,
		"8:1:1000000"
	},
	{
		508001,
		4,
		15,
		"4:393:5"
	},
	{
		508001,
		5,
		25,
		"4:393:10"
	}
}
local t_divine_tun_tian_clg_normal_progress_prize = {
	[508001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_tun_tian_clg_normal_progress_prize.dataList = dataList

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

return t_divine_tun_tian_clg_normal_progress_prize
