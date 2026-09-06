-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_extreme_clg_stage_truefalse_type.lua

module("logicconfig.config.t_divine_xiu_er_extreme_clg_stage_truefalse_type", package.seeall)

local title = {
	activityId = 1,
	clgResultTitle = 5,
	index = 2,
	stageType = 3,
	progressTitle = 4
}
local dataList = {
	{
		329001,
		1,
		0,
		"“非”之力",
		"本关获得“非”之力"
	},
	{
		329001,
		2,
		1,
		"“是”之力",
		"本关获得“是”之力"
	}
}
local t_divine_xiu_er_extreme_clg_stage_truefalse_type = {
	[329001] = {
		dataList[1],
		dataList[2]
	}
}

t_divine_xiu_er_extreme_clg_stage_truefalse_type.dataList = dataList

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

return t_divine_xiu_er_extreme_clg_stage_truefalse_type
