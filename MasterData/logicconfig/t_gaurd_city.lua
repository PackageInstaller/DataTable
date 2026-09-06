-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gaurd_city.lua

module("logicconfig.config.t_gaurd_city", package.seeall)

local title = {
	scoreMaterials = 10,
	strengthPurchasePlanId = 9,
	refreshMaterials = 11,
	prizePlanId = 8,
	redPointId = 13,
	damagePrizePlanId = 6,
	starPlanId = 7,
	abilityPlanId = 4,
	masterPlanId = 5,
	msgId = 14,
	buffPlanId = 2,
	jumpTo1 = 15,
	pathPlanId = 3,
	skinId = 16,
	activityId = 1,
	privilegeMaterialId = 12
}
local dataList = {
	{
		250001,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		"10:250001:1",
		"10:250002:1",
		250999,
		459,
		59,
		"func#191#250#250001",
		17006
	},
	{
		250002,
		1,
		1,
		2,
		2,
		2,
		2,
		2,
		1,
		"10:250004:1",
		"10:250005:1",
		250998,
		459,
		59,
		"func#191#250#250002",
		17006
	},
	{
		250003,
		1,
		1,
		2,
		2,
		2,
		2,
		2,
		1,
		"10:250006:1",
		"10:250007:1",
		250997,
		459,
		59,
		"func#191#250#250003",
		17006
	}
}
local t_gaurd_city = {
	[250001] = dataList[1],
	[250002] = dataList[2],
	[250003] = dataList[3]
}

t_gaurd_city.dataList = dataList

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

return t_gaurd_city
