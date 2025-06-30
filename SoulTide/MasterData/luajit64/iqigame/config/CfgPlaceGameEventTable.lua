-- chunkname: @IQIGame\\Config\\CfgPlaceGameEventTable.lua

local CfgPlaceGameEventTable = {
	[1001] = {
		Group = 1,
		Id = 1001,
		Parameter = 51000170,
		UnlockTower = 1,
		Name = getI18NValue(180846523),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868576)
	},
	[1002] = {
		Group = 1,
		PreStory = 1001,
		Id = 1002,
		Parameter = 51000300,
		UnlockTower = 9,
		Name = getI18NValue(180846524),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868577)
	},
	[1003] = {
		Group = 1,
		PreStory = 1002,
		Id = 1003,
		Parameter = 51000460,
		UnlockTower = 17,
		Name = getI18NValue(180846525),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868578)
	},
	[1004] = {
		Group = 1,
		PreStory = 1003,
		Id = 1004,
		Parameter = 51000600,
		UnlockTower = 25,
		Name = getI18NValue(180846526),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868579)
	},
	[1005] = {
		Group = 1,
		PreStory = 1004,
		Id = 1005,
		Parameter = 51000750,
		UnlockTower = 33,
		Name = getI18NValue(180846527),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868580)
	},
	[1006] = {
		Group = 1,
		PreStory = 1005,
		Id = 1006,
		Parameter = 51000890,
		UnlockTower = 41,
		Name = getI18NValue(180846528),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868581)
	},
	[1007] = {
		Group = 1,
		PreStory = 1006,
		Id = 1007,
		Parameter = 51001020,
		UnlockTower = 49,
		Name = getI18NValue(180846529),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868582)
	},
	[1008] = {
		Group = 1,
		PreStory = 1007,
		Id = 1008,
		Parameter = 51001180,
		UnlockTower = 57,
		Name = getI18NValue(180846530),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180868583)
	},
	[1009] = {
		Group = 1,
		PreStory = 1008,
		Id = 1009,
		Parameter = 51001320,
		UnlockTower = 65,
		Name = getI18NValue(180876575),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180876574)
	},
	[1010] = {
		Group = 1,
		PreStory = 1009,
		Id = 1010,
		Parameter = 51001480,
		UnlockTower = 73,
		Name = getI18NValue(180876577),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180876576)
	},
	[1011] = {
		Group = 1,
		PreStory = 1010,
		Id = 1011,
		Parameter = 51001650,
		UnlockTower = 80,
		Name = getI18NValue(180876579),
		DialogReward = {
			2,
			100
		},
		Title = getI18NValue(180876578)
	}
}

setmetatable(CfgPlaceGameEventTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlaceGameEventTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Name = "",
		Title = "",
		PreStory = 0,
		Parameter = 0,
		UnlockTower = 0,
		DialogReward = {}
	}
}

for i, data in pairs(CfgPlaceGameEventTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlaceGameEventTable
