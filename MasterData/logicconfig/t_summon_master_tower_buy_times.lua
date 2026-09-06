-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_buy_times.lua

module("logicconfig.config.t_summon_master_tower_buy_times", package.seeall)

local title = {
	consume = 2,
	times = 1
}
local dataList = {
	{
		1,
		"105:195:200"
	},
	{
		2,
		"105:195:200"
	},
	{
		3,
		"105:195:200"
	},
	{
		4,
		"105:195:200"
	}
}
local t_summon_master_tower_buy_times = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_summon_master_tower_buy_times.dataList = dataList

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

return t_summon_master_tower_buy_times
