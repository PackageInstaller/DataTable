-- chunkname: @IQIGame\\Config\\CfgPlaceGameControlTable.lua

local CfgPlaceGameControlTable = {
	{
		ExpId = 341,
		TimeIntervalEquip = 600,
		BoxNumMax = 50,
		EquipMaxNum = 999,
		MainUiGetButton = 360,
		MaxTimes = 720,
		TimeIntervalItem = 60,
		UIBGM = 450,
		Id = 1,
		MaxTimesEquip = 72,
		ExploreHallUIBG = "Activity_PlaceGame_240516",
		Name = getI18NValue(180846330),
		ButtonName = getI18NValue(180846329),
		Desc = getI18NValue(180846328),
		MoneyId = {
			341,
			342,
			343
		},
		ClearItem = {
			341,
			342,
			343
		},
		InitialProps = {
			342,
			600
		},
		SoulMax = {
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15
		},
		NeedTower = {
			0,
			2,
			4,
			6,
			8,
			10,
			12,
			15,
			18,
			21,
			24,
			27,
			30
		}
	}
}

setmetatable(CfgPlaceGameControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlaceGameControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Desc = "",
		ButtonName = "",
		MaxTimes = 0,
		ExpId = 0,
		Name = "",
		EquipMaxNum = 0,
		BoxNumMax = 0,
		TimeIntervalEquip = 0,
		MainUiGetButton = 0,
		TimeIntervalItem = 0,
		UIBGM = 0,
		MaxTimesEquip = 0,
		ExploreHallUIBG = "",
		InitialProps = {},
		SoulMax = {},
		ClearItem = {},
		NeedTower = {},
		MoneyId = {}
	}
}

for i, data in pairs(CfgPlaceGameControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlaceGameControlTable
