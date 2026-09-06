-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_fusion_times.lua

module("logicconfig.config.t_dragon_respect_challenge_fusion_times", package.seeall)

local title = {
	scoreRange = 3,
	fusionDrawPlanId = 1,
	drawTimes = 2
}
local dataList = {
	{
		1,
		1,
		{
			30,
			59
		}
	},
	{
		1,
		2,
		{
			60,
			94
		}
	},
	{
		1,
		3,
		{
			95,
			134
		}
	},
	{
		1,
		4,
		{
			135,
			164
		}
	},
	{
		1,
		5,
		{
			165,
			209
		}
	},
	{
		1,
		6,
		{
			210,
			269
		}
	},
	{
		1,
		7,
		{
			270,
			999
		}
	}
}
local t_dragon_respect_challenge_fusion_times = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_dragon_respect_challenge_fusion_times.dataList = dataList

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

return t_dragon_respect_challenge_fusion_times
