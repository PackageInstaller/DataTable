-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg_normal_stage_prize.lua

module("logicconfig.config.t_divine_ao_jiu_clg_normal_stage_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	passStageCount = 3
}
local dataList = {
	{
		511001,
		1,
		2,
		"8:1:10000"
	},
	{
		511001,
		2,
		4,
		"8:1:10000"
	},
	{
		511001,
		3,
		6,
		"8:1:10000"
	},
	{
		511001,
		4,
		8,
		"8:1:10000"
	},
	{
		511001,
		5,
		9,
		"4:391:100"
	}
}
local t_divine_ao_jiu_clg_normal_stage_prize = {
	[511001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_ao_jiu_clg_normal_stage_prize.dataList = dataList

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

return t_divine_ao_jiu_clg_normal_stage_prize
