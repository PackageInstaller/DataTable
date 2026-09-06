-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equipment_quality_plan.lua

module("logicconfig.config.t_equipment_quality_plan", package.seeall)

local title = {
	isBase = 3,
	qualityName = 4,
	planId = 1,
	qualityNum = 2
}
local dataList = {
	{
		1,
		0,
		true,
		"<color=#FFFFFFFF>白色</color>"
	},
	{
		1,
		1,
		true,
		"<color=#76FFAAFF>绿</color>"
	},
	{
		1,
		2,
		true,
		"<color=#1161FFFF>蓝</color>"
	},
	{
		1,
		3,
		true,
		"<color=#FF00EDFF>紫</color>"
	},
	{
		2,
		0,
		true,
		"<color=#FFFFFFFF>白色</color>"
	},
	{
		2,
		1,
		true,
		"<color=#76FFAAFF>绿</color>"
	},
	{
		2,
		2,
		true,
		"<color=#1161FFFF>蓝</color>"
	},
	{
		2,
		5,
		false,
		"<color=#FF00EDFF>紫</color>"
	},
	{
		2,
		6,
		false,
		"<color=#FF00EDFF>紫+1</color>"
	},
	{
		2,
		7,
		false,
		"<color=#FF00EDFF>紫+2</color>"
	}
}
local t_equipment_quality_plan = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		[0] = dataList[5],
		dataList[6],
		dataList[7],
		[5] = dataList[8],
		[6] = dataList[9],
		[7] = dataList[10]
	}
}

t_equipment_quality_plan.dataList = dataList

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

return t_equipment_quality_plan
