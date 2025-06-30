-- chunkname: @IQIGame\\Config\\CfgGuildMissionTable.lua

local CfgGuildMissionTable = {
	[101] = {
		DisplayOrder = 1,
		TargetType = 1,
		Group = 1,
		Id = 101,
		CompletePoint = 1,
		TargetNum = 40,
		Description = getI18NValue(180533793),
		Reward = {
			122,
			100
		}
	},
	[102] = {
		DisplayOrder = 2,
		TargetType = 1,
		Group = 1,
		Id = 102,
		CompletePoint = 1,
		TargetNum = 100,
		Description = getI18NValue(180533794),
		Reward = {
			122,
			100
		}
	},
	[103] = {
		DisplayOrder = 3,
		TargetType = 1,
		Group = 1,
		Id = 103,
		CompletePoint = 1,
		TargetNum = 180,
		Description = getI18NValue(180533795),
		Reward = {
			122,
			100
		}
	},
	[104] = {
		DisplayOrder = 4,
		TargetType = 1,
		Group = 1,
		Id = 104,
		CompletePoint = 1,
		TargetNum = 280,
		Description = getI18NValue(180534449),
		Reward = {
			122,
			100
		}
	},
	[105] = {
		DisplayOrder = 5,
		TargetType = 1,
		Group = 1,
		Id = 105,
		CompletePoint = 1,
		TargetNum = 400,
		Description = getI18NValue(180534450),
		Reward = {
			122,
			100
		}
	},
	[201] = {
		DisplayOrder = 1,
		TargetType = 2,
		Group = 2,
		Id = 201,
		CompletePoint = 1,
		TargetNum = 6,
		Description = getI18NValue(180533796),
		Reward = {
			122,
			100
		}
	},
	[202] = {
		DisplayOrder = 2,
		TargetType = 2,
		Group = 2,
		Id = 202,
		CompletePoint = 1,
		TargetNum = 15,
		Description = getI18NValue(180533797),
		Reward = {
			122,
			100
		}
	},
	[203] = {
		DisplayOrder = 3,
		TargetType = 2,
		Group = 2,
		Id = 203,
		CompletePoint = 1,
		TargetNum = 28,
		Description = getI18NValue(180533798),
		Reward = {
			122,
			100
		}
	},
	[204] = {
		DisplayOrder = 4,
		TargetType = 2,
		Group = 2,
		Id = 204,
		CompletePoint = 1,
		TargetNum = 42,
		Description = getI18NValue(180534451),
		Reward = {
			122,
			100
		}
	},
	[205] = {
		DisplayOrder = 5,
		TargetType = 2,
		Group = 2,
		Id = 205,
		CompletePoint = 1,
		TargetNum = 60,
		Description = getI18NValue(180534452),
		Reward = {
			122,
			100
		}
	},
	[301] = {
		DisplayOrder = 1,
		TargetType = 3,
		Group = 3,
		Id = 301,
		CompletePoint = 1,
		TargetNum = 80,
		Description = getI18NValue(180533799),
		Reward = {
			122,
			100
		}
	},
	[302] = {
		DisplayOrder = 2,
		TargetType = 3,
		Group = 3,
		Id = 302,
		CompletePoint = 1,
		TargetNum = 180,
		Description = getI18NValue(180533800),
		Reward = {
			122,
			100
		}
	},
	[303] = {
		DisplayOrder = 3,
		TargetType = 3,
		Group = 3,
		Id = 303,
		CompletePoint = 1,
		TargetNum = 330,
		Description = getI18NValue(180533801),
		Reward = {
			122,
			100
		}
	},
	[304] = {
		DisplayOrder = 4,
		TargetType = 3,
		Group = 3,
		Id = 304,
		CompletePoint = 1,
		TargetNum = 520,
		Description = getI18NValue(180534453),
		Reward = {
			122,
			100
		}
	},
	[305] = {
		DisplayOrder = 5,
		TargetType = 3,
		Group = 3,
		Id = 305,
		CompletePoint = 1,
		TargetNum = 750,
		Description = getI18NValue(180534454),
		Reward = {
			122,
			100
		}
	},
	[401] = {
		DisplayOrder = 1,
		TargetType = 4,
		Group = 4,
		Id = 401,
		CompletePoint = 1,
		TargetNum = 1500,
		Description = getI18NValue(180533802),
		Reward = {
			122,
			100
		}
	},
	[402] = {
		DisplayOrder = 2,
		TargetType = 4,
		Group = 4,
		Id = 402,
		CompletePoint = 1,
		TargetNum = 3800,
		Description = getI18NValue(180533803),
		Reward = {
			122,
			100
		}
	},
	[403] = {
		DisplayOrder = 3,
		TargetType = 4,
		Group = 4,
		Id = 403,
		CompletePoint = 1,
		TargetNum = 6800,
		Description = getI18NValue(180533804),
		Reward = {
			122,
			100
		}
	},
	[404] = {
		DisplayOrder = 4,
		TargetType = 4,
		Group = 4,
		Id = 404,
		CompletePoint = 1,
		TargetNum = 10000,
		Description = getI18NValue(180534455),
		Reward = {
			122,
			100
		}
	},
	[405] = {
		DisplayOrder = 5,
		TargetType = 4,
		Group = 4,
		Id = 405,
		CompletePoint = 1,
		TargetNum = 15000,
		Description = getI18NValue(180534456),
		Reward = {
			122,
			100
		}
	}
}

setmetatable(CfgGuildMissionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildMissionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Description = "",
		DisplayOrder = 0,
		TargetType = 0,
		Group = 0,
		CompletePoint = 0,
		TargetNum = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgGuildMissionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildMissionTable
