-- chunkname: @IQIGame\\Config\\CfgGuildTrainingPointRewardTable.lua

local CfgGuildTrainingPointRewardTable = {
	[101] = {
		NeedPoints = 10,
		Sort = 1,
		Id = 101,
		Stage = getI18NValue(180825889),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[102] = {
		NeedPoints = 20,
		Sort = 2,
		Id = 102,
		Stage = getI18NValue(180825890),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[103] = {
		NeedPoints = 50,
		Sort = 3,
		Id = 103,
		Stage = getI18NValue(180825891),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[104] = {
		NeedPoints = 100,
		Sort = 4,
		Id = 104,
		Stage = getI18NValue(180825892),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[105] = {
		NeedPoints = 200,
		Sort = 5,
		Id = 105,
		Stage = getI18NValue(180825893),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[106] = {
		NeedPoints = 500,
		Sort = 6,
		Id = 106,
		Stage = getI18NValue(180825894),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[107] = {
		NeedPoints = 1000,
		Sort = 7,
		Id = 107,
		Stage = getI18NValue(180825895),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[108] = {
		NeedPoints = 1600,
		Sort = 8,
		Id = 108,
		Stage = getI18NValue(180825896),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[109] = {
		NeedPoints = 2300,
		Sort = 9,
		Id = 109,
		Stage = getI18NValue(180825897),
		Reward = {
			122,
			200,
			11502,
			15
		}
	},
	[110] = {
		NeedPoints = 3000,
		Sort = 10,
		Id = 110,
		Stage = getI18NValue(180825898),
		Reward = {
			122,
			200,
			11502,
			15
		}
	}
}

setmetatable(CfgGuildTrainingPointRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildTrainingPointRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		NeedPoints = 0,
		Stage = "",
		Reward = {}
	}
}

for i, data in pairs(CfgGuildTrainingPointRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildTrainingPointRewardTable
