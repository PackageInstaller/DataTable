-- chunkname: @IQIGame\\Config\\CfgMonthCardTable.lua

local CfgMonthCardTable = {
	{
		Time = 30,
		Type = 1,
		Id = 1,
		Limit = 180,
		Name = getI18NValue(180093896),
		DailyReward = {
			2,
			100
		}
	},
	{
		Time = 30,
		Type = 2,
		Id = 2,
		Limit = 180,
		Name = getI18NValue(180149218),
		DailyReward = {
			104,
			100
		}
	},
	{
		Time = 30,
		Type = 3,
		Id = 3,
		Limit = 180,
		DailyGetPaypoint = 3,
		Name = getI18NValue(180498868),
		Reward = {
			4062001,
			1,
			4062002,
			1,
			4062003,
			1,
			80018,
			1
		},
		DailyReward = {
			121002,
			1,
			20421,
			1
		}
	},
	{
		Time = 30,
		Type = 2,
		Id = 4,
		Limit = 180,
		Name = getI18NValue(180775694),
		DailyReward = {
			104,
			100,
			2,
			100
		}
	},
	[100] = {
		Time = 10,
		Id = 100,
		Limit = 10,
		Name = getI18NValue(180439871),
		DailyReward = {
			10006,
			1
		}
	}
}

setmetatable(CfgMonthCardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMonthCardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DailyGetPaypoint = 0,
		Name = "",
		Time = 0,
		Type = 0,
		Desc1 = "",
		Limit = 0,
		Desc = "",
		DailyReward = {},
		Reward = {}
	}
}

for i, data in pairs(CfgMonthCardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMonthCardTable
