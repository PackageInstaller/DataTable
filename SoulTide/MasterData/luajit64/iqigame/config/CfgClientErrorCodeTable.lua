-- chunkname: @IQIGame\\Config\\CfgClientErrorCodeTable.lua

local CfgClientErrorCodeTable = {
	[0] = {
		Id = 0,
		Describe = getI18NValue(180004035)
	},
	[5001] = {
		Id = 5001,
		Describe = getI18NValue(180004036)
	},
	[5002] = {
		Id = 5002,
		Describe = getI18NValue(180004037)
	},
	[5003] = {
		Id = 5003,
		Describe = getI18NValue(180004038)
	},
	[5004] = {
		Id = 5004,
		Describe = getI18NValue(180004039)
	},
	[5005] = {
		Id = 5005,
		Describe = getI18NValue(180004040)
	},
	[5006] = {
		Id = 5006,
		Describe = getI18NValue(180004041)
	},
	[5007] = {
		Id = 5007,
		Describe = getI18NValue(180004042)
	},
	[5008] = {
		Id = 5008,
		Describe = getI18NValue(180004043)
	},
	[5009] = {
		Id = 5009,
		Describe = getI18NValue(180004044)
	},
	[5010] = {
		Id = 5010,
		Describe = getI18NValue(180004045)
	},
	[5011] = {
		Id = 5011,
		Describe = getI18NValue(180004046)
	},
	[5012] = {
		Id = 5012,
		Describe = getI18NValue(180004047)
	},
	[5013] = {
		Id = 5013,
		Describe = getI18NValue(180004048)
	},
	[5014] = {
		Id = 5014,
		Describe = getI18NValue(180004049)
	},
	[5018] = {
		Id = 5018,
		Describe = getI18NValue(180004050)
	},
	[5019] = {
		Id = 5019,
		Describe = getI18NValue(180004051)
	},
	[5020] = {
		Id = 5020,
		Describe = getI18NValue(180004052)
	},
	[5021] = {
		Id = 5021,
		Describe = getI18NValue(180004053)
	},
	[5022] = {
		Id = 5022,
		Describe = getI18NValue(180004054)
	},
	[5025] = {
		Id = 5025,
		Describe = getI18NValue(180004055)
	},
	[5026] = {
		Id = 5026,
		Describe = getI18NValue(180004056)
	},
	[5029] = {
		Id = 5029,
		Describe = getI18NValue(180004057)
	},
	[5030] = {
		Id = 5030,
		Describe = getI18NValue(180004058)
	},
	[5031] = {
		Id = 5031,
		Describe = getI18NValue(180004059)
	},
	[5032] = {
		Id = 5032,
		Describe = getI18NValue(180004060)
	},
	[5033] = {
		Id = 5033,
		Describe = getI18NValue(180004061)
	}
}

setmetatable(CfgClientErrorCodeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgClientErrorCodeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Describe = ""
	}
}

for i, data in pairs(CfgClientErrorCodeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgClientErrorCodeTable
