-- chunkname: @IQIGame\\Config\\CfgHomeLandDecorateThemeTable.lua

local CfgHomeLandDecorateThemeTable = {
	{
		Preview = "/Home/HomeBg/HomeBg_01_01.png",
		Id = 1,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_01_01.png",
		Tpye = 1,
		Name = getI18NValue(180081020),
		Score = {
			10,
			500
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_02_01.png",
		Id = 2,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_02_01.png",
		Tpye = 1,
		Name = getI18NValue(180081021),
		Score = {
			10,
			1500
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_03.png",
		Id = 3,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_03_01.png",
		Tpye = 1,
		Name = getI18NValue(180145902),
		Score = {
			10,
			1500
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_04.png",
		Id = 4,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_04_01.png",
		Tpye = 1,
		Name = getI18NValue(180145903),
		Score = {
			10,
			2000
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_05.png",
		Id = 5,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_05_01.png",
		Tpye = 1,
		Name = getI18NValue(180243156),
		Score = {
			10,
			1500
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_06.png",
		Id = 6,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_06_01.png",
		Tpye = 1,
		Name = getI18NValue(180248950),
		Score = {
			10,
			2000
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_07.png",
		Id = 7,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_07_01.png",
		Tpye = 1,
		Name = getI18NValue(180431628),
		Score = {
			10,
			2000
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_08.png",
		Id = 8,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_08_01.png",
		Tpye = 1,
		Name = getI18NValue(180765619),
		Score = {
			10,
			2000
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_09.png",
		Id = 9,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_09_01.png",
		Tpye = 1,
		Name = getI18NValue(180766059),
		Score = {
			10,
			2000
		}
	},
	{
		Preview = "/Home/HomeBg/HomeBg_10.png",
		Id = 10,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_10_01.png",
		Tpye = 1,
		Name = getI18NValue(180823717),
		Score = {
			10,
			2000
		}
	},
	[10001] = {
		Preview = "/Home/HomeBg/HomeBg_04.png",
		Id = 10001,
		Icon = "/HomeUI/ThemeIcon/Theme_Icon_04_01.png",
		Tpye = 1,
		Name = getI18NValue(180237113),
		Score = {
			5,
			500
		}
	}
}

setmetatable(CfgHomeLandDecorateThemeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandDecorateThemeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		Preview = "",
		Icon = "",
		Tpye = 0,
		Score = {}
	}
}

for i, data in pairs(CfgHomeLandDecorateThemeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandDecorateThemeTable
