-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_star_plan.lua

module("logicconfig.config.t_free_scuffle_star_plan", package.seeall)

local title = {
	coinIncreaseRatio = 3,
	star = 2,
	starPlan = 1
}
local dataList = {
	{
		1,
		0,
		1000
	},
	{
		1,
		1,
		2000
	},
	{
		1,
		2,
		4000
	},
	{
		1,
		3,
		6000
	},
	{
		1,
		4,
		8000
	},
	{
		1,
		5,
		10000
	},
	{
		1,
		6,
		12000
	}
}
local t_free_scuffle_star_plan = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_free_scuffle_star_plan.dataList = dataList

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

return t_free_scuffle_star_plan
