-- chunkname: @IQIGame\\Config\\CfgOptionalGiftPackTable.lua

local CfgOptionalGiftPackTable = {
	{
		ChoicesNum = 1,
		Id = 1,
		Reward = {
			10101,
			10102,
			10103,
			10104,
			10105,
			10106,
			10107,
			10108,
			10109,
			10110,
			10111,
			10112,
			10113,
			10114,
			10117,
			10118,
			10119,
			10120
		},
		Num = {
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		}
	},
	{
		ChoicesNum = 2,
		Id = 2,
		Reward = {
			10101,
			10102,
			10103,
			10104,
			10105,
			10106,
			10107,
			10108,
			10109,
			10110,
			10111,
			10112,
			10113,
			0,
			0,
			0,
			0,
			0
		},
		Num = {
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			0,
			0,
			0,
			0,
			0
		}
	},
	[20205] = {
		ChoicesNum = 1,
		Id = 20205,
		Reward = {
			10711,
			10712,
			10713,
			10714,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		Num = {
			1,
			1,
			1,
			1,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[320] = {
		ChoicesNum = 1,
		Id = 320,
		Reward = {
			314,
			315,
			316,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		Num = {
			1,
			1,
			1,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	}
}

setmetatable(CfgOptionalGiftPackTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgOptionalGiftPackTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ChoicesNum = 0,
		Num = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		Reward = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	}
}

for i, data in pairs(CfgOptionalGiftPackTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgOptionalGiftPackTable
