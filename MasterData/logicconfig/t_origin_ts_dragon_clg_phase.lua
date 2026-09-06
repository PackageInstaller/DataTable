-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ts_dragon_clg_phase.lua

module("logicconfig.config.t_origin_ts_dragon_clg_phase", package.seeall)

local title = {
	activityId = 1,
	name = 4,
	phaseId = 2,
	puzzleLimit = 3
}
local dataList = {
	{
		591001,
		1,
		3,
		"名字1"
	},
	{
		591001,
		2,
		3,
		"名字2"
	},
	{
		591001,
		3,
		3,
		"名字3"
	}
}
local t_origin_ts_dragon_clg_phase = {
	[591001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_ts_dragon_clg_phase.dataList = dataList

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

return t_origin_ts_dragon_clg_phase
