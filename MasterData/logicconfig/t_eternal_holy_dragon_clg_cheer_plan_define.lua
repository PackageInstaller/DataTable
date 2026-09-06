-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_holy_dragon_clg_cheer_plan_define.lua

module("logicconfig.config.t_eternal_holy_dragon_clg_cheer_plan_define", package.seeall)

local title = {
	awakenLvl = 2,
	btlCheerPlanId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		2,
		"xx1"
	},
	{
		1,
		4,
		"xx2"
	},
	{
		1,
		5,
		"xx3"
	}
}
local t_eternal_holy_dragon_clg_cheer_plan_define = {
	{
		[2] = dataList[1],
		[4] = dataList[2],
		[5] = dataList[3]
	}
}

t_eternal_holy_dragon_clg_cheer_plan_define.dataList = dataList

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

return t_eternal_holy_dragon_clg_cheer_plan_define
