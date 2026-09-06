-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_talk.lua

module("logicconfig.config.t_draw_and_guess_talk", package.seeall)

local title = {
	id = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		536001,
		1,
		"画的好，简直是马良在世"
	},
	{
		536001,
		2,
		"不愧是我，一下就猜出来了"
	},
	{
		536001,
		3,
		"快点画吧，时间不多了"
	},
	{
		536001,
		4,
		"不要着急，慢慢画"
	},
	{
		536001,
		5,
		"这画风，难道是毕加索传人"
	},
	{
		536001,
		6,
		"太抽象了，看不懂"
	}
}
local t_draw_and_guess_talk = {
	[536001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_draw_and_guess_talk.dataList = dataList

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

return t_draw_and_guess_talk
