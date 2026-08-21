-- chunkname: @IQIGame\\Config\\CfgFunctionForecastTable.lua

local CfgFunctionForecastTable = {
	[1001] = {
		Id = 1001,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_02.png",
		Title = getI18NValue(180256882),
		ConditionInfo = getI18NValue(180256880),
		Desc = getI18NValue(180256881)
	},
	[1002] = {
		Id = 1002,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_01.png",
		Title = getI18NValue(180256885),
		ConditionInfo = getI18NValue(180256883),
		Desc = getI18NValue(180256884)
	},
	[1003] = {
		Id = 1003,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_03.png",
		Title = getI18NValue(180256888),
		ConditionInfo = getI18NValue(180256886),
		Desc = getI18NValue(180256887)
	},
	[1004] = {
		Id = 1004,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_04.png",
		Title = getI18NValue(180256891),
		ConditionInfo = getI18NValue(180256889),
		Desc = getI18NValue(180256890)
	},
	[1005] = {
		Id = 1005,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_05.png",
		Title = getI18NValue(180256894),
		ConditionInfo = getI18NValue(180256892),
		Desc = getI18NValue(180256893)
	},
	[1006] = {
		Id = 1006,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_08.png",
		Title = getI18NValue(180256897),
		ConditionInfo = getI18NValue(180256895),
		Desc = getI18NValue(180256896)
	},
	[1007] = {
		Id = 1007,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_06.png",
		Title = getI18NValue(180256900),
		ConditionInfo = getI18NValue(180256898),
		Desc = getI18NValue(180256899)
	},
	[1008] = {
		Id = 1008,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_07.png",
		Title = getI18NValue(180256903),
		ConditionInfo = getI18NValue(180256901),
		Desc = getI18NValue(180256902)
	},
	[1009] = {
		Id = 1009,
		Image = "/MainCity/FunctionPreviewUI/FunctionPreview_Image_09.png",
		Title = getI18NValue(180256906),
		ConditionInfo = getI18NValue(180256904),
		Desc = getI18NValue(180256905)
	}
}

setmetatable(CfgFunctionForecastTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFunctionForecastTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ConditionInfo = "",
		Image = "",
		Title = "",
		Desc = ""
	}
}

for i, data in pairs(CfgFunctionForecastTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFunctionForecastTable
