-- chunkname: @IQIGame\\Config\\CfgSkillRangeTable.lua

local CfgSkillRangeTable = {
	[100] = {
		Id = 100,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_100.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			44
		}
	},
	[101] = {
		Id = 101,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_101.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			11,
			12,
			13,
			14,
			15,
			21,
			22,
			23,
			24,
			25,
			31,
			32,
			33,
			34,
			35,
			41,
			42,
			43,
			44,
			45,
			51,
			52,
			53,
			54,
			55
		}
	},
	[102] = {
		Id = 102,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_102.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			13,
			23,
			33,
			43,
			53,
			31,
			32,
			34,
			35
		}
	},
	[103] = {
		Id = 103,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_103.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			46,
			45,
			44,
			43,
			42
		}
	},
	[104] = {
		Id = 104,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_104.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			31,
			32,
			33,
			34,
			35
		}
	},
	[105] = {
		Id = 105,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_105.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			33,
			34
		}
	},
	[106] = {
		Id = 106,
		SkillRangeImg = "/Icon/SkillRangeImg/SkillRange_Icon_106.png",
		IsNotVisibleInSelect = false,
		PositionParam = {
			33,
			14,
			24,
			34,
			44,
			54
		}
	},
	[200] = {
		Id = 200,
		IsNotVisibleInSelect = true,
		PositionParam = {
			33
		}
	}
}

setmetatable(CfgSkillRangeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSkillRangeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		SkillRangeImg = "",
		IsNotVisibleInSelect = false,
		PositionParam = {}
	}
}

for i, data in pairs(CfgSkillRangeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSkillRangeTable
