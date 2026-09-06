-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_path_finding_buy.lua

module("logicconfig.config.t_camp_battle_path_finding_buy", package.seeall)

local title = {
	cost = 3,
	buyPlanId = 1,
	time = 2
}
local dataList = {
	{
		1,
		1,
		"105:147:300"
	},
	{
		1,
		2,
		"105:147:300"
	},
	{
		2,
		1,
		"105:147:300"
	},
	{
		2,
		2,
		"105:147:300"
	}
}
local t_camp_battle_path_finding_buy = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	}
}

t_camp_battle_path_finding_buy.dataList = dataList

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

return t_camp_battle_path_finding_buy
