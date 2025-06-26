-- chunkname: @IQIGame\\Config\\CfgOperateEventsControlTable.lua

local CfgOperateEventsControlTable = {
	[211001001] = {
		Id = 211001001,
		FunctionType = 30010069,
		Type = 1,
		Name = getI18NValue(180095703)
	},
	[211001002] = {
		Id = 211001002,
		FunctionType = 30010070,
		Type = 2,
		Name = getI18NValue(180095704)
	},
	[211001003] = {
		Function = 10201006,
		Type = 3,
		Id = 211001003,
		FunctionType = 30010071,
		Name = getI18NValue(180135525)
	},
	[211001004] = {
		Id = 211001004,
		FunctionType = 30010072,
		Type = 4,
		Name = getI18NValue(180136455)
	},
	[211104001] = {
		Id = 211104001,
		FunctionType = 30010073,
		Type = 5,
		Name = getI18NValue(180142202)
	},
	[211202001] = {
		Id = 211202001,
		FunctionType = 30010074,
		Type = 6,
		Name = getI18NValue(180149046)
	},
	[211001005] = {
		Id = 211001005,
		FunctionType = 30010075,
		Type = 7,
		Name = getI18NValue(180146965)
	},
	[211222001] = {
		Id = 211222001,
		FunctionType = 30010076,
		Type = 8,
		Name = getI18NValue(180149047)
	},
	[211222002] = {
		Id = 211222002,
		FunctionType = 30010078,
		Type = 9,
		Name = getI18NValue(180150114)
	},
	[211222003] = {
		Id = 211222003,
		FunctionType = 30010079,
		Type = 10,
		Name = getI18NValue(180150115)
	},
	[220127001] = {
		Id = 220127001,
		FunctionType = 30010079,
		Type = 11,
		Name = getI18NValue(180245857)
	},
	[220127002] = {
		Id = 220127002,
		FunctionType = 30010079,
		Type = 12,
		Name = getI18NValue(180247372)
	},
	[220127003] = {
		Id = 220127003,
		FunctionType = 30010081,
		Type = 13,
		Name = getI18NValue(180248319)
	},
	[220127004] = {
		Id = 220127004,
		FunctionType = 30010082,
		Type = 14,
		Name = getI18NValue(180249932)
	},
	[220331001] = {
		Id = 220331001,
		FunctionType = 30010086,
		Type = 15,
		Name = getI18NValue(180267985)
	},
	[220331002] = {
		Id = 220331002,
		FunctionType = 30010082,
		Type = 16,
		Name = getI18NValue(180268094)
	},
	[220428001] = {
		Id = 220428001,
		FunctionType = 30010089,
		Type = 17,
		Name = getI18NValue(180272777)
	},
	[220630001] = {
		Id = 220630001,
		FunctionType = 30010061,
		Type = 18,
		Name = getI18NValue(180477543)
	},
	[230100119] = {
		Id = 230100119,
		FunctionType = 30010098,
		Type = 19,
		Name = getI18NValue(180477708)
	},
	[230119001] = {
		Id = 230119001,
		FunctionType = 30010099,
		Type = 20,
		Name = getI18NValue(180498838)
	},
	[230223001] = {
		Id = 230223001,
		FunctionType = 30010101,
		Type = 21,
		Name = getI18NValue(180505145)
	}
}

setmetatable(CfgOperateEventsControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgOperateEventsControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		Function = 0,
		FunctionType = 0,
		Type = 0
	}
}

for i, data in pairs(CfgOperateEventsControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgOperateEventsControlTable
