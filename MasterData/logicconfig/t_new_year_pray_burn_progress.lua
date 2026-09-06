-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_burn_progress.lua

module("logicconfig.config.t_new_year_pray_burn_progress", package.seeall)

local title = {
	burnPlanId = 1,
	score = 3,
	choiceId = 4,
	burnProgressId = 2
}
local dataList = {
	{
		1,
		1,
		0,
		1
	},
	{
		1,
		2,
		90,
		2
	},
	{
		1,
		3,
		120,
		3
	}
}
local t_new_year_pray_burn_progress = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_new_year_pray_burn_progress.dataList = dataList

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

return t_new_year_pray_burn_progress
