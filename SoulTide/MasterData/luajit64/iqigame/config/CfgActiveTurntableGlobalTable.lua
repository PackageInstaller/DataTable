-- chunkname: @IQIGame\\Config\\CfgActiveTurntableGlobalTable.lua

local CfgActiveTurntableGlobalTable = {
	[220630] = {
		Id = 220630,
		CostItem = 115,
		BackGround = "/UI/_DailyActivityUI/ActiveTurntable_220630.prefab",
		CostNum = 1,
		DailyFreeChance = 1,
		Name = getI18NValue(180477488),
		Rewards = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16
		},
		Desc = getI18NValue(180477487)
	}
}

setmetatable(CfgActiveTurntableGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgActiveTurntableGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		CostItem = 0,
		CostNum = 0,
		BackGround = "",
		DailyFreeChance = 0,
		Desc = "",
		Rewards = {}
	}
}

for i, data in pairs(CfgActiveTurntableGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgActiveTurntableGlobalTable
