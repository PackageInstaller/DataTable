-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationFunctionControlTable.lua

local CfgRestaurantOperationFunctionControlTable = {
	{
		Group = 1,
		Id = 1,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_2.png",
		FunctionName = getI18NValue(180828597)
	},
	{
		Group = 1,
		Id = 2,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_9.png",
		FunctionName = getI18NValue(180828598)
	},
	{
		Group = 1,
		Id = 3,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_8.png",
		FunctionName = getI18NValue(180828599)
	},
	{
		Group = 1,
		Id = 4,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_3.png",
		FunctionName = getI18NValue(180828600)
	},
	{
		Group = 1,
		Id = 5,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_1.png",
		FunctionName = getI18NValue(180828601)
	},
	{
		Group = 1,
		Id = 6,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_5.png",
		FunctionName = getI18NValue(180828602)
	},
	{
		Group = 1,
		Id = 7,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_4.png",
		FunctionName = getI18NValue(180828603)
	},
	{
		Group = 1,
		Id = 8,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_6.png",
		FunctionName = getI18NValue(180828604)
	},
	{
		Group = 1,
		Id = 9,
		FunctionIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationFunctionUI/RestaurantOperationFunction_Icon_7.png",
		FunctionName = getI18NValue(180830200)
	}
}

setmetatable(CfgRestaurantOperationFunctionControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationFunctionControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		FunctionIcon = "",
		FunctionName = ""
	}
}

for i, data in pairs(CfgRestaurantOperationFunctionControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationFunctionControlTable
