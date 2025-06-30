-- chunkname: @IQIGame\\Config\\CfgFurnitureActivityLotteryGlobalTable.lua

local CfgFurnitureActivityLotteryGlobalTable = {
	{
		ShowType = 1,
		Id = 1,
		MaxTimes = 105,
		BackGround = "/UI/_DailyActivityUI/GashaponPool_211202001.prefab",
		Name = getI18NValue(180149607),
		Cost1 = {
			10025,
			1
		},
		Cost10 = {
			10025,
			10
		}
	},
	{
		ShowType = 1,
		Id = 2,
		MaxTimes = 105,
		BackGround = "/UI/_DailyActivityUI/GashaponPool_220609001.prefab",
		Name = getI18NValue(180290483),
		Cost1 = {
			10025,
			1
		},
		Cost10 = {
			10025,
			10
		}
	},
	{
		ShowType = 1,
		Id = 3,
		MaxTimes = 105,
		BackGround = "/UI/_DailyActivityUI/GashaponPool_230824001.prefab",
		Name = getI18NValue(180562816),
		Cost1 = {
			10025,
			1
		},
		Cost10 = {
			10025,
			10
		}
	},
	{
		ShowType = 2,
		Id = 4,
		MaxTimes = 47,
		BackGround = "/UI/_DailyActivityUI/GashaponPool_230928001.prefab",
		Name = getI18NValue(180775143),
		Cost1 = {
			10039,
			1
		},
		Cost10 = {
			10039,
			10
		}
	}
}

setmetatable(CfgFurnitureActivityLotteryGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFurnitureActivityLotteryGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ShowType = 0,
		Name = "",
		BackGround = "",
		MaxTimes = 0,
		Desc = "",
		Cost1 = {},
		Cost10 = {}
	}
}

for i, data in pairs(CfgFurnitureActivityLotteryGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFurnitureActivityLotteryGlobalTable
