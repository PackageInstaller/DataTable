-- chunkname: @IQIGame\\Config\\CfgCGTable.lua

local CfgCGTable = {
	[1000000] = {
		Id = 1000000,
		Path = "CG/SplashScreen.mp4"
	}
}

setmetatable(CfgCGTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCGTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Path = ""
	}
}

for i, data in pairs(CfgCGTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCGTable
