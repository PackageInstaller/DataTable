-- chunkname: @IQIGame\\Config\\CfgAmusementParkBlockListTable.lua

local CfgAmusementParkBlockListTable = {
	{
		GridNum = 1,
		Id = 1,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 1
	},
	{
		GridNum = 2,
		Id = 2,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 2
	},
	{
		GridNum = 2,
		Id = 3,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 3
	},
	{
		GridNum = 3,
		Id = 4,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 4
	},
	{
		GridNum = 3,
		Id = 5,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 5
	},
	{
		GridNum = 4,
		Id = 6,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 6
	},
	{
		GridNum = 4,
		Id = 7,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 7
	},
	{
		GridNum = 5,
		Id = 8,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 8
	},
	{
		GridNum = 5,
		Id = 9,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_03.png",
		GraphicPresets = 9
	},
	{
		GridNum = 4,
		Id = 10,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_06.png",
		GraphicPresets = 10
	},
	{
		GridNum = 4,
		Id = 11,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_06.png",
		GraphicPresets = 11
	},
	{
		GridNum = 4,
		Id = 12,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 12
	},
	{
		GridNum = 4,
		Id = 13,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 13
	},
	{
		GridNum = 4,
		Id = 14,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 14
	},
	{
		GridNum = 4,
		Id = 15,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_05.png",
		GraphicPresets = 15
	},
	{
		GridNum = 4,
		Id = 16,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_05.png",
		GraphicPresets = 16
	},
	{
		GridNum = 5,
		Id = 17,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_06.png",
		GraphicPresets = 17
	},
	{
		GridNum = 5,
		Id = 18,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_06.png",
		GraphicPresets = 18
	},
	{
		GridNum = 5,
		Id = 19,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_06.png",
		GraphicPresets = 19
	},
	{
		GridNum = 6,
		Id = 20,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 20
	},
	{
		GridNum = 6,
		Id = 21,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 21
	},
	{
		GridNum = 4,
		Id = 22,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 22
	},
	{
		GridNum = 4,
		Id = 23,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_04.png",
		GraphicPresets = 23
	},
	{
		GridNum = 3,
		Id = 24,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_05.png",
		GraphicPresets = 24
	},
	{
		GridNum = 3,
		Id = 25,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_05.png",
		GraphicPresets = 25
	},
	{
		GridNum = 3,
		Id = 26,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_05.png",
		GraphicPresets = 26
	},
	{
		GridNum = 3,
		Id = 27,
		ImageRes = "/Activity/AmusementPark/AmusementParkGameUI/AmusementParkGameBlocksUI_05.png",
		GraphicPresets = 37
	}
}

setmetatable(CfgAmusementParkBlockListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkBlockListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		GridNum = 0,
		ImageRes = "",
		GraphicPresets = 0
	}
}

for i, data in pairs(CfgAmusementParkBlockListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkBlockListTable
