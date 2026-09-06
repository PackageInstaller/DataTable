-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ciyuan_signin_player_type.lua

module("logicconfig.config.t_ciyuan_signin_player_type", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	playerType = 2,
	benefitDesc = 4
}
local dataList = {
	{
		616001,
		1,
		"204:250914:40",
		"每日活跃度达到120后可签到领奖"
	},
	{
		616001,
		2,
		"204:250915:25",
		"每日登录后即可签到，每次签到计为2天，领取2日奖励"
	},
	{
		616001,
		3,
		"204:250914:40",
		"每日登录后即可签到，每次签到计为1天，领取1日奖励"
	},
	{
		616002,
		1,
		"204:250914:50",
		"每日活跃度达到120后可签到领奖"
	},
	{
		616002,
		2,
		"204:250915:30",
		"每日登录后即可签到，每次签到计为2天，领取2日奖励"
	},
	{
		616002,
		3,
		"204:250916:50",
		"每日登录后即可签到，每次签到计为1天，领取1日奖励"
	}
}
local t_ciyuan_signin_player_type = {
	[616001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[616002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ciyuan_signin_player_type.dataList = dataList

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

return t_ciyuan_signin_player_type
