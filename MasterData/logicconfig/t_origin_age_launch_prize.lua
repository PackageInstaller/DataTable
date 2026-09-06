-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_age_launch_prize.lua

module("logicconfig.config.t_origin_age_launch_prize", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	prizeType = 2
}
local dataList = {
	{
		532001,
		"CHECK_IN",
		"9:1300027:1"
	},
	{
		532001,
		"SHARE",
		"9:1300027:1"
	},
	{
		532001,
		"INVITE_OLD_PLAYER",
		"8:25:800"
	},
	{
		532001,
		"BIND_CODE",
		"8:25:800"
	}
}
local t_origin_age_launch_prize = {
	[532001] = {
		CHECK_IN = dataList[1],
		SHARE = dataList[2],
		INVITE_OLD_PLAYER = dataList[3],
		BIND_CODE = dataList[4]
	}
}

t_origin_age_launch_prize.dataList = dataList

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

return t_origin_age_launch_prize
