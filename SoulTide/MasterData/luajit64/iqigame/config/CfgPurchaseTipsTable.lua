-- chunkname: @IQIGame\\Config\\CfgPurchaseTipsTable.lua

local CfgPurchaseTipsTable = {
	{
		FunctionId = 10605501,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26071001,
		Type = 1,
		Id = 1,
		Order = 101,
		Describe = getI18NValue(180105495)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26070001,
		Type = 2,
		Id = 2,
		MallId = 1010301015,
		Order = 201,
		Describe = getI18NValue(180105496)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26070002,
		Type = 2,
		Id = 3,
		MallId = 1010301016,
		Order = 202,
		Describe = getI18NValue(180105497)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26070003,
		Type = 2,
		Id = 4,
		MallId = 1010301017,
		Order = 203,
		Describe = getI18NValue(180105498)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26011926,
		Type = 2,
		Id = 5,
		MallId = 1010301018,
		Order = 204,
		Describe = getI18NValue(180105499)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26011926,
		Type = 2,
		Id = 6,
		MallId = 1010301019,
		Order = 205,
		Describe = getI18NValue(180105500)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26011926,
		Type = 2,
		Id = 7,
		MallId = 1010301020,
		Order = 206,
		Describe = getI18NValue(180105501)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26011926,
		Type = 2,
		Id = 8,
		MallId = 1010301021,
		Order = 207,
		Describe = getI18NValue(180105502)
	},
	{
		FunctionId = 10202023,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Conditions = 26011926,
		Type = 2,
		Id = 9,
		MallId = 1010301022,
		Order = 208,
		Describe = getI18NValue(180105503)
	},
	{
		FunctionId = 10605502,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Type = 3,
		Id = 10,
		MallId = 1010312001,
		Order = 11,
		Describe = getI18NValue(180515266),
		ShowItems = {
			11140,
			100,
			10026,
			10
		}
	},
	{
		FunctionId = 10605502,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Type = 3,
		Id = 11,
		MallId = 1010312002,
		Order = 12,
		Describe = getI18NValue(180515267),
		ShowItems = {
			501,
			1,
			20302,
			20,
			20303,
			10,
			10026,
			10
		}
	},
	{
		FunctionId = 10605502,
		ImageIcon = "/MainCity/MainUI/MainUI_Image_Tip_03.png",
		Type = 3,
		Id = 12,
		MallId = 1010312004,
		Order = 13,
		Describe = getI18NValue(180515268),
		ShowItems = {
			10032,
			1,
			11140,
			10,
			10026,
			20
		}
	}
}

setmetatable(CfgPurchaseTipsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPurchaseTipsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		FunctionId = 0,
		Describe = "",
		ImageIcon = "",
		Type = 0,
		Conditions = 0,
		MallId = 0,
		Order = 0,
		ShowItems = {}
	}
}

for i, data in pairs(CfgPurchaseTipsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPurchaseTipsTable
