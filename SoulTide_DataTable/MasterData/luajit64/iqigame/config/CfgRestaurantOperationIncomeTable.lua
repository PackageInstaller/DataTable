-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationIncomeTable.lua

local CfgRestaurantOperationIncomeTable = {
	{
		Group = 1,
		IncomeItem = 335,
		Ratio = 1,
		Type = 1,
		Id = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_5.png",
		AttName = getI18NValue(180829285),
		Attribute = {
			4
		}
	},
	{
		Group = 1,
		IncomeItem = 334,
		Ratio = 1,
		Type = 2,
		Id = 2,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_1.png",
		AttName = getI18NValue(180829286),
		Attribute = {
			1
		}
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_7.png",
		Ratio = 1,
		Type = 3,
		Id = 3,
		AttName = getI18NValue(180829287),
		Attribute = {
			2
		}
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_2.png",
		Ratio = 1,
		Type = 4,
		Id = 4,
		AttName = getI18NValue(180829288),
		Attribute = {
			3
		}
	},
	{
		Group = 1,
		IncomeItem = 331,
		Ratio = 10,
		Type = 5,
		Id = 5,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_6.png",
		AttName = getI18NValue(180829289)
	},
	{
		Group = 1,
		IncomeItem = 332,
		Ratio = 0.2,
		Type = 6,
		Id = 6,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_4.png",
		AttName = getI18NValue(180829290),
		Attribute = {
			6
		}
	},
	{
		Group = 1,
		IncomeItem = 333,
		Ratio = 0.01,
		Type = 7,
		Id = 7,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationCommonUI/RestaurantOperationMain_Icon_3.png",
		AttName = getI18NValue(180829291),
		Attribute = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	}
}

setmetatable(CfgRestaurantOperationIncomeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationIncomeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ImageIcon = "",
		Ratio = 0,
		Type = 0,
		IncomeItem = 0,
		AttName = "",
		Attribute = {}
	}
}

for i, data in pairs(CfgRestaurantOperationIncomeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationIncomeTable
