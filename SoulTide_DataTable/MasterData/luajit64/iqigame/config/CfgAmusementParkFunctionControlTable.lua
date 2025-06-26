-- chunkname: @IQIGame\\Config\\CfgAmusementParkFunctionControlTable.lua

local CfgAmusementParkFunctionControlTable = {
	{
		BuildingId = 1,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_9.png",
		Type = 1,
		Id = 1,
		FunctionName = getI18NValue(180905874),
		Abstract = getI18NValue(180905875)
	},
	{
		BuildingId = 5,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_1.png",
		Type = 2,
		Id = 2,
		FunctionName = getI18NValue(180905876),
		Abstract = getI18NValue(180905877)
	},
	{
		BuildingId = 18,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_5.png",
		Type = 3,
		Id = 3,
		FunctionName = getI18NValue(180905878),
		Abstract = getI18NValue(180905879)
	},
	{
		BuildingId = 12,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_4.png",
		Type = 4,
		Id = 4,
		FunctionName = getI18NValue(180905880),
		Abstract = getI18NValue(180905881)
	},
	{
		BuildingId = 2,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_6.png",
		Type = 5,
		Id = 5,
		FunctionName = getI18NValue(180905882),
		Abstract = getI18NValue(180905883)
	},
	{
		BuildingId = 9,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_7.png",
		Type = 6,
		Id = 6,
		FunctionName = getI18NValue(180905884),
		Abstract = getI18NValue(180905885)
	},
	{
		BuildingId = 16,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_6.png",
		Type = 7,
		Id = 7,
		FunctionName = getI18NValue(180905886),
		Abstract = getI18NValue(180905887)
	},
	{
		BuildingId = 14,
		Group = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_7.png",
		Type = 8,
		Id = 8,
		FunctionName = getI18NValue(180905888),
		Abstract = getI18NValue(180905889)
	}
}

setmetatable(CfgAmusementParkFunctionControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkFunctionControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Type = 0,
		FunctionIcon = "",
		FunctionName = "",
		BuildingId = 0,
		Abstract = ""
	}
}

for i, data in pairs(CfgAmusementParkFunctionControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkFunctionControlTable
