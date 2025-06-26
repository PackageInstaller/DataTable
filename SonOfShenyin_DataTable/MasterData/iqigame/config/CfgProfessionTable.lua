-- chunkname: @IQIGame\\Config\\CfgProfessionTable.lua

local CfgProfessionTable = {
	{
		Value2 = 1,
		Value1 = 1,
		Id = 1,
		Att = 4,
		Move = 1,
		Name = getI18NValue(180005369),
		Description = getI18NValue(180005368),
		Restraint = {
			1
		},
		HalfRestraint = {
			1
		}
	},
	{
		Value2 = 1,
		Value1 = 1,
		Id = 2,
		Att = 4,
		Move = 1,
		Name = getI18NValue(180005371),
		Description = getI18NValue(180005370),
		Restraint = {
			1
		},
		HalfRestraint = {
			1
		}
	},
	{
		Value2 = 1,
		Value1 = 1,
		Id = 3,
		Att = 4,
		Move = 2,
		Name = getI18NValue(180005373),
		Description = getI18NValue(180005372),
		Restraint = {
			1
		},
		HalfRestraint = {
			1
		}
	},
	{
		Value2 = 1,
		Value1 = 1,
		Id = 4,
		Att = 4,
		Move = 3,
		Name = getI18NValue(180005375),
		Description = getI18NValue(180005374),
		Restraint = {
			1
		},
		HalfRestraint = {
			1
		}
	},
	{
		Value2 = 1,
		Value1 = 1,
		Id = 5,
		Att = 4,
		Move = 3,
		Name = getI18NValue(180041479),
		Description = getI18NValue(180041478),
		Restraint = {
			1
		},
		HalfRestraint = {
			1
		}
	},
	{
		Value2 = 1,
		Value1 = 1,
		Id = 6,
		Att = 4,
		Move = 3,
		Name = getI18NValue(180041481),
		Description = getI18NValue(180041480),
		Restraint = {
			1
		},
		HalfRestraint = {
			1
		}
	}
}

setmetatable(CfgProfessionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgProfessionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Description = "",
		Value2 = 0,
		Name = "",
		Value1 = 0,
		Att = 0,
		Move = 0,
		HalfRestraint = {},
		Skills = {},
		Restraint = {}
	}
}

for i, data in pairs(CfgProfessionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgProfessionTable
