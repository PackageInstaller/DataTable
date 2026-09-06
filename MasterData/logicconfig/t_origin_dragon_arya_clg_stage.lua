-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dragon_arya_clg_stage.lua

module("logicconfig.config.t_origin_dragon_arya_clg_stage", package.seeall)

local title = {
	stageId = 2,
	selectScoreTypeCount = 4,
	showSkinId = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		573001,
		1,
		1001,
		2,
		"13025"
	},
	{
		573001,
		2,
		1002,
		2,
		"16041"
	},
	{
		573001,
		3,
		1003,
		2,
		"14039"
	},
	{
		573001,
		4,
		1004,
		2,
		"17025"
	}
}
local t_origin_dragon_arya_clg_stage = {
	[573001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_origin_dragon_arya_clg_stage.dataList = dataList

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

return t_origin_dragon_arya_clg_stage
