-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ares_mom_clg_normal_prize.lua

module("logicconfig.config.t_origin_ares_mom_clg_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		549001,
		1,
		1,
		"8:1:1000000"
	},
	{
		549001,
		2,
		3,
		"4:436:5"
	},
	{
		549001,
		3,
		5,
		"4:436:5"
	},
	{
		549001,
		4,
		7,
		"4:436:10"
	},
	{
		549001,
		5,
		9,
		"4:90004:1"
	},
	{
		549001,
		6,
		12,
		"4:30006:20"
	},
	{
		549001,
		7,
		15,
		"4:30006:20"
	}
}
local t_origin_ares_mom_clg_normal_prize = {
	[549001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_origin_ares_mom_clg_normal_prize.dataList = dataList

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

return t_origin_ares_mom_clg_normal_prize
