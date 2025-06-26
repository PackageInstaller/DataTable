-- chunkname: @IQIGame\\Config\\CfgFishActiveControlTable.lua

local CfgFishActiveControlTable = {
	{
		ExploreHallUIBG = "Activity_Fishing_250529",
		AutoLevel = 2,
		TimeInterval = 28800,
		MaxLevel = 20,
		MoneyId = 354,
		UIBGM = 34,
		Id = 1,
		ScoreId = 355,
		Name = getI18NValue(181196602),
		ButtonName = getI18NValue(181196601),
		Desc = getI18NValue(181196600),
		ClearItem = {
			354,
			355
		},
		AchievementsID = {
			90601001,
			90601002,
			90601003,
			90601004,
			90601005,
			90601006,
			90601007,
			90601008,
			90601009,
			90601010,
			90601011,
			90601012,
			90601013,
			90601014,
			90601015,
			90601016,
			90601017,
			90601018,
			90601019,
			90601020,
			90601021,
			90601022,
			90601023,
			90601024,
			90601025,
			90601026,
			90601027,
			90601028,
			90601029,
			90601030,
			90601031,
			90601032,
			90601033,
			90601034,
			90601035,
			90601036,
			90601037,
			90601038,
			90601039,
			90601040,
			90601041,
			90601042,
			90601043,
			90601044,
			90601045,
			90601046,
			90601047,
			90601048,
			90601049,
			90601050,
			90601051,
			90601052,
			90601053,
			90601054,
			90601055,
			90601056,
			90601057,
			90601058,
			90601059,
			90601060,
			90601061,
			90601062,
			90601063,
			90601064,
			90601065,
			90601066,
			90601067,
			90601068,
			90601069,
			90601070
		},
		InitialProps = {
			354,
			100
		},
		FishNum = {
			20,
			30
		},
		Cost = {
			104,
			1
		}
	}
}

setmetatable(CfgFishActiveControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFishActiveControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AutoLevel = 0,
		ButtonName = "",
		Desc = "",
		ExploreHallUIBG = "",
		UIBGM = 0,
		MaxLevel = 0,
		Name = "",
		MoneyId = 0,
		ScoreId = 0,
		TimeInterval = 0,
		InitialProps = {},
		FishNum = {},
		AchievementsID = {},
		ClearItem = {},
		Cost = {}
	}
}

for i, data in pairs(CfgFishActiveControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFishActiveControlTable
