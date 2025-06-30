-- chunkname: @IQIGame\\Config\\CfgHeroScreenTable.lua

local CfgHeroScreenTable = {
	[100] = {
		ID = 100,
		TipsID = 100,
		TextName = getI18NValue(180037714)
	},
	[101] = {
		LastID = 100,
		Checked = true,
		RelationID = -1,
		ID = 101,
		Index = 1,
		TipsID = 101,
		TextName = getI18NValue(180037715)
	},
	[102] = {
		LastID = 100,
		RelationID = 1,
		Index = 2,
		ID = 102,
		TipsID = 102,
		TextName = getI18NValue(180037716)
	},
	[103] = {
		LastID = 100,
		RelationID = 2,
		Index = 3,
		ID = 103,
		TipsID = 103,
		TextName = getI18NValue(180037717)
	},
	[104] = {
		LastID = 100,
		RelationID = 3,
		Index = 4,
		ID = 104,
		TipsID = 104,
		TextName = getI18NValue(180037718)
	},
	[105] = {
		LastID = 100,
		RelationID = 4,
		Index = 5,
		ID = 105,
		TipsID = 105,
		TextName = getI18NValue(180037719)
	},
	[120] = {
		ID = 120,
		TipsID = 120,
		TextName = getI18NValue(180037720)
	},
	[121] = {
		LastID = 120,
		Checked = true,
		RelationID = -1,
		ID = 121,
		Index = 1,
		TipsID = 121,
		TextName = getI18NValue(180037721)
	},
	[122] = {
		LastID = 120,
		RelationID = 1,
		Index = 2,
		ID = 122,
		TipsID = 122,
		TextName = getI18NValue(180037722)
	},
	[124] = {
		LastID = 120,
		RelationID = 3,
		Index = 3,
		ID = 124,
		TipsID = 124,
		TextName = getI18NValue(180037724)
	},
	[125] = {
		LastID = 120,
		RelationID = 4,
		Index = 4,
		ID = 125,
		TipsID = 125,
		TextName = getI18NValue(180037725)
	},
	[126] = {
		LastID = 120,
		RelationID = 5,
		Index = 5,
		ID = 126,
		TipsID = 126,
		TextName = getI18NValue(180037726)
	},
	[150] = {
		ID = 150,
		TipsID = 150,
		TextName = getI18NValue(180037728)
	},
	[151] = {
		LastID = 150,
		Checked = true,
		RelationID = -1,
		ID = 151,
		Index = 1,
		TipsID = 151,
		TextName = getI18NValue(180037729)
	},
	[152] = {
		LastID = 150,
		Index = 2,
		ID = 152,
		TipsID = 152,
		TextName = getI18NValue(180037730)
	},
	[153] = {
		LastID = 150,
		RelationID = 1,
		Index = 3,
		ID = 153,
		TipsID = 153,
		TextName = getI18NValue(180037731)
	},
	[154] = {
		LastID = 150,
		RelationID = 2,
		Index = 4,
		ID = 154,
		TipsID = 154,
		TextName = getI18NValue(180037732)
	},
	[155] = {
		LastID = 150,
		RelationID = 3,
		Index = 5,
		ID = 155,
		TipsID = 155,
		TextName = getI18NValue(180037733)
	},
	[156] = {
		LastID = 150,
		RelationID = 4,
		Index = 6,
		ID = 156,
		TipsID = 156,
		TextName = getI18NValue(180037734)
	},
	[157] = {
		LastID = 150,
		RelationID = 5,
		Index = 7,
		ID = 157,
		TipsID = 157,
		TextName = getI18NValue(180037735)
	},
	[158] = {
		LastID = 150,
		RelationID = 6,
		Index = 8,
		ID = 158,
		TipsID = 158,
		TextName = getI18NValue(180037736)
	},
	[159] = {
		LastID = 150,
		RelationID = 7,
		Index = 9,
		ID = 159,
		TipsID = 159,
		TextName = getI18NValue(180037737)
	},
	[160] = {
		LastID = 150,
		RelationID = 8,
		Index = 10,
		ID = 160,
		TipsID = 160,
		TextName = getI18NValue(180037738)
	},
	[161] = {
		LastID = 150,
		RelationID = 9,
		Index = 11,
		ID = 161,
		TipsID = 161,
		TextName = getI18NValue(180037739)
	},
	[162] = {
		LastID = 150,
		RelationID = 10,
		Index = 12,
		ID = 162,
		TipsID = 162,
		TextName = getI18NValue(180037740)
	}
}

setmetatable(CfgHeroScreenTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHeroScreenTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RelationID = 0,
		LastID = 0,
		Checked = false,
		TextName = "",
		Index = 0,
		TipsID = 0
	}
}

for i, data in pairs(CfgHeroScreenTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHeroScreenTable
