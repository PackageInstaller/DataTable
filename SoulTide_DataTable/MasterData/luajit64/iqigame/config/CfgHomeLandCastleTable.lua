-- chunkname: @IQIGame\\Config\\CfgHomeLandCastleTable.lua

local CfgHomeLandCastleTable = {
	{
		Id = 1,
		CastleName = getI18NValue(180079500)
	},
	{
		Id = 2,
		CastleName = getI18NValue(180079501)
	},
	{
		Id = 3,
		CastleName = getI18NValue(180079502)
	}
}

setmetatable(CfgHomeLandCastleTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandCastleTable]")
	end
})

local defaultMetaTable = {
	__index = {
		CastleIcon = "",
		CastleName = ""
	}
}

for i, data in pairs(CfgHomeLandCastleTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandCastleTable
