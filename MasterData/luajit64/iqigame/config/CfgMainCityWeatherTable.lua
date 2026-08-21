-- chunkname: @IQIGame\\Config\\CfgMainCityWeatherTable.lua

local CfgMainCityWeatherTable = {
	[1000] = {
		Icon = "/Common/ComImage/Common_Weather_Day_Cloud.png",
		Id = 1000,
		Name = getI18NValue(180082630),
		Weight = {
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10
		},
		Time = {
			{
				6,
				10
			},
			{
				10,
				18
			},
			{
				18,
				20
			},
			{
				20,
				24
			},
			{
				0,
				6
			}
		},
		Performance = {
			1001,
			1002,
			1003,
			1004,
			1005
		}
	},
	[2000] = {
		Icon = "/Common/ComImage/Common_Weather_Dusk_Cloud.png",
		Id = 2000,
		Name = getI18NValue(180082631),
		Weight = {
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10
		},
		Time = {
			{
				6,
				10
			},
			{
				10,
				18
			},
			{
				18,
				20
			},
			{
				20,
				24
			},
			{
				0,
				6
			}
		},
		Performance = {
			1011,
			1012,
			1013,
			1014,
			1015
		}
	},
	[3000] = {
		Icon = "/Common/ComImage/Common_Weather_Day_Rain.png",
		Id = 3000,
		Name = getI18NValue(180082632),
		Weight = {
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10,
			10
		},
		Time = {
			{
				6,
				10
			},
			{
				10,
				18
			},
			{
				18,
				20
			},
			{
				20,
				24
			},
			{
				0,
				6
			}
		},
		Performance = {
			1021,
			1022,
			1023,
			1024,
			1025
		}
	}
}

setmetatable(CfgMainCityWeatherTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMainCityWeatherTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Icon = "",
		Name = "",
		Time = {
			{},
			{},
			{},
			{},
			{}
		},
		Performance = {},
		Weight = {}
	}
}

for i, data in pairs(CfgMainCityWeatherTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMainCityWeatherTable
