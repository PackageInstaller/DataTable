-- chunkname: @IQIGame\\Config\\CfgPreloadTable.lua

local CfgPreloadTable = {
	{
		Id = 1,
		FilePath = "/05_Images/Common/ArtFont/_ArtFont.spriteatlas"
	}
}

setmetatable(CfgPreloadTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPreloadTable]")
	end
})

local defaultMetaTable = {
	__index = {
		SceneID = 0,
		FilePath = ""
	}
}

for i, data in pairs(CfgPreloadTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPreloadTable
