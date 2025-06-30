-- chunkname: @IQIGame\\Config\\CfgTownAlienEventBookTable.lua

local CfgTownAlienEventBookTable = {
	[600000] = {
		Id = 600000,
		Name = getI18NValue(180131408),
		EngName = getI18NValue(180131407),
		CollectTime = {
			20,
			45,
			68
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		}
	},
	[600001] = {
		Id = 600001,
		Name = getI18NValue(180131410),
		EngName = getI18NValue(180131409),
		CollectTime = {
			15,
			30,
			45
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		}
	},
	[600002] = {
		Id = 600002,
		Name = getI18NValue(180131412),
		EngName = getI18NValue(180131411),
		CollectTime = {
			30,
			70,
			107
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		}
	}
}

setmetatable(CfgTownAlienEventBookTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTownAlienEventBookTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		EngName = "",
		ButtonImage = "",
		CollectTime = {
			0,
			0,
			0
		},
		CollectReward = {
			{},
			{},
			{}
		}
	}
}

for i, data in pairs(CfgTownAlienEventBookTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTownAlienEventBookTable
