-- chunkname: @IQIGame\\Config\\CfgItemTable.lua

local CfgItemTable = {
	{
		Quality = 5,
		Id = 1,
		OverMode = 1,
		Icon = "/Item/Icon_Rmb01.png",
		MaxNum = 99999999,
		UseType = 2,
		SmallIcon = "/Item/Icon_Rmb01.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Rmb01.png",
		Name = getI18NValue(180017244),
		ItemTips = getI18NValue(180017243)
	},
	{
		Quality = 5,
		Id = 2,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Jade.png",
		SmallIcon = "/Item/Icon_Currency_Small_Jade.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Jade.png",
		Name = getI18NValue(180017246),
		ItemTips = getI18NValue(180017245)
	},
	{
		Quality = 5,
		Id = 3,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Stone_01.png",
		SmallIcon = "/Item/Icon_Currency_Small_Stone.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Stone_01.png",
		Name = getI18NValue(180017248),
		ItemTips = getI18NValue(180017247),
		ItemStory = getI18NValue(180038394)
	},
	{
		Quality = 4,
		Id = 4,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Coins_01.png",
		SmallIcon = "/Item/Icon_Currency_Small_Coins.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Coins_01.png",
		Name = getI18NValue(180017250),
		ItemTips = getI18NValue(180017249),
		ItemStory = getI18NValue(180038395),
		Source = {
			11202200
		}
	},
	{
		UserAction = 2,
		Quality = 4,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Experience_01.png",
		UseType = 1,
		Id = 5,
		SmallIcon = "/Item/Icon_Item_Experience_01.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Item_Experience_01.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017252),
		ItemTips = getI18NValue(180017251),
		ActionParams = {
			1
		}
	},
	{
		Quality = 5,
		IsHide = 1,
		Id = 6,
		Icon = "/Item/Icon_Item_Experience_01.png",
		OverMode = 1,
		Reveal = true,
		SmallIcon = "/Item/Icon_Item_Experience_01.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Item_Experience_01.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180251758),
		ItemTips = getI18NValue(180251757)
	},
	[11] = {
		Quality = 4,
		OverMode = 1,
		Id = 11,
		Icon = "/Item/Icon_Currency_Personality.png",
		SmallIcon = "/Item/Icon_Currency_Small_Personality.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Personality.png",
		ItemSubTypes = 2,
		Name = getI18NValue(180017254),
		ItemTips = getI18NValue(180017253)
	},
	[12] = {
		Quality = 5,
		OverMode = 1,
		Id = 12,
		Icon = "/Item/Icon_Currency_Other_1.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_1.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Other_1.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017256),
		ItemTips = getI18NValue(180017255),
		Source = {
			10202002
		}
	},
	[13] = {
		Quality = 5,
		OverMode = 1,
		Id = 13,
		Icon = "/Item/Icon_Currency_Skin.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_8.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Skin.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017258),
		ItemTips = getI18NValue(180017257)
	},
	[14] = {
		Quality = 5,
		OverMode = 1,
		Id = 14,
		Icon = "/Item/Icon_Currency_Other_2.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_2.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Other_2.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017260),
		ItemTips = getI18NValue(180017259),
		Source = {
			10202002
		}
	},
	[16] = {
		ItemTypes = 1,
		Quality = 5,
		Id = 16,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_SmallOther_7.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_7.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180038397),
		ItemTips = getI18NValue(180038396)
	},
	[15] = {
		Quality = 5,
		OverMode = 1,
		Id = 15,
		Icon = "/Item/Icon_Item_BreakProperty_021.png",
		SmallIcon = "/Item/Icon_Item_BreakProperty_50.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Item_BreakProperty_021.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180038399),
		ItemTips = getI18NValue(180038398)
	},
	[17] = {
		Quality = 4,
		Id = 17,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_Currency_Other_3.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_6.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Other_3.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180038402),
		ItemTips = getI18NValue(180038400),
		ItemStory = getI18NValue(180038401)
	},
	[18] = {
		Quality = 5,
		Id = 18,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_Currency_Other_9.png",
		MaxNum = 99999999,
		SmallIcon = "/Item/Icon_Currency_SmallOther_9.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Other_9.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180038404),
		ItemTips = getI18NValue(180038403),
		ItemStory = getI18NValue(180176775)
	},
	[19] = {
		ItemTypes = 1,
		Quality = 3,
		Id = 19,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ActivityExperience_01.png",
		Star = false,
		Reveal = false,
		BigIcon = "/Item/Icon_Item_ActivityExperience_01.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180038406),
		ItemTips = getI18NValue(180038405)
	},
	[20] = {
		Quality = 5,
		OverMode = 1,
		Id = 20,
		Icon = "/Item/Icon_Maze_03.png",
		SmallIcon = "/Item/Icon_Maze_Small_02.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Maze_03.png",
		ItemSubTypes = 5,
		Name = getI18NValue(180038408),
		ItemTips = getI18NValue(180038407)
	},
	[21] = {
		Quality = 5,
		OverMode = 1,
		Id = 21,
		Icon = "/Item/Icon_Maze_07.png",
		SmallIcon = "/Item/Icon_Maze_Small_04.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Maze_07.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180177911),
		ItemTips = getI18NValue(180177910)
	},
	[22] = {
		Quality = 5,
		OverMode = 1,
		Id = 22,
		Icon = "/Item/Icon_Maze_06.png",
		SmallIcon = "/Item/Icon_Maze_Small_03.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Maze_06.png",
		ItemSubTypes = 4,
		Name = getI18NValue(180177913),
		ItemTips = getI18NValue(180177912)
	},
	[23] = {
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/Icon_Maze_01.png",
		Id = 23,
		SmallIcon = "/Item/Icon_Maze_Small_01.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Maze_01.png",
		ItemSubTypes = 4,
		Name = getI18NValue(180196010),
		ItemTips = getI18NValue(180196009),
		Compensate = {
			22,
			300
		}
	},
	[24] = {
		ItemTypes = 22,
		Quality = 5,
		Id = 24,
		OverMode = 1,
		Icon = "/Item/Icon_Maze_08.png",
		BigIcon = "/Item/Icon_Maze_08.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180196012),
		ItemTips = getI18NValue(180196011)
	},
	[25] = {
		UserAction = 33,
		Quality = 5,
		Id = 25,
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_05.png",
		UseType = 2,
		BigIcon = "/Item/Icon_Maze_05.png",
		ItemSubTypes = 2,
		Name = getI18NValue(180196014),
		ItemTips = getI18NValue(180196013),
		ActionParams = {
			2,
			2,
			1,
			15
		}
	},
	[26] = {
		UserAction = 33,
		Quality = 5,
		Id = 26,
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_04.png",
		UseType = 2,
		BigIcon = "/Item/Icon_Maze_04.png",
		ItemSubTypes = 2,
		Name = getI18NValue(180196016),
		ItemTips = getI18NValue(180196015),
		ActionParams = {
			2,
			2,
			1,
			-90
		}
	},
	[27] = {
		UserAction = 33,
		Quality = 5,
		Id = 27,
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_05.png",
		UseType = 2,
		BigIcon = "/Item/Icon_Maze_05.png",
		ItemSubTypes = 2,
		Name = getI18NValue(180196018),
		ItemTips = getI18NValue(180196017),
		ActionParams = {
			2,
			2,
			1,
			30
		}
	},
	[28] = {
		UserAction = 33,
		Quality = 5,
		Id = 28,
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_04.png",
		UseType = 2,
		BigIcon = "/Item/Icon_Maze_04.png",
		ItemSubTypes = 2,
		Name = getI18NValue(180196020),
		ItemTips = getI18NValue(180196019),
		ActionParams = {
			2,
			2,
			1,
			-90
		}
	},
	[29] = {
		UserAction = 39,
		Quality = 4,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Experience_01.png",
		UseType = 1,
		Id = 29,
		SmallIcon = "/Item/Icon_Item_Experience_01.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Item_Experience_01.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180197499),
		ItemTips = getI18NValue(180197498),
		ActionParams = {
			2,
			8
		}
	},
	[30] = {
		Id = 30,
		BigIcon = "/Item/Icon_Maze_09.png",
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_09.png",
		ItemSubTypes = 2,
		Quality = 5,
		Name = getI18NValue(180204162),
		ItemTips = getI18NValue(180204161)
	},
	[31] = {
		Id = 31,
		BigIcon = "/Item/Icon_Maze_12.png",
		ItemTypes = 1,
		Icon = "/Item/Icon_Maze_12.png",
		ItemSubTypes = 4,
		Quality = 5,
		Name = getI18NValue(180216776),
		ItemTips = getI18NValue(180216775)
	},
	[32] = {
		Id = 32,
		BigIcon = "/Item/Icon_Maze_10.png",
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_10.png",
		ItemSubTypes = 2,
		Quality = 5,
		Name = getI18NValue(180216778),
		ItemTips = getI18NValue(180216777)
	},
	[33] = {
		Id = 33,
		BigIcon = "/Item/Icon_Maze_11.png",
		ItemTypes = 22,
		Icon = "/Item/Icon_Maze_11.png",
		ItemSubTypes = 2,
		Quality = 5,
		Name = getI18NValue(180216780),
		ItemTips = getI18NValue(180216779)
	},
	[101] = {
		ItemTypes = 1,
		Quality = 4,
		Id = 101,
		OverMode = 1,
		Icon = "/Item/Icon_DayTask_01.png",
		BigIcon = "/Item/Icon_DayTask_01.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017262),
		ItemTips = getI18NValue(180017261)
	},
	[102] = {
		ItemTypes = 1,
		Quality = 4,
		Id = 102,
		OverMode = 1,
		Icon = "/Item/Icon_DayTask_01.png",
		BigIcon = "/Item/Icon_DayTask_01.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017264),
		ItemTips = getI18NValue(180017263)
	},
	[103] = {
		UserAction = 20,
		Quality = 3,
		Id = 103,
		IsHide = 1,
		ItemTypes = 1,
		Icon = "/Item/Icon_Item_ActivityExperience_01.png",
		UseType = 1,
		OverMode = 1,
		BigIcon = "/Item/Icon_Item_ActivityExperience_01.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017266),
		ItemTips = getI18NValue(180017265),
		ActionParams = {
			1,
			1,
			19
		}
	},
	[104] = {
		UserAction = 20,
		Quality = 3,
		Id = 104,
		IsHide = 1,
		ItemTypes = 1,
		Icon = "/Item/Icon_Item_ActivityExperience_01.png",
		UseType = 1,
		OverMode = 1,
		BigIcon = "/Item/Icon_Item_ActivityExperience_01.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017268),
		ItemTips = getI18NValue(180017267),
		ActionParams = {
			2,
			1,
			19
		}
	},
	[105] = {
		ItemTypes = 1,
		Quality = 3,
		Id = 105,
		OverMode = 1,
		Icon = "/Item/Icon_NoviceImg_01.png",
		BigIcon = "/Item/Icon_NoviceImg_01.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180017270),
		ItemTips = getI18NValue(180017269)
	},
	[106] = {
		Id = 106,
		IsHide = 1,
		ItemTypes = 1,
		Quality = 3,
		ItemSubTypes = 3,
		OverMode = 1,
		Name = getI18NValue(180017272),
		ItemTips = getI18NValue(180017271)
	},
	[107] = {
		Id = 107,
		IsHide = 1,
		ItemTypes = 1,
		Quality = 3,
		ItemSubTypes = 3,
		OverMode = 1,
		Name = getI18NValue(180017274),
		ItemTips = getI18NValue(180017273)
	},
	[108] = {
		Id = 108,
		IsHide = 1,
		ItemTypes = 1,
		Quality = 3,
		ItemSubTypes = 3,
		OverMode = 1,
		Name = getI18NValue(180017276),
		ItemTips = getI18NValue(180017275)
	},
	[109] = {
		Id = 109,
		IsHide = 1,
		ItemTypes = 1,
		Quality = 3,
		ItemSubTypes = 3,
		OverMode = 1,
		Name = getI18NValue(180017278),
		ItemTips = getI18NValue(180017277)
	},
	[110] = {
		Id = 110,
		IsHide = 1,
		ItemTypes = 1,
		Quality = 3,
		ItemSubTypes = 3,
		OverMode = 1,
		Name = getI18NValue(180038410),
		ItemTips = getI18NValue(180038409)
	},
	[111] = {
		UserAction = 28,
		Quality = 3,
		IsHide = 1,
		Id = 111,
		OverMode = 1,
		UseType = 1,
		ItemTypes = 12,
		ItemSubTypes = 1,
		Name = getI18NValue(180139107),
		ItemTips = getI18NValue(180139106),
		ActionParams = {
			1
		}
	},
	[112] = {
		UserAction = 44,
		Quality = 3,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_001.png",
		UseType = 1,
		Id = 112,
		BigIcon = "/Item/Icon_Item_Favorable_001.png",
		Name = getI18NValue(180233397),
		ItemTips = getI18NValue(180233396),
		ActionParams = {
			1,
			1
		}
	},
	[113] = {
		Id = 113,
		BigIcon = "/Item/Icon_Item_Favorable_002.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_002.png",
		Quality = 3,
		ItemTypes = 1,
		Name = getI18NValue(180232344),
		ItemTips = getI18NValue(180232343)
	},
	[114] = {
		UserAction = 44,
		Quality = 3,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_001.png",
		UseType = 1,
		Id = 114,
		BigIcon = "/Item/Icon_Item_Favorable_001.png",
		Name = getI18NValue(180235945),
		ItemTips = getI18NValue(180235944),
		ActionParams = {
			2,
			1
		}
	},
	[115] = {
		Quality = 4,
		OverMode = 1,
		Id = 115,
		Icon = "/Item/Icon_ItemMiddle_WorldBoss_01_002.png",
		SmallIcon = "/Item/Icon_ItemSmall_WorldBoss_01_003.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_ItemMiddle_WorldBoss_01_001.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180238901),
		ItemTips = getI18NValue(180238900)
	},
	[116] = {
		Quality = 4,
		OverMode = 1,
		Id = 116,
		Icon = "/Item/Icon_Currency_SmallOther_14.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_14.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_SmallOther_14.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180241246),
		ItemTips = getI18NValue(180241245)
	},
	[117] = {
		Quality = 4,
		OverMode = 1,
		Id = 117,
		Icon = "/Item/Icon_Currency_Other_17.png",
		SmallIcon = "/Item/Icon_Currency_SmallOther_17.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Other_17.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180264488),
		ItemTips = getI18NValue(180264487)
	},
	[201] = {
		ItemTypes = 1,
		Quality = 5,
		Id = 201,
		OverMode = 1,
		MaxNum = 99999999,
		Icon = "/Item/Icon_Currency_Other_10.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Currency_Other_10.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180187155),
		ItemTips = getI18NValue(180187154)
	},
	[202] = {
		Quality = 5,
		Id = 202,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_Currency_Other_16.png",
		MaxNum = 99999999,
		SmallIcon = "/Item/Icon_Currency_SmallOther_16.png",
		ItemTypes = 1,
		BigIcon = "/Item/Icon_Currency_Other_16.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180261314),
		ItemTips = getI18NValue(180261312),
		ItemStory = getI18NValue(180261313)
	},
	[203] = {
		Id = 203,
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/Icon_Item_203.png",
		UseType = 2,
		Reveal = true,
		Name = getI18NValue(180267644),
		ItemTips = getI18NValue(180267643)
	},
	[1000] = {
		UserAction = 5,
		Quality = 3,
		Id = 1000,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038412),
		ItemTips = getI18NValue(180038411),
		ActionParams = {
			1
		}
	},
	[1001] = {
		UserAction = 5,
		Quality = 3,
		Id = 1001,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180017280),
		ItemTips = getI18NValue(180017279),
		ActionParams = {
			2
		}
	},
	[1002] = {
		UserAction = 5,
		Quality = 3,
		Id = 1002,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038414),
		ItemTips = getI18NValue(180038413),
		ActionParams = {
			3
		}
	},
	[1003] = {
		UserAction = 5,
		Quality = 3,
		Id = 1003,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038416),
		ItemTips = getI18NValue(180038415),
		ActionParams = {
			4
		}
	},
	[1004] = {
		UserAction = 5,
		Quality = 3,
		Id = 1004,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038418),
		ItemTips = getI18NValue(180038417),
		ActionParams = {
			5
		}
	},
	[1005] = {
		UserAction = 5,
		Quality = 3,
		Id = 1005,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038420),
		ItemTips = getI18NValue(180038419),
		ActionParams = {
			6
		}
	},
	[1006] = {
		UserAction = 5,
		Quality = 3,
		Id = 1006,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038422),
		ItemTips = getI18NValue(180038421),
		ActionParams = {
			7,
			6
		}
	},
	[1007] = {
		UserAction = 5,
		Quality = 3,
		Id = 1007,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038424),
		ItemTips = getI18NValue(180038423),
		ActionParams = {
			9
		}
	},
	[1008] = {
		UserAction = 5,
		Quality = 3,
		Id = 1008,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038426),
		ItemTips = getI18NValue(180038425),
		ActionParams = {
			10
		}
	},
	[1009] = {
		UserAction = 5,
		Quality = 3,
		Id = 1009,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038428),
		ItemTips = getI18NValue(180038427),
		ActionParams = {
			11
		}
	},
	[1010] = {
		UserAction = 5,
		Quality = 3,
		Id = 1010,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038430),
		ItemTips = getI18NValue(180038429),
		ActionParams = {
			12
		}
	},
	[1011] = {
		UserAction = 5,
		Quality = 3,
		Id = 1011,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038432),
		ItemTips = getI18NValue(180038431),
		ActionParams = {
			13
		}
	},
	[1012] = {
		UserAction = 5,
		Quality = 3,
		Id = 1012,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038434),
		ItemTips = getI18NValue(180038433),
		ActionParams = {
			15
		}
	},
	[1013] = {
		UserAction = 5,
		Quality = 3,
		Id = 1013,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038436),
		ItemTips = getI18NValue(180038435),
		ActionParams = {
			16
		}
	},
	[1014] = {
		UserAction = 5,
		Quality = 3,
		Id = 1014,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038438),
		ItemTips = getI18NValue(180038437),
		ActionParams = {
			17
		}
	},
	[1015] = {
		UserAction = 5,
		Quality = 3,
		Id = 1015,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038440),
		ItemTips = getI18NValue(180038439),
		ActionParams = {
			18
		}
	},
	[1016] = {
		UserAction = 5,
		Quality = 3,
		Id = 1016,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038442),
		ItemTips = getI18NValue(180038441),
		ActionParams = {
			19
		}
	},
	[1017] = {
		UserAction = 5,
		Quality = 3,
		Id = 1017,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038444),
		ItemTips = getI18NValue(180038443),
		ActionParams = {
			20
		}
	},
	[1018] = {
		UserAction = 5,
		Quality = 3,
		Id = 1018,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038446),
		ItemTips = getI18NValue(180038445),
		ActionParams = {
			21
		}
	},
	[1019] = {
		UserAction = 5,
		Quality = 3,
		Id = 1019,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038448),
		ItemTips = getI18NValue(180038447),
		ActionParams = {
			22
		}
	},
	[1020] = {
		UserAction = 5,
		Quality = 3,
		Id = 1020,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038450),
		ItemTips = getI18NValue(180038449),
		ActionParams = {
			23
		}
	},
	[1021] = {
		UserAction = 5,
		Quality = 3,
		Id = 1021,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038452),
		ItemTips = getI18NValue(180038451),
		ActionParams = {
			24
		}
	},
	[1022] = {
		UserAction = 5,
		Quality = 3,
		Id = 1022,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038454),
		ItemTips = getI18NValue(180038453),
		ActionParams = {
			25
		}
	},
	[1023] = {
		UserAction = 5,
		Quality = 3,
		Id = 1023,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038456),
		ItemTips = getI18NValue(180038455),
		ActionParams = {
			26
		}
	},
	[1024] = {
		UserAction = 5,
		Quality = 3,
		Id = 1024,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038458),
		ItemTips = getI18NValue(180038457),
		ActionParams = {
			27
		}
	},
	[1025] = {
		UserAction = 5,
		Quality = 3,
		Id = 1025,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180038460),
		ItemTips = getI18NValue(180038459),
		ActionParams = {
			28
		}
	},
	[1026] = {
		UserAction = 12,
		Quality = 5,
		Id = 1026,
		OverMode = 1,
		ItemTypes = 20,
		Icon = "/Item/Icon_MonthCardImg_01.png",
		MaxNum = 1,
		UseType = 1,
		BigIcon = "/Item/Icon_MonthCardImg_01.png",
		Name = getI18NValue(180038462),
		ItemTips = getI18NValue(180038461),
		ActionParams = {
			30
		}
	},
	[1027] = {
		Quality = 2,
		Id = 1027,
		IsHide = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemBag_003.png",
		MaxNum = 1,
		ItemTypes = 20,
		BigIcon = "/Item/Icon_ItemBag_003.png",
		Name = getI18NValue(180038464),
		ItemTips = getI18NValue(180038463)
	},
	[1028] = {
		Quality = 2,
		Id = 1028,
		IsHide = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemBag_003.png",
		MaxNum = 1,
		ItemTypes = 20,
		BigIcon = "/Item/Icon_ItemBag_003.png",
		Name = getI18NValue(180038466),
		ItemTips = getI18NValue(180038465)
	},
	[1029] = {
		UserAction = 5,
		Quality = 3,
		Id = 1029,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180202620),
		ItemTips = getI18NValue(180202619),
		ActionParams = {
			31
		}
	},
	[1030] = {
		UserAction = 5,
		Quality = 3,
		Id = 1030,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180212724),
		ItemTips = getI18NValue(180212723),
		ActionParams = {
			32
		}
	},
	[1031] = {
		UserAction = 5,
		Quality = 3,
		Id = 1031,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180212726),
		ItemTips = getI18NValue(180212725),
		ActionParams = {
			33
		}
	},
	[1032] = {
		UserAction = 5,
		Quality = 3,
		Id = 1032,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180216543),
		ItemTips = getI18NValue(180216542),
		ActionParams = {
			30
		}
	},
	[1033] = {
		UserAction = 5,
		Quality = 3,
		Id = 1033,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180217292),
		ItemTips = getI18NValue(180217291),
		ActionParams = {
			34
		}
	},
	[1034] = {
		UserAction = 5,
		Quality = 3,
		Id = 1034,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180237482),
		ItemTips = getI18NValue(180237481),
		ActionParams = {
			35
		}
	},
	[1035] = {
		UserAction = 5,
		Quality = 3,
		Id = 1035,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180244191),
		ItemTips = getI18NValue(180244190),
		ActionParams = {
			37
		}
	},
	[1036] = {
		UserAction = 5,
		Quality = 3,
		Id = 1036,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180253371),
		ItemTips = getI18NValue(180253370),
		ActionParams = {
			38
		}
	},
	[1037] = {
		UserAction = 5,
		Quality = 3,
		Id = 1037,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180254085),
		ItemTips = getI18NValue(180254084),
		ActionParams = {
			39
		}
	},
	[1038] = {
		UserAction = 5,
		Quality = 3,
		Id = 1038,
		IsHide = 1,
		ItemTypes = 20,
		OverMode = 1,
		UseType = 1,
		Name = getI18NValue(180255681),
		ItemTips = getI18NValue(180255680),
		ActionParams = {
			36
		}
	},
	[1039] = {
		UserAction = 46,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 1039,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260506),
		ActionParams = {
			102
		}
	},
	[1100] = {
		Quality = 4,
		Id = 1100,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Rename.png",
		MaxNum = 99,
		Reveal = true,
		SmallIcon = "/Item/Icon_Currency_Small_Coins.png",
		ItemTypes = 20,
		BigIcon = "/Item/Icon_Item_Rename.png",
		Name = getI18NValue(180038468),
		ItemTips = getI18NValue(180038467)
	},
	[1101] = {
		Id = 1101,
		Quality = 4,
		OverMode = 1,
		MaxNum = 999,
		Icon = "/Item/Icon_ItemHero_01.png",
		Reveal = true,
		SmallIcon = "/Item/Icon_ItemHero_01.png",
		BigIcon = "/Item/Icon_ItemHero_01.png",
		ItemSubTypes = 11,
		DepotType = 5,
		Name = getI18NValue(180038470),
		ItemTips = getI18NValue(180038469)
	},
	[1102] = {
		Id = 1102,
		Quality = 5,
		OverMode = 1,
		MaxNum = 999,
		Icon = "/Item/Icon_ItemHero_02.png",
		Reveal = true,
		SmallIcon = "/Item/Icon_ItemHero_02.png",
		BigIcon = "/Item/Icon_ItemHero_02.png",
		ItemSubTypes = 11,
		DepotType = 5,
		Name = getI18NValue(180038472),
		ItemTips = getI18NValue(180038471)
	},
	[1103] = {
		Id = 1103,
		Quality = 5,
		OverMode = 1,
		MaxNum = 999,
		Icon = "/Item/Icon_Item_MazeUpdate.png",
		Star = false,
		Reveal = false,
		SmallIcon = "/Item/Icon_Item_MazeUpdate.png",
		BigIcon = "/Item/Icon_Item_MazeUpdate.png",
		Name = getI18NValue(180038474),
		ItemTips = getI18NValue(180038473)
	},
	[1500] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1500,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_3_001.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_3_001.png",
		ItemSubTypes = 3,
		DepotType = 15,
		Name = getI18NValue(180038476),
		ItemTips = getI18NValue(180038475)
	},
	[1501] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1501,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_2_002.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_2_002.png",
		ItemSubTypes = 2,
		DepotType = 15,
		Name = getI18NValue(180019320),
		ItemTips = getI18NValue(180019319)
	},
	[1502] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1502,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_2_003.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_2_003.png",
		ItemSubTypes = 2,
		DepotType = 15,
		Name = getI18NValue(180019322),
		ItemTips = getI18NValue(180019321)
	},
	[1503] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1503,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_2_004.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_2_004.png",
		ItemSubTypes = 2,
		DepotType = 15,
		Name = getI18NValue(180019324),
		ItemTips = getI18NValue(180019323)
	},
	[1504] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1504,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_2_005.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_2_005.png",
		ItemSubTypes = 2,
		DepotType = 15,
		Name = getI18NValue(180019326),
		ItemTips = getI18NValue(180019325)
	},
	[1505] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1505,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_2_001.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_2_001.png",
		ItemSubTypes = 2,
		DepotType = 15,
		Name = getI18NValue(180019328),
		ItemTips = getI18NValue(180019327)
	},
	[1506] = {
		ItemTypes = 18,
		Quality = 3,
		Id = 1506,
		OverMode = 1,
		Icon = "/DisplaysIcon_Small/Display_Icon_2_006.png",
		MaxNum = 1,
		BigIcon = "/DisplaysIcon_Big/Display_Image_2_006.png",
		ItemSubTypes = 2,
		DepotType = 15,
		Name = getI18NValue(180026970),
		ItemTips = getI18NValue(180026969)
	},
	[1600] = {
		Id = 1600,
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/1601.png",
		MaxNum = 1,
		BigIcon = "/Item/1601.png",
		ItemSubTypes = 15,
		Name = getI18NValue(180260982),
		ItemTips = getI18NValue(180260981)
	},
	[1601] = {
		Id = 1601,
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/1601.png",
		MaxNum = 1,
		BigIcon = "/Item/1601.png",
		ItemSubTypes = 15,
		Name = getI18NValue(180260151),
		ItemTips = getI18NValue(180260150)
	},
	[1602] = {
		Id = 1602,
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/1602.png",
		MaxNum = 1,
		BigIcon = "/Item/1602.png",
		ItemSubTypes = 15,
		Name = getI18NValue(180260153),
		ItemTips = getI18NValue(180260152)
	},
	[1603] = {
		Id = 1603,
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/1603.png",
		MaxNum = 1,
		BigIcon = "/Item/1603.png",
		ItemSubTypes = 15,
		Name = getI18NValue(180260155),
		ItemTips = getI18NValue(180260154)
	},
	[1604] = {
		Icon = "/Item/1604.png",
		Quality = 5,
		OverMode = 1,
		Id = 1604,
		BigIcon = "/Item/1604.png",
		ItemSubTypes = 15,
		MaxNum = 1,
		Name = getI18NValue(180260983)
	},
	[1605] = {
		Id = 1605,
		Quality = 5,
		OverMode = 1,
		Icon = "/Item/1605.png",
		MaxNum = 1,
		BigIcon = "/Item/1605.png",
		ItemSubTypes = 15,
		Name = getI18NValue(180263170),
		ItemTips = getI18NValue(180263169)
	},
	[3000] = {
		Quality = 5,
		Id = 3000,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_LargeItem_05.png",
		Star = false,
		MaxNum = 9999,
		SmallIcon = "/Item/Icon_Currency_SmallOther_10.png",
		BigIcon = "/Item/Icon_LargeItem_05.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180017286),
		ItemTips = getI18NValue(180017285),
		ItemStory = getI18NValue(180038477)
	},
	[3001] = {
		Id = 3001,
		Quality = 5,
		OverMode = 1,
		MaxNum = 9999,
		Icon = "/Item/Icon_LargeItem_06.png",
		Star = false,
		Reveal = true,
		SmallIcon = "/Item/Icon_Currency_SmallOther_11.png",
		BigIcon = "/Item/Icon_LargeItem_06.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180017288),
		ItemTips = getI18NValue(180017287)
	},
	[3002] = {
		Quality = 5,
		Id = 3002,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_LargeItem_07.png",
		Star = false,
		MaxNum = 9999,
		SmallIcon = "/Item/Icon_Currency_SmallOther_12.png",
		BigIcon = "/Item/Icon_LargeItem_07.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022503),
		ItemTips = getI18NValue(180022502),
		ItemStory = getI18NValue(180038478)
	},
	[3003] = {
		Quality = 5,
		Id = 3003,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_LargeItem_08.png",
		Star = false,
		MaxNum = 9999,
		SmallIcon = "/Item/Icon_Currency_SmallOther_13.png",
		BigIcon = "/Item/Icon_LargeItem_08.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180206652),
		ItemTips = getI18NValue(180206650),
		ItemStory = getI18NValue(180206651)
	},
	[3004] = {
		Quality = 5,
		Id = 3004,
		OverMode = 1,
		Reveal = true,
		Icon = "/Item/Icon_LargeItem_09.png",
		Star = false,
		MaxNum = 9999,
		SmallIcon = "/Item/Icon_Currency_SmallOther_15.png",
		BigIcon = "/Item/Icon_LargeItem_09.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259502),
		ItemTips = getI18NValue(180259500),
		ItemStory = getI18NValue(180259501)
	},
	[10001] = {
		UserAction = 4,
		Quality = 5,
		Id = 10001,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9001.png",
		LikeId = 10000001,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9001.png",
		DepotType = 5,
		Name = getI18NValue(180002085),
		ItemTips = getI18NValue(180002084),
		ActionParams = {
			10000001
		},
		Source = {
			10202002
		}
	},
	[10002] = {
		UserAction = 4,
		Quality = 5,
		Id = 10002,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9002.png",
		LikeId = 10000002,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9002.png",
		DepotType = 5,
		Name = getI18NValue(180002087),
		ItemTips = getI18NValue(180002086),
		ActionParams = {
			10000002
		},
		Source = {
			10202002
		}
	},
	[10003] = {
		UserAction = 4,
		Quality = 4,
		Id = 10003,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9003.png",
		LikeId = 10000003,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9003.png",
		DepotType = 5,
		Name = getI18NValue(180002089),
		ItemTips = getI18NValue(180002088),
		ActionParams = {
			10000003
		},
		Source = {
			10202002
		}
	},
	[10004] = {
		UserAction = 4,
		Quality = 5,
		Id = 10004,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9004.png",
		LikeId = 10000004,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9004.png",
		DepotType = 5,
		Name = getI18NValue(180002091),
		ItemTips = getI18NValue(180002090),
		ActionParams = {
			10000004
		},
		Source = {
			10202002
		}
	},
	[10005] = {
		UserAction = 4,
		Quality = 5,
		Id = 10005,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9005.png",
		LikeId = 10000005,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9005.png",
		DepotType = 5,
		Name = getI18NValue(180002093),
		ItemTips = getI18NValue(180002092),
		ActionParams = {
			10000005
		},
		Source = {
			10202002
		}
	},
	[10006] = {
		UserAction = 4,
		Quality = 5,
		Id = 10006,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9006.png",
		LikeId = 10000006,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9006.png",
		DepotType = 5,
		Name = getI18NValue(180002095),
		ItemTips = getI18NValue(180002094),
		ActionParams = {
			10000006
		},
		Source = {
			10202002
		}
	},
	[10007] = {
		UserAction = 4,
		Quality = 5,
		Id = 10007,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9007.png",
		LikeId = 10000007,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9007.png",
		DepotType = 5,
		Name = getI18NValue(180002097),
		ItemTips = getI18NValue(180002096),
		ActionParams = {
			10000007
		},
		Source = {
			10202002
		}
	},
	[10008] = {
		UserAction = 4,
		Quality = 4,
		Id = 10008,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9008.png",
		LikeId = 10000008,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9008.png",
		DepotType = 5,
		Name = getI18NValue(180002099),
		ItemTips = getI18NValue(180002098),
		ActionParams = {
			10000008
		},
		Source = {
			10202002
		}
	},
	[10009] = {
		UserAction = 4,
		Quality = 5,
		Id = 10009,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9009.png",
		LikeId = 10000009,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9009.png",
		DepotType = 5,
		Name = getI18NValue(180002101),
		ItemTips = getI18NValue(180002100),
		ActionParams = {
			10000009
		},
		Source = {
			10202002
		}
	},
	[10010] = {
		UserAction = 4,
		Quality = 4,
		Id = 10010,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9010.png",
		LikeId = 10000010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9010.png",
		DepotType = 5,
		Name = getI18NValue(180002103),
		ItemTips = getI18NValue(180002102),
		ActionParams = {
			10000010
		},
		Source = {
			10202002
		}
	},
	[10011] = {
		UserAction = 4,
		Quality = 4,
		Id = 10011,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9011.png",
		LikeId = 10000011,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9011.png",
		DepotType = 5,
		Name = getI18NValue(180002105),
		ItemTips = getI18NValue(180002104),
		ActionParams = {
			10000011
		},
		Source = {
			10202002
		}
	},
	[10012] = {
		UserAction = 4,
		Quality = 4,
		Id = 10012,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9012.png",
		LikeId = 10000012,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9012.png",
		DepotType = 5,
		Name = getI18NValue(180002107),
		ItemTips = getI18NValue(180002106),
		ActionParams = {
			10000012
		},
		Source = {
			10202002
		}
	},
	[10013] = {
		UserAction = 4,
		Quality = 4,
		Id = 10013,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9013.png",
		LikeId = 10000013,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9013.png",
		DepotType = 5,
		Name = getI18NValue(180002109),
		ItemTips = getI18NValue(180002108),
		ActionParams = {
			10000013
		},
		Source = {
			10202002
		}
	},
	[10014] = {
		UserAction = 4,
		Quality = 5,
		Id = 10014,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9014.png",
		LikeId = 10000014,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9014.png",
		DepotType = 5,
		Name = getI18NValue(180002111),
		ItemTips = getI18NValue(180002110),
		ActionParams = {
			10000014
		},
		Source = {
			10202002
		}
	},
	[10015] = {
		UserAction = 4,
		Quality = 5,
		Id = 10015,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9015.png",
		LikeId = 10000015,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9015.png",
		DepotType = 5,
		Name = getI18NValue(180002113),
		ItemTips = getI18NValue(180002112),
		ActionParams = {
			10000015
		},
		Source = {
			10202002
		}
	},
	[10016] = {
		UserAction = 4,
		Quality = 5,
		Id = 10016,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9016.png",
		LikeId = 10000016,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9016.png",
		DepotType = 5,
		Name = getI18NValue(180002115),
		ItemTips = getI18NValue(180002114),
		ActionParams = {
			10000016
		},
		Source = {
			10202002
		}
	},
	[10017] = {
		UserAction = 4,
		Quality = 4,
		Id = 10017,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9017.png",
		LikeId = 10000017,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9017.png",
		DepotType = 5,
		Name = getI18NValue(180002117),
		ItemTips = getI18NValue(180002116),
		ActionParams = {
			10000017
		},
		Source = {
			10202002
		}
	},
	[10018] = {
		UserAction = 4,
		Quality = 4,
		Id = 10018,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9018.png",
		LikeId = 10000018,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9018.png",
		DepotType = 5,
		Name = getI18NValue(180002119),
		ItemTips = getI18NValue(180002118),
		ActionParams = {
			10000018
		},
		Source = {
			10202002
		}
	},
	[10019] = {
		UserAction = 4,
		Quality = 5,
		Id = 10019,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9019.png",
		LikeId = 10000019,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9019.png",
		DepotType = 5,
		Name = getI18NValue(180002121),
		ItemTips = getI18NValue(180002120),
		ActionParams = {
			10000019
		},
		Source = {
			10202002
		}
	},
	[10020] = {
		UserAction = 4,
		Quality = 5,
		Id = 10020,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9020.png",
		LikeId = 10000020,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9020.png",
		DepotType = 5,
		Name = getI18NValue(180002123),
		ItemTips = getI18NValue(180002122),
		ActionParams = {
			10000020
		},
		Source = {
			10202002
		}
	},
	[10021] = {
		UserAction = 4,
		Quality = 4,
		Id = 10021,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9021.png",
		LikeId = 10000021,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9021.png",
		DepotType = 5,
		Name = getI18NValue(180002125),
		ItemTips = getI18NValue(180002124),
		ActionParams = {
			10000021
		},
		Source = {
			10202002
		}
	},
	[10022] = {
		UserAction = 4,
		Quality = 4,
		Id = 10022,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9022.png",
		LikeId = 10000022,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9022.png",
		DepotType = 5,
		Name = getI18NValue(180002127),
		ItemTips = getI18NValue(180002126),
		ActionParams = {
			10000022
		},
		Source = {
			10202002
		}
	},
	[10023] = {
		UserAction = 4,
		Quality = 5,
		Id = 10023,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9023.png",
		LikeId = 10000023,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9023.png",
		DepotType = 5,
		Name = getI18NValue(180002129),
		ItemTips = getI18NValue(180002128),
		ActionParams = {
			10000023
		},
		Source = {
			10202002
		}
	},
	[10024] = {
		UserAction = 4,
		Quality = 5,
		Id = 10024,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9024.png",
		LikeId = 10000024,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9024.png",
		DepotType = 5,
		Name = getI18NValue(180038480),
		ItemTips = getI18NValue(180038479),
		ActionParams = {
			10000024
		},
		Source = {
			10202002
		}
	},
	[10025] = {
		UserAction = 4,
		Quality = 5,
		Id = 10025,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9025.png",
		LikeId = 10000025,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9025.png",
		DepotType = 5,
		Name = getI18NValue(180038482),
		ItemTips = getI18NValue(180038481),
		ActionParams = {
			10000025
		},
		Source = {
			10202002
		}
	},
	[10026] = {
		UserAction = 4,
		Quality = 5,
		Id = 10026,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9026.png",
		LikeId = 10000026,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9026.png",
		DepotType = 5,
		Name = getI18NValue(180038484),
		ItemTips = getI18NValue(180038483),
		ActionParams = {
			10000026
		},
		Source = {
			10202002
		}
	},
	[10027] = {
		UserAction = 4,
		Quality = 5,
		Id = 10027,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9027.png",
		LikeId = 10000027,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9027.png",
		DepotType = 5,
		Name = getI18NValue(180038486),
		ItemTips = getI18NValue(180038485),
		ActionParams = {
			10000027
		},
		Source = {
			10202002
		}
	},
	[10028] = {
		UserAction = 4,
		Quality = 5,
		Id = 10028,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9028.png",
		LikeId = 10000028,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9028.png",
		DepotType = 5,
		Name = getI18NValue(180038488),
		ItemTips = getI18NValue(180038487),
		ActionParams = {
			10000028
		},
		Source = {
			10202002
		}
	},
	[10029] = {
		UserAction = 4,
		Quality = 4,
		Id = 10029,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9029.png",
		LikeId = 10000029,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9029.png",
		DepotType = 5,
		Name = getI18NValue(180038490),
		ItemTips = getI18NValue(180038489),
		ActionParams = {
			10000029
		},
		Source = {
			10202002
		}
	},
	[10030] = {
		UserAction = 4,
		Quality = 4,
		ItemTypes = 2,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_ItemHero_9030.png",
		LikeId = 10000030,
		UseType = 1,
		Id = 10030,
		BigIcon = "/Item/Icon_ItemHero_9030.png",
		DepotType = 5,
		Name = getI18NValue(180038491),
		ActionParams = {
			10000030
		},
		Source = {
			10202002
		}
	},
	[10031] = {
		UserAction = 4,
		Quality = 4,
		Id = 10031,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9031.png",
		LikeId = 10000031,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9031.png",
		DepotType = 5,
		Name = getI18NValue(180038493),
		ItemTips = getI18NValue(180038492),
		ActionParams = {
			10000031
		},
		Source = {
			10202002
		}
	},
	[10032] = {
		UserAction = 4,
		Quality = 4,
		Id = 10032,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10000032,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		DepotType = 5,
		Name = getI18NValue(180038495),
		ItemTips = getI18NValue(180038494),
		ActionParams = {
			10000032
		},
		Source = {
			10202002
		}
	},
	[10033] = {
		UserAction = 4,
		Quality = 5,
		Id = 10033,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9033.png",
		LikeId = 10000033,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9033.png",
		DepotType = 5,
		Name = getI18NValue(180166470),
		ItemTips = getI18NValue(180166469),
		ActionParams = {
			10000033
		},
		Source = {
			10202002
		}
	},
	[10034] = {
		UserAction = 4,
		Quality = 5,
		Id = 10034,
		OverMode = 1,
		ItemTypes = 2,
		Icon = "/Item/Icon_ItemHero_9034.png",
		LikeId = 10000034,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemHero_9034.png",
		DepotType = 5,
		Name = getI18NValue(180167374),
		ItemTips = getI18NValue(180167373),
		ActionParams = {
			10000034
		},
		Source = {
			10202002
		}
	},
	[12001] = {
		Id = 12001,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12001_small.png",
		LikeId = 10000001,
		Reveal = true,
		BigIcon = "/Item/12001_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180002229),
		ItemTips = getI18NValue(180002228),
		Source = {
			10202002
		}
	},
	[12002] = {
		Id = 12002,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12002_small.png",
		LikeId = 10000002,
		Reveal = true,
		BigIcon = "/Item/12002_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180002231),
		ItemTips = getI18NValue(180002230),
		Source = {
			10202002
		}
	},
	[12003] = {
		Id = 12003,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12003_small.png",
		LikeId = 10000003,
		Reveal = true,
		BigIcon = "/Item/12003_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180002233),
		ItemTips = getI18NValue(180002232),
		Source = {
			10202002
		}
	},
	[12004] = {
		Id = 12004,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12004_small.png",
		LikeId = 10000004,
		Reveal = true,
		BigIcon = "/Item/12004_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017290),
		ItemTips = getI18NValue(180017289),
		Source = {
			10202002
		}
	},
	[12005] = {
		Id = 12005,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12005_small.png",
		LikeId = 10000005,
		Reveal = true,
		BigIcon = "/Item/12005_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017292),
		ItemTips = getI18NValue(180017291),
		Source = {
			10202002
		}
	},
	[12006] = {
		Id = 12006,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12006_small.png",
		LikeId = 10000006,
		Reveal = true,
		BigIcon = "/Item/12006_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017294),
		ItemTips = getI18NValue(180017293),
		Source = {
			10202002
		}
	},
	[12007] = {
		Id = 12007,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12007_small.png",
		LikeId = 10000007,
		Reveal = true,
		BigIcon = "/Item/12007_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017296),
		ItemTips = getI18NValue(180017295),
		Source = {
			10202002
		}
	},
	[12008] = {
		Id = 12008,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12008_small.png",
		LikeId = 10000008,
		Reveal = true,
		BigIcon = "/Item/12008_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017298),
		ItemTips = getI18NValue(180017297),
		Source = {
			10202002
		}
	},
	[12009] = {
		Id = 12009,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12009_small.png",
		LikeId = 10000009,
		Reveal = true,
		BigIcon = "/Item/12009_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017300),
		ItemTips = getI18NValue(180017299),
		Source = {
			10202002
		}
	},
	[12010] = {
		Id = 12010,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12010_small.png",
		LikeId = 10000010,
		Reveal = true,
		BigIcon = "/Item/12010_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017302),
		ItemTips = getI18NValue(180017301),
		Source = {
			10202002
		}
	},
	[12011] = {
		Id = 12011,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12011_small.png",
		LikeId = 10000011,
		Reveal = true,
		BigIcon = "/Item/12011_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017304),
		ItemTips = getI18NValue(180017303),
		Source = {
			10202002
		}
	},
	[12012] = {
		Id = 12012,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12012_small.png",
		LikeId = 10000012,
		Reveal = true,
		BigIcon = "/Item/12012_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017306),
		ItemTips = getI18NValue(180017305)
	},
	[12013] = {
		Id = 12013,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12013_small.png",
		LikeId = 10000013,
		Reveal = true,
		BigIcon = "/Item/12013_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017308),
		ItemTips = getI18NValue(180017307),
		Source = {
			10202002
		}
	},
	[12014] = {
		Id = 12014,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12014_small.png",
		LikeId = 10000014,
		Reveal = true,
		BigIcon = "/Item/12014_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017310),
		ItemTips = getI18NValue(180017309),
		Source = {
			10202002
		}
	},
	[12015] = {
		Id = 12015,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12015_small.png",
		LikeId = 10000015,
		Reveal = true,
		BigIcon = "/Item/12015_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017312),
		ItemTips = getI18NValue(180017311),
		Source = {
			10202002
		}
	},
	[12016] = {
		Id = 12016,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12016_small.png",
		LikeId = 10000016,
		Reveal = true,
		BigIcon = "/Item/12016_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017314),
		ItemTips = getI18NValue(180017313),
		Source = {
			10202002
		}
	},
	[12017] = {
		Id = 12017,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12017_small.png",
		LikeId = 10000017,
		Reveal = true,
		BigIcon = "/Item/12017_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017316),
		ItemTips = getI18NValue(180017315),
		Source = {
			10202002
		}
	},
	[12018] = {
		Id = 12018,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12018_small.png",
		LikeId = 10000018,
		Reveal = true,
		BigIcon = "/Item/12018_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017318),
		ItemTips = getI18NValue(180017317),
		Source = {
			10202002
		}
	},
	[12019] = {
		Id = 12019,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12019_small.png",
		LikeId = 10000019,
		Reveal = true,
		BigIcon = "/Item/12019_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017320),
		ItemTips = getI18NValue(180017319),
		Source = {
			10202002
		}
	},
	[12020] = {
		Id = 12020,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12020_small.png",
		LikeId = 10000020,
		Reveal = true,
		BigIcon = "/Item/12020_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017322),
		ItemTips = getI18NValue(180017321),
		Source = {
			10202002
		}
	},
	[12021] = {
		Id = 12021,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12021_small.png",
		LikeId = 10000021,
		Reveal = true,
		BigIcon = "/Item/12021_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017324),
		ItemTips = getI18NValue(180017323),
		Source = {
			10202002
		}
	},
	[12022] = {
		Id = 12022,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12022_small.png",
		LikeId = 10000022,
		Reveal = true,
		BigIcon = "/Item/12022_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017326),
		ItemTips = getI18NValue(180017325),
		Source = {
			10202002
		}
	},
	[12023] = {
		Id = 12023,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12023_small.png",
		LikeId = 10000023,
		Reveal = true,
		BigIcon = "/Item/12023_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180017328),
		ItemTips = getI18NValue(180017327),
		Source = {
			10202002
		}
	},
	[12024] = {
		Id = 12024,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12024_small.png",
		LikeId = 10000024,
		Reveal = true,
		BigIcon = "/Item/12024_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038497),
		ItemTips = getI18NValue(180038496),
		Source = {
			10202002
		}
	},
	[12025] = {
		Id = 12025,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12025_small.png",
		LikeId = 10000025,
		Reveal = true,
		BigIcon = "/Item/12025_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038499),
		ItemTips = getI18NValue(180038498),
		Source = {
			10202002
		}
	},
	[12026] = {
		Id = 12026,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12026_small.png",
		LikeId = 10000026,
		Reveal = true,
		BigIcon = "/Item/12026_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038501),
		ItemTips = getI18NValue(180038500),
		Source = {
			10202002
		}
	},
	[12027] = {
		Id = 12027,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12027_small.png",
		LikeId = 10000027,
		Reveal = true,
		BigIcon = "/Item/12027_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038503),
		ItemTips = getI18NValue(180038502),
		Source = {
			10202002
		}
	},
	[12028] = {
		Id = 12028,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12028_small.png",
		LikeId = 10000028,
		Reveal = true,
		BigIcon = "/Item/12028_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038505),
		ItemTips = getI18NValue(180038504),
		Source = {
			10202002
		}
	},
	[12029] = {
		Id = 12029,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12029_small.png",
		LikeId = 10000029,
		Reveal = true,
		BigIcon = "/Item/12029_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038507),
		ItemTips = getI18NValue(180038506),
		Source = {
			10202002
		}
	},
	[12030] = {
		Id = 12030,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12030_small.png",
		LikeId = 10000030,
		Reveal = true,
		BigIcon = "/Item/12030_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038509),
		ItemTips = getI18NValue(180038508),
		Source = {
			10202002
		}
	},
	[12031] = {
		Id = 12031,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12031_small.png",
		LikeId = 10000031,
		Reveal = true,
		BigIcon = "/Item/12031_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038511),
		ItemTips = getI18NValue(180038510),
		Source = {
			10202002
		}
	},
	[12032] = {
		Id = 12032,
		Quality = 3,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12032_small.png",
		LikeId = 10000032,
		Reveal = true,
		BigIcon = "/Item/12032_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180038513),
		ItemTips = getI18NValue(180038512),
		Source = {
			10202002
		}
	},
	[12033] = {
		Id = 12033,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12033_small.png",
		LikeId = 10000033,
		Reveal = true,
		BigIcon = "/Item/12033_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180166449),
		ItemTips = getI18NValue(180166448),
		Source = {
			10202002
		}
	},
	[12034] = {
		Id = 12034,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/12034_small.png",
		LikeId = 10000034,
		Reveal = true,
		BigIcon = "/Item/12034_big.png",
		ItemSubTypes = 2,
		DepotType = 5,
		Name = getI18NValue(180167376),
		ItemTips = getI18NValue(180167375),
		Source = {
			10202002
		}
	},
	[15000] = {
		Id = 15000,
		Quality = 5,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_MazeFireThunder_001.png",
		Star = false,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_MazeFireThunder_001.png",
		ItemSubTypes = 4,
		DepotType = 2,
		Name = getI18NValue(180223877),
		ItemTips = getI18NValue(180223876),
		Source = {
			10201100,
			30000000,
			20000074,
			20000076,
			20000077
		}
	},
	[15001] = {
		Id = 15001,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ElementProperty_103.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_03.png",
		ItemSubTypes = 4,
		DepotType = 2,
		Name = getI18NValue(180223879),
		ItemTips = getI18NValue(180223878),
		Source = {
			11206100
		}
	},
	[15002] = {
		Id = 15002,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ElementProperty_106.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_06.png",
		ItemSubTypes = 4,
		DepotType = 2,
		Name = getI18NValue(180223881),
		ItemTips = getI18NValue(180223880),
		Source = {
			11206200
		}
	},
	[15003] = {
		Id = 15003,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ElementProperty_112.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_09.png",
		ItemSubTypes = 4,
		DepotType = 2,
		Name = getI18NValue(180223883),
		ItemTips = getI18NValue(180223882),
		Source = {
			11206300
		}
	},
	[15004] = {
		Id = 15004,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ElementProperty_109.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_12.png",
		ItemSubTypes = 4,
		DepotType = 2,
		Name = getI18NValue(180223885),
		ItemTips = getI18NValue(180223884),
		Source = {
			11206400
		}
	},
	[15011] = {
		Id = 15011,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Skill_BreakProperty_104.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_104.png",
		ItemSubTypes = 5,
		DepotType = 2,
		Name = getI18NValue(180223887),
		ItemTips = getI18NValue(180223886),
		Source = {
			11205100
		}
	},
	[15012] = {
		Id = 15012,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Skill_BreakProperty_114.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_114.png",
		ItemSubTypes = 5,
		DepotType = 2,
		Name = getI18NValue(180223889),
		ItemTips = getI18NValue(180223888),
		Source = {
			11205200
		}
	},
	[15013] = {
		Id = 15013,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Skill_BreakProperty_124.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_124.png",
		ItemSubTypes = 5,
		DepotType = 2,
		Name = getI18NValue(180223891),
		ItemTips = getI18NValue(180223890),
		Source = {
			11205300
		}
	},
	[15014] = {
		Id = 15014,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Skill_BreakProperty_134.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_134.png",
		ItemSubTypes = 5,
		DepotType = 2,
		Name = getI18NValue(180223893),
		ItemTips = getI18NValue(180223892),
		Source = {
			11205400
		}
	},
	[15015] = {
		Id = 15015,
		Quality = 5,
		MaxNum = 20,
		OverMode = 1,
		Icon = "/Item/Icon_Skill_BreakProperty_002.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Skill_BreakProperty_002.png",
		ItemSubTypes = 5,
		DepotType = 2,
		Name = getI18NValue(180264501),
		ItemTips = getI18NValue(180264500),
		Source = {
			20000001
		}
	},
	[15021] = {
		Id = 15021,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_BreakProperty_032.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Item_BreakProperty_032.png",
		DepotType = 2,
		Name = getI18NValue(180223895),
		ItemTips = getI18NValue(180223894),
		Source = {
			11202620
		}
	},
	[15022] = {
		Id = 15022,
		Quality = 5,
		Reveal = true,
		OverMode = 1,
		MaxNum = 99,
		Icon = "/Item/Icon_Item_BreakProperty_032.png",
		BigIcon = "/Item/Icon_Item_BreakProperty_032.png",
		DepotType = 2,
		Name = getI18NValue(180223898),
		ItemTips = getI18NValue(180223896),
		ItemStory = getI18NValue(180223897)
	},
	[15031] = {
		Id = 15031,
		Quality = 5,
		Reveal = true,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_Item_BreakProperty_034.png",
		BigIcon = "/Item/Icon_Item_BreakProperty_034.png",
		ItemSubTypes = 13,
		DepotType = 2,
		Name = getI18NValue(180223901),
		ItemTips = getI18NValue(180223899),
		ItemStory = getI18NValue(180223900),
		Source = {
			20000031
		}
	},
	[15032] = {
		Id = 15032,
		Quality = 4,
		Reveal = true,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_Item_BreakProperty_033.png",
		BigIcon = "/Item/Icon_Item_BreakProperty_033.png",
		ItemSubTypes = 13,
		DepotType = 2,
		Name = getI18NValue(180223904),
		ItemTips = getI18NValue(180223902),
		ItemStory = getI18NValue(180223903),
		Source = {
			20000031
		}
	},
	[16001] = {
		UserAction = 13,
		Quality = 1,
		Id = 16001,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_11.png",
		MaxNum = 999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_Favorable_11.png",
		ItemSubTypes = 3,
		DepotType = 2,
		Name = getI18NValue(180017330),
		ItemTips = getI18NValue(180017329),
		ActionParams = {
			30
		}
	},
	[16002] = {
		UserAction = 13,
		Quality = 2,
		Id = 16002,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_12.png",
		MaxNum = 999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_Favorable_12.png",
		ItemSubTypes = 3,
		DepotType = 2,
		Name = getI18NValue(180017332),
		ItemTips = getI18NValue(180017331),
		ActionParams = {
			50
		}
	},
	[16003] = {
		UserAction = 13,
		Quality = 3,
		Id = 16003,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_13.png",
		MaxNum = 999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_Favorable_13.png",
		ItemSubTypes = 3,
		DepotType = 2,
		Name = getI18NValue(180017334),
		ItemTips = getI18NValue(180017333),
		ActionParams = {
			100
		}
	},
	[16004] = {
		UserAction = 13,
		Quality = 4,
		Id = 16004,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_14.png",
		MaxNum = 999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_Favorable_14.png",
		ItemSubTypes = 3,
		DepotType = 2,
		Name = getI18NValue(180017336),
		ItemTips = getI18NValue(180017335),
		ActionParams = {
			300
		}
	},
	[16005] = {
		UserAction = 13,
		Quality = 5,
		Id = 16005,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_15.png",
		MaxNum = 999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_Favorable_15.png",
		ItemSubTypes = 3,
		DepotType = 2,
		Name = getI18NValue(180017338),
		ItemTips = getI18NValue(180017337),
		ActionParams = {
			500
		}
	},
	[40001] = {
		UserAction = 1,
		Quality = 4,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Favorable_15.png",
		Star = false,
		Reveal = false,
		ItemTypes = 6,
		MaxNum = 1,
		Sell = false,
		Id = 40001,
		BigIcon = "/Item/Icon_Item_Favorable_15.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180261642),
		ActionParams = {
			3,
			100
		}
	},
	[50001] = {
		UserAction = 3,
		Quality = 2,
		Id = 50001,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ExpProperty_01.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_ExpProperty_01.png",
		ItemSubTypes = 6,
		DepotType = 2,
		Name = getI18NValue(180002773),
		ItemTips = getI18NValue(180002772),
		ActionParams = {
			50
		},
		Source = {
			11202100
		}
	},
	[50002] = {
		UserAction = 3,
		Quality = 3,
		Id = 50002,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ExpProperty_02.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_ExpProperty_02.png",
		ItemSubTypes = 6,
		DepotType = 2,
		Name = getI18NValue(180002775),
		ItemTips = getI18NValue(180002774),
		ActionParams = {
			100
		},
		Source = {
			11202100
		}
	},
	[50003] = {
		UserAction = 3,
		Quality = 4,
		Id = 50003,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ExpProperty_03.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_ExpProperty_03.png",
		ItemSubTypes = 6,
		DepotType = 2,
		Name = getI18NValue(180002777),
		ItemTips = getI18NValue(180002776),
		ActionParams = {
			500
		},
		Source = {
			11202100
		}
	},
	[50004] = {
		UserAction = 3,
		Quality = 5,
		Id = 50004,
		OverMode = 1,
		Icon = "/Item/Icon_Item_ExpProperty_04.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_ExpProperty_04.png",
		ItemSubTypes = 6,
		DepotType = 2,
		Name = getI18NValue(180002779),
		ItemTips = getI18NValue(180002778),
		ActionParams = {
			2000
		},
		Source = {
			11202100
		}
	},
	[50011] = {
		UserAction = 7,
		Quality = 2,
		Id = 50011,
		OverMode = 1,
		Icon = "/Item/Icon_Item_EquipProperty_01.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_EquipProperty_01.png",
		ItemSubTypes = 7,
		DepotType = 2,
		Name = getI18NValue(180002793),
		ItemTips = getI18NValue(180002792),
		ActionParams = {
			500
		},
		Source = {
			10208010
		}
	},
	[50012] = {
		UserAction = 7,
		Quality = 3,
		Id = 50012,
		OverMode = 1,
		Icon = "/Item/Icon_Item_EquipProperty_02.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_EquipProperty_02.png",
		ItemSubTypes = 7,
		DepotType = 2,
		Name = getI18NValue(180002795),
		ItemTips = getI18NValue(180002794),
		ActionParams = {
			1000
		},
		Source = {
			10208010
		}
	},
	[50013] = {
		UserAction = 7,
		Quality = 4,
		Id = 50013,
		OverMode = 1,
		Icon = "/Item/Icon_Item_EquipProperty_03.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_EquipProperty_03.png",
		ItemSubTypes = 7,
		DepotType = 2,
		Name = getI18NValue(180017496),
		ItemTips = getI18NValue(180017495),
		ActionParams = {
			2000
		},
		Source = {
			10208010
		}
	},
	[50014] = {
		UserAction = 7,
		Quality = 5,
		Id = 50014,
		OverMode = 1,
		Icon = "/Item/Icon_Item_EquipProperty_04.png",
		MaxNum = 99999,
		Reveal = true,
		BigIcon = "/Item/Icon_Item_EquipProperty_04.png",
		ItemSubTypes = 7,
		DepotType = 2,
		Name = getI18NValue(180017498),
		ItemTips = getI18NValue(180017497),
		ActionParams = {
			3000
		},
		Source = {
			30000003
		}
	},
	[50031] = {
		UserAction = 6,
		Quality = 2,
		Reveal = true,
		OverMode = 1,
		Icon = "/Item/Icon_Item_SkillProperty_01.png",
		Id = 50031,
		MaxNum = 99999,
		BigIcon = "/Item/Icon_Item_SkillProperty_01.png",
		ItemSubTypes = 8,
		DepotType = 2,
		Name = getI18NValue(180017500),
		ItemTips = getI18NValue(180017499),
		ItemStory = getI18NValue(180038972),
		ActionParams = {
			100
		},
		Source = {
			11202610,
			10203005
		}
	},
	[50032] = {
		UserAction = 6,
		Quality = 3,
		Reveal = true,
		OverMode = 1,
		Icon = "/Item/Icon_Item_SkillProperty_02.png",
		Id = 50032,
		MaxNum = 99999,
		BigIcon = "/Item/Icon_Item_SkillProperty_02.png",
		ItemSubTypes = 8,
		DepotType = 2,
		Name = getI18NValue(180017502),
		ItemTips = getI18NValue(180017501),
		ItemStory = getI18NValue(180038973),
		ActionParams = {
			500
		},
		Source = {
			11202610,
			10203005
		}
	},
	[50033] = {
		UserAction = 6,
		Quality = 4,
		Reveal = true,
		OverMode = 1,
		Icon = "/Item/Icon_Item_SkillProperty_03.png",
		Id = 50033,
		MaxNum = 99999,
		BigIcon = "/Item/Icon_Item_SkillProperty_03.png",
		ItemSubTypes = 8,
		DepotType = 2,
		Name = getI18NValue(180017504),
		ItemTips = getI18NValue(180017503),
		ItemStory = getI18NValue(180038974),
		ActionParams = {
			2000
		},
		Source = {
			11202610,
			10203005
		}
	},
	[50034] = {
		UserAction = 6,
		Quality = 5,
		Reveal = true,
		OverMode = 1,
		Icon = "/Item/Icon_Item_SkillProperty_04.png",
		Id = 50034,
		MaxNum = 99999,
		BigIcon = "/Item/Icon_Item_SkillProperty_04.png",
		ItemSubTypes = 8,
		DepotType = 2,
		Name = getI18NValue(180017506),
		ItemTips = getI18NValue(180017505),
		ItemStory = getI18NValue(180038975),
		ActionParams = {
			6000
		},
		Source = {
			11202610,
			10203005
		}
	},
	[50041] = {
		Id = 50041,
		Quality = 4,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_50041.png",
		Reveal = true,
		DepotType = 16,
		Name = getI18NValue(180268552),
		ItemTips = getI18NValue(180268551)
	},
	[50042] = {
		Id = 50042,
		Quality = 5,
		MaxNum = 999,
		OverMode = 1,
		Icon = "/Item/Icon_Item_50042.png",
		Reveal = true,
		DepotType = 16,
		Name = getI18NValue(180268554),
		ItemTips = getI18NValue(180268553)
	},
	[55001] = {
		UserAction = 1,
		Quality = 4,
		UseType = 2,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Personality_01.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 99,
		Id = 55001,
		BigIcon = "/Item/Icon_Item_Personality_01.png",
		ItemSubTypes = 10,
		DepotType = 16,
		Name = getI18NValue(180017508),
		ItemTips = getI18NValue(180017507),
		ActionParams = {
			11,
			50
		}
	},
	[55002] = {
		UserAction = 1,
		Quality = 5,
		UseType = 2,
		OverMode = 1,
		Icon = "/Item/Icon_Item_Personality_02.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 99,
		Id = 55002,
		BigIcon = "/Item/Icon_Item_Personality_02.png",
		ItemSubTypes = 10,
		DepotType = 16,
		Name = getI18NValue(180017510),
		ItemTips = getI18NValue(180017509),
		ActionParams = {
			11,
			100
		}
	},
	[55003] = {
		UserAction = 1,
		Quality = 5,
		UseType = 2,
		OverMode = 2,
		Icon = "/Item/Icon_Item_Personality_01.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 99,
		Id = 55003,
		EffectiveDuration = 259200,
		BigIcon = "/Item/Icon_Item_Personality_01.png",
		ItemSubTypes = 10,
		DepotType = 16,
		Name = getI18NValue(180017512),
		ItemTips = getI18NValue(180017511),
		ActionParams = {
			11,
			50
		}
	},
	[55004] = {
		UserAction = 1,
		Quality = 2,
		UseType = 2,
		OverMode = 2,
		Icon = "/Item/Icon_Item_Personality_02.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 99,
		Id = 55004,
		EffectiveDuration = 259200,
		BigIcon = "/Item/Icon_Item_Personality_02.png",
		ItemSubTypes = 10,
		DepotType = 16,
		Name = getI18NValue(180017514),
		ItemTips = getI18NValue(180017513),
		ActionParams = {
			11,
			100
		}
	},
	[60001] = {
		UserAction = 1,
		Quality = 2,
		Id = 60001,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_002.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_002.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180017522),
		ItemTips = getI18NValue(180017521),
		ActionParams = {
			1027,
			1,
			3,
			680,
			80228,
			1
		}
	},
	[60002] = {
		UserAction = 1,
		Quality = 2,
		Id = 60002,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_002.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_002.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180017524),
		ItemTips = getI18NValue(180017523),
		ActionParams = {
			1027,
			1,
			1028,
			1,
			3,
			980,
			80228,
			1,
			55002,
			2,
			103,
			10000
		}
	},
	[60003] = {
		UserAction = 1,
		Quality = 2,
		Id = 60003,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_002.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_002.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180017526),
		ItemTips = getI18NValue(180017525),
		ActionParams = {
			1028,
			1,
			3,
			300,
			55002,
			2,
			103,
			10000
		}
	},
	[60004] = {
		UserAction = 1,
		Quality = 2,
		Id = 60004,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_CoinsBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 999,
		BigIcon = "/Item/Icon_CoinsBag_001.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180017528),
		ItemTips = getI18NValue(180017527),
		ActionParams = {
			4,
			10000
		}
	},
	[60005] = {
		UserAction = 9,
		Quality = 2,
		Id = 60005,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_002.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_002.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180129534),
		ItemTips = getI18NValue(180129533),
		ActionParams = {
			11,
			2,
			2
		}
	},
	[60006] = {
		UserAction = 9,
		Quality = 2,
		Id = 60006,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_002.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_002.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180129536),
		ItemTips = getI18NValue(180129535),
		ActionParams = {
			11,
			4,
			2
		}
	},
	[60007] = {
		UserAction = 9,
		Quality = 2,
		Id = 60007,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_002.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_002.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180129589),
		ItemTips = getI18NValue(180129588),
		ActionParams = {
			11,
			3,
			2
		}
	},
	[60008] = {
		UserAction = 1,
		Quality = 4,
		OverMode = 1,
		UseType = 1,
		Icon = "/Item/Icon_Currency_Personality.png",
		Reveal = true,
		SmallIcon = "/Item/Icon_Currency_Small_Personality.png",
		Id = 60008,
		ItemTypes = 6,
		BigIcon = "/Item/Icon_Currency_Personality.png",
		ItemSubTypes = 1,
		DepotType = 2,
		Name = getI18NValue(180131869),
		ItemTips = getI18NValue(180131868),
		ActionParams = {
			11,
			60
		}
	},
	[60021] = {
		UserAction = 29,
		Quality = 3,
		Id = 60021,
		OverMode = 1,
		ItemTypes = 21,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 999,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		DepotType = 2,
		Name = getI18NValue(180150406),
		ItemTips = getI18NValue(180150405),
		ActionParams = {
			50200001
		}
	},
	[60022] = {
		UserAction = 29,
		Quality = 3,
		Id = 60022,
		OverMode = 1,
		ItemTypes = 21,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 999,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		DepotType = 2,
		Name = getI18NValue(180150408),
		ItemTips = getI18NValue(180150407),
		ActionParams = {
			50200002
		}
	},
	[60023] = {
		UserAction = 29,
		Quality = 4,
		Id = 60023,
		OverMode = 1,
		ItemTypes = 21,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 999,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		DepotType = 2,
		Name = getI18NValue(180150410),
		ItemTips = getI18NValue(180150409),
		ActionParams = {
			50200003
		}
	},
	[60024] = {
		UserAction = 29,
		Quality = 4,
		Id = 60024,
		OverMode = 1,
		ItemTypes = 21,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 999,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		DepotType = 2,
		Name = getI18NValue(180150412),
		ItemTips = getI18NValue(180150411),
		ActionParams = {
			50200004
		}
	},
	[60025] = {
		UserAction = 29,
		Quality = 5,
		Id = 60025,
		OverMode = 1,
		ItemTypes = 21,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 999,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		DepotType = 2,
		Name = getI18NValue(180150414),
		ItemTips = getI18NValue(180150413),
		ActionParams = {
			50200005
		}
	},
	[60026] = {
		UserAction = 29,
		Quality = 5,
		Id = 60026,
		OverMode = 1,
		ItemTypes = 21,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 999,
		UseType = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		DepotType = 2,
		Name = getI18NValue(180150416),
		ItemTips = getI18NValue(180150415),
		ActionParams = {
			50200006
		}
	},
	[60100] = {
		UserAction = 19,
		Quality = 3,
		Id = 60100,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_003.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022501),
		ItemTips = getI18NValue(180022500),
		ActionParams = {
			100
		}
	},
	[60101] = {
		UserAction = 1,
		Quality = 5,
		Id = 60101,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022515),
		ItemTips = getI18NValue(180022514),
		ActionParams = {
			200151,
			1,
			200152,
			1,
			200153,
			1,
			200154,
			1
		}
	},
	[60102] = {
		UserAction = 1,
		Quality = 5,
		Id = 60102,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022517),
		ItemTips = getI18NValue(180022516),
		ActionParams = {
			200251,
			1,
			200252,
			1,
			200253,
			1,
			200254,
			1
		}
	},
	[60103] = {
		UserAction = 1,
		Quality = 5,
		Id = 60103,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022519),
		ItemTips = getI18NValue(180022518),
		ActionParams = {
			200351,
			1,
			200352,
			1,
			200353,
			1,
			200354,
			1
		}
	},
	[60104] = {
		UserAction = 1,
		Quality = 5,
		Id = 60104,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022521),
		ItemTips = getI18NValue(180022520),
		ActionParams = {
			200451,
			1,
			200452,
			1,
			200453,
			1,
			200454,
			1
		}
	},
	[60105] = {
		UserAction = 1,
		Quality = 5,
		Id = 60105,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022523),
		ItemTips = getI18NValue(180022522),
		ActionParams = {
			200551,
			1,
			200552,
			1,
			200553,
			1,
			200554,
			1
		}
	},
	[60106] = {
		UserAction = 1,
		Quality = 5,
		Id = 60106,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180022525),
		ItemTips = getI18NValue(180022524),
		ActionParams = {
			200651,
			1,
			200652,
			1,
			200653,
			1,
			200654,
			1
		}
	},
	[60107] = {
		UserAction = 1,
		Quality = 5,
		Id = 60107,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180023143),
		ItemTips = getI18NValue(180023142),
		ActionParams = {
			200751,
			1,
			200752,
			1,
			200753,
			1,
			200754,
			1
		}
	},
	[60108] = {
		UserAction = 1,
		Quality = 5,
		Id = 60108,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180023145),
		ItemTips = getI18NValue(180023144),
		ActionParams = {
			200851,
			1,
			200852,
			1,
			200853,
			1,
			200854,
			1
		}
	},
	[60109] = {
		UserAction = 1,
		Quality = 5,
		Id = 60109,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_001.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_LargeItem_Bag_01.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180023147),
		ItemTips = getI18NValue(180023146),
		ActionParams = {
			200951,
			1,
			200952,
			1,
			200953,
			1,
			200954,
			1
		}
	},
	[60110] = {
		UserAction = 10,
		Quality = 5,
		Id = 60110,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180023149),
		ItemTips = getI18NValue(180023148),
		ActionParams = {
			80207,
			1,
			80208,
			1,
			80209,
			1,
			80210,
			1,
			80211,
			1
		}
	},
	[60111] = {
		UseType = 2,
		Id = 60111,
		OverMode = 1,
		MaxUse = 99,
		Reveal = true,
		ItemTypes = 6,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		UserAction = 19,
		Quality = 4,
		Icon = "/Item/Icon_ItemBag_006.png",
		Star = true,
		MaxNum = 999,
		Name = getI18NValue(180028455),
		ItemTips = getI18NValue(180028454),
		ActionParams = {
			2041
		}
	},
	[60112] = {
		UseType = 2,
		Id = 60112,
		OverMode = 1,
		MaxUse = 99,
		Reveal = true,
		ItemTypes = 6,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		UserAction = 19,
		Quality = 5,
		Icon = "/Item/Icon_ItemBag_006.png",
		Star = true,
		MaxNum = 999,
		Name = getI18NValue(180028457),
		ItemTips = getI18NValue(180028456),
		ActionParams = {
			2042
		}
	},
	[60113] = {
		UserAction = 1,
		Quality = 4,
		Id = 60113,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133536),
		ItemTips = getI18NValue(180133535),
		ActionParams = {
			200141,
			1,
			200142,
			1,
			200143,
			1,
			200144,
			1
		}
	},
	[60114] = {
		UserAction = 1,
		Quality = 4,
		Id = 60114,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133538),
		ItemTips = getI18NValue(180133537),
		ActionParams = {
			200241,
			1,
			200242,
			1,
			200243,
			1,
			200244,
			1
		}
	},
	[60115] = {
		UserAction = 1,
		Quality = 4,
		Id = 60115,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133540),
		ItemTips = getI18NValue(180133539),
		ActionParams = {
			200341,
			1,
			200342,
			1,
			200343,
			1,
			200344,
			1
		}
	},
	[60116] = {
		UserAction = 1,
		Quality = 4,
		Id = 60116,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133542),
		ItemTips = getI18NValue(180133541),
		ActionParams = {
			200441,
			1,
			200442,
			1,
			200443,
			1,
			200444,
			1
		}
	},
	[60117] = {
		UserAction = 1,
		Quality = 4,
		Id = 60117,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133544),
		ItemTips = getI18NValue(180133543),
		ActionParams = {
			200541,
			1,
			200542,
			1,
			200543,
			1,
			200544,
			1
		}
	},
	[60118] = {
		UserAction = 1,
		Quality = 4,
		Id = 60118,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133546),
		ItemTips = getI18NValue(180133545),
		ActionParams = {
			200641,
			1,
			200642,
			1,
			200643,
			1,
			200644,
			1
		}
	},
	[60119] = {
		UserAction = 1,
		Quality = 4,
		Id = 60119,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133548),
		ItemTips = getI18NValue(180133547),
		ActionParams = {
			200741,
			1,
			200742,
			1,
			200743,
			1,
			200744,
			1
		}
	},
	[60120] = {
		UserAction = 1,
		Quality = 4,
		Id = 60120,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133550),
		ItemTips = getI18NValue(180133549),
		ActionParams = {
			200841,
			1,
			200842,
			1,
			200843,
			1,
			200844,
			1
		}
	},
	[60121] = {
		UserAction = 1,
		Quality = 4,
		Id = 60121,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 1,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180133552),
		ItemTips = getI18NValue(180133551),
		ActionParams = {
			200941,
			1,
			200942,
			1,
			200943,
			1,
			200944,
			1
		}
	},
	[60122] = {
		UserAction = 19,
		Quality = 5,
		Id = 60122,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 4,
		DepotType = 16,
		Name = getI18NValue(180244371),
		ItemTips = getI18NValue(180244370),
		ActionParams = {
			34
		}
	},
	[60123] = {
		UserAction = 19,
		Quality = 4,
		Id = 60123,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 4,
		DepotType = 16,
		Name = getI18NValue(180259504),
		ItemTips = getI18NValue(180259503),
		ActionParams = {
			35
		}
	},
	[60124] = {
		UserAction = 19,
		Quality = 4,
		Id = 60124,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 4,
		DepotType = 16,
		Name = getI18NValue(180260508),
		ItemTips = getI18NValue(180260507),
		ActionParams = {
			37
		}
	},
	[60125] = {
		UserAction = 19,
		Quality = 4,
		Id = 60125,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 4,
		DepotType = 16,
		Name = getI18NValue(180260510),
		ItemTips = getI18NValue(180260509),
		ActionParams = {
			38
		}
	},
	[60126] = {
		UserAction = 19,
		Quality = 4,
		Id = 60126,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 4,
		DepotType = 16,
		Name = getI18NValue(180260512),
		ItemTips = getI18NValue(180260511),
		ActionParams = {
			39
		}
	},
	[60127] = {
		UserAction = 19,
		Quality = 4,
		Id = 60127,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/60127.png",
		MaxUse = 999,
		Reveal = true,
		UseType = 2,
		MaxNum = 999,
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180261164),
		ItemTips = getI18NValue(180261163),
		ActionParams = {
			150001
		}
	},
	[60128] = {
		UserAction = 19,
		Quality = 5,
		Id = 60128,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/60128.png",
		MaxUse = 999,
		Reveal = true,
		UseType = 2,
		MaxNum = 999,
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180261166),
		ItemTips = getI18NValue(180261165),
		ActionParams = {
			150002
		}
	},
	[60129] = {
		UserAction = 10,
		Quality = 5,
		Id = 60129,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180263175),
		ItemTips = getI18NValue(180263174),
		ActionParams = {
			80202,
			1,
			80203,
			1,
			80204,
			1,
			80209,
			1,
			80217,
			1,
			80220,
			1
		}
	},
	[60130] = {
		UserAction = 10,
		Quality = 4,
		Id = 60130,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_012.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180264491),
		ItemTips = getI18NValue(180264490),
		ActionParams = {
			80121,
			1,
			80104,
			1,
			80123,
			1,
			80122,
			1
		}
	},
	[60131] = {
		UserAction = 10,
		Quality = 5,
		Id = 60131,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_013.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180264493),
		ItemTips = getI18NValue(180264492),
		ActionParams = {
			80215,
			1,
			80213,
			1,
			80216,
			1,
			80214,
			1
		}
	},
	[60132] = {
		UserAction = 10,
		Quality = 5,
		Id = 60132,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_014.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180264495),
		ItemTips = getI18NValue(180264494),
		ActionParams = {
			80205,
			1,
			80204,
			1,
			80210,
			1,
			80206,
			1
		}
	},
	[60133] = {
		UserAction = 10,
		Quality = 5,
		Id = 60133,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_015.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180266466),
		ItemTips = getI18NValue(180266465),
		ActionParams = {
			10001,
			1,
			10002,
			1,
			10004,
			1,
			10005,
			1,
			10006,
			1,
			10007,
			1,
			10009,
			1,
			10020,
			1,
			10024,
			1,
			10027,
			1
		}
	},
	[60134] = {
		UserAction = 10,
		Quality = 5,
		Id = 60134,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_015.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 2,
		MaxNum = 1,
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180267547),
		ItemTips = getI18NValue(180267546),
		ActionParams = {
			10001,
			1,
			10002,
			1,
			10004,
			1,
			10005,
			1,
			10006,
			1,
			10007,
			1,
			10009,
			1,
			10016,
			1,
			10020,
			1,
			10024,
			1,
			10027,
			1
		}
	},
	[60135] = {
		UserAction = 10,
		Quality = 4,
		UseType = 2,
		OverMode = 1,
		Icon = "/Item/Icon_ItemBag_005.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 99,
		ItemTypes = 6,
		Id = 60135,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180268867),
		ActionParams = {
			50041,
			10
		}
	},
	[60136] = {
		UserAction = 10,
		Quality = 5,
		UseType = 2,
		OverMode = 1,
		Icon = "/Item/Icon_ItemBag_004.png",
		MaxUse = 99,
		Reveal = true,
		MaxNum = 99,
		ItemTypes = 6,
		Id = 60136,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180268868),
		ActionParams = {
			50042,
			5
		}
	},
	[60201] = {
		UserAction = 10,
		Quality = 2,
		Id = 60201,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_004.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 999,
		BigIcon = "/Item/Icon_ItemBag_004.png",
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180038979),
		ItemTips = getI18NValue(180038978),
		ActionParams = {
			15011,
			1,
			15012,
			1,
			15013,
			1,
			15014,
			1
		}
	},
	[60202] = {
		UserAction = 10,
		Quality = 2,
		Id = 60202,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_005.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 999,
		BigIcon = "/Item/Icon_ItemBag_005.png",
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180224155),
		ItemTips = getI18NValue(180224154),
		ActionParams = {
			15001,
			1,
			15002,
			1,
			15003,
			1,
			15004,
			1
		}
	},
	[60203] = {
		UserAction = 19,
		Quality = 4,
		Id = 60203,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Bag_60203.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252837),
		ItemTips = getI18NValue(180252836),
		ActionParams = {
			10061
		}
	},
	[60212] = {
		UserAction = 1,
		Quality = 3,
		Id = 60212,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180166437),
		ItemTips = getI18NValue(180166436),
		ActionParams = {
			4,
			100000
		}
	},
	[60213] = {
		UserAction = 1,
		Quality = 4,
		Id = 60213,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180166439),
		ItemTips = getI18NValue(180166438),
		ActionParams = {
			4,
			1000000
		}
	},
	[60214] = {
		UserAction = 1,
		Quality = 5,
		Id = 60214,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_010.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Item/Icon_ItemBag_010.png",
		ItemSubTypes = 2,
		DepotType = 16,
		Name = getI18NValue(180166441),
		ItemTips = getI18NValue(180166440),
		ActionParams = {
			4,
			10000000
		}
	},
	[60301] = {
		UserAction = 19,
		Quality = 3,
		Id = 60301,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252386),
		ItemTips = getI18NValue(180252385),
		ActionParams = {
			10201
		}
	},
	[60302] = {
		UserAction = 19,
		Quality = 3,
		Id = 60302,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252388),
		ItemTips = getI18NValue(180252387),
		ActionParams = {
			10202
		}
	},
	[60303] = {
		UserAction = 19,
		Quality = 3,
		Id = 60303,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252390),
		ItemTips = getI18NValue(180252389),
		ActionParams = {
			10203
		}
	},
	[60304] = {
		UserAction = 19,
		Quality = 3,
		Id = 60304,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252392),
		ItemTips = getI18NValue(180252391),
		ActionParams = {
			10204
		}
	},
	[60305] = {
		UserAction = 19,
		Quality = 3,
		Id = 60305,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252394),
		ItemTips = getI18NValue(180252393),
		ActionParams = {
			10205
		}
	},
	[60306] = {
		UserAction = 19,
		Quality = 3,
		Id = 60306,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252396),
		ItemTips = getI18NValue(180252395),
		ActionParams = {
			10206
		}
	},
	[60311] = {
		UserAction = 19,
		Quality = 4,
		Id = 60311,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252398),
		ItemTips = getI18NValue(180252397),
		ActionParams = {
			10211
		}
	},
	[60312] = {
		UserAction = 19,
		Quality = 4,
		Id = 60312,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252400),
		ItemTips = getI18NValue(180252399),
		ActionParams = {
			10212
		}
	},
	[60313] = {
		UserAction = 19,
		Quality = 4,
		Id = 60313,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252402),
		ItemTips = getI18NValue(180252401),
		ActionParams = {
			10213
		}
	},
	[60314] = {
		UserAction = 19,
		Quality = 4,
		Id = 60314,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252404),
		ItemTips = getI18NValue(180252403),
		ActionParams = {
			10214
		}
	},
	[60315] = {
		UserAction = 19,
		Quality = 4,
		Id = 60315,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252406),
		ItemTips = getI18NValue(180252405),
		ActionParams = {
			10215
		}
	},
	[60316] = {
		UserAction = 19,
		Quality = 4,
		Id = 60316,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252408),
		ItemTips = getI18NValue(180252407),
		ActionParams = {
			10216
		}
	},
	[60321] = {
		UserAction = 19,
		Quality = 5,
		Id = 60321,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252410),
		ItemTips = getI18NValue(180252409),
		ActionParams = {
			10221
		}
	},
	[60322] = {
		UserAction = 19,
		Quality = 5,
		Id = 60322,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252412),
		ItemTips = getI18NValue(180252411),
		ActionParams = {
			10222
		}
	},
	[60323] = {
		UserAction = 19,
		Quality = 5,
		Id = 60323,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252414),
		ItemTips = getI18NValue(180252413),
		ActionParams = {
			10223
		}
	},
	[60324] = {
		UserAction = 19,
		Quality = 5,
		Id = 60324,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252416),
		ItemTips = getI18NValue(180252415),
		ActionParams = {
			10224
		}
	},
	[60325] = {
		UserAction = 19,
		Quality = 5,
		Id = 60325,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252418),
		ItemTips = getI18NValue(180252417),
		ActionParams = {
			10225
		}
	},
	[60326] = {
		UserAction = 19,
		Quality = 5,
		Id = 60326,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/Icon_ItemBag_006.png",
		MaxUse = 99,
		Reveal = true,
		UseType = 2,
		MaxNum = 99,
		BigIcon = "/Item/Icon_ItemBag_006.png",
		ItemSubTypes = 5,
		DepotType = 16,
		Name = getI18NValue(180252420),
		ItemTips = getI18NValue(180252419),
		ActionParams = {
			10226
		}
	},
	[61001] = {
		UserAction = 1,
		Quality = 3,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61001.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61001,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242757),
		ActionParams = {
			50002,
			5,
			4,
			5000
		}
	},
	[61011] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61011,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242758),
		ActionParams = {
			50003,
			5,
			50033,
			5,
			4,
			10000
		}
	},
	[61012] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61012.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61012,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242759),
		ActionParams = {
			50003,
			5,
			50033,
			5,
			4,
			10000
		}
	},
	[61013] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61013.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61013,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242760),
		ActionParams = {
			50003,
			5,
			50033,
			5,
			4,
			10000
		}
	},
	[61014] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61014.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61014,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242761),
		ActionParams = {
			50003,
			10,
			50033,
			10,
			4,
			10000
		}
	},
	[61015] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61015.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61015,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242762),
		ActionParams = {
			50003,
			10,
			50033,
			10,
			4,
			10000
		}
	},
	[61016] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61016.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61016,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242763),
		ActionParams = {
			50003,
			10,
			50033,
			10,
			4,
			10000
		}
	},
	[61017] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61017.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61017,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242764),
		ActionParams = {
			50003,
			15,
			50033,
			15,
			4,
			20000
		}
	},
	[61018] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61018.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61018,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242765),
		ActionParams = {
			50003,
			15,
			50033,
			15,
			4,
			20000
		}
	},
	[61041] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61041.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61041,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242766),
		ActionParams = {
			3000,
			2,
			50004,
			3,
			50033,
			2
		}
	},
	[61042] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61042.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61042,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242767),
		ActionParams = {
			3003,
			2,
			60201,
			5,
			15021,
			10
		}
	},
	[61043] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61043.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61043,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242768),
		ActionParams = {
			3000,
			2,
			50004,
			3,
			50033,
			2
		}
	},
	[61044] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61044.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61044,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242769),
		ActionParams = {
			3003,
			2,
			60201,
			5,
			15021,
			15
		}
	},
	[61045] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61045.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61045,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242770),
		ActionParams = {
			3000,
			2,
			50004,
			6,
			50033,
			4
		}
	},
	[61046] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61046.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61046,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242771),
		ActionParams = {
			3003,
			5,
			60201,
			10,
			15021,
			20
		}
	},
	[61047] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61047.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61047,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242772),
		ActionParams = {
			3000,
			2,
			50004,
			8,
			50033,
			6
		}
	},
	[61048] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61048.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61048,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242773),
		ActionParams = {
			3003,
			5,
			60201,
			10,
			15021,
			30,
			15000,
			1
		}
	},
	[61071] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61071.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61071,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242774),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			50004,
			8,
			50033,
			5
		}
	},
	[61072] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61072.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61072,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242775),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			60201,
			10,
			15021,
			20
		}
	},
	[61073] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61073.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61073,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242776),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			50004,
			10,
			50033,
			5
		}
	},
	[61074] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61074.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61074,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242777),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			60201,
			10,
			15021,
			30
		}
	},
	[61075] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61075.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61075,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242778),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			50004,
			10,
			50033,
			10
		}
	},
	[61076] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61076.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61076,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242779),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			60201,
			15,
			15021,
			30
		}
	},
	[61077] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61077.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61077,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242780),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			50004,
			15,
			50033,
			5
		}
	},
	[61078] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61078.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61078,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242781),
		ActionParams = {
			55001,
			2,
			3000,
			5,
			60201,
			10,
			15021,
			30,
			15031,
			1
		}
	},
	[61101] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61101.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61101,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242782),
		ActionParams = {
			50003,
			10,
			60202,
			10,
			4,
			100000
		}
	},
	[61102] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61102.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61102,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242783),
		ActionParams = {
			55001,
			1,
			50003,
			20,
			4,
			50000
		}
	},
	[61103] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61103.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61103,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242784),
		ActionParams = {
			50004,
			10,
			50003,
			10,
			4,
			20000
		}
	},
	[61201] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61201.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61201,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242785),
		ActionParams = {
			16005,
			20
		}
	},
	[61202] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61202.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61202,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242786),
		ActionParams = {
			3,
			300,
			15000,
			1
		}
	},
	[61203] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61203.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61203,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242787),
		ActionParams = {
			3,
			300
		}
	},
	[61211] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61211.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61211,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242788),
		ActionParams = {
			3001,
			1
		}
	},
	[61212] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61212.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61212,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242789),
		ActionParams = {
			3003,
			1
		}
	},
	[61213] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61213.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61213,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242790),
		ActionParams = {
			3001,
			10
		}
	},
	[61214] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61214.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61214,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242791),
		ActionParams = {
			3003,
			10
		}
	},
	[61215] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61215.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61215,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242792),
		ActionParams = {
			3000,
			30,
			3,
			1500
		}
	},
	[61216] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61216.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61216,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242793),
		ActionParams = {
			3001,
			30
		}
	},
	[61217] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61217.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61217,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242794),
		ActionParams = {
			3003,
			30
		}
	},
	[61218] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61218.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61218,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180256415),
		ActionParams = {
			3003,
			40,
			50034,
			20,
			4,
			50000
		}
	},
	[61219] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61219.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61219,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180256416),
		ActionParams = {
			3001,
			20,
			3000,
			20,
			50004,
			20,
			4,
			50000
		}
	},
	[61220] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61220.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61220,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260513),
		ActionParams = {
			3004,
			1
		}
	},
	[61221] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61221.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61221,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260514),
		ActionParams = {
			3004,
			10
		}
	},
	[61222] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/Bag_61222.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61222,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260515),
		ActionParams = {
			3004,
			30
		}
	},
	[61301] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61301.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61301,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242795),
		ActionParams = {
			2,
			6,
			3001,
			2
		}
	},
	[61302] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61302.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61302,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242796),
		ActionParams = {
			2,
			18,
			3001,
			5
		}
	},
	[61303] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61303.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61303,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242797),
		ActionParams = {
			2,
			30,
			3001,
			10,
			55002,
			2,
			50003,
			20,
			15021,
			20,
			4,
			300000
		}
	},
	[61304] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61304.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61304,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242798),
		ActionParams = {
			2,
			38,
			3001,
			10,
			3003,
			10
		}
	},
	[61305] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61305.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61305,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242799),
		ActionParams = {
			2,
			68,
			3001,
			10,
			3000,
			10,
			3004,
			10,
			3003,
			10
		}
	},
	[61306] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61306.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61306,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242800),
		ActionParams = {
			2,
			128,
			3001,
			30,
			16005,
			10,
			50004,
			5,
			4,
			100000
		}
	},
	[61307] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61307.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61307,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260516),
		ActionParams = {
			2,
			128,
			3004,
			30,
			16005,
			10,
			50004,
			5,
			4,
			100000
		}
	},
	[61501] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61501.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61501,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242801),
		ActionParams = {
			55001,
			2,
			4,
			10000
		}
	},
	[61502] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61502.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61502,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242802),
		ActionParams = {
			3001,
			1,
			3003,
			1,
			4,
			10000
		}
	},
	[61503] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61503.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61503,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242803),
		ActionParams = {
			3001,
			3,
			16005,
			2,
			60201,
			10,
			4,
			30000
		}
	},
	[61504] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61504.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61504,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242804),
		ActionParams = {
			3001,
			5,
			3003,
			3
		}
	},
	[61505] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61505.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61505,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242805),
		ActionParams = {
			3001,
			10,
			16005,
			10
		}
	},
	[61506] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61506.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61506,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242806),
		ActionParams = {
			3001,
			20
		}
	},
	[61701] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61701,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242807),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61702] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61702.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61702,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242808),
		ActionParams = {
			3001,
			5
		}
	},
	[61703] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61703.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61703,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242809),
		ActionParams = {
			3003,
			10
		}
	},
	[61704] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61704.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61704,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242810),
		ActionParams = {
			3001,
			10
		}
	},
	[61705] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61705.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61705,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242811),
		ActionParams = {
			3000,
			10,
			3001,
			10,
			3003,
			10
		}
	},
	[61706] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61706.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61706,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242812),
		ActionParams = {
			3001,
			30
		}
	},
	[61707] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61707.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61707,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242813),
		ActionParams = {
			3003,
			30
		}
	},
	[61708] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61708.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61708,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180242814),
		ActionParams = {
			3000,
			30,
			3001,
			30
		}
	},
	[61709] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61709.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61709,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180256417),
		ActionParams = {
			2,
			300,
			3001,
			30,
			15000,
			1,
			60202,
			50,
			4,
			300000
		}
	},
	[61710] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61710.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61710,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180256418),
		ActionParams = {
			2,
			300,
			3003,
			30,
			60122,
			1,
			15021,
			50,
			4,
			300000
		}
	},
	[61711] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61711.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61711,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180256419),
		ActionParams = {
			2,
			600,
			3001,
			20,
			3003,
			30,
			15000,
			1,
			60122,
			1,
			4,
			600000
		}
	},
	[61712] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61712.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61712,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260517),
		ActionParams = {
			3000,
			10,
			3004,
			10,
			3003,
			10
		}
	},
	[61713] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61713.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61713,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180260518),
		ActionParams = {
			3004,
			30
		}
	},
	[61801] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61801.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61801,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259705),
		ActionParams = {
			3001,
			2,
			55001,
			2,
			50003,
			10,
			4,
			20000
		}
	},
	[61802] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61802.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61802,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259706),
		ActionParams = {
			2,
			30,
			3001,
			10
		}
	},
	[61803] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61803.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61803,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259707),
		ActionParams = {
			2,
			68,
			3001,
			10,
			55002,
			5
		}
	},
	[61804] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61804.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61804,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259708),
		ActionParams = {
			2,
			198,
			3001,
			10,
			3004,
			10,
			60130,
			1,
			4,
			300000
		}
	},
	[61805] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61805.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61805,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259709),
		ActionParams = {
			2,
			328,
			3001,
			15,
			3004,
			15,
			60131,
			1,
			4,
			400000
		}
	},
	[61806] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61806.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61806,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259710),
		ActionParams = {
			2,
			648,
			3001,
			30,
			3004,
			30,
			60132,
			1,
			15000,
			1,
			4,
			600000
		}
	},
	[61807] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61807.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61807,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259711),
		ActionParams = {
			3001,
			2,
			55001,
			2
		}
	},
	[61808] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61808.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61808,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259712),
		ActionParams = {
			2,
			30,
			55001,
			5,
			3001,
			10
		}
	},
	[61809] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61809.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61809,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259713),
		ActionParams = {
			2,
			68,
			55002,
			3,
			3001,
			15
		}
	},
	[61810] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61810.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61810,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259714),
		ActionParams = {
			2,
			128,
			55002,
			5,
			3003,
			10
		}
	},
	[61811] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61811.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61811,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259715),
		ActionParams = {
			2,
			198,
			55002,
			8,
			3003,
			15
		}
	},
	[61812] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61812.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61812,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259716),
		ActionParams = {
			2,
			328,
			55002,
			10,
			3001,
			20,
			3004,
			20,
			15000,
			1
		}
	},
	[61813] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61813.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61813,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259717),
		ActionParams = {
			2,
			648,
			55002,
			15,
			3001,
			30,
			3004,
			30,
			60122,
			1
		}
	},
	[61814] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61814,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259718),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61815] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61815,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259719),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61816] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61816,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259720),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61817] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61817,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259721),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61818] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61818,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259722),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61819] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61819,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259723),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61820] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61820,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259724),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61821] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61821,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259725),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61822] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61822,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259726),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61823] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61823,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259727),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61824] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61824,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259728),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61825] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61825,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259729),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61826] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61826,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259730),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61827] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61827,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259731),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61828] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61828,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259732),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61829] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61829,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259733),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61830] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61830,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259734),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61831] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61831,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259735),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61832] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61832,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259736),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61833] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61833,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259737),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61834] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61834,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259738),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61835] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61835,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259739),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61836] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61836,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259740),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61837] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61837,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259741),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61838] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61838,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259742),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61839] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61839,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259743),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61840] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61840,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259744),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61841] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61841,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259745),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61842] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61842,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259746),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61843] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61843,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259747),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61844] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61844,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259748),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[61845] = {
		UserAction = 1,
		Quality = 5,
		UseType = 1,
		OverMode = 1,
		Icon = "/Item/BagBig_61701.png",
		MaxUse = 1,
		Reveal = true,
		MaxNum = 1,
		ItemTypes = 6,
		Id = 61845,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259749),
		ActionParams = {
			55002,
			2,
			16005,
			1
		}
	},
	[80000] = {
		UserAction = 21,
		Quality = 3,
		Id = 80000,
		OverMode = 1,
		ItemTypes = 4,
		Icon = "/SmallDIYSkill/Diy_80001.png",
		LikeId = 800000,
		Reveal = true,
		Star = true,
		MaxNum = 1,
		BigIcon = "/SmallDIYSkill/Diy_80001.png",
		ItemSubTypes = 2,
		DepotType = 4,
		Name = getI18NValue(180241014),
		ItemTips = getI18NValue(180241013),
		ActionParams = {
			1
		}
	},
	[80001] = {
		Id = 80001,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800010,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80001.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80001.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002815),
		ItemTips = getI18NValue(180002814),
		ItemStory = getI18NValue(180039040),
		ActionParams = {
			1
		}
	},
	[80002] = {
		Id = 80002,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800020,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80002.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80002.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002817),
		ItemTips = getI18NValue(180002816),
		ItemStory = getI18NValue(180039041),
		ActionParams = {
			1
		}
	},
	[80003] = {
		Id = 80003,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800030,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80003.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 3,
		Icon = "/SmallDIYSkill/Diy_80003.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002819),
		ItemTips = getI18NValue(180002818),
		ItemStory = getI18NValue(180039042),
		ActionParams = {
			1
		}
	},
	[80004] = {
		Id = 80004,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800040,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80004.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80004.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002821),
		ItemTips = getI18NValue(180002820),
		ItemStory = getI18NValue(180039043),
		ActionParams = {
			1
		}
	},
	[80005] = {
		Id = 80005,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800050,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80005.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80005.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002823),
		ItemTips = getI18NValue(180002822),
		ItemStory = getI18NValue(180039044),
		ActionParams = {
			1
		}
	},
	[80006] = {
		Id = 80006,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800060,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80006.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 3,
		Icon = "/SmallDIYSkill/Diy_80006.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002825),
		ItemTips = getI18NValue(180002824),
		ItemStory = getI18NValue(180039045),
		ActionParams = {
			1
		}
	},
	[80007] = {
		Id = 80007,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800070,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80007.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80007.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002827),
		ItemTips = getI18NValue(180002826),
		ItemStory = getI18NValue(180039046),
		ActionParams = {
			1
		}
	},
	[80008] = {
		Id = 80008,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800080,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80008.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 3,
		Icon = "/SmallDIYSkill/Diy_80008.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002829),
		ItemTips = getI18NValue(180002828),
		ItemStory = getI18NValue(180039047),
		ActionParams = {
			1
		}
	},
	[80009] = {
		Id = 80009,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800090,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80009.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 3,
		Icon = "/SmallDIYSkill/Diy_80009.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180002831),
		ItemTips = getI18NValue(180002830),
		ItemStory = getI18NValue(180039048),
		ActionParams = {
			1
		}
	},
	[80010] = {
		Id = 80010,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800100,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80010.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80010.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242930),
		ItemTips = getI18NValue(180242929),
		ItemStory = getI18NValue(180244100),
		ActionParams = {
			1
		}
	},
	[80011] = {
		Id = 80011,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800110,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80011.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80011.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180020589),
		ItemTips = getI18NValue(180020588),
		ItemStory = getI18NValue(180039049),
		ActionParams = {
			1
		}
	},
	[80012] = {
		Id = 80012,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800120,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80012.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 3,
		Icon = "/SmallDIYSkill/Diy_80012.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242932),
		ItemTips = getI18NValue(180242931),
		ItemStory = getI18NValue(180244101),
		ActionParams = {
			1
		}
	},
	[80013] = {
		Id = 80013,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800130,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80013.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80013.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242934),
		ItemTips = getI18NValue(180242933),
		ItemStory = getI18NValue(180244102),
		ActionParams = {
			1
		}
	},
	[80014] = {
		Id = 80014,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800140,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80014.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80014.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242936),
		ItemTips = getI18NValue(180242935),
		ItemStory = getI18NValue(180244103),
		ActionParams = {
			1
		}
	},
	[80015] = {
		Id = 80015,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800150,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80015.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80015.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242938),
		ItemTips = getI18NValue(180242937),
		ItemStory = getI18NValue(180244104),
		ActionParams = {
			1
		}
	},
	[80016] = {
		Id = 80016,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800160,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80016.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80016.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242940),
		ItemTips = getI18NValue(180242939),
		ItemStory = getI18NValue(180244105),
		ActionParams = {
			1
		}
	},
	[80017] = {
		Id = 80017,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800170,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80017.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80017.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242942),
		ItemTips = getI18NValue(180242941),
		ItemStory = getI18NValue(180244106),
		ActionParams = {
			1
		}
	},
	[80018] = {
		Id = 80018,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800180,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80018.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80018.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242944),
		ItemTips = getI18NValue(180242943),
		ItemStory = getI18NValue(180244107),
		ActionParams = {
			1
		}
	},
	[80019] = {
		Id = 80019,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800190,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80019.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80019.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242946),
		ItemTips = getI18NValue(180242945),
		ItemStory = getI18NValue(180244108),
		ActionParams = {
			1
		}
	},
	[80020] = {
		Id = 80020,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 800200,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80020.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80020.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242948),
		ItemTips = getI18NValue(180242947),
		ItemStory = getI18NValue(180244109),
		ActionParams = {
			1
		}
	},
	[80101] = {
		Id = 80101,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801010,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80101.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80101.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011307),
		ItemTips = getI18NValue(180011306),
		ItemStory = getI18NValue(180039050),
		ActionParams = {
			1
		}
	},
	[80102] = {
		Id = 80102,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801020,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80102.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80102.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011309),
		ItemTips = getI18NValue(180011308),
		ItemStory = getI18NValue(180039051),
		ActionParams = {
			1
		}
	},
	[80103] = {
		Id = 80103,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801030,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80103.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80103.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011311),
		ItemTips = getI18NValue(180011310),
		ItemStory = getI18NValue(180039052),
		ActionParams = {
			1
		}
	},
	[80104] = {
		Id = 80104,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801040,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80104.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80104.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011313),
		ItemTips = getI18NValue(180011312),
		ItemStory = getI18NValue(180039053),
		ActionParams = {
			1
		}
	},
	[80105] = {
		Id = 80105,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801050,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80105.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80105.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011315),
		ItemTips = getI18NValue(180011314),
		ItemStory = getI18NValue(180039054),
		ActionParams = {
			1
		}
	},
	[80106] = {
		Id = 80106,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801060,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80106.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80106.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011317),
		ItemTips = getI18NValue(180011316),
		ItemStory = getI18NValue(180039055),
		ActionParams = {
			1
		}
	},
	[80107] = {
		Id = 80107,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801070,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80107.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80107.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011319),
		ItemTips = getI18NValue(180011318),
		ItemStory = getI18NValue(180039056),
		ActionParams = {
			1
		}
	},
	[80108] = {
		Id = 80108,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801080,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80108.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80108.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011321),
		ItemTips = getI18NValue(180011320),
		ItemStory = getI18NValue(180039057),
		ActionParams = {
			1
		}
	},
	[80109] = {
		Id = 80109,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801090,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80109.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80109.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011323),
		ItemTips = getI18NValue(180011322),
		ItemStory = getI18NValue(180039058),
		ActionParams = {
			1
		}
	},
	[80110] = {
		Id = 80110,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801100,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80110.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80110.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011325),
		ItemTips = getI18NValue(180011324),
		ItemStory = getI18NValue(180039059),
		ActionParams = {
			1
		}
	},
	[80111] = {
		Id = 80111,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801110,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80111.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80111.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011327),
		ItemTips = getI18NValue(180011326),
		ItemStory = getI18NValue(180039060),
		ActionParams = {
			1
		}
	},
	[80112] = {
		Id = 80112,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801120,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80112.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80112.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011329),
		ItemTips = getI18NValue(180011328),
		ItemStory = getI18NValue(180039061),
		ActionParams = {
			1
		}
	},
	[80113] = {
		Id = 80113,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801130,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80113.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80113.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180011331),
		ItemTips = getI18NValue(180011330),
		ItemStory = getI18NValue(180039062),
		ActionParams = {
			1
		}
	},
	[80114] = {
		Id = 80114,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801140,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80114.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80114.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180039065),
		ItemTips = getI18NValue(180039063),
		ItemStory = getI18NValue(180039064),
		ActionParams = {
			1
		}
	},
	[80115] = {
		Id = 80115,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801150,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80115.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80115.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180039068),
		ItemTips = getI18NValue(180039066),
		ItemStory = getI18NValue(180039067),
		ActionParams = {
			1
		}
	},
	[80116] = {
		Id = 80116,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801160,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80116.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80116.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242950),
		ItemTips = getI18NValue(180242949),
		ItemStory = getI18NValue(180244110),
		ActionParams = {
			1
		}
	},
	[80117] = {
		Id = 80117,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801170,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80117.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80117.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242952),
		ItemTips = getI18NValue(180242951),
		ItemStory = getI18NValue(180244111),
		ActionParams = {
			1
		}
	},
	[80118] = {
		Id = 80118,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801180,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80118.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80118.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242954),
		ItemTips = getI18NValue(180242953),
		ItemStory = getI18NValue(180244112),
		ActionParams = {
			1
		}
	},
	[80119] = {
		Id = 80119,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801190,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80119.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80119.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242956),
		ItemTips = getI18NValue(180242955),
		ItemStory = getI18NValue(180244113),
		ActionParams = {
			1
		}
	},
	[80120] = {
		Id = 80120,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801200,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80120.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80120.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180242958),
		ItemTips = getI18NValue(180242957),
		ItemStory = getI18NValue(180244114),
		ActionParams = {
			1
		}
	},
	[80121] = {
		Id = 80121,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801210,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80121.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80121.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180260159),
		ItemTips = getI18NValue(180260157),
		ItemStory = getI18NValue(180260158),
		ActionParams = {
			1
		}
	},
	[80122] = {
		Id = 80122,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801220,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80122.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80122.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180260162),
		ItemTips = getI18NValue(180260160),
		ItemStory = getI18NValue(180260161),
		ActionParams = {
			1
		}
	},
	[80123] = {
		Id = 80123,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801230,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80123.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80123.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180260165),
		ItemTips = getI18NValue(180260163),
		ItemStory = getI18NValue(180260164),
		ActionParams = {
			1
		}
	},
	[80124] = {
		Id = 80124,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 801240,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80124.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 4,
		Icon = "/SmallDIYSkill/Diy_80124.png",
		Star = true,
		Isdestroyed = true,
		Name = getI18NValue(180261643),
		ItemTips = getI18NValue(180263093),
		ItemStory = getI18NValue(180263094),
		ActionParams = {
			1
		}
	},
	[80201] = {
		Id = 80201,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802010,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80201.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80201.png",
		Star = true,
		Name = getI18NValue(180011333),
		ItemTips = getI18NValue(180011332),
		ItemStory = getI18NValue(180039069),
		ActionParams = {
			1
		}
	},
	[80202] = {
		Id = 80202,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802020,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80202.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80202.png",
		Star = true,
		Name = getI18NValue(180011335),
		ItemTips = getI18NValue(180011334),
		ItemStory = getI18NValue(180039070),
		ActionParams = {
			1
		}
	},
	[80203] = {
		Id = 80203,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802030,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80203.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80203.png",
		Star = true,
		Name = getI18NValue(180011337),
		ItemTips = getI18NValue(180011336),
		ItemStory = getI18NValue(180039071),
		ActionParams = {
			1
		}
	},
	[80204] = {
		Id = 80204,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802040,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80204.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80204.png",
		Star = true,
		Name = getI18NValue(180011339),
		ItemTips = getI18NValue(180011338),
		ItemStory = getI18NValue(180039072),
		ActionParams = {
			1
		}
	},
	[80205] = {
		Id = 80205,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802050,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80205.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80205.png",
		Star = true,
		Name = getI18NValue(180039075),
		ItemTips = getI18NValue(180039073),
		ItemStory = getI18NValue(180039074),
		ActionParams = {
			1
		}
	},
	[80206] = {
		Id = 80206,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802060,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80206.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80206.png",
		Star = true,
		Name = getI18NValue(180162727),
		ItemTips = getI18NValue(180162725),
		ItemStory = getI18NValue(180162726),
		ActionParams = {
			1
		}
	},
	[80207] = {
		Id = 80207,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802070,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80207.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80207.png",
		Star = true,
		Name = getI18NValue(180167542),
		ItemTips = getI18NValue(180167540),
		ItemStory = getI18NValue(180167541),
		ActionParams = {
			1
		}
	},
	[80208] = {
		Id = 80208,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802080,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80208.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80208.png",
		Star = true,
		Name = getI18NValue(180182232),
		ItemTips = getI18NValue(180182230),
		ItemStory = getI18NValue(180182231),
		ActionParams = {
			1
		}
	},
	[80209] = {
		Id = 80209,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802090,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80209.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80209.png",
		Star = true,
		Name = getI18NValue(180206669),
		ItemTips = getI18NValue(180206667),
		ItemStory = getI18NValue(180206668),
		ActionParams = {
			1
		}
	},
	[80210] = {
		Id = 80210,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802100,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80210.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80210.png",
		Star = true,
		Name = getI18NValue(180206672),
		ItemTips = getI18NValue(180206670),
		ItemStory = getI18NValue(180206671),
		ActionParams = {
			1
		}
	},
	[80211] = {
		Id = 80211,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802110,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80211.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80211.png",
		Star = true,
		Name = getI18NValue(180206675),
		ItemTips = getI18NValue(180206673),
		ItemStory = getI18NValue(180206674),
		ActionParams = {
			1
		}
	},
	[80212] = {
		Id = 80212,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802120,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80212.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80212.png",
		Star = true,
		Name = getI18NValue(180242960),
		ItemTips = getI18NValue(180242959),
		ItemStory = getI18NValue(180244115),
		ActionParams = {
			1
		}
	},
	[80213] = {
		Id = 80213,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802130,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80213.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80213.png",
		Star = true,
		Name = getI18NValue(180242962),
		ItemTips = getI18NValue(180242961),
		ItemStory = getI18NValue(180244116),
		ActionParams = {
			1
		}
	},
	[80214] = {
		Id = 80214,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802140,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80214.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80214.png",
		Star = true,
		Name = getI18NValue(180242964),
		ItemTips = getI18NValue(180242963),
		ItemStory = getI18NValue(180244117),
		ActionParams = {
			1
		}
	},
	[80215] = {
		Id = 80215,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802150,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80215.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80215.png",
		Star = true,
		Name = getI18NValue(180242966),
		ItemTips = getI18NValue(180242965),
		ItemStory = getI18NValue(180244118),
		ActionParams = {
			1
		}
	},
	[80216] = {
		Id = 80216,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802160,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80216.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80216.png",
		Star = true,
		Name = getI18NValue(180242968),
		ItemTips = getI18NValue(180242967),
		ItemStory = getI18NValue(180244119),
		ActionParams = {
			1
		}
	},
	[80217] = {
		Id = 80217,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802170,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80217.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80217.png",
		Star = true,
		Name = getI18NValue(180242970),
		ItemTips = getI18NValue(180242969),
		ItemStory = getI18NValue(180244120),
		ActionParams = {
			1
		}
	},
	[80218] = {
		Id = 80218,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802180,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80218.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80218.png",
		Star = true,
		Name = getI18NValue(180242972),
		ItemTips = getI18NValue(180242971),
		ItemStory = getI18NValue(180244121),
		ActionParams = {
			1
		}
	},
	[80219] = {
		Id = 80219,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802190,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80219.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80219.png",
		Star = true,
		Name = getI18NValue(180242974),
		ItemTips = getI18NValue(180242973),
		ItemStory = getI18NValue(180244122),
		ActionParams = {
			1
		}
	},
	[80220] = {
		Id = 80220,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802200,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80220.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80220.png",
		Star = true,
		Name = getI18NValue(180242976),
		ItemTips = getI18NValue(180242975),
		ItemStory = getI18NValue(180244123),
		ActionParams = {
			1
		}
	},
	[80221] = {
		Id = 80221,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802210,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80221.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80221.png",
		Star = true,
		Name = getI18NValue(180242978),
		ItemTips = getI18NValue(180242977),
		ItemStory = getI18NValue(180244124),
		ActionParams = {
			1
		}
	},
	[80222] = {
		Id = 80222,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802220,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80222.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80222.png",
		Star = true,
		Name = getI18NValue(180242980),
		ItemTips = getI18NValue(180242979),
		ItemStory = getI18NValue(180244125),
		ActionParams = {
			1
		}
	},
	[80223] = {
		Id = 80223,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802230,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80223.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80223.png",
		Star = true,
		Name = getI18NValue(180242982),
		ItemTips = getI18NValue(180242981),
		ItemStory = getI18NValue(180244126),
		ActionParams = {
			1
		}
	},
	[80224] = {
		Id = 80224,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802240,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80224.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80224.png",
		Star = true,
		Name = getI18NValue(180264360),
		ItemTips = getI18NValue(180266467),
		ItemStory = getI18NValue(180266468),
		ActionParams = {
			1
		}
	},
	[80225] = {
		Id = 80225,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802250,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80225.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80225.png",
		Star = true,
		Name = getI18NValue(180264361),
		ItemTips = getI18NValue(180266469),
		ItemStory = getI18NValue(180266470),
		ActionParams = {
			1
		}
	},
	[80226] = {
		Id = 80226,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802260,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80226.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80226.png",
		Star = true,
		Name = getI18NValue(180267147),
		ItemTips = getI18NValue(180268146),
		ItemStory = getI18NValue(180268147),
		ActionParams = {
			1
		}
	},
	[80227] = {
		Id = 80227,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802270,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80227.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80227.png",
		Star = true,
		Name = getI18NValue(180268555),
		ItemTips = getI18NValue(180268754),
		ItemStory = getI18NValue(180268755),
		ActionParams = {
			1
		}
	},
	[80228] = {
		Id = 80228,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 802280,
		Reveal = true,
		ItemTypes = 4,
		BigIcon = "/SmallDIYSkill/Diy_80228.png",
		ItemSubTypes = 2,
		DepotType = 4,
		UserAction = 21,
		Quality = 5,
		Icon = "/SmallDIYSkill/Diy_80228.png",
		Star = true,
		Name = getI18NValue(180268556),
		ItemTips = getI18NValue(180268756),
		ItemStory = getI18NValue(180268757),
		ActionParams = {
			1
		}
	},
	[100110] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100110,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30001.png",
		LikeId = 100110,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30001.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180162844),
		ItemTips = getI18NValue(180162843)
	},
	[100120] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100120,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30002.png",
		LikeId = 100120,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30002.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002337),
		ItemTips = getI18NValue(180002336)
	},
	[100130] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100130,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100130,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002339),
		ItemTips = getI18NValue(180002338)
	},
	[100140] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100140,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100140,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203242),
		ItemTips = getI18NValue(180203241)
	},
	[100210] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100210,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30004.png",
		LikeId = 100210,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30004.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002341),
		ItemTips = getI18NValue(180002340)
	},
	[100220] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100220,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30005.png",
		LikeId = 100220,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30005.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002343),
		ItemTips = getI18NValue(180002342)
	},
	[100230] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100230,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30006.png",
		LikeId = 100230,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30006.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002345),
		ItemTips = getI18NValue(180002344)
	},
	[100240] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100240,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100240,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203244),
		ItemTips = getI18NValue(180203243)
	},
	[100310] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100310,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100310.png",
		LikeId = 100310,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100310.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002347),
		ItemTips = getI18NValue(180002346)
	},
	[100320] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100320,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100320.png",
		LikeId = 100320,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100320.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002349),
		ItemTips = getI18NValue(180002348)
	},
	[100330] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100330,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100330.png",
		LikeId = 100330,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100330.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002351),
		ItemTips = getI18NValue(180002350)
	},
	[100340] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100340,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100340,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203246),
		ItemTips = getI18NValue(180203245)
	},
	[100410] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100410,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30010.png",
		LikeId = 100410,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30010.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002353),
		ItemTips = getI18NValue(180002352)
	},
	[100420] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100420,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30011.png",
		LikeId = 100420,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30011.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002355),
		ItemTips = getI18NValue(180002354)
	},
	[100430] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100430,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30012.png",
		LikeId = 100430,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30012.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002357),
		ItemTips = getI18NValue(180002356)
	},
	[100440] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100440,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100440,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203248),
		ItemTips = getI18NValue(180203247)
	},
	[100510] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100510,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100510.png",
		LikeId = 100510,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100510.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002359),
		ItemTips = getI18NValue(180002358)
	},
	[100520] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100520,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100520.png",
		LikeId = 100520,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100520.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002361),
		ItemTips = getI18NValue(180002360)
	},
	[100530] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100530,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100530.png",
		LikeId = 100530,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100530.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002363),
		ItemTips = getI18NValue(180002362)
	},
	[100540] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100540,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100540,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203250),
		ItemTips = getI18NValue(180203249)
	},
	[100610] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100610,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100610.png",
		LikeId = 100610,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100610.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002365),
		ItemTips = getI18NValue(180002364)
	},
	[100620] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100620,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100620.png",
		LikeId = 100620,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100620.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002367),
		ItemTips = getI18NValue(180002366)
	},
	[100630] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100630,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100630.png",
		LikeId = 100630,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100630.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002369),
		ItemTips = getI18NValue(180002368)
	},
	[100640] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100640,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100640,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203252),
		ItemTips = getI18NValue(180203251)
	},
	[100710] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100710,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100710.png",
		LikeId = 100710,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100710.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002371),
		ItemTips = getI18NValue(180002370)
	},
	[100720] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100720,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100720.png",
		LikeId = 100720,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100720.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002373),
		ItemTips = getI18NValue(180002372)
	},
	[100730] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100730,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100730.png",
		LikeId = 100730,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100730.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002375),
		ItemTips = getI18NValue(180002374)
	},
	[100740] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100740,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100740,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203254),
		ItemTips = getI18NValue(180203253)
	},
	[100810] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100810,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100810.png",
		LikeId = 100810,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100810.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002377),
		ItemTips = getI18NValue(180002376)
	},
	[100820] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100820,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100820.png",
		LikeId = 100820,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100820.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002379),
		ItemTips = getI18NValue(180002378)
	},
	[100830] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100830,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100830.png",
		LikeId = 100830,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100830.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002381),
		ItemTips = getI18NValue(180002380)
	},
	[100840] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100840,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100840,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203256),
		ItemTips = getI18NValue(180203255)
	},
	[100910] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100910,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100910.png",
		LikeId = 100910,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100910.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002383),
		ItemTips = getI18NValue(180002382)
	},
	[100920] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100920,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100920.png",
		LikeId = 100920,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100920.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002385),
		ItemTips = getI18NValue(180002384)
	},
	[100930] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100930,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100930.png",
		LikeId = 100930,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100930.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002387),
		ItemTips = getI18NValue(180002386)
	},
	[100940] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 100940,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 100940,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203258),
		ItemTips = getI18NValue(180203257)
	},
	[101010] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101010,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101010.png",
		LikeId = 101010,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101010.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002389),
		ItemTips = getI18NValue(180002388)
	},
	[101020] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101020,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101020.png",
		LikeId = 101020,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101020.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002391),
		ItemTips = getI18NValue(180002390)
	},
	[101030] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101030,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101030.png",
		LikeId = 101030,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101030.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002393),
		ItemTips = getI18NValue(180002392)
	},
	[101040] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101040,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101040,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203260),
		ItemTips = getI18NValue(180203259)
	},
	[101110] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101110,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101110.png",
		LikeId = 101110,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101110.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002395),
		ItemTips = getI18NValue(180002394)
	},
	[101120] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101120,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101120.png",
		LikeId = 101120,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101120.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002397),
		ItemTips = getI18NValue(180002396)
	},
	[101130] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101130,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101130.png",
		LikeId = 101130,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101130.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002399),
		ItemTips = getI18NValue(180002398)
	},
	[101140] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101140,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101140,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203262),
		ItemTips = getI18NValue(180203261)
	},
	[101210] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101210,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101210.png",
		LikeId = 101210,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101210.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002401),
		ItemTips = getI18NValue(180002400)
	},
	[101220] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101220,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101220.png",
		LikeId = 101220,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101220.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002403),
		ItemTips = getI18NValue(180002402)
	},
	[101230] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101230,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101230.png",
		LikeId = 101230,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101230.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002405),
		ItemTips = getI18NValue(180002404)
	},
	[101240] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101240,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101240,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203264),
		ItemTips = getI18NValue(180203263)
	},
	[101310] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101310,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101310.png",
		LikeId = 101310,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101310.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002407),
		ItemTips = getI18NValue(180002406)
	},
	[101320] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101320,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101320.png",
		LikeId = 101320,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101320.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002409),
		ItemTips = getI18NValue(180002408)
	},
	[101330] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101330,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101330.png",
		LikeId = 101330,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101330.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002411),
		ItemTips = getI18NValue(180002410)
	},
	[101340] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101340,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101340,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203266),
		ItemTips = getI18NValue(180203265)
	},
	[101410] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101410,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101410.png",
		LikeId = 101410,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101410.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002413),
		ItemTips = getI18NValue(180002412)
	},
	[101420] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101420,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101420.png",
		LikeId = 101420,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101420.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002415),
		ItemTips = getI18NValue(180002414)
	},
	[101430] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101430,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101430.png",
		LikeId = 101430,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101430.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002417),
		ItemTips = getI18NValue(180002416)
	},
	[101440] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101440,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101440,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203268),
		ItemTips = getI18NValue(180203267)
	},
	[101510] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101510,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101510.png",
		LikeId = 101510,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101510.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002419),
		ItemTips = getI18NValue(180002418)
	},
	[101520] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101520,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101520.png",
		LikeId = 101520,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101520.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002421),
		ItemTips = getI18NValue(180002420)
	},
	[101530] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101530,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101530.png",
		LikeId = 101530,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101530.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002423),
		ItemTips = getI18NValue(180002422)
	},
	[101540] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101540,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101540,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203270),
		ItemTips = getI18NValue(180203269)
	},
	[101610] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101610,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101610.png",
		LikeId = 101610,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101610.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002425),
		ItemTips = getI18NValue(180002424)
	},
	[101620] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101620,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101620.png",
		LikeId = 101620,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101620.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002427),
		ItemTips = getI18NValue(180002426)
	},
	[101630] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101630,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101630.png",
		LikeId = 101630,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101630.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002429),
		ItemTips = getI18NValue(180002428)
	},
	[101640] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101640,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101640,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203272),
		ItemTips = getI18NValue(180203271)
	},
	[101710] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101710,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101710.png",
		LikeId = 101710,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101710.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002431),
		ItemTips = getI18NValue(180002430)
	},
	[101720] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101720,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101720.png",
		LikeId = 101720,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101720.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002433),
		ItemTips = getI18NValue(180002432)
	},
	[101730] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101730,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101730.png",
		LikeId = 101730,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101730.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002435),
		ItemTips = getI18NValue(180002434)
	},
	[101740] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101740,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101740,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203274),
		ItemTips = getI18NValue(180203273)
	},
	[101810] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101810,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101810.png",
		LikeId = 101810,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101810.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002437),
		ItemTips = getI18NValue(180002436)
	},
	[101820] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101820,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101820.png",
		LikeId = 101820,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101820.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002439),
		ItemTips = getI18NValue(180002438)
	},
	[101830] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101830,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101830.png",
		LikeId = 101830,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101830.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002441),
		ItemTips = getI18NValue(180002440)
	},
	[101840] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101840,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101840,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203276),
		ItemTips = getI18NValue(180203275)
	},
	[101910] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101910,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101910.png",
		LikeId = 101910,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101910.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002443),
		ItemTips = getI18NValue(180002442)
	},
	[101920] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101920,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101920.png",
		LikeId = 101920,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101920.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002445),
		ItemTips = getI18NValue(180002444)
	},
	[101930] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101930,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101930.png",
		LikeId = 101930,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101930.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180002447),
		ItemTips = getI18NValue(180002446)
	},
	[101940] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 101940,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 101940,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203278),
		ItemTips = getI18NValue(180203277)
	},
	[102010] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102010,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102010.png",
		LikeId = 102010,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102010.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017594),
		ItemTips = getI18NValue(180017593)
	},
	[102020] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102020,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102020.png",
		LikeId = 102020,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102020.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017596),
		ItemTips = getI18NValue(180017595)
	},
	[102030] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102030,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102030.png",
		LikeId = 102030,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102030.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017598),
		ItemTips = getI18NValue(180017597)
	},
	[102040] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102040,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102040,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203280),
		ItemTips = getI18NValue(180203279)
	},
	[102110] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102110,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102110.png",
		LikeId = 102110,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102110.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017600),
		ItemTips = getI18NValue(180017599)
	},
	[102120] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102120,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 102120,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017602),
		ItemTips = getI18NValue(180017601)
	},
	[102130] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102130,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102130.png",
		LikeId = 102130,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102130.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017604),
		ItemTips = getI18NValue(180017603)
	},
	[102140] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102140,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102140,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203282),
		ItemTips = getI18NValue(180203281)
	},
	[102210] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102210,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102210.png",
		LikeId = 102210,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102210.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017606),
		ItemTips = getI18NValue(180017605)
	},
	[102220] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102220,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102220.png",
		LikeId = 102220,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102220.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017608),
		ItemTips = getI18NValue(180017607)
	},
	[102230] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102230,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102230.png",
		LikeId = 102230,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102230.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017610),
		ItemTips = getI18NValue(180017609)
	},
	[102240] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102240,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102240,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203284),
		ItemTips = getI18NValue(180203283)
	},
	[102310] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102310,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102310.png",
		LikeId = 102310,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102310.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017612),
		ItemTips = getI18NValue(180017611)
	},
	[102320] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102320,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102320.png",
		LikeId = 102320,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102320.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017614),
		ItemTips = getI18NValue(180017613)
	},
	[102330] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102330,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102330.png",
		LikeId = 102330,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102330.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180017616),
		ItemTips = getI18NValue(180017615)
	},
	[102340] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102340,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102340,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203286),
		ItemTips = getI18NValue(180203285)
	},
	[102410] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102410,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102410.png",
		LikeId = 102410,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102410.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039173),
		ItemTips = getI18NValue(180039172)
	},
	[102420] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102420,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102420.png",
		LikeId = 102420,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102420.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039175),
		ItemTips = getI18NValue(180039174)
	},
	[102430] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 102430,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102430.png",
		LikeId = 102430,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102430.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039177),
		ItemTips = getI18NValue(180039176)
	},
	[102440] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102440,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102440,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203288),
		ItemTips = getI18NValue(180203287)
	},
	[102510] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102510,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102510.png",
		LikeId = 102510,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102510.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039179),
		ItemTips = getI18NValue(180039178)
	},
	[102520] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102520,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102520.png",
		LikeId = 102520,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102520.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039181),
		ItemTips = getI18NValue(180039180)
	},
	[102530] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102530,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102530.png",
		LikeId = 102530,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102530.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039183),
		ItemTips = getI18NValue(180039182)
	},
	[102540] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102540,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102540,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203290),
		ItemTips = getI18NValue(180203289)
	},
	[102610] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102610,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102610.png",
		LikeId = 102610,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102610.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039185),
		ItemTips = getI18NValue(180039184)
	},
	[102620] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102620,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102620.png",
		LikeId = 102620,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102620.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039187),
		ItemTips = getI18NValue(180039186)
	},
	[102630] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102630,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102630.png",
		LikeId = 102630,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102630.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039189),
		ItemTips = getI18NValue(180039188)
	},
	[102640] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102640,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102640,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203292),
		ItemTips = getI18NValue(180203291)
	},
	[102710] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102710,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102710.png",
		LikeId = 102710,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102710.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039191),
		ItemTips = getI18NValue(180039190)
	},
	[102720] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102720,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102720.png",
		LikeId = 102720,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102720.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039193),
		ItemTips = getI18NValue(180039192)
	},
	[102730] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102730,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102730.png",
		LikeId = 102730,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102730.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039195),
		ItemTips = getI18NValue(180039194)
	},
	[102740] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102740,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102740,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203294),
		ItemTips = getI18NValue(180203293)
	},
	[102810] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102810,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102810.png",
		LikeId = 102810,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102810.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039197),
		ItemTips = getI18NValue(180039196)
	},
	[102820] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102820,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102820.png",
		LikeId = 102820,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102820.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039199),
		ItemTips = getI18NValue(180039198)
	},
	[102830] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102830,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102830.png",
		LikeId = 102830,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102830.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039201),
		ItemTips = getI18NValue(180039200)
	},
	[102840] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102840,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102840,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203296),
		ItemTips = getI18NValue(180203295)
	},
	[102910] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102910,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102910.png",
		LikeId = 102910,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102910.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039203),
		ItemTips = getI18NValue(180039202)
	},
	[102920] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102920,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102920.png",
		LikeId = 102920,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102920.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039205),
		ItemTips = getI18NValue(180039204)
	},
	[102930] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102930,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102930.png",
		LikeId = 102930,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102930.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039207),
		ItemTips = getI18NValue(180039206)
	},
	[102940] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 102940,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 102940,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180203298),
		ItemTips = getI18NValue(180203297)
	},
	[103010] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103010,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103010.png",
		LikeId = 103010,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103010.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039209),
		ItemTips = getI18NValue(180039208)
	},
	[103020] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103020,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103020.png",
		LikeId = 103020,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103020.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039211),
		ItemTips = getI18NValue(180039210)
	},
	[103030] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103030,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103030.png",
		LikeId = 103030,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103030.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039213),
		ItemTips = getI18NValue(180039212)
	},
	[103040] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103040,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 103040,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180200939),
		ItemTips = getI18NValue(180200938)
	},
	[103110] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103110,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103110.png",
		LikeId = 103110,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103110.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039215),
		ItemTips = getI18NValue(180039214)
	},
	[103120] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103120,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103120.png",
		LikeId = 103120,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103120.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039217),
		ItemTips = getI18NValue(180039216)
	},
	[103130] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103130,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103130.png",
		LikeId = 103130,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103130.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039219),
		ItemTips = getI18NValue(180039218)
	},
	[103140] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103140,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 103140,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180200941),
		ItemTips = getI18NValue(180200940)
	},
	[103210] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103210,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103210.png",
		LikeId = 103210,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103210.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039221),
		ItemTips = getI18NValue(180039220)
	},
	[103220] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103220,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103220.png",
		LikeId = 103220,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103220.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039223),
		ItemTips = getI18NValue(180039222)
	},
	[103230] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103230,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_103230.png",
		LikeId = 103230,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_103230.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180039225),
		ItemTips = getI18NValue(180039224)
	},
	[103240] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103240,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 103240,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180200943),
		ItemTips = getI18NValue(180200942)
	},
	[103310] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103310,
		OverMode = 1,
		Star = false,
		Icon = "/Skill/Icon_Skill_103310.png",
		LikeId = 103310,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		BigIcon = "/Skill/Icon_Skill_103310.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180166451),
		ItemTips = getI18NValue(180166450)
	},
	[103320] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103320,
		OverMode = 1,
		Star = false,
		Icon = "/Skill/Icon_Skill_103320.png",
		LikeId = 103320,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		BigIcon = "/Skill/Icon_Skill_103320.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180166453),
		ItemTips = getI18NValue(180166452)
	},
	[103330] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103330,
		OverMode = 1,
		Star = false,
		Icon = "/Skill/Icon_Skill_103330.png",
		LikeId = 103330,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		BigIcon = "/Skill/Icon_Skill_103330.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180166455),
		ItemTips = getI18NValue(180166454)
	},
	[103340] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103340,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 103340,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180200945),
		ItemTips = getI18NValue(180200944)
	},
	[103410] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 103410,
		OverMode = 1,
		Star = false,
		Icon = "/Skill/Icon_Skill_103410.png",
		LikeId = 103410,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		BigIcon = "/Skill/Icon_Skill_103410.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180167454),
		ItemTips = getI18NValue(180167453)
	},
	[103420] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 103420,
		OverMode = 1,
		Star = false,
		Icon = "/Skill/Icon_Skill_103420.png",
		LikeId = 103420,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		BigIcon = "/Skill/Icon_Skill_103420.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180167456),
		ItemTips = getI18NValue(180167455)
	},
	[103430] = {
		ItemTypes = 4,
		Quality = 4,
		Id = 103430,
		OverMode = 1,
		Star = false,
		Icon = "/Skill/Icon_Skill_103430.png",
		LikeId = 103430,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		BigIcon = "/Skill/Icon_Skill_103430.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180167458),
		ItemTips = getI18NValue(180167457)
	},
	[103440] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 103440,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30003.png",
		LikeId = 103440,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180200947),
		ItemTips = getI18NValue(180200946)
	},
	[120001] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 120001,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180039227),
		ItemTips = getI18NValue(180039226)
	},
	[120002] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 120002,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101530.png",
		LikeId = 201020,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_101530.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180039229),
		ItemTips = getI18NValue(180039228)
	},
	[120003] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 120003,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_30012.png",
		LikeId = 201030,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_30012.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180039231),
		ItemTips = getI18NValue(180039230)
	},
	[120004] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 120004,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_100510.png",
		LikeId = 201040,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_100510.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180039233),
		ItemTips = getI18NValue(180039232)
	},
	[120005] = {
		ItemTypes = 4,
		Quality = 5,
		Id = 120005,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_101830.png",
		LikeId = 201050,
		MaxNum = 1,
		UnlockConditionId = 300004,
		BigIcon = "/Skill/Icon_Skill_101830.png",
		ItemSubTypes = 3,
		Name = getI18NValue(180039235),
		ItemTips = getI18NValue(180039234)
	},
	[110001] = {
		UserAction = 19,
		Quality = 5,
		Id = 110001,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259211),
		ItemTips = getI18NValue(180259210),
		ActionParams = {
			50
		}
	},
	[110002] = {
		UserAction = 19,
		Quality = 5,
		Id = 110002,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259213),
		ItemTips = getI18NValue(180259212),
		ActionParams = {
			51
		}
	},
	[110003] = {
		UserAction = 19,
		Quality = 5,
		Id = 110003,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259215),
		ItemTips = getI18NValue(180259214),
		ActionParams = {
			52
		}
	},
	[110004] = {
		UserAction = 19,
		Quality = 5,
		Id = 110004,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259217),
		ItemTips = getI18NValue(180259216),
		ActionParams = {
			53
		}
	},
	[110101] = {
		UserAction = 19,
		Quality = 5,
		Id = 110101,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259219),
		ItemTips = getI18NValue(180259218),
		ActionParams = {
			60
		}
	},
	[110102] = {
		UserAction = 19,
		Quality = 5,
		Id = 110102,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259221),
		ItemTips = getI18NValue(180259220),
		ActionParams = {
			61
		}
	},
	[110103] = {
		UserAction = 19,
		Quality = 5,
		Id = 110103,
		OverMode = 1,
		ItemTypes = 6,
		Icon = "/Item/BagBig_61011.png",
		MaxUse = 1,
		Reveal = true,
		UseType = 1,
		MaxNum = 1,
		ItemSubTypes = 1,
		DepotType = 16,
		Name = getI18NValue(180259223),
		ItemTips = getI18NValue(180259222),
		ActionParams = {
			62
		}
	},
	[130101] = {
		UserAction = 45,
		Quality = 5,
		Id = 130101,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241702),
		ItemTips = getI18NValue(180253873),
		ActionParams = {
			1001
		}
	},
	[130102] = {
		UserAction = 45,
		Quality = 5,
		Id = 130102,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241703),
		ItemTips = getI18NValue(180253874),
		ActionParams = {
			1002
		}
	},
	[130103] = {
		UserAction = 45,
		Quality = 5,
		Id = 130103,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241704),
		ItemTips = getI18NValue(180253875),
		ActionParams = {
			1003
		}
	},
	[130104] = {
		UserAction = 45,
		Quality = 5,
		Id = 130104,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241705),
		ItemTips = getI18NValue(180253876),
		ActionParams = {
			1004
		}
	},
	[130105] = {
		UserAction = 45,
		Quality = 5,
		Id = 130105,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241706),
		ItemTips = getI18NValue(180253877),
		ActionParams = {
			1005
		}
	},
	[130106] = {
		UserAction = 45,
		Quality = 5,
		Id = 130106,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241707),
		ItemTips = getI18NValue(180253878),
		ActionParams = {
			1006
		}
	},
	[130107] = {
		UserAction = 45,
		Quality = 5,
		Id = 130107,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241708),
		ItemTips = getI18NValue(180253879),
		ActionParams = {
			1007
		}
	},
	[130108] = {
		UserAction = 45,
		Quality = 5,
		Id = 130108,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241709),
		ItemTips = getI18NValue(180253880),
		ActionParams = {
			1008
		}
	},
	[130109] = {
		UserAction = 45,
		Quality = 5,
		Id = 130109,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241710),
		ItemTips = getI18NValue(180253881),
		ActionParams = {
			1009
		}
	},
	[130110] = {
		UserAction = 45,
		Quality = 5,
		Id = 130110,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241711),
		ItemTips = getI18NValue(180253882),
		ActionParams = {
			1010
		}
	},
	[130111] = {
		UserAction = 45,
		Quality = 5,
		Id = 130111,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241712),
		ItemTips = getI18NValue(180253883),
		ActionParams = {
			1011
		}
	},
	[130112] = {
		UserAction = 45,
		Quality = 5,
		Id = 130112,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241713),
		ItemTips = getI18NValue(180253884),
		ActionParams = {
			1012
		}
	},
	[130201] = {
		UserAction = 45,
		Quality = 5,
		Id = 130201,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241714),
		ItemTips = getI18NValue(180253885),
		ActionParams = {
			2001
		}
	},
	[130202] = {
		UserAction = 45,
		Quality = 5,
		Id = 130202,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241715),
		ItemTips = getI18NValue(180253886),
		ActionParams = {
			2002
		}
	},
	[130203] = {
		UserAction = 45,
		Quality = 5,
		Id = 130203,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241716),
		ItemTips = getI18NValue(180253887),
		ActionParams = {
			2003
		}
	},
	[130204] = {
		UserAction = 45,
		Quality = 5,
		Id = 130204,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241717),
		ItemTips = getI18NValue(180253888),
		ActionParams = {
			2004
		}
	},
	[130205] = {
		UserAction = 45,
		Quality = 5,
		Id = 130205,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241718),
		ItemTips = getI18NValue(180253889),
		ActionParams = {
			2005
		}
	},
	[130206] = {
		UserAction = 45,
		Quality = 5,
		Id = 130206,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241719),
		ItemTips = getI18NValue(180253890),
		ActionParams = {
			2006
		}
	},
	[130207] = {
		UserAction = 45,
		Quality = 5,
		Id = 130207,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241720),
		ItemTips = getI18NValue(180253891),
		ActionParams = {
			2007
		}
	},
	[130208] = {
		UserAction = 45,
		Quality = 5,
		Id = 130208,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241721),
		ItemTips = getI18NValue(180253892),
		ActionParams = {
			2008
		}
	},
	[130209] = {
		UserAction = 45,
		Quality = 5,
		Id = 130209,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241722),
		ItemTips = getI18NValue(180253893),
		ActionParams = {
			2009
		}
	},
	[130210] = {
		UserAction = 45,
		Quality = 5,
		Id = 130210,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241723),
		ItemTips = getI18NValue(180253894),
		ActionParams = {
			2010
		}
	},
	[130211] = {
		UserAction = 45,
		Quality = 5,
		Id = 130211,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241724),
		ItemTips = getI18NValue(180253895),
		ActionParams = {
			2011
		}
	},
	[130212] = {
		UserAction = 45,
		Quality = 5,
		Id = 130212,
		OverMode = 1,
		Icon = "/Skill/Icon_Skill_102120.png",
		LikeId = 201010,
		UseType = 1,
		MaxNum = 1,
		BigIcon = "/Skill/Icon_Skill_102120.png",
		ItemSubTypes = 14,
		Name = getI18NValue(180241725),
		ItemTips = getI18NValue(180253896),
		ActionParams = {
			2012
		}
	},
	[200001] = {
		ItemTypes = 3,
		Quality = 5,
		Id = 200001,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 10001,
		Reveal = true,
		Part = 1,
		BigIcon = "/EquipLarge/Icon_EquipLarge_21.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180002879),
		ItemTips = getI18NValue(180002878)
	},
	[200002] = {
		ItemTypes = 3,
		Quality = 5,
		Id = 200002,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_22.png",
		LikeId = 10002,
		Reveal = true,
		Part = 2,
		BigIcon = "/EquipLarge/Icon_EquipLarge_22.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180002881),
		ItemTips = getI18NValue(180002880)
	},
	[200003] = {
		ItemTypes = 3,
		Quality = 5,
		Id = 200003,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_23.png",
		LikeId = 10003,
		Reveal = true,
		Part = 3,
		BigIcon = "/EquipLarge/Icon_EquipLarge_23.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180002883),
		ItemTips = getI18NValue(180002882)
	},
	[200004] = {
		ItemTypes = 3,
		Quality = 5,
		Id = 200004,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_24.png",
		LikeId = 10004,
		Reveal = true,
		Part = 4,
		BigIcon = "/EquipLarge/Icon_EquipLarge_24.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180002885),
		ItemTips = getI18NValue(180002884)
	},
	[200111] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 10111,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200111,
		BigIcon = "/EquipLarge/Icon_EquipLarge_01.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017618),
		Source = {
			11203100
		}
	},
	[200112] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_02.png",
		LikeId = 10112,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200112,
		BigIcon = "/EquipLarge/Icon_EquipLarge_02.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017620),
		Source = {
			11203100
		}
	},
	[200113] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_03.png",
		LikeId = 10113,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200113,
		BigIcon = "/EquipLarge/Icon_EquipLarge_03.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017622),
		Source = {
			11203100
		}
	},
	[200114] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_04.png",
		LikeId = 10114,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200114,
		BigIcon = "/EquipLarge/Icon_EquipLarge_04.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017624),
		Source = {
			11203100
		}
	},
	[200121] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 10121,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200121,
		BigIcon = "/EquipLarge/Icon_EquipLarge_01.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017628),
		Source = {
			11203100
		}
	},
	[200122] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_02.png",
		LikeId = 10122,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200122,
		BigIcon = "/EquipLarge/Icon_EquipLarge_02.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017630),
		Source = {
			11203100
		}
	},
	[200123] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_03.png",
		LikeId = 10123,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200123,
		BigIcon = "/EquipLarge/Icon_EquipLarge_03.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017632),
		Source = {
			11203100
		}
	},
	[200124] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_04.png",
		LikeId = 10124,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200124,
		BigIcon = "/EquipLarge/Icon_EquipLarge_04.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017634),
		Source = {
			11203100
		}
	},
	[200131] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 10131,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200131,
		BigIcon = "/EquipLarge/Icon_EquipLarge_01.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017638),
		Source = {
			11203100
		}
	},
	[200132] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_02.png",
		LikeId = 10132,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200132,
		BigIcon = "/EquipLarge/Icon_EquipLarge_02.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017640),
		Source = {
			11203100
		}
	},
	[200133] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_03.png",
		LikeId = 10133,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200133,
		BigIcon = "/EquipLarge/Icon_EquipLarge_03.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017642),
		Source = {
			11203100
		}
	},
	[200134] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_04.png",
		LikeId = 10134,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200134,
		BigIcon = "/EquipLarge/Icon_EquipLarge_04.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017644),
		Source = {
			11203100
		}
	},
	[200141] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 10141,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200141,
		BigIcon = "/EquipLarge/Icon_EquipLarge_01.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017648),
		Source = {
			11203100
		}
	},
	[200142] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_02.png",
		LikeId = 10142,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200142,
		BigIcon = "/EquipLarge/Icon_EquipLarge_02.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017650),
		Source = {
			11203100
		}
	},
	[200143] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_03.png",
		LikeId = 10143,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200143,
		BigIcon = "/EquipLarge/Icon_EquipLarge_03.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017652),
		Source = {
			11203100
		}
	},
	[200144] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_04.png",
		LikeId = 10144,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200144,
		BigIcon = "/EquipLarge/Icon_EquipLarge_04.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017654),
		Source = {
			11203100
		}
	},
	[200151] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 10151,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200151,
		BigIcon = "/EquipLarge/Icon_EquipLarge_01.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017658),
		Source = {
			11203100
		}
	},
	[200152] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_02.png",
		LikeId = 10152,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200152,
		BigIcon = "/EquipLarge/Icon_EquipLarge_02.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017660),
		Source = {
			11203100
		}
	},
	[200153] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_03.png",
		LikeId = 10153,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200153,
		BigIcon = "/EquipLarge/Icon_EquipLarge_03.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017662),
		Source = {
			11203100
		}
	},
	[200154] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_04.png",
		LikeId = 10154,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200154,
		BigIcon = "/EquipLarge/Icon_EquipLarge_04.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017664),
		Source = {
			11203100
		}
	},
	[200211] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 10211,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200211,
		BigIcon = "/EquipLarge/Icon_EquipLarge_06.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017678),
		Source = {
			11203300
		}
	},
	[200212] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_07.png",
		LikeId = 10212,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200212,
		BigIcon = "/EquipLarge/Icon_EquipLarge_07.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017680),
		Source = {
			11203300
		}
	},
	[200213] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_08.png",
		LikeId = 10213,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200213,
		BigIcon = "/EquipLarge/Icon_EquipLarge_08.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017682),
		Source = {
			11203300
		}
	},
	[200214] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_09.png",
		LikeId = 10214,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200214,
		BigIcon = "/EquipLarge/Icon_EquipLarge_09.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017684),
		Source = {
			11203300
		}
	},
	[200221] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 10221,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200221,
		BigIcon = "/EquipLarge/Icon_EquipLarge_06.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017688),
		Source = {
			11203300
		}
	},
	[200222] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_07.png",
		LikeId = 10222,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200222,
		BigIcon = "/EquipLarge/Icon_EquipLarge_07.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017690),
		Source = {
			11203300
		}
	},
	[200223] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_08.png",
		LikeId = 10223,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200223,
		BigIcon = "/EquipLarge/Icon_EquipLarge_08.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017692),
		Source = {
			11203300
		}
	},
	[200224] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_09.png",
		LikeId = 10224,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200224,
		BigIcon = "/EquipLarge/Icon_EquipLarge_09.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017694),
		Source = {
			11203300
		}
	},
	[200231] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 10231,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200231,
		BigIcon = "/EquipLarge/Icon_EquipLarge_06.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017698),
		Source = {
			11203300
		}
	},
	[200232] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_07.png",
		LikeId = 10232,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200232,
		BigIcon = "/EquipLarge/Icon_EquipLarge_07.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017700),
		Source = {
			11203300
		}
	},
	[200233] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_08.png",
		LikeId = 10233,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200233,
		BigIcon = "/EquipLarge/Icon_EquipLarge_08.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017702),
		Source = {
			11203300
		}
	},
	[200234] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_09.png",
		LikeId = 10234,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200234,
		BigIcon = "/EquipLarge/Icon_EquipLarge_09.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017704),
		Source = {
			11203300
		}
	},
	[200241] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 10241,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200241,
		BigIcon = "/EquipLarge/Icon_EquipLarge_06.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017708),
		Source = {
			11203300
		}
	},
	[200242] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_07.png",
		LikeId = 10242,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200242,
		BigIcon = "/EquipLarge/Icon_EquipLarge_07.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017710),
		Source = {
			11203300
		}
	},
	[200243] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_08.png",
		LikeId = 10243,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200243,
		BigIcon = "/EquipLarge/Icon_EquipLarge_08.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017712),
		Source = {
			11203300
		}
	},
	[200244] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_09.png",
		LikeId = 10244,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200244,
		BigIcon = "/EquipLarge/Icon_EquipLarge_09.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017714),
		Source = {
			11203300
		}
	},
	[200251] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 10251,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200251,
		BigIcon = "/EquipLarge/Icon_EquipLarge_06.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017718),
		Source = {
			11203300
		}
	},
	[200252] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_07.png",
		LikeId = 10252,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200252,
		BigIcon = "/EquipLarge/Icon_EquipLarge_07.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017720),
		Source = {
			11203300
		}
	},
	[200253] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_08.png",
		LikeId = 10253,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200253,
		BigIcon = "/EquipLarge/Icon_EquipLarge_08.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017722),
		Source = {
			11203300
		}
	},
	[200254] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_09.png",
		LikeId = 10254,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200254,
		BigIcon = "/EquipLarge/Icon_EquipLarge_09.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017724),
		Source = {
			11203300
		}
	},
	[200311] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 10311,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200311,
		BigIcon = "/EquipLarge/Icon_EquipLarge_11.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017738),
		Source = {
			11203200
		}
	},
	[200312] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_12.png",
		LikeId = 10312,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200312,
		BigIcon = "/EquipLarge/Icon_EquipLarge_12.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017740),
		Source = {
			11203200
		}
	},
	[200313] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_13.png",
		LikeId = 10313,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200313,
		BigIcon = "/EquipLarge/Icon_EquipLarge_13.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017742),
		Source = {
			11203200
		}
	},
	[200314] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_14.png",
		LikeId = 10314,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200314,
		BigIcon = "/EquipLarge/Icon_EquipLarge_14.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017744),
		Source = {
			11203200
		}
	},
	[200321] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 10321,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200321,
		BigIcon = "/EquipLarge/Icon_EquipLarge_11.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017748),
		Source = {
			11203200
		}
	},
	[200322] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_12.png",
		LikeId = 10322,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200322,
		BigIcon = "/EquipLarge/Icon_EquipLarge_12.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017750),
		Source = {
			11203200
		}
	},
	[200323] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_13.png",
		LikeId = 10323,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200323,
		BigIcon = "/EquipLarge/Icon_EquipLarge_13.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017752),
		Source = {
			11203200
		}
	},
	[200324] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_14.png",
		LikeId = 10324,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200324,
		BigIcon = "/EquipLarge/Icon_EquipLarge_14.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017754),
		Source = {
			11203200
		}
	},
	[200331] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 10331,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200331,
		BigIcon = "/EquipLarge/Icon_EquipLarge_11.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017758),
		Source = {
			11203200
		}
	},
	[200332] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_12.png",
		LikeId = 10332,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200332,
		BigIcon = "/EquipLarge/Icon_EquipLarge_12.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017760),
		Source = {
			11203200
		}
	},
	[200333] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_13.png",
		LikeId = 10333,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200333,
		BigIcon = "/EquipLarge/Icon_EquipLarge_13.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017762),
		Source = {
			11203200
		}
	},
	[200334] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_14.png",
		LikeId = 10334,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200334,
		BigIcon = "/EquipLarge/Icon_EquipLarge_14.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017764),
		Source = {
			11203200
		}
	},
	[200341] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 10341,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200341,
		BigIcon = "/EquipLarge/Icon_EquipLarge_11.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017768),
		Source = {
			11203200
		}
	},
	[200342] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_12.png",
		LikeId = 10342,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200342,
		BigIcon = "/EquipLarge/Icon_EquipLarge_12.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017770),
		Source = {
			11203200
		}
	},
	[200343] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_13.png",
		LikeId = 10343,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200343,
		BigIcon = "/EquipLarge/Icon_EquipLarge_13.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017772),
		Source = {
			11203200
		}
	},
	[200344] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_14.png",
		LikeId = 10344,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200344,
		BigIcon = "/EquipLarge/Icon_EquipLarge_14.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017774),
		Source = {
			11203200
		}
	},
	[200351] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 10351,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200351,
		BigIcon = "/EquipLarge/Icon_EquipLarge_11.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017778),
		Source = {
			11203200
		}
	},
	[200352] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_12.png",
		LikeId = 10352,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200352,
		BigIcon = "/EquipLarge/Icon_EquipLarge_12.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017780),
		Source = {
			11203200
		}
	},
	[200353] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_13.png",
		LikeId = 10353,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200353,
		BigIcon = "/EquipLarge/Icon_EquipLarge_13.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017782),
		Source = {
			11203200
		}
	},
	[200354] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_14.png",
		LikeId = 10354,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200354,
		BigIcon = "/EquipLarge/Icon_EquipLarge_14.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017784),
		Source = {
			11203200
		}
	},
	[200411] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 10411,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200411,
		BigIcon = "/EquipLarge/Icon_EquipLarge_16.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017798),
		Source = {
			11203400
		}
	},
	[200412] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_17.png",
		LikeId = 10412,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200412,
		BigIcon = "/EquipLarge/Icon_EquipLarge_17.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017800),
		Source = {
			11203400
		}
	},
	[200413] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_18.png",
		LikeId = 10413,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200413,
		BigIcon = "/EquipLarge/Icon_EquipLarge_18.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017802),
		Source = {
			11203400
		}
	},
	[200414] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_19.png",
		LikeId = 10414,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200414,
		BigIcon = "/EquipLarge/Icon_EquipLarge_19.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017804),
		Source = {
			11203400
		}
	},
	[200421] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 10421,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200421,
		BigIcon = "/EquipLarge/Icon_EquipLarge_16.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017808),
		Source = {
			11203400
		}
	},
	[200422] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_17.png",
		LikeId = 10422,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200422,
		BigIcon = "/EquipLarge/Icon_EquipLarge_17.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017810),
		Source = {
			11203400
		}
	},
	[200423] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_18.png",
		LikeId = 10423,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200423,
		BigIcon = "/EquipLarge/Icon_EquipLarge_18.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017812),
		Source = {
			11203400
		}
	},
	[200424] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_19.png",
		LikeId = 10424,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200424,
		BigIcon = "/EquipLarge/Icon_EquipLarge_19.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017814),
		Source = {
			11203400
		}
	},
	[200431] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 10431,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200431,
		BigIcon = "/EquipLarge/Icon_EquipLarge_16.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017818),
		Source = {
			11203400
		}
	},
	[200432] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_17.png",
		LikeId = 10432,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200432,
		BigIcon = "/EquipLarge/Icon_EquipLarge_17.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017820),
		Source = {
			11203400
		}
	},
	[200433] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_18.png",
		LikeId = 10433,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200433,
		BigIcon = "/EquipLarge/Icon_EquipLarge_18.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017822),
		Source = {
			11203400
		}
	},
	[200434] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_19.png",
		LikeId = 10434,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200434,
		BigIcon = "/EquipLarge/Icon_EquipLarge_19.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017824),
		Source = {
			11203400
		}
	},
	[200441] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 10441,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200441,
		BigIcon = "/EquipLarge/Icon_EquipLarge_16.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017828),
		Source = {
			11203400
		}
	},
	[200442] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_17.png",
		LikeId = 10442,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200442,
		BigIcon = "/EquipLarge/Icon_EquipLarge_17.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017830),
		Source = {
			11203400
		}
	},
	[200443] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_18.png",
		LikeId = 10443,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200443,
		BigIcon = "/EquipLarge/Icon_EquipLarge_18.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017832),
		Source = {
			11203400
		}
	},
	[200444] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_19.png",
		LikeId = 10444,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200444,
		BigIcon = "/EquipLarge/Icon_EquipLarge_19.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017834),
		Source = {
			11203400
		}
	},
	[200451] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 10451,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200451,
		BigIcon = "/EquipLarge/Icon_EquipLarge_16.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017838),
		Source = {
			11203400
		}
	},
	[200452] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_17.png",
		LikeId = 10452,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200452,
		BigIcon = "/EquipLarge/Icon_EquipLarge_17.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017840),
		Source = {
			11203400
		}
	},
	[200453] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_18.png",
		LikeId = 10453,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200453,
		BigIcon = "/EquipLarge/Icon_EquipLarge_18.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017842),
		Source = {
			11203400
		}
	},
	[200454] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_19.png",
		LikeId = 10454,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200454,
		BigIcon = "/EquipLarge/Icon_EquipLarge_19.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017844),
		Source = {
			11203400
		}
	},
	[200511] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 10511,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200511,
		BigIcon = "/EquipLarge/Icon_EquipLarge_21.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017858),
		Source = {
			11203200
		}
	},
	[200512] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_22.png",
		LikeId = 10512,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200512,
		BigIcon = "/EquipLarge/Icon_EquipLarge_22.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017860),
		Source = {
			11203200
		}
	},
	[200513] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_23.png",
		LikeId = 10513,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200513,
		BigIcon = "/EquipLarge/Icon_EquipLarge_23.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017862),
		Source = {
			11203200
		}
	},
	[200514] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_24.png",
		LikeId = 10514,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200514,
		BigIcon = "/EquipLarge/Icon_EquipLarge_24.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017864),
		Source = {
			11203200
		}
	},
	[200521] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 10521,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200521,
		BigIcon = "/EquipLarge/Icon_EquipLarge_21.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017868),
		Source = {
			11203200
		}
	},
	[200522] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_22.png",
		LikeId = 10522,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200522,
		BigIcon = "/EquipLarge/Icon_EquipLarge_22.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017870),
		Source = {
			11203200
		}
	},
	[200523] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_23.png",
		LikeId = 10523,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200523,
		BigIcon = "/EquipLarge/Icon_EquipLarge_23.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017872),
		Source = {
			11203200
		}
	},
	[200524] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_24.png",
		LikeId = 10524,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200524,
		BigIcon = "/EquipLarge/Icon_EquipLarge_24.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017874),
		Source = {
			11203200
		}
	},
	[200531] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 10531,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200531,
		BigIcon = "/EquipLarge/Icon_EquipLarge_21.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017878),
		Source = {
			11203200
		}
	},
	[200532] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_22.png",
		LikeId = 10532,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200532,
		BigIcon = "/EquipLarge/Icon_EquipLarge_22.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017880),
		Source = {
			11203200
		}
	},
	[200533] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_23.png",
		LikeId = 10533,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200533,
		BigIcon = "/EquipLarge/Icon_EquipLarge_23.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017882),
		Source = {
			11203200
		}
	},
	[200534] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_24.png",
		LikeId = 10534,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200534,
		BigIcon = "/EquipLarge/Icon_EquipLarge_24.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017884),
		Source = {
			11203200
		}
	},
	[200541] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 10541,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200541,
		BigIcon = "/EquipLarge/Icon_EquipLarge_21.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017888),
		Source = {
			11203200
		}
	},
	[200542] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_22.png",
		LikeId = 10542,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200542,
		BigIcon = "/EquipLarge/Icon_EquipLarge_22.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017890),
		Source = {
			11203200
		}
	},
	[200543] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_23.png",
		LikeId = 10543,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200543,
		BigIcon = "/EquipLarge/Icon_EquipLarge_23.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017892),
		Source = {
			11203200
		}
	},
	[200544] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_24.png",
		LikeId = 10544,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200544,
		BigIcon = "/EquipLarge/Icon_EquipLarge_24.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017894),
		Source = {
			11203200
		}
	},
	[200551] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 10551,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200551,
		BigIcon = "/EquipLarge/Icon_EquipLarge_21.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017898),
		Source = {
			11203200
		}
	},
	[200552] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_22.png",
		LikeId = 10552,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200552,
		BigIcon = "/EquipLarge/Icon_EquipLarge_22.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017900),
		Source = {
			11203200
		}
	},
	[200553] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_23.png",
		LikeId = 10553,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200553,
		BigIcon = "/EquipLarge/Icon_EquipLarge_23.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017902),
		Source = {
			11203200
		}
	},
	[200554] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_24.png",
		LikeId = 10554,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200554,
		BigIcon = "/EquipLarge/Icon_EquipLarge_24.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017904),
		Source = {
			11203200
		}
	},
	[200611] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 10611,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200611,
		BigIcon = "/EquipLarge/Icon_EquipLarge_26.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017917),
		Source = {
			11203300
		}
	},
	[200612] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_27.png",
		LikeId = 10612,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200612,
		BigIcon = "/EquipLarge/Icon_EquipLarge_27.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017918),
		Source = {
			11203300
		}
	},
	[200613] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_28.png",
		LikeId = 10613,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200613,
		BigIcon = "/EquipLarge/Icon_EquipLarge_28.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017919),
		Source = {
			11203300
		}
	},
	[200614] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_29.png",
		LikeId = 10614,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200614,
		BigIcon = "/EquipLarge/Icon_EquipLarge_29.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017920),
		Source = {
			11203300
		}
	},
	[200621] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 10621,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200621,
		BigIcon = "/EquipLarge/Icon_EquipLarge_26.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017922),
		Source = {
			11203300
		}
	},
	[200622] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_27.png",
		LikeId = 10622,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200622,
		BigIcon = "/EquipLarge/Icon_EquipLarge_27.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017923),
		Source = {
			11203300
		}
	},
	[200623] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_28.png",
		LikeId = 10623,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200623,
		BigIcon = "/EquipLarge/Icon_EquipLarge_28.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017924),
		Source = {
			11203300
		}
	},
	[200624] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_29.png",
		LikeId = 10624,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200624,
		BigIcon = "/EquipLarge/Icon_EquipLarge_29.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017925),
		Source = {
			11203300
		}
	},
	[200631] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 10631,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200631,
		BigIcon = "/EquipLarge/Icon_EquipLarge_26.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017927),
		Source = {
			11203300
		}
	},
	[200632] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_27.png",
		LikeId = 10632,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200632,
		BigIcon = "/EquipLarge/Icon_EquipLarge_27.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017928),
		Source = {
			11203300
		}
	},
	[200633] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_28.png",
		LikeId = 10633,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200633,
		BigIcon = "/EquipLarge/Icon_EquipLarge_28.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017929),
		Source = {
			11203300
		}
	},
	[200634] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_29.png",
		LikeId = 10634,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200634,
		BigIcon = "/EquipLarge/Icon_EquipLarge_29.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017930),
		Source = {
			11203300
		}
	},
	[200641] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 10641,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200641,
		BigIcon = "/EquipLarge/Icon_EquipLarge_26.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017932),
		Source = {
			11203300
		}
	},
	[200642] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_27.png",
		LikeId = 10642,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200642,
		BigIcon = "/EquipLarge/Icon_EquipLarge_27.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017933),
		Source = {
			11203300
		}
	},
	[200643] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_28.png",
		LikeId = 10643,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200643,
		BigIcon = "/EquipLarge/Icon_EquipLarge_28.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017934),
		Source = {
			11203300
		}
	},
	[200644] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_29.png",
		LikeId = 10644,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200644,
		BigIcon = "/EquipLarge/Icon_EquipLarge_29.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017935),
		Source = {
			11203300
		}
	},
	[200651] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 10651,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200651,
		BigIcon = "/EquipLarge/Icon_EquipLarge_26.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017937),
		Source = {
			11203300
		}
	},
	[200652] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_27.png",
		LikeId = 10652,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200652,
		BigIcon = "/EquipLarge/Icon_EquipLarge_27.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017938),
		Source = {
			11203300
		}
	},
	[200653] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_28.png",
		LikeId = 10653,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200653,
		BigIcon = "/EquipLarge/Icon_EquipLarge_28.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017939),
		Source = {
			11203300
		}
	},
	[200654] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_29.png",
		LikeId = 10654,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200654,
		BigIcon = "/EquipLarge/Icon_EquipLarge_29.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017940),
		Source = {
			11203300
		}
	},
	[200711] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 10711,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200711,
		BigIcon = "/EquipLarge/Icon_EquipLarge_31.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017947),
		Source = {
			11203100
		}
	},
	[200712] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_32.png",
		LikeId = 10712,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200712,
		BigIcon = "/EquipLarge/Icon_EquipLarge_32.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017948),
		Source = {
			11203100
		}
	},
	[200713] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_33.png",
		LikeId = 10713,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200713,
		BigIcon = "/EquipLarge/Icon_EquipLarge_33.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017949),
		Source = {
			11203100
		}
	},
	[200714] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_34.png",
		LikeId = 10714,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200714,
		BigIcon = "/EquipLarge/Icon_EquipLarge_34.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017950),
		Source = {
			11203100
		}
	},
	[200721] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 10721,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200721,
		BigIcon = "/EquipLarge/Icon_EquipLarge_31.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017952),
		Source = {
			11203100
		}
	},
	[200722] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_32.png",
		LikeId = 10722,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200722,
		BigIcon = "/EquipLarge/Icon_EquipLarge_32.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017953),
		Source = {
			11203100
		}
	},
	[200723] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_33.png",
		LikeId = 10723,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200723,
		BigIcon = "/EquipLarge/Icon_EquipLarge_33.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017954),
		Source = {
			11203100
		}
	},
	[200724] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_34.png",
		LikeId = 10724,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200724,
		BigIcon = "/EquipLarge/Icon_EquipLarge_34.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017955),
		Source = {
			11203100
		}
	},
	[200731] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 10731,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200731,
		BigIcon = "/EquipLarge/Icon_EquipLarge_31.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017957),
		Source = {
			11203100
		}
	},
	[200732] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_32.png",
		LikeId = 10732,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200732,
		BigIcon = "/EquipLarge/Icon_EquipLarge_32.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017958),
		Source = {
			11203100
		}
	},
	[200733] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_33.png",
		LikeId = 10733,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200733,
		BigIcon = "/EquipLarge/Icon_EquipLarge_33.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017959),
		Source = {
			11203100
		}
	},
	[200734] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_34.png",
		LikeId = 10734,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200734,
		BigIcon = "/EquipLarge/Icon_EquipLarge_34.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017960),
		Source = {
			11203100
		}
	},
	[200741] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 10741,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200741,
		BigIcon = "/EquipLarge/Icon_EquipLarge_31.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017962),
		Source = {
			11203100
		}
	},
	[200742] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_32.png",
		LikeId = 10742,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200742,
		BigIcon = "/EquipLarge/Icon_EquipLarge_32.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017963),
		Source = {
			11203100
		}
	},
	[200743] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_33.png",
		LikeId = 10743,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200743,
		BigIcon = "/EquipLarge/Icon_EquipLarge_33.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017964),
		Source = {
			11203100
		}
	},
	[200744] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_34.png",
		LikeId = 10744,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200744,
		BigIcon = "/EquipLarge/Icon_EquipLarge_34.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017965),
		Source = {
			11203100
		}
	},
	[200751] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 10751,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200751,
		BigIcon = "/EquipLarge/Icon_EquipLarge_31.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017967),
		Source = {
			11203100
		}
	},
	[200752] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_32.png",
		LikeId = 10752,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200752,
		BigIcon = "/EquipLarge/Icon_EquipLarge_32.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017968),
		Source = {
			11203100
		}
	},
	[200753] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_33.png",
		LikeId = 10753,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200753,
		BigIcon = "/EquipLarge/Icon_EquipLarge_33.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017969),
		Source = {
			11203100
		}
	},
	[200754] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_34.png",
		LikeId = 10754,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200754,
		BigIcon = "/EquipLarge/Icon_EquipLarge_34.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017970),
		Source = {
			11203100
		}
	},
	[200811] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 10811,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200811,
		BigIcon = "/EquipLarge/Icon_EquipLarge_36.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017977),
		Source = {
			11203400
		}
	},
	[200812] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_37.png",
		LikeId = 10812,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200812,
		BigIcon = "/EquipLarge/Icon_EquipLarge_37.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017978),
		Source = {
			11203400
		}
	},
	[200813] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_38.png",
		LikeId = 10813,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200813,
		BigIcon = "/EquipLarge/Icon_EquipLarge_38.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017979),
		Source = {
			11203400
		}
	},
	[200814] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_39.png",
		LikeId = 10814,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200814,
		BigIcon = "/EquipLarge/Icon_EquipLarge_39.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017980),
		Source = {
			11203400
		}
	},
	[200821] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 10821,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200821,
		BigIcon = "/EquipLarge/Icon_EquipLarge_36.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017982),
		Source = {
			11203400
		}
	},
	[200822] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_37.png",
		LikeId = 10822,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200822,
		BigIcon = "/EquipLarge/Icon_EquipLarge_37.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017983),
		Source = {
			11203400
		}
	},
	[200823] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_38.png",
		LikeId = 10823,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200823,
		BigIcon = "/EquipLarge/Icon_EquipLarge_38.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017984),
		Source = {
			11203400
		}
	},
	[200824] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_39.png",
		LikeId = 10824,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200824,
		BigIcon = "/EquipLarge/Icon_EquipLarge_39.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017985),
		Source = {
			11203400
		}
	},
	[200831] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 10831,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200831,
		BigIcon = "/EquipLarge/Icon_EquipLarge_36.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017987),
		Source = {
			11203400
		}
	},
	[200832] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_37.png",
		LikeId = 10832,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200832,
		BigIcon = "/EquipLarge/Icon_EquipLarge_37.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017988),
		Source = {
			11203400
		}
	},
	[200833] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_38.png",
		LikeId = 10833,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200833,
		BigIcon = "/EquipLarge/Icon_EquipLarge_38.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017989),
		Source = {
			11203400
		}
	},
	[200834] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_39.png",
		LikeId = 10834,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200834,
		BigIcon = "/EquipLarge/Icon_EquipLarge_39.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017990),
		Source = {
			11203400
		}
	},
	[200841] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 10841,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200841,
		BigIcon = "/EquipLarge/Icon_EquipLarge_36.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017992),
		Source = {
			11203400
		}
	},
	[200842] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_37.png",
		LikeId = 10842,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200842,
		BigIcon = "/EquipLarge/Icon_EquipLarge_37.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017993),
		Source = {
			11203400
		}
	},
	[200843] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_38.png",
		LikeId = 10843,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200843,
		BigIcon = "/EquipLarge/Icon_EquipLarge_38.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017994),
		Source = {
			11203400
		}
	},
	[200844] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_39.png",
		LikeId = 10844,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200844,
		BigIcon = "/EquipLarge/Icon_EquipLarge_39.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180017995),
		Source = {
			11203400
		}
	},
	[200851] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 10851,
		Reveal = true,
		Part = 1,
		Isdestroyed = true,
		Id = 200851,
		BigIcon = "/EquipLarge/Icon_EquipLarge_36.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180017997),
		Source = {
			11203400
		}
	},
	[200852] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_37.png",
		LikeId = 10852,
		Reveal = true,
		Part = 2,
		Isdestroyed = true,
		Id = 200852,
		BigIcon = "/EquipLarge/Icon_EquipLarge_37.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180017998),
		Source = {
			11203400
		}
	},
	[200853] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_38.png",
		LikeId = 10853,
		Reveal = true,
		Part = 3,
		Isdestroyed = true,
		Id = 200853,
		BigIcon = "/EquipLarge/Icon_EquipLarge_38.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180017999),
		Source = {
			11203400
		}
	},
	[200854] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_39.png",
		LikeId = 10854,
		Reveal = true,
		Part = 4,
		Isdestroyed = true,
		Id = 200854,
		BigIcon = "/EquipLarge/Icon_EquipLarge_39.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180018000),
		Source = {
			11203400
		}
	},
	[200911] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 10911,
		Reveal = true,
		Part = 1,
		Id = 200911,
		BigIcon = "/EquipLarge/Icon_EquipLarge_41.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180018007)
	},
	[200912] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_42.png",
		LikeId = 10912,
		Reveal = true,
		Part = 2,
		Id = 200912,
		BigIcon = "/EquipLarge/Icon_EquipLarge_42.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180018008)
	},
	[200913] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_43.png",
		LikeId = 10913,
		Reveal = true,
		Part = 3,
		Id = 200913,
		BigIcon = "/EquipLarge/Icon_EquipLarge_43.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180018009)
	},
	[200914] = {
		ItemTypes = 3,
		Quality = 1,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_44.png",
		LikeId = 10914,
		Reveal = true,
		Part = 4,
		Id = 200914,
		BigIcon = "/EquipLarge/Icon_EquipLarge_44.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180018010)
	},
	[200921] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 10921,
		Reveal = true,
		Part = 1,
		Id = 200921,
		BigIcon = "/EquipLarge/Icon_EquipLarge_41.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180018012)
	},
	[200922] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_42.png",
		LikeId = 10922,
		Reveal = true,
		Part = 2,
		Id = 200922,
		BigIcon = "/EquipLarge/Icon_EquipLarge_42.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180018013)
	},
	[200923] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_43.png",
		LikeId = 10923,
		Reveal = true,
		Part = 3,
		Id = 200923,
		BigIcon = "/EquipLarge/Icon_EquipLarge_43.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180018014)
	},
	[200924] = {
		ItemTypes = 3,
		Quality = 2,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_44.png",
		LikeId = 10924,
		Reveal = true,
		Part = 4,
		Id = 200924,
		BigIcon = "/EquipLarge/Icon_EquipLarge_44.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180018015)
	},
	[200931] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 10931,
		Reveal = true,
		Part = 1,
		Id = 200931,
		BigIcon = "/EquipLarge/Icon_EquipLarge_41.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180018017)
	},
	[200932] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_42.png",
		LikeId = 10932,
		Reveal = true,
		Part = 2,
		Id = 200932,
		BigIcon = "/EquipLarge/Icon_EquipLarge_42.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180018018)
	},
	[200933] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_43.png",
		LikeId = 10933,
		Reveal = true,
		Part = 3,
		Id = 200933,
		BigIcon = "/EquipLarge/Icon_EquipLarge_43.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180018019)
	},
	[200934] = {
		ItemTypes = 3,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_44.png",
		LikeId = 10934,
		Reveal = true,
		Part = 4,
		Id = 200934,
		BigIcon = "/EquipLarge/Icon_EquipLarge_44.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180018020)
	},
	[200941] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 10941,
		Reveal = true,
		Part = 1,
		Id = 200941,
		BigIcon = "/EquipLarge/Icon_EquipLarge_41.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180018022)
	},
	[200942] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_42.png",
		LikeId = 10942,
		Reveal = true,
		Part = 2,
		Id = 200942,
		BigIcon = "/EquipLarge/Icon_EquipLarge_42.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180018023)
	},
	[200943] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_43.png",
		LikeId = 10943,
		Reveal = true,
		Part = 3,
		Id = 200943,
		BigIcon = "/EquipLarge/Icon_EquipLarge_43.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180018024)
	},
	[200944] = {
		ItemTypes = 3,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_44.png",
		LikeId = 10944,
		Reveal = true,
		Part = 4,
		Id = 200944,
		BigIcon = "/EquipLarge/Icon_EquipLarge_44.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180018025)
	},
	[200951] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 10951,
		Reveal = true,
		Part = 1,
		Id = 200951,
		BigIcon = "/EquipLarge/Icon_EquipLarge_41.png",
		ItemSubTypes = 1,
		DepotType = 3,
		Name = getI18NValue(180018027)
	},
	[200952] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_42.png",
		LikeId = 10952,
		Reveal = true,
		Part = 2,
		Id = 200952,
		BigIcon = "/EquipLarge/Icon_EquipLarge_42.png",
		ItemSubTypes = 2,
		DepotType = 3,
		Name = getI18NValue(180018028)
	},
	[200953] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_43.png",
		LikeId = 10953,
		Reveal = true,
		Part = 3,
		Id = 200953,
		BigIcon = "/EquipLarge/Icon_EquipLarge_43.png",
		ItemSubTypes = 3,
		DepotType = 3,
		Name = getI18NValue(180018029)
	},
	[200954] = {
		ItemTypes = 3,
		Quality = 5,
		MaxNum = 1,
		OverMode = 1,
		Isdestroyed = true,
		Icon = "/Equip/Icon_Item_Equip_44.png",
		LikeId = 10954,
		Reveal = true,
		Part = 4,
		Id = 200954,
		BigIcon = "/EquipLarge/Icon_EquipLarge_44.png",
		ItemSubTypes = 4,
		DepotType = 3,
		Name = getI18NValue(180018030)
	},
	[300101] = {
		Id = 300101,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180173004),
		ItemTips = getI18NValue(180173003)
	},
	[300102] = {
		Id = 300102,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_Item_SummerActivity_02.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Item_SummerActivity_02.png",
		Name = getI18NValue(180173006),
		ItemTips = getI18NValue(180173005)
	},
	[300103] = {
		Id = 300103,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_Item_SummerActivity_03.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Item_SummerActivity_03.png",
		Name = getI18NValue(180173008),
		ItemTips = getI18NValue(180173007)
	},
	[300104] = {
		Id = 300104,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_Item_SummerActivity_04.png",
		Reveal = true,
		BigIcon = "/Item/Icon_Item_SummerActivity_04.png",
		Name = getI18NValue(180173010),
		ItemTips = getI18NValue(180173009)
	},
	[400001] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400001,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018046),
		ItemTips = getI18NValue(180018045),
		ActionParams = {
			1201100,
			1
		}
	},
	[400002] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400002,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018048),
		ItemTips = getI18NValue(180018047),
		ActionParams = {
			1201110,
			1
		}
	},
	[400003] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400003,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018050),
		ItemTips = getI18NValue(180018049),
		ActionParams = {
			1201120,
			1
		}
	},
	[400004] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400004,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018052),
		ItemTips = getI18NValue(180018051),
		ActionParams = {
			1201200,
			1
		}
	},
	[400005] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400005,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018054),
		ItemTips = getI18NValue(180018053),
		ActionParams = {
			1201210,
			1
		}
	},
	[400006] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400006,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018056),
		ItemTips = getI18NValue(180018055),
		ActionParams = {
			1201220,
			1
		}
	},
	[400007] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400007,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018058),
		ItemTips = getI18NValue(180018057),
		ActionParams = {
			1201300,
			1
		}
	},
	[400008] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400008,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018060),
		ItemTips = getI18NValue(180018059),
		ActionParams = {
			1201310,
			1
		}
	},
	[400009] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400009,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018062),
		ItemTips = getI18NValue(180018061),
		ActionParams = {
			1201400,
			1
		}
	},
	[400010] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400010,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018064),
		ItemTips = getI18NValue(180018063),
		ActionParams = {
			1201410,
			1
		}
	},
	[400011] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400011,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018066),
		ItemTips = getI18NValue(180018065),
		ActionParams = {
			1201420,
			1
		}
	},
	[400012] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400012,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180018068),
		ItemTips = getI18NValue(180018067),
		ActionParams = {
			1101100,
			1
		}
	},
	[400013] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400013,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197501),
		ItemTips = getI18NValue(180197500),
		ActionParams = {
			1101110,
			1
		}
	},
	[400014] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400014,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197503),
		ItemTips = getI18NValue(180197502),
		ActionParams = {
			1101120,
			1
		}
	},
	[400015] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400015,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197505),
		ItemTips = getI18NValue(180197504),
		ActionParams = {
			1101200,
			1
		}
	},
	[400016] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400016,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197507),
		ItemTips = getI18NValue(180197506),
		ActionParams = {
			1101210,
			1
		}
	},
	[400017] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400017,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197509),
		ItemTips = getI18NValue(180197508),
		ActionParams = {
			1101220,
			1
		}
	},
	[400018] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400018,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197511),
		ItemTips = getI18NValue(180197510),
		ActionParams = {
			1101300,
			1
		}
	},
	[400019] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400019,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197513),
		ItemTips = getI18NValue(180197512),
		ActionParams = {
			1101310,
			1
		}
	},
	[400020] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400020,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197515),
		ItemTips = getI18NValue(180197514),
		ActionParams = {
			1101400,
			1
		}
	},
	[400021] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400021,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197517),
		ItemTips = getI18NValue(180197516),
		ActionParams = {
			1101410,
			1
		}
	},
	[400022] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400022,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197519),
		ItemTips = getI18NValue(180197518),
		ActionParams = {
			1101420,
			1
		}
	},
	[400023] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400023,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197521),
		ItemTips = getI18NValue(180197520),
		ActionParams = {
			1102100,
			1
		}
	},
	[400024] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400024,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197523),
		ItemTips = getI18NValue(180197522),
		ActionParams = {
			1102110,
			1
		}
	},
	[400025] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400025,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197525),
		ItemTips = getI18NValue(180197524),
		ActionParams = {
			1102120,
			1
		}
	},
	[400026] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400026,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197527),
		ItemTips = getI18NValue(180197526),
		ActionParams = {
			1102200,
			1
		}
	},
	[400027] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400027,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197529),
		ItemTips = getI18NValue(180197528),
		ActionParams = {
			1102210,
			1
		}
	},
	[400028] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400028,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197531),
		ItemTips = getI18NValue(180197530),
		ActionParams = {
			1102220,
			1
		}
	},
	[400029] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400029,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197533),
		ItemTips = getI18NValue(180197532),
		ActionParams = {
			1102300,
			1
		}
	},
	[400030] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400030,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197535),
		ItemTips = getI18NValue(180197534),
		ActionParams = {
			1102310,
			1
		}
	},
	[400031] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400031,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197537),
		ItemTips = getI18NValue(180197536),
		ActionParams = {
			1102400,
			1
		}
	},
	[400032] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400032,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180197539),
		ItemTips = getI18NValue(180197538),
		ActionParams = {
			1102410,
			1
		}
	},
	[400033] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400033,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180201975),
		ItemTips = getI18NValue(180201974),
		ActionParams = {
			1102420,
			1
		}
	},
	[400034] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400034,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180201977),
		ItemTips = getI18NValue(180201976),
		ActionParams = {
			1103100,
			1
		}
	},
	[400035] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400035,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180201979),
		ItemTips = getI18NValue(180201978),
		ActionParams = {
			1103110,
			1
		}
	},
	[400036] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400036,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180201981),
		ItemTips = getI18NValue(180201980),
		ActionParams = {
			1103120,
			1
		}
	},
	[400037] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400037,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180201983),
		ItemTips = getI18NValue(180201982),
		ActionParams = {
			1103200,
			1
		}
	},
	[400038] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400038,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180201985),
		ItemTips = getI18NValue(180201984),
		ActionParams = {
			1103210,
			1
		}
	},
	[400039] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400039,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212630),
		ItemTips = getI18NValue(180212859),
		ActionParams = {
			1103220,
			1
		}
	},
	[400040] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400040,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212631),
		ItemTips = getI18NValue(180212860),
		ActionParams = {
			1103300,
			1
		}
	},
	[400041] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400041,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212632),
		ItemTips = getI18NValue(180212861),
		ActionParams = {
			1103310,
			1
		}
	},
	[400042] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400042,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212633),
		ItemTips = getI18NValue(180212862),
		ActionParams = {
			1103400,
			1
		}
	},
	[400043] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400043,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212634),
		ItemTips = getI18NValue(180212863),
		ActionParams = {
			1103410,
			1
		}
	},
	[400044] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400044,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212635),
		ItemTips = getI18NValue(180212864),
		ActionParams = {
			1103420,
			1
		}
	},
	[400045] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400045,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212636),
		ItemTips = getI18NValue(180212865),
		ActionParams = {
			8001001,
			1
		}
	},
	[400046] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400046,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212867),
		ItemTips = getI18NValue(180212866),
		ActionParams = {
			8001002,
			1
		}
	},
	[400047] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400047,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212638),
		ItemTips = getI18NValue(180212868),
		ActionParams = {
			8001003,
			1
		}
	},
	[400048] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400048,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212639),
		ItemTips = getI18NValue(180212869),
		ActionParams = {
			8001004,
			1
		}
	},
	[400049] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400049,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212640),
		ItemTips = getI18NValue(180212870),
		ActionParams = {
			8001005,
			1
		}
	},
	[400050] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400050,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212641),
		ItemTips = getI18NValue(180212871),
		ActionParams = {
			8001006,
			1
		}
	},
	[400051] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400051,
		Name = getI18NValue(180212642),
		ActionParams = {
			8001201,
			1
		}
	},
	[400052] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400052,
		Name = getI18NValue(180212643),
		ActionParams = {
			8001202,
			1
		}
	},
	[400053] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400053,
		Name = getI18NValue(180212644),
		ActionParams = {
			8001203,
			1
		}
	},
	[400054] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400054,
		Name = getI18NValue(180212645),
		ActionParams = {
			8001301,
			1
		}
	},
	[400055] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400055,
		Name = getI18NValue(180212646),
		ActionParams = {
			8001302,
			1
		}
	},
	[400056] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400056,
		Name = getI18NValue(180212647),
		ActionParams = {
			8001501,
			1
		}
	},
	[400057] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Attribute/Maze_Buff_02.png",
		UseType = 1,
		Id = 400057,
		Name = getI18NValue(180212648),
		ActionParams = {
			8001502,
			1
		}
	},
	[400058] = {
		Id = 400058
	},
	[400059] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400059,
		Name = getI18NValue(180212683),
		ActionParams = {
			1602,
			1
		}
	},
	[400060] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400060,
		Name = getI18NValue(180212684),
		ActionParams = {
			1603,
			1
		}
	},
	[400061] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400061,
		Name = getI18NValue(180212685),
		ActionParams = {
			1604,
			1
		}
	},
	[400062] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400062,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212686),
		ItemTips = getI18NValue(180221134),
		ActionParams = {
			8000001,
			1
		}
	},
	[400063] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400063,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212687),
		ItemTips = getI18NValue(180221135),
		ActionParams = {
			8000002,
			1
		}
	},
	[400064] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400064,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180212688),
		ItemTips = getI18NValue(180221136),
		ActionParams = {
			8000003,
			1
		}
	},
	[400065] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400065,
		Name = getI18NValue(180212689),
		ActionParams = {
			8000042,
			1
		}
	},
	[400066] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400066,
		Name = getI18NValue(180212872),
		ActionParams = {
			8000043,
			1
		}
	},
	[400067] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400067,
		Name = getI18NValue(180212873),
		ActionParams = {
			8000044,
			1
		}
	},
	[400068] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400068,
		Name = getI18NValue(180212874),
		ActionParams = {
			8000045,
			1
		}
	},
	[400069] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400069,
		Name = getI18NValue(180212875),
		ActionParams = {
			8000046,
			1
		}
	},
	[400070] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400070,
		Name = getI18NValue(180212876),
		ActionParams = {
			8000047,
			1
		}
	},
	[400071] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400071,
		Name = getI18NValue(180212877),
		ActionParams = {
			8000048,
			1
		}
	},
	[400072] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400072,
		Name = getI18NValue(180212878),
		ActionParams = {
			8000049,
			1
		}
	},
	[400073] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400073,
		Name = getI18NValue(180212879),
		ActionParams = {
			8000050,
			1
		}
	},
	[400074] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400074,
		Name = getI18NValue(180212880),
		ActionParams = {
			8000051,
			1
		}
	},
	[400075] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400075,
		Name = getI18NValue(180212881),
		ActionParams = {
			8000052,
			1
		}
	},
	[400076] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400076,
		Name = getI18NValue(180212882),
		ActionParams = {
			8000053,
			1
		}
	},
	[400077] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400077,
		Name = getI18NValue(180212883),
		ActionParams = {
			8000054,
			1
		}
	},
	[400078] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400078,
		Name = getI18NValue(180213199),
		ActionParams = {
			103300,
			1
		}
	},
	[400079] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		UseType = 1,
		Id = 400079,
		Name = getI18NValue(180213326),
		ActionParams = {
			9301,
			1
		}
	},
	[400080] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400080,
		Name = getI18NValue(180213327),
		ActionParams = {
			101100,
			1
		}
	},
	[400081] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400081,
		Name = getI18NValue(180213328),
		ActionParams = {
			101200,
			1
		}
	},
	[400082] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400082,
		Name = getI18NValue(180213329),
		ActionParams = {
			101300,
			1
		}
	},
	[400083] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_01.png",
		UseType = 1,
		Id = 400083,
		Name = getI18NValue(180213330),
		ActionParams = {
			102100,
			1
		}
	},
	[400084] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_01.png",
		UseType = 1,
		Id = 400084,
		Name = getI18NValue(180213331),
		ActionParams = {
			102200,
			1
		}
	},
	[400085] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_01.png",
		UseType = 1,
		Id = 400085,
		Name = getI18NValue(180213332),
		ActionParams = {
			102300,
			1
		}
	},
	[400086] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_03.png",
		UseType = 1,
		Id = 400086,
		Name = getI18NValue(180213333),
		ActionParams = {
			103100,
			1
		}
	},
	[400087] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_03.png",
		UseType = 1,
		Id = 400087,
		Name = getI18NValue(180213334),
		ActionParams = {
			103200,
			1
		}
	},
	[400088] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_03.png",
		UseType = 1,
		Id = 400088,
		Name = getI18NValue(180213335),
		ActionParams = {
			103300,
			1
		}
	},
	[400089] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400089,
		Name = getI18NValue(180213336),
		ActionParams = {
			104100,
			1
		}
	},
	[400090] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400090,
		Name = getI18NValue(180213337),
		ActionParams = {
			104200,
			1
		}
	},
	[400091] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400091,
		Name = getI18NValue(180213338),
		ActionParams = {
			104300,
			1
		}
	},
	[400092] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400092,
		Name = getI18NValue(180213339),
		ActionParams = {
			105100,
			1
		}
	},
	[400093] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400093,
		Name = getI18NValue(180213340),
		ActionParams = {
			105200,
			1
		}
	},
	[400094] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400094,
		Name = getI18NValue(180213341),
		ActionParams = {
			105300,
			1
		}
	},
	[400095] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_01.png",
		UseType = 1,
		Id = 400095,
		Name = getI18NValue(180213342),
		ActionParams = {
			106100,
			1
		}
	},
	[400096] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_01.png",
		UseType = 1,
		Id = 400096,
		Name = getI18NValue(180216614),
		ActionParams = {
			106200,
			1
		}
	},
	[400097] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_01.png",
		UseType = 1,
		Id = 400097,
		Name = getI18NValue(180216615),
		ActionParams = {
			106300,
			1
		}
	},
	[400098] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400098,
		Name = getI18NValue(180216616),
		ActionParams = {
			107100,
			1
		}
	},
	[400099] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400099,
		Name = getI18NValue(180216617),
		ActionParams = {
			107200,
			1
		}
	},
	[400100] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Labyrinth/TalentIcon/Maze_Talent_02.png",
		UseType = 1,
		Id = 400100,
		Name = getI18NValue(180216618),
		ActionParams = {
			107300,
			1
		}
	},
	[400101] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400101,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180217286),
		ItemTips = getI18NValue(180220896),
		ActionParams = {
			100300,
			1
		}
	},
	[400102] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400102,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180217287),
		ItemTips = getI18NValue(180220897),
		ActionParams = {
			100310,
			1
		}
	},
	[400103] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400103,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180217288),
		ItemTips = getI18NValue(180220898),
		ActionParams = {
			100320,
			1
		}
	},
	[400104] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400104,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180217289),
		ItemTips = getI18NValue(180220899),
		ActionParams = {
			100330,
			1
		}
	},
	[400105] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400105,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180217290),
		ItemTips = getI18NValue(180220900),
		ActionParams = {
			100340,
			1
		}
	},
	[400106] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400106,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218255),
		ItemTips = getI18NValue(180218254),
		ActionParams = {
			1310000,
			1
		}
	},
	[400107] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400107,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218257),
		ItemTips = getI18NValue(180218256),
		ActionParams = {
			1310010,
			1
		}
	},
	[400108] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400108,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218259),
		ItemTips = getI18NValue(180218258),
		ActionParams = {
			1310020,
			1
		}
	},
	[400109] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400109,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218261),
		ItemTips = getI18NValue(180218260),
		ActionParams = {
			1310030,
			1
		}
	},
	[400110] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400110,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218263),
		ItemTips = getI18NValue(180218262),
		ActionParams = {
			1310040,
			1
		}
	},
	[400111] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400111,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218265),
		ItemTips = getI18NValue(180218264),
		ActionParams = {
			1310050,
			1
		}
	},
	[400112] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400112,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218267),
		ItemTips = getI18NValue(180218266),
		ActionParams = {
			1310060,
			1
		}
	},
	[400113] = {
		UserAction = 34,
		Quality = 3,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400113,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218269),
		ItemTips = getI18NValue(180218268),
		ActionParams = {
			1310070,
			1
		}
	},
	[400114] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400114,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218271),
		ItemTips = getI18NValue(180218270),
		ActionParams = {
			1320000,
			1
		}
	},
	[400115] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400115,
		Icon = "/Attribute/Maze_Buff_01.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218273),
		ItemTips = getI18NValue(180218272),
		ActionParams = {
			1320010,
			1
		}
	},
	[400116] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400116,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218275),
		ItemTips = getI18NValue(180218274),
		ActionParams = {
			1320020,
			1
		}
	},
	[400117] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400117,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218277),
		ItemTips = getI18NValue(180218276),
		ActionParams = {
			1320030,
			1
		}
	},
	[400118] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400118,
		Icon = "/Attribute/Maze_Buff_03.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218279),
		ItemTips = getI18NValue(180218278),
		ActionParams = {
			1320040,
			1
		}
	},
	[400119] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400119,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218281),
		ItemTips = getI18NValue(180218280),
		ActionParams = {
			1320050,
			1
		}
	},
	[400120] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400120,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218283),
		ItemTips = getI18NValue(180218282),
		ActionParams = {
			1330000,
			1
		}
	},
	[400121] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400121,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218285),
		ItemTips = getI18NValue(180218284),
		ActionParams = {
			1330010,
			1
		}
	},
	[400122] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400122,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218287),
		ItemTips = getI18NValue(180218286),
		ActionParams = {
			1330020,
			1
		}
	},
	[400123] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400123,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180218289),
		ItemTips = getI18NValue(180218288),
		ActionParams = {
			1330030,
			1
		}
	},
	[400124] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400124,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241604),
		ItemTips = getI18NValue(180241603),
		ActionParams = {
			1202100,
			1
		}
	},
	[400125] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400125,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241606),
		ItemTips = getI18NValue(180241605),
		ActionParams = {
			1202110,
			1
		}
	},
	[400126] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400126,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241608),
		ItemTips = getI18NValue(180241607),
		ActionParams = {
			1202120,
			1
		}
	},
	[400127] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400127,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241610),
		ItemTips = getI18NValue(180241609),
		ActionParams = {
			1202200,
			1
		}
	},
	[400128] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400128,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241612),
		ItemTips = getI18NValue(180241611),
		ActionParams = {
			1202210,
			1
		}
	},
	[400129] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400129,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241614),
		ItemTips = getI18NValue(180241613),
		ActionParams = {
			1202220,
			1
		}
	},
	[400130] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400130,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241616),
		ItemTips = getI18NValue(180241615),
		ActionParams = {
			1202300,
			1
		}
	},
	[400131] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400131,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241618),
		ItemTips = getI18NValue(180241617),
		ActionParams = {
			1202310,
			1
		}
	},
	[400132] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400132,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241620),
		ItemTips = getI18NValue(180241619),
		ActionParams = {
			1202400,
			1
		}
	},
	[400133] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400133,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241622),
		ItemTips = getI18NValue(180241621),
		ActionParams = {
			1202410,
			1
		}
	},
	[400134] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400134,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241624),
		ItemTips = getI18NValue(180241623),
		ActionParams = {
			1202420,
			1
		}
	},
	[400135] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400135,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241626),
		ItemTips = getI18NValue(180241625),
		ActionParams = {
			1203100,
			1
		}
	},
	[400136] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400136,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241628),
		ItemTips = getI18NValue(180241627),
		ActionParams = {
			1203110,
			1
		}
	},
	[400137] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400137,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241630),
		ItemTips = getI18NValue(180241629),
		ActionParams = {
			1203120,
			1
		}
	},
	[400138] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400138,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241632),
		ItemTips = getI18NValue(180241631),
		ActionParams = {
			1203200,
			1
		}
	},
	[400139] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400139,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241634),
		ItemTips = getI18NValue(180241633),
		ActionParams = {
			1203210,
			1
		}
	},
	[400140] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400140,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241636),
		ItemTips = getI18NValue(180241635),
		ActionParams = {
			1203220,
			1
		}
	},
	[400141] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400141,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241638),
		ItemTips = getI18NValue(180241637),
		ActionParams = {
			1203300,
			1
		}
	},
	[400142] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400142,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241640),
		ItemTips = getI18NValue(180241639),
		ActionParams = {
			1203310,
			1
		}
	},
	[400143] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400143,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241642),
		ItemTips = getI18NValue(180241641),
		ActionParams = {
			1203400,
			1
		}
	},
	[400144] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400144,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241644),
		ItemTips = getI18NValue(180241643),
		ActionParams = {
			1203410,
			1
		}
	},
	[400145] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400145,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180241646),
		ItemTips = getI18NValue(180241645),
		ActionParams = {
			1203420,
			1
		}
	},
	[400201] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400201,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220473),
		ItemTips = getI18NValue(180220472),
		ActionParams = {
			1410000,
			1
		}
	},
	[400202] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400202,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220475),
		ItemTips = getI18NValue(180220474),
		ActionParams = {
			1410010,
			1
		}
	},
	[400203] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400203,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220477),
		ItemTips = getI18NValue(180220476),
		ActionParams = {
			1410020,
			1
		}
	},
	[400204] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400204,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220479),
		ItemTips = getI18NValue(180220478),
		ActionParams = {
			1410030,
			1
		}
	},
	[400205] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400205,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220481),
		ItemTips = getI18NValue(180220480),
		ActionParams = {
			1410040,
			1
		}
	},
	[400206] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400206,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220483),
		ItemTips = getI18NValue(180220482),
		ActionParams = {
			1410050,
			1
		}
	},
	[400207] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400207,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220485),
		ItemTips = getI18NValue(180220484),
		ActionParams = {
			1410060,
			1
		}
	},
	[400208] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400208,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220487),
		ItemTips = getI18NValue(180220486),
		ActionParams = {
			1410070,
			1
		}
	},
	[400209] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400209,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220489),
		ItemTips = getI18NValue(180220488),
		ActionParams = {
			1410080,
			1
		}
	},
	[400210] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400210,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220491),
		ItemTips = getI18NValue(180220490),
		ActionParams = {
			1410090,
			1
		}
	},
	[400211] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400211,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220493),
		ItemTips = getI18NValue(180220492),
		ActionParams = {
			1410100,
			1
		}
	},
	[400212] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400212,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220495),
		ItemTips = getI18NValue(180220494),
		ActionParams = {
			1410110,
			1
		}
	},
	[400213] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400213,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220497),
		ItemTips = getI18NValue(180220496),
		ActionParams = {
			1410120,
			1
		}
	},
	[400214] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400214,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220499),
		ItemTips = getI18NValue(180220498),
		ActionParams = {
			1410130,
			1
		}
	},
	[400215] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400215,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220501),
		ItemTips = getI18NValue(180220500),
		ActionParams = {
			1410140,
			1
		}
	},
	[400216] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400216,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220503),
		ItemTips = getI18NValue(180220502),
		ActionParams = {
			1410150,
			1
		}
	},
	[400217] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400217,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220505),
		ItemTips = getI18NValue(180220504),
		ActionParams = {
			1410160,
			1
		}
	},
	[400218] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400218,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220507),
		ItemTips = getI18NValue(180220506),
		ActionParams = {
			1410170,
			1
		}
	},
	[400219] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400219,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220509),
		ItemTips = getI18NValue(180220508),
		ActionParams = {
			1410180,
			1
		}
	},
	[400220] = {
		UserAction = 34,
		Quality = 4,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400220,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220511),
		ItemTips = getI18NValue(180220510),
		ActionParams = {
			1410190,
			1
		}
	},
	[400300] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400300,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220513),
		ItemTips = getI18NValue(180220512),
		ActionParams = {
			1410200,
			1
		}
	},
	[400301] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400301,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220515),
		ItemTips = getI18NValue(180220514),
		ActionParams = {
			1410210,
			1
		}
	},
	[400302] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400302,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220517),
		ItemTips = getI18NValue(180220516),
		ActionParams = {
			1410220,
			1
		}
	},
	[400303] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400303,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220519),
		ItemTips = getI18NValue(180220518),
		ActionParams = {
			1410230,
			1
		}
	},
	[400304] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400304,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220521),
		ItemTips = getI18NValue(180220520),
		ActionParams = {
			1410240,
			1
		}
	},
	[400305] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400305,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220523),
		ItemTips = getI18NValue(180220522),
		ActionParams = {
			1410250,
			1
		}
	},
	[400306] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400306,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220525),
		ItemTips = getI18NValue(180220524),
		ActionParams = {
			1410260,
			1
		}
	},
	[400307] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400307,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220527),
		ItemTips = getI18NValue(180220526),
		ActionParams = {
			1410270,
			1
		}
	},
	[400308] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400308,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220529),
		ItemTips = getI18NValue(180220528),
		ActionParams = {
			1410280,
			1
		}
	},
	[400309] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400309,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220531),
		ItemTips = getI18NValue(180220530),
		ActionParams = {
			1410290,
			1
		}
	},
	[400310] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400310,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220533),
		ItemTips = getI18NValue(180220532),
		ActionParams = {
			1410300,
			1
		}
	},
	[400311] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400311,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220535),
		ItemTips = getI18NValue(180220534),
		ActionParams = {
			1410310,
			1
		}
	},
	[400312] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400312,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220537),
		ItemTips = getI18NValue(180220536),
		ActionParams = {
			1410320,
			1
		}
	},
	[400313] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400313,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220539),
		ItemTips = getI18NValue(180220538),
		ActionParams = {
			1410330,
			1
		}
	},
	[400314] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400314,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220541),
		ItemTips = getI18NValue(180220540),
		ActionParams = {
			1410340,
			1
		}
	},
	[400315] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400315,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220543),
		ItemTips = getI18NValue(180220542),
		ActionParams = {
			1410350,
			1
		}
	},
	[400316] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400316,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220545),
		ItemTips = getI18NValue(180220544),
		ActionParams = {
			1410360,
			1
		}
	},
	[400317] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400317,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220547),
		ItemTips = getI18NValue(180220546),
		ActionParams = {
			1410370,
			1
		}
	},
	[400318] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400318,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220549),
		ItemTips = getI18NValue(180220548),
		ActionParams = {
			1410380,
			1
		}
	},
	[400319] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400319,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220551),
		ItemTips = getI18NValue(180220550),
		ActionParams = {
			1410390,
			1
		}
	},
	[400320] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400320,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220553),
		ItemTips = getI18NValue(180220552),
		ActionParams = {
			1410400,
			1
		}
	},
	[400321] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400321,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220555),
		ItemTips = getI18NValue(180220554),
		ActionParams = {
			1410410,
			1
		}
	},
	[400322] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400322,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220557),
		ItemTips = getI18NValue(180220556),
		ActionParams = {
			1410420,
			1
		}
	},
	[400323] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400323,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220559),
		ItemTips = getI18NValue(180220558),
		ActionParams = {
			1410430,
			1
		}
	},
	[400324] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400324,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220561),
		ItemTips = getI18NValue(180220560),
		ActionParams = {
			1410440,
			1
		}
	},
	[400325] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400325,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220563),
		ItemTips = getI18NValue(180220562),
		ActionParams = {
			1410450,
			1
		}
	},
	[400326] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400326,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220565),
		ItemTips = getI18NValue(180220564),
		ActionParams = {
			1410460,
			1
		}
	},
	[400327] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400327,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220567),
		ItemTips = getI18NValue(180220566),
		ActionParams = {
			1410470,
			1
		}
	},
	[400328] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400328,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220569),
		ItemTips = getI18NValue(180220568),
		ActionParams = {
			1410480,
			1
		}
	},
	[400329] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400329,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220571),
		ItemTips = getI18NValue(180220570),
		ActionParams = {
			1410490,
			1
		}
	},
	[400330] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400330,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220573),
		ItemTips = getI18NValue(180220572),
		ActionParams = {
			1410500,
			1
		}
	},
	[400331] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400331,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220575),
		ItemTips = getI18NValue(180220574),
		ActionParams = {
			1410510,
			1
		}
	},
	[400332] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400332,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220577),
		ItemTips = getI18NValue(180220576),
		ActionParams = {
			1410520,
			1
		}
	},
	[400333] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400333,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220579),
		ItemTips = getI18NValue(180220578),
		ActionParams = {
			1410530,
			1
		}
	},
	[400334] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400334,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220581),
		ItemTips = getI18NValue(180220580),
		ActionParams = {
			1410540,
			1
		}
	},
	[400335] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400335,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220583),
		ItemTips = getI18NValue(180220582),
		ActionParams = {
			1410550,
			1
		}
	},
	[400336] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400336,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220585),
		ItemTips = getI18NValue(180220584),
		ActionParams = {
			1410560,
			1
		}
	},
	[400337] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400337,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220587),
		ItemTips = getI18NValue(180220586),
		ActionParams = {
			1410570,
			1
		}
	},
	[400338] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400338,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220589),
		ItemTips = getI18NValue(180220588),
		ActionParams = {
			1410580,
			1
		}
	},
	[400339] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400339,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220591),
		ItemTips = getI18NValue(180220590),
		ActionParams = {
			1410590,
			1
		}
	},
	[400340] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400340,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220593),
		ItemTips = getI18NValue(180220592),
		ActionParams = {
			1410600,
			1
		}
	},
	[400341] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400341,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220595),
		ItemTips = getI18NValue(180220594),
		ActionParams = {
			1410610,
			1
		}
	},
	[400342] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400342,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220597),
		ItemTips = getI18NValue(180220596),
		ActionParams = {
			1410620,
			1
		}
	},
	[400343] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400343,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220599),
		ItemTips = getI18NValue(180220598),
		ActionParams = {
			1410630,
			1
		}
	},
	[400344] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400344,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220601),
		ItemTips = getI18NValue(180220600),
		ActionParams = {
			1410640,
			1
		}
	},
	[400345] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400345,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220603),
		ItemTips = getI18NValue(180220602),
		ActionParams = {
			1410650,
			1
		}
	},
	[400346] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400346,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220605),
		ItemTips = getI18NValue(180220604),
		ActionParams = {
			1410660,
			1
		}
	},
	[400347] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400347,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220607),
		ItemTips = getI18NValue(180220606),
		ActionParams = {
			1410670,
			1
		}
	},
	[400348] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400348,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220609),
		ItemTips = getI18NValue(180220608),
		ActionParams = {
			1410680,
			1
		}
	},
	[400349] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400349,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220611),
		ItemTips = getI18NValue(180220610),
		ActionParams = {
			1410690,
			1
		}
	},
	[400350] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400350,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220613),
		ItemTips = getI18NValue(180220612),
		ActionParams = {
			1410700,
			1
		}
	},
	[400351] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400351,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220615),
		ItemTips = getI18NValue(180220614),
		ActionParams = {
			1410710,
			1
		}
	},
	[400352] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400352,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220617),
		ItemTips = getI18NValue(180220616),
		ActionParams = {
			1410720,
			1
		}
	},
	[400353] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400353,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220619),
		ItemTips = getI18NValue(180220618),
		ActionParams = {
			1410730,
			1
		}
	},
	[400354] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400354,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220621),
		ItemTips = getI18NValue(180220620),
		ActionParams = {
			1410740,
			1
		}
	},
	[400355] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400355,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220623),
		ItemTips = getI18NValue(180220622),
		ActionParams = {
			1410750,
			1
		}
	},
	[400356] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400356,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220625),
		ItemTips = getI18NValue(180220624),
		ActionParams = {
			1410760,
			1
		}
	},
	[400357] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400357,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220627),
		ItemTips = getI18NValue(180220626),
		ActionParams = {
			1410770,
			1
		}
	},
	[400358] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400358,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220629),
		ItemTips = getI18NValue(180220628),
		ActionParams = {
			1410780,
			1
		}
	},
	[400359] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400359,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220631),
		ItemTips = getI18NValue(180220630),
		ActionParams = {
			1410790,
			1
		}
	},
	[400360] = {
		UserAction = 34,
		Quality = 5,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 400360,
		Icon = "/Attribute/Maze_Buff_02.png",
		MaxNum = 1,
		UseType = 1,
		Name = getI18NValue(180220633),
		ItemTips = getI18NValue(180220632),
		ActionParams = {
			1410800,
			1
		}
	},
	[401001] = {
		Id = 401001,
		BigIcon = "/Item/Icon_Item_MazeCollection_01_001.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_MazeCollection_01_001.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180120258),
		ItemTips = getI18NValue(180120257)
	},
	[401002] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401002,
		Icon = "/Item/Icon_Item_MazeCollection_01_002.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_002.png",
		Name = getI18NValue(180120260),
		ItemTips = getI18NValue(180120259)
	},
	[401003] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401003,
		Icon = "/Item/Icon_Item_MazeCollection_01_003.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_003.png",
		Name = getI18NValue(180120262),
		ItemTips = getI18NValue(180120261)
	},
	[401004] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401004,
		Icon = "/Item/Icon_Item_MazeCollection_01_004.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_004.png",
		Name = getI18NValue(180120264),
		ItemTips = getI18NValue(180120263)
	},
	[401005] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401005,
		Icon = "/Item/Icon_Item_MazeCollection_01_005.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_005.png",
		Name = getI18NValue(180120266),
		ItemTips = getI18NValue(180120265)
	},
	[401006] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401006,
		Icon = "/Item/Icon_Item_MazeCollection_01_006.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_006.png",
		Name = getI18NValue(180120268),
		ItemTips = getI18NValue(180120267)
	},
	[401007] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401007,
		Icon = "/Item/Icon_Item_MazeCollection_01_007.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_007.png",
		Name = getI18NValue(180120270),
		ItemTips = getI18NValue(180120269)
	},
	[401008] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401008,
		Icon = "/Item/Icon_Item_MazeCollection_01_008.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_008.png",
		Name = getI18NValue(180120272),
		ItemTips = getI18NValue(180120271)
	},
	[401009] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401009,
		Icon = "/Item/Icon_Item_MazeCollection_01_009.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_009.png",
		Name = getI18NValue(180120274),
		ItemTips = getI18NValue(180120273)
	},
	[401010] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401010,
		Icon = "/Item/Icon_Item_MazeCollection_01_010.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_010.png",
		Name = getI18NValue(180120276),
		ItemTips = getI18NValue(180120275)
	},
	[401011] = {
		Id = 401011,
		BigIcon = "/Item/Icon_Item_MazeCollection_01_011.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_MazeCollection_01_011.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180120278),
		ItemTips = getI18NValue(180120277)
	},
	[401012] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401012,
		Icon = "/Item/Icon_Item_MazeCollection_01_012.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_012.png",
		Name = getI18NValue(180120280),
		ItemTips = getI18NValue(180120279)
	},
	[401013] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401013,
		Icon = "/Item/Icon_Item_MazeCollection_01_013.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_013.png",
		Name = getI18NValue(180120282),
		ItemTips = getI18NValue(180120281)
	},
	[401014] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401014,
		Icon = "/Item/Icon_Item_MazeCollection_01_014.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_014.png",
		Name = getI18NValue(180120284),
		ItemTips = getI18NValue(180120283)
	},
	[401015] = {
		Id = 401015,
		BigIcon = "/Item/Icon_Item_MazeCollection_01_015.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_MazeCollection_01_015.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180200112),
		ItemTips = getI18NValue(180200111)
	},
	[401016] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401016,
		Icon = "/Item/Icon_Item_MazeCollection_01_016.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_016.png",
		Name = getI18NValue(180200114),
		ItemTips = getI18NValue(180200113)
	},
	[401017] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401017,
		Icon = "/Item/Icon_Item_MazeCollection_01_017.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_017.png",
		Name = getI18NValue(180200116),
		ItemTips = getI18NValue(180200115)
	},
	[401018] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401018,
		Icon = "/Item/Icon_Item_MazeCollection_01_018.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_018.png",
		Name = getI18NValue(180200118),
		ItemTips = getI18NValue(180200117)
	},
	[401019] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401019,
		Icon = "/Item/Icon_Item_MazeCollection_01_019.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_019.png",
		Name = getI18NValue(180200120),
		ItemTips = getI18NValue(180200119)
	},
	[401020] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401020,
		Icon = "/Item/Icon_Item_MazeCollection_01_020.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_020.png",
		Name = getI18NValue(180200122),
		ItemTips = getI18NValue(180200121)
	},
	[401021] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401021,
		Icon = "/Item/Icon_Item_MazeCollection_01_021.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_021.png",
		Name = getI18NValue(180200124),
		ItemTips = getI18NValue(180200123)
	},
	[401022] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401022,
		Icon = "/Item/Icon_Item_MazeCollection_01_022.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_022.png",
		Name = getI18NValue(180200126),
		ItemTips = getI18NValue(180200125)
	},
	[401023] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401023,
		Icon = "/Item/Icon_Item_MazeCollection_01_023.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_023.png",
		Name = getI18NValue(180200128),
		ItemTips = getI18NValue(180200127)
	},
	[401024] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401024,
		Icon = "/Item/Icon_Item_MazeCollection_01_024.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_024.png",
		Name = getI18NValue(180200130),
		ItemTips = getI18NValue(180200129)
	},
	[401025] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401025,
		Icon = "/Item/Icon_Item_MazeCollection_01_025.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_025.png",
		Name = getI18NValue(180200132),
		ItemTips = getI18NValue(180200131)
	},
	[401026] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401026,
		Icon = "/Item/Icon_Item_MazeCollection_01_026.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_026.png",
		Name = getI18NValue(180200134),
		ItemTips = getI18NValue(180200133)
	},
	[401027] = {
		Id = 401027,
		BigIcon = "/Item/Icon_Item_MazeCollection_01_027.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_MazeCollection_01_027.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180200136),
		ItemTips = getI18NValue(180200135)
	},
	[401028] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401028,
		Icon = "/Item/Icon_Item_MazeCollection_01_028.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_028.png",
		Name = getI18NValue(180200138),
		ItemTips = getI18NValue(180200137)
	},
	[401029] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401029,
		Icon = "/Item/Icon_Item_MazeCollection_01_029.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_029.png",
		Name = getI18NValue(180200140),
		ItemTips = getI18NValue(180200139)
	},
	[401030] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401030,
		Icon = "/Item/Icon_Item_MazeCollection_01_030.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_030.png",
		Name = getI18NValue(180200142),
		ItemTips = getI18NValue(180200141)
	},
	[401031] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401031,
		Icon = "/Item/Icon_Item_MazeCollection_01_031.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_031.png",
		Name = getI18NValue(180200144),
		ItemTips = getI18NValue(180200143)
	},
	[401032] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401032,
		Icon = "/Item/Icon_Item_MazeCollection_01_032.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_032.png",
		Name = getI18NValue(180200146),
		ItemTips = getI18NValue(180200145)
	},
	[401033] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401033,
		Icon = "/Item/Icon_Item_MazeCollection_01_033.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_033.png",
		Name = getI18NValue(180200148),
		ItemTips = getI18NValue(180200147)
	},
	[401034] = {
		Id = 401034,
		BigIcon = "/Item/Icon_Item_MazeCollection_01_034.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_MazeCollection_01_034.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180200150),
		ItemTips = getI18NValue(180200149)
	},
	[401035] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401035,
		Icon = "/Item/Icon_Item_MazeCollection_01_035.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_035.png",
		Name = getI18NValue(180200152),
		ItemTips = getI18NValue(180200151)
	},
	[401036] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401036,
		Icon = "/Item/Icon_Item_MazeCollection_01_036.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_036.png",
		Name = getI18NValue(180200154),
		ItemTips = getI18NValue(180200153)
	},
	[401037] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401037,
		Icon = "/Item/Icon_Item_MazeCollection_01_037.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_037.png",
		Name = getI18NValue(180200156),
		ItemTips = getI18NValue(180200155)
	},
	[401038] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 401038,
		Icon = "/Item/Icon_Item_MazeCollection_01_038.png",
		BigIcon = "/Item/Icon_Item_MazeCollection_01_038.png",
		Name = getI18NValue(180203604),
		ItemTips = getI18NValue(180203603)
	},
	[402001] = {
		Id = 402001,
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180198504),
		ItemTips = getI18NValue(180198503)
	},
	[402002] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402002,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198506),
		ItemTips = getI18NValue(180198505)
	},
	[402003] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402003,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198508),
		ItemTips = getI18NValue(180198507)
	},
	[402004] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402004,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198510),
		ItemTips = getI18NValue(180198509)
	},
	[402005] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402005,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198512),
		ItemTips = getI18NValue(180198511)
	},
	[402006] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402006,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198514),
		ItemTips = getI18NValue(180198513)
	},
	[402007] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402007,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198516),
		ItemTips = getI18NValue(180198515)
	},
	[402008] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402008,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198518),
		ItemTips = getI18NValue(180198517)
	},
	[402009] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402009,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198520),
		ItemTips = getI18NValue(180198519)
	},
	[402010] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402010,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198522),
		ItemTips = getI18NValue(180198521)
	},
	[402011] = {
		Id = 402011,
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		OverMode = 1,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		Quality = 1,
		ItemTypes = 17,
		Name = getI18NValue(180198524),
		ItemTips = getI18NValue(180198523)
	},
	[402012] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402012,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198526),
		ItemTips = getI18NValue(180198525)
	},
	[402013] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402013,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198528),
		ItemTips = getI18NValue(180198527)
	},
	[402014] = {
		ItemTypes = 17,
		Quality = 1,
		DropMaxNum = 1,
		OverMode = 1,
		Id = 402014,
		Icon = "/Item/Icon_Item_SummerActivity_01.png",
		BigIcon = "/Item/Icon_Item_SummerActivity_01.png",
		Name = getI18NValue(180198530),
		ItemTips = getI18NValue(180198529)
	},
	[500001] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 101,
		MaxNum = 1,
		Id = 500001,
		BigIcon = "/Equip/Icon_Item_Equip_01.png",
		Name = getI18NValue(180014543)
	},
	[500002] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 101,
		MaxNum = 1,
		Id = 500002,
		BigIcon = "/Equip/Icon_Item_Equip_01.png",
		Name = getI18NValue(180014545)
	},
	[500003] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 101,
		MaxNum = 1,
		Id = 500003,
		BigIcon = "/Equip/Icon_Item_Equip_01.png",
		Name = getI18NValue(180018070)
	},
	[500004] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 101,
		MaxNum = 1,
		Id = 500004,
		BigIcon = "/Equip/Icon_Item_Equip_01.png",
		Name = getI18NValue(180018072)
	},
	[500005] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_01.png",
		LikeId = 101,
		MaxNum = 1,
		Id = 500005,
		BigIcon = "/Equip/Icon_Item_Equip_01.png",
		Name = getI18NValue(180018074)
	},
	[500011] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 102,
		MaxNum = 1,
		Id = 500011,
		BigIcon = "/Equip/Icon_Item_Equip_06.png",
		Name = getI18NValue(180018076)
	},
	[500012] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 102,
		MaxNum = 1,
		Id = 500012,
		BigIcon = "/Equip/Icon_Item_Equip_06.png",
		Name = getI18NValue(180018078)
	},
	[500013] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 102,
		MaxNum = 1,
		Id = 500013,
		BigIcon = "/Equip/Icon_Item_Equip_06.png",
		Name = getI18NValue(180018080)
	},
	[500014] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 102,
		MaxNum = 1,
		Id = 500014,
		BigIcon = "/Equip/Icon_Item_Equip_06.png",
		Name = getI18NValue(180018082)
	},
	[500015] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_06.png",
		LikeId = 102,
		MaxNum = 1,
		Id = 500015,
		BigIcon = "/Equip/Icon_Item_Equip_06.png",
		Name = getI18NValue(180018084)
	},
	[500021] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 103,
		MaxNum = 1,
		Id = 500021,
		BigIcon = "/Equip/Icon_Item_Equip_11.png",
		Name = getI18NValue(180018086)
	},
	[500022] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 103,
		MaxNum = 1,
		Id = 500022,
		BigIcon = "/Equip/Icon_Item_Equip_11.png",
		Name = getI18NValue(180018088)
	},
	[500023] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 103,
		MaxNum = 1,
		Id = 500023,
		BigIcon = "/Equip/Icon_Item_Equip_11.png",
		Name = getI18NValue(180018090)
	},
	[500024] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 103,
		MaxNum = 1,
		Id = 500024,
		BigIcon = "/Equip/Icon_Item_Equip_11.png",
		Name = getI18NValue(180018092)
	},
	[500025] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_11.png",
		LikeId = 103,
		MaxNum = 1,
		Id = 500025,
		BigIcon = "/Equip/Icon_Item_Equip_11.png",
		Name = getI18NValue(180018094)
	},
	[500031] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 104,
		MaxNum = 1,
		Id = 500031,
		BigIcon = "/Equip/Icon_Item_Equip_16.png",
		Name = getI18NValue(180018096)
	},
	[500032] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 104,
		MaxNum = 1,
		Id = 500032,
		BigIcon = "/Equip/Icon_Item_Equip_16.png",
		Name = getI18NValue(180018098)
	},
	[500033] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 104,
		MaxNum = 1,
		Id = 500033,
		BigIcon = "/Equip/Icon_Item_Equip_16.png",
		Name = getI18NValue(180018100)
	},
	[500034] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 104,
		MaxNum = 1,
		Id = 500034,
		BigIcon = "/Equip/Icon_Item_Equip_16.png",
		Name = getI18NValue(180018102)
	},
	[500035] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_16.png",
		LikeId = 104,
		MaxNum = 1,
		Id = 500035,
		BigIcon = "/Equip/Icon_Item_Equip_16.png",
		Name = getI18NValue(180018104)
	},
	[500041] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 105,
		MaxNum = 1,
		Id = 500041,
		BigIcon = "/Equip/Icon_Item_Equip_21.png",
		Name = getI18NValue(180018106)
	},
	[500042] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 105,
		MaxNum = 1,
		Id = 500042,
		BigIcon = "/Equip/Icon_Item_Equip_21.png",
		Name = getI18NValue(180018108)
	},
	[500043] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 105,
		MaxNum = 1,
		Id = 500043,
		BigIcon = "/Equip/Icon_Item_Equip_21.png",
		Name = getI18NValue(180018110)
	},
	[500044] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 105,
		MaxNum = 1,
		Id = 500044,
		BigIcon = "/Equip/Icon_Item_Equip_21.png",
		Name = getI18NValue(180018112)
	},
	[500045] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_21.png",
		LikeId = 105,
		MaxNum = 1,
		Id = 500045,
		BigIcon = "/Equip/Icon_Item_Equip_21.png",
		Name = getI18NValue(180018114)
	},
	[500051] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 106,
		MaxNum = 1,
		Id = 500051,
		BigIcon = "/Equip/Icon_Item_Equip_26.png",
		Name = getI18NValue(180020593)
	},
	[500052] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 106,
		MaxNum = 1,
		Id = 500052,
		BigIcon = "/Equip/Icon_Item_Equip_26.png",
		Name = getI18NValue(180020595)
	},
	[500053] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 106,
		MaxNum = 1,
		Id = 500053,
		BigIcon = "/Equip/Icon_Item_Equip_26.png",
		Name = getI18NValue(180020597)
	},
	[500054] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 106,
		MaxNum = 1,
		Id = 500054,
		BigIcon = "/Equip/Icon_Item_Equip_26.png",
		Name = getI18NValue(180020599)
	},
	[500055] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_26.png",
		LikeId = 106,
		MaxNum = 1,
		Id = 500055,
		BigIcon = "/Equip/Icon_Item_Equip_26.png",
		Name = getI18NValue(180020601)
	},
	[500061] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 107,
		MaxNum = 1,
		Id = 500061,
		BigIcon = "/Equip/Icon_Item_Equip_31.png",
		Name = getI18NValue(180020603)
	},
	[500062] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 107,
		MaxNum = 1,
		Id = 500062,
		BigIcon = "/Equip/Icon_Item_Equip_31.png",
		Name = getI18NValue(180020605)
	},
	[500063] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 107,
		MaxNum = 1,
		Id = 500063,
		BigIcon = "/Equip/Icon_Item_Equip_31.png",
		Name = getI18NValue(180020607)
	},
	[500064] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 107,
		MaxNum = 1,
		Id = 500064,
		BigIcon = "/Equip/Icon_Item_Equip_31.png",
		Name = getI18NValue(180020609)
	},
	[500065] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_31.png",
		LikeId = 107,
		MaxNum = 1,
		Id = 500065,
		BigIcon = "/Equip/Icon_Item_Equip_31.png",
		Name = getI18NValue(180020611)
	},
	[500071] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 108,
		MaxNum = 1,
		Id = 500071,
		BigIcon = "/Equip/Icon_Item_Equip_36.png",
		Name = getI18NValue(180020613)
	},
	[500072] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 108,
		MaxNum = 1,
		Id = 500072,
		BigIcon = "/Equip/Icon_Item_Equip_36.png",
		Name = getI18NValue(180020615)
	},
	[500073] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 108,
		MaxNum = 1,
		Id = 500073,
		BigIcon = "/Equip/Icon_Item_Equip_36.png",
		Name = getI18NValue(180020617)
	},
	[500074] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 108,
		MaxNum = 1,
		Id = 500074,
		BigIcon = "/Equip/Icon_Item_Equip_36.png",
		Name = getI18NValue(180020619)
	},
	[500075] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_36.png",
		LikeId = 108,
		MaxNum = 1,
		Id = 500075,
		BigIcon = "/Equip/Icon_Item_Equip_36.png",
		Name = getI18NValue(180020621)
	},
	[500081] = {
		ItemTypes = 19,
		Quality = 1,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 109,
		MaxNum = 1,
		Id = 500081,
		BigIcon = "/Equip/Icon_Item_Equip_41.png",
		Name = getI18NValue(180020623)
	},
	[500082] = {
		ItemTypes = 19,
		Quality = 2,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 109,
		MaxNum = 1,
		Id = 500082,
		BigIcon = "/Equip/Icon_Item_Equip_41.png",
		Name = getI18NValue(180020625)
	},
	[500083] = {
		ItemTypes = 19,
		Quality = 3,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 109,
		MaxNum = 1,
		Id = 500083,
		BigIcon = "/Equip/Icon_Item_Equip_41.png",
		Name = getI18NValue(180020627)
	},
	[500084] = {
		ItemTypes = 19,
		Quality = 4,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 109,
		MaxNum = 1,
		Id = 500084,
		BigIcon = "/Equip/Icon_Item_Equip_41.png",
		Name = getI18NValue(180020629)
	},
	[500085] = {
		ItemTypes = 19,
		Quality = 5,
		OverMode = 1,
		Icon = "/Equip/Icon_Item_Equip_41.png",
		LikeId = 109,
		MaxNum = 1,
		Id = 500085,
		BigIcon = "/Equip/Icon_Item_Equip_41.png",
		Name = getI18NValue(180020631)
	},
	[501001] = {
		UserAction = 25,
		Quality = 3,
		ItemTypes = 20,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Maze.png",
		UseType = 1,
		Id = 501001,
		BigIcon = "/Item/Icon_Currency_Maze.png",
		Name = getI18NValue(180039384),
		ActionParams = {
			31110001
		}
	},
	[501002] = {
		UserAction = 25,
		Quality = 3,
		ItemTypes = 20,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Maze.png",
		UseType = 1,
		Id = 501002,
		BigIcon = "/Item/Icon_Currency_Maze.png",
		Name = getI18NValue(180039385),
		ActionParams = {
			31110002
		}
	},
	[501004] = {
		UserAction = 25,
		Quality = 3,
		ItemTypes = 20,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Maze.png",
		UseType = 1,
		Id = 501004,
		BigIcon = "/Item/Icon_Currency_Maze.png",
		Name = getI18NValue(180039387),
		ActionParams = {
			20001
		}
	},
	[501005] = {
		UserAction = 25,
		Quality = 3,
		ItemTypes = 20,
		OverMode = 1,
		Icon = "/Item/Icon_Currency_Maze.png",
		UseType = 1,
		Id = 501005,
		BigIcon = "/Item/Icon_Currency_Maze.png",
		Name = getI18NValue(180039388),
		ActionParams = {
			20002
		}
	},
	[600011] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9001.png",
		LikeId = 10400101,
		UseType = 3,
		Id = 600011,
		BigIcon = "/Item/Icon_ItemHero_9001.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223905)
	},
	[600012] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9001.png",
		LikeId = 10400102,
		UseType = 3,
		Id = 600012,
		BigIcon = "/Item/Icon_ItemHero_9001.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223906)
	},
	[600013] = {
		ItemTypes = 7,
		Quality = 4,
		UseType = 2,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_ItemHeroSkin_9001_1.png",
		LikeId = 10400103,
		Id = 600013,
		BigIcon = "/Item/Icon_ItemHeroSkin_9001_1.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223908),
		ItemStory = getI18NValue(180223907),
		Source = {
			30000000
		}
	},
	[600014] = {
		ItemTypes = 7,
		Quality = 4,
		Id = 600014,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_ItemHeroSkin_9001_2.png",
		LikeId = 10400104,
		UseType = 2,
		BigIcon = "/Item/Icon_ItemHeroSkin_9001_2.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223910),
		ItemTips = getI18NValue(180223909),
		Source = {
			20000010
		}
	},
	[600021] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9002.png",
		LikeId = 10400201,
		UseType = 3,
		Id = 600021,
		BigIcon = "/Item/Icon_ItemHero_9002.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223911)
	},
	[600022] = {
		ItemTypes = 7,
		Quality = 4,
		Star = false,
		OverMode = 1,
		UseType = 3,
		Icon = "/Item/Icon_ItemHero_9002.png",
		LikeId = 10400202,
		Reveal = false,
		MaxNum = 1,
		Id = 600022,
		BigIcon = "/Item/Icon_ItemHero_9002.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223912)
	},
	[600031] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9003.png",
		LikeId = 10400301,
		UseType = 3,
		Id = 600031,
		BigIcon = "/Item/Icon_ItemHero_9003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223913)
	},
	[600032] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9003.png",
		LikeId = 10400302,
		UseType = 3,
		Id = 600032,
		BigIcon = "/Item/Icon_ItemHero_9003.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223914)
	},
	[600041] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9004.png",
		LikeId = 10400401,
		UseType = 3,
		Id = 600041,
		BigIcon = "/Item/Icon_ItemHero_9004.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223915)
	},
	[600042] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9004.png",
		LikeId = 10400402,
		UseType = 3,
		Id = 600042,
		BigIcon = "/Item/Icon_ItemHero_9004.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223916)
	},
	[600051] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9005.png",
		LikeId = 10400501,
		UseType = 3,
		Id = 600051,
		BigIcon = "/Item/Icon_ItemHero_9005.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223917)
	},
	[600052] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9005.png",
		LikeId = 10400502,
		UseType = 3,
		Id = 600052,
		BigIcon = "/Item/Icon_ItemHero_9005.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223918)
	},
	[600061] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9006.png",
		LikeId = 10400601,
		UseType = 3,
		Id = 600061,
		BigIcon = "/Item/Icon_ItemHero_9006.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223919)
	},
	[600062] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9006.png",
		LikeId = 10400602,
		UseType = 3,
		Id = 600062,
		BigIcon = "/Item/Icon_ItemHero_9006.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223920)
	},
	[600071] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9007.png",
		LikeId = 10400701,
		UseType = 3,
		Id = 600071,
		BigIcon = "/Item/Icon_ItemHero_9007.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223921)
	},
	[600072] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9007.png",
		LikeId = 10400702,
		UseType = 3,
		Id = 600072,
		BigIcon = "/Item/Icon_ItemHero_9007.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223922)
	},
	[600081] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9008.png",
		LikeId = 10400801,
		UseType = 3,
		Id = 600081,
		BigIcon = "/Item/Icon_ItemHero_9008.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223923)
	},
	[600082] = {
		ItemTypes = 7,
		Quality = 4,
		Star = false,
		OverMode = 1,
		UseType = 3,
		Icon = "/Item/Icon_ItemHero_9008.png",
		LikeId = 10400802,
		Reveal = false,
		MaxNum = 1,
		Id = 600082,
		BigIcon = "/Item/Icon_ItemHero_9008.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223924)
	},
	[600091] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9009.png",
		LikeId = 10400901,
		UseType = 3,
		Id = 600091,
		BigIcon = "/Item/Icon_ItemHero_9009.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223925)
	},
	[600092] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9009.png",
		LikeId = 10400902,
		UseType = 3,
		Id = 600092,
		BigIcon = "/Item/Icon_ItemHero_9009.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223926)
	},
	[600093] = {
		ItemTypes = 7,
		Quality = 5,
		Id = 600093,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_ItemHeroSkin_9009_1.png",
		LikeId = 10400903,
		UseType = 2,
		BigIcon = "/Item/Icon_ItemHeroSkin_9009_1.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223928),
		ItemTips = getI18NValue(180223927),
		Source = {
			20000010
		}
	},
	[600101] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9010.png",
		LikeId = 10401001,
		UseType = 3,
		Id = 600101,
		BigIcon = "/Item/Icon_ItemHero_9010.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223929)
	},
	[600102] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9010.png",
		LikeId = 10401002,
		UseType = 3,
		Id = 600102,
		BigIcon = "/Item/Icon_ItemHero_9010.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223930)
	},
	[600111] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9011.png",
		LikeId = 10401101,
		UseType = 3,
		Id = 600111,
		BigIcon = "/Item/Icon_ItemHero_9011.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223931)
	},
	[600112] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9011.png",
		LikeId = 10401102,
		UseType = 3,
		Id = 600112,
		BigIcon = "/Item/Icon_ItemHero_9011.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223932)
	},
	[600121] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9012.png",
		LikeId = 10401201,
		UseType = 3,
		Id = 600121,
		BigIcon = "/Item/Icon_ItemHero_9012.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223933)
	},
	[600122] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9012.png",
		LikeId = 10401202,
		UseType = 3,
		Id = 600122,
		BigIcon = "/Item/Icon_ItemHero_9012.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223934)
	},
	[600131] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9013.png",
		LikeId = 10401301,
		UseType = 3,
		Id = 600131,
		BigIcon = "/Item/Icon_ItemHero_9013.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223935)
	},
	[600132] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9013.png",
		LikeId = 10401302,
		UseType = 3,
		Id = 600132,
		BigIcon = "/Item/Icon_ItemHero_9013.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223936)
	},
	[600141] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9014.png",
		LikeId = 10401401,
		UseType = 3,
		Id = 600141,
		BigIcon = "/Item/Icon_ItemHero_9014.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223937)
	},
	[600142] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9014.png",
		LikeId = 10401402,
		UseType = 3,
		Id = 600142,
		BigIcon = "/Item/Icon_ItemHero_9014.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223938)
	},
	[600151] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9015.png",
		LikeId = 10401501,
		UseType = 3,
		Id = 600151,
		BigIcon = "/Item/Icon_ItemHero_9015.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223939)
	},
	[600152] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9015.png",
		LikeId = 10401502,
		UseType = 3,
		Id = 600152,
		BigIcon = "/Item/Icon_ItemHero_9015.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223940)
	},
	[600161] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9016.png",
		LikeId = 10401601,
		UseType = 3,
		Id = 600161,
		BigIcon = "/Item/Icon_ItemHero_9016.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223941)
	},
	[600162] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9016.png",
		LikeId = 10401602,
		UseType = 3,
		Id = 600162,
		BigIcon = "/Item/Icon_ItemHero_9016.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223942)
	},
	[600163] = {
		ItemTypes = 7,
		Quality = 5,
		Id = 600163,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_ItemHeroSkin_9016_1.png",
		LikeId = 10401603,
		UseType = 2,
		BigIcon = "/Item/Icon_ItemHeroSkin_9016_1.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180268840),
		ItemTips = getI18NValue(180268839),
		Source = {
			20000010
		}
	},
	[600171] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9017.png",
		LikeId = 10401701,
		UseType = 3,
		Id = 600171,
		BigIcon = "/Item/Icon_ItemHero_9017.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223943)
	},
	[600172] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9017.png",
		LikeId = 10401702,
		UseType = 3,
		Id = 600172,
		BigIcon = "/Item/Icon_ItemHero_9017.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223944)
	},
	[600181] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9018.png",
		LikeId = 10401801,
		UseType = 3,
		Id = 600181,
		BigIcon = "/Item/Icon_ItemHero_9018.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223945)
	},
	[600182] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9018.png",
		LikeId = 10401802,
		UseType = 3,
		Id = 600182,
		BigIcon = "/Item/Icon_ItemHero_9018.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223946)
	},
	[600191] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9019.png",
		LikeId = 10401901,
		UseType = 3,
		Id = 600191,
		BigIcon = "/Item/Icon_ItemHero_9019.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223947)
	},
	[600192] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9019.png",
		LikeId = 10401902,
		UseType = 3,
		Id = 600192,
		BigIcon = "/Item/Icon_ItemHero_9019.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223948)
	},
	[600201] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9020.png",
		LikeId = 10402001,
		UseType = 3,
		Id = 600201,
		BigIcon = "/Item/Icon_ItemHero_9020.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223949)
	},
	[600202] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9020.png",
		LikeId = 10402002,
		UseType = 3,
		Id = 600202,
		BigIcon = "/Item/Icon_ItemHero_9020.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223950)
	},
	[600211] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9021.png",
		LikeId = 10402101,
		UseType = 3,
		Id = 600211,
		BigIcon = "/Item/Icon_ItemHero_9021.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223951)
	},
	[600212] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9021.png",
		LikeId = 10402102,
		UseType = 3,
		Id = 600212,
		BigIcon = "/Item/Icon_ItemHero_9021.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223952)
	},
	[600221] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9022.png",
		LikeId = 10402201,
		UseType = 3,
		Id = 600221,
		BigIcon = "/Item/Icon_ItemHero_9022.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223953)
	},
	[600222] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9022.png",
		LikeId = 10402202,
		UseType = 3,
		Id = 600222,
		BigIcon = "/Item/Icon_ItemHero_9022.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223954)
	},
	[600231] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9023.png",
		LikeId = 10402301,
		UseType = 3,
		Id = 600231,
		BigIcon = "/Item/Icon_ItemHero_9023.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223955)
	},
	[600232] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9023.png",
		LikeId = 10402302,
		UseType = 3,
		Id = 600232,
		BigIcon = "/Item/Icon_ItemHero_9023.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223956)
	},
	[600241] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9024.png",
		LikeId = 10402401,
		UseType = 3,
		Id = 600241,
		BigIcon = "/Item/Icon_ItemHero_9024.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223957)
	},
	[600242] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9024.png",
		LikeId = 10402402,
		UseType = 3,
		Id = 600242,
		BigIcon = "/Item/Icon_ItemHero_9024.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223958)
	},
	[600251] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9025.png",
		LikeId = 10402501,
		UseType = 3,
		Id = 600251,
		BigIcon = "/Item/Icon_ItemHero_9025.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223959)
	},
	[600252] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9025.png",
		LikeId = 10402502,
		UseType = 3,
		Id = 600252,
		BigIcon = "/Item/Icon_ItemHero_9025.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223960)
	},
	[600261] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9026.png",
		LikeId = 10402601,
		UseType = 3,
		Id = 600261,
		BigIcon = "/Item/Icon_ItemHero_9026.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223961)
	},
	[600262] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9026.png",
		LikeId = 10402602,
		UseType = 3,
		Id = 600262,
		BigIcon = "/Item/Icon_ItemHero_9026.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223962)
	},
	[600271] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9027.png",
		LikeId = 10402701,
		UseType = 3,
		Id = 600271,
		BigIcon = "/Item/Icon_ItemHero_9027.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223963)
	},
	[600272] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9027.png",
		LikeId = 10402702,
		UseType = 3,
		Id = 600272,
		BigIcon = "/Item/Icon_ItemHero_9027.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223964)
	},
	[600281] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9028.png",
		LikeId = 10402801,
		UseType = 3,
		Id = 600281,
		BigIcon = "/Item/Icon_ItemHero_9028.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223965)
	},
	[600282] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9028.png",
		LikeId = 10402802,
		UseType = 3,
		Id = 600282,
		BigIcon = "/Item/Icon_ItemHero_9028.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223966)
	},
	[600291] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9029.png",
		LikeId = 10402901,
		UseType = 3,
		Id = 600291,
		BigIcon = "/Item/Icon_ItemHero_9029.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223967)
	},
	[600292] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9029.png",
		LikeId = 10402902,
		UseType = 3,
		Id = 600292,
		BigIcon = "/Item/Icon_ItemHero_9029.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223968)
	},
	[600301] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9030.png",
		LikeId = 10403001,
		UseType = 3,
		Id = 600301,
		BigIcon = "/Item/Icon_ItemHero_9030.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223969)
	},
	[600302] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9030.png",
		LikeId = 10403002,
		UseType = 3,
		Id = 600302,
		BigIcon = "/Item/Icon_ItemHero_9030.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223970)
	},
	[600311] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9031.png",
		LikeId = 10403101,
		UseType = 3,
		Id = 600311,
		BigIcon = "/Item/Icon_ItemHero_9031.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223971)
	},
	[600312] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9031.png",
		LikeId = 10403102,
		UseType = 3,
		Id = 600312,
		BigIcon = "/Item/Icon_ItemHero_9031.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223972)
	},
	[600313] = {
		ItemTypes = 7,
		Quality = 5,
		UseType = 2,
		OverMode = 1,
		MaxNum = 1,
		Icon = "/Item/Icon_ItemHeroSkin_9031_1.png",
		LikeId = 10403103,
		Id = 600313,
		BigIcon = "/Item/Icon_ItemHeroSkin_9031_1.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223974),
		ItemStory = getI18NValue(180223973),
		Source = {
			30010000
		}
	},
	[600321] = {
		ItemTypes = 7,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10403201,
		UseType = 3,
		Id = 600321,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223975)
	},
	[600322] = {
		ItemTypes = 7,
		Quality = 4,
		MaxNum = 1,
		OverMode = 1,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10403202,
		UseType = 3,
		Id = 600322,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223976)
	},
	[600331] = {
		ItemTypes = 7,
		Quality = 3,
		Star = false,
		OverMode = 1,
		UseType = 3,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10403301,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		Id = 600331,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223977)
	},
	[600332] = {
		ItemTypes = 7,
		Quality = 4,
		Star = false,
		OverMode = 1,
		UseType = 3,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10403302,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		Id = 600332,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223978)
	},
	[600341] = {
		ItemTypes = 7,
		Quality = 3,
		Star = false,
		OverMode = 1,
		UseType = 3,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10403401,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		Id = 600341,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223979)
	},
	[600342] = {
		ItemTypes = 7,
		Quality = 4,
		Star = false,
		OverMode = 1,
		UseType = 3,
		Icon = "/Item/Icon_ItemHero_9032.png",
		LikeId = 10403402,
		Reveal = false,
		MaxNum = 1,
		Sell = false,
		Id = 600342,
		BigIcon = "/Item/Icon_ItemHero_9032.png",
		ItemSubTypes = 1,
		Name = getI18NValue(180223980)
	},
	[605001] = {
		Id = 605001,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600001,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223981)
	},
	[605002] = {
		Id = 605002,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600002,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223982)
	},
	[605003] = {
		Id = 605003,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600003,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223983)
	},
	[605004] = {
		Id = 605004,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600004,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223984)
	},
	[605005] = {
		Id = 605005,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600005,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223985)
	},
	[605006] = {
		Id = 605006,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600006,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223986)
	},
	[605007] = {
		Id = 605007,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600007,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223987)
	},
	[605008] = {
		Id = 605008,
		Quality = 3,
		MaxNum = 1,
		OverMode = 1,
		LikeId = 30600008,
		UseType = 3,
		ItemTypes = 7,
		ItemSubTypes = 2,
		Name = getI18NValue(180223988)
	}
}

setmetatable(CfgItemTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgItemTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ExpirationTime = "",
		MaxUse = 0,
		OverMode = 0,
		IsHide = 0,
		LikeId = 0,
		Reveal = false,
		UnlockConditionId = 0,
		Name = "",
		ItemStory = "",
		Sell = false,
		ItemTypes = 0,
		ItemSubTypes = 0,
		DepotType = 0,
		UserAction = 0,
		Quality = 0,
		DropMaxNum = 0,
		UseType = 0,
		Part = 0,
		Star = false,
		MaxNum = 0,
		BigIcon = "",
		Icon = "",
		SmallIcon = "",
		ItemTips = "",
		EffectiveDuration = 0,
		Isdestroyed = false,
		StartTime = "",
		Compensate = {},
		Source = {},
		CombinationId = {},
		SellReward = {},
		ActionParams = {}
	}
}

for i, data in pairs(CfgItemTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgItemTable
