-- chunkname: @IQIGame\\Config\\CfgLoginErrorCodeTable.lua

local CfgLoginErrorCodeTable = {
	[100001] = {
		Id = 100001,
		Describe = getI18NValue(180082261)
	},
	[100002] = {
		Id = 100002,
		Describe = getI18NValue(180082262)
	},
	[110001] = {
		Id = 110001,
		Describe = getI18NValue(180082263)
	},
	[110002] = {
		Id = 110002,
		Describe = getI18NValue(180082264)
	},
	[110003] = {
		Id = 110003,
		Describe = getI18NValue(180082265)
	},
	[110004] = {
		Id = 110004,
		Describe = getI18NValue(180082266)
	},
	[110005] = {
		Id = 110005,
		Describe = getI18NValue(180082267)
	},
	[110006] = {
		Id = 110006,
		Describe = getI18NValue(180082268)
	},
	[110007] = {
		Id = 110007,
		Describe = getI18NValue(180082269)
	},
	[110008] = {
		Id = 110008,
		Describe = getI18NValue(180082270)
	},
	[110009] = {
		Id = 110009,
		Describe = getI18NValue(180082271)
	},
	[110010] = {
		Id = 110010,
		Describe = getI18NValue(180082272)
	},
	[110011] = {
		Id = 110011,
		Describe = getI18NValue(180082273)
	},
	[110013] = {
		Id = 110013,
		Describe = getI18NValue(180082274)
	},
	[110014] = {
		Id = 110014,
		Describe = getI18NValue(180082275)
	},
	[110015] = {
		Id = 110015,
		Describe = getI18NValue(180082276)
	},
	[110016] = {
		Id = 110016,
		Describe = getI18NValue(180082277)
	},
	[110017] = {
		Id = 110017,
		Describe = getI18NValue(180082278)
	},
	[110018] = {
		Id = 110018,
		Describe = getI18NValue(180082279)
	},
	[120001] = {
		Id = 120001,
		Describe = getI18NValue(180082280)
	},
	[120002] = {
		Id = 120002,
		Describe = getI18NValue(180082281)
	},
	[120003] = {
		Id = 120003,
		Describe = getI18NValue(180082282)
	},
	[120004] = {
		Id = 120004,
		Describe = getI18NValue(180082283)
	},
	[120005] = {
		Id = 120005,
		Describe = getI18NValue(180082284)
	},
	[120006] = {
		Id = 120006,
		Describe = getI18NValue(180082285)
	},
	[120007] = {
		Id = 120007,
		Describe = getI18NValue(180082286)
	},
	[120008] = {
		Id = 120008,
		Describe = getI18NValue(180082287)
	},
	[120009] = {
		Id = 120009,
		Describe = getI18NValue(180082288)
	},
	[120010] = {
		Id = 120010,
		Describe = getI18NValue(180082289)
	},
	[120011] = {
		Id = 120011,
		Describe = getI18NValue(180082290)
	},
	[120012] = {
		Id = 120012,
		Describe = getI18NValue(180082291)
	},
	[120013] = {
		Id = 120013,
		Describe = getI18NValue(180082292)
	},
	[120014] = {
		Id = 120014,
		Describe = getI18NValue(180082293)
	},
	[120015] = {
		Id = 120015,
		Describe = getI18NValue(180082294)
	}
}

setmetatable(CfgLoginErrorCodeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLoginErrorCodeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Describe = ""
	}
}

for i, data in pairs(CfgLoginErrorCodeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLoginErrorCodeTable
