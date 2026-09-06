-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_vein_nuo_ya_clg.lua

module("logicconfig.config.t_dragon_vein_nuo_ya_clg", package.seeall)

local title = {
	redPointId = 2,
	jumpTo = 4,
	raceId = 3,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		427001,
		642,
		16028,
		{
			"func#618#16028",
			"mibao#shenyaonuoya6",
			"func#1153"
		},
		"dragon_vein_nuo_ya_clg_rule"
	},
	{
		427002,
		642,
		16028,
		{
			"func#618#16028",
			"mibao#shenyaonuoya6",
			"func#1153"
		},
		"dragon_vein_nuo_ya_clg_rule2"
	}
}
local t_dragon_vein_nuo_ya_clg = {
	[427001] = dataList[1],
	[427002] = dataList[2]
}

t_dragon_vein_nuo_ya_clg.dataList = dataList

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

return t_dragon_vein_nuo_ya_clg
