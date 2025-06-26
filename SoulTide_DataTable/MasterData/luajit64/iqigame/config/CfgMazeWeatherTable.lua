-- chunkname: @IQIGame\\Config\\CfgMazeWeatherTable.lua

local CfgMazeWeatherTable = {
	[1000] = {
		EnvironmentalSound = 10101,
		Id = 1000,
		Icon = "/Buff/BattleBuffIcon_1010.png",
		Name = getI18NValue(180089909),
		Describe = getI18NValue(180089908),
		Buff = {
			51031000
		}
	},
	[1001] = {
		Id = 1001,
		Icon = "/Buff/BattleBuffIcon_1010.png",
		Name = getI18NValue(180089911),
		Describe = getI18NValue(180089910),
		Buff = {
			51031000
		}
	},
	[4000] = {
		Id = 4000,
		Icon = "/Buff/BattleBuffIcon_1010.png",
		Name = getI18NValue(180089913),
		Describe = getI18NValue(180089912),
		Buff = {
			51031000
		}
	},
	[5000] = {
		Id = 5000,
		Icon = "/Buff/BattleBuffIcon_1010.png",
		Name = getI18NValue(180437440),
		Buff = {
			85000005
		}
	},
	[5001] = {
		Id = 5001,
		Icon = "/Buff/BattleBuffIcon_1010.png",
		Name = getI18NValue(180437441),
		Buff = {
			85000006
		}
	},
	[6000] = {
		Id = 6000,
		Icon = "/Buff/BattleBuffIcon_1010.png",
		Name = getI18NValue(180926822),
		Describe = getI18NValue(180926821),
		Buff = {
			10000001
		}
	}
}

setmetatable(CfgMazeWeatherTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazeWeatherTable]")
	end
})

local defaultMetaTable = {
	__index = {
		EnvironmentalSound = 0,
		Describe = "",
		EffectId = 0,
		Name = "",
		Icon = "",
		Buff = {}
	}
}

for i, data in pairs(CfgMazeWeatherTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazeWeatherTable
