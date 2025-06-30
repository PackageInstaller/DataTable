-- chunkname: @IQIGame\\Config\\CfgRefundsGiftPackTable.lua

local CfgRefundsGiftPackTable = {
	{
		Id = 1,
		Name = getI18NValue(180498862),
		RefundsGiftPackRewards = {
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
			14
		},
		Time = {
			0,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200
		}
	},
	{
		Id = 2,
		Name = getI18NValue(180836537),
		RefundsGiftPackRewards = {
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
			14
		},
		Time = {
			0,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200
		}
	},
	{
		Id = 3,
		Name = getI18NValue(180931694),
		RefundsGiftPackRewards = {
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
			14
		},
		Time = {
			0,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200,
			79200
		}
	}
}

setmetatable(CfgRefundsGiftPackTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRefundsGiftPackTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		RefundsGiftPackRewards = {},
		Time = {}
	}
}

for i, data in pairs(CfgRefundsGiftPackTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRefundsGiftPackTable
