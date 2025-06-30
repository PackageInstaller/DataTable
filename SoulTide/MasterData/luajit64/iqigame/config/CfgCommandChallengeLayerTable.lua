-- chunkname: @IQIGame\\Config\\CfgCommandChallengeLayerTable.lua

local CfgCommandChallengeLayerTable = {
	[101] = {
		Sort = 1,
		Id = 101,
		MonserTeamId = 42410101,
		Lecture = getI18NValue(180765075),
		Name = getI18NValue(180765077),
		Des = getI18NValue(180765076),
		FormationInfo = {
			110001,
			110002
		},
		Reward = {
			2,
			100
		}
	},
	[102] = {
		Sort = 2,
		Id = 102,
		MonserTeamId = 42420101,
		Lecture = getI18NValue(180765078),
		Name = getI18NValue(180765080),
		Des = getI18NValue(180765079),
		FormationInfo = {
			110003
		},
		Reward = {
			2,
			100
		}
	},
	[103] = {
		Sort = 3,
		Id = 103,
		MonserTeamId = 42430101,
		Lecture = getI18NValue(180765081),
		Name = getI18NValue(180765083),
		Des = getI18NValue(180765082),
		FormationInfo = {
			110004
		},
		Reward = {
			2,
			100
		}
	},
	[104] = {
		Sort = 4,
		Id = 104,
		MonserTeamId = 42440101,
		Lecture = getI18NValue(180765084),
		Name = getI18NValue(180765086),
		Des = getI18NValue(180765085),
		FormationInfo = {
			110005
		},
		Reward = {
			2,
			100
		}
	},
	[105] = {
		Sort = 5,
		Id = 105,
		MonserTeamId = 42450101,
		Lecture = getI18NValue(180765972),
		Name = getI18NValue(180765973),
		Des = getI18NValue(180765980),
		FormationInfo = {
			110006
		},
		Reward = {
			2,
			100
		}
	},
	[106] = {
		Sort = 6,
		Id = 106,
		MonserTeamId = 42460101,
		Lecture = getI18NValue(180765974),
		Name = getI18NValue(180765975),
		Des = getI18NValue(180765981),
		FormationInfo = {
			110007
		},
		Reward = {
			2,
			100
		}
	},
	[107] = {
		Sort = 7,
		Id = 107,
		MonserTeamId = 42470101,
		Lecture = getI18NValue(180765976),
		Name = getI18NValue(180765977),
		Des = getI18NValue(180765982),
		FormationInfo = {
			110008,
			110009,
			110010
		},
		Reward = {
			2,
			100
		}
	},
	[108] = {
		Sort = 8,
		Id = 108,
		MonserTeamId = 42480101,
		Lecture = getI18NValue(180765978),
		Name = getI18NValue(180765979),
		Des = getI18NValue(180765983),
		FormationInfo = {
			110011
		},
		Reward = {
			2,
			100
		}
	}
}

setmetatable(CfgCommandChallengeLayerTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCommandChallengeLayerTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		Lecture = "",
		MonserTeamId = 0,
		Name = "",
		Des = "",
		FormationInfo = {},
		Reward = {}
	}
}

for i, data in pairs(CfgCommandChallengeLayerTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCommandChallengeLayerTable
