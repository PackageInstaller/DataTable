-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mount_att_plan.lua

module("logicconfig.config.t_mount_att_plan", package.seeall)

local title = {
	attributePlan = 1,
	weight = 3,
	attribute = 2
}
local dataList = {
	{
		1,
		"生命+10",
		10
	},
	{
		1,
		"物攻+2",
		10
	},
	{
		1,
		"物防+1",
		10
	},
	{
		1,
		"魔攻+2",
		10
	},
	{
		1,
		"魔防+1",
		10
	}
}
local t_mount_att_plan = {
	{
		["生命+10"] = dataList[1],
		["物攻+2"] = dataList[2],
		["物防+1"] = dataList[3],
		["魔攻+2"] = dataList[4],
		["魔防+1"] = dataList[5]
	}
}

t_mount_att_plan.dataList = dataList

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

return t_mount_att_plan
