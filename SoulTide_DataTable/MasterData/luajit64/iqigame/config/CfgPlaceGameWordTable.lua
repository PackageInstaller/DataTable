-- chunkname: @IQIGame\\Config\\CfgPlaceGameWordTable.lua

local CfgPlaceGameWordTable = {
	[101] = {
		Group = 1,
		Id = 101,
		ChatWord = {
			getI18NValue(180876215),
			getI18NValue(180876267),
			getI18NValue(180876268)
		}
	},
	[102] = {
		Group = 1,
		Id = 102,
		ChatWord = {
			getI18NValue(180876216),
			getI18NValue(180876269),
			getI18NValue(180876270)
		}
	},
	[103] = {
		Group = 1,
		Id = 103,
		ChatWord = {
			getI18NValue(180876217),
			getI18NValue(180876271),
			getI18NValue(180876272)
		}
	},
	[104] = {
		Group = 1,
		Id = 104,
		ChatWord = {
			getI18NValue(180876273),
			getI18NValue(180876274),
			getI18NValue(180876275)
		}
	},
	[105] = {
		Group = 1,
		Id = 105,
		ChatWord = {
			getI18NValue(180876276),
			getI18NValue(180876277)
		}
	},
	[106] = {
		Group = 1,
		Id = 106,
		ChatWord = {
			getI18NValue(180876278),
			getI18NValue(180876279),
			getI18NValue(180876280)
		}
	},
	[107] = {
		Group = 1,
		Id = 107,
		ChatWord = {
			getI18NValue(180876281),
			getI18NValue(180876282),
			getI18NValue(180876283)
		}
	},
	[108] = {
		Group = 1,
		Id = 108,
		ChatWord = {
			getI18NValue(180876284),
			getI18NValue(180876285),
			getI18NValue(180876286)
		}
	},
	[109] = {
		Group = 1,
		Id = 109,
		ChatWord = {
			getI18NValue(180876287),
			getI18NValue(180876288)
		}
	},
	[110] = {
		Group = 1,
		Id = 110,
		ChatWord = {
			getI18NValue(180876289),
			getI18NValue(180876290),
			getI18NValue(180876291)
		}
	},
	[111] = {
		Group = 1,
		Id = 111,
		ChatWord = {
			getI18NValue(180876292),
			getI18NValue(180876293),
			getI18NValue(180876294)
		}
	},
	[112] = {
		Group = 1,
		Id = 112,
		ChatWord = {
			getI18NValue(180876295),
			getI18NValue(180876296),
			getI18NValue(180876297)
		}
	},
	[113] = {
		Group = 1,
		Id = 113,
		ChatWord = {
			getI18NValue(180876298),
			getI18NValue(180876299)
		}
	},
	[114] = {
		Group = 1,
		Id = 114,
		ChatWord = {
			getI18NValue(180876300),
			getI18NValue(180876301)
		}
	},
	[115] = {
		Group = 1,
		Id = 115,
		ChatWord = {
			getI18NValue(180876302),
			getI18NValue(180876303)
		}
	},
	[116] = {
		Group = 1,
		Id = 116,
		ChatWord = {
			getI18NValue(180876304),
			getI18NValue(180876305)
		}
	},
	[117] = {
		Group = 1,
		Id = 117,
		ChatWord = {
			getI18NValue(180876306),
			getI18NValue(180876307),
			getI18NValue(180876308)
		}
	},
	[118] = {
		Group = 1,
		Id = 118,
		ChatWord = {
			getI18NValue(180876309),
			getI18NValue(180876310)
		}
	},
	[119] = {
		Group = 1,
		Id = 119,
		ChatWord = {
			getI18NValue(180876311),
			getI18NValue(180876312)
		}
	},
	[120] = {
		Group = 1,
		Id = 120,
		ChatWord = {
			getI18NValue(180876313),
			getI18NValue(180876314),
			getI18NValue(180876315)
		}
	}
}

setmetatable(CfgPlaceGameWordTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlaceGameWordTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ChatWord = {}
	}
}

for i, data in pairs(CfgPlaceGameWordTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlaceGameWordTable
