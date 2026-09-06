-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dragon_arya_clg_stage.lua

module("logicconfig.config.t_divine_dragon_arya_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	skinId = 4
}
local dataList = {
	{
		337001,
		1,
		1001,
		16004
	},
	{
		337001,
		2,
		1002,
		10314
	},
	{
		337001,
		3,
		1003,
		11011
	},
	{
		337001,
		4,
		1004,
		17014
	},
	{
		337001,
		5,
		1005,
		14016
	},
	{
		337001,
		6,
		1006,
		13008
	}
}
local t_divine_dragon_arya_clg_stage = {
	[337001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_dragon_arya_clg_stage.dataList = dataList

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

return t_divine_dragon_arya_clg_stage
