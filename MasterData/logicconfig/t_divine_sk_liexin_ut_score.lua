-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_sk_liexin_ut_score.lua

module("logicconfig.config.t_divine_sk_liexin_ut_score", package.seeall)

local title = {
	score = 4,
	ultimateScorePlanId = 1,
	count = 3,
	type = 2
}
local dataList = {
	{
		1,
		1,
		1,
		10
	},
	{
		1,
		1,
		2,
		5
	},
	{
		1,
		1,
		3,
		1
	},
	{
		1,
		2,
		1,
		5
	},
	{
		1,
		2,
		2,
		10
	},
	{
		1,
		2,
		3,
		15
	}
}
local t_divine_sk_liexin_ut_score = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_divine_sk_liexin_ut_score.dataList = dataList

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

return t_divine_sk_liexin_ut_score
