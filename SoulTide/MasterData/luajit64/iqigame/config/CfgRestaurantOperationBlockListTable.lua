-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationBlockListTable.lua

local CfgRestaurantOperationBlockListTable = {
	{
		GridNum = 1,
		Id = 1,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Blue_1.png",
		GraphicPresets = 1
	},
	{
		GridNum = 2,
		Id = 2,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Red_1.png",
		GraphicPresets = 2
	},
	{
		GridNum = 2,
		Id = 3,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Blue_1.png",
		GraphicPresets = 3
	},
	{
		GridNum = 3,
		Id = 4,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Pale_1.png",
		GraphicPresets = 4
	},
	{
		GridNum = 3,
		Id = 5,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Purple_1.png",
		GraphicPresets = 5
	},
	{
		GridNum = 4,
		Id = 6,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Red_1.png",
		GraphicPresets = 6
	},
	{
		GridNum = 4,
		Id = 7,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Blue_1.png",
		GraphicPresets = 7
	},
	{
		GridNum = 5,
		Id = 8,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Pale_1.png",
		GraphicPresets = 8
	},
	{
		GridNum = 5,
		Id = 9,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Purple_1.png",
		GraphicPresets = 9
	},
	{
		GridNum = 4,
		Id = 10,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Purple_1.png",
		GraphicPresets = 10
	},
	{
		GridNum = 4,
		Id = 11,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Pale_1.png",
		GraphicPresets = 11
	},
	{
		GridNum = 4,
		Id = 12,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Yellow_1.png",
		GraphicPresets = 12
	},
	{
		GridNum = 4,
		Id = 13,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Yellow_1.png",
		GraphicPresets = 13
	},
	{
		GridNum = 4,
		Id = 14,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Yellow_1.png",
		GraphicPresets = 14
	},
	{
		GridNum = 4,
		Id = 15,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Red_1.png",
		GraphicPresets = 15
	},
	{
		GridNum = 4,
		Id = 16,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Blue_1.png",
		GraphicPresets = 16
	},
	{
		GridNum = 5,
		Id = 17,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Yellow_1.png",
		GraphicPresets = 17
	},
	{
		GridNum = 5,
		Id = 18,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Red_1.png",
		GraphicPresets = 18
	},
	{
		GridNum = 5,
		Id = 19,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Blue_1.png",
		GraphicPresets = 19
	},
	{
		GridNum = 6,
		Id = 20,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Purple_1.png",
		GraphicPresets = 20
	},
	{
		GridNum = 6,
		Id = 21,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Pale_1.png",
		GraphicPresets = 21
	},
	{
		GridNum = 9,
		Id = 22,
		ImageRes = "/Activity/RestaurantOperation/Batch1/RestaurantGameBlocksResUI/RestaurantGame_Yellow_1.png",
		GraphicPresets = 22
	}
}

setmetatable(CfgRestaurantOperationBlockListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationBlockListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		GridNum = 0,
		ImageRes = "",
		GraphicPresets = 0
	}
}

for i, data in pairs(CfgRestaurantOperationBlockListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationBlockListTable
