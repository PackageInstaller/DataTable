-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mo_yan_clg_stage.lua

module("logicconfig.config.t_origin_dark_mo_yan_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		625001,
		1,
		"2026-07-24T05:00:00",
		"4:510847:20"
	},
	{
		625001,
		2,
		"2026-07-25T05:00:00",
		"4:510847:30"
	},
	{
		625001,
		3,
		"2026-07-26T05:00:00",
		"4:510847:50"
	}
}
local t_origin_dark_mo_yan_clg_stage = {
	[625001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_dark_mo_yan_clg_stage.dataList = dataList

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

return t_origin_dark_mo_yan_clg_stage
