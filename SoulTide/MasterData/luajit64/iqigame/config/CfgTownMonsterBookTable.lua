-- chunkname: @IQIGame\\Config\\CfgTownMonsterBookTable.lua

local CfgTownMonsterBookTable = {
	[101] = {
		Id = 101,
		Name = getI18NValue(180132963),
		EngName = getI18NValue(180132962)
	},
	[102] = {
		Id = 102,
		Name = getI18NValue(180132965),
		EngName = getI18NValue(180132964)
	},
	[103] = {
		Id = 103,
		Name = getI18NValue(180132967),
		EngName = getI18NValue(180132966)
	},
	[104] = {
		Id = 104,
		Name = getI18NValue(180132969),
		EngName = getI18NValue(180132968)
	},
	[105] = {
		Id = 105,
		Name = getI18NValue(180268157),
		EngName = getI18NValue(180268156)
	},
	[106] = {
		Id = 106,
		Name = getI18NValue(180477490),
		EngName = getI18NValue(180477489)
	},
	[107] = {
		Id = 107,
		Name = getI18NValue(180776282),
		EngName = getI18NValue(180776281)
	},
	[200] = {
		Id = 200,
		Name = getI18NValue(180132971),
		EngName = getI18NValue(180132970)
	},
	[300] = {
		Id = 300,
		Name = getI18NValue(180132973),
		EngName = getI18NValue(180132972)
	}
}

setmetatable(CfgTownMonsterBookTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTownMonsterBookTable]")
	end
})

local defaultMetaTable = {
	__index = {
		EngName = "",
		Name = ""
	}
}

for i, data in pairs(CfgTownMonsterBookTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTownMonsterBookTable
