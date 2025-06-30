-- chunkname: @IQIGame\\Config\\CfgCardJackpotGroupTable.lua

local CfgCardJackpotGroupTable = {
	[50310001] = {
		GuaranteeTime = 5,
		Id = 50310001,
		MustGuarantee = 9,
		GuaranteePerAdd = 2500
	},
	[50310002] = {
		GuaranteePer = 160,
		GuaranteeTime = 50,
		GuaranteePerAdd = 500,
		Id = 50310002,
		MustGuarantee = 60
	},
	[50310003] = {
		GuaranteePer = 160,
		GuaranteeTime = 50,
		GuaranteePerAdd = 500,
		Id = 50310003,
		MustGuarantee = 60
	},
	[50310004] = {
		GuaranteePer = 160,
		GuaranteeTime = 50,
		UpGuaranteeTime = 100,
		GuaranteePerAdd = 500,
		Id = 50310004,
		UpMustGuarantee = 110,
		MustGuarantee = 60,
		UpGuaranteePerAdd = 500
	},
	[50310005] = {
		GuaranteePer = 160,
		GuaranteeTime = 50,
		UpGuaranteeTime = 100,
		GuaranteePerAdd = 500,
		Id = 50310005,
		UpMustGuarantee = 110,
		MustGuarantee = 60,
		UpGuaranteePerAdd = 500
	},
	[50310006] = {
		GuaranteePer = 160,
		GuaranteeTime = 50,
		UpGuaranteeTime = 100,
		GuaranteePerAdd = 500,
		Id = 50310006,
		UpMustGuarantee = 110,
		MustGuarantee = 60,
		UpGuaranteePerAdd = 500
	},
	[50310101] = {
		GuaranteePer = 100,
		GuaranteeTime = 60,
		GuaranteePerAdd = 30,
		Id = 50310101,
		MustGuarantee = 80
	}
}

setmetatable(CfgCardJackpotGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCardJackpotGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		GuaranteeTime = 0,
		GuaranteePer = 0,
		GuaranteePerAdd = 0,
		UpGuaranteeTime = 0,
		UpGuaranteePerAdd = 0,
		UPGuaranteePer = 0,
		UpMustGuarantee = 0,
		MustGuarantee = 0
	}
}

for i, data in pairs(CfgCardJackpotGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCardJackpotGroupTable
