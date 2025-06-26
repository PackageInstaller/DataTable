-- chunkname: @IQIGame\\Config\\CfgNewCharacterActivityTable.lua

local CfgNewCharacterActivityTable = {
	{
		BingoUI = "/_DailyActivityUI/ActivityNewDoll/ActivityNewDoll_1/ActivityNewDollBingoUIView",
		NPCAction = 6,
		ShowUiSize = 100,
		Proportion = 2,
		MaxTimes = 20,
		Score = 301,
		CardID = 1201,
		MainCharacterHead = "/Image_Resources/SoulResources/SoulResourcesHead01/Image_Alisa_Dress_01_HeadIcon01.png",
		BackGround = "/UI/_DailyActivityUI/NewDoll_211019001.prefab",
		StoryUI = "/_DailyActivityUI/ActivityNewDoll/ActivityNewDoll_1/ActivityNewDollStoryUIView",
		Id = 1,
		Name = getI18NValue(180144927),
		Desc = getI18NValue(180136431),
		Quest = {
			10310001,
			10310002,
			10310003,
			10310004,
			10310005,
			10310006,
			10310007,
			10310008,
			10310009,
			10310010,
			10310011,
			10310012,
			10310013,
			10310014,
			10310015,
			10310016,
			10310017,
			10310018,
			10310019,
			10310020,
			10310021,
			10310022,
			10310023,
			10310024,
			10310025,
			10310026,
			10310027,
			10310028,
			10310029,
			10310030,
			10310031,
			10310032,
			10310033,
			10310034,
			10310035,
			10310036,
			10310037,
			10310038,
			10310039,
			10310040
		},
		CardCost = {
			1,
			10
		},
		ShowUiPosition = {
			0,
			0,
			0
		}
	},
	{
		BingoUI = "/_DailyActivityUI/ActivityNewDoll/ActivityNewDoll_2/ActivityNewDollBingoUIView",
		NPCAction = 7,
		ShowUiSize = 100,
		Proportion = 2,
		MaxTimes = 20,
		Score = 301,
		CardID = 1202,
		MainCharacterHead = "/Image_Resources/SoulResources/SoulResourcesHead01/Image_Silenus_Dress_01_HeadIcon01.png",
		BackGround = "/UI/_DailyActivityUI/NewDoll_220428001.prefab",
		StoryUI = "/_DailyActivityUI/ActivityNewDoll/ActivityNewDoll_2/ActivityNewDollStoryUIView",
		Id = 2,
		Name = getI18NValue(180272866),
		Desc = getI18NValue(180272865),
		Quest = {
			10320001,
			10320002,
			10320003,
			10320004,
			10320005,
			10320006,
			10320007,
			10320008,
			10320009,
			10320010,
			10320011,
			10320012,
			10320013,
			10320014,
			10320015,
			10320016,
			10320017,
			10320018,
			10320019,
			10320020,
			10320021,
			10320022,
			10320023,
			10320024,
			10320025,
			10320026,
			10320027,
			10320028,
			10320029,
			10320030,
			10320031,
			10320032,
			10320033,
			10320034,
			10320035,
			10320036,
			10320037,
			10320038,
			10320039,
			10320040
		},
		CardCost = {
			1,
			10
		},
		ShowUiPosition = {
			0,
			0,
			0
		}
	},
	{
		BingoUI = "/_DailyActivityUI/ActivityNewDoll/ActivityNewDoll_3/ActivityNewDollBingoUIView",
		NPCAction = 8,
		ShowUiSize = 100,
		Proportion = 2,
		MaxTimes = 20,
		Score = 301,
		CardID = 1203,
		MainCharacterHead = "/Image_Resources/SoulResources/SoulResourcesHead01/Image_Clotho_Dress_01_HeadIcon01.png",
		BackGround = "/UI/_DailyActivityUI/NewDoll_230629001.prefab",
		StoryUI = "/_DailyActivityUI/ActivityNewDoll/ActivityNewDoll_3/ActivityNewDollStoryUIView",
		Id = 3,
		Name = getI18NValue(180538953),
		Desc = getI18NValue(180538952),
		Quest = {
			10320101,
			10320102,
			10320103,
			10320104,
			10320105,
			10320106,
			10320107,
			10320108,
			10320109,
			10320110,
			10320111,
			10320112,
			10320113,
			10320114,
			10320115,
			10320116,
			10320117,
			10320118,
			10320119,
			10320120,
			10320121,
			10320122,
			10320123,
			10320124,
			10320125,
			10320126,
			10320127,
			10320128,
			10320129,
			10320130,
			10320131,
			10320132,
			10320133,
			10320134,
			10320135,
			10320136,
			10320137,
			10320138,
			10320139,
			10320140
		},
		CardCost = {
			1,
			10
		},
		ShowUiPosition = {
			0,
			0,
			0
		}
	}
}

setmetatable(CfgNewCharacterActivityTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgNewCharacterActivityTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BackGround = "",
		BingoUI = "",
		StoryUI = "",
		MainCharacterHead = "",
		Name = "",
		MaxTimes = 0,
		Score = 0,
		CardID = 0,
		Proportion = 0,
		ShowUiSize = 0,
		NPCAction = 0,
		Desc = "",
		ShowUiPosition = {},
		CardCost = {},
		Quest = {}
	}
}

for i, data in pairs(CfgNewCharacterActivityTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgNewCharacterActivityTable
