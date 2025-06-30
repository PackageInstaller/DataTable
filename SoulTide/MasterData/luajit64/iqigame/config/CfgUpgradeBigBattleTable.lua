-- chunkname: @IQIGame\\Config\\CfgUpgradeBigBattleTable.lua

local CfgUpgradeBigBattleTable = {
	{
		Id = 1,
		TargetLevel = 5,
		Condition = getI18NValue(180249437),
		Reward = {
			10302,
			80,
			11402,
			50,
			1,
			100000,
			10711,
			80,
			10712,
			80,
			10713,
			80,
			10714,
			80
		}
	},
	{
		Id = 2,
		TargetLevel = 10,
		Condition = getI18NValue(180249438),
		Reward = {
			10302,
			180,
			11402,
			120,
			1,
			250000,
			10501,
			100,
			20303,
			80
		}
	},
	{
		Id = 3,
		TargetLevel = 15,
		Condition = getI18NValue(180249439),
		Reward = {
			10302,
			280,
			11402,
			180,
			1,
			400000,
			10711,
			100,
			10712,
			100,
			10713,
			100,
			10714,
			100
		}
	},
	{
		Id = 4,
		TargetLevel = 20,
		Condition = getI18NValue(180249440),
		Reward = {
			10302,
			400,
			11402,
			280,
			1,
			650000,
			10501,
			200,
			20303,
			100
		}
	},
	{
		Id = 5,
		TargetLevel = 25,
		Condition = getI18NValue(180249441),
		Reward = {
			10303,
			180,
			11403,
			120,
			1,
			900000,
			10711,
			120,
			10712,
			120,
			10713,
			120,
			10714,
			120
		}
	},
	{
		Id = 6,
		TargetLevel = 30,
		Condition = getI18NValue(180249442),
		Reward = {
			10303,
			220,
			11403,
			150,
			1,
			1100000,
			10501,
			400,
			20303,
			120
		}
	},
	{
		Id = 7,
		TargetLevel = 35,
		Condition = getI18NValue(180249443),
		Reward = {
			10303,
			260,
			11403,
			180,
			1,
			1300000,
			10711,
			160,
			10712,
			160,
			10713,
			160,
			10714,
			160
		}
	},
	{
		Id = 8,
		TargetLevel = 40,
		Condition = getI18NValue(180249444),
		Reward = {
			10304,
			90,
			11404,
			60,
			1,
			1500000,
			10501,
			600,
			20303,
			160
		}
	},
	{
		Id = 9,
		TargetLevel = 45,
		Condition = getI18NValue(180249445),
		Reward = {
			10304,
			100,
			11404,
			70,
			1,
			1800000,
			10711,
			200,
			10712,
			200,
			10713,
			200,
			10714,
			200
		}
	},
	{
		Id = 10,
		TargetLevel = 50,
		Condition = getI18NValue(180249446),
		Reward = {
			10304,
			120,
			11404,
			80,
			1,
			2000000,
			10501,
			800,
			20303,
			200
		}
	}
}

setmetatable(CfgUpgradeBigBattleTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgUpgradeBigBattleTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Condition = "",
		TargetLevel = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgUpgradeBigBattleTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgUpgradeBigBattleTable
