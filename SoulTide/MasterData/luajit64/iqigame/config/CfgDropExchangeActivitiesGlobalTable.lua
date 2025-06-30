-- chunkname: @IQIGame\\Config\\CfgDropExchangeActivitiesGlobalTable.lua

local CfgDropExchangeActivitiesGlobalTable = {
	{
		Id = 1,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_220428.prefab",
		DayLimit = 80,
		Name = getI18NValue(180272776),
		Desc = getI18NValue(180272775),
		GetItem = {
			409,
			1
		}
	},
	{
		Id = 2,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_220602.prefab",
		DayLimit = 80,
		Name = getI18NValue(180289823),
		Desc = getI18NValue(180289822),
		GetItem = {
			412,
			1
		}
	},
	{
		Id = 3,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_220823.prefab",
		DayLimit = 80,
		Name = getI18NValue(180433874),
		Desc = getI18NValue(180433873),
		GetItem = {
			419,
			1
		}
	},
	{
		Id = 4,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_220929.prefab",
		DayLimit = 80,
		Name = getI18NValue(180452521),
		Desc = getI18NValue(180452520),
		GetItem = {
			422,
			1
		}
	},
	{
		Id = 5,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_230119.prefab",
		DayLimit = 80,
		Name = getI18NValue(180497278),
		Desc = getI18NValue(180497277),
		GetItem = {
			429,
			1
		}
	},
	{
		Id = 6,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_230223.prefab",
		DayLimit = 80,
		Name = getI18NValue(180506394),
		Desc = getI18NValue(180506393),
		GetItem = {
			432,
			1
		}
	},
	{
		Id = 7,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_230427.prefab",
		DayLimit = 80,
		Name = getI18NValue(180528030),
		Desc = getI18NValue(180528029),
		GetItem = {
			438,
			1
		}
	},
	{
		Id = 8,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_230622.prefab",
		DayLimit = 80,
		Name = getI18NValue(180539751),
		Desc = getI18NValue(180539750),
		GetItem = {
			440,
			1
		}
	},
	{
		Id = 9,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_230824.prefab",
		DayLimit = 80,
		Name = getI18NValue(180760195),
		Desc = getI18NValue(180760194),
		GetItem = {
			443,
			1
		}
	},
	{
		Id = 10,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_231221.prefab",
		DayLimit = 80,
		Name = getI18NValue(180826192),
		Desc = getI18NValue(180826191),
		GetItem = {
			450,
			1
		}
	},
	{
		Id = 11,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_240201.prefab",
		DayLimit = 80,
		Name = getI18NValue(180831575),
		Desc = getI18NValue(180831574),
		GetItem = {
			453,
			1
		}
	},
	{
		Id = 12,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_240520.prefab",
		DayLimit = 80,
		Name = getI18NValue(180875480),
		Desc = getI18NValue(180875479),
		GetItem = {
			456,
			1
		}
	},
	{
		Id = 13,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_240822.prefab",
		DayLimit = 80,
		Name = getI18NValue(180910055),
		Desc = getI18NValue(180910054),
		GetItem = {
			459,
			1
		}
	},
	{
		Id = 14,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_240926.prefab",
		DayLimit = 80,
		Name = getI18NValue(180914765),
		Desc = getI18NValue(180914764),
		GetItem = {
			463,
			1
		}
	},
	{
		Id = 15,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_241212.prefab",
		DayLimit = 80,
		Name = getI18NValue(180921975),
		Desc = getI18NValue(180921974),
		GetItem = {
			467,
			1
		}
	},
	{
		Id = 16,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_250220.prefab",
		DayLimit = 80,
		Name = getI18NValue(180939091),
		Desc = getI18NValue(180939090),
		GetItem = {
			472,
			1
		}
	},
	{
		Id = 17,
		NeedPower = 5,
		BackGround = "/UI/_DailyActivityUI/ActiveDrops_250529.prefab",
		DayLimit = 80,
		Name = getI18NValue(181203245),
		Desc = getI18NValue(181203244),
		GetItem = {
			475,
			1
		}
	}
}

setmetatable(CfgDropExchangeActivitiesGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDropExchangeActivitiesGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		NeedPower = 0,
		Name = "",
		BackGround = "",
		DayLimit = 0,
		Desc = "",
		GetItem = {}
	}
}

for i, data in pairs(CfgDropExchangeActivitiesGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDropExchangeActivitiesGlobalTable
