-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_activity.lua

module("logicconfig.config.t_maintain_power_pillar_activity", package.seeall)

local title = {
	stagePlanId = 3,
	petPlanId = 5,
	buffPlanId = 4,
	bgEff = 7,
	gameCoin = 6,
	activityId = 1,
	dailyPrize = 2
}
local dataList = {
	{
		152002,
		"10:152003:1000",
		2,
		1,
		2,
		"10:152003",
		"20230602/fuyaota/fx_ui_fuyaota_fw01"
	},
	{
		152003,
		"10:152005:1000",
		3,
		2,
		3,
		"10:152005",
		"20240531/fuyaota/fx_ui_fuyaota_fw01"
	},
	{
		152004,
		"10:152007:1000",
		4,
		3,
		4,
		"10:152007",
		"20250228/fuyaota/fx_ui_fuyaota_fw01"
	},
	{
		152005,
		"10:152009:1000",
		5,
		4,
		5,
		"10:152009",
		"20250228/fuyaota/fx_ui_fuyaota_fw01"
	},
	{
		152006,
		"10:152009:1000",
		6,
		5,
		6,
		"10:152009",
		"20250228/fuyaota/fx_ui_fuyaota_fw01"
	}
}
local t_maintain_power_pillar_activity = {
	[152002] = dataList[1],
	[152003] = dataList[2],
	[152004] = dataList[3],
	[152005] = dataList[4],
	[152006] = dataList[5]
}

t_maintain_power_pillar_activity.dataList = dataList

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

return t_maintain_power_pillar_activity
