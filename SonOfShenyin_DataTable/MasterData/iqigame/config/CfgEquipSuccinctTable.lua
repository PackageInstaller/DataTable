-- chunkname: @IQIGame\\Config\\CfgEquipSuccinctTable.lua

local CfgEquipSuccinctTable = {
	[1001] = {
		AttrStone = 270,
		Id = 1001,
		Attr = 41,
		AttrMax = 300,
		AttrName = getI18NValue(180268581),
		AttrQuality = {
			90,
			120,
			180,
			240,
			300
		}
	},
	[1002] = {
		AttrStone = 45,
		Id = 1002,
		Attr = 42,
		AttrMax = 50,
		AttrName = getI18NValue(180268582),
		AttrQuality = {
			15,
			20,
			30,
			40,
			50
		}
	},
	[1003] = {
		AttrStone = 18,
		Id = 1003,
		Attr = 43,
		AttrMax = 20,
		AttrName = getI18NValue(180268583),
		AttrQuality = {
			6,
			8,
			12,
			16,
			20
		}
	},
	[1004] = {
		AttrStone = 4.5,
		Id = 1004,
		Attr = 21,
		AttrMax = 0.05,
		AttrName = getI18NValue(180268584),
		AttrQuality = {
			1.5,
			2,
			3,
			4,
			5
		}
	},
	[1005] = {
		AttrStone = 4.5,
		Id = 1005,
		Attr = 22,
		AttrMax = 0.05,
		AttrName = getI18NValue(180268585),
		AttrQuality = {
			1.5,
			2,
			3,
			4,
			5
		}
	},
	[1006] = {
		AttrStone = 4.5,
		Id = 1006,
		Attr = 23,
		AttrMax = 0.05,
		AttrName = getI18NValue(180268586),
		AttrQuality = {
			1.5,
			2,
			3,
			4,
			5
		}
	},
	[1007] = {
		AttrStone = 4.5,
		Id = 1007,
		Attr = 61,
		AttrMax = 0.05,
		AttrName = getI18NValue(180268587),
		AttrQuality = {
			1.5,
			2,
			3,
			4,
			5
		}
	},
	[1008] = {
		AttrStone = 9,
		Id = 1008,
		Attr = 81,
		AttrMax = 0.1,
		AttrName = getI18NValue(180268588),
		AttrQuality = {
			3,
			4,
			6,
			8,
			10
		}
	},
	[1009] = {
		AttrStone = 3.6,
		Id = 1009,
		Attr = 79,
		AttrMax = 0.04,
		AttrName = getI18NValue(180268589),
		AttrQuality = {
			1.2,
			1.6,
			2.4,
			3.2,
			4
		}
	},
	[1010] = {
		AttrStone = 4.5,
		Id = 1010,
		Attr = 80,
		AttrMax = 0.05,
		AttrName = getI18NValue(180268590),
		AttrQuality = {
			1.5,
			2,
			3,
			4,
			5
		}
	}
}

setmetatable(CfgEquipSuccinctTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEquipSuccinctTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AttrMin = 0,
		AttrStone = 0,
		AttrName = "",
		Attr = 0,
		AttrMax = 0,
		AttrQuality = {}
	}
}

for i, data in pairs(CfgEquipSuccinctTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEquipSuccinctTable
