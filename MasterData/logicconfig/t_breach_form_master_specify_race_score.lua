-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_specify_race_score.lua

module("logicconfig.config.t_breach_form_master_specify_race_score", package.seeall)

local title = {
	raceId = 2,
	raceScorePlanId = 1,
	score = 3
}
local dataList = {
	{
		1,
		15044,
		100
	},
	{
		1,
		15045,
		100
	},
	{
		1,
		15046,
		100
	},
	{
		2,
		15044,
		100
	},
	{
		2,
		15045,
		100
	},
	{
		2,
		15046,
		100
	},
	{
		2,
		15047,
		100
	},
	{
		2,
		15048,
		100
	},
	{
		3,
		15044,
		100
	},
	{
		3,
		15045,
		100
	},
	{
		3,
		15046,
		100
	},
	{
		3,
		15047,
		100
	},
	{
		3,
		15048,
		100
	},
	{
		3,
		15049,
		100
	}
}
local t_breach_form_master_specify_race_score = {
	{
		[15044] = dataList[1],
		[15045] = dataList[2],
		[15046] = dataList[3]
	},
	{
		[15044] = dataList[4],
		[15045] = dataList[5],
		[15046] = dataList[6],
		[15047] = dataList[7],
		[15048] = dataList[8]
	},
	{
		[15044] = dataList[9],
		[15045] = dataList[10],
		[15046] = dataList[11],
		[15047] = dataList[12],
		[15048] = dataList[13],
		[15049] = dataList[14]
	}
}

t_breach_form_master_specify_race_score.dataList = dataList

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

return t_breach_form_master_specify_race_score
