-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_surround_by_dream_girl_girl.lua

module("logicconfig.config.t_surround_by_dream_girl_girl", package.seeall)

local title = {
	maxFetter = 5,
	dreamGirlId = 2,
	shopName = 3,
	skinId = 4,
	investPlanId = 6,
	dialoguePlanId = 9,
	pos = 11,
	feelPlanId = 10,
	favouriteGiftId = 8,
	dailyChatTimes = 7,
	activityId = 1
}
local dataList = {
	{
		459001,
		1,
		"棋牌室",
		1503101,
		10000,
		1,
		3,
		1,
		1,
		1,
		{
			206,
			185
		}
	},
	{
		459001,
		2,
		"机甲坊",
		1403101,
		10000,
		2,
		3,
		2,
		2,
		2,
		{
			410,
			70
		}
	},
	{
		459001,
		3,
		"占星馆",
		1202902,
		10000,
		3,
		3,
		3,
		3,
		3,
		{
			-240,
			295
		}
	},
	{
		459001,
		4,
		"诡事集",
		1603102,
		10000,
		4,
		3,
		4,
		4,
		4,
		{
			-485,
			85
		}
	}
}
local t_surround_by_dream_girl_girl = {
	[459001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_surround_by_dream_girl_girl.dataList = dataList

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

return t_surround_by_dream_girl_girl
