-- chunkname: @IQIGame\\Config\\CfgSoulMemoryChapterTable.lua

local CfgSoulMemoryChapterTable = {
	[100010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter01.mp4",
		Id = 100010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010001,
		Name = getI18NValue(180120800),
		Order = getI18NValue(180120799),
		PieceIdList = {
			100011,
			100012,
			100013,
			100014
		},
		MemoryReward = {
			2,
			30,
			5001101,
			1
		}
	},
	[100020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100010,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter02.mp4",
		Id = 100020,
		Level = 2,
		SoulId = 20010001,
		Name = getI18NValue(180120802),
		Order = getI18NValue(180120801),
		PieceIdList = {
			100021,
			100022,
			100023,
			100024
		},
		MemoryReward = {
			2,
			30,
			5001102,
			1
		}
	},
	[100030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100020,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter03.mp4",
		Id = 100030,
		Level = 3,
		SoulId = 20010001,
		Name = getI18NValue(180120804),
		Order = getI18NValue(180120803),
		PieceIdList = {
			100031,
			100032,
			100033,
			100034
		},
		MemoryReward = {
			2,
			30,
			5001103,
			1
		}
	},
	[100040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100030,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter04.mp4",
		Id = 100040,
		Level = 4,
		SoulId = 20010001,
		Name = getI18NValue(180120806),
		Order = getI18NValue(180120805),
		PieceIdList = {
			100041,
			100042,
			100043,
			100044
		},
		MemoryReward = {
			2,
			30,
			5001104,
			1
		}
	},
	[100050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100040,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter05.mp4",
		Id = 100050,
		Level = 5,
		SoulId = 20010001,
		Name = getI18NValue(180120808),
		Order = getI18NValue(180120807),
		PieceIdList = {
			100051,
			100052,
			100053,
			100054
		},
		MemoryReward = {
			2,
			30,
			5001105,
			1
		}
	},
	[100060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100050,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter06.mp4",
		Id = 100060,
		Level = 6,
		SoulId = 20010001,
		Name = getI18NValue(180120810),
		Order = getI18NValue(180120809),
		PieceIdList = {
			100061,
			100062,
			100063,
			100064
		},
		MemoryReward = {
			2,
			30,
			5001106,
			1
		}
	},
	[100070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100060,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter07.mp4",
		Id = 100070,
		Level = 7,
		SoulId = 20010001,
		Name = getI18NValue(180120812),
		Order = getI18NValue(180120811),
		PieceIdList = {
			100071,
			100072,
			100073,
			100074
		},
		MemoryReward = {
			2,
			30,
			5001107,
			1
		}
	},
	[100080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100070,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter08.mp4",
		Id = 100080,
		Level = 8,
		SoulId = 20010001,
		Name = getI18NValue(180120814),
		Order = getI18NValue(180120813),
		PieceIdList = {
			100081,
			100082,
			100083,
			100084
		},
		MemoryReward = {
			2,
			30,
			5001108,
			1
		}
	},
	[100090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100080,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter09.mp4",
		Id = 100090,
		Level = 9,
		SoulId = 20010001,
		Name = getI18NValue(180120816),
		Order = getI18NValue(180120815),
		PieceIdList = {
			100091,
			100092,
			100093,
			100094
		},
		MemoryReward = {
			2,
			30,
			5001109,
			1
		}
	},
	[100100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100090,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter10.mp4",
		Id = 100100,
		Level = 10,
		SoulId = 20010001,
		Name = getI18NValue(180120818),
		Order = getI18NValue(180120817),
		PieceIdList = {
			100101,
			100102,
			100103,
			100104
		},
		MemoryReward = {
			2,
			30,
			5001110,
			1
		}
	},
	[100110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100100,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter11.mp4",
		Id = 100110,
		Level = 11,
		SoulId = 20010001,
		Name = getI18NValue(180120820),
		Order = getI18NValue(180120819),
		PieceIdList = {
			100111,
			100112,
			100113,
			100114
		},
		MemoryReward = {
			2,
			30,
			5001111,
			1
		}
	},
	[100120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100110,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter12.mp4",
		Id = 100120,
		Level = 12,
		SoulId = 20010001,
		Name = getI18NValue(180120822),
		Order = getI18NValue(180120821),
		PieceIdList = {
			100121,
			100122,
			100123,
			100124
		},
		MemoryReward = {
			2,
			30,
			5001112,
			1
		}
	},
	[100130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100120,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter13.mp4",
		Id = 100130,
		Level = 13,
		SoulId = 20010001,
		Name = getI18NValue(180120824),
		Order = getI18NValue(180120823),
		PieceIdList = {
			100131,
			100132,
			100133,
			100134
		},
		MemoryReward = {
			2,
			30,
			5001113,
			1
		}
	},
	[100140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100130,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter14.mp4",
		Id = 100140,
		Level = 14,
		SoulId = 20010001,
		Name = getI18NValue(180120826),
		Order = getI18NValue(180120825),
		PieceIdList = {
			100141,
			100142,
			100143,
			100144
		},
		MemoryReward = {
			2,
			30,
			5001114,
			1
		}
	},
	[100150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100140,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter15.mp4",
		Id = 100150,
		Level = 15,
		SoulId = 20010001,
		Name = getI18NValue(180120828),
		Order = getI18NValue(180120827),
		PieceIdList = {
			100151,
			100152,
			100153,
			100154
		},
		MemoryReward = {
			2,
			30,
			5001115,
			1
		}
	},
	[100160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100150,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter16.mp4",
		Id = 100160,
		Level = 16,
		SoulId = 20010001,
		Name = getI18NValue(180120830),
		Order = getI18NValue(180120829),
		PieceIdList = {
			100161,
			100162,
			100163,
			100164
		},
		MemoryReward = {
			2,
			30,
			5001116,
			1
		}
	},
	[100170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100160,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter17.mp4",
		Id = 100170,
		Level = 17,
		SoulId = 20010001,
		Name = getI18NValue(180120832),
		Order = getI18NValue(180120831),
		PieceIdList = {
			100171,
			100172,
			100173,
			100174
		},
		MemoryReward = {
			2,
			30,
			5001117,
			1
		}
	},
	[100180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Colcher/Colcher.png",
		PreMemoryChapter = 100170,
		Movie = "/Memory/Colcher/Memory_Colcher_Chapter18.mp4",
		Id = 100180,
		Level = 18,
		SoulId = 20010001,
		Name = getI18NValue(180120834),
		Order = getI18NValue(180120833),
		PieceIdList = {
			100181,
			100182,
			100183,
			100184
		},
		MemoryReward = {
			2,
			30,
			5001118,
			1
		}
	},
	[200010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter01.mp4",
		Id = 200010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010002,
		Name = getI18NValue(180120836),
		Order = getI18NValue(180120835),
		PieceIdList = {
			200011,
			200012,
			200013,
			200014
		},
		MemoryReward = {
			2,
			30,
			5002101,
			1
		}
	},
	[200020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200010,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter02.mp4",
		Id = 200020,
		Level = 2,
		SoulId = 20010002,
		Name = getI18NValue(180120838),
		Order = getI18NValue(180120837),
		PieceIdList = {
			200021,
			200022,
			200023,
			200024
		},
		MemoryReward = {
			2,
			30,
			5002102,
			1
		}
	},
	[200030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200020,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter03.mp4",
		Id = 200030,
		Level = 3,
		SoulId = 20010002,
		Name = getI18NValue(180120840),
		Order = getI18NValue(180120839),
		PieceIdList = {
			200031,
			200032,
			200033,
			200034
		},
		MemoryReward = {
			2,
			30,
			5002103,
			1
		}
	},
	[200040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200030,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter04.mp4",
		Id = 200040,
		Level = 4,
		SoulId = 20010002,
		Name = getI18NValue(180120842),
		Order = getI18NValue(180120841),
		PieceIdList = {
			200041,
			200042,
			200043,
			200044
		},
		MemoryReward = {
			2,
			30,
			5002104,
			1
		}
	},
	[200050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200040,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter05.mp4",
		Id = 200050,
		Level = 5,
		SoulId = 20010002,
		Name = getI18NValue(180120844),
		Order = getI18NValue(180120843),
		PieceIdList = {
			200051,
			200052,
			200053,
			200054
		},
		MemoryReward = {
			2,
			30,
			5002105,
			1
		}
	},
	[200060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200050,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter06.mp4",
		Id = 200060,
		Level = 6,
		SoulId = 20010002,
		Name = getI18NValue(180120846),
		Order = getI18NValue(180120845),
		PieceIdList = {
			200061,
			200062,
			200063,
			200064
		},
		MemoryReward = {
			2,
			30,
			5002106,
			1
		}
	},
	[200070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200060,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter07.mp4",
		Id = 200070,
		Level = 7,
		SoulId = 20010002,
		Name = getI18NValue(180120848),
		Order = getI18NValue(180120847),
		PieceIdList = {
			200071,
			200072,
			200073,
			200074
		},
		MemoryReward = {
			2,
			30,
			5002107,
			1
		}
	},
	[200080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200070,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter08.mp4",
		Id = 200080,
		Level = 8,
		SoulId = 20010002,
		Name = getI18NValue(180120850),
		Order = getI18NValue(180120849),
		PieceIdList = {
			200081,
			200082,
			200083,
			200084
		},
		MemoryReward = {
			2,
			30,
			5002108,
			1
		}
	},
	[200090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200080,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter09.mp4",
		Id = 200090,
		Level = 9,
		SoulId = 20010002,
		Name = getI18NValue(180120852),
		Order = getI18NValue(180120851),
		PieceIdList = {
			200091,
			200092,
			200093,
			200094
		},
		MemoryReward = {
			2,
			30,
			5002109,
			1
		}
	},
	[200100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200090,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter10.mp4",
		Id = 200100,
		Level = 10,
		SoulId = 20010002,
		Name = getI18NValue(180120854),
		Order = getI18NValue(180120853),
		PieceIdList = {
			200101,
			200102,
			200103,
			200104
		},
		MemoryReward = {
			2,
			30,
			5002110,
			1
		}
	},
	[200110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200100,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter11.mp4",
		Id = 200110,
		Level = 11,
		SoulId = 20010002,
		Name = getI18NValue(180120856),
		Order = getI18NValue(180120855),
		PieceIdList = {
			200111,
			200112,
			200113,
			200114
		},
		MemoryReward = {
			2,
			30,
			5002111,
			1
		}
	},
	[200120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200110,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter12.mp4",
		Id = 200120,
		Level = 12,
		SoulId = 20010002,
		Name = getI18NValue(180120858),
		Order = getI18NValue(180120857),
		PieceIdList = {
			200121,
			200122,
			200123,
			200124
		},
		MemoryReward = {
			2,
			30,
			5002112,
			1
		}
	},
	[200130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200120,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter13.mp4",
		Id = 200130,
		Level = 13,
		SoulId = 20010002,
		Name = getI18NValue(180120860),
		Order = getI18NValue(180120859),
		PieceIdList = {
			200131,
			200132,
			200133,
			200134
		},
		MemoryReward = {
			2,
			30,
			5002113,
			1
		}
	},
	[200140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200130,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter14.mp4",
		Id = 200140,
		Level = 14,
		SoulId = 20010002,
		Name = getI18NValue(180120862),
		Order = getI18NValue(180120861),
		PieceIdList = {
			200141,
			200142,
			200143,
			200144
		},
		MemoryReward = {
			2,
			30,
			5002114,
			1
		}
	},
	[200150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200140,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter15.mp4",
		Id = 200150,
		Level = 15,
		SoulId = 20010002,
		Name = getI18NValue(180120864),
		Order = getI18NValue(180120863),
		PieceIdList = {
			200151,
			200152,
			200153,
			200154
		},
		MemoryReward = {
			2,
			30,
			5002115,
			1
		}
	},
	[200160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200150,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter16.mp4",
		Id = 200160,
		Level = 16,
		SoulId = 20010002,
		Name = getI18NValue(180120866),
		Order = getI18NValue(180120865),
		PieceIdList = {
			200161,
			200162,
			200163,
			200164
		},
		MemoryReward = {
			2,
			30,
			5002116,
			1
		}
	},
	[200170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200160,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter17.mp4",
		Id = 200170,
		Level = 17,
		SoulId = 20010002,
		Name = getI18NValue(180120868),
		Order = getI18NValue(180120867),
		PieceIdList = {
			200171,
			200172,
			200173,
			200174
		},
		MemoryReward = {
			2,
			30,
			5002117,
			1
		}
	},
	[200180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Akaset/Akaset.png",
		PreMemoryChapter = 200170,
		Movie = "/Memory/Akaset/Memory_Akaset_Chapter18.mp4",
		Id = 200180,
		Level = 18,
		SoulId = 20010002,
		Name = getI18NValue(180120870),
		Order = getI18NValue(180120869),
		PieceIdList = {
			200181,
			200182,
			200183,
			200184
		},
		MemoryReward = {
			2,
			30,
			5002118,
			1
		}
	},
	[300010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter01.mp4",
		Id = 300010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010003,
		Name = getI18NValue(180120872),
		Order = getI18NValue(180120871),
		PieceIdList = {
			300011,
			300012,
			300013,
			300014
		},
		MemoryReward = {
			2,
			30,
			5003101,
			1
		}
	},
	[300020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300010,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter02.mp4",
		Id = 300020,
		Level = 2,
		SoulId = 20010003,
		Name = getI18NValue(180120874),
		Order = getI18NValue(180120873),
		PieceIdList = {
			300021,
			300022,
			300023,
			300024
		},
		MemoryReward = {
			2,
			30,
			5003102,
			1
		}
	},
	[300030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300020,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter03.mp4",
		Id = 300030,
		Level = 3,
		SoulId = 20010003,
		Name = getI18NValue(180120876),
		Order = getI18NValue(180120875),
		PieceIdList = {
			300031,
			300032,
			300033,
			300034
		},
		MemoryReward = {
			2,
			30,
			5003103,
			1
		}
	},
	[300040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300030,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter04.mp4",
		Id = 300040,
		Level = 4,
		SoulId = 20010003,
		Name = getI18NValue(180120878),
		Order = getI18NValue(180120877),
		PieceIdList = {
			300041,
			300042,
			300043,
			300044
		},
		MemoryReward = {
			2,
			30,
			5003104,
			1
		}
	},
	[300050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300040,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter05.mp4",
		Id = 300050,
		Level = 5,
		SoulId = 20010003,
		Name = getI18NValue(180120880),
		Order = getI18NValue(180120879),
		PieceIdList = {
			300051,
			300052,
			300053,
			300054
		},
		MemoryReward = {
			2,
			30,
			5003105,
			1
		}
	},
	[300060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300050,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter06.mp4",
		Id = 300060,
		Level = 6,
		SoulId = 20010003,
		Name = getI18NValue(180120882),
		Order = getI18NValue(180120881),
		PieceIdList = {
			300061,
			300062,
			300063,
			300064
		},
		MemoryReward = {
			2,
			30,
			5003106,
			1
		}
	},
	[300070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300060,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter07.mp4",
		Id = 300070,
		Level = 7,
		SoulId = 20010003,
		Name = getI18NValue(180120884),
		Order = getI18NValue(180120883),
		PieceIdList = {
			300071,
			300072,
			300073,
			300074
		},
		MemoryReward = {
			2,
			30,
			5003107,
			1
		}
	},
	[300080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300070,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter08.mp4",
		Id = 300080,
		Level = 8,
		SoulId = 20010003,
		Name = getI18NValue(180120886),
		Order = getI18NValue(180120885),
		PieceIdList = {
			300081,
			300082,
			300083,
			300084
		},
		MemoryReward = {
			2,
			30,
			5003108,
			1
		}
	},
	[300090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300080,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter09.mp4",
		Id = 300090,
		Level = 9,
		SoulId = 20010003,
		Name = getI18NValue(180120888),
		Order = getI18NValue(180120887),
		PieceIdList = {
			300091,
			300092,
			300093,
			300094
		},
		MemoryReward = {
			2,
			30,
			5003109,
			1
		}
	},
	[300100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300090,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter10.mp4",
		Id = 300100,
		Level = 10,
		SoulId = 20010003,
		Name = getI18NValue(180120890),
		Order = getI18NValue(180120889),
		PieceIdList = {
			300101,
			300102,
			300103,
			300104
		},
		MemoryReward = {
			2,
			30,
			5003110,
			1
		}
	},
	[300110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300100,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter11.mp4",
		Id = 300110,
		Level = 11,
		SoulId = 20010003,
		Name = getI18NValue(180120892),
		Order = getI18NValue(180120891),
		PieceIdList = {
			300111,
			300112,
			300113,
			300114
		},
		MemoryReward = {
			2,
			30,
			5003111,
			1
		}
	},
	[300120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300110,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter12.mp4",
		Id = 300120,
		Level = 12,
		SoulId = 20010003,
		Name = getI18NValue(180120894),
		Order = getI18NValue(180120893),
		PieceIdList = {
			300121,
			300122,
			300123,
			300124
		},
		MemoryReward = {
			2,
			30,
			5003112,
			1
		}
	},
	[300130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300120,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter13.mp4",
		Id = 300130,
		Level = 13,
		SoulId = 20010003,
		Name = getI18NValue(180120896),
		Order = getI18NValue(180120895),
		PieceIdList = {
			300131,
			300132,
			300133,
			300134
		},
		MemoryReward = {
			2,
			30,
			5003113,
			1
		}
	},
	[300140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300130,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter14.mp4",
		Id = 300140,
		Level = 14,
		SoulId = 20010003,
		Name = getI18NValue(180120898),
		Order = getI18NValue(180120897),
		PieceIdList = {
			300141,
			300142,
			300143,
			300144
		},
		MemoryReward = {
			2,
			30,
			5003114,
			1
		}
	},
	[300150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300140,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter15.mp4",
		Id = 300150,
		Level = 15,
		SoulId = 20010003,
		Name = getI18NValue(180120900),
		Order = getI18NValue(180120899),
		PieceIdList = {
			300151,
			300152,
			300153,
			300154
		},
		MemoryReward = {
			2,
			30,
			5003115,
			1
		}
	},
	[300160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300150,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter16.mp4",
		Id = 300160,
		Level = 16,
		SoulId = 20010003,
		Name = getI18NValue(180120902),
		Order = getI18NValue(180120901),
		PieceIdList = {
			300161,
			300162,
			300163,
			300164
		},
		MemoryReward = {
			2,
			30,
			5003116,
			1
		}
	},
	[300170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300160,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter17.mp4",
		Id = 300170,
		Level = 17,
		SoulId = 20010003,
		Name = getI18NValue(180120904),
		Order = getI18NValue(180120903),
		PieceIdList = {
			300171,
			300172,
			300173,
			300174
		},
		MemoryReward = {
			2,
			30,
			5003117,
			1
		}
	},
	[300180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lilyiro/Lilyiro.png",
		PreMemoryChapter = 300170,
		Movie = "/Memory/Lilyiro/Memory_Lilyiro_Chapter18.mp4",
		Id = 300180,
		Level = 18,
		SoulId = 20010003,
		Name = getI18NValue(180120906),
		Order = getI18NValue(180120905),
		PieceIdList = {
			300181,
			300182,
			300183,
			300184
		},
		MemoryReward = {
			2,
			30,
			5003118,
			1
		}
	},
	[400010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter01.mp4",
		Id = 400010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010004,
		Name = getI18NValue(180120908),
		Order = getI18NValue(180120907),
		PieceIdList = {
			400011,
			400012,
			400013,
			400014
		},
		MemoryReward = {
			2,
			30,
			5004101,
			1
		}
	},
	[400020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400010,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter02.mp4",
		Id = 400020,
		Level = 2,
		SoulId = 20010004,
		Name = getI18NValue(180120910),
		Order = getI18NValue(180120909),
		PieceIdList = {
			400021,
			400022,
			400023,
			400024
		},
		MemoryReward = {
			2,
			30,
			5004102,
			1
		}
	},
	[400030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400020,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter03.mp4",
		Id = 400030,
		Level = 3,
		SoulId = 20010004,
		Name = getI18NValue(180120912),
		Order = getI18NValue(180120911),
		PieceIdList = {
			400031,
			400032,
			400033,
			400034
		},
		MemoryReward = {
			2,
			30,
			5004103,
			1
		}
	},
	[400040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400030,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter04.mp4",
		Id = 400040,
		Level = 4,
		SoulId = 20010004,
		Name = getI18NValue(180120914),
		Order = getI18NValue(180120913),
		PieceIdList = {
			400041,
			400042,
			400043,
			400044
		},
		MemoryReward = {
			2,
			30,
			5004104,
			1
		}
	},
	[400050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400040,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter05.mp4",
		Id = 400050,
		Level = 5,
		SoulId = 20010004,
		Name = getI18NValue(180120916),
		Order = getI18NValue(180120915),
		PieceIdList = {
			400051,
			400052,
			400053,
			400054
		},
		MemoryReward = {
			2,
			30,
			5004105,
			1
		}
	},
	[400060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400050,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter06.mp4",
		Id = 400060,
		Level = 6,
		SoulId = 20010004,
		Name = getI18NValue(180120918),
		Order = getI18NValue(180120917),
		PieceIdList = {
			400061,
			400062,
			400063,
			400064
		},
		MemoryReward = {
			2,
			30,
			5004106,
			1
		}
	},
	[400070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400060,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter07.mp4",
		Id = 400070,
		Level = 7,
		SoulId = 20010004,
		Name = getI18NValue(180120920),
		Order = getI18NValue(180120919),
		PieceIdList = {
			400071,
			400072,
			400073,
			400074
		},
		MemoryReward = {
			2,
			30,
			5004107,
			1
		}
	},
	[400080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400070,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter08.mp4",
		Id = 400080,
		Level = 8,
		SoulId = 20010004,
		Name = getI18NValue(180120922),
		Order = getI18NValue(180120921),
		PieceIdList = {
			400081,
			400082,
			400083,
			400084
		},
		MemoryReward = {
			2,
			30,
			5004108,
			1
		}
	},
	[400090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400080,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter09.mp4",
		Id = 400090,
		Level = 9,
		SoulId = 20010004,
		Name = getI18NValue(180120924),
		Order = getI18NValue(180120923),
		PieceIdList = {
			400091,
			400092,
			400093,
			400094
		},
		MemoryReward = {
			2,
			30,
			5004109,
			1
		}
	},
	[400100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400090,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter10.mp4",
		Id = 400100,
		Level = 10,
		SoulId = 20010004,
		Name = getI18NValue(180120926),
		Order = getI18NValue(180120925),
		PieceIdList = {
			400101,
			400102,
			400103,
			400104
		},
		MemoryReward = {
			2,
			30,
			5004110,
			1
		}
	},
	[400110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400100,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter11.mp4",
		Id = 400110,
		Level = 11,
		SoulId = 20010004,
		Name = getI18NValue(180120928),
		Order = getI18NValue(180120927),
		PieceIdList = {
			400111,
			400112,
			400113,
			400114
		},
		MemoryReward = {
			2,
			30,
			5004111,
			1
		}
	},
	[400120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400110,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter12.mp4",
		Id = 400120,
		Level = 12,
		SoulId = 20010004,
		Name = getI18NValue(180120930),
		Order = getI18NValue(180120929),
		PieceIdList = {
			400121,
			400122,
			400123,
			400124
		},
		MemoryReward = {
			2,
			30,
			5004112,
			1
		}
	},
	[400130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400120,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter13.mp4",
		Id = 400130,
		Level = 13,
		SoulId = 20010004,
		Name = getI18NValue(180120932),
		Order = getI18NValue(180120931),
		PieceIdList = {
			400131,
			400132,
			400133,
			400134
		},
		MemoryReward = {
			2,
			30,
			5004113,
			1
		}
	},
	[400140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400130,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter14.mp4",
		Id = 400140,
		Level = 14,
		SoulId = 20010004,
		Name = getI18NValue(180120934),
		Order = getI18NValue(180120933),
		PieceIdList = {
			400141,
			400142,
			400143,
			400144
		},
		MemoryReward = {
			2,
			30,
			5004114,
			1
		}
	},
	[400150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400140,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter15.mp4",
		Id = 400150,
		Level = 15,
		SoulId = 20010004,
		Name = getI18NValue(180120936),
		Order = getI18NValue(180120935),
		PieceIdList = {
			400151,
			400152,
			400153,
			400154
		},
		MemoryReward = {
			2,
			30,
			5004115,
			1
		}
	},
	[400160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400150,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter16.mp4",
		Id = 400160,
		Level = 16,
		SoulId = 20010004,
		Name = getI18NValue(180120938),
		Order = getI18NValue(180120937),
		PieceIdList = {
			400161,
			400162,
			400163,
			400164
		},
		MemoryReward = {
			2,
			30,
			5004116,
			1
		}
	},
	[400170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400160,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter17.mp4",
		Id = 400170,
		Level = 17,
		SoulId = 20010004,
		Name = getI18NValue(180120940),
		Order = getI18NValue(180120939),
		PieceIdList = {
			400171,
			400172,
			400173,
			400174
		},
		MemoryReward = {
			2,
			30,
			5004117,
			1
		}
	},
	[400180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Freesia/Freesia.png",
		PreMemoryChapter = 400170,
		Movie = "/Memory/Freesia/Memory_Freesia_Chapter18.mp4",
		Id = 400180,
		Level = 18,
		SoulId = 20010004,
		Name = getI18NValue(180120942),
		Order = getI18NValue(180120941),
		PieceIdList = {
			400181,
			400182,
			400183,
			400184
		},
		MemoryReward = {
			2,
			30,
			5004118,
			1
		}
	},
	[500010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		Movie = "/Memory/Benten/Memory_Benten_Chapter01.mp4",
		Id = 500010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010005,
		Name = getI18NValue(180120944),
		Order = getI18NValue(180120943),
		PieceIdList = {
			500011,
			500012,
			500013,
			500014
		},
		MemoryReward = {
			2,
			30,
			5005101,
			1
		}
	},
	[500020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500010,
		Movie = "/Memory/Benten/Memory_Benten_Chapter02.mp4",
		Id = 500020,
		Level = 2,
		SoulId = 20010005,
		Name = getI18NValue(180120946),
		Order = getI18NValue(180120945),
		PieceIdList = {
			500021,
			500022,
			500023,
			500024
		},
		MemoryReward = {
			2,
			30,
			5005102,
			1
		}
	},
	[500030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500020,
		Movie = "/Memory/Benten/Memory_Benten_Chapter03.mp4",
		Id = 500030,
		Level = 3,
		SoulId = 20010005,
		Name = getI18NValue(180120948),
		Order = getI18NValue(180120947),
		PieceIdList = {
			500031,
			500032,
			500033,
			500034
		},
		MemoryReward = {
			2,
			30,
			5005103,
			1
		}
	},
	[500040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500030,
		Movie = "/Memory/Benten/Memory_Benten_Chapter04.mp4",
		Id = 500040,
		Level = 4,
		SoulId = 20010005,
		Name = getI18NValue(180120950),
		Order = getI18NValue(180120949),
		PieceIdList = {
			500041,
			500042,
			500043,
			500044
		},
		MemoryReward = {
			2,
			30,
			5005104,
			1
		}
	},
	[500050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500040,
		Movie = "/Memory/Benten/Memory_Benten_Chapter05.mp4",
		Id = 500050,
		Level = 5,
		SoulId = 20010005,
		Name = getI18NValue(180120952),
		Order = getI18NValue(180120951),
		PieceIdList = {
			500051,
			500052,
			500053,
			500054
		},
		MemoryReward = {
			2,
			30,
			5005105,
			1
		}
	},
	[500060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500050,
		Movie = "/Memory/Benten/Memory_Benten_Chapter06.mp4",
		Id = 500060,
		Level = 6,
		SoulId = 20010005,
		Name = getI18NValue(180120954),
		Order = getI18NValue(180120953),
		PieceIdList = {
			500061,
			500062,
			500063,
			500064
		},
		MemoryReward = {
			2,
			30,
			5005106,
			1
		}
	},
	[500070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500060,
		Movie = "/Memory/Benten/Memory_Benten_Chapter07.mp4",
		Id = 500070,
		Level = 7,
		SoulId = 20010005,
		Name = getI18NValue(180120956),
		Order = getI18NValue(180120955),
		PieceIdList = {
			500071,
			500072,
			500073,
			500074
		},
		MemoryReward = {
			2,
			30,
			5005107,
			1
		}
	},
	[500080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500070,
		Movie = "/Memory/Benten/Memory_Benten_Chapter08.mp4",
		Id = 500080,
		Level = 8,
		SoulId = 20010005,
		Name = getI18NValue(180120958),
		Order = getI18NValue(180120957),
		PieceIdList = {
			500081,
			500082,
			500083,
			500084
		},
		MemoryReward = {
			2,
			30,
			5005108,
			1
		}
	},
	[500090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500080,
		Movie = "/Memory/Benten/Memory_Benten_Chapter09.mp4",
		Id = 500090,
		Level = 9,
		SoulId = 20010005,
		Name = getI18NValue(180120960),
		Order = getI18NValue(180120959),
		PieceIdList = {
			500091,
			500092,
			500093,
			500094
		},
		MemoryReward = {
			2,
			30,
			5005109,
			1
		}
	},
	[500100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500090,
		Movie = "/Memory/Benten/Memory_Benten_Chapter10.mp4",
		Id = 500100,
		Level = 10,
		SoulId = 20010005,
		Name = getI18NValue(180120962),
		Order = getI18NValue(180120961),
		PieceIdList = {
			500101,
			500102,
			500103,
			500104
		},
		MemoryReward = {
			2,
			30,
			5005110,
			1
		}
	},
	[500110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500100,
		Movie = "/Memory/Benten/Memory_Benten_Chapter11.mp4",
		Id = 500110,
		Level = 11,
		SoulId = 20010005,
		Name = getI18NValue(180120964),
		Order = getI18NValue(180120963),
		PieceIdList = {
			500111,
			500112,
			500113,
			500114
		},
		MemoryReward = {
			2,
			30,
			5005111,
			1
		}
	},
	[500120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500110,
		Movie = "/Memory/Benten/Memory_Benten_Chapter12.mp4",
		Id = 500120,
		Level = 12,
		SoulId = 20010005,
		Name = getI18NValue(180120966),
		Order = getI18NValue(180120965),
		PieceIdList = {
			500121,
			500122,
			500123,
			500124
		},
		MemoryReward = {
			2,
			30,
			5005112,
			1
		}
	},
	[500130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500120,
		Movie = "/Memory/Benten/Memory_Benten_Chapter13.mp4",
		Id = 500130,
		Level = 13,
		SoulId = 20010005,
		Name = getI18NValue(180120968),
		Order = getI18NValue(180120967),
		PieceIdList = {
			500131,
			500132,
			500133,
			500134
		},
		MemoryReward = {
			2,
			30,
			5005113,
			1
		}
	},
	[500140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500130,
		Movie = "/Memory/Benten/Memory_Benten_Chapter14.mp4",
		Id = 500140,
		Level = 14,
		SoulId = 20010005,
		Name = getI18NValue(180120970),
		Order = getI18NValue(180120969),
		PieceIdList = {
			500141,
			500142,
			500143,
			500144
		},
		MemoryReward = {
			2,
			30,
			5005114,
			1
		}
	},
	[500150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500140,
		Movie = "/Memory/Benten/Memory_Benten_Chapter15.mp4",
		Id = 500150,
		Level = 15,
		SoulId = 20010005,
		Name = getI18NValue(180120972),
		Order = getI18NValue(180120971),
		PieceIdList = {
			500151,
			500152,
			500153,
			500154
		},
		MemoryReward = {
			2,
			30,
			5005115,
			1
		}
	},
	[500160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500150,
		Movie = "/Memory/Benten/Memory_Benten_Chapter16.mp4",
		Id = 500160,
		Level = 16,
		SoulId = 20010005,
		Name = getI18NValue(180120974),
		Order = getI18NValue(180120973),
		PieceIdList = {
			500161,
			500162,
			500163,
			500164
		},
		MemoryReward = {
			2,
			30,
			5005116,
			1
		}
	},
	[500170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500160,
		Movie = "/Memory/Benten/Memory_Benten_Chapter17.mp4",
		Id = 500170,
		Level = 17,
		SoulId = 20010005,
		Name = getI18NValue(180120976),
		Order = getI18NValue(180120975),
		PieceIdList = {
			500171,
			500172,
			500173,
			500174
		},
		MemoryReward = {
			2,
			30,
			5005117,
			1
		}
	},
	[500180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Benten_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Benten/Benten.png",
		PreMemoryChapter = 500170,
		Movie = "/Memory/Benten/Memory_Benten_Chapter18.mp4",
		Id = 500180,
		Level = 18,
		SoulId = 20010005,
		Name = getI18NValue(180120978),
		Order = getI18NValue(180120977),
		PieceIdList = {
			500181,
			500182,
			500183,
			500184
		},
		MemoryReward = {
			2,
			30,
			5005118,
			1
		}
	},
	[600010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter01.mp4",
		Id = 600010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010006,
		Name = getI18NValue(180120980),
		Order = getI18NValue(180120979),
		PieceIdList = {
			600011,
			600012,
			600013,
			600014
		},
		MemoryReward = {
			2,
			30,
			5006101,
			1
		}
	},
	[600020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600010,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter02.mp4",
		Id = 600020,
		Level = 2,
		SoulId = 20010006,
		Name = getI18NValue(180120982),
		Order = getI18NValue(180120981),
		PieceIdList = {
			600021,
			600022,
			600023,
			600024
		},
		MemoryReward = {
			2,
			30,
			5006102,
			1
		}
	},
	[600030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600020,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter03.mp4",
		Id = 600030,
		Level = 3,
		SoulId = 20010006,
		Name = getI18NValue(180120984),
		Order = getI18NValue(180120983),
		PieceIdList = {
			600031,
			600032,
			600033,
			600034
		},
		MemoryReward = {
			2,
			30,
			5006103,
			1
		}
	},
	[600040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600030,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter04.mp4",
		Id = 600040,
		Level = 4,
		SoulId = 20010006,
		Name = getI18NValue(180120986),
		Order = getI18NValue(180120985),
		PieceIdList = {
			600041,
			600042,
			600043,
			600044
		},
		MemoryReward = {
			2,
			30,
			5006104,
			1
		}
	},
	[600050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600040,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter05.mp4",
		Id = 600050,
		Level = 5,
		SoulId = 20010006,
		Name = getI18NValue(180120988),
		Order = getI18NValue(180120987),
		PieceIdList = {
			600051,
			600052,
			600053,
			600054
		},
		MemoryReward = {
			2,
			30,
			5006105,
			1
		}
	},
	[600060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600050,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter06.mp4",
		Id = 600060,
		Level = 6,
		SoulId = 20010006,
		Name = getI18NValue(180120990),
		Order = getI18NValue(180120989),
		PieceIdList = {
			600061,
			600062,
			600063,
			600064
		},
		MemoryReward = {
			2,
			30,
			5006106,
			1
		}
	},
	[600070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600060,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter07.mp4",
		Id = 600070,
		Level = 7,
		SoulId = 20010006,
		Name = getI18NValue(180120992),
		Order = getI18NValue(180120991),
		PieceIdList = {
			600071,
			600072,
			600073,
			600074
		},
		MemoryReward = {
			2,
			30,
			5006107,
			1
		}
	},
	[600080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600070,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter08.mp4",
		Id = 600080,
		Level = 8,
		SoulId = 20010006,
		Name = getI18NValue(180120994),
		Order = getI18NValue(180120993),
		PieceIdList = {
			600081,
			600082,
			600083,
			600084
		},
		MemoryReward = {
			2,
			30,
			5006108,
			1
		}
	},
	[600090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600080,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter09.mp4",
		Id = 600090,
		Level = 9,
		SoulId = 20010006,
		Name = getI18NValue(180120996),
		Order = getI18NValue(180120995),
		PieceIdList = {
			600091,
			600092,
			600093,
			600094
		},
		MemoryReward = {
			2,
			30,
			5006109,
			1
		}
	},
	[600100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600090,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter10.mp4",
		Id = 600100,
		Level = 10,
		SoulId = 20010006,
		Name = getI18NValue(180120998),
		Order = getI18NValue(180120997),
		PieceIdList = {
			600101,
			600102,
			600103,
			600104
		},
		MemoryReward = {
			2,
			30,
			5006110,
			1
		}
	},
	[600110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600100,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter11.mp4",
		Id = 600110,
		Level = 11,
		SoulId = 20010006,
		Name = getI18NValue(180121000),
		Order = getI18NValue(180120999),
		PieceIdList = {
			600111,
			600112,
			600113,
			600114
		},
		MemoryReward = {
			2,
			30,
			5006111,
			1
		}
	},
	[600120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600110,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter12.mp4",
		Id = 600120,
		Level = 12,
		SoulId = 20010006,
		Name = getI18NValue(180121002),
		Order = getI18NValue(180121001),
		PieceIdList = {
			600121,
			600122,
			600123,
			600124
		},
		MemoryReward = {
			2,
			30,
			5006112,
			1
		}
	},
	[600130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600120,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter13.mp4",
		Id = 600130,
		Level = 13,
		SoulId = 20010006,
		Name = getI18NValue(180121004),
		Order = getI18NValue(180121003),
		PieceIdList = {
			600131,
			600132,
			600133,
			600134
		},
		MemoryReward = {
			2,
			30,
			5006113,
			1
		}
	},
	[600140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600130,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter14.mp4",
		Id = 600140,
		Level = 14,
		SoulId = 20010006,
		Name = getI18NValue(180121006),
		Order = getI18NValue(180121005),
		PieceIdList = {
			600141,
			600142,
			600143,
			600144
		},
		MemoryReward = {
			2,
			30,
			5006114,
			1
		}
	},
	[600150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600140,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter15.mp4",
		Id = 600150,
		Level = 15,
		SoulId = 20010006,
		Name = getI18NValue(180121008),
		Order = getI18NValue(180121007),
		PieceIdList = {
			600151,
			600152,
			600153,
			600154
		},
		MemoryReward = {
			2,
			30,
			5006115,
			1
		}
	},
	[600160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600150,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter16.mp4",
		Id = 600160,
		Level = 16,
		SoulId = 20010006,
		Name = getI18NValue(180121010),
		Order = getI18NValue(180121009),
		PieceIdList = {
			600161,
			600162,
			600163,
			600164
		},
		MemoryReward = {
			2,
			30,
			5006116,
			1
		}
	},
	[600170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600160,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter17.mp4",
		Id = 600170,
		Level = 17,
		SoulId = 20010006,
		Name = getI18NValue(180121012),
		Order = getI18NValue(180121011),
		PieceIdList = {
			600171,
			600172,
			600173,
			600174
		},
		MemoryReward = {
			2,
			30,
			5006117,
			1
		}
	},
	[600180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Asuna_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Asuna/Asuna.png",
		PreMemoryChapter = 600170,
		Movie = "/Memory/Asuna/Memory_Asuna_Chapter18.mp4",
		Id = 600180,
		Level = 18,
		SoulId = 20010006,
		Name = getI18NValue(180121014),
		Order = getI18NValue(180121013),
		PieceIdList = {
			600181,
			600182,
			600183,
			600184
		},
		MemoryReward = {
			2,
			30,
			5006118,
			1
		}
	},
	[700010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter01.mp4",
		Id = 700010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010007,
		Name = getI18NValue(180121016),
		Order = getI18NValue(180121015),
		PieceIdList = {
			700011,
			700012,
			700013,
			700014
		},
		MemoryReward = {
			2,
			30,
			5007101,
			1
		}
	},
	[700020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700010,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter02.mp4",
		Id = 700020,
		Level = 2,
		SoulId = 20010007,
		Name = getI18NValue(180121018),
		Order = getI18NValue(180121017),
		PieceIdList = {
			700021,
			700022,
			700023,
			700024
		},
		MemoryReward = {
			2,
			30,
			5007102,
			1
		}
	},
	[700030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700020,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter03.mp4",
		Id = 700030,
		Level = 3,
		SoulId = 20010007,
		Name = getI18NValue(180121020),
		Order = getI18NValue(180121019),
		PieceIdList = {
			700031,
			700032,
			700033,
			700034
		},
		MemoryReward = {
			2,
			30,
			5007103,
			1
		}
	},
	[700040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700030,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter04.mp4",
		Id = 700040,
		Level = 4,
		SoulId = 20010007,
		Name = getI18NValue(180121022),
		Order = getI18NValue(180121021),
		PieceIdList = {
			700041,
			700042,
			700043,
			700044
		},
		MemoryReward = {
			2,
			30,
			5007104,
			1
		}
	},
	[700050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700040,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter05.mp4",
		Id = 700050,
		Level = 5,
		SoulId = 20010007,
		Name = getI18NValue(180121024),
		Order = getI18NValue(180121023),
		PieceIdList = {
			700051,
			700052,
			700053,
			700054
		},
		MemoryReward = {
			2,
			30,
			5007105,
			1
		}
	},
	[700060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700050,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter06.mp4",
		Id = 700060,
		Level = 6,
		SoulId = 20010007,
		Name = getI18NValue(180121026),
		Order = getI18NValue(180121025),
		PieceIdList = {
			700061,
			700062,
			700063,
			700064
		},
		MemoryReward = {
			2,
			30,
			5007106,
			1
		}
	},
	[700070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700060,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter07.mp4",
		Id = 700070,
		Level = 7,
		SoulId = 20010007,
		Name = getI18NValue(180121028),
		Order = getI18NValue(180121027),
		PieceIdList = {
			700071,
			700072,
			700073,
			700074
		},
		MemoryReward = {
			2,
			30,
			5007107,
			1
		}
	},
	[700080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700070,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter08.mp4",
		Id = 700080,
		Level = 8,
		SoulId = 20010007,
		Name = getI18NValue(180121030),
		Order = getI18NValue(180121029),
		PieceIdList = {
			700081,
			700082,
			700083,
			700084
		},
		MemoryReward = {
			2,
			30,
			5007108,
			1
		}
	},
	[700090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700080,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter09.mp4",
		Id = 700090,
		Level = 9,
		SoulId = 20010007,
		Name = getI18NValue(180121032),
		Order = getI18NValue(180121031),
		PieceIdList = {
			700091,
			700092,
			700093,
			700094
		},
		MemoryReward = {
			2,
			30,
			5007109,
			1
		}
	},
	[700100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700090,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter10.mp4",
		Id = 700100,
		Level = 10,
		SoulId = 20010007,
		Name = getI18NValue(180121034),
		Order = getI18NValue(180121033),
		PieceIdList = {
			700101,
			700102,
			700103,
			700104
		},
		MemoryReward = {
			2,
			30,
			5007110,
			1
		}
	},
	[700110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700100,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter11.mp4",
		Id = 700110,
		Level = 11,
		SoulId = 20010007,
		Name = getI18NValue(180121036),
		Order = getI18NValue(180121035),
		PieceIdList = {
			700111,
			700112,
			700113,
			700114
		},
		MemoryReward = {
			2,
			30,
			5007111,
			1
		}
	},
	[700120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700110,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter12.mp4",
		Id = 700120,
		Level = 12,
		SoulId = 20010007,
		Name = getI18NValue(180121038),
		Order = getI18NValue(180121037),
		PieceIdList = {
			700121,
			700122,
			700123,
			700124
		},
		MemoryReward = {
			2,
			30,
			5007112,
			1
		}
	},
	[700130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700120,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter13.mp4",
		Id = 700130,
		Level = 13,
		SoulId = 20010007,
		Name = getI18NValue(180121040),
		Order = getI18NValue(180121039),
		PieceIdList = {
			700131,
			700132,
			700133,
			700134
		},
		MemoryReward = {
			2,
			30,
			5007113,
			1
		}
	},
	[700140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700130,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter14.mp4",
		Id = 700140,
		Level = 14,
		SoulId = 20010007,
		Name = getI18NValue(180121042),
		Order = getI18NValue(180121041),
		PieceIdList = {
			700141,
			700142,
			700143,
			700144
		},
		MemoryReward = {
			2,
			30,
			5007114,
			1
		}
	},
	[700150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700140,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter15.mp4",
		Id = 700150,
		Level = 15,
		SoulId = 20010007,
		Name = getI18NValue(180121044),
		Order = getI18NValue(180121043),
		PieceIdList = {
			700151,
			700152,
			700153,
			700154
		},
		MemoryReward = {
			2,
			30,
			5007115,
			1
		}
	},
	[700160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700150,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter16.mp4",
		Id = 700160,
		Level = 16,
		SoulId = 20010007,
		Name = getI18NValue(180121046),
		Order = getI18NValue(180121045),
		PieceIdList = {
			700161,
			700162,
			700163,
			700164
		},
		MemoryReward = {
			2,
			30,
			5007116,
			1
		}
	},
	[700170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700160,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter17.mp4",
		Id = 700170,
		Level = 17,
		SoulId = 20010007,
		Name = getI18NValue(180121048),
		Order = getI18NValue(180121047),
		PieceIdList = {
			700171,
			700172,
			700173,
			700174
		},
		MemoryReward = {
			2,
			30,
			5007117,
			1
		}
	},
	[700180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Minerdwen_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Minerdwen/Minerdwen.png",
		PreMemoryChapter = 700170,
		Movie = "/Memory/Minerdwen/Memory_Minerdwen_Chapter18.mp4",
		Id = 700180,
		Level = 18,
		SoulId = 20010007,
		Name = getI18NValue(180121050),
		Order = getI18NValue(180121049),
		PieceIdList = {
			700181,
			700182,
			700183,
			700184
		},
		MemoryReward = {
			2,
			30,
			5007118,
			1
		}
	},
	[800010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter01.mp4",
		Id = 800010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010008,
		Name = getI18NValue(180121052),
		Order = getI18NValue(180121051),
		PieceIdList = {
			800011,
			800012,
			800013,
			800014
		},
		MemoryReward = {
			2,
			30,
			5008101,
			1
		}
	},
	[800020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800010,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter02.mp4",
		Id = 800020,
		Level = 2,
		SoulId = 20010008,
		Name = getI18NValue(180121054),
		Order = getI18NValue(180121053),
		PieceIdList = {
			800021,
			800022,
			800023,
			800024
		},
		MemoryReward = {
			2,
			30,
			5008102,
			1
		}
	},
	[800030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800020,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter03.mp4",
		Id = 800030,
		Level = 3,
		SoulId = 20010008,
		Name = getI18NValue(180121056),
		Order = getI18NValue(180121055),
		PieceIdList = {
			800031,
			800032,
			800033,
			800034
		},
		MemoryReward = {
			2,
			30,
			5008103,
			1
		}
	},
	[800040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800030,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter04.mp4",
		Id = 800040,
		Level = 4,
		SoulId = 20010008,
		Name = getI18NValue(180121058),
		Order = getI18NValue(180121057),
		PieceIdList = {
			800041,
			800042,
			800043,
			800044
		},
		MemoryReward = {
			2,
			30,
			5008104,
			1
		}
	},
	[800050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800040,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter05.mp4",
		Id = 800050,
		Level = 5,
		SoulId = 20010008,
		Name = getI18NValue(180121060),
		Order = getI18NValue(180121059),
		PieceIdList = {
			800051,
			800052,
			800053,
			800054
		},
		MemoryReward = {
			2,
			30,
			5008105,
			1
		}
	},
	[800060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800050,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter06.mp4",
		Id = 800060,
		Level = 6,
		SoulId = 20010008,
		Name = getI18NValue(180121062),
		Order = getI18NValue(180121061),
		PieceIdList = {
			800061,
			800062,
			800063,
			800064
		},
		MemoryReward = {
			2,
			30,
			5008106,
			1
		}
	},
	[800070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800060,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter07.mp4",
		Id = 800070,
		Level = 7,
		SoulId = 20010008,
		Name = getI18NValue(180121064),
		Order = getI18NValue(180121063),
		PieceIdList = {
			800071,
			800072,
			800073,
			800074
		},
		MemoryReward = {
			2,
			30,
			5008107,
			1
		}
	},
	[800080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800070,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter08.mp4",
		Id = 800080,
		Level = 8,
		SoulId = 20010008,
		Name = getI18NValue(180121066),
		Order = getI18NValue(180121065),
		PieceIdList = {
			800081,
			800082,
			800083,
			800084
		},
		MemoryReward = {
			2,
			30,
			5008108,
			1
		}
	},
	[800090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800080,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter09.mp4",
		Id = 800090,
		Level = 9,
		SoulId = 20010008,
		Name = getI18NValue(180121068),
		Order = getI18NValue(180121067),
		PieceIdList = {
			800091,
			800092,
			800093,
			800094
		},
		MemoryReward = {
			2,
			30,
			5008109,
			1
		}
	},
	[800100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800090,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter10.mp4",
		Id = 800100,
		Level = 10,
		SoulId = 20010008,
		Name = getI18NValue(180121070),
		Order = getI18NValue(180121069),
		PieceIdList = {
			800101,
			800102,
			800103,
			800104
		},
		MemoryReward = {
			2,
			30,
			5008110,
			1
		}
	},
	[800110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800100,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter11.mp4",
		Id = 800110,
		Level = 11,
		SoulId = 20010008,
		Name = getI18NValue(180121072),
		Order = getI18NValue(180121071),
		PieceIdList = {
			800111,
			800112,
			800113,
			800114
		},
		MemoryReward = {
			2,
			30,
			5008111,
			1
		}
	},
	[800120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800110,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter12.mp4",
		Id = 800120,
		Level = 12,
		SoulId = 20010008,
		Name = getI18NValue(180121074),
		Order = getI18NValue(180121073),
		PieceIdList = {
			800121,
			800122,
			800123,
			800124
		},
		MemoryReward = {
			2,
			30,
			5008112,
			1
		}
	},
	[800130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800120,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter13.mp4",
		Id = 800130,
		Level = 13,
		SoulId = 20010008,
		Name = getI18NValue(180121076),
		Order = getI18NValue(180121075),
		PieceIdList = {
			800131,
			800132,
			800133,
			800134
		},
		MemoryReward = {
			2,
			30,
			5008113,
			1
		}
	},
	[800140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800130,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter14.mp4",
		Id = 800140,
		Level = 14,
		SoulId = 20010008,
		Name = getI18NValue(180121078),
		Order = getI18NValue(180121077),
		PieceIdList = {
			800141,
			800142,
			800143,
			800144
		},
		MemoryReward = {
			2,
			30,
			5008114,
			1
		}
	},
	[800150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800140,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter15.mp4",
		Id = 800150,
		Level = 15,
		SoulId = 20010008,
		Name = getI18NValue(180121080),
		Order = getI18NValue(180121079),
		PieceIdList = {
			800151,
			800152,
			800153,
			800154
		},
		MemoryReward = {
			2,
			30,
			5008115,
			1
		}
	},
	[800160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800150,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter16.mp4",
		Id = 800160,
		Level = 16,
		SoulId = 20010008,
		Name = getI18NValue(180121082),
		Order = getI18NValue(180121081),
		PieceIdList = {
			800161,
			800162,
			800163,
			800164
		},
		MemoryReward = {
			2,
			30,
			5008116,
			1
		}
	},
	[800170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800160,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter17.mp4",
		Id = 800170,
		Level = 17,
		SoulId = 20010008,
		Name = getI18NValue(180121084),
		Order = getI18NValue(180121083),
		PieceIdList = {
			800171,
			800172,
			800173,
			800174
		},
		MemoryReward = {
			2,
			30,
			5008117,
			1
		}
	},
	[800180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Netsuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Netsuki/Netsuki.png",
		PreMemoryChapter = 800170,
		Movie = "/Memory/Netsuki/Memory_Netsuki_Chapter18.mp4",
		Id = 800180,
		Level = 18,
		SoulId = 20010008,
		Name = getI18NValue(180121086),
		Order = getI18NValue(180121085),
		PieceIdList = {
			800181,
			800182,
			800183,
			800184
		},
		MemoryReward = {
			2,
			30,
			5008118,
			1
		}
	},
	[900010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter01.mp4",
		Id = 900010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010009,
		Name = getI18NValue(180121088),
		Order = getI18NValue(180121087),
		PieceIdList = {
			900011,
			900012,
			900013,
			900014
		},
		MemoryReward = {
			2,
			30,
			5009101,
			1
		}
	},
	[900020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900010,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter02.mp4",
		Id = 900020,
		Level = 2,
		SoulId = 20010009,
		Name = getI18NValue(180121090),
		Order = getI18NValue(180121089),
		PieceIdList = {
			900021,
			900022,
			900023,
			900024
		},
		MemoryReward = {
			2,
			30,
			5009102,
			1
		}
	},
	[900030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900020,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter03.mp4",
		Id = 900030,
		Level = 3,
		SoulId = 20010009,
		Name = getI18NValue(180121092),
		Order = getI18NValue(180121091),
		PieceIdList = {
			900031,
			900032,
			900033,
			900034
		},
		MemoryReward = {
			2,
			30,
			5009103,
			1
		}
	},
	[900040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900030,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter04.mp4",
		Id = 900040,
		Level = 4,
		SoulId = 20010009,
		Name = getI18NValue(180121094),
		Order = getI18NValue(180121093),
		PieceIdList = {
			900041,
			900042,
			900043,
			900044
		},
		MemoryReward = {
			2,
			30,
			5009104,
			1
		}
	},
	[900050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900040,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter05.mp4",
		Id = 900050,
		Level = 5,
		SoulId = 20010009,
		Name = getI18NValue(180121096),
		Order = getI18NValue(180121095),
		PieceIdList = {
			900051,
			900052,
			900053,
			900054
		},
		MemoryReward = {
			2,
			30,
			5009105,
			1
		}
	},
	[900060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900050,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter06.mp4",
		Id = 900060,
		Level = 6,
		SoulId = 20010009,
		Name = getI18NValue(180121098),
		Order = getI18NValue(180121097),
		PieceIdList = {
			900061,
			900062,
			900063,
			900064
		},
		MemoryReward = {
			2,
			30,
			5009106,
			1
		}
	},
	[900070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900060,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter07.mp4",
		Id = 900070,
		Level = 7,
		SoulId = 20010009,
		Name = getI18NValue(180121100),
		Order = getI18NValue(180121099),
		PieceIdList = {
			900071,
			900072,
			900073,
			900074
		},
		MemoryReward = {
			2,
			30,
			5009107,
			1
		}
	},
	[900080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900070,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter08.mp4",
		Id = 900080,
		Level = 8,
		SoulId = 20010009,
		Name = getI18NValue(180121102),
		Order = getI18NValue(180121101),
		PieceIdList = {
			900081,
			900082,
			900083,
			900084
		},
		MemoryReward = {
			2,
			30,
			5009108,
			1
		}
	},
	[900090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900080,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter09.mp4",
		Id = 900090,
		Level = 9,
		SoulId = 20010009,
		Name = getI18NValue(180121104),
		Order = getI18NValue(180121103),
		PieceIdList = {
			900091,
			900092,
			900093,
			900094
		},
		MemoryReward = {
			2,
			30,
			5009109,
			1
		}
	},
	[900100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900090,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter10.mp4",
		Id = 900100,
		Level = 10,
		SoulId = 20010009,
		Name = getI18NValue(180121106),
		Order = getI18NValue(180121105),
		PieceIdList = {
			900101,
			900102,
			900103,
			900104
		},
		MemoryReward = {
			2,
			30,
			5009110,
			1
		}
	},
	[900110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900100,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter11.mp4",
		Id = 900110,
		Level = 11,
		SoulId = 20010009,
		Name = getI18NValue(180121108),
		Order = getI18NValue(180121107),
		PieceIdList = {
			900111,
			900112,
			900113,
			900114
		},
		MemoryReward = {
			2,
			30,
			5009111,
			1
		}
	},
	[900120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900110,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter12.mp4",
		Id = 900120,
		Level = 12,
		SoulId = 20010009,
		Name = getI18NValue(180121110),
		Order = getI18NValue(180121109),
		PieceIdList = {
			900121,
			900122,
			900123,
			900124
		},
		MemoryReward = {
			2,
			30,
			5009112,
			1
		}
	},
	[900130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900120,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter13.mp4",
		Id = 900130,
		Level = 13,
		SoulId = 20010009,
		Name = getI18NValue(180121112),
		Order = getI18NValue(180121111),
		PieceIdList = {
			900131,
			900132,
			900133,
			900134
		},
		MemoryReward = {
			2,
			30,
			5009113,
			1
		}
	},
	[900140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900130,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter14.mp4",
		Id = 900140,
		Level = 14,
		SoulId = 20010009,
		Name = getI18NValue(180121114),
		Order = getI18NValue(180121113),
		PieceIdList = {
			900141,
			900142,
			900143,
			900144
		},
		MemoryReward = {
			2,
			30,
			5009114,
			1
		}
	},
	[900150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900140,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter15.mp4",
		Id = 900150,
		Level = 15,
		SoulId = 20010009,
		Name = getI18NValue(180121116),
		Order = getI18NValue(180121115),
		PieceIdList = {
			900151,
			900152,
			900153,
			900154
		},
		MemoryReward = {
			2,
			30,
			5009115,
			1
		}
	},
	[900160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900150,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter16.mp4",
		Id = 900160,
		Level = 16,
		SoulId = 20010009,
		Name = getI18NValue(180121118),
		Order = getI18NValue(180121117),
		PieceIdList = {
			900161,
			900162,
			900163,
			900164
		},
		MemoryReward = {
			2,
			30,
			5009116,
			1
		}
	},
	[900170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900160,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter17.mp4",
		Id = 900170,
		Level = 17,
		SoulId = 20010009,
		Name = getI18NValue(180121120),
		Order = getI18NValue(180121119),
		PieceIdList = {
			900171,
			900172,
			900173,
			900174
		},
		MemoryReward = {
			2,
			30,
			5009117,
			1
		}
	},
	[900180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Lavira/Lavira.png",
		PreMemoryChapter = 900170,
		Movie = "/Memory/Lavira/Memory_Lavira_Chapter18.mp4",
		Id = 900180,
		Level = 18,
		SoulId = 20010009,
		Name = getI18NValue(180121122),
		Order = getI18NValue(180121121),
		PieceIdList = {
			900181,
			900182,
			900183,
			900184
		},
		MemoryReward = {
			2,
			30,
			5009118,
			1
		}
	},
	[1000010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter01.mp4",
		Id = 1000010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010010,
		Name = getI18NValue(180121124),
		Order = getI18NValue(180121123),
		PieceIdList = {
			1000011,
			1000012,
			1000013,
			1000014
		},
		MemoryReward = {
			2,
			30,
			5010101,
			1
		}
	},
	[1000020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000010,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter02.mp4",
		Id = 1000020,
		Level = 2,
		SoulId = 20010010,
		Name = getI18NValue(180121126),
		Order = getI18NValue(180121125),
		PieceIdList = {
			1000021,
			1000022,
			1000023,
			1000024
		},
		MemoryReward = {
			2,
			30,
			5010102,
			1
		}
	},
	[1000030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000020,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter03.mp4",
		Id = 1000030,
		Level = 3,
		SoulId = 20010010,
		Name = getI18NValue(180121128),
		Order = getI18NValue(180121127),
		PieceIdList = {
			1000031,
			1000032,
			1000033,
			1000034
		},
		MemoryReward = {
			2,
			30,
			5010103,
			1
		}
	},
	[1000040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000030,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter04.mp4",
		Id = 1000040,
		Level = 4,
		SoulId = 20010010,
		Name = getI18NValue(180121130),
		Order = getI18NValue(180121129),
		PieceIdList = {
			1000041,
			1000042,
			1000043,
			1000044
		},
		MemoryReward = {
			2,
			30,
			5010104,
			1
		}
	},
	[1000050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000040,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter05.mp4",
		Id = 1000050,
		Level = 5,
		SoulId = 20010010,
		Name = getI18NValue(180121132),
		Order = getI18NValue(180121131),
		PieceIdList = {
			1000051,
			1000052,
			1000053,
			1000054
		},
		MemoryReward = {
			2,
			30,
			5010105,
			1
		}
	},
	[1000060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000050,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter06.mp4",
		Id = 1000060,
		Level = 6,
		SoulId = 20010010,
		Name = getI18NValue(180121134),
		Order = getI18NValue(180121133),
		PieceIdList = {
			1000061,
			1000062,
			1000063,
			1000064
		},
		MemoryReward = {
			2,
			30,
			5010106,
			1
		}
	},
	[1000070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000060,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter07.mp4",
		Id = 1000070,
		Level = 7,
		SoulId = 20010010,
		Name = getI18NValue(180121136),
		Order = getI18NValue(180121135),
		PieceIdList = {
			1000071,
			1000072,
			1000073,
			1000074
		},
		MemoryReward = {
			2,
			30,
			5010107,
			1
		}
	},
	[1000080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000070,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter08.mp4",
		Id = 1000080,
		Level = 8,
		SoulId = 20010010,
		Name = getI18NValue(180121138),
		Order = getI18NValue(180121137),
		PieceIdList = {
			1000081,
			1000082,
			1000083,
			1000084
		},
		MemoryReward = {
			2,
			30,
			5010108,
			1
		}
	},
	[1000090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000080,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter09.mp4",
		Id = 1000090,
		Level = 9,
		SoulId = 20010010,
		Name = getI18NValue(180121140),
		Order = getI18NValue(180121139),
		PieceIdList = {
			1000091,
			1000092,
			1000093,
			1000094
		},
		MemoryReward = {
			2,
			30,
			5010109,
			1
		}
	},
	[1000100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000090,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter10.mp4",
		Id = 1000100,
		Level = 10,
		SoulId = 20010010,
		Name = getI18NValue(180121142),
		Order = getI18NValue(180121141),
		PieceIdList = {
			1000101,
			1000102,
			1000103,
			1000104
		},
		MemoryReward = {
			2,
			30,
			5010110,
			1
		}
	},
	[1000110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000100,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter11.mp4",
		Id = 1000110,
		Level = 11,
		SoulId = 20010010,
		Name = getI18NValue(180121144),
		Order = getI18NValue(180121143),
		PieceIdList = {
			1000111,
			1000112,
			1000113,
			1000114
		},
		MemoryReward = {
			2,
			30,
			5010111,
			1
		}
	},
	[1000120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000110,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter12.mp4",
		Id = 1000120,
		Level = 12,
		SoulId = 20010010,
		Name = getI18NValue(180121146),
		Order = getI18NValue(180121145),
		PieceIdList = {
			1000121,
			1000122,
			1000123,
			1000124
		},
		MemoryReward = {
			2,
			30,
			5010112,
			1
		}
	},
	[1000130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000120,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter13.mp4",
		Id = 1000130,
		Level = 13,
		SoulId = 20010010,
		Name = getI18NValue(180121148),
		Order = getI18NValue(180121147),
		PieceIdList = {
			1000131,
			1000132,
			1000133,
			1000134
		},
		MemoryReward = {
			2,
			30,
			5010113,
			1
		}
	},
	[1000140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000130,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter14.mp4",
		Id = 1000140,
		Level = 14,
		SoulId = 20010010,
		Name = getI18NValue(180121150),
		Order = getI18NValue(180121149),
		PieceIdList = {
			1000141,
			1000142,
			1000143,
			1000144
		},
		MemoryReward = {
			2,
			30,
			5010114,
			1
		}
	},
	[1000150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000140,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter15.mp4",
		Id = 1000150,
		Level = 15,
		SoulId = 20010010,
		Name = getI18NValue(180121152),
		Order = getI18NValue(180121151),
		PieceIdList = {
			1000151,
			1000152,
			1000153,
			1000154
		},
		MemoryReward = {
			2,
			30,
			5010115,
			1
		}
	},
	[1000160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000150,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter16.mp4",
		Id = 1000160,
		Level = 16,
		SoulId = 20010010,
		Name = getI18NValue(180121154),
		Order = getI18NValue(180121153),
		PieceIdList = {
			1000161,
			1000162,
			1000163,
			1000164
		},
		MemoryReward = {
			2,
			30,
			5010116,
			1
		}
	},
	[1000170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000160,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter17.mp4",
		Id = 1000170,
		Level = 17,
		SoulId = 20010010,
		Name = getI18NValue(180121156),
		Order = getI18NValue(180121155),
		PieceIdList = {
			1000171,
			1000172,
			1000173,
			1000174
		},
		MemoryReward = {
			2,
			30,
			5010117,
			1
		}
	},
	[1000180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HagakureRuri_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HagakureRuri/HagakureRuri.png",
		PreMemoryChapter = 1000170,
		Movie = "/Memory/HagakureRuri/Memory_HagakureRuri_Chapter18.mp4",
		Id = 1000180,
		Level = 18,
		SoulId = 20010010,
		Name = getI18NValue(180121158),
		Order = getI18NValue(180121157),
		PieceIdList = {
			1000181,
			1000182,
			1000183,
			1000184
		},
		MemoryReward = {
			2,
			30,
			5010118,
			1
		}
	},
	[1100010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter01.mp4",
		Id = 1100010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010011,
		Name = getI18NValue(180121160),
		Order = getI18NValue(180121159),
		PieceIdList = {
			1100011,
			1100012,
			1100013,
			1100014
		},
		MemoryReward = {
			2,
			30,
			5011101,
			1
		}
	},
	[1100020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100010,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter02.mp4",
		Id = 1100020,
		Level = 2,
		SoulId = 20010011,
		Name = getI18NValue(180121162),
		Order = getI18NValue(180121161),
		PieceIdList = {
			1100021,
			1100022,
			1100023,
			1100024
		},
		MemoryReward = {
			2,
			30,
			5011102,
			1
		}
	},
	[1100030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100020,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter03.mp4",
		Id = 1100030,
		Level = 3,
		SoulId = 20010011,
		Name = getI18NValue(180121164),
		Order = getI18NValue(180121163),
		PieceIdList = {
			1100031,
			1100032,
			1100033,
			1100034
		},
		MemoryReward = {
			2,
			30,
			5011103,
			1
		}
	},
	[1100040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100030,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter04.mp4",
		Id = 1100040,
		Level = 4,
		SoulId = 20010011,
		Name = getI18NValue(180121166),
		Order = getI18NValue(180121165),
		PieceIdList = {
			1100041,
			1100042,
			1100043,
			1100044
		},
		MemoryReward = {
			2,
			30,
			5011104,
			1
		}
	},
	[1100050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100040,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter05.mp4",
		Id = 1100050,
		Level = 5,
		SoulId = 20010011,
		Name = getI18NValue(180121168),
		Order = getI18NValue(180121167),
		PieceIdList = {
			1100051,
			1100052,
			1100053,
			1100054
		},
		MemoryReward = {
			2,
			30,
			5011105,
			1
		}
	},
	[1100060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100050,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter06.mp4",
		Id = 1100060,
		Level = 6,
		SoulId = 20010011,
		Name = getI18NValue(180121170),
		Order = getI18NValue(180121169),
		PieceIdList = {
			1100061,
			1100062,
			1100063,
			1100064
		},
		MemoryReward = {
			2,
			30,
			5011106,
			1
		}
	},
	[1100070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100060,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter07.mp4",
		Id = 1100070,
		Level = 7,
		SoulId = 20010011,
		Name = getI18NValue(180121172),
		Order = getI18NValue(180121171),
		PieceIdList = {
			1100071,
			1100072,
			1100073,
			1100074
		},
		MemoryReward = {
			2,
			30,
			5011107,
			1
		}
	},
	[1100080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100070,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter08.mp4",
		Id = 1100080,
		Level = 8,
		SoulId = 20010011,
		Name = getI18NValue(180121174),
		Order = getI18NValue(180121173),
		PieceIdList = {
			1100081,
			1100082,
			1100083,
			1100084
		},
		MemoryReward = {
			2,
			30,
			5011108,
			1
		}
	},
	[1100090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100080,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter09.mp4",
		Id = 1100090,
		Level = 9,
		SoulId = 20010011,
		Name = getI18NValue(180121176),
		Order = getI18NValue(180121175),
		PieceIdList = {
			1100091,
			1100092,
			1100093,
			1100094
		},
		MemoryReward = {
			2,
			30,
			5011109,
			1
		}
	},
	[1100100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100090,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter10.mp4",
		Id = 1100100,
		Level = 10,
		SoulId = 20010011,
		Name = getI18NValue(180121178),
		Order = getI18NValue(180121177),
		PieceIdList = {
			1100101,
			1100102,
			1100103,
			1100104
		},
		MemoryReward = {
			2,
			30,
			5011110,
			1
		}
	},
	[1100110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100100,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter11.mp4",
		Id = 1100110,
		Level = 11,
		SoulId = 20010011,
		Name = getI18NValue(180121180),
		Order = getI18NValue(180121179),
		PieceIdList = {
			1100111,
			1100112,
			1100113,
			1100114
		},
		MemoryReward = {
			2,
			30,
			5011111,
			1
		}
	},
	[1100120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100110,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter12.mp4",
		Id = 1100120,
		Level = 12,
		SoulId = 20010011,
		Name = getI18NValue(180121182),
		Order = getI18NValue(180121181),
		PieceIdList = {
			1100121,
			1100122,
			1100123,
			1100124
		},
		MemoryReward = {
			2,
			30,
			5011112,
			1
		}
	},
	[1100130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100120,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter13.mp4",
		Id = 1100130,
		Level = 13,
		SoulId = 20010011,
		Name = getI18NValue(180121184),
		Order = getI18NValue(180121183),
		PieceIdList = {
			1100131,
			1100132,
			1100133,
			1100134
		},
		MemoryReward = {
			2,
			30,
			5011113,
			1
		}
	},
	[1100140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100130,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter14.mp4",
		Id = 1100140,
		Level = 14,
		SoulId = 20010011,
		Name = getI18NValue(180121186),
		Order = getI18NValue(180121185),
		PieceIdList = {
			1100141,
			1100142,
			1100143,
			1100144
		},
		MemoryReward = {
			2,
			30,
			5011114,
			1
		}
	},
	[1100150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100140,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter15.mp4",
		Id = 1100150,
		Level = 15,
		SoulId = 20010011,
		Name = getI18NValue(180121188),
		Order = getI18NValue(180121187),
		PieceIdList = {
			1100151,
			1100152,
			1100153,
			1100154
		},
		MemoryReward = {
			2,
			30,
			5011115,
			1
		}
	},
	[1100160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100150,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter16.mp4",
		Id = 1100160,
		Level = 16,
		SoulId = 20010011,
		Name = getI18NValue(180121190),
		Order = getI18NValue(180121189),
		PieceIdList = {
			1100161,
			1100162,
			1100163,
			1100164
		},
		MemoryReward = {
			2,
			30,
			5011116,
			1
		}
	},
	[1100170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100160,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter17.mp4",
		Id = 1100170,
		Level = 17,
		SoulId = 20010011,
		Name = getI18NValue(180121192),
		Order = getI18NValue(180121191),
		PieceIdList = {
			1100171,
			1100172,
			1100173,
			1100174
		},
		MemoryReward = {
			2,
			30,
			5011117,
			1
		}
	},
	[1100180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Nicolette_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NicoletteLamel/NicoletteLamel.png",
		PreMemoryChapter = 1100170,
		Movie = "/Memory/Nicolette/Memory_Nicolette_Chapter18.mp4",
		Id = 1100180,
		Level = 18,
		SoulId = 20010011,
		Name = getI18NValue(180121194),
		Order = getI18NValue(180121193),
		PieceIdList = {
			1100181,
			1100182,
			1100183,
			1100184
		},
		MemoryReward = {
			2,
			30,
			5011118,
			1
		}
	},
	[1200010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter01.mp4",
		Id = 1200010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010012,
		Name = getI18NValue(180121196),
		Order = getI18NValue(180121195),
		PieceIdList = {
			1200011,
			1200012,
			1200013,
			1200014
		},
		MemoryReward = {
			2,
			30,
			5012101,
			1
		}
	},
	[1200020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200010,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter02.mp4",
		Id = 1200020,
		Level = 2,
		SoulId = 20010012,
		Name = getI18NValue(180121198),
		Order = getI18NValue(180121197),
		PieceIdList = {
			1200021,
			1200022,
			1200023,
			1200024
		},
		MemoryReward = {
			2,
			30,
			5012102,
			1
		}
	},
	[1200030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200020,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter03.mp4",
		Id = 1200030,
		Level = 3,
		SoulId = 20010012,
		Name = getI18NValue(180121200),
		Order = getI18NValue(180121199),
		PieceIdList = {
			1200031,
			1200032,
			1200033,
			1200034
		},
		MemoryReward = {
			2,
			30,
			5012103,
			1
		}
	},
	[1200040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200030,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter04.mp4",
		Id = 1200040,
		Level = 4,
		SoulId = 20010012,
		Name = getI18NValue(180121202),
		Order = getI18NValue(180121201),
		PieceIdList = {
			1200041,
			1200042,
			1200043,
			1200044
		},
		MemoryReward = {
			2,
			30,
			5012104,
			1
		}
	},
	[1200050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200040,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter05.mp4",
		Id = 1200050,
		Level = 5,
		SoulId = 20010012,
		Name = getI18NValue(180121204),
		Order = getI18NValue(180121203),
		PieceIdList = {
			1200051,
			1200052,
			1200053,
			1200054
		},
		MemoryReward = {
			2,
			30,
			5012105,
			1
		}
	},
	[1200060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200050,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter06.mp4",
		Id = 1200060,
		Level = 6,
		SoulId = 20010012,
		Name = getI18NValue(180121206),
		Order = getI18NValue(180121205),
		PieceIdList = {
			1200061,
			1200062,
			1200063,
			1200064
		},
		MemoryReward = {
			2,
			30,
			5012106,
			1
		}
	},
	[1200070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200060,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter07.mp4",
		Id = 1200070,
		Level = 7,
		SoulId = 20010012,
		Name = getI18NValue(180121208),
		Order = getI18NValue(180121207),
		PieceIdList = {
			1200071,
			1200072,
			1200073,
			1200074
		},
		MemoryReward = {
			2,
			30,
			5012107,
			1
		}
	},
	[1200080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200070,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter08.mp4",
		Id = 1200080,
		Level = 8,
		SoulId = 20010012,
		Name = getI18NValue(180121210),
		Order = getI18NValue(180121209),
		PieceIdList = {
			1200081,
			1200082,
			1200083,
			1200084
		},
		MemoryReward = {
			2,
			30,
			5012108,
			1
		}
	},
	[1200090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200080,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter09.mp4",
		Id = 1200090,
		Level = 9,
		SoulId = 20010012,
		Name = getI18NValue(180121212),
		Order = getI18NValue(180121211),
		PieceIdList = {
			1200091,
			1200092,
			1200093,
			1200094
		},
		MemoryReward = {
			2,
			30,
			5012109,
			1
		}
	},
	[1200100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200090,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter10.mp4",
		Id = 1200100,
		Level = 10,
		SoulId = 20010012,
		Name = getI18NValue(180121214),
		Order = getI18NValue(180121213),
		PieceIdList = {
			1200101,
			1200102,
			1200103,
			1200104
		},
		MemoryReward = {
			2,
			30,
			5012110,
			1
		}
	},
	[1200110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200100,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter11.mp4",
		Id = 1200110,
		Level = 11,
		SoulId = 20010012,
		Name = getI18NValue(180121216),
		Order = getI18NValue(180121215),
		PieceIdList = {
			1200111,
			1200112,
			1200113,
			1200114
		},
		MemoryReward = {
			2,
			30,
			5012111,
			1
		}
	},
	[1200120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200110,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter12.mp4",
		Id = 1200120,
		Level = 12,
		SoulId = 20010012,
		Name = getI18NValue(180121218),
		Order = getI18NValue(180121217),
		PieceIdList = {
			1200121,
			1200122,
			1200123,
			1200124
		},
		MemoryReward = {
			2,
			30,
			5012112,
			1
		}
	},
	[1200130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200120,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter13.mp4",
		Id = 1200130,
		Level = 13,
		SoulId = 20010012,
		Name = getI18NValue(180121220),
		Order = getI18NValue(180121219),
		PieceIdList = {
			1200131,
			1200132,
			1200133,
			1200134
		},
		MemoryReward = {
			2,
			30,
			5012113,
			1
		}
	},
	[1200140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200130,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter14.mp4",
		Id = 1200140,
		Level = 14,
		SoulId = 20010012,
		Name = getI18NValue(180121222),
		Order = getI18NValue(180121221),
		PieceIdList = {
			1200141,
			1200142,
			1200143,
			1200144
		},
		MemoryReward = {
			2,
			30,
			5012114,
			1
		}
	},
	[1200150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200140,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter15.mp4",
		Id = 1200150,
		Level = 15,
		SoulId = 20010012,
		Name = getI18NValue(180121224),
		Order = getI18NValue(180121223),
		PieceIdList = {
			1200151,
			1200152,
			1200153,
			1200154
		},
		MemoryReward = {
			2,
			30,
			5012115,
			1
		}
	},
	[1200160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200150,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter16.mp4",
		Id = 1200160,
		Level = 16,
		SoulId = 20010012,
		Name = getI18NValue(180121226),
		Order = getI18NValue(180121225),
		PieceIdList = {
			1200161,
			1200162,
			1200163,
			1200164
		},
		MemoryReward = {
			2,
			30,
			5012116,
			1
		}
	},
	[1200170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200160,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter17.mp4",
		Id = 1200170,
		Level = 17,
		SoulId = 20010012,
		Name = getI18NValue(180121228),
		Order = getI18NValue(180121227),
		PieceIdList = {
			1200171,
			1200172,
			1200173,
			1200174
		},
		MemoryReward = {
			2,
			30,
			5012117,
			1
		}
	},
	[1200180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Virgina_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Virgina/Virgina.png",
		PreMemoryChapter = 1200170,
		Movie = "/Memory/Virgina/Memory_Virgina_Chapter18.mp4",
		Id = 1200180,
		Level = 18,
		SoulId = 20010012,
		Name = getI18NValue(180121230),
		Order = getI18NValue(180121229),
		PieceIdList = {
			1200181,
			1200182,
			1200183,
			1200184
		},
		MemoryReward = {
			2,
			30,
			5012118,
			1
		}
	},
	[1300010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		Movie = "/Memory/Satya/Memory_Satya_Chapter01.mp4",
		Id = 1300010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010013,
		Name = getI18NValue(180121232),
		Order = getI18NValue(180121231),
		PieceIdList = {
			1300011,
			1300012,
			1300013,
			1300014
		},
		MemoryReward = {
			2,
			30,
			5013101,
			1
		}
	},
	[1300020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300010,
		Movie = "/Memory/Satya/Memory_Satya_Chapter02.mp4",
		Id = 1300020,
		Level = 2,
		SoulId = 20010013,
		Name = getI18NValue(180121234),
		Order = getI18NValue(180121233),
		PieceIdList = {
			1300021,
			1300022,
			1300023,
			1300024
		},
		MemoryReward = {
			2,
			30,
			5013102,
			1
		}
	},
	[1300030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300020,
		Movie = "/Memory/Satya/Memory_Satya_Chapter03.mp4",
		Id = 1300030,
		Level = 3,
		SoulId = 20010013,
		Name = getI18NValue(180121236),
		Order = getI18NValue(180121235),
		PieceIdList = {
			1300031,
			1300032,
			1300033,
			1300034
		},
		MemoryReward = {
			2,
			30,
			5013103,
			1
		}
	},
	[1300040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300030,
		Movie = "/Memory/Satya/Memory_Satya_Chapter04.mp4",
		Id = 1300040,
		Level = 4,
		SoulId = 20010013,
		Name = getI18NValue(180121238),
		Order = getI18NValue(180121237),
		PieceIdList = {
			1300041,
			1300042,
			1300043,
			1300044
		},
		MemoryReward = {
			2,
			30,
			5013104,
			1
		}
	},
	[1300050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300040,
		Movie = "/Memory/Satya/Memory_Satya_Chapter05.mp4",
		Id = 1300050,
		Level = 5,
		SoulId = 20010013,
		Name = getI18NValue(180121240),
		Order = getI18NValue(180121239),
		PieceIdList = {
			1300051,
			1300052,
			1300053,
			1300054
		},
		MemoryReward = {
			2,
			30,
			5013105,
			1
		}
	},
	[1300060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300050,
		Movie = "/Memory/Satya/Memory_Satya_Chapter06.mp4",
		Id = 1300060,
		Level = 6,
		SoulId = 20010013,
		Name = getI18NValue(180121242),
		Order = getI18NValue(180121241),
		PieceIdList = {
			1300061,
			1300062,
			1300063,
			1300064
		},
		MemoryReward = {
			2,
			30,
			5013106,
			1
		}
	},
	[1300070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300060,
		Movie = "/Memory/Satya/Memory_Satya_Chapter07.mp4",
		Id = 1300070,
		Level = 7,
		SoulId = 20010013,
		Name = getI18NValue(180121244),
		Order = getI18NValue(180121243),
		PieceIdList = {
			1300071,
			1300072,
			1300073,
			1300074
		},
		MemoryReward = {
			2,
			30,
			5013107,
			1
		}
	},
	[1300080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300070,
		Movie = "/Memory/Satya/Memory_Satya_Chapter08.mp4",
		Id = 1300080,
		Level = 8,
		SoulId = 20010013,
		Name = getI18NValue(180121246),
		Order = getI18NValue(180121245),
		PieceIdList = {
			1300081,
			1300082,
			1300083,
			1300084
		},
		MemoryReward = {
			2,
			30,
			5013108,
			1
		}
	},
	[1300090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300080,
		Movie = "/Memory/Satya/Memory_Satya_Chapter09.mp4",
		Id = 1300090,
		Level = 9,
		SoulId = 20010013,
		Name = getI18NValue(180121248),
		Order = getI18NValue(180121247),
		PieceIdList = {
			1300091,
			1300092,
			1300093,
			1300094
		},
		MemoryReward = {
			2,
			30,
			5013109,
			1
		}
	},
	[1300100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300090,
		Movie = "/Memory/Satya/Memory_Satya_Chapter10.mp4",
		Id = 1300100,
		Level = 10,
		SoulId = 20010013,
		Name = getI18NValue(180121250),
		Order = getI18NValue(180121249),
		PieceIdList = {
			1300101,
			1300102,
			1300103,
			1300104
		},
		MemoryReward = {
			2,
			30,
			5013110,
			1
		}
	},
	[1300110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300100,
		Movie = "/Memory/Satya/Memory_Satya_Chapter11.mp4",
		Id = 1300110,
		Level = 11,
		SoulId = 20010013,
		Name = getI18NValue(180121252),
		Order = getI18NValue(180121251),
		PieceIdList = {
			1300111,
			1300112,
			1300113,
			1300114
		},
		MemoryReward = {
			2,
			30,
			5013111,
			1
		}
	},
	[1300120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300110,
		Movie = "/Memory/Satya/Memory_Satya_Chapter12.mp4",
		Id = 1300120,
		Level = 12,
		SoulId = 20010013,
		Name = getI18NValue(180121254),
		Order = getI18NValue(180121253),
		PieceIdList = {
			1300121,
			1300122,
			1300123,
			1300124
		},
		MemoryReward = {
			2,
			30,
			5013112,
			1
		}
	},
	[1300130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300120,
		Movie = "/Memory/Satya/Memory_Satya_Chapter13.mp4",
		Id = 1300130,
		Level = 13,
		SoulId = 20010013,
		Name = getI18NValue(180121256),
		Order = getI18NValue(180121255),
		PieceIdList = {
			1300131,
			1300132,
			1300133,
			1300134
		},
		MemoryReward = {
			2,
			30,
			5013113,
			1
		}
	},
	[1300140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300130,
		Movie = "/Memory/Satya/Memory_Satya_Chapter14.mp4",
		Id = 1300140,
		Level = 14,
		SoulId = 20010013,
		Name = getI18NValue(180121258),
		Order = getI18NValue(180121257),
		PieceIdList = {
			1300141,
			1300142,
			1300143,
			1300144
		},
		MemoryReward = {
			2,
			30,
			5013114,
			1
		}
	},
	[1300150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300140,
		Movie = "/Memory/Satya/Memory_Satya_Chapter15.mp4",
		Id = 1300150,
		Level = 15,
		SoulId = 20010013,
		Name = getI18NValue(180121260),
		Order = getI18NValue(180121259),
		PieceIdList = {
			1300151,
			1300152,
			1300153,
			1300154
		},
		MemoryReward = {
			2,
			30,
			5013115,
			1
		}
	},
	[1300160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300150,
		Movie = "/Memory/Satya/Memory_Satya_Chapter16.mp4",
		Id = 1300160,
		Level = 16,
		SoulId = 20010013,
		Name = getI18NValue(180121262),
		Order = getI18NValue(180121261),
		PieceIdList = {
			1300161,
			1300162,
			1300163,
			1300164
		},
		MemoryReward = {
			2,
			30,
			5013116,
			1
		}
	},
	[1300170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300160,
		Movie = "/Memory/Satya/Memory_Satya_Chapter17.mp4",
		Id = 1300170,
		Level = 17,
		SoulId = 20010013,
		Name = getI18NValue(180121264),
		Order = getI18NValue(180121263),
		PieceIdList = {
			1300171,
			1300172,
			1300173,
			1300174
		},
		MemoryReward = {
			2,
			30,
			5013117,
			1
		}
	},
	[1300180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Satya/Satya.png",
		PreMemoryChapter = 1300170,
		Movie = "/Memory/Satya/Memory_Satya_Chapter18.mp4",
		Id = 1300180,
		Level = 18,
		SoulId = 20010013,
		Name = getI18NValue(180121266),
		Order = getI18NValue(180121265),
		PieceIdList = {
			1300181,
			1300182,
			1300183,
			1300184
		},
		MemoryReward = {
			2,
			30,
			5013118,
			1
		}
	},
	[1400010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter01.mp4",
		Id = 1400010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010014,
		Name = getI18NValue(180121268),
		Order = getI18NValue(180121267),
		PieceIdList = {
			1400011,
			1400012,
			1400013,
			1400014
		},
		MemoryReward = {
			2,
			30,
			5014101,
			1
		}
	},
	[1400020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400010,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter02.mp4",
		Id = 1400020,
		Level = 2,
		SoulId = 20010014,
		Name = getI18NValue(180121270),
		Order = getI18NValue(180121269),
		PieceIdList = {
			1400021,
			1400022,
			1400023,
			1400024
		},
		MemoryReward = {
			2,
			30,
			5014102,
			1
		}
	},
	[1400030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400020,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter03.mp4",
		Id = 1400030,
		Level = 3,
		SoulId = 20010014,
		Name = getI18NValue(180121272),
		Order = getI18NValue(180121271),
		PieceIdList = {
			1400031,
			1400032,
			1400033,
			1400034
		},
		MemoryReward = {
			2,
			30,
			5014103,
			1
		}
	},
	[1400040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400030,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter04.mp4",
		Id = 1400040,
		Level = 4,
		SoulId = 20010014,
		Name = getI18NValue(180121274),
		Order = getI18NValue(180121273),
		PieceIdList = {
			1400041,
			1400042,
			1400043,
			1400044
		},
		MemoryReward = {
			2,
			30,
			5014104,
			1
		}
	},
	[1400050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400040,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter05.mp4",
		Id = 1400050,
		Level = 5,
		SoulId = 20010014,
		Name = getI18NValue(180121276),
		Order = getI18NValue(180121275),
		PieceIdList = {
			1400051,
			1400052,
			1400053,
			1400054
		},
		MemoryReward = {
			2,
			30,
			5014105,
			1
		}
	},
	[1400060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400050,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter06.mp4",
		Id = 1400060,
		Level = 6,
		SoulId = 20010014,
		Name = getI18NValue(180121278),
		Order = getI18NValue(180121277),
		PieceIdList = {
			1400061,
			1400062,
			1400063,
			1400064
		},
		MemoryReward = {
			2,
			30,
			5014106,
			1
		}
	},
	[1400070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400060,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter07.mp4",
		Id = 1400070,
		Level = 7,
		SoulId = 20010014,
		Name = getI18NValue(180121280),
		Order = getI18NValue(180121279),
		PieceIdList = {
			1400071,
			1400072,
			1400073,
			1400074
		},
		MemoryReward = {
			2,
			30,
			5014107,
			1
		}
	},
	[1400080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400070,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter08.mp4",
		Id = 1400080,
		Level = 8,
		SoulId = 20010014,
		Name = getI18NValue(180121282),
		Order = getI18NValue(180121281),
		PieceIdList = {
			1400081,
			1400082,
			1400083,
			1400084
		},
		MemoryReward = {
			2,
			30,
			5014108,
			1
		}
	},
	[1400090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400080,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter09.mp4",
		Id = 1400090,
		Level = 9,
		SoulId = 20010014,
		Name = getI18NValue(180121284),
		Order = getI18NValue(180121283),
		PieceIdList = {
			1400091,
			1400092,
			1400093,
			1400094
		},
		MemoryReward = {
			2,
			30,
			5014109,
			1
		}
	},
	[1400100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400090,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter10.mp4",
		Id = 1400100,
		Level = 10,
		SoulId = 20010014,
		Name = getI18NValue(180121286),
		Order = getI18NValue(180121285),
		PieceIdList = {
			1400101,
			1400102,
			1400103,
			1400104
		},
		MemoryReward = {
			2,
			30,
			5014110,
			1
		}
	},
	[1400110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400100,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter11.mp4",
		Id = 1400110,
		Level = 11,
		SoulId = 20010014,
		Name = getI18NValue(180121288),
		Order = getI18NValue(180121287),
		PieceIdList = {
			1400111,
			1400112,
			1400113,
			1400114
		},
		MemoryReward = {
			2,
			30,
			5014111,
			1
		}
	},
	[1400120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400110,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter12.mp4",
		Id = 1400120,
		Level = 12,
		SoulId = 20010014,
		Name = getI18NValue(180121290),
		Order = getI18NValue(180121289),
		PieceIdList = {
			1400121,
			1400122,
			1400123,
			1400124
		},
		MemoryReward = {
			2,
			30,
			5014112,
			1
		}
	},
	[1400130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400120,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter13.mp4",
		Id = 1400130,
		Level = 13,
		SoulId = 20010014,
		Name = getI18NValue(180121292),
		Order = getI18NValue(180121291),
		PieceIdList = {
			1400131,
			1400132,
			1400133,
			1400134
		},
		MemoryReward = {
			2,
			30,
			5014113,
			1
		}
	},
	[1400140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400130,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter14.mp4",
		Id = 1400140,
		Level = 14,
		SoulId = 20010014,
		Name = getI18NValue(180121294),
		Order = getI18NValue(180121293),
		PieceIdList = {
			1400141,
			1400142,
			1400143,
			1400144
		},
		MemoryReward = {
			2,
			30,
			5014114,
			1
		}
	},
	[1400150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400140,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter15.mp4",
		Id = 1400150,
		Level = 15,
		SoulId = 20010014,
		Name = getI18NValue(180121296),
		Order = getI18NValue(180121295),
		PieceIdList = {
			1400151,
			1400152,
			1400153,
			1400154
		},
		MemoryReward = {
			2,
			30,
			5014115,
			1
		}
	},
	[1400160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400150,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter16.mp4",
		Id = 1400160,
		Level = 16,
		SoulId = 20010014,
		Name = getI18NValue(180121298),
		Order = getI18NValue(180121297),
		PieceIdList = {
			1400161,
			1400162,
			1400163,
			1400164
		},
		MemoryReward = {
			2,
			30,
			5014116,
			1
		}
	},
	[1400170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400160,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter17.mp4",
		Id = 1400170,
		Level = 17,
		SoulId = 20010014,
		Name = getI18NValue(180121300),
		Order = getI18NValue(180121299),
		PieceIdList = {
			1400171,
			1400172,
			1400173,
			1400174
		},
		MemoryReward = {
			2,
			30,
			5014117,
			1
		}
	},
	[1400180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_NankungLin/NankungLin.png",
		PreMemoryChapter = 1400170,
		Movie = "/Memory/NankungLin/Memory_NankungLin_Chapter18.mp4",
		Id = 1400180,
		Level = 18,
		SoulId = 20010014,
		Name = getI18NValue(180121302),
		Order = getI18NValue(180121301),
		PieceIdList = {
			1400181,
			1400182,
			1400183,
			1400184
		},
		MemoryReward = {
			2,
			30,
			5014118,
			1
		}
	},
	[1500010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter01.mp4",
		Id = 1500010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010015,
		Name = getI18NValue(180121304),
		Order = getI18NValue(180121303),
		PieceIdList = {
			1500011,
			1500012,
			1500013,
			1500014
		},
		MemoryReward = {
			2,
			30,
			5015101,
			1
		}
	},
	[1500020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500010,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter02.mp4",
		Id = 1500020,
		Level = 2,
		SoulId = 20010015,
		Name = getI18NValue(180121306),
		Order = getI18NValue(180121305),
		PieceIdList = {
			1500021,
			1500022,
			1500023,
			1500024
		},
		MemoryReward = {
			2,
			30,
			5015102,
			1
		}
	},
	[1500030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500020,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter03.mp4",
		Id = 1500030,
		Level = 3,
		SoulId = 20010015,
		Name = getI18NValue(180121308),
		Order = getI18NValue(180121307),
		PieceIdList = {
			1500031,
			1500032,
			1500033,
			1500034
		},
		MemoryReward = {
			2,
			30,
			5015103,
			1
		}
	},
	[1500040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500030,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter04.mp4",
		Id = 1500040,
		Level = 4,
		SoulId = 20010015,
		Name = getI18NValue(180121310),
		Order = getI18NValue(180121309),
		PieceIdList = {
			1500041,
			1500042,
			1500043,
			1500044
		},
		MemoryReward = {
			2,
			30,
			5015104,
			1
		}
	},
	[1500050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500040,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter05.mp4",
		Id = 1500050,
		Level = 5,
		SoulId = 20010015,
		Name = getI18NValue(180121312),
		Order = getI18NValue(180121311),
		PieceIdList = {
			1500051,
			1500052,
			1500053,
			1500054
		},
		MemoryReward = {
			2,
			30,
			5015105,
			1
		}
	},
	[1500060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500050,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter06.mp4",
		Id = 1500060,
		Level = 6,
		SoulId = 20010015,
		Name = getI18NValue(180121314),
		Order = getI18NValue(180121313),
		PieceIdList = {
			1500061,
			1500062,
			1500063,
			1500064
		},
		MemoryReward = {
			2,
			30,
			5015106,
			1
		}
	},
	[1500070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500060,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter07.mp4",
		Id = 1500070,
		Level = 7,
		SoulId = 20010015,
		Name = getI18NValue(180121316),
		Order = getI18NValue(180121315),
		PieceIdList = {
			1500071,
			1500072,
			1500073,
			1500074
		},
		MemoryReward = {
			2,
			30,
			5015107,
			1
		}
	},
	[1500080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500070,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter08.mp4",
		Id = 1500080,
		Level = 8,
		SoulId = 20010015,
		Name = getI18NValue(180121318),
		Order = getI18NValue(180121317),
		PieceIdList = {
			1500081,
			1500082,
			1500083,
			1500084
		},
		MemoryReward = {
			2,
			30,
			5015108,
			1
		}
	},
	[1500090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500080,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter09.mp4",
		Id = 1500090,
		Level = 9,
		SoulId = 20010015,
		Name = getI18NValue(180121320),
		Order = getI18NValue(180121319),
		PieceIdList = {
			1500091,
			1500092,
			1500093,
			1500094
		},
		MemoryReward = {
			2,
			30,
			5015109,
			1
		}
	},
	[1500100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500090,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter10.mp4",
		Id = 1500100,
		Level = 10,
		SoulId = 20010015,
		Name = getI18NValue(180121322),
		Order = getI18NValue(180121321),
		PieceIdList = {
			1500101,
			1500102,
			1500103,
			1500104
		},
		MemoryReward = {
			2,
			30,
			5015110,
			1
		}
	},
	[1500110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500100,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter11.mp4",
		Id = 1500110,
		Level = 11,
		SoulId = 20010015,
		Name = getI18NValue(180121324),
		Order = getI18NValue(180121323),
		PieceIdList = {
			1500111,
			1500112,
			1500113,
			1500114
		},
		MemoryReward = {
			2,
			30,
			5015111,
			1
		}
	},
	[1500120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500110,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter12.mp4",
		Id = 1500120,
		Level = 12,
		SoulId = 20010015,
		Name = getI18NValue(180121326),
		Order = getI18NValue(180121325),
		PieceIdList = {
			1500121,
			1500122,
			1500123,
			1500124
		},
		MemoryReward = {
			2,
			30,
			5015112,
			1
		}
	},
	[1500130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500120,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter13.mp4",
		Id = 1500130,
		Level = 13,
		SoulId = 20010015,
		Name = getI18NValue(180121328),
		Order = getI18NValue(180121327),
		PieceIdList = {
			1500131,
			1500132,
			1500133,
			1500134
		},
		MemoryReward = {
			2,
			30,
			5015113,
			1
		}
	},
	[1500140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500130,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter14.mp4",
		Id = 1500140,
		Level = 14,
		SoulId = 20010015,
		Name = getI18NValue(180121330),
		Order = getI18NValue(180121329),
		PieceIdList = {
			1500141,
			1500142,
			1500143,
			1500144
		},
		MemoryReward = {
			2,
			30,
			5015114,
			1
		}
	},
	[1500150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500140,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter15.mp4",
		Id = 1500150,
		Level = 15,
		SoulId = 20010015,
		Name = getI18NValue(180121332),
		Order = getI18NValue(180121331),
		PieceIdList = {
			1500151,
			1500152,
			1500153,
			1500154
		},
		MemoryReward = {
			2,
			30,
			5015115,
			1
		}
	},
	[1500160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500150,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter16.mp4",
		Id = 1500160,
		Level = 16,
		SoulId = 20010015,
		Name = getI18NValue(180121334),
		Order = getI18NValue(180121333),
		PieceIdList = {
			1500161,
			1500162,
			1500163,
			1500164
		},
		MemoryReward = {
			2,
			30,
			5015116,
			1
		}
	},
	[1500170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500160,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter17.mp4",
		Id = 1500170,
		Level = 17,
		SoulId = 20010015,
		Name = getI18NValue(180121336),
		Order = getI18NValue(180121335),
		PieceIdList = {
			1500171,
			1500172,
			1500173,
			1500174
		},
		MemoryReward = {
			2,
			30,
			5015117,
			1
		}
	},
	[1500180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dreizehn/Dreizehn.png",
		PreMemoryChapter = 1500170,
		Movie = "/Memory/Dreizehn/Memory_Dreizehn_Chapter18.mp4",
		Id = 1500180,
		Level = 18,
		SoulId = 20010015,
		Name = getI18NValue(180121338),
		Order = getI18NValue(180121337),
		PieceIdList = {
			1500181,
			1500182,
			1500183,
			1500184
		},
		MemoryReward = {
			2,
			30,
			5015118,
			1
		}
	},
	[1600010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter01.mp4",
		Id = 1600010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010016,
		Name = getI18NValue(180121340),
		Order = getI18NValue(180121339),
		PieceIdList = {
			1600011,
			1600012,
			1600013,
			1600014
		},
		MemoryReward = {
			2,
			30,
			5016101,
			1
		}
	},
	[1600020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600010,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter02.mp4",
		Id = 1600020,
		Level = 2,
		SoulId = 20010016,
		Name = getI18NValue(180121342),
		Order = getI18NValue(180121341),
		PieceIdList = {
			1600021,
			1600022,
			1600023,
			1600024
		},
		MemoryReward = {
			2,
			30,
			5016102,
			1
		}
	},
	[1600030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600020,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter03.mp4",
		Id = 1600030,
		Level = 3,
		SoulId = 20010016,
		Name = getI18NValue(180121344),
		Order = getI18NValue(180121343),
		PieceIdList = {
			1600031,
			1600032,
			1600033,
			1600034
		},
		MemoryReward = {
			2,
			30,
			5016103,
			1
		}
	},
	[1600040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600030,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter04.mp4",
		Id = 1600040,
		Level = 4,
		SoulId = 20010016,
		Name = getI18NValue(180121346),
		Order = getI18NValue(180121345),
		PieceIdList = {
			1600041,
			1600042,
			1600043,
			1600044
		},
		MemoryReward = {
			2,
			30,
			5016104,
			1
		}
	},
	[1600050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600040,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter05.mp4",
		Id = 1600050,
		Level = 5,
		SoulId = 20010016,
		Name = getI18NValue(180121348),
		Order = getI18NValue(180121347),
		PieceIdList = {
			1600051,
			1600052,
			1600053,
			1600054
		},
		MemoryReward = {
			2,
			30,
			5016105,
			1
		}
	},
	[1600060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600050,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter06.mp4",
		Id = 1600060,
		Level = 6,
		SoulId = 20010016,
		Name = getI18NValue(180121350),
		Order = getI18NValue(180121349),
		PieceIdList = {
			1600061,
			1600062,
			1600063,
			1600064
		},
		MemoryReward = {
			2,
			30,
			5016106,
			1
		}
	},
	[1600070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600060,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter07.mp4",
		Id = 1600070,
		Level = 7,
		SoulId = 20010016,
		Name = getI18NValue(180121352),
		Order = getI18NValue(180121351),
		PieceIdList = {
			1600071,
			1600072,
			1600073,
			1600074
		},
		MemoryReward = {
			2,
			30,
			5016107,
			1
		}
	},
	[1600080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600070,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter08.mp4",
		Id = 1600080,
		Level = 8,
		SoulId = 20010016,
		Name = getI18NValue(180121354),
		Order = getI18NValue(180121353),
		PieceIdList = {
			1600081,
			1600082,
			1600083,
			1600084
		},
		MemoryReward = {
			2,
			30,
			5016108,
			1
		}
	},
	[1600090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600080,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter09.mp4",
		Id = 1600090,
		Level = 9,
		SoulId = 20010016,
		Name = getI18NValue(180121356),
		Order = getI18NValue(180121355),
		PieceIdList = {
			1600091,
			1600092,
			1600093,
			1600094
		},
		MemoryReward = {
			2,
			30,
			5016109,
			1
		}
	},
	[1600100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600090,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter10.mp4",
		Id = 1600100,
		Level = 10,
		SoulId = 20010016,
		Name = getI18NValue(180121358),
		Order = getI18NValue(180121357),
		PieceIdList = {
			1600101,
			1600102,
			1600103,
			1600104
		},
		MemoryReward = {
			2,
			30,
			5016110,
			1
		}
	},
	[1600110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600100,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter11.mp4",
		Id = 1600110,
		Level = 11,
		SoulId = 20010016,
		Name = getI18NValue(180121360),
		Order = getI18NValue(180121359),
		PieceIdList = {
			1600111,
			1600112,
			1600113,
			1600114
		},
		MemoryReward = {
			2,
			30,
			5016111,
			1
		}
	},
	[1600120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600110,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter12.mp4",
		Id = 1600120,
		Level = 12,
		SoulId = 20010016,
		Name = getI18NValue(180121362),
		Order = getI18NValue(180121361),
		PieceIdList = {
			1600121,
			1600122,
			1600123,
			1600124
		},
		MemoryReward = {
			2,
			30,
			5016112,
			1
		}
	},
	[1600130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600120,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter13.mp4",
		Id = 1600130,
		Level = 13,
		SoulId = 20010016,
		Name = getI18NValue(180121364),
		Order = getI18NValue(180121363),
		PieceIdList = {
			1600131,
			1600132,
			1600133,
			1600134
		},
		MemoryReward = {
			2,
			30,
			5016113,
			1
		}
	},
	[1600140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600130,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter14.mp4",
		Id = 1600140,
		Level = 14,
		SoulId = 20010016,
		Name = getI18NValue(180121366),
		Order = getI18NValue(180121365),
		PieceIdList = {
			1600141,
			1600142,
			1600143,
			1600144
		},
		MemoryReward = {
			2,
			30,
			5016114,
			1
		}
	},
	[1600150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600140,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter15.mp4",
		Id = 1600150,
		Level = 15,
		SoulId = 20010016,
		Name = getI18NValue(180121368),
		Order = getI18NValue(180121367),
		PieceIdList = {
			1600151,
			1600152,
			1600153,
			1600154
		},
		MemoryReward = {
			2,
			30,
			5016115,
			1
		}
	},
	[1600160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600150,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter16.mp4",
		Id = 1600160,
		Level = 16,
		SoulId = 20010016,
		Name = getI18NValue(180121370),
		Order = getI18NValue(180121369),
		PieceIdList = {
			1600161,
			1600162,
			1600163,
			1600164
		},
		MemoryReward = {
			2,
			30,
			5016116,
			1
		}
	},
	[1600170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600160,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter17.mp4",
		Id = 1600170,
		Level = 17,
		SoulId = 20010016,
		Name = getI18NValue(180121372),
		Order = getI18NValue(180121371),
		PieceIdList = {
			1600171,
			1600172,
			1600173,
			1600174
		},
		MemoryReward = {
			2,
			30,
			5016117,
			1
		}
	},
	[1600180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Gawana/Gawana.png",
		PreMemoryChapter = 1600170,
		Movie = "/Memory/Gawana/Memory_Gawana_Chapter18.mp4",
		Id = 1600180,
		Level = 18,
		SoulId = 20010016,
		Name = getI18NValue(180121374),
		Order = getI18NValue(180121373),
		PieceIdList = {
			1600181,
			1600182,
			1600183,
			1600184
		},
		MemoryReward = {
			2,
			30,
			5016118,
			1
		}
	},
	[1700010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter01.mp4",
		Id = 1700010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010017,
		Name = getI18NValue(180121376),
		Order = getI18NValue(180121375),
		PieceIdList = {
			1700011,
			1700012,
			1700013,
			1700014
		},
		MemoryReward = {
			2,
			30,
			5017101,
			1
		}
	},
	[1700020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700010,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter02.mp4",
		Id = 1700020,
		Level = 2,
		SoulId = 20010017,
		Name = getI18NValue(180121378),
		Order = getI18NValue(180121377),
		PieceIdList = {
			1700021,
			1700022,
			1700023,
			1700024
		},
		MemoryReward = {
			2,
			30,
			5017102,
			1
		}
	},
	[1700030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700020,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter03.mp4",
		Id = 1700030,
		Level = 3,
		SoulId = 20010017,
		Name = getI18NValue(180121380),
		Order = getI18NValue(180121379),
		PieceIdList = {
			1700031,
			1700032,
			1700033,
			1700034
		},
		MemoryReward = {
			2,
			30,
			5017103,
			1
		}
	},
	[1700040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700030,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter04.mp4",
		Id = 1700040,
		Level = 4,
		SoulId = 20010017,
		Name = getI18NValue(180121382),
		Order = getI18NValue(180121381),
		PieceIdList = {
			1700041,
			1700042,
			1700043,
			1700044
		},
		MemoryReward = {
			2,
			30,
			5017104,
			1
		}
	},
	[1700050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700040,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter05.mp4",
		Id = 1700050,
		Level = 5,
		SoulId = 20010017,
		Name = getI18NValue(180121384),
		Order = getI18NValue(180121383),
		PieceIdList = {
			1700051,
			1700052,
			1700053,
			1700054
		},
		MemoryReward = {
			2,
			30,
			5017105,
			1
		}
	},
	[1700060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700050,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter06.mp4",
		Id = 1700060,
		Level = 6,
		SoulId = 20010017,
		Name = getI18NValue(180121386),
		Order = getI18NValue(180121385),
		PieceIdList = {
			1700061,
			1700062,
			1700063,
			1700064
		},
		MemoryReward = {
			2,
			30,
			5017106,
			1
		}
	},
	[1700070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700060,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter07.mp4",
		Id = 1700070,
		Level = 7,
		SoulId = 20010017,
		Name = getI18NValue(180121388),
		Order = getI18NValue(180121387),
		PieceIdList = {
			1700071,
			1700072,
			1700073,
			1700074
		},
		MemoryReward = {
			2,
			30,
			5017107,
			1
		}
	},
	[1700080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700070,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter08.mp4",
		Id = 1700080,
		Level = 8,
		SoulId = 20010017,
		Name = getI18NValue(180121390),
		Order = getI18NValue(180121389),
		PieceIdList = {
			1700081,
			1700082,
			1700083,
			1700084
		},
		MemoryReward = {
			2,
			30,
			5017108,
			1
		}
	},
	[1700090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700080,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter09.mp4",
		Id = 1700090,
		Level = 9,
		SoulId = 20010017,
		Name = getI18NValue(180121392),
		Order = getI18NValue(180121391),
		PieceIdList = {
			1700091,
			1700092,
			1700093,
			1700094
		},
		MemoryReward = {
			2,
			30,
			5017109,
			1
		}
	},
	[1700100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700090,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter10.mp4",
		Id = 1700100,
		Level = 10,
		SoulId = 20010017,
		Name = getI18NValue(180121394),
		Order = getI18NValue(180121393),
		PieceIdList = {
			1700101,
			1700102,
			1700103,
			1700104
		},
		MemoryReward = {
			2,
			30,
			5017110,
			1
		}
	},
	[1700110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700100,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter11.mp4",
		Id = 1700110,
		Level = 11,
		SoulId = 20010017,
		Name = getI18NValue(180121396),
		Order = getI18NValue(180121395),
		PieceIdList = {
			1700111,
			1700112,
			1700113,
			1700114
		},
		MemoryReward = {
			2,
			30,
			5017111,
			1
		}
	},
	[1700120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700110,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter12.mp4",
		Id = 1700120,
		Level = 12,
		SoulId = 20010017,
		Name = getI18NValue(180121398),
		Order = getI18NValue(180121397),
		PieceIdList = {
			1700121,
			1700122,
			1700123,
			1700124
		},
		MemoryReward = {
			2,
			30,
			5017112,
			1
		}
	},
	[1700130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700120,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter13.mp4",
		Id = 1700130,
		Level = 13,
		SoulId = 20010017,
		Name = getI18NValue(180121400),
		Order = getI18NValue(180121399),
		PieceIdList = {
			1700131,
			1700132,
			1700133,
			1700134
		},
		MemoryReward = {
			2,
			30,
			5017113,
			1
		}
	},
	[1700140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700130,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter14.mp4",
		Id = 1700140,
		Level = 14,
		SoulId = 20010017,
		Name = getI18NValue(180121402),
		Order = getI18NValue(180121401),
		PieceIdList = {
			1700141,
			1700142,
			1700143,
			1700144
		},
		MemoryReward = {
			2,
			30,
			5017114,
			1
		}
	},
	[1700150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700140,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter15.mp4",
		Id = 1700150,
		Level = 15,
		SoulId = 20010017,
		Name = getI18NValue(180121404),
		Order = getI18NValue(180121403),
		PieceIdList = {
			1700151,
			1700152,
			1700153,
			1700154
		},
		MemoryReward = {
			2,
			30,
			5017115,
			1
		}
	},
	[1700160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700150,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter16.mp4",
		Id = 1700160,
		Level = 16,
		SoulId = 20010017,
		Name = getI18NValue(180121406),
		Order = getI18NValue(180121405),
		PieceIdList = {
			1700161,
			1700162,
			1700163,
			1700164
		},
		MemoryReward = {
			2,
			30,
			5017116,
			1
		}
	},
	[1700170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700160,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter17.mp4",
		Id = 1700170,
		Level = 17,
		SoulId = 20010017,
		Name = getI18NValue(180121408),
		Order = getI18NValue(180121407),
		PieceIdList = {
			1700171,
			1700172,
			1700173,
			1700174
		},
		MemoryReward = {
			2,
			30,
			5017117,
			1
		}
	},
	[1700180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Juewa/Juewa.png",
		PreMemoryChapter = 1700170,
		Movie = "/Memory/Juewa/Memory_Juewa_Chapter18.mp4",
		Id = 1700180,
		Level = 18,
		SoulId = 20010017,
		Name = getI18NValue(180121410),
		Order = getI18NValue(180121409),
		PieceIdList = {
			1700181,
			1700182,
			1700183,
			1700184
		},
		MemoryReward = {
			2,
			30,
			5017118,
			1
		}
	},
	[1800010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter01.mp4",
		Id = 1800010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010018,
		Name = getI18NValue(180121412),
		Order = getI18NValue(180121411),
		PieceIdList = {
			1800011,
			1800012,
			1800013,
			1800014
		},
		MemoryReward = {
			2,
			30,
			5018101,
			1
		}
	},
	[1800020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800010,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter02.mp4",
		Id = 1800020,
		Level = 2,
		SoulId = 20010018,
		Name = getI18NValue(180121414),
		Order = getI18NValue(180121413),
		PieceIdList = {
			1800021,
			1800022,
			1800023,
			1800024
		},
		MemoryReward = {
			2,
			30,
			5018102,
			1
		}
	},
	[1800030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800020,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter03.mp4",
		Id = 1800030,
		Level = 3,
		SoulId = 20010018,
		Name = getI18NValue(180121416),
		Order = getI18NValue(180121415),
		PieceIdList = {
			1800031,
			1800032,
			1800033,
			1800034
		},
		MemoryReward = {
			2,
			30,
			5018103,
			1
		}
	},
	[1800040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800030,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter04.mp4",
		Id = 1800040,
		Level = 4,
		SoulId = 20010018,
		Name = getI18NValue(180121418),
		Order = getI18NValue(180121417),
		PieceIdList = {
			1800041,
			1800042,
			1800043,
			1800044
		},
		MemoryReward = {
			2,
			30,
			5018104,
			1
		}
	},
	[1800050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800040,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter05.mp4",
		Id = 1800050,
		Level = 5,
		SoulId = 20010018,
		Name = getI18NValue(180121420),
		Order = getI18NValue(180121419),
		PieceIdList = {
			1800051,
			1800052,
			1800053,
			1800054
		},
		MemoryReward = {
			2,
			30,
			5018105,
			1
		}
	},
	[1800060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800050,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter06.mp4",
		Id = 1800060,
		Level = 6,
		SoulId = 20010018,
		Name = getI18NValue(180121422),
		Order = getI18NValue(180121421),
		PieceIdList = {
			1800061,
			1800062,
			1800063,
			1800064
		},
		MemoryReward = {
			2,
			30,
			5018106,
			1
		}
	},
	[1800070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800060,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter07.mp4",
		Id = 1800070,
		Level = 7,
		SoulId = 20010018,
		Name = getI18NValue(180121424),
		Order = getI18NValue(180121423),
		PieceIdList = {
			1800071,
			1800072,
			1800073,
			1800074
		},
		MemoryReward = {
			2,
			30,
			5018107,
			1
		}
	},
	[1800080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800070,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter08.mp4",
		Id = 1800080,
		Level = 8,
		SoulId = 20010018,
		Name = getI18NValue(180121426),
		Order = getI18NValue(180121425),
		PieceIdList = {
			1800081,
			1800082,
			1800083,
			1800084
		},
		MemoryReward = {
			2,
			30,
			5018108,
			1
		}
	},
	[1800090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800080,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter09.mp4",
		Id = 1800090,
		Level = 9,
		SoulId = 20010018,
		Name = getI18NValue(180121428),
		Order = getI18NValue(180121427),
		PieceIdList = {
			1800091,
			1800092,
			1800093,
			1800094
		},
		MemoryReward = {
			2,
			30,
			5018109,
			1
		}
	},
	[1800100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800090,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter10.mp4",
		Id = 1800100,
		Level = 10,
		SoulId = 20010018,
		Name = getI18NValue(180121430),
		Order = getI18NValue(180121429),
		PieceIdList = {
			1800101,
			1800102,
			1800103,
			1800104
		},
		MemoryReward = {
			2,
			30,
			5018110,
			1
		}
	},
	[1800110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800100,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter11.mp4",
		Id = 1800110,
		Level = 11,
		SoulId = 20010018,
		Name = getI18NValue(180121432),
		Order = getI18NValue(180121431),
		PieceIdList = {
			1800111,
			1800112,
			1800113,
			1800114
		},
		MemoryReward = {
			2,
			30,
			5018111,
			1
		}
	},
	[1800120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800110,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter12.mp4",
		Id = 1800120,
		Level = 12,
		SoulId = 20010018,
		Name = getI18NValue(180121434),
		Order = getI18NValue(180121433),
		PieceIdList = {
			1800121,
			1800122,
			1800123,
			1800124
		},
		MemoryReward = {
			2,
			30,
			5018112,
			1
		}
	},
	[1800130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800120,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter13.mp4",
		Id = 1800130,
		Level = 13,
		SoulId = 20010018,
		Name = getI18NValue(180121436),
		Order = getI18NValue(180121435),
		PieceIdList = {
			1800131,
			1800132,
			1800133,
			1800134
		},
		MemoryReward = {
			2,
			30,
			5018113,
			1
		}
	},
	[1800140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800130,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter14.mp4",
		Id = 1800140,
		Level = 14,
		SoulId = 20010018,
		Name = getI18NValue(180121438),
		Order = getI18NValue(180121437),
		PieceIdList = {
			1800141,
			1800142,
			1800143,
			1800144
		},
		MemoryReward = {
			2,
			30,
			5018114,
			1
		}
	},
	[1800150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800140,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter15.mp4",
		Id = 1800150,
		Level = 15,
		SoulId = 20010018,
		Name = getI18NValue(180121440),
		Order = getI18NValue(180121439),
		PieceIdList = {
			1800151,
			1800152,
			1800153,
			1800154
		},
		MemoryReward = {
			2,
			30,
			5018115,
			1
		}
	},
	[1800160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800150,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter16.mp4",
		Id = 1800160,
		Level = 16,
		SoulId = 20010018,
		Name = getI18NValue(180121442),
		Order = getI18NValue(180121441),
		PieceIdList = {
			1800161,
			1800162,
			1800163,
			1800164
		},
		MemoryReward = {
			2,
			30,
			5018116,
			1
		}
	},
	[1800170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800160,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter17.mp4",
		Id = 1800170,
		Level = 17,
		SoulId = 20010018,
		Name = getI18NValue(180121444),
		Order = getI18NValue(180121443),
		PieceIdList = {
			1800171,
			1800172,
			1800173,
			1800174
		},
		MemoryReward = {
			2,
			30,
			5018117,
			1
		}
	},
	[1800180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_SakuyaMako/SakuyaMako.png",
		PreMemoryChapter = 1800170,
		Movie = "/Memory/SakuyaMako/Memory_SakuyaMako_Chapter18.mp4",
		Id = 1800180,
		Level = 18,
		SoulId = 20010018,
		Name = getI18NValue(180121446),
		Order = getI18NValue(180121445),
		PieceIdList = {
			1800181,
			1800182,
			1800183,
			1800184
		},
		MemoryReward = {
			2,
			30,
			5018118,
			1
		}
	},
	[1900010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter01.mp4",
		Id = 1900010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010019,
		Name = getI18NValue(180121448),
		Order = getI18NValue(180121447),
		PieceIdList = {
			1900011,
			1900012,
			1900013,
			1900014
		},
		MemoryReward = {
			2,
			30,
			5019101,
			1
		}
	},
	[1900020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900010,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter02.mp4",
		Id = 1900020,
		Level = 2,
		SoulId = 20010019,
		Name = getI18NValue(180121450),
		Order = getI18NValue(180121449),
		PieceIdList = {
			1900021,
			1900022,
			1900023,
			1900024
		},
		MemoryReward = {
			2,
			30,
			5019102,
			1
		}
	},
	[1900030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900020,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter03.mp4",
		Id = 1900030,
		Level = 3,
		SoulId = 20010019,
		Name = getI18NValue(180121452),
		Order = getI18NValue(180121451),
		PieceIdList = {
			1900031,
			1900032,
			1900033,
			1900034
		},
		MemoryReward = {
			2,
			30,
			5019103,
			1
		}
	},
	[1900040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900030,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter04.mp4",
		Id = 1900040,
		Level = 4,
		SoulId = 20010019,
		Name = getI18NValue(180121454),
		Order = getI18NValue(180121453),
		PieceIdList = {
			1900041,
			1900042,
			1900043,
			1900044
		},
		MemoryReward = {
			2,
			30,
			5019104,
			1
		}
	},
	[1900050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900040,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter05.mp4",
		Id = 1900050,
		Level = 5,
		SoulId = 20010019,
		Name = getI18NValue(180121456),
		Order = getI18NValue(180121455),
		PieceIdList = {
			1900051,
			1900052,
			1900053,
			1900054
		},
		MemoryReward = {
			2,
			30,
			5019105,
			1
		}
	},
	[1900060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900050,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter06.mp4",
		Id = 1900060,
		Level = 6,
		SoulId = 20010019,
		Name = getI18NValue(180121458),
		Order = getI18NValue(180121457),
		PieceIdList = {
			1900061,
			1900062,
			1900063,
			1900064
		},
		MemoryReward = {
			2,
			30,
			5019106,
			1
		}
	},
	[1900070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900060,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter07.mp4",
		Id = 1900070,
		Level = 7,
		SoulId = 20010019,
		Name = getI18NValue(180121460),
		Order = getI18NValue(180121459),
		PieceIdList = {
			1900071,
			1900072,
			1900073,
			1900074
		},
		MemoryReward = {
			2,
			30,
			5019107,
			1
		}
	},
	[1900080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900070,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter08.mp4",
		Id = 1900080,
		Level = 8,
		SoulId = 20010019,
		Name = getI18NValue(180121462),
		Order = getI18NValue(180121461),
		PieceIdList = {
			1900081,
			1900082,
			1900083,
			1900084
		},
		MemoryReward = {
			2,
			30,
			5019108,
			1
		}
	},
	[1900090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900080,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter09.mp4",
		Id = 1900090,
		Level = 9,
		SoulId = 20010019,
		Name = getI18NValue(180121464),
		Order = getI18NValue(180121463),
		PieceIdList = {
			1900091,
			1900092,
			1900093,
			1900094
		},
		MemoryReward = {
			2,
			30,
			5019109,
			1
		}
	},
	[1900100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900090,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter10.mp4",
		Id = 1900100,
		Level = 10,
		SoulId = 20010019,
		Name = getI18NValue(180121466),
		Order = getI18NValue(180121465),
		PieceIdList = {
			1900101,
			1900102,
			1900103,
			1900104
		},
		MemoryReward = {
			2,
			30,
			5019110,
			1
		}
	},
	[1900110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900100,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter11.mp4",
		Id = 1900110,
		Level = 11,
		SoulId = 20010019,
		Name = getI18NValue(180121468),
		Order = getI18NValue(180121467),
		PieceIdList = {
			1900111,
			1900112,
			1900113,
			1900114
		},
		MemoryReward = {
			2,
			30,
			5019111,
			1
		}
	},
	[1900120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900110,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter12.mp4",
		Id = 1900120,
		Level = 12,
		SoulId = 20010019,
		Name = getI18NValue(180121470),
		Order = getI18NValue(180121469),
		PieceIdList = {
			1900121,
			1900122,
			1900123,
			1900124
		},
		MemoryReward = {
			2,
			30,
			5019112,
			1
		}
	},
	[1900130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900120,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter13.mp4",
		Id = 1900130,
		Level = 13,
		SoulId = 20010019,
		Name = getI18NValue(180121472),
		Order = getI18NValue(180121471),
		PieceIdList = {
			1900131,
			1900132,
			1900133,
			1900134
		},
		MemoryReward = {
			2,
			30,
			5019113,
			1
		}
	},
	[1900140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900130,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter14.mp4",
		Id = 1900140,
		Level = 14,
		SoulId = 20010019,
		Name = getI18NValue(180121474),
		Order = getI18NValue(180121473),
		PieceIdList = {
			1900141,
			1900142,
			1900143,
			1900144
		},
		MemoryReward = {
			2,
			30,
			5019114,
			1
		}
	},
	[1900150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900140,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter15.mp4",
		Id = 1900150,
		Level = 15,
		SoulId = 20010019,
		Name = getI18NValue(180121476),
		Order = getI18NValue(180121475),
		PieceIdList = {
			1900151,
			1900152,
			1900153,
			1900154
		},
		MemoryReward = {
			2,
			30,
			5019115,
			1
		}
	},
	[1900160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900150,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter16.mp4",
		Id = 1900160,
		Level = 16,
		SoulId = 20010019,
		Name = getI18NValue(180121478),
		Order = getI18NValue(180121477),
		PieceIdList = {
			1900161,
			1900162,
			1900163,
			1900164
		},
		MemoryReward = {
			2,
			30,
			5019116,
			1
		}
	},
	[1900170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900160,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter17.mp4",
		Id = 1900170,
		Level = 17,
		SoulId = 20010019,
		Name = getI18NValue(180121480),
		Order = getI18NValue(180121479),
		PieceIdList = {
			1900171,
			1900172,
			1900173,
			1900174
		},
		MemoryReward = {
			2,
			30,
			5019117,
			1
		}
	},
	[1900180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aurora/Aurora.png",
		PreMemoryChapter = 1900170,
		Movie = "/Memory/Aurora/Memory_Aurora_Chapter18.mp4",
		Id = 1900180,
		Level = 18,
		SoulId = 20010019,
		Name = getI18NValue(180121482),
		Order = getI18NValue(180121481),
		PieceIdList = {
			1900181,
			1900182,
			1900183,
			1900184
		},
		MemoryReward = {
			2,
			30,
			5019118,
			1
		}
	},
	[2000010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter01.mp4",
		Id = 2000010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010020,
		Name = getI18NValue(180121484),
		Order = getI18NValue(180121483),
		PieceIdList = {
			2000011,
			2000012,
			2000013,
			2000014
		},
		MemoryReward = {
			2,
			30,
			5020101,
			1
		}
	},
	[2000020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000010,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter02.mp4",
		Id = 2000020,
		Level = 2,
		SoulId = 20010020,
		Name = getI18NValue(180121486),
		Order = getI18NValue(180121485),
		PieceIdList = {
			2000021,
			2000022,
			2000023,
			2000024
		},
		MemoryReward = {
			2,
			30,
			5020102,
			1
		}
	},
	[2000030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000020,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter03.mp4",
		Id = 2000030,
		Level = 3,
		SoulId = 20010020,
		Name = getI18NValue(180121488),
		Order = getI18NValue(180121487),
		PieceIdList = {
			2000031,
			2000032,
			2000033,
			2000034
		},
		MemoryReward = {
			2,
			30,
			5020103,
			1
		}
	},
	[2000040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000030,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter04.mp4",
		Id = 2000040,
		Level = 4,
		SoulId = 20010020,
		Name = getI18NValue(180121490),
		Order = getI18NValue(180121489),
		PieceIdList = {
			2000041,
			2000042,
			2000043,
			2000044
		},
		MemoryReward = {
			2,
			30,
			5020104,
			1
		}
	},
	[2000050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000040,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter05.mp4",
		Id = 2000050,
		Level = 5,
		SoulId = 20010020,
		Name = getI18NValue(180121492),
		Order = getI18NValue(180121491),
		PieceIdList = {
			2000051,
			2000052,
			2000053,
			2000054
		},
		MemoryReward = {
			2,
			30,
			5020105,
			1
		}
	},
	[2000060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000050,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter06.mp4",
		Id = 2000060,
		Level = 6,
		SoulId = 20010020,
		Name = getI18NValue(180121494),
		Order = getI18NValue(180121493),
		PieceIdList = {
			2000061,
			2000062,
			2000063,
			2000064
		},
		MemoryReward = {
			2,
			30,
			5020106,
			1
		}
	},
	[2000070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000060,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter07.mp4",
		Id = 2000070,
		Level = 7,
		SoulId = 20010020,
		Name = getI18NValue(180121496),
		Order = getI18NValue(180121495),
		PieceIdList = {
			2000071,
			2000072,
			2000073,
			2000074
		},
		MemoryReward = {
			2,
			30,
			5020107,
			1
		}
	},
	[2000080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000070,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter08.mp4",
		Id = 2000080,
		Level = 8,
		SoulId = 20010020,
		Name = getI18NValue(180121498),
		Order = getI18NValue(180121497),
		PieceIdList = {
			2000081,
			2000082,
			2000083,
			2000084
		},
		MemoryReward = {
			2,
			30,
			5020108,
			1
		}
	},
	[2000090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000080,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter09.mp4",
		Id = 2000090,
		Level = 9,
		SoulId = 20010020,
		Name = getI18NValue(180121500),
		Order = getI18NValue(180121499),
		PieceIdList = {
			2000091,
			2000092,
			2000093,
			2000094
		},
		MemoryReward = {
			2,
			30,
			5020109,
			1
		}
	},
	[2000100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000090,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter10.mp4",
		Id = 2000100,
		Level = 10,
		SoulId = 20010020,
		Name = getI18NValue(180121502),
		Order = getI18NValue(180121501),
		PieceIdList = {
			2000101,
			2000102,
			2000103,
			2000104
		},
		MemoryReward = {
			2,
			30,
			5020110,
			1
		}
	},
	[2000110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000100,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter11.mp4",
		Id = 2000110,
		Level = 11,
		SoulId = 20010020,
		Name = getI18NValue(180121504),
		Order = getI18NValue(180121503),
		PieceIdList = {
			2000111,
			2000112,
			2000113,
			2000114
		},
		MemoryReward = {
			2,
			30,
			5020111,
			1
		}
	},
	[2000120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000110,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter12.mp4",
		Id = 2000120,
		Level = 12,
		SoulId = 20010020,
		Name = getI18NValue(180121506),
		Order = getI18NValue(180121505),
		PieceIdList = {
			2000121,
			2000122,
			2000123,
			2000124
		},
		MemoryReward = {
			2,
			30,
			5020112,
			1
		}
	},
	[2000130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000120,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter13.mp4",
		Id = 2000130,
		Level = 13,
		SoulId = 20010020,
		Name = getI18NValue(180121508),
		Order = getI18NValue(180121507),
		PieceIdList = {
			2000131,
			2000132,
			2000133,
			2000134
		},
		MemoryReward = {
			2,
			30,
			5020113,
			1
		}
	},
	[2000140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000130,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter14.mp4",
		Id = 2000140,
		Level = 14,
		SoulId = 20010020,
		Name = getI18NValue(180121510),
		Order = getI18NValue(180121509),
		PieceIdList = {
			2000141,
			2000142,
			2000143,
			2000144
		},
		MemoryReward = {
			2,
			30,
			5020114,
			1
		}
	},
	[2000150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000140,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter15.mp4",
		Id = 2000150,
		Level = 15,
		SoulId = 20010020,
		Name = getI18NValue(180121512),
		Order = getI18NValue(180121511),
		PieceIdList = {
			2000151,
			2000152,
			2000153,
			2000154
		},
		MemoryReward = {
			2,
			30,
			5020115,
			1
		}
	},
	[2000160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000150,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter16.mp4",
		Id = 2000160,
		Level = 16,
		SoulId = 20010020,
		Name = getI18NValue(180121514),
		Order = getI18NValue(180121513),
		PieceIdList = {
			2000161,
			2000162,
			2000163,
			2000164
		},
		MemoryReward = {
			2,
			30,
			5020116,
			1
		}
	},
	[2000170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000160,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter17.mp4",
		Id = 2000170,
		Level = 17,
		SoulId = 20010020,
		Name = getI18NValue(180121516),
		Order = getI18NValue(180121515),
		PieceIdList = {
			2000171,
			2000172,
			2000173,
			2000174
		},
		MemoryReward = {
			2,
			30,
			5020117,
			1
		}
	},
	[2000180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ennis/Ennis.png",
		PreMemoryChapter = 2000170,
		Movie = "/Memory/Ennis/Memory_Ennis_Chapter18.mp4",
		Id = 2000180,
		Level = 18,
		SoulId = 20010020,
		Name = getI18NValue(180121518),
		Order = getI18NValue(180121517),
		PieceIdList = {
			2000181,
			2000182,
			2000183,
			2000184
		},
		MemoryReward = {
			2,
			30,
			5020118,
			1
		}
	},
	[2100010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter01.mp4",
		Id = 2100010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010021,
		Name = getI18NValue(180121520),
		Order = getI18NValue(180121519),
		PieceIdList = {
			2100011,
			2100012,
			2100013,
			2100014
		},
		MemoryReward = {
			2,
			30,
			5021101,
			1
		}
	},
	[2100020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100010,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter02.mp4",
		Id = 2100020,
		Level = 2,
		SoulId = 20010021,
		Name = getI18NValue(180121522),
		Order = getI18NValue(180121521),
		PieceIdList = {
			2100021,
			2100022,
			2100023,
			2100024
		},
		MemoryReward = {
			2,
			30,
			5021102,
			1
		}
	},
	[2100030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100020,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter03.mp4",
		Id = 2100030,
		Level = 3,
		SoulId = 20010021,
		Name = getI18NValue(180121524),
		Order = getI18NValue(180121523),
		PieceIdList = {
			2100031,
			2100032,
			2100033,
			2100034
		},
		MemoryReward = {
			2,
			30,
			5021103,
			1
		}
	},
	[2100040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100030,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter04.mp4",
		Id = 2100040,
		Level = 4,
		SoulId = 20010021,
		Name = getI18NValue(180121526),
		Order = getI18NValue(180121525),
		PieceIdList = {
			2100041,
			2100042,
			2100043,
			2100044
		},
		MemoryReward = {
			2,
			30,
			5021104,
			1
		}
	},
	[2100050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100040,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter05.mp4",
		Id = 2100050,
		Level = 5,
		SoulId = 20010021,
		Name = getI18NValue(180121528),
		Order = getI18NValue(180121527),
		PieceIdList = {
			2100051,
			2100052,
			2100053,
			2100054
		},
		MemoryReward = {
			2,
			30,
			5021105,
			1
		}
	},
	[2100060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100050,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter06.mp4",
		Id = 2100060,
		Level = 6,
		SoulId = 20010021,
		Name = getI18NValue(180121530),
		Order = getI18NValue(180121529),
		PieceIdList = {
			2100061,
			2100062,
			2100063,
			2100064
		},
		MemoryReward = {
			2,
			30,
			5021106,
			1
		}
	},
	[2100070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100060,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter07.mp4",
		Id = 2100070,
		Level = 7,
		SoulId = 20010021,
		Name = getI18NValue(180121532),
		Order = getI18NValue(180121531),
		PieceIdList = {
			2100071,
			2100072,
			2100073,
			2100074
		},
		MemoryReward = {
			2,
			30,
			5021107,
			1
		}
	},
	[2100080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100070,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter08.mp4",
		Id = 2100080,
		Level = 8,
		SoulId = 20010021,
		Name = getI18NValue(180121534),
		Order = getI18NValue(180121533),
		PieceIdList = {
			2100081,
			2100082,
			2100083,
			2100084
		},
		MemoryReward = {
			2,
			30,
			5021108,
			1
		}
	},
	[2100090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100080,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter09.mp4",
		Id = 2100090,
		Level = 9,
		SoulId = 20010021,
		Name = getI18NValue(180121536),
		Order = getI18NValue(180121535),
		PieceIdList = {
			2100091,
			2100092,
			2100093,
			2100094
		},
		MemoryReward = {
			2,
			30,
			5021109,
			1
		}
	},
	[2100100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100090,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter10.mp4",
		Id = 2100100,
		Level = 10,
		SoulId = 20010021,
		Name = getI18NValue(180121538),
		Order = getI18NValue(180121537),
		PieceIdList = {
			2100101,
			2100102,
			2100103,
			2100104
		},
		MemoryReward = {
			2,
			30,
			5021110,
			1
		}
	},
	[2100110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100100,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter11.mp4",
		Id = 2100110,
		Level = 11,
		SoulId = 20010021,
		Name = getI18NValue(180121540),
		Order = getI18NValue(180121539),
		PieceIdList = {
			2100111,
			2100112,
			2100113,
			2100114
		},
		MemoryReward = {
			2,
			30,
			5021111,
			1
		}
	},
	[2100120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100110,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter12.mp4",
		Id = 2100120,
		Level = 12,
		SoulId = 20010021,
		Name = getI18NValue(180121542),
		Order = getI18NValue(180121541),
		PieceIdList = {
			2100121,
			2100122,
			2100123,
			2100124
		},
		MemoryReward = {
			2,
			30,
			5021112,
			1
		}
	},
	[2100130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100120,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter13.mp4",
		Id = 2100130,
		Level = 13,
		SoulId = 20010021,
		Name = getI18NValue(180121544),
		Order = getI18NValue(180121543),
		PieceIdList = {
			2100131,
			2100132,
			2100133,
			2100134
		},
		MemoryReward = {
			2,
			30,
			5021113,
			1
		}
	},
	[2100140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100130,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter14.mp4",
		Id = 2100140,
		Level = 14,
		SoulId = 20010021,
		Name = getI18NValue(180121546),
		Order = getI18NValue(180121545),
		PieceIdList = {
			2100141,
			2100142,
			2100143,
			2100144
		},
		MemoryReward = {
			2,
			30,
			5021114,
			1
		}
	},
	[2100150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100140,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter15.mp4",
		Id = 2100150,
		Level = 15,
		SoulId = 20010021,
		Name = getI18NValue(180121548),
		Order = getI18NValue(180121547),
		PieceIdList = {
			2100151,
			2100152,
			2100153,
			2100154
		},
		MemoryReward = {
			2,
			30,
			5021115,
			1
		}
	},
	[2100160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100150,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter16.mp4",
		Id = 2100160,
		Level = 16,
		SoulId = 20010021,
		Name = getI18NValue(180121550),
		Order = getI18NValue(180121549),
		PieceIdList = {
			2100161,
			2100162,
			2100163,
			2100164
		},
		MemoryReward = {
			2,
			30,
			5021116,
			1
		}
	},
	[2100170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100160,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter17.mp4",
		Id = 2100170,
		Level = 17,
		SoulId = 20010021,
		Name = getI18NValue(180121552),
		Order = getI18NValue(180121551),
		PieceIdList = {
			2100171,
			2100172,
			2100173,
			2100174
		},
		MemoryReward = {
			2,
			30,
			5021117,
			1
		}
	},
	[2100180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_HazukiYuki_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HazukiYuki/HazukiYuki.png",
		PreMemoryChapter = 2100170,
		Movie = "/Memory/HazukiYuki/Memory_HazukiYuki_Chapter18.mp4",
		Id = 2100180,
		Level = 18,
		SoulId = 20010021,
		Name = getI18NValue(180121554),
		Order = getI18NValue(180121553),
		PieceIdList = {
			2100181,
			2100182,
			2100183,
			2100184
		},
		MemoryReward = {
			2,
			30,
			5021118,
			1
		}
	},
	[2200010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter01.mp4",
		Id = 2200010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010022,
		Name = getI18NValue(180121556),
		Order = getI18NValue(180121555),
		PieceIdList = {
			2200011,
			2200012,
			2200013,
			2200014
		},
		MemoryReward = {
			2,
			30,
			5022101,
			1
		}
	},
	[2200020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200010,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter02.mp4",
		Id = 2200020,
		Level = 2,
		SoulId = 20010022,
		Name = getI18NValue(180121558),
		Order = getI18NValue(180121557),
		PieceIdList = {
			2200021,
			2200022,
			2200023,
			2200024
		},
		MemoryReward = {
			2,
			30,
			5022102,
			1
		}
	},
	[2200030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200020,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter03.mp4",
		Id = 2200030,
		Level = 3,
		SoulId = 20010022,
		Name = getI18NValue(180121560),
		Order = getI18NValue(180121559),
		PieceIdList = {
			2200031,
			2200032,
			2200033,
			2200034
		},
		MemoryReward = {
			2,
			30,
			5022103,
			1
		}
	},
	[2200040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200030,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter04.mp4",
		Id = 2200040,
		Level = 4,
		SoulId = 20010022,
		Name = getI18NValue(180121562),
		Order = getI18NValue(180121561),
		PieceIdList = {
			2200041,
			2200042,
			2200043,
			2200044
		},
		MemoryReward = {
			2,
			30,
			5022104,
			1
		}
	},
	[2200050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200040,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter05.mp4",
		Id = 2200050,
		Level = 5,
		SoulId = 20010022,
		Name = getI18NValue(180121564),
		Order = getI18NValue(180121563),
		PieceIdList = {
			2200051,
			2200052,
			2200053,
			2200054
		},
		MemoryReward = {
			2,
			30,
			5022105,
			1
		}
	},
	[2200060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200050,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter06.mp4",
		Id = 2200060,
		Level = 6,
		SoulId = 20010022,
		Name = getI18NValue(180121566),
		Order = getI18NValue(180121565),
		PieceIdList = {
			2200061,
			2200062,
			2200063,
			2200064
		},
		MemoryReward = {
			2,
			30,
			5022106,
			1
		}
	},
	[2200070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200060,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter07.mp4",
		Id = 2200070,
		Level = 7,
		SoulId = 20010022,
		Name = getI18NValue(180121568),
		Order = getI18NValue(180121567),
		PieceIdList = {
			2200071,
			2200072,
			2200073,
			2200074
		},
		MemoryReward = {
			2,
			30,
			5022107,
			1
		}
	},
	[2200080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200070,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter08.mp4",
		Id = 2200080,
		Level = 8,
		SoulId = 20010022,
		Name = getI18NValue(180121570),
		Order = getI18NValue(180121569),
		PieceIdList = {
			2200081,
			2200082,
			2200083,
			2200084
		},
		MemoryReward = {
			2,
			30,
			5022108,
			1
		}
	},
	[2200090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200080,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter09.mp4",
		Id = 2200090,
		Level = 9,
		SoulId = 20010022,
		Name = getI18NValue(180121572),
		Order = getI18NValue(180121571),
		PieceIdList = {
			2200091,
			2200092,
			2200093,
			2200094
		},
		MemoryReward = {
			2,
			30,
			5022109,
			1
		}
	},
	[2200100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200090,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter10.mp4",
		Id = 2200100,
		Level = 10,
		SoulId = 20010022,
		Name = getI18NValue(180121574),
		Order = getI18NValue(180121573),
		PieceIdList = {
			2200101,
			2200102,
			2200103,
			2200104
		},
		MemoryReward = {
			2,
			30,
			5022110,
			1
		}
	},
	[2200110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200100,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter11.mp4",
		Id = 2200110,
		Level = 11,
		SoulId = 20010022,
		Name = getI18NValue(180121576),
		Order = getI18NValue(180121575),
		PieceIdList = {
			2200111,
			2200112,
			2200113,
			2200114
		},
		MemoryReward = {
			2,
			30,
			5022111,
			1
		}
	},
	[2200120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200110,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter12.mp4",
		Id = 2200120,
		Level = 12,
		SoulId = 20010022,
		Name = getI18NValue(180121578),
		Order = getI18NValue(180121577),
		PieceIdList = {
			2200121,
			2200122,
			2200123,
			2200124
		},
		MemoryReward = {
			2,
			30,
			5022112,
			1
		}
	},
	[2200130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200120,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter13.mp4",
		Id = 2200130,
		Level = 13,
		SoulId = 20010022,
		Name = getI18NValue(180121580),
		Order = getI18NValue(180121579),
		PieceIdList = {
			2200131,
			2200132,
			2200133,
			2200134
		},
		MemoryReward = {
			2,
			30,
			5022113,
			1
		}
	},
	[2200140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200130,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter14.mp4",
		Id = 2200140,
		Level = 14,
		SoulId = 20010022,
		Name = getI18NValue(180121582),
		Order = getI18NValue(180121581),
		PieceIdList = {
			2200141,
			2200142,
			2200143,
			2200144
		},
		MemoryReward = {
			2,
			30,
			5022114,
			1
		}
	},
	[2200150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200140,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter15.mp4",
		Id = 2200150,
		Level = 15,
		SoulId = 20010022,
		Name = getI18NValue(180121584),
		Order = getI18NValue(180121583),
		PieceIdList = {
			2200151,
			2200152,
			2200153,
			2200154
		},
		MemoryReward = {
			2,
			30,
			5022115,
			1
		}
	},
	[2200160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200150,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter16.mp4",
		Id = 2200160,
		Level = 16,
		SoulId = 20010022,
		Name = getI18NValue(180121586),
		Order = getI18NValue(180121585),
		PieceIdList = {
			2200161,
			2200162,
			2200163,
			2200164
		},
		MemoryReward = {
			2,
			30,
			5022116,
			1
		}
	},
	[2200170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200160,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter17.mp4",
		Id = 2200170,
		Level = 17,
		SoulId = 20010022,
		Name = getI18NValue(180121588),
		Order = getI18NValue(180121587),
		PieceIdList = {
			2200171,
			2200172,
			2200173,
			2200174
		},
		MemoryReward = {
			2,
			30,
			5022117,
			1
		}
	},
	[2200180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2200170,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter18.mp4",
		Id = 2200180,
		Level = 18,
		SoulId = 20010022,
		Name = getI18NValue(180121590),
		Order = getI18NValue(180121589),
		PieceIdList = {
			2200181,
			2200182,
			2200183,
			2200184
		},
		MemoryReward = {
			2,
			30,
			5022118,
			1
		}
	},
	[2300010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter01.mp4",
		Id = 2300010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010023,
		Name = getI18NValue(180139369),
		Order = getI18NValue(180139368),
		PieceIdList = {
			2300011,
			2300012,
			2300013,
			2300014
		},
		MemoryReward = {
			2,
			30,
			5023101,
			1
		}
	},
	[2300020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300010,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter02.mp4",
		Id = 2300020,
		Level = 2,
		SoulId = 20010023,
		Name = getI18NValue(180139371),
		Order = getI18NValue(180139370),
		PieceIdList = {
			2300021,
			2300022,
			2300023,
			2300024
		},
		MemoryReward = {
			2,
			30,
			5023102,
			1
		}
	},
	[2300030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300020,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter03.mp4",
		Id = 2300030,
		Level = 3,
		SoulId = 20010023,
		Name = getI18NValue(180139373),
		Order = getI18NValue(180139372),
		PieceIdList = {
			2300031,
			2300032,
			2300033,
			2300034
		},
		MemoryReward = {
			2,
			30,
			5023103,
			1
		}
	},
	[2300040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300030,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter04.mp4",
		Id = 2300040,
		Level = 4,
		SoulId = 20010023,
		Name = getI18NValue(180139375),
		Order = getI18NValue(180139374),
		PieceIdList = {
			2300041,
			2300042,
			2300043,
			2300044
		},
		MemoryReward = {
			2,
			30,
			5023104,
			1
		}
	},
	[2300050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300040,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter05.mp4",
		Id = 2300050,
		Level = 5,
		SoulId = 20010023,
		Name = getI18NValue(180139377),
		Order = getI18NValue(180139376),
		PieceIdList = {
			2300051,
			2300052,
			2300053,
			2300054
		},
		MemoryReward = {
			2,
			30,
			5023105,
			1
		}
	},
	[2300060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300050,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter06.mp4",
		Id = 2300060,
		Level = 6,
		SoulId = 20010023,
		Name = getI18NValue(180139379),
		Order = getI18NValue(180139378),
		PieceIdList = {
			2300061,
			2300062,
			2300063,
			2300064
		},
		MemoryReward = {
			2,
			30,
			5023106,
			1
		}
	},
	[2300070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300060,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter07.mp4",
		Id = 2300070,
		Level = 7,
		SoulId = 20010023,
		Name = getI18NValue(180139381),
		Order = getI18NValue(180139380),
		PieceIdList = {
			2300071,
			2300072,
			2300073,
			2300074
		},
		MemoryReward = {
			2,
			30,
			5023107,
			1
		}
	},
	[2300080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300070,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter08.mp4",
		Id = 2300080,
		Level = 8,
		SoulId = 20010023,
		Name = getI18NValue(180139383),
		Order = getI18NValue(180139382),
		PieceIdList = {
			2300081,
			2300082,
			2300083,
			2300084
		},
		MemoryReward = {
			2,
			30,
			5023108,
			1
		}
	},
	[2300090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300080,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter09.mp4",
		Id = 2300090,
		Level = 9,
		SoulId = 20010023,
		Name = getI18NValue(180139385),
		Order = getI18NValue(180139384),
		PieceIdList = {
			2300091,
			2300092,
			2300093,
			2300094
		},
		MemoryReward = {
			2,
			30,
			5023109,
			1
		}
	},
	[2300100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300090,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter10.mp4",
		Id = 2300100,
		Level = 10,
		SoulId = 20010023,
		Name = getI18NValue(180139387),
		Order = getI18NValue(180139386),
		PieceIdList = {
			2300101,
			2300102,
			2300103,
			2300104
		},
		MemoryReward = {
			2,
			30,
			5023110,
			1
		}
	},
	[2300110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300100,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter11.mp4",
		Id = 2300110,
		Level = 11,
		SoulId = 20010023,
		Name = getI18NValue(180139389),
		Order = getI18NValue(180139388),
		PieceIdList = {
			2300111,
			2300112,
			2300113,
			2300114
		},
		MemoryReward = {
			2,
			30,
			5023111,
			1
		}
	},
	[2300120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300110,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter12.mp4",
		Id = 2300120,
		Level = 12,
		SoulId = 20010023,
		Name = getI18NValue(180139391),
		Order = getI18NValue(180139390),
		PieceIdList = {
			2300121,
			2300122,
			2300123,
			2300124
		},
		MemoryReward = {
			2,
			30,
			5023112,
			1
		}
	},
	[2300130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300120,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter13.mp4",
		Id = 2300130,
		Level = 13,
		SoulId = 20010023,
		Name = getI18NValue(180139393),
		Order = getI18NValue(180139392),
		PieceIdList = {
			2300131,
			2300132,
			2300133,
			2300134
		},
		MemoryReward = {
			2,
			30,
			5023113,
			1
		}
	},
	[2300140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300130,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter14.mp4",
		Id = 2300140,
		Level = 14,
		SoulId = 20010023,
		Name = getI18NValue(180139395),
		Order = getI18NValue(180139394),
		PieceIdList = {
			2300141,
			2300142,
			2300143,
			2300144
		},
		MemoryReward = {
			2,
			30,
			5023114,
			1
		}
	},
	[2300150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300140,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter15.mp4",
		Id = 2300150,
		Level = 15,
		SoulId = 20010023,
		Name = getI18NValue(180139397),
		Order = getI18NValue(180139396),
		PieceIdList = {
			2300151,
			2300152,
			2300153,
			2300154
		},
		MemoryReward = {
			2,
			30,
			5023115,
			1
		}
	},
	[2300160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300150,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter16.mp4",
		Id = 2300160,
		Level = 16,
		SoulId = 20010023,
		Name = getI18NValue(180139399),
		Order = getI18NValue(180139398),
		PieceIdList = {
			2300161,
			2300162,
			2300163,
			2300164
		},
		MemoryReward = {
			2,
			30,
			5023116,
			1
		}
	},
	[2300170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300160,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter17.mp4",
		Id = 2300170,
		Level = 17,
		SoulId = 20010023,
		Name = getI18NValue(180139401),
		Order = getI18NValue(180139400),
		PieceIdList = {
			2300171,
			2300172,
			2300173,
			2300174
		},
		MemoryReward = {
			2,
			30,
			5023117,
			1
		}
	},
	[2300180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QuLing/QuLing.png",
		PreMemoryChapter = 2300170,
		Movie = "/Memory/QuLing/Memory_QuLing_Chapter18.mp4",
		Id = 2300180,
		Level = 18,
		SoulId = 20010023,
		Name = getI18NValue(180139403),
		Order = getI18NValue(180139402),
		PieceIdList = {
			2300181,
			2300182,
			2300183,
			2300184
		},
		MemoryReward = {
			2,
			30,
			5023118,
			1
		}
	},
	[2400010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter01.mp4",
		Id = 2400010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010024,
		Name = getI18NValue(180139405),
		Order = getI18NValue(180139404),
		PieceIdList = {
			2400011,
			2400012,
			2400013,
			2400014
		},
		MemoryReward = {
			2,
			30,
			5024101,
			1
		}
	},
	[2400020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400010,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter02.mp4",
		Id = 2400020,
		Level = 2,
		SoulId = 20010024,
		Name = getI18NValue(180139407),
		Order = getI18NValue(180139406),
		PieceIdList = {
			2400021,
			2400022,
			2400023,
			2400024
		},
		MemoryReward = {
			2,
			30,
			5024102,
			1
		}
	},
	[2400030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400020,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter03.mp4",
		Id = 2400030,
		Level = 3,
		SoulId = 20010024,
		Name = getI18NValue(180139409),
		Order = getI18NValue(180139408),
		PieceIdList = {
			2400031,
			2400032,
			2400033,
			2400034
		},
		MemoryReward = {
			2,
			30,
			5024103,
			1
		}
	},
	[2400040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400030,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter04.mp4",
		Id = 2400040,
		Level = 4,
		SoulId = 20010024,
		Name = getI18NValue(180139411),
		Order = getI18NValue(180139410),
		PieceIdList = {
			2400041,
			2400042,
			2400043,
			2400044
		},
		MemoryReward = {
			2,
			30,
			5024104,
			1
		}
	},
	[2400050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400040,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter05.mp4",
		Id = 2400050,
		Level = 5,
		SoulId = 20010024,
		Name = getI18NValue(180139413),
		Order = getI18NValue(180139412),
		PieceIdList = {
			2400051,
			2400052,
			2400053,
			2400054
		},
		MemoryReward = {
			2,
			30,
			5024105,
			1
		}
	},
	[2400060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400050,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter06.mp4",
		Id = 2400060,
		Level = 6,
		SoulId = 20010024,
		Name = getI18NValue(180139415),
		Order = getI18NValue(180139414),
		PieceIdList = {
			2400061,
			2400062,
			2400063,
			2400064
		},
		MemoryReward = {
			2,
			30,
			5024106,
			1
		}
	},
	[2400070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400060,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter07.mp4",
		Id = 2400070,
		Level = 7,
		SoulId = 20010024,
		Name = getI18NValue(180139417),
		Order = getI18NValue(180139416),
		PieceIdList = {
			2400071,
			2400072,
			2400073,
			2400074
		},
		MemoryReward = {
			2,
			30,
			5024107,
			1
		}
	},
	[2400080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400070,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter08.mp4",
		Id = 2400080,
		Level = 8,
		SoulId = 20010024,
		Name = getI18NValue(180139419),
		Order = getI18NValue(180139418),
		PieceIdList = {
			2400081,
			2400082,
			2400083,
			2400084
		},
		MemoryReward = {
			2,
			30,
			5024108,
			1
		}
	},
	[2400090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400080,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter09.mp4",
		Id = 2400090,
		Level = 9,
		SoulId = 20010024,
		Name = getI18NValue(180139421),
		Order = getI18NValue(180139420),
		PieceIdList = {
			2400091,
			2400092,
			2400093,
			2400094
		},
		MemoryReward = {
			2,
			30,
			5024109,
			1
		}
	},
	[2400100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400090,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter10.mp4",
		Id = 2400100,
		Level = 10,
		SoulId = 20010024,
		Name = getI18NValue(180139423),
		Order = getI18NValue(180139422),
		PieceIdList = {
			2400101,
			2400102,
			2400103,
			2400104
		},
		MemoryReward = {
			2,
			30,
			5024110,
			1
		}
	},
	[2400110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400100,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter11.mp4",
		Id = 2400110,
		Level = 11,
		SoulId = 20010024,
		Name = getI18NValue(180139425),
		Order = getI18NValue(180139424),
		PieceIdList = {
			2400111,
			2400112,
			2400113,
			2400114
		},
		MemoryReward = {
			2,
			30,
			5024111,
			1
		}
	},
	[2400120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400110,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter12.mp4",
		Id = 2400120,
		Level = 12,
		SoulId = 20010024,
		Name = getI18NValue(180139427),
		Order = getI18NValue(180139426),
		PieceIdList = {
			2400121,
			2400122,
			2400123,
			2400124
		},
		MemoryReward = {
			2,
			30,
			5024112,
			1
		}
	},
	[2400130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400120,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter13.mp4",
		Id = 2400130,
		Level = 13,
		SoulId = 20010024,
		Name = getI18NValue(180139429),
		Order = getI18NValue(180139428),
		PieceIdList = {
			2400131,
			2400132,
			2400133,
			2400134
		},
		MemoryReward = {
			2,
			30,
			5024113,
			1
		}
	},
	[2400140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400130,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter14.mp4",
		Id = 2400140,
		Level = 14,
		SoulId = 20010024,
		Name = getI18NValue(180139431),
		Order = getI18NValue(180139430),
		PieceIdList = {
			2400141,
			2400142,
			2400143,
			2400144
		},
		MemoryReward = {
			2,
			30,
			5024114,
			1
		}
	},
	[2400150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400140,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter15.mp4",
		Id = 2400150,
		Level = 15,
		SoulId = 20010024,
		Name = getI18NValue(180139433),
		Order = getI18NValue(180139432),
		PieceIdList = {
			2400151,
			2400152,
			2400153,
			2400154
		},
		MemoryReward = {
			2,
			30,
			5024115,
			1
		}
	},
	[2400160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400150,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter16.mp4",
		Id = 2400160,
		Level = 16,
		SoulId = 20010024,
		Name = getI18NValue(180139435),
		Order = getI18NValue(180139434),
		PieceIdList = {
			2400161,
			2400162,
			2400163,
			2400164
		},
		MemoryReward = {
			2,
			30,
			5024116,
			1
		}
	},
	[2400170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400160,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter17.mp4",
		Id = 2400170,
		Level = 17,
		SoulId = 20010024,
		Name = getI18NValue(180139437),
		Order = getI18NValue(180139436),
		PieceIdList = {
			2400171,
			2400172,
			2400173,
			2400174
		},
		MemoryReward = {
			2,
			30,
			5024117,
			1
		}
	},
	[2400180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_AmaneInori/AmaneInori.png",
		PreMemoryChapter = 2400170,
		Movie = "/Memory/AmaneInori/Memory_AmaneInori_Chapter18.mp4",
		Id = 2400180,
		Level = 18,
		SoulId = 20010024,
		Name = getI18NValue(180139439),
		Order = getI18NValue(180139438),
		PieceIdList = {
			2400181,
			2400182,
			2400183,
			2400184
		},
		MemoryReward = {
			2,
			30,
			5024118,
			1
		}
	},
	[2500010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter01.mp4",
		Id = 2500010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010025,
		Name = getI18NValue(180139441),
		Order = getI18NValue(180139440),
		PieceIdList = {
			2500011,
			2500012,
			2500013,
			2500014
		},
		MemoryReward = {
			2,
			30,
			5025101,
			1
		}
	},
	[2500020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500010,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter02.mp4",
		Id = 2500020,
		Level = 2,
		SoulId = 20010025,
		Name = getI18NValue(180139443),
		Order = getI18NValue(180139442),
		PieceIdList = {
			2500021,
			2500022,
			2500023,
			2500024
		},
		MemoryReward = {
			2,
			30,
			5025102,
			1
		}
	},
	[2500030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500020,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter03.mp4",
		Id = 2500030,
		Level = 3,
		SoulId = 20010025,
		Name = getI18NValue(180139445),
		Order = getI18NValue(180139444),
		PieceIdList = {
			2500031,
			2500032,
			2500033,
			2500034
		},
		MemoryReward = {
			2,
			30,
			5025103,
			1
		}
	},
	[2500040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500030,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter04.mp4",
		Id = 2500040,
		Level = 4,
		SoulId = 20010025,
		Name = getI18NValue(180139447),
		Order = getI18NValue(180139446),
		PieceIdList = {
			2500041,
			2500042,
			2500043,
			2500044
		},
		MemoryReward = {
			2,
			30,
			5025104,
			1
		}
	},
	[2500050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500040,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter05.mp4",
		Id = 2500050,
		Level = 5,
		SoulId = 20010025,
		Name = getI18NValue(180139449),
		Order = getI18NValue(180139448),
		PieceIdList = {
			2500051,
			2500052,
			2500053,
			2500054
		},
		MemoryReward = {
			2,
			30,
			5025105,
			1
		}
	},
	[2500060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500050,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter06.mp4",
		Id = 2500060,
		Level = 6,
		SoulId = 20010025,
		Name = getI18NValue(180139451),
		Order = getI18NValue(180139450),
		PieceIdList = {
			2500061,
			2500062,
			2500063,
			2500064
		},
		MemoryReward = {
			2,
			30,
			5025106,
			1
		}
	},
	[2500070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500060,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter07.mp4",
		Id = 2500070,
		Level = 7,
		SoulId = 20010025,
		Name = getI18NValue(180139453),
		Order = getI18NValue(180139452),
		PieceIdList = {
			2500071,
			2500072,
			2500073,
			2500074
		},
		MemoryReward = {
			2,
			30,
			5025107,
			1
		}
	},
	[2500080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500070,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter08.mp4",
		Id = 2500080,
		Level = 8,
		SoulId = 20010025,
		Name = getI18NValue(180139455),
		Order = getI18NValue(180139454),
		PieceIdList = {
			2500081,
			2500082,
			2500083,
			2500084
		},
		MemoryReward = {
			2,
			30,
			5025108,
			1
		}
	},
	[2500090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500080,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter09.mp4",
		Id = 2500090,
		Level = 9,
		SoulId = 20010025,
		Name = getI18NValue(180139457),
		Order = getI18NValue(180139456),
		PieceIdList = {
			2500091,
			2500092,
			2500093,
			2500094
		},
		MemoryReward = {
			2,
			30,
			5025109,
			1
		}
	},
	[2500100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500090,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter10.mp4",
		Id = 2500100,
		Level = 10,
		SoulId = 20010025,
		Name = getI18NValue(180139459),
		Order = getI18NValue(180139458),
		PieceIdList = {
			2500101,
			2500102,
			2500103,
			2500104
		},
		MemoryReward = {
			2,
			30,
			5025110,
			1
		}
	},
	[2500110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500100,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter11.mp4",
		Id = 2500110,
		Level = 11,
		SoulId = 20010025,
		Name = getI18NValue(180139461),
		Order = getI18NValue(180139460),
		PieceIdList = {
			2500111,
			2500112,
			2500113,
			2500114
		},
		MemoryReward = {
			2,
			30,
			5025111,
			1
		}
	},
	[2500120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500110,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter12.mp4",
		Id = 2500120,
		Level = 12,
		SoulId = 20010025,
		Name = getI18NValue(180139463),
		Order = getI18NValue(180139462),
		PieceIdList = {
			2500121,
			2500122,
			2500123,
			2500124
		},
		MemoryReward = {
			2,
			30,
			5025112,
			1
		}
	},
	[2500130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500120,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter13.mp4",
		Id = 2500130,
		Level = 13,
		SoulId = 20010025,
		Name = getI18NValue(180139465),
		Order = getI18NValue(180139464),
		PieceIdList = {
			2500131,
			2500132,
			2500133,
			2500134
		},
		MemoryReward = {
			2,
			30,
			5025113,
			1
		}
	},
	[2500140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500130,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter14.mp4",
		Id = 2500140,
		Level = 14,
		SoulId = 20010025,
		Name = getI18NValue(180139467),
		Order = getI18NValue(180139466),
		PieceIdList = {
			2500141,
			2500142,
			2500143,
			2500144
		},
		MemoryReward = {
			2,
			30,
			5025114,
			1
		}
	},
	[2500150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500140,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter15.mp4",
		Id = 2500150,
		Level = 15,
		SoulId = 20010025,
		Name = getI18NValue(180139469),
		Order = getI18NValue(180139468),
		PieceIdList = {
			2500151,
			2500152,
			2500153,
			2500154
		},
		MemoryReward = {
			2,
			30,
			5025115,
			1
		}
	},
	[2500160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500150,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter16.mp4",
		Id = 2500160,
		Level = 16,
		SoulId = 20010025,
		Name = getI18NValue(180139471),
		Order = getI18NValue(180139470),
		PieceIdList = {
			2500161,
			2500162,
			2500163,
			2500164
		},
		MemoryReward = {
			2,
			30,
			5025116,
			1
		}
	},
	[2500170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500160,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter17.mp4",
		Id = 2500170,
		Level = 17,
		SoulId = 20010025,
		Name = getI18NValue(180139473),
		Order = getI18NValue(180139472),
		PieceIdList = {
			2500171,
			2500172,
			2500173,
			2500174
		},
		MemoryReward = {
			2,
			30,
			5025117,
			1
		}
	},
	[2500180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Colcher_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Alisa/Alisa.png",
		PreMemoryChapter = 2500170,
		Movie = "/Memory/Alisa/Memory_Alisa_Chapter18.mp4",
		Id = 2500180,
		Level = 18,
		SoulId = 20010025,
		Name = getI18NValue(180139475),
		Order = getI18NValue(180139474),
		PieceIdList = {
			2500181,
			2500182,
			2500183,
			2500184
		},
		MemoryReward = {
			2,
			30,
			5025118,
			1
		}
	},
	[2600010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter01.mp4",
		Id = 2600010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010026,
		Name = getI18NValue(180139477),
		Order = getI18NValue(180139476),
		PieceIdList = {
			2600011,
			2600012,
			2600013,
			2600014
		},
		MemoryReward = {
			2,
			30,
			5026101,
			1
		}
	},
	[2600020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600010,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter02.mp4",
		Id = 2600020,
		Level = 2,
		SoulId = 20010026,
		Name = getI18NValue(180139479),
		Order = getI18NValue(180139478),
		PieceIdList = {
			2600021,
			2600022,
			2600023,
			2600024
		},
		MemoryReward = {
			2,
			30,
			5026102,
			1
		}
	},
	[2600030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600020,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter03.mp4",
		Id = 2600030,
		Level = 3,
		SoulId = 20010026,
		Name = getI18NValue(180139481),
		Order = getI18NValue(180139480),
		PieceIdList = {
			2600031,
			2600032,
			2600033,
			2600034
		},
		MemoryReward = {
			2,
			30,
			5026103,
			1
		}
	},
	[2600040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600030,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter04.mp4",
		Id = 2600040,
		Level = 4,
		SoulId = 20010026,
		Name = getI18NValue(180139483),
		Order = getI18NValue(180139482),
		PieceIdList = {
			2600041,
			2600042,
			2600043,
			2600044
		},
		MemoryReward = {
			2,
			30,
			5026104,
			1
		}
	},
	[2600050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600040,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter05.mp4",
		Id = 2600050,
		Level = 5,
		SoulId = 20010026,
		Name = getI18NValue(180139485),
		Order = getI18NValue(180139484),
		PieceIdList = {
			2600051,
			2600052,
			2600053,
			2600054
		},
		MemoryReward = {
			2,
			30,
			5026105,
			1
		}
	},
	[2600060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600050,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter06.mp4",
		Id = 2600060,
		Level = 6,
		SoulId = 20010026,
		Name = getI18NValue(180139487),
		Order = getI18NValue(180139486),
		PieceIdList = {
			2600061,
			2600062,
			2600063,
			2600064
		},
		MemoryReward = {
			2,
			30,
			5026106,
			1
		}
	},
	[2600070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600060,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter07.mp4",
		Id = 2600070,
		Level = 7,
		SoulId = 20010026,
		Name = getI18NValue(180139489),
		Order = getI18NValue(180139488),
		PieceIdList = {
			2600071,
			2600072,
			2600073,
			2600074
		},
		MemoryReward = {
			2,
			30,
			5026107,
			1
		}
	},
	[2600080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600070,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter08.mp4",
		Id = 2600080,
		Level = 8,
		SoulId = 20010026,
		Name = getI18NValue(180139491),
		Order = getI18NValue(180139490),
		PieceIdList = {
			2600081,
			2600082,
			2600083,
			2600084
		},
		MemoryReward = {
			2,
			30,
			5026108,
			1
		}
	},
	[2600090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600080,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter09.mp4",
		Id = 2600090,
		Level = 9,
		SoulId = 20010026,
		Name = getI18NValue(180139493),
		Order = getI18NValue(180139492),
		PieceIdList = {
			2600091,
			2600092,
			2600093,
			2600094
		},
		MemoryReward = {
			2,
			30,
			5026109,
			1
		}
	},
	[2600100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600090,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter10.mp4",
		Id = 2600100,
		Level = 10,
		SoulId = 20010026,
		Name = getI18NValue(180139495),
		Order = getI18NValue(180139494),
		PieceIdList = {
			2600101,
			2600102,
			2600103,
			2600104
		},
		MemoryReward = {
			2,
			30,
			5026110,
			1
		}
	},
	[2600110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600100,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter11.mp4",
		Id = 2600110,
		Level = 11,
		SoulId = 20010026,
		Name = getI18NValue(180139497),
		Order = getI18NValue(180139496),
		PieceIdList = {
			2600111,
			2600112,
			2600113,
			2600114
		},
		MemoryReward = {
			2,
			30,
			5026111,
			1
		}
	},
	[2600120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600110,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter12.mp4",
		Id = 2600120,
		Level = 12,
		SoulId = 20010026,
		Name = getI18NValue(180139499),
		Order = getI18NValue(180139498),
		PieceIdList = {
			2600121,
			2600122,
			2600123,
			2600124
		},
		MemoryReward = {
			2,
			30,
			5026112,
			1
		}
	},
	[2600130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600120,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter13.mp4",
		Id = 2600130,
		Level = 13,
		SoulId = 20010026,
		Name = getI18NValue(180139501),
		Order = getI18NValue(180139500),
		PieceIdList = {
			2600131,
			2600132,
			2600133,
			2600134
		},
		MemoryReward = {
			2,
			30,
			5026113,
			1
		}
	},
	[2600140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600130,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter14.mp4",
		Id = 2600140,
		Level = 14,
		SoulId = 20010026,
		Name = getI18NValue(180139503),
		Order = getI18NValue(180139502),
		PieceIdList = {
			2600141,
			2600142,
			2600143,
			2600144
		},
		MemoryReward = {
			2,
			30,
			5026114,
			1
		}
	},
	[2600150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600140,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter15.mp4",
		Id = 2600150,
		Level = 15,
		SoulId = 20010026,
		Name = getI18NValue(180139505),
		Order = getI18NValue(180139504),
		PieceIdList = {
			2600151,
			2600152,
			2600153,
			2600154
		},
		MemoryReward = {
			2,
			30,
			5026115,
			1
		}
	},
	[2600160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600150,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter16.mp4",
		Id = 2600160,
		Level = 16,
		SoulId = 20010026,
		Name = getI18NValue(180139507),
		Order = getI18NValue(180139506),
		PieceIdList = {
			2600161,
			2600162,
			2600163,
			2600164
		},
		MemoryReward = {
			2,
			30,
			5026116,
			1
		}
	},
	[2600170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600160,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter17.mp4",
		Id = 2600170,
		Level = 17,
		SoulId = 20010026,
		Name = getI18NValue(180139509),
		Order = getI18NValue(180139508),
		PieceIdList = {
			2600171,
			2600172,
			2600173,
			2600174
		},
		MemoryReward = {
			2,
			30,
			5026117,
			1
		}
	},
	[2600180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 2600170,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter18.mp4",
		Id = 2600180,
		Level = 18,
		SoulId = 20010026,
		Name = getI18NValue(180139511),
		Order = getI18NValue(180139510),
		PieceIdList = {
			2600181,
			2600182,
			2600183,
			2600184
		},
		MemoryReward = {
			2,
			30,
			5026118,
			1
		}
	},
	[2700010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter01.mp4",
		Id = 2700010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010027,
		Name = getI18NValue(180262689),
		Order = getI18NValue(180262688),
		PieceIdList = {
			2700011,
			2700012,
			2700013,
			2700014
		},
		MemoryReward = {
			2,
			30,
			5027101,
			1
		}
	},
	[2700020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700010,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter02.mp4",
		Id = 2700020,
		Level = 2,
		SoulId = 20010027,
		Name = getI18NValue(180262691),
		Order = getI18NValue(180262690),
		PieceIdList = {
			2700021,
			2700022,
			2700023,
			2700024
		},
		MemoryReward = {
			2,
			30,
			5027102,
			1
		}
	},
	[2700030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700020,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter03.mp4",
		Id = 2700030,
		Level = 3,
		SoulId = 20010027,
		Name = getI18NValue(180262693),
		Order = getI18NValue(180262692),
		PieceIdList = {
			2700031,
			2700032,
			2700033,
			2700034
		},
		MemoryReward = {
			2,
			30,
			5027103,
			1
		}
	},
	[2700040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700030,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter04.mp4",
		Id = 2700040,
		Level = 4,
		SoulId = 20010027,
		Name = getI18NValue(180262695),
		Order = getI18NValue(180262694),
		PieceIdList = {
			2700041,
			2700042,
			2700043,
			2700044
		},
		MemoryReward = {
			2,
			30,
			5027104,
			1
		}
	},
	[2700050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700040,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter05.mp4",
		Id = 2700050,
		Level = 5,
		SoulId = 20010027,
		Name = getI18NValue(180262697),
		Order = getI18NValue(180262696),
		PieceIdList = {
			2700051,
			2700052,
			2700053,
			2700054
		},
		MemoryReward = {
			2,
			30,
			5027105,
			1
		}
	},
	[2700060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700050,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter06.mp4",
		Id = 2700060,
		Level = 6,
		SoulId = 20010027,
		Name = getI18NValue(180262699),
		Order = getI18NValue(180262698),
		PieceIdList = {
			2700061,
			2700062,
			2700063,
			2700064
		},
		MemoryReward = {
			2,
			30,
			5027106,
			1
		}
	},
	[2700070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700060,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter07.mp4",
		Id = 2700070,
		Level = 7,
		SoulId = 20010027,
		Name = getI18NValue(180262701),
		Order = getI18NValue(180262700),
		PieceIdList = {
			2700071,
			2700072,
			2700073,
			2700074
		},
		MemoryReward = {
			2,
			30,
			5027107,
			1
		}
	},
	[2700080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700070,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter08.mp4",
		Id = 2700080,
		Level = 8,
		SoulId = 20010027,
		Name = getI18NValue(180262703),
		Order = getI18NValue(180262702),
		PieceIdList = {
			2700081,
			2700082,
			2700083,
			2700084
		},
		MemoryReward = {
			2,
			30,
			5027108,
			1
		}
	},
	[2700090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700080,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter09.mp4",
		Id = 2700090,
		Level = 9,
		SoulId = 20010027,
		Name = getI18NValue(180262705),
		Order = getI18NValue(180262704),
		PieceIdList = {
			2700091,
			2700092,
			2700093,
			2700094
		},
		MemoryReward = {
			2,
			30,
			5027109,
			1
		}
	},
	[2700100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700090,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter10.mp4",
		Id = 2700100,
		Level = 10,
		SoulId = 20010027,
		Name = getI18NValue(180262707),
		Order = getI18NValue(180262706),
		PieceIdList = {
			2700101,
			2700102,
			2700103,
			2700104
		},
		MemoryReward = {
			2,
			30,
			5027110,
			1
		}
	},
	[2700110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700100,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter11.mp4",
		Id = 2700110,
		Level = 11,
		SoulId = 20010027,
		Name = getI18NValue(180262709),
		Order = getI18NValue(180262708),
		PieceIdList = {
			2700111,
			2700112,
			2700113,
			2700114
		},
		MemoryReward = {
			2,
			30,
			5027111,
			1
		}
	},
	[2700120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700110,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter12.mp4",
		Id = 2700120,
		Level = 12,
		SoulId = 20010027,
		Name = getI18NValue(180262711),
		Order = getI18NValue(180262710),
		PieceIdList = {
			2700121,
			2700122,
			2700123,
			2700124
		},
		MemoryReward = {
			2,
			30,
			5027112,
			1
		}
	},
	[2700130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700120,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter13.mp4",
		Id = 2700130,
		Level = 13,
		SoulId = 20010027,
		Name = getI18NValue(180262713),
		Order = getI18NValue(180262712),
		PieceIdList = {
			2700131,
			2700132,
			2700133,
			2700134
		},
		MemoryReward = {
			2,
			30,
			5027113,
			1
		}
	},
	[2700140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700130,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter14.mp4",
		Id = 2700140,
		Level = 14,
		SoulId = 20010027,
		Name = getI18NValue(180262715),
		Order = getI18NValue(180262714),
		PieceIdList = {
			2700141,
			2700142,
			2700143,
			2700144
		},
		MemoryReward = {
			2,
			30,
			5027114,
			1
		}
	},
	[2700150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700140,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter15.mp4",
		Id = 2700150,
		Level = 15,
		SoulId = 20010027,
		Name = getI18NValue(180262717),
		Order = getI18NValue(180262716),
		PieceIdList = {
			2700151,
			2700152,
			2700153,
			2700154
		},
		MemoryReward = {
			2,
			30,
			5027115,
			1
		}
	},
	[2700160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700150,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter16.mp4",
		Id = 2700160,
		Level = 16,
		SoulId = 20010027,
		Name = getI18NValue(180262719),
		Order = getI18NValue(180262718),
		PieceIdList = {
			2700161,
			2700162,
			2700163,
			2700164
		},
		MemoryReward = {
			2,
			30,
			5027116,
			1
		}
	},
	[2700170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700160,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter17.mp4",
		Id = 2700170,
		Level = 17,
		SoulId = 20010027,
		Name = getI18NValue(180262721),
		Order = getI18NValue(180262720),
		PieceIdList = {
			2700171,
			2700172,
			2700173,
			2700174
		},
		MemoryReward = {
			2,
			30,
			5027117,
			1
		}
	},
	[2700180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Silenus/Silenus.png",
		PreMemoryChapter = 2700170,
		Movie = "/Memory/Silenus/Memory_Silenus_Chapter18.mp4",
		Id = 2700180,
		Level = 18,
		SoulId = 20010027,
		Name = getI18NValue(180262723),
		Order = getI18NValue(180262722),
		PieceIdList = {
			2700181,
			2700182,
			2700183,
			2700184
		},
		MemoryReward = {
			2,
			30,
			5027118,
			1
		}
	},
	[2800010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		Movie = "/Memory/Mist/Memory_Mist_Chapter01.mp4",
		Id = 2800010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010028,
		Name = getI18NValue(180262725),
		Order = getI18NValue(180262724),
		PieceIdList = {
			2800011,
			2800012,
			2800013,
			2800014
		},
		MemoryReward = {
			2,
			30,
			5028101,
			1
		}
	},
	[2800020] = {
		ResourceSize = "5M",
		Scene = 102802,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800010,
		Movie = "/Memory/Mist/Memory_Mist_Chapter01.mp4",
		Id = 2800020,
		Level = 2,
		SoulId = 20010028,
		Name = getI18NValue(180262727),
		Order = getI18NValue(180262726),
		PieceIdList = {
			2800021,
			2800022,
			2800023,
			2800024
		},
		MemoryReward = {
			2,
			30,
			5028102,
			1
		}
	},
	[2800030] = {
		ResourceSize = "5M",
		Scene = 102803,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800020,
		Movie = "/Memory/Mist/Memory_Mist_Chapter01.mp4",
		Id = 2800030,
		Level = 3,
		SoulId = 20010028,
		Name = getI18NValue(180262729),
		Order = getI18NValue(180262728),
		PieceIdList = {
			2800031,
			2800032,
			2800033,
			2800034
		},
		MemoryReward = {
			2,
			30,
			5028103,
			1
		}
	},
	[2800040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800030,
		Movie = "/Memory/Mist/Memory_Mist_Chapter04.mp4",
		Id = 2800040,
		Level = 4,
		SoulId = 20010028,
		Name = getI18NValue(180262731),
		Order = getI18NValue(180262730),
		PieceIdList = {
			2800041,
			2800042,
			2800043,
			2800044
		},
		MemoryReward = {
			2,
			30,
			5028104,
			1
		}
	},
	[2800050] = {
		ResourceSize = "5M",
		Scene = 102805,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800040,
		Movie = "/Memory/Mist/Memory_Mist_Chapter01.mp4",
		Id = 2800050,
		Level = 5,
		SoulId = 20010028,
		Name = getI18NValue(180262733),
		Order = getI18NValue(180262732),
		PieceIdList = {
			2800051,
			2800052,
			2800053,
			2800054
		},
		MemoryReward = {
			2,
			30,
			5028105,
			1
		}
	},
	[2800060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800050,
		Movie = "/Memory/Mist/Memory_Mist_Chapter06.mp4",
		Id = 2800060,
		Level = 6,
		SoulId = 20010028,
		Name = getI18NValue(180262735),
		Order = getI18NValue(180262734),
		PieceIdList = {
			2800061,
			2800062,
			2800063,
			2800064
		},
		MemoryReward = {
			2,
			30,
			5028106,
			1
		}
	},
	[2800070] = {
		ResourceSize = "5M",
		Scene = 102807,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800060,
		Movie = "/Memory/Mist/Memory_Mist_Chapter01.mp4",
		Id = 2800070,
		Level = 7,
		SoulId = 20010028,
		Name = getI18NValue(180262737),
		Order = getI18NValue(180262736),
		PieceIdList = {
			2800071,
			2800072,
			2800073,
			2800074
		},
		MemoryReward = {
			2,
			30,
			5028107,
			1
		}
	},
	[2800080] = {
		ResourceSize = "5M",
		Scene = 102808,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800070,
		Movie = "/Memory/Mist/Memory_Mist_Chapter01.mp4",
		Id = 2800080,
		Level = 8,
		SoulId = 20010028,
		Name = getI18NValue(180262739),
		Order = getI18NValue(180262738),
		PieceIdList = {
			2800081,
			2800082,
			2800083,
			2800084
		},
		MemoryReward = {
			2,
			30,
			5028108,
			1
		}
	},
	[2800090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800080,
		Movie = "/Memory/Mist/Memory_Mist_Chapter09.mp4",
		Id = 2800090,
		Level = 9,
		SoulId = 20010028,
		Name = getI18NValue(180262741),
		Order = getI18NValue(180262740),
		PieceIdList = {
			2800091,
			2800092,
			2800093,
			2800094
		},
		MemoryReward = {
			2,
			30,
			5028109,
			1
		}
	},
	[2800100] = {
		ResourceSize = "5M",
		Scene = 10281001,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 25,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800090,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800100,
		Level = 10,
		SoulId = 20010028,
		Name = getI18NValue(180262743),
		Order = getI18NValue(180262742),
		PieceIdList = {
			2800101,
			2800102,
			2800103,
			2800104
		},
		MemoryReward = {
			2,
			30,
			5028110,
			1
		}
	},
	[2800110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800100,
		Movie = "/Memory/Mist/Memory_Mist_Chapter11.mp4",
		Id = 2800110,
		Level = 11,
		SoulId = 20010028,
		Name = getI18NValue(180262745),
		Order = getI18NValue(180262744),
		PieceIdList = {
			2800111,
			2800112,
			2800113,
			2800114
		},
		MemoryReward = {
			2,
			30,
			5028111,
			1
		}
	},
	[2800120] = {
		ResourceSize = "5M",
		Scene = 10281201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 31,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800110,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800120,
		Level = 12,
		SoulId = 20010028,
		Name = getI18NValue(180262747),
		Order = getI18NValue(180262746),
		PieceIdList = {
			2800121,
			2800122,
			2800123,
			2800124
		},
		MemoryReward = {
			2,
			30,
			5028112,
			1
		}
	},
	[2800130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800120,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800130,
		Level = 13,
		SoulId = 20010028,
		Name = getI18NValue(180262749),
		Order = getI18NValue(180262748),
		PieceIdList = {
			2800131,
			2800132,
			2800133,
			2800134
		},
		MemoryReward = {
			2,
			30,
			5028113,
			1
		}
	},
	[2800140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800130,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800140,
		Level = 14,
		SoulId = 20010028,
		Name = getI18NValue(180262751),
		Order = getI18NValue(180262750),
		PieceIdList = {
			2800141,
			2800142,
			2800143,
			2800144
		},
		MemoryReward = {
			2,
			30,
			5028114,
			1
		}
	},
	[2800150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800140,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800150,
		Level = 15,
		SoulId = 20010028,
		Name = getI18NValue(180262753),
		Order = getI18NValue(180262752),
		PieceIdList = {
			2800151,
			2800152,
			2800153,
			2800154
		},
		MemoryReward = {
			2,
			30,
			5028115,
			1
		}
	},
	[2800160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800150,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800160,
		Level = 16,
		SoulId = 20010028,
		Name = getI18NValue(180262755),
		Order = getI18NValue(180262754),
		PieceIdList = {
			2800161,
			2800162,
			2800163,
			2800164
		},
		MemoryReward = {
			2,
			30,
			5028116,
			1
		}
	},
	[2800170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800160,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800170,
		Level = 17,
		SoulId = 20010028,
		Name = getI18NValue(180262757),
		Order = getI18NValue(180262756),
		PieceIdList = {
			2800171,
			2800172,
			2800173,
			2800174
		},
		MemoryReward = {
			2,
			30,
			5028117,
			1
		}
	},
	[2800180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Mist/Mist.png",
		PreMemoryChapter = 2800170,
		Movie = "/Memory/Mist/Memory_Mist_Chapter18.mp4",
		Id = 2800180,
		Level = 18,
		SoulId = 20010028,
		Name = getI18NValue(180262759),
		Order = getI18NValue(180262758),
		PieceIdList = {
			2800181,
			2800182,
			2800183,
			2800184
		},
		MemoryReward = {
			2,
			30,
			5028118,
			1
		}
	},
	[2900010] = {
		ResourceSize = "5M",
		Scene = 10290101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter01.mp4",
		Id = 2900010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010029,
		Name = getI18NValue(180262761),
		Order = getI18NValue(180262760),
		PieceIdList = {
			2900011,
			2900012,
			2900013,
			2900014
		},
		MemoryReward = {
			2,
			30,
			5029101,
			1
		}
	},
	[2900020] = {
		ResourceSize = "5M",
		Scene = 10290201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900010,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter02.mp4",
		Id = 2900020,
		Level = 2,
		SoulId = 20010029,
		Name = getI18NValue(180262763),
		Order = getI18NValue(180262762),
		PieceIdList = {
			2900021,
			2900022,
			2900023,
			2900024
		},
		MemoryReward = {
			2,
			30,
			5029102,
			1
		}
	},
	[2900030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900020,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter03.mp4",
		Id = 2900030,
		Level = 3,
		SoulId = 20010029,
		Name = getI18NValue(180262765),
		Order = getI18NValue(180262764),
		PieceIdList = {
			2900031,
			2900032,
			2900033,
			2900034
		},
		MemoryReward = {
			2,
			30,
			5029103,
			1
		}
	},
	[2900040] = {
		ResourceSize = "5M",
		Scene = 10290401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900030,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter04.mp4",
		Id = 2900040,
		Level = 4,
		SoulId = 20010029,
		Name = getI18NValue(180262767),
		Order = getI18NValue(180262766),
		PieceIdList = {
			2900041,
			2900042,
			2900043,
			2900044
		},
		MemoryReward = {
			2,
			30,
			5029104,
			1
		}
	},
	[2900050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900040,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter05.mp4",
		Id = 2900050,
		Level = 5,
		SoulId = 20010029,
		Name = getI18NValue(180262769),
		Order = getI18NValue(180262768),
		PieceIdList = {
			2900051,
			2900052,
			2900053,
			2900054
		},
		MemoryReward = {
			2,
			30,
			5029105,
			1
		}
	},
	[2900060] = {
		ResourceSize = "5M",
		Scene = 10290601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900050,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter06.mp4",
		Id = 2900060,
		Level = 6,
		SoulId = 20010029,
		Name = getI18NValue(180262771),
		Order = getI18NValue(180262770),
		PieceIdList = {
			2900061,
			2900062,
			2900063,
			2900064
		},
		MemoryReward = {
			2,
			30,
			5029106,
			1
		}
	},
	[2900070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900060,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter07.mp4",
		Id = 2900070,
		Level = 7,
		SoulId = 20010029,
		Name = getI18NValue(180262773),
		Order = getI18NValue(180262772),
		PieceIdList = {
			2900071,
			2900072,
			2900073,
			2900074
		},
		MemoryReward = {
			2,
			30,
			5029107,
			1
		}
	},
	[2900080] = {
		ResourceSize = "5M",
		Scene = 10290801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900070,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter08.mp4",
		Id = 2900080,
		Level = 8,
		SoulId = 20010029,
		Name = getI18NValue(180262775),
		Order = getI18NValue(180262774),
		PieceIdList = {
			2900081,
			2900082,
			2900083,
			2900084
		},
		MemoryReward = {
			2,
			30,
			5029108,
			1
		}
	},
	[2900090] = {
		ResourceSize = "5M",
		Scene = 10290901,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 22,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900080,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter09.mp4",
		Id = 2900090,
		Level = 9,
		SoulId = 20010029,
		Name = getI18NValue(180262777),
		Order = getI18NValue(180262776),
		PieceIdList = {
			2900091,
			2900092,
			2900093,
			2900094
		},
		MemoryReward = {
			2,
			30,
			5029109,
			1
		}
	},
	[2900100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900090,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter10.mp4",
		Id = 2900100,
		Level = 10,
		SoulId = 20010029,
		Name = getI18NValue(180262779),
		Order = getI18NValue(180262778),
		PieceIdList = {
			2900101,
			2900102,
			2900103,
			2900104
		},
		MemoryReward = {
			2,
			30,
			5029110,
			1
		}
	},
	[2900110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900100,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter11.mp4",
		Id = 2900110,
		Level = 11,
		SoulId = 20010029,
		Name = getI18NValue(180262781),
		Order = getI18NValue(180262780),
		PieceIdList = {
			2900111,
			2900112,
			2900113,
			2900114
		},
		MemoryReward = {
			2,
			30,
			5029111,
			1
		}
	},
	[2900120] = {
		ResourceSize = "5M",
		Scene = 10291201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 31,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900110,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter12.mp4",
		Id = 2900120,
		Level = 12,
		SoulId = 20010029,
		Name = getI18NValue(180262783),
		Order = getI18NValue(180262782),
		PieceIdList = {
			2900121,
			2900122,
			2900123,
			2900124
		},
		MemoryReward = {
			2,
			30,
			5029112,
			1
		}
	},
	[2900130] = {
		ResourceSize = "5M",
		Scene = 10291301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 34,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900120,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter13.mp4",
		Id = 2900130,
		Level = 13,
		SoulId = 20010029,
		Name = getI18NValue(180262785),
		Order = getI18NValue(180262784),
		PieceIdList = {
			2900131,
			2900132,
			2900133,
			2900134
		},
		MemoryReward = {
			2,
			30,
			5029113,
			1
		}
	},
	[2900140] = {
		ResourceSize = "5M",
		Scene = 10291401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 38,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900130,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter14.mp4",
		Id = 2900140,
		Level = 14,
		SoulId = 20010029,
		Name = getI18NValue(180262787),
		Order = getI18NValue(180262786),
		PieceIdList = {
			2900141,
			2900142,
			2900143,
			2900144
		},
		MemoryReward = {
			2,
			30,
			5029114,
			1
		}
	},
	[2900150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900140,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter15.mp4",
		Id = 2900150,
		Level = 15,
		SoulId = 20010029,
		Name = getI18NValue(180262789),
		Order = getI18NValue(180262788),
		PieceIdList = {
			2900151,
			2900152,
			2900153,
			2900154
		},
		MemoryReward = {
			2,
			30,
			5029115,
			1
		}
	},
	[2900160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900150,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter16.mp4",
		Id = 2900160,
		Level = 16,
		SoulId = 20010029,
		Name = getI18NValue(180262791),
		Order = getI18NValue(180262790),
		PieceIdList = {
			2900161,
			2900162,
			2900163,
			2900164
		},
		MemoryReward = {
			2,
			30,
			5029116,
			1
		}
	},
	[2900170] = {
		ResourceSize = "5M",
		Scene = 10291701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 47,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900160,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter17.mp4",
		Id = 2900170,
		Level = 17,
		SoulId = 20010029,
		Name = getI18NValue(180262793),
		Order = getI18NValue(180262792),
		PieceIdList = {
			2900171,
			2900172,
			2900173,
			2900174
		},
		MemoryReward = {
			2,
			30,
			5029117,
			1
		}
	},
	[2900180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_EtsukazuMiko/EtsukazuMiko.png",
		PreMemoryChapter = 2900170,
		Movie = "/Memory/EtsukazuMiko/Memory_EtsukazuMiko_Chapter18.mp4",
		Id = 2900180,
		Level = 18,
		SoulId = 20010029,
		Name = getI18NValue(180262795),
		Order = getI18NValue(180262794),
		PieceIdList = {
			2900181,
			2900182,
			2900183,
			2900184
		},
		MemoryReward = {
			2,
			30,
			5029118,
			1
		}
	},
	[3000010] = {
		ResourceSize = "5M",
		Scene = 10300101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010030,
		Name = getI18NValue(180262797),
		Order = getI18NValue(180262796),
		PieceIdList = {
			3000011,
			3000012,
			3000013,
			3000014
		},
		MemoryReward = {
			2,
			30,
			5030101,
			1
		}
	},
	[3000020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000010,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000020,
		Level = 2,
		SoulId = 20010030,
		Name = getI18NValue(180262799),
		Order = getI18NValue(180262798),
		PieceIdList = {
			3000021,
			3000022,
			3000023,
			3000024
		},
		MemoryReward = {
			2,
			30,
			5030102,
			1
		}
	},
	[3000030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000020,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter03.mp4",
		Id = 3000030,
		Level = 3,
		SoulId = 20010030,
		Name = getI18NValue(180262801),
		Order = getI18NValue(180262800),
		PieceIdList = {
			3000031,
			3000032,
			3000033,
			3000034
		},
		MemoryReward = {
			2,
			30,
			5030103,
			1
		}
	},
	[3000040] = {
		ResourceSize = "5M",
		Scene = 10300401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000030,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000040,
		Level = 4,
		SoulId = 20010030,
		Name = getI18NValue(180262803),
		Order = getI18NValue(180262802),
		PieceIdList = {
			3000041,
			3000042,
			3000043,
			3000044
		},
		MemoryReward = {
			2,
			30,
			5030104,
			1
		}
	},
	[3000050] = {
		ResourceSize = "5M",
		Scene = 10300501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000040,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000050,
		Level = 5,
		SoulId = 20010030,
		Name = getI18NValue(180262805),
		Order = getI18NValue(180262804),
		PieceIdList = {
			3000051,
			3000052,
			3000053,
			3000054
		},
		MemoryReward = {
			2,
			30,
			5030105,
			1
		}
	},
	[3000060] = {
		ResourceSize = "5M",
		Scene = 10300604,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000050,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000060,
		Level = 6,
		SoulId = 20010030,
		Name = getI18NValue(180262807),
		Order = getI18NValue(180262806),
		PieceIdList = {
			3000061,
			3000062,
			3000063,
			3000064
		},
		MemoryReward = {
			2,
			30,
			5030106,
			1
		}
	},
	[3000070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000060,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter07.mp4",
		Id = 3000070,
		Level = 7,
		SoulId = 20010030,
		Name = getI18NValue(180262809),
		Order = getI18NValue(180262808),
		PieceIdList = {
			3000071,
			3000072,
			3000073,
			3000074
		},
		MemoryReward = {
			2,
			30,
			5030107,
			1
		}
	},
	[3000080] = {
		ResourceSize = "5M",
		Scene = 10300801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000070,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000080,
		Level = 8,
		SoulId = 20010030,
		Name = getI18NValue(180262811),
		Order = getI18NValue(180262810),
		PieceIdList = {
			3000081,
			3000082,
			3000083,
			3000084
		},
		MemoryReward = {
			2,
			30,
			5030108,
			1
		}
	},
	[3000090] = {
		ResourceSize = "5M",
		Scene = 10300901,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 22,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000080,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000090,
		Level = 9,
		SoulId = 20010030,
		Name = getI18NValue(180262813),
		Order = getI18NValue(180262812),
		PieceIdList = {
			3000091,
			3000092,
			3000093,
			3000094
		},
		MemoryReward = {
			2,
			30,
			5030109,
			1
		}
	},
	[3000100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000090,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter10.mp4",
		Id = 3000100,
		Level = 10,
		SoulId = 20010030,
		Name = getI18NValue(180262815),
		Order = getI18NValue(180262814),
		PieceIdList = {
			3000101,
			3000102,
			3000103,
			3000104
		},
		MemoryReward = {
			2,
			30,
			5030110,
			1
		}
	},
	[3000110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000100,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter11.mp4",
		Id = 3000110,
		Level = 11,
		SoulId = 20010030,
		Name = getI18NValue(180262817),
		Order = getI18NValue(180262816),
		PieceIdList = {
			3000111,
			3000112,
			3000113,
			3000114
		},
		MemoryReward = {
			2,
			30,
			5030111,
			1
		}
	},
	[3000120] = {
		ResourceSize = "5M",
		Scene = 10301201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 31,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000110,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000120,
		Level = 12,
		SoulId = 20010030,
		Name = getI18NValue(180262819),
		Order = getI18NValue(180262818),
		PieceIdList = {
			3000121,
			3000122,
			3000123,
			3000124
		},
		MemoryReward = {
			2,
			30,
			5030112,
			1
		}
	},
	[3000130] = {
		ResourceSize = "5M",
		Scene = 10301301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 34,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000120,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000130,
		Level = 13,
		SoulId = 20010030,
		Name = getI18NValue(180262821),
		Order = getI18NValue(180262820),
		PieceIdList = {
			3000131,
			3000132,
			3000133,
			3000134
		},
		MemoryReward = {
			2,
			30,
			5030113,
			1
		}
	},
	[3000140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000130,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter14.mp4",
		Id = 3000140,
		Level = 14,
		SoulId = 20010030,
		Name = getI18NValue(180262823),
		Order = getI18NValue(180262822),
		PieceIdList = {
			3000141,
			3000142,
			3000143,
			3000144
		},
		MemoryReward = {
			2,
			30,
			5030114,
			1
		}
	},
	[3000150] = {
		ResourceSize = "5M",
		Scene = 10301501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 41,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000140,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000150,
		Level = 15,
		SoulId = 20010030,
		Name = getI18NValue(180262825),
		Order = getI18NValue(180262824),
		PieceIdList = {
			3000151,
			3000152,
			3000153,
			3000154
		},
		MemoryReward = {
			2,
			30,
			5030115,
			1
		}
	},
	[3000160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000150,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter16.mp4",
		Id = 3000160,
		Level = 16,
		SoulId = 20010030,
		Name = getI18NValue(180262827),
		Order = getI18NValue(180262826),
		PieceIdList = {
			3000161,
			3000162,
			3000163,
			3000164
		},
		MemoryReward = {
			2,
			30,
			5030116,
			1
		}
	},
	[3000170] = {
		ResourceSize = "5M",
		Scene = 10301701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 47,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000160,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter02.mp4",
		Id = 3000170,
		Level = 17,
		SoulId = 20010030,
		Name = getI18NValue(180262829),
		Order = getI18NValue(180262828),
		PieceIdList = {
			3000171,
			3000172,
			3000173,
			3000174
		},
		MemoryReward = {
			2,
			30,
			5030117,
			1
		}
	},
	[3000180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_TsukinoMiyo/TsukinoMiyo.png",
		PreMemoryChapter = 3000170,
		Movie = "/Memory/TsukinoMiyo/Memory_TsukinoMiyo_Chapter18.mp4",
		Id = 3000180,
		Level = 18,
		SoulId = 20010030,
		Name = getI18NValue(180262831),
		Order = getI18NValue(180262830),
		PieceIdList = {
			3000181,
			3000182,
			3000183,
			3000184
		},
		MemoryReward = {
			2,
			30,
			5030118,
			1
		}
	},
	[3100010] = {
		ResourceSize = "5M",
		Scene = 10310101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter01.mp4",
		Id = 3100010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010031,
		Name = getI18NValue(180262833),
		Order = getI18NValue(180262832),
		PieceIdList = {
			3100011,
			3100012,
			3100013,
			3100014
		},
		MemoryReward = {
			2,
			30,
			5031101,
			1
		}
	},
	[3100020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100010,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter02.mp4",
		Id = 3100020,
		Level = 2,
		SoulId = 20010031,
		Name = getI18NValue(180262835),
		Order = getI18NValue(180262834),
		PieceIdList = {
			3100021,
			3100022,
			3100023,
			3100024
		},
		MemoryReward = {
			2,
			30,
			5031102,
			1
		}
	},
	[3100030] = {
		ResourceSize = "5M",
		Scene = 10310301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100020,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter03.mp4",
		Id = 3100030,
		Level = 3,
		SoulId = 20010031,
		Name = getI18NValue(180262837),
		Order = getI18NValue(180262836),
		PieceIdList = {
			3100031,
			3100032,
			3100033,
			3100034
		},
		MemoryReward = {
			2,
			30,
			5031103,
			1
		}
	},
	[3100040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100030,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter04.mp4",
		Id = 3100040,
		Level = 4,
		SoulId = 20010031,
		Name = getI18NValue(180262839),
		Order = getI18NValue(180262838),
		PieceIdList = {
			3100041,
			3100042,
			3100043,
			3100044
		},
		MemoryReward = {
			2,
			30,
			5031104,
			1
		}
	},
	[3100050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100040,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter05.mp4",
		Id = 3100050,
		Level = 5,
		SoulId = 20010031,
		Name = getI18NValue(180262841),
		Order = getI18NValue(180262840),
		PieceIdList = {
			3100051,
			3100052,
			3100053,
			3100054
		},
		MemoryReward = {
			2,
			30,
			5031105,
			1
		}
	},
	[3100060] = {
		ResourceSize = "5M",
		Scene = 10310601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100050,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter06.mp4",
		Id = 3100060,
		Level = 6,
		SoulId = 20010031,
		Name = getI18NValue(180262843),
		Order = getI18NValue(180262842),
		PieceIdList = {
			3100061,
			3100062,
			3100063,
			3100064
		},
		MemoryReward = {
			2,
			30,
			5031106,
			1
		}
	},
	[3100070] = {
		ResourceSize = "5M",
		Scene = 10310701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100060,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter07.mp4",
		Id = 3100070,
		Level = 7,
		SoulId = 20010031,
		Name = getI18NValue(180262845),
		Order = getI18NValue(180262844),
		PieceIdList = {
			3100071,
			3100072,
			3100073,
			3100074
		},
		MemoryReward = {
			2,
			30,
			5031107,
			1
		}
	},
	[3100080] = {
		ResourceSize = "5M",
		Scene = 10310801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100070,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter08.mp4",
		Id = 3100080,
		Level = 8,
		SoulId = 20010031,
		Name = getI18NValue(180262847),
		Order = getI18NValue(180262846),
		PieceIdList = {
			3100081,
			3100082,
			3100083,
			3100084
		},
		MemoryReward = {
			2,
			30,
			5031108,
			1
		}
	},
	[3100090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100080,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter09.mp4",
		Id = 3100090,
		Level = 9,
		SoulId = 20010031,
		Name = getI18NValue(180262849),
		Order = getI18NValue(180262848),
		PieceIdList = {
			3100091,
			3100092,
			3100093,
			3100094
		},
		MemoryReward = {
			2,
			30,
			5031109,
			1
		}
	},
	[3100100] = {
		ResourceSize = "5M",
		Scene = 10311001,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 25,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100090,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter10.mp4",
		Id = 3100100,
		Level = 10,
		SoulId = 20010031,
		Name = getI18NValue(180262851),
		Order = getI18NValue(180262850),
		PieceIdList = {
			3100101,
			3100102,
			3100103,
			3100104
		},
		MemoryReward = {
			2,
			30,
			5031110,
			1
		}
	},
	[3100110] = {
		ResourceSize = "5M",
		Scene = 10311101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 29,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100100,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter11.mp4",
		Id = 3100110,
		Level = 11,
		SoulId = 20010031,
		Name = getI18NValue(180262853),
		Order = getI18NValue(180262852),
		PieceIdList = {
			3100111,
			3100112,
			3100113,
			3100114
		},
		MemoryReward = {
			2,
			30,
			5031111,
			1
		}
	},
	[3100120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100110,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter12.mp4",
		Id = 3100120,
		Level = 12,
		SoulId = 20010031,
		Name = getI18NValue(180262855),
		Order = getI18NValue(180262854),
		PieceIdList = {
			3100121,
			3100122,
			3100123,
			3100124
		},
		MemoryReward = {
			2,
			30,
			5031112,
			1
		}
	},
	[3100130] = {
		ResourceSize = "5M",
		Scene = 10311301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 34,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100120,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter13.mp4",
		Id = 3100130,
		Level = 13,
		SoulId = 20010031,
		Name = getI18NValue(180262857),
		Order = getI18NValue(180262856),
		PieceIdList = {
			3100131,
			3100132,
			3100133,
			3100134
		},
		MemoryReward = {
			2,
			30,
			5031113,
			1
		}
	},
	[3100140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100130,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter14.mp4",
		Id = 3100140,
		Level = 14,
		SoulId = 20010031,
		Name = getI18NValue(180262859),
		Order = getI18NValue(180262858),
		PieceIdList = {
			3100141,
			3100142,
			3100143,
			3100144
		},
		MemoryReward = {
			2,
			30,
			5031114,
			1
		}
	},
	[3100150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100140,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter15.mp4",
		Id = 3100150,
		Level = 15,
		SoulId = 20010031,
		Name = getI18NValue(180262861),
		Order = getI18NValue(180262860),
		PieceIdList = {
			3100151,
			3100152,
			3100153,
			3100154
		},
		MemoryReward = {
			2,
			30,
			5031115,
			1
		}
	},
	[3100160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100150,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter16.mp4",
		Id = 3100160,
		Level = 16,
		SoulId = 20010031,
		Name = getI18NValue(180262863),
		Order = getI18NValue(180262862),
		PieceIdList = {
			3100161,
			3100162,
			3100163,
			3100164
		},
		MemoryReward = {
			2,
			30,
			5031116,
			1
		}
	},
	[3100170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100160,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter17.mp4",
		Id = 3100170,
		Level = 17,
		SoulId = 20010031,
		Name = getI18NValue(180262865),
		Order = getI18NValue(180262864),
		PieceIdList = {
			3100171,
			3100172,
			3100173,
			3100174
		},
		MemoryReward = {
			2,
			30,
			5031117,
			1
		}
	},
	[3100180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Ithil/Ithil.png",
		PreMemoryChapter = 3100170,
		Movie = "/Memory/Ithil/Memory_Ithil_Chapter18.mp4",
		Id = 3100180,
		Level = 18,
		SoulId = 20010031,
		Name = getI18NValue(180262867),
		Order = getI18NValue(180262866),
		PieceIdList = {
			3100181,
			3100182,
			3100183,
			3100184
		},
		MemoryReward = {
			2,
			30,
			5031118,
			1
		}
	},
	[3200010] = {
		ResourceSize = "5M",
		Scene = 10320101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010032,
		Name = getI18NValue(180262869),
		Order = getI18NValue(180262868),
		PieceIdList = {
			3200011,
			3200012,
			3200013,
			3200014
		},
		MemoryReward = {
			2,
			30,
			5032101,
			1
		}
	},
	[3200020] = {
		ResourceSize = "5M",
		Scene = 10320201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200010,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200020,
		Level = 2,
		SoulId = 20010032,
		Name = getI18NValue(180262871),
		Order = getI18NValue(180262870),
		PieceIdList = {
			3200021,
			3200022,
			3200023,
			3200024
		},
		MemoryReward = {
			2,
			30,
			5032102,
			1
		}
	},
	[3200030] = {
		ResourceSize = "5M",
		Scene = 10320301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200020,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200030,
		Level = 3,
		SoulId = 20010032,
		Name = getI18NValue(180262873),
		Order = getI18NValue(180262872),
		PieceIdList = {
			3200031,
			3200032,
			3200033,
			3200034
		},
		MemoryReward = {
			2,
			30,
			5032103,
			1
		}
	},
	[3200040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200030,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter04.mp4",
		Id = 3200040,
		Level = 4,
		SoulId = 20010032,
		Name = getI18NValue(180262875),
		Order = getI18NValue(180262874),
		PieceIdList = {
			3200041,
			3200042,
			3200043,
			3200044
		},
		MemoryReward = {
			2,
			30,
			5032104,
			1
		}
	},
	[3200050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200040,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter05.mp4",
		Id = 3200050,
		Level = 5,
		SoulId = 20010032,
		Name = getI18NValue(180262877),
		Order = getI18NValue(180262876),
		PieceIdList = {
			3200051,
			3200052,
			3200053,
			3200054
		},
		MemoryReward = {
			2,
			30,
			5032105,
			1
		}
	},
	[3200060] = {
		ResourceSize = "5M",
		Scene = 10320601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200050,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200060,
		Level = 6,
		SoulId = 20010032,
		Name = getI18NValue(180262879),
		Order = getI18NValue(180262878),
		PieceIdList = {
			3200061,
			3200062,
			3200063,
			3200064
		},
		MemoryReward = {
			2,
			30,
			5032106,
			1
		}
	},
	[3200070] = {
		ResourceSize = "5M",
		Scene = 10320701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200060,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200070,
		Level = 7,
		SoulId = 20010032,
		Name = getI18NValue(180262881),
		Order = getI18NValue(180262880),
		PieceIdList = {
			3200071,
			3200072,
			3200073,
			3200074
		},
		MemoryReward = {
			2,
			30,
			5032107,
			1
		}
	},
	[3200080] = {
		ResourceSize = "5M",
		Scene = 10320801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200070,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200080,
		Level = 8,
		SoulId = 20010032,
		Name = getI18NValue(180262883),
		Order = getI18NValue(180262882),
		PieceIdList = {
			3200081,
			3200082,
			3200083,
			3200084
		},
		MemoryReward = {
			2,
			30,
			5032108,
			1
		}
	},
	[3200090] = {
		ResourceSize = "5M",
		Scene = 10320901,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 22,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200080,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200090,
		Level = 9,
		SoulId = 20010032,
		Name = getI18NValue(180262885),
		Order = getI18NValue(180262884),
		PieceIdList = {
			3200091,
			3200092,
			3200093,
			3200094
		},
		MemoryReward = {
			2,
			30,
			5032109,
			1
		}
	},
	[3200100] = {
		ResourceSize = "5M",
		Scene = 10321001,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 25,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200090,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200100,
		Level = 10,
		SoulId = 20010032,
		Name = getI18NValue(180262887),
		Order = getI18NValue(180262886),
		PieceIdList = {
			3200101,
			3200102,
			3200103,
			3200104
		},
		MemoryReward = {
			2,
			30,
			5032110,
			1
		}
	},
	[3200110] = {
		ResourceSize = "5M",
		Scene = 10321101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 29,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200100,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200110,
		Level = 11,
		SoulId = 20010032,
		Name = getI18NValue(180262889),
		Order = getI18NValue(180262888),
		PieceIdList = {
			3200111,
			3200112,
			3200113,
			3200114
		},
		MemoryReward = {
			2,
			30,
			5032111,
			1
		}
	},
	[3200120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200110,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter12.mp4",
		Id = 3200120,
		Level = 12,
		SoulId = 20010032,
		Name = getI18NValue(180262891),
		Order = getI18NValue(180262890),
		PieceIdList = {
			3200121,
			3200122,
			3200123,
			3200124
		},
		MemoryReward = {
			2,
			30,
			5032112,
			1
		}
	},
	[3200130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200120,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter13.mp4",
		Id = 3200130,
		Level = 13,
		SoulId = 20010032,
		Name = getI18NValue(180262893),
		Order = getI18NValue(180262892),
		PieceIdList = {
			3200131,
			3200132,
			3200133,
			3200134
		},
		MemoryReward = {
			2,
			30,
			5032113,
			1
		}
	},
	[3200140] = {
		ResourceSize = "5M",
		Scene = 10321401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 38,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200130,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter00.mp4",
		Id = 3200140,
		Level = 14,
		SoulId = 20010032,
		Name = getI18NValue(180262895),
		Order = getI18NValue(180262894),
		PieceIdList = {
			3200141,
			3200142,
			3200143,
			3200144
		},
		MemoryReward = {
			2,
			30,
			5032114,
			1
		}
	},
	[3200150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200140,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter15.mp4",
		Id = 3200150,
		Level = 15,
		SoulId = 20010032,
		Name = getI18NValue(180262897),
		Order = getI18NValue(180262896),
		PieceIdList = {
			3200151,
			3200152,
			3200153,
			3200154
		},
		MemoryReward = {
			2,
			30,
			5032115,
			1
		}
	},
	[3200160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200150,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter16.mp4",
		Id = 3200160,
		Level = 16,
		SoulId = 20010032,
		Name = getI18NValue(180262899),
		Order = getI18NValue(180262898),
		PieceIdList = {
			3200161,
			3200162,
			3200163,
			3200164
		},
		MemoryReward = {
			2,
			30,
			5032116,
			1
		}
	},
	[3200170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200160,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter17.mp4",
		Id = 3200170,
		Level = 17,
		SoulId = 20010032,
		Name = getI18NValue(180262901),
		Order = getI18NValue(180262900),
		PieceIdList = {
			3200171,
			3200172,
			3200173,
			3200174
		},
		MemoryReward = {
			2,
			30,
			5032117,
			1
		}
	},
	[3200180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dolores/Dolores.png",
		PreMemoryChapter = 3200170,
		Movie = "/Memory/Dolores/Memory_Dolores_Chapter18.mp4",
		Id = 3200180,
		Level = 18,
		SoulId = 20010032,
		Name = getI18NValue(180262903),
		Order = getI18NValue(180262902),
		PieceIdList = {
			3200181,
			3200182,
			3200183,
			3200184
		},
		MemoryReward = {
			2,
			30,
			5032118,
			1
		}
	},
	[3300010] = {
		ResourceSize = "5M",
		Scene = 10330101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010033,
		Name = getI18NValue(180489794),
		Order = getI18NValue(180489793),
		PieceIdList = {
			3300011,
			3300012,
			3300013,
			3300014
		},
		MemoryReward = {
			2,
			30,
			5033101,
			1
		}
	},
	[3300020] = {
		ResourceSize = "5M",
		Scene = 10330201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300010,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300020,
		Level = 2,
		SoulId = 20010033,
		Name = getI18NValue(180489796),
		Order = getI18NValue(180489795),
		PieceIdList = {
			3300021,
			3300022,
			3300023,
			3300024
		},
		MemoryReward = {
			2,
			30,
			5033102,
			1
		}
	},
	[3300030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300020,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter03.mp4",
		Id = 3300030,
		Level = 3,
		SoulId = 20010033,
		Name = getI18NValue(180489798),
		Order = getI18NValue(180489797),
		PieceIdList = {
			3300031,
			3300032,
			3300033,
			3300034
		},
		MemoryReward = {
			2,
			30,
			5033103,
			1
		}
	},
	[3300040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300030,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter04.mp4",
		Id = 3300040,
		Level = 4,
		SoulId = 20010033,
		Name = getI18NValue(180489800),
		Order = getI18NValue(180489799),
		PieceIdList = {
			3300041,
			3300042,
			3300043,
			3300044
		},
		MemoryReward = {
			2,
			30,
			5033104,
			1
		}
	},
	[3300050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300040,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter05.mp4",
		Id = 3300050,
		Level = 5,
		SoulId = 20010033,
		Name = getI18NValue(180489802),
		Order = getI18NValue(180489801),
		PieceIdList = {
			3300051,
			3300052,
			3300053,
			3300054
		},
		MemoryReward = {
			2,
			30,
			5033105,
			1
		}
	},
	[3300060] = {
		ResourceSize = "5M",
		Scene = 10330601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300050,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300060,
		Level = 6,
		SoulId = 20010033,
		Name = getI18NValue(180489804),
		Order = getI18NValue(180489803),
		PieceIdList = {
			3300061,
			3300062,
			3300063,
			3300064
		},
		MemoryReward = {
			2,
			30,
			5033106,
			1
		}
	},
	[3300070] = {
		ResourceSize = "5M",
		Scene = 10330701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300060,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300070,
		Level = 7,
		SoulId = 20010033,
		Name = getI18NValue(180489806),
		Order = getI18NValue(180489805),
		PieceIdList = {
			3300071,
			3300072,
			3300073,
			3300074
		},
		MemoryReward = {
			2,
			30,
			5033107,
			1
		}
	},
	[3300080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300070,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter08.mp4",
		Id = 3300080,
		Level = 8,
		SoulId = 20010033,
		Name = getI18NValue(180489808),
		Order = getI18NValue(180489807),
		PieceIdList = {
			3300081,
			3300082,
			3300083,
			3300084
		},
		MemoryReward = {
			2,
			30,
			5033108,
			1
		}
	},
	[3300090] = {
		ResourceSize = "5M",
		Scene = 10330901,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 22,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300080,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300090,
		Level = 9,
		SoulId = 20010033,
		Name = getI18NValue(180489810),
		Order = getI18NValue(180489809),
		PieceIdList = {
			3300091,
			3300092,
			3300093,
			3300094
		},
		MemoryReward = {
			2,
			30,
			5033109,
			1
		}
	},
	[3300100] = {
		ResourceSize = "5M",
		Scene = 10331001,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 25,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300090,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300100,
		Level = 10,
		SoulId = 20010033,
		Name = getI18NValue(180489812),
		Order = getI18NValue(180489811),
		PieceIdList = {
			3300101,
			3300102,
			3300103,
			3300104
		},
		MemoryReward = {
			2,
			30,
			5033110,
			1
		}
	},
	[3300110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300100,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter11.mp4",
		Id = 3300110,
		Level = 11,
		SoulId = 20010033,
		Name = getI18NValue(180489814),
		Order = getI18NValue(180489813),
		PieceIdList = {
			3300111,
			3300112,
			3300113,
			3300114
		},
		MemoryReward = {
			2,
			30,
			5033111,
			1
		}
	},
	[3300120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300110,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300120,
		Level = 12,
		SoulId = 20010033,
		Name = getI18NValue(180489816),
		Order = getI18NValue(180489815),
		PieceIdList = {
			3300121,
			3300122,
			3300123,
			3300124
		},
		MemoryReward = {
			2,
			30,
			5033112,
			1
		}
	},
	[3300130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300120,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300130,
		Level = 13,
		SoulId = 20010033,
		Name = getI18NValue(180489818),
		Order = getI18NValue(180489817),
		PieceIdList = {
			3300131,
			3300132,
			3300133,
			3300134
		},
		MemoryReward = {
			2,
			30,
			5033113,
			1
		}
	},
	[3300140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300130,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300140,
		Level = 14,
		SoulId = 20010033,
		Name = getI18NValue(180489820),
		Order = getI18NValue(180489819),
		PieceIdList = {
			3300141,
			3300142,
			3300143,
			3300144
		},
		MemoryReward = {
			2,
			30,
			5033114,
			1
		}
	},
	[3300150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300140,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300150,
		Level = 15,
		SoulId = 20010033,
		Name = getI18NValue(180489822),
		Order = getI18NValue(180489821),
		PieceIdList = {
			3300151,
			3300152,
			3300153,
			3300154
		},
		MemoryReward = {
			2,
			30,
			5033115,
			1
		}
	},
	[3300160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300150,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300160,
		Level = 16,
		SoulId = 20010033,
		Name = getI18NValue(180489824),
		Order = getI18NValue(180489823),
		PieceIdList = {
			3300161,
			3300162,
			3300163,
			3300164
		},
		MemoryReward = {
			2,
			30,
			5033116,
			1
		}
	},
	[3300170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300160,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300170,
		Level = 17,
		SoulId = 20010033,
		Name = getI18NValue(180489826),
		Order = getI18NValue(180489825),
		PieceIdList = {
			3300171,
			3300172,
			3300173,
			3300174
		},
		MemoryReward = {
			2,
			30,
			5033117,
			1
		}
	},
	[3300180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_NankungLin_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Aoling/Aoling.png",
		PreMemoryChapter = 3300170,
		Movie = "/Memory/Aoling/Memory_Aoling_Chapter00.mp4",
		Id = 3300180,
		Level = 18,
		SoulId = 20010033,
		Name = getI18NValue(180489828),
		Order = getI18NValue(180489827),
		PieceIdList = {
			3300181,
			3300182,
			3300183,
			3300184
		},
		MemoryReward = {
			2,
			30,
			5033118,
			1
		}
	},
	[3400010] = {
		ResourceSize = "5M",
		Scene = 10340101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010034,
		Name = getI18NValue(180489830),
		Order = getI18NValue(180489829),
		PieceIdList = {
			3400011,
			3400012,
			3400013,
			3400014
		},
		MemoryReward = {
			2,
			30,
			5034101,
			1
		}
	},
	[3400020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400010,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter02.mp4",
		Id = 3400020,
		Level = 2,
		SoulId = 20010034,
		Name = getI18NValue(180489832),
		Order = getI18NValue(180489831),
		PieceIdList = {
			3400021,
			3400022,
			3400023,
			3400024
		},
		MemoryReward = {
			2,
			30,
			5034102,
			1
		}
	},
	[3400030] = {
		ResourceSize = "5M",
		Scene = 10340301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400020,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400030,
		Level = 3,
		SoulId = 20010034,
		Name = getI18NValue(180489834),
		Order = getI18NValue(180489833),
		PieceIdList = {
			3400031,
			3400032,
			3400033,
			3400034
		},
		MemoryReward = {
			2,
			30,
			5034103,
			1
		}
	},
	[3400040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400030,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter04.mp4",
		Id = 3400040,
		Level = 4,
		SoulId = 20010034,
		Name = getI18NValue(180489836),
		Order = getI18NValue(180489835),
		PieceIdList = {
			3400041,
			3400042,
			3400043,
			3400044
		},
		MemoryReward = {
			2,
			30,
			5034104,
			1
		}
	},
	[3400050] = {
		ResourceSize = "5M",
		Scene = 10340501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400040,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400050,
		Level = 5,
		SoulId = 20010034,
		Name = getI18NValue(180489838),
		Order = getI18NValue(180489837),
		PieceIdList = {
			3400051,
			3400052,
			3400053,
			3400054
		},
		MemoryReward = {
			2,
			30,
			5034105,
			1
		}
	},
	[3400060] = {
		ResourceSize = "5M",
		Scene = 10340601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400050,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400060,
		Level = 6,
		SoulId = 20010034,
		Name = getI18NValue(180489840),
		Order = getI18NValue(180489839),
		PieceIdList = {
			3400061,
			3400062,
			3400063,
			3400064
		},
		MemoryReward = {
			2,
			30,
			5034106,
			1
		}
	},
	[3400070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400060,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter07.mp4",
		Id = 3400070,
		Level = 7,
		SoulId = 20010034,
		Name = getI18NValue(180489842),
		Order = getI18NValue(180489841),
		PieceIdList = {
			3400071,
			3400072,
			3400073,
			3400074
		},
		MemoryReward = {
			2,
			30,
			5034107,
			1
		}
	},
	[3400080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400070,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter08.mp4",
		Id = 3400080,
		Level = 8,
		SoulId = 20010034,
		Name = getI18NValue(180489844),
		Order = getI18NValue(180489843),
		PieceIdList = {
			3400081,
			3400082,
			3400083,
			3400084
		},
		MemoryReward = {
			2,
			30,
			5034108,
			1
		}
	},
	[3400090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400080,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400090,
		Level = 9,
		SoulId = 20010034,
		Name = getI18NValue(180489846),
		Order = getI18NValue(180489845),
		PieceIdList = {
			3400091,
			3400092,
			3400093,
			3400094
		},
		MemoryReward = {
			2,
			30,
			5034109,
			1
		}
	},
	[3400100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400090,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400100,
		Level = 10,
		SoulId = 20010034,
		Name = getI18NValue(180489848),
		Order = getI18NValue(180489847),
		PieceIdList = {
			3400101,
			3400102,
			3400103,
			3400104
		},
		MemoryReward = {
			2,
			30,
			5034110,
			1
		}
	},
	[3400110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400100,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400110,
		Level = 11,
		SoulId = 20010034,
		Name = getI18NValue(180489850),
		Order = getI18NValue(180489849),
		PieceIdList = {
			3400111,
			3400112,
			3400113,
			3400114
		},
		MemoryReward = {
			2,
			30,
			5034111,
			1
		}
	},
	[3400120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400110,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400120,
		Level = 12,
		SoulId = 20010034,
		Name = getI18NValue(180489852),
		Order = getI18NValue(180489851),
		PieceIdList = {
			3400121,
			3400122,
			3400123,
			3400124
		},
		MemoryReward = {
			2,
			30,
			5034112,
			1
		}
	},
	[3400130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400120,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400130,
		Level = 13,
		SoulId = 20010034,
		Name = getI18NValue(180489854),
		Order = getI18NValue(180489853),
		PieceIdList = {
			3400131,
			3400132,
			3400133,
			3400134
		},
		MemoryReward = {
			2,
			30,
			5034113,
			1
		}
	},
	[3400140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400130,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400140,
		Level = 14,
		SoulId = 20010034,
		Name = getI18NValue(180489856),
		Order = getI18NValue(180489855),
		PieceIdList = {
			3400141,
			3400142,
			3400143,
			3400144
		},
		MemoryReward = {
			2,
			30,
			5034114,
			1
		}
	},
	[3400150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400140,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400150,
		Level = 15,
		SoulId = 20010034,
		Name = getI18NValue(180489858),
		Order = getI18NValue(180489857),
		PieceIdList = {
			3400151,
			3400152,
			3400153,
			3400154
		},
		MemoryReward = {
			2,
			30,
			5034115,
			1
		}
	},
	[3400160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400150,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400160,
		Level = 16,
		SoulId = 20010034,
		Name = getI18NValue(180489860),
		Order = getI18NValue(180489859),
		PieceIdList = {
			3400161,
			3400162,
			3400163,
			3400164
		},
		MemoryReward = {
			2,
			30,
			5034116,
			1
		}
	},
	[3400170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400160,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400170,
		Level = 17,
		SoulId = 20010034,
		Name = getI18NValue(180489862),
		Order = getI18NValue(180489861),
		PieceIdList = {
			3400171,
			3400172,
			3400173,
			3400174
		},
		MemoryReward = {
			2,
			30,
			5034117,
			1
		}
	},
	[3400180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Satya_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clotho/Clotho.png",
		PreMemoryChapter = 3400170,
		Movie = "/Memory/Clotho/Memory_Clotho_Chapter00.mp4",
		Id = 3400180,
		Level = 18,
		SoulId = 20010034,
		Name = getI18NValue(180489864),
		Order = getI18NValue(180489863),
		PieceIdList = {
			3400181,
			3400182,
			3400183,
			3400184
		},
		MemoryReward = {
			2,
			30,
			5034118,
			1
		}
	},
	[3500010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter01.mp4",
		Id = 3500010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010035,
		Name = getI18NValue(180489866),
		Order = getI18NValue(180489865),
		PieceIdList = {
			3500011,
			3500012,
			3500013,
			3500014
		},
		MemoryReward = {
			2,
			30,
			5035101,
			1
		}
	},
	[3500020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500010,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter02.mp4",
		Id = 3500020,
		Level = 2,
		SoulId = 20010035,
		Name = getI18NValue(180489868),
		Order = getI18NValue(180489867),
		PieceIdList = {
			3500021,
			3500022,
			3500023,
			3500024
		},
		MemoryReward = {
			2,
			30,
			5035102,
			1
		}
	},
	[3500030] = {
		ResourceSize = "5M",
		Scene = 10350301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500020,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500030,
		Level = 3,
		SoulId = 20010035,
		Name = getI18NValue(180489870),
		Order = getI18NValue(180489869),
		PieceIdList = {
			3500031,
			3500032,
			3500033,
			3500034
		},
		MemoryReward = {
			2,
			30,
			5035103,
			1
		}
	},
	[3500040] = {
		ResourceSize = "5M",
		Scene = 10350401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500030,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500040,
		Level = 4,
		SoulId = 20010035,
		Name = getI18NValue(180489872),
		Order = getI18NValue(180489871),
		PieceIdList = {
			3500041,
			3500042,
			3500043,
			3500044
		},
		MemoryReward = {
			2,
			30,
			5035104,
			1
		}
	},
	[3500050] = {
		ResourceSize = "5M",
		Scene = 10350501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500040,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500050,
		Level = 5,
		SoulId = 20010035,
		Name = getI18NValue(180489874),
		Order = getI18NValue(180489873),
		PieceIdList = {
			3500051,
			3500052,
			3500053,
			3500054
		},
		MemoryReward = {
			2,
			30,
			5035105,
			1
		}
	},
	[3500060] = {
		ResourceSize = "5M",
		Scene = 10350601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500050,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500060,
		Level = 6,
		SoulId = 20010035,
		Name = getI18NValue(180489876),
		Order = getI18NValue(180489875),
		PieceIdList = {
			3500061,
			3500062,
			3500063,
			3500064
		},
		MemoryReward = {
			2,
			30,
			5035106,
			1
		}
	},
	[3500070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500060,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter07.mp4",
		Id = 3500070,
		Level = 7,
		SoulId = 20010035,
		Name = getI18NValue(180489878),
		Order = getI18NValue(180489877),
		PieceIdList = {
			3500071,
			3500072,
			3500073,
			3500074
		},
		MemoryReward = {
			2,
			30,
			5035107,
			1
		}
	},
	[3500080] = {
		ResourceSize = "5M",
		Scene = 10350801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500070,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500080,
		Level = 8,
		SoulId = 20010035,
		Name = getI18NValue(180489880),
		Order = getI18NValue(180489879),
		PieceIdList = {
			3500081,
			3500082,
			3500083,
			3500084
		},
		MemoryReward = {
			2,
			30,
			5035108,
			1
		}
	},
	[3500090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500080,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500090,
		Level = 9,
		SoulId = 20010035,
		Name = getI18NValue(180489882),
		Order = getI18NValue(180489881),
		PieceIdList = {
			3500091,
			3500092,
			3500093,
			3500094
		},
		MemoryReward = {
			2,
			30,
			5035109,
			1
		}
	},
	[3500100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500090,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500100,
		Level = 10,
		SoulId = 20010035,
		Name = getI18NValue(180489884),
		Order = getI18NValue(180489883),
		PieceIdList = {
			3500101,
			3500102,
			3500103,
			3500104
		},
		MemoryReward = {
			2,
			30,
			5035110,
			1
		}
	},
	[3500110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500100,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500110,
		Level = 11,
		SoulId = 20010035,
		Name = getI18NValue(180489886),
		Order = getI18NValue(180489885),
		PieceIdList = {
			3500111,
			3500112,
			3500113,
			3500114
		},
		MemoryReward = {
			2,
			30,
			5035111,
			1
		}
	},
	[3500120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500110,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500120,
		Level = 12,
		SoulId = 20010035,
		Name = getI18NValue(180489888),
		Order = getI18NValue(180489887),
		PieceIdList = {
			3500121,
			3500122,
			3500123,
			3500124
		},
		MemoryReward = {
			2,
			30,
			5035112,
			1
		}
	},
	[3500130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500120,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500130,
		Level = 13,
		SoulId = 20010035,
		Name = getI18NValue(180489890),
		Order = getI18NValue(180489889),
		PieceIdList = {
			3500131,
			3500132,
			3500133,
			3500134
		},
		MemoryReward = {
			2,
			30,
			5035113,
			1
		}
	},
	[3500140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500130,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500140,
		Level = 14,
		SoulId = 20010035,
		Name = getI18NValue(180489892),
		Order = getI18NValue(180489891),
		PieceIdList = {
			3500141,
			3500142,
			3500143,
			3500144
		},
		MemoryReward = {
			2,
			30,
			5035114,
			1
		}
	},
	[3500150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500140,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500150,
		Level = 15,
		SoulId = 20010035,
		Name = getI18NValue(180489894),
		Order = getI18NValue(180489893),
		PieceIdList = {
			3500151,
			3500152,
			3500153,
			3500154
		},
		MemoryReward = {
			2,
			30,
			5035115,
			1
		}
	},
	[3500160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500150,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500160,
		Level = 16,
		SoulId = 20010035,
		Name = getI18NValue(180489896),
		Order = getI18NValue(180489895),
		PieceIdList = {
			3500161,
			3500162,
			3500163,
			3500164
		},
		MemoryReward = {
			2,
			30,
			5035116,
			1
		}
	},
	[3500170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500160,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500170,
		Level = 17,
		SoulId = 20010035,
		Name = getI18NValue(180489898),
		Order = getI18NValue(180489897),
		PieceIdList = {
			3500171,
			3500172,
			3500173,
			3500174
		},
		MemoryReward = {
			2,
			30,
			5035117,
			1
		}
	},
	[3500180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_QingDai_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingDai/QingDai.png",
		PreMemoryChapter = 3500170,
		Movie = "/Memory/QingDai/Memory_QingDai_Chapter00.mp4",
		Id = 3500180,
		Level = 18,
		SoulId = 20010035,
		Name = getI18NValue(180489900),
		Order = getI18NValue(180489899),
		PieceIdList = {
			3500181,
			3500182,
			3500183,
			3500184
		},
		MemoryReward = {
			2,
			30,
			5035118,
			1
		}
	},
	[3600010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter01.mp4",
		Id = 3600010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010036,
		Name = getI18NValue(180489902),
		Order = getI18NValue(180489901),
		PieceIdList = {
			3600011,
			3600012,
			3600013,
			3600014
		},
		MemoryReward = {
			2,
			30,
			5036101,
			1
		}
	},
	[3600020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600010,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter02.mp4",
		Id = 3600020,
		Level = 2,
		SoulId = 20010036,
		Name = getI18NValue(180489904),
		Order = getI18NValue(180489903),
		PieceIdList = {
			3600021,
			3600022,
			3600023,
			3600024
		},
		MemoryReward = {
			2,
			30,
			5036102,
			1
		}
	},
	[3600030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600020,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter03.mp4",
		Id = 3600030,
		Level = 3,
		SoulId = 20010036,
		Name = getI18NValue(180489906),
		Order = getI18NValue(180489905),
		PieceIdList = {
			3600031,
			3600032,
			3600033,
			3600034
		},
		MemoryReward = {
			2,
			30,
			5036103,
			1
		}
	},
	[3600040] = {
		ResourceSize = "5M",
		Scene = 10360401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600030,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600040,
		Level = 4,
		SoulId = 20010036,
		Name = getI18NValue(180489908),
		Order = getI18NValue(180489907),
		PieceIdList = {
			3600041,
			3600042,
			3600043,
			3600044
		},
		MemoryReward = {
			2,
			30,
			5036104,
			1
		}
	},
	[3600050] = {
		ResourceSize = "5M",
		Scene = 10360501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600040,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600050,
		Level = 5,
		SoulId = 20010036,
		Name = getI18NValue(180489910),
		Order = getI18NValue(180489909),
		PieceIdList = {
			3600051,
			3600052,
			3600053,
			3600054
		},
		MemoryReward = {
			2,
			30,
			5036105,
			1
		}
	},
	[3600060] = {
		ResourceSize = "5M",
		Scene = 10360601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600050,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600060,
		Level = 6,
		SoulId = 20010036,
		Name = getI18NValue(180489912),
		Order = getI18NValue(180489911),
		PieceIdList = {
			3600061,
			3600062,
			3600063,
			3600064
		},
		MemoryReward = {
			2,
			30,
			5036106,
			1
		}
	},
	[3600070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600060,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter07.mp4",
		Id = 3600070,
		Level = 7,
		SoulId = 20010036,
		Name = getI18NValue(180489914),
		Order = getI18NValue(180489913),
		PieceIdList = {
			3600071,
			3600072,
			3600073,
			3600074
		},
		MemoryReward = {
			2,
			30,
			5036107,
			1
		}
	},
	[3600080] = {
		ResourceSize = "5M",
		Scene = 10360801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600070,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600080,
		Level = 8,
		SoulId = 20010036,
		Name = getI18NValue(180489916),
		Order = getI18NValue(180489915),
		PieceIdList = {
			3600081,
			3600082,
			3600083,
			3600084
		},
		MemoryReward = {
			2,
			30,
			5036108,
			1
		}
	},
	[3600090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600080,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600090,
		Level = 9,
		SoulId = 20010036,
		Name = getI18NValue(180489918),
		Order = getI18NValue(180489917),
		PieceIdList = {
			3600091,
			3600092,
			3600093,
			3600094
		},
		MemoryReward = {
			2,
			30,
			5036109,
			1
		}
	},
	[3600100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600090,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600100,
		Level = 10,
		SoulId = 20010036,
		Name = getI18NValue(180489920),
		Order = getI18NValue(180489919),
		PieceIdList = {
			3600101,
			3600102,
			3600103,
			3600104
		},
		MemoryReward = {
			2,
			30,
			5036110,
			1
		}
	},
	[3600110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600100,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600110,
		Level = 11,
		SoulId = 20010036,
		Name = getI18NValue(180489922),
		Order = getI18NValue(180489921),
		PieceIdList = {
			3600111,
			3600112,
			3600113,
			3600114
		},
		MemoryReward = {
			2,
			30,
			5036111,
			1
		}
	},
	[3600120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600110,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600120,
		Level = 12,
		SoulId = 20010036,
		Name = getI18NValue(180489924),
		Order = getI18NValue(180489923),
		PieceIdList = {
			3600121,
			3600122,
			3600123,
			3600124
		},
		MemoryReward = {
			2,
			30,
			5036112,
			1
		}
	},
	[3600130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600120,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600130,
		Level = 13,
		SoulId = 20010036,
		Name = getI18NValue(180489926),
		Order = getI18NValue(180489925),
		PieceIdList = {
			3600131,
			3600132,
			3600133,
			3600134
		},
		MemoryReward = {
			2,
			30,
			5036113,
			1
		}
	},
	[3600140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600130,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600140,
		Level = 14,
		SoulId = 20010036,
		Name = getI18NValue(180489928),
		Order = getI18NValue(180489927),
		PieceIdList = {
			3600141,
			3600142,
			3600143,
			3600144
		},
		MemoryReward = {
			2,
			30,
			5036114,
			1
		}
	},
	[3600150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600140,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600150,
		Level = 15,
		SoulId = 20010036,
		Name = getI18NValue(180489930),
		Order = getI18NValue(180489929),
		PieceIdList = {
			3600151,
			3600152,
			3600153,
			3600154
		},
		MemoryReward = {
			2,
			30,
			5036115,
			1
		}
	},
	[3600160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600150,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600160,
		Level = 16,
		SoulId = 20010036,
		Name = getI18NValue(180489932),
		Order = getI18NValue(180489931),
		PieceIdList = {
			3600161,
			3600162,
			3600163,
			3600164
		},
		MemoryReward = {
			2,
			30,
			5036116,
			1
		}
	},
	[3600170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600160,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600170,
		Level = 17,
		SoulId = 20010036,
		Name = getI18NValue(180489934),
		Order = getI18NValue(180489933),
		PieceIdList = {
			3600171,
			3600172,
			3600173,
			3600174
		},
		MemoryReward = {
			2,
			30,
			5036117,
			1
		}
	},
	[3600180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_SakuyaMako_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_QingHao/QingHao.png",
		PreMemoryChapter = 3600170,
		Movie = "/Memory/QingHao/Memory_QingHao_Chapter00.mp4",
		Id = 3600180,
		Level = 18,
		SoulId = 20010036,
		Name = getI18NValue(180489936),
		Order = getI18NValue(180489935),
		PieceIdList = {
			3600181,
			3600182,
			3600183,
			3600184
		},
		MemoryReward = {
			2,
			30,
			5036118,
			1
		}
	},
	[3700010] = {
		ResourceSize = "5M",
		Scene = 10370101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010037,
		Name = getI18NValue(180489938),
		Order = getI18NValue(180489937),
		PieceIdList = {
			3700011,
			3700012,
			3700013,
			3700014
		},
		MemoryReward = {
			2,
			30,
			5037101,
			1
		}
	},
	[3700020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700010,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter02.mp4",
		Id = 3700020,
		Level = 2,
		SoulId = 20010037,
		Name = getI18NValue(180489940),
		Order = getI18NValue(180489939),
		PieceIdList = {
			3700021,
			3700022,
			3700023,
			3700024
		},
		MemoryReward = {
			2,
			30,
			5037102,
			1
		}
	},
	[3700030] = {
		ResourceSize = "5M",
		Scene = 10370301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700020,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700030,
		Level = 3,
		SoulId = 20010037,
		Name = getI18NValue(180489942),
		Order = getI18NValue(180489941),
		PieceIdList = {
			3700031,
			3700032,
			3700033,
			3700034
		},
		MemoryReward = {
			2,
			30,
			5037103,
			1
		}
	},
	[3700040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700030,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter04.mp4",
		Id = 3700040,
		Level = 4,
		SoulId = 20010037,
		Name = getI18NValue(180489944),
		Order = getI18NValue(180489943),
		PieceIdList = {
			3700041,
			3700042,
			3700043,
			3700044
		},
		MemoryReward = {
			2,
			30,
			5037104,
			1
		}
	},
	[3700050] = {
		ResourceSize = "5M",
		Scene = 10370501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700040,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700050,
		Level = 5,
		SoulId = 20010037,
		Name = getI18NValue(180489946),
		Order = getI18NValue(180489945),
		PieceIdList = {
			3700051,
			3700052,
			3700053,
			3700054
		},
		MemoryReward = {
			2,
			30,
			5037105,
			1
		}
	},
	[3700060] = {
		ResourceSize = "5M",
		Scene = 10370601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700050,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700060,
		Level = 6,
		SoulId = 20010037,
		Name = getI18NValue(180489948),
		Order = getI18NValue(180489947),
		PieceIdList = {
			3700061,
			3700062,
			3700063,
			3700064
		},
		MemoryReward = {
			2,
			30,
			5037106,
			1
		}
	},
	[3700070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700060,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter07.mp4",
		Id = 3700070,
		Level = 7,
		SoulId = 20010037,
		Name = getI18NValue(180489950),
		Order = getI18NValue(180489949),
		PieceIdList = {
			3700071,
			3700072,
			3700073,
			3700074
		},
		MemoryReward = {
			2,
			30,
			5037107,
			1
		}
	},
	[3700080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700070,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter08.mp4",
		Id = 3700080,
		Level = 8,
		SoulId = 20010037,
		Name = getI18NValue(180489952),
		Order = getI18NValue(180489951),
		PieceIdList = {
			3700081,
			3700082,
			3700083,
			3700084
		},
		MemoryReward = {
			2,
			30,
			5037108,
			1
		}
	},
	[3700090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700080,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700090,
		Level = 9,
		SoulId = 20010037,
		Name = getI18NValue(180489954),
		Order = getI18NValue(180489953),
		PieceIdList = {
			3700091,
			3700092,
			3700093,
			3700094
		},
		MemoryReward = {
			2,
			30,
			5037109,
			1
		}
	},
	[3700100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700090,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700100,
		Level = 10,
		SoulId = 20010037,
		Name = getI18NValue(180489956),
		Order = getI18NValue(180489955),
		PieceIdList = {
			3700101,
			3700102,
			3700103,
			3700104
		},
		MemoryReward = {
			2,
			30,
			5037110,
			1
		}
	},
	[3700110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700100,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700110,
		Level = 11,
		SoulId = 20010037,
		Name = getI18NValue(180489958),
		Order = getI18NValue(180489957),
		PieceIdList = {
			3700111,
			3700112,
			3700113,
			3700114
		},
		MemoryReward = {
			2,
			30,
			5037111,
			1
		}
	},
	[3700120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700110,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700120,
		Level = 12,
		SoulId = 20010037,
		Name = getI18NValue(180489960),
		Order = getI18NValue(180489959),
		PieceIdList = {
			3700121,
			3700122,
			3700123,
			3700124
		},
		MemoryReward = {
			2,
			30,
			5037112,
			1
		}
	},
	[3700130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700120,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700130,
		Level = 13,
		SoulId = 20010037,
		Name = getI18NValue(180489962),
		Order = getI18NValue(180489961),
		PieceIdList = {
			3700131,
			3700132,
			3700133,
			3700134
		},
		MemoryReward = {
			2,
			30,
			5037113,
			1
		}
	},
	[3700140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700130,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700140,
		Level = 14,
		SoulId = 20010037,
		Name = getI18NValue(180489964),
		Order = getI18NValue(180489963),
		PieceIdList = {
			3700141,
			3700142,
			3700143,
			3700144
		},
		MemoryReward = {
			2,
			30,
			5037114,
			1
		}
	},
	[3700150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700140,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700150,
		Level = 15,
		SoulId = 20010037,
		Name = getI18NValue(180489966),
		Order = getI18NValue(180489965),
		PieceIdList = {
			3700151,
			3700152,
			3700153,
			3700154
		},
		MemoryReward = {
			2,
			30,
			5037115,
			1
		}
	},
	[3700160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700150,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700160,
		Level = 16,
		SoulId = 20010037,
		Name = getI18NValue(180489968),
		Order = getI18NValue(180489967),
		PieceIdList = {
			3700161,
			3700162,
			3700163,
			3700164
		},
		MemoryReward = {
			2,
			30,
			5037116,
			1
		}
	},
	[3700170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700160,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700170,
		Level = 17,
		SoulId = 20010037,
		Name = getI18NValue(180489970),
		Order = getI18NValue(180489969),
		PieceIdList = {
			3700171,
			3700172,
			3700173,
			3700174
		},
		MemoryReward = {
			2,
			30,
			5037117,
			1
		}
	},
	[3700180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_JoanofArcLoire/JoanofArcLoire.png",
		PreMemoryChapter = 3700170,
		Movie = "/Memory/JoanofArcLoire/Memory_JoanofArcLoire_Chapter00.mp4",
		Id = 3700180,
		Level = 18,
		SoulId = 20010037,
		Name = getI18NValue(180489972),
		Order = getI18NValue(180489971),
		PieceIdList = {
			3700181,
			3700182,
			3700183,
			3700184
		},
		MemoryReward = {
			2,
			30,
			5037118,
			1
		}
	},
	[3800010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter01.mp4",
		Id = 3800010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010038,
		Name = getI18NValue(180489974),
		Order = getI18NValue(180489973),
		PieceIdList = {
			3800011,
			3800012,
			3800013,
			3800014
		},
		MemoryReward = {
			2,
			30,
			5038101,
			1
		}
	},
	[3800020] = {
		ResourceSize = "5M",
		Scene = 10380201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800010,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800020,
		Level = 2,
		SoulId = 20010038,
		Name = getI18NValue(180489976),
		Order = getI18NValue(180489975),
		PieceIdList = {
			3800021,
			3800022,
			3800023,
			3800024
		},
		MemoryReward = {
			2,
			30,
			5038102,
			1
		}
	},
	[3800030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800020,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter03.mp4",
		Id = 3800030,
		Level = 3,
		SoulId = 20010038,
		Name = getI18NValue(180489978),
		Order = getI18NValue(180489977),
		PieceIdList = {
			3800031,
			3800032,
			3800033,
			3800034
		},
		MemoryReward = {
			2,
			30,
			5038103,
			1
		}
	},
	[3800040] = {
		ResourceSize = "5M",
		Scene = 10380401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800030,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800040,
		Level = 4,
		SoulId = 20010038,
		Name = getI18NValue(180489980),
		Order = getI18NValue(180489979),
		PieceIdList = {
			3800041,
			3800042,
			3800043,
			3800044
		},
		MemoryReward = {
			2,
			30,
			5038104,
			1
		}
	},
	[3800050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800040,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter05.mp4",
		Id = 3800050,
		Level = 5,
		SoulId = 20010038,
		Name = getI18NValue(180489982),
		Order = getI18NValue(180489981),
		PieceIdList = {
			3800051,
			3800052,
			3800053,
			3800054
		},
		MemoryReward = {
			2,
			30,
			5038105,
			1
		}
	},
	[3800060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800050,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter06.mp4",
		Id = 3800060,
		Level = 6,
		SoulId = 20010038,
		Name = getI18NValue(180489984),
		Order = getI18NValue(180489983),
		PieceIdList = {
			3800061,
			3800062,
			3800063,
			3800064
		},
		MemoryReward = {
			2,
			30,
			5038106,
			1
		}
	},
	[3800070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800060,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter07.mp4",
		Id = 3800070,
		Level = 7,
		SoulId = 20010038,
		Name = getI18NValue(180489986),
		Order = getI18NValue(180489985),
		PieceIdList = {
			3800071,
			3800072,
			3800073,
			3800074
		},
		MemoryReward = {
			2,
			30,
			5038107,
			1
		}
	},
	[3800080] = {
		ResourceSize = "5M",
		Scene = 10380801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800070,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800080,
		Level = 8,
		SoulId = 20010038,
		Name = getI18NValue(180489988),
		Order = getI18NValue(180489987),
		PieceIdList = {
			3800081,
			3800082,
			3800083,
			3800084
		},
		MemoryReward = {
			2,
			30,
			5038108,
			1
		}
	},
	[3800090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800080,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800090,
		Level = 9,
		SoulId = 20010038,
		Name = getI18NValue(180489990),
		Order = getI18NValue(180489989),
		PieceIdList = {
			3800091,
			3800092,
			3800093,
			3800094
		},
		MemoryReward = {
			2,
			30,
			5038109,
			1
		}
	},
	[3800100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800090,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800100,
		Level = 10,
		SoulId = 20010038,
		Name = getI18NValue(180489992),
		Order = getI18NValue(180489991),
		PieceIdList = {
			3800101,
			3800102,
			3800103,
			3800104
		},
		MemoryReward = {
			2,
			30,
			5038110,
			1
		}
	},
	[3800110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800100,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800110,
		Level = 11,
		SoulId = 20010038,
		Name = getI18NValue(180489994),
		Order = getI18NValue(180489993),
		PieceIdList = {
			3800111,
			3800112,
			3800113,
			3800114
		},
		MemoryReward = {
			2,
			30,
			5038111,
			1
		}
	},
	[3800120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800110,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800120,
		Level = 12,
		SoulId = 20010038,
		Name = getI18NValue(180489996),
		Order = getI18NValue(180489995),
		PieceIdList = {
			3800121,
			3800122,
			3800123,
			3800124
		},
		MemoryReward = {
			2,
			30,
			5038112,
			1
		}
	},
	[3800130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800120,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800130,
		Level = 13,
		SoulId = 20010038,
		Name = getI18NValue(180489998),
		Order = getI18NValue(180489997),
		PieceIdList = {
			3800131,
			3800132,
			3800133,
			3800134
		},
		MemoryReward = {
			2,
			30,
			5038113,
			1
		}
	},
	[3800140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800130,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800140,
		Level = 14,
		SoulId = 20010038,
		Name = getI18NValue(180490000),
		Order = getI18NValue(180489999),
		PieceIdList = {
			3800141,
			3800142,
			3800143,
			3800144
		},
		MemoryReward = {
			2,
			30,
			5038114,
			1
		}
	},
	[3800150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800140,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800150,
		Level = 15,
		SoulId = 20010038,
		Name = getI18NValue(180490002),
		Order = getI18NValue(180490001),
		PieceIdList = {
			3800151,
			3800152,
			3800153,
			3800154
		},
		MemoryReward = {
			2,
			30,
			5038115,
			1
		}
	},
	[3800160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800150,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800160,
		Level = 16,
		SoulId = 20010038,
		Name = getI18NValue(180490004),
		Order = getI18NValue(180490003),
		PieceIdList = {
			3800161,
			3800162,
			3800163,
			3800164
		},
		MemoryReward = {
			2,
			30,
			5038116,
			1
		}
	},
	[3800170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800160,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800170,
		Level = 17,
		SoulId = 20010038,
		Name = getI18NValue(180490006),
		Order = getI18NValue(180490005),
		PieceIdList = {
			3800171,
			3800172,
			3800173,
			3800174
		},
		MemoryReward = {
			2,
			30,
			5038117,
			1
		}
	},
	[3800180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_LightCloud/LightCloud.png",
		PreMemoryChapter = 3800170,
		Movie = "/Memory/LightCloud/Memory_LightCloud_Chapter00.mp4",
		Id = 3800180,
		Level = 18,
		SoulId = 20010038,
		Name = getI18NValue(180490008),
		Order = getI18NValue(180490007),
		PieceIdList = {
			3800181,
			3800182,
			3800183,
			3800184
		},
		MemoryReward = {
			2,
			30,
			5038118,
			1
		}
	},
	[3900010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter01.mp4",
		Id = 3900010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010039,
		Name = getI18NValue(180490010),
		Order = getI18NValue(180490009),
		PieceIdList = {
			3900011,
			3900012,
			3900013,
			3900014
		},
		MemoryReward = {
			2,
			30,
			5039101,
			1
		}
	},
	[3900020] = {
		ResourceSize = "5M",
		Scene = 10390201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900010,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900020,
		Level = 2,
		SoulId = 20010039,
		Name = getI18NValue(180490012),
		Order = getI18NValue(180490011),
		PieceIdList = {
			3900021,
			3900022,
			3900023,
			3900024
		},
		MemoryReward = {
			2,
			30,
			5039102,
			1
		}
	},
	[3900030] = {
		ResourceSize = "5M",
		Scene = 10390301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900020,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900030,
		Level = 3,
		SoulId = 20010039,
		Name = getI18NValue(180490014),
		Order = getI18NValue(180490013),
		PieceIdList = {
			3900031,
			3900032,
			3900033,
			3900034
		},
		MemoryReward = {
			2,
			30,
			5039103,
			1
		}
	},
	[3900040] = {
		ResourceSize = "5M",
		Scene = 10390401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900030,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900040,
		Level = 4,
		SoulId = 20010039,
		Name = getI18NValue(180490016),
		Order = getI18NValue(180490015),
		PieceIdList = {
			3900041,
			3900042,
			3900043,
			3900044
		},
		MemoryReward = {
			2,
			30,
			5039104,
			1
		}
	},
	[3900050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900040,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter05.mp4",
		Id = 3900050,
		Level = 5,
		SoulId = 20010039,
		Name = getI18NValue(180490018),
		Order = getI18NValue(180490017),
		PieceIdList = {
			3900051,
			3900052,
			3900053,
			3900054
		},
		MemoryReward = {
			2,
			30,
			5039105,
			1
		}
	},
	[3900060] = {
		ResourceSize = "5M",
		Scene = 10390601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900050,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900060,
		Level = 6,
		SoulId = 20010039,
		Name = getI18NValue(180490020),
		Order = getI18NValue(180490019),
		PieceIdList = {
			3900061,
			3900062,
			3900063,
			3900064
		},
		MemoryReward = {
			2,
			30,
			5039106,
			1
		}
	},
	[3900070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900060,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter07.mp4",
		Id = 3900070,
		Level = 7,
		SoulId = 20010039,
		Name = getI18NValue(180490022),
		Order = getI18NValue(180490021),
		PieceIdList = {
			3900071,
			3900072,
			3900073,
			3900074
		},
		MemoryReward = {
			2,
			30,
			5039107,
			1
		}
	},
	[3900080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900070,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter08.mp4",
		Id = 3900080,
		Level = 8,
		SoulId = 20010039,
		Name = getI18NValue(180490024),
		Order = getI18NValue(180490023),
		PieceIdList = {
			3900081,
			3900082,
			3900083,
			3900084
		},
		MemoryReward = {
			2,
			30,
			5039108,
			1
		}
	},
	[3900090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900080,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900090,
		Level = 9,
		SoulId = 20010039,
		Name = getI18NValue(180490026),
		Order = getI18NValue(180490025),
		PieceIdList = {
			3900091,
			3900092,
			3900093,
			3900094
		},
		MemoryReward = {
			2,
			30,
			5039109,
			1
		}
	},
	[3900100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900090,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900100,
		Level = 10,
		SoulId = 20010039,
		Name = getI18NValue(180490028),
		Order = getI18NValue(180490027),
		PieceIdList = {
			3900101,
			3900102,
			3900103,
			3900104
		},
		MemoryReward = {
			2,
			30,
			5039110,
			1
		}
	},
	[3900110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900100,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900110,
		Level = 11,
		SoulId = 20010039,
		Name = getI18NValue(180490030),
		Order = getI18NValue(180490029),
		PieceIdList = {
			3900111,
			3900112,
			3900113,
			3900114
		},
		MemoryReward = {
			2,
			30,
			5039111,
			1
		}
	},
	[3900120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900110,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900120,
		Level = 12,
		SoulId = 20010039,
		Name = getI18NValue(180490032),
		Order = getI18NValue(180490031),
		PieceIdList = {
			3900121,
			3900122,
			3900123,
			3900124
		},
		MemoryReward = {
			2,
			30,
			5039112,
			1
		}
	},
	[3900130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900120,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900130,
		Level = 13,
		SoulId = 20010039,
		Name = getI18NValue(180490034),
		Order = getI18NValue(180490033),
		PieceIdList = {
			3900131,
			3900132,
			3900133,
			3900134
		},
		MemoryReward = {
			2,
			30,
			5039113,
			1
		}
	},
	[3900140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900130,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900140,
		Level = 14,
		SoulId = 20010039,
		Name = getI18NValue(180490036),
		Order = getI18NValue(180490035),
		PieceIdList = {
			3900141,
			3900142,
			3900143,
			3900144
		},
		MemoryReward = {
			2,
			30,
			5039114,
			1
		}
	},
	[3900150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900140,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900150,
		Level = 15,
		SoulId = 20010039,
		Name = getI18NValue(180490038),
		Order = getI18NValue(180490037),
		PieceIdList = {
			3900151,
			3900152,
			3900153,
			3900154
		},
		MemoryReward = {
			2,
			30,
			5039115,
			1
		}
	},
	[3900160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900150,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900160,
		Level = 16,
		SoulId = 20010039,
		Name = getI18NValue(180490040),
		Order = getI18NValue(180490039),
		PieceIdList = {
			3900161,
			3900162,
			3900163,
			3900164
		},
		MemoryReward = {
			2,
			30,
			5039116,
			1
		}
	},
	[3900170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900160,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900170,
		Level = 17,
		SoulId = 20010039,
		Name = getI18NValue(180490042),
		Order = getI18NValue(180490041),
		PieceIdList = {
			3900171,
			3900172,
			3900173,
			3900174
		},
		MemoryReward = {
			2,
			30,
			5039117,
			1
		}
	},
	[3900180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Antonina/Antonina.png",
		PreMemoryChapter = 3900170,
		Movie = "/Memory/Antonina/Memory_Antonina_Chapter00.mp4",
		Id = 3900180,
		Level = 18,
		SoulId = 20010039,
		Name = getI18NValue(180490044),
		Order = getI18NValue(180490043),
		PieceIdList = {
			3900181,
			3900182,
			3900183,
			3900184
		},
		MemoryReward = {
			2,
			30,
			5039118,
			1
		}
	},
	[4000010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter01.mp4",
		Id = 4000010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010040,
		Name = getI18NValue(180490046),
		Order = getI18NValue(180490045),
		PieceIdList = {
			4000011,
			4000012,
			4000013,
			4000014
		},
		MemoryReward = {
			2,
			30,
			5040101,
			1
		}
	},
	[4000020] = {
		ResourceSize = "5M",
		Scene = 10400201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000010,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000020,
		Level = 2,
		SoulId = 20010040,
		Name = getI18NValue(180490048),
		Order = getI18NValue(180490047),
		PieceIdList = {
			4000021,
			4000022,
			4000023,
			4000024
		},
		MemoryReward = {
			2,
			30,
			5040102,
			1
		}
	},
	[4000030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000020,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter03.mp4",
		Id = 4000030,
		Level = 3,
		SoulId = 20010040,
		Name = getI18NValue(180490050),
		Order = getI18NValue(180490049),
		PieceIdList = {
			4000031,
			4000032,
			4000033,
			4000034
		},
		MemoryReward = {
			2,
			30,
			5040103,
			1
		}
	},
	[4000040] = {
		ResourceSize = "5M",
		Scene = 10400401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000030,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000040,
		Level = 4,
		SoulId = 20010040,
		Name = getI18NValue(180490052),
		Order = getI18NValue(180490051),
		PieceIdList = {
			4000041,
			4000042,
			4000043,
			4000044
		},
		MemoryReward = {
			2,
			30,
			5040104,
			1
		}
	},
	[4000050] = {
		ResourceSize = "5M",
		Scene = 10400501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000040,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000050,
		Level = 5,
		SoulId = 20010040,
		Name = getI18NValue(180490054),
		Order = getI18NValue(180490053),
		PieceIdList = {
			4000051,
			4000052,
			4000053,
			4000054
		},
		MemoryReward = {
			2,
			30,
			5040105,
			1
		}
	},
	[4000060] = {
		ResourceSize = "5M",
		Scene = 10400601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000050,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000060,
		Level = 6,
		SoulId = 20010040,
		Name = getI18NValue(180490056),
		Order = getI18NValue(180490055),
		PieceIdList = {
			4000061,
			4000062,
			4000063,
			4000064
		},
		MemoryReward = {
			2,
			30,
			5040106,
			1
		}
	},
	[4000070] = {
		ResourceSize = "5M",
		Scene = 10400701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000060,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000070,
		Level = 7,
		SoulId = 20010040,
		Name = getI18NValue(180490058),
		Order = getI18NValue(180490057),
		PieceIdList = {
			4000071,
			4000072,
			4000073,
			4000074
		},
		MemoryReward = {
			2,
			30,
			5040107,
			1
		}
	},
	[4000080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000070,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter08.mp4",
		Id = 4000080,
		Level = 8,
		SoulId = 20010040,
		Name = getI18NValue(180490060),
		Order = getI18NValue(180490059),
		PieceIdList = {
			4000081,
			4000082,
			4000083,
			4000084
		},
		MemoryReward = {
			2,
			30,
			5040108,
			1
		}
	},
	[4000090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000080,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000090,
		Level = 9,
		SoulId = 20010040,
		Name = getI18NValue(180490062),
		Order = getI18NValue(180490061),
		PieceIdList = {
			4000091,
			4000092,
			4000093,
			4000094
		},
		MemoryReward = {
			2,
			30,
			5040109,
			1
		}
	},
	[4000100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000090,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000100,
		Level = 10,
		SoulId = 20010040,
		Name = getI18NValue(180490064),
		Order = getI18NValue(180490063),
		PieceIdList = {
			4000101,
			4000102,
			4000103,
			4000104
		},
		MemoryReward = {
			2,
			30,
			5040110,
			1
		}
	},
	[4000110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000100,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000110,
		Level = 11,
		SoulId = 20010040,
		Name = getI18NValue(180490066),
		Order = getI18NValue(180490065),
		PieceIdList = {
			4000111,
			4000112,
			4000113,
			4000114
		},
		MemoryReward = {
			2,
			30,
			5040111,
			1
		}
	},
	[4000120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000110,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000120,
		Level = 12,
		SoulId = 20010040,
		Name = getI18NValue(180490068),
		Order = getI18NValue(180490067),
		PieceIdList = {
			4000121,
			4000122,
			4000123,
			4000124
		},
		MemoryReward = {
			2,
			30,
			5040112,
			1
		}
	},
	[4000130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000120,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000130,
		Level = 13,
		SoulId = 20010040,
		Name = getI18NValue(180490070),
		Order = getI18NValue(180490069),
		PieceIdList = {
			4000131,
			4000132,
			4000133,
			4000134
		},
		MemoryReward = {
			2,
			30,
			5040113,
			1
		}
	},
	[4000140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000130,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000140,
		Level = 14,
		SoulId = 20010040,
		Name = getI18NValue(180490072),
		Order = getI18NValue(180490071),
		PieceIdList = {
			4000141,
			4000142,
			4000143,
			4000144
		},
		MemoryReward = {
			2,
			30,
			5040114,
			1
		}
	},
	[4000150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000140,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000150,
		Level = 15,
		SoulId = 20010040,
		Name = getI18NValue(180490074),
		Order = getI18NValue(180490073),
		PieceIdList = {
			4000151,
			4000152,
			4000153,
			4000154
		},
		MemoryReward = {
			2,
			30,
			5040115,
			1
		}
	},
	[4000160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000150,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000160,
		Level = 16,
		SoulId = 20010040,
		Name = getI18NValue(180490076),
		Order = getI18NValue(180490075),
		PieceIdList = {
			4000161,
			4000162,
			4000163,
			4000164
		},
		MemoryReward = {
			2,
			30,
			5040116,
			1
		}
	},
	[4000170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000160,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000170,
		Level = 17,
		SoulId = 20010040,
		Name = getI18NValue(180490078),
		Order = getI18NValue(180490077),
		PieceIdList = {
			4000171,
			4000172,
			4000173,
			4000174
		},
		MemoryReward = {
			2,
			30,
			5040117,
			1
		}
	},
	[4000180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Philodoxy/Philodoxy.png",
		PreMemoryChapter = 4000170,
		Movie = "/Memory/Philodoxy/Memory_Philodoxy_Chapter00.mp4",
		Id = 4000180,
		Level = 18,
		SoulId = 20010040,
		Name = getI18NValue(180490080),
		Order = getI18NValue(180490079),
		PieceIdList = {
			4000181,
			4000182,
			4000183,
			4000184
		},
		MemoryReward = {
			2,
			30,
			5040118,
			1
		}
	},
	[4100010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter01.mp4",
		Id = 4100010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010041,
		Name = getI18NValue(180490082),
		Order = getI18NValue(180490081),
		PieceIdList = {
			4100011,
			4100012,
			4100013,
			4100014
		},
		MemoryReward = {
			2,
			30,
			5041101,
			1
		}
	},
	[4100020] = {
		ResourceSize = "5M",
		Scene = 10410201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100010,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100020,
		Level = 2,
		SoulId = 20010041,
		Name = getI18NValue(180490084),
		Order = getI18NValue(180490083),
		PieceIdList = {
			4100021,
			4100022,
			4100023,
			4100024
		},
		MemoryReward = {
			2,
			30,
			5041102,
			1
		}
	},
	[4100030] = {
		ResourceSize = "5M",
		Scene = 10410301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100020,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100030,
		Level = 3,
		SoulId = 20010041,
		Name = getI18NValue(180490086),
		Order = getI18NValue(180490085),
		PieceIdList = {
			4100031,
			4100032,
			4100033,
			4100034
		},
		MemoryReward = {
			2,
			30,
			5041103,
			1
		}
	},
	[4100040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100030,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter04.mp4",
		Id = 4100040,
		Level = 4,
		SoulId = 20010041,
		Name = getI18NValue(180490088),
		Order = getI18NValue(180490087),
		PieceIdList = {
			4100041,
			4100042,
			4100043,
			4100044
		},
		MemoryReward = {
			2,
			30,
			5041104,
			1
		}
	},
	[4100050] = {
		ResourceSize = "5M",
		Scene = 10410501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100040,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100050,
		Level = 5,
		SoulId = 20010041,
		Name = getI18NValue(180490090),
		Order = getI18NValue(180490089),
		PieceIdList = {
			4100051,
			4100052,
			4100053,
			4100054
		},
		MemoryReward = {
			2,
			30,
			5041105,
			1
		}
	},
	[4100060] = {
		ResourceSize = "5M",
		Scene = 10410601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100050,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100060,
		Level = 6,
		SoulId = 20010041,
		Name = getI18NValue(180490092),
		Order = getI18NValue(180490091),
		PieceIdList = {
			4100061,
			4100062,
			4100063,
			4100064
		},
		MemoryReward = {
			2,
			30,
			5041106,
			1
		}
	},
	[4100070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100060,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter07.mp4",
		Id = 4100070,
		Level = 7,
		SoulId = 20010041,
		Name = getI18NValue(180490094),
		Order = getI18NValue(180490093),
		PieceIdList = {
			4100071,
			4100072,
			4100073,
			4100074
		},
		MemoryReward = {
			2,
			30,
			5041107,
			1
		}
	},
	[4100080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100070,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter08.mp4",
		Id = 4100080,
		Level = 8,
		SoulId = 20010041,
		Name = getI18NValue(180490096),
		Order = getI18NValue(180490095),
		PieceIdList = {
			4100081,
			4100082,
			4100083,
			4100084
		},
		MemoryReward = {
			2,
			30,
			5041108,
			1
		}
	},
	[4100090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100080,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100090,
		Level = 9,
		SoulId = 20010041,
		Name = getI18NValue(180490098),
		Order = getI18NValue(180490097),
		PieceIdList = {
			4100091,
			4100092,
			4100093,
			4100094
		},
		MemoryReward = {
			2,
			30,
			5041109,
			1
		}
	},
	[4100100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100090,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100100,
		Level = 10,
		SoulId = 20010041,
		Name = getI18NValue(180490100),
		Order = getI18NValue(180490099),
		PieceIdList = {
			4100101,
			4100102,
			4100103,
			4100104
		},
		MemoryReward = {
			2,
			30,
			5041110,
			1
		}
	},
	[4100110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100100,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100110,
		Level = 11,
		SoulId = 20010041,
		Name = getI18NValue(180490102),
		Order = getI18NValue(180490101),
		PieceIdList = {
			4100111,
			4100112,
			4100113,
			4100114
		},
		MemoryReward = {
			2,
			30,
			5041111,
			1
		}
	},
	[4100120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100110,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100120,
		Level = 12,
		SoulId = 20010041,
		Name = getI18NValue(180490104),
		Order = getI18NValue(180490103),
		PieceIdList = {
			4100121,
			4100122,
			4100123,
			4100124
		},
		MemoryReward = {
			2,
			30,
			5041112,
			1
		}
	},
	[4100130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100120,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100130,
		Level = 13,
		SoulId = 20010041,
		Name = getI18NValue(180490106),
		Order = getI18NValue(180490105),
		PieceIdList = {
			4100131,
			4100132,
			4100133,
			4100134
		},
		MemoryReward = {
			2,
			30,
			5041113,
			1
		}
	},
	[4100140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100130,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100140,
		Level = 14,
		SoulId = 20010041,
		Name = getI18NValue(180490108),
		Order = getI18NValue(180490107),
		PieceIdList = {
			4100141,
			4100142,
			4100143,
			4100144
		},
		MemoryReward = {
			2,
			30,
			5041114,
			1
		}
	},
	[4100150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100140,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100150,
		Level = 15,
		SoulId = 20010041,
		Name = getI18NValue(180490110),
		Order = getI18NValue(180490109),
		PieceIdList = {
			4100151,
			4100152,
			4100153,
			4100154
		},
		MemoryReward = {
			2,
			30,
			5041115,
			1
		}
	},
	[4100160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100150,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100160,
		Level = 16,
		SoulId = 20010041,
		Name = getI18NValue(180490112),
		Order = getI18NValue(180490111),
		PieceIdList = {
			4100161,
			4100162,
			4100163,
			4100164
		},
		MemoryReward = {
			2,
			30,
			5041116,
			1
		}
	},
	[4100170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100160,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100170,
		Level = 17,
		SoulId = 20010041,
		Name = getI18NValue(180490114),
		Order = getI18NValue(180490113),
		PieceIdList = {
			4100171,
			4100172,
			4100173,
			4100174
		},
		MemoryReward = {
			2,
			30,
			5041117,
			1
		}
	},
	[4100180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Ennis_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Erinnern/Erinnern.png",
		PreMemoryChapter = 4100170,
		Movie = "/Memory/Erinnern/Memory_Erinnern_Chapter00.mp4",
		Id = 4100180,
		Level = 18,
		SoulId = 20010041,
		Name = getI18NValue(180490116),
		Order = getI18NValue(180490115),
		PieceIdList = {
			4100181,
			4100182,
			4100183,
			4100184
		},
		MemoryReward = {
			2,
			30,
			5041118,
			1
		}
	},
	[4200010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter01.mp4",
		Id = 4200010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010042,
		Name = getI18NValue(180490118),
		Order = getI18NValue(180490117),
		PieceIdList = {
			4200011,
			4200012,
			4200013,
			4200014
		},
		MemoryReward = {
			2,
			30,
			5042101,
			1
		}
	},
	[4200020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200010,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter02.mp4",
		Id = 4200020,
		Level = 2,
		SoulId = 20010042,
		Name = getI18NValue(180490120),
		Order = getI18NValue(180490119),
		PieceIdList = {
			4200021,
			4200022,
			4200023,
			4200024
		},
		MemoryReward = {
			2,
			30,
			5042102,
			1
		}
	},
	[4200030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200020,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter03.mp4",
		Id = 4200030,
		Level = 3,
		SoulId = 20010042,
		Name = getI18NValue(180490122),
		Order = getI18NValue(180490121),
		PieceIdList = {
			4200031,
			4200032,
			4200033,
			4200034
		},
		MemoryReward = {
			2,
			30,
			5042103,
			1
		}
	},
	[4200040] = {
		ResourceSize = "5M",
		Scene = 10420401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200030,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200040,
		Level = 4,
		SoulId = 20010042,
		Name = getI18NValue(180490124),
		Order = getI18NValue(180490123),
		PieceIdList = {
			4200041,
			4200042,
			4200043,
			4200044
		},
		MemoryReward = {
			2,
			30,
			5042104,
			1
		}
	},
	[4200050] = {
		ResourceSize = "5M",
		Scene = 10420501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200040,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200050,
		Level = 5,
		SoulId = 20010042,
		Name = getI18NValue(180490126),
		Order = getI18NValue(180490125),
		PieceIdList = {
			4200051,
			4200052,
			4200053,
			4200054
		},
		MemoryReward = {
			2,
			30,
			5042105,
			1
		}
	},
	[4200060] = {
		ResourceSize = "5M",
		Scene = 10420601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200050,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200060,
		Level = 6,
		SoulId = 20010042,
		Name = getI18NValue(180490128),
		Order = getI18NValue(180490127),
		PieceIdList = {
			4200061,
			4200062,
			4200063,
			4200064
		},
		MemoryReward = {
			2,
			30,
			5042106,
			1
		}
	},
	[4200070] = {
		ResourceSize = "5M",
		Scene = 10420701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200060,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200070,
		Level = 7,
		SoulId = 20010042,
		Name = getI18NValue(180490130),
		Order = getI18NValue(180490129),
		PieceIdList = {
			4200071,
			4200072,
			4200073,
			4200074
		},
		MemoryReward = {
			2,
			30,
			5042107,
			1
		}
	},
	[4200080] = {
		ResourceSize = "5M",
		Scene = 10420801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200070,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200080,
		Level = 8,
		SoulId = 20010042,
		Name = getI18NValue(180490132),
		Order = getI18NValue(180490131),
		PieceIdList = {
			4200081,
			4200082,
			4200083,
			4200084
		},
		MemoryReward = {
			2,
			30,
			5042108,
			1
		}
	},
	[4200090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200080,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200090,
		Level = 9,
		SoulId = 20010042,
		Name = getI18NValue(180490134),
		Order = getI18NValue(180490133),
		PieceIdList = {
			4200091,
			4200092,
			4200093,
			4200094
		},
		MemoryReward = {
			2,
			30,
			5042109,
			1
		}
	},
	[4200100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200090,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200100,
		Level = 10,
		SoulId = 20010042,
		Name = getI18NValue(180490136),
		Order = getI18NValue(180490135),
		PieceIdList = {
			4200101,
			4200102,
			4200103,
			4200104
		},
		MemoryReward = {
			2,
			30,
			5042110,
			1
		}
	},
	[4200110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200100,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200110,
		Level = 11,
		SoulId = 20010042,
		Name = getI18NValue(180490138),
		Order = getI18NValue(180490137),
		PieceIdList = {
			4200111,
			4200112,
			4200113,
			4200114
		},
		MemoryReward = {
			2,
			30,
			5042111,
			1
		}
	},
	[4200120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200110,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200120,
		Level = 12,
		SoulId = 20010042,
		Name = getI18NValue(180490140),
		Order = getI18NValue(180490139),
		PieceIdList = {
			4200121,
			4200122,
			4200123,
			4200124
		},
		MemoryReward = {
			2,
			30,
			5042112,
			1
		}
	},
	[4200130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200120,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200130,
		Level = 13,
		SoulId = 20010042,
		Name = getI18NValue(180490142),
		Order = getI18NValue(180490141),
		PieceIdList = {
			4200131,
			4200132,
			4200133,
			4200134
		},
		MemoryReward = {
			2,
			30,
			5042113,
			1
		}
	},
	[4200140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200130,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200140,
		Level = 14,
		SoulId = 20010042,
		Name = getI18NValue(180490144),
		Order = getI18NValue(180490143),
		PieceIdList = {
			4200141,
			4200142,
			4200143,
			4200144
		},
		MemoryReward = {
			2,
			30,
			5042114,
			1
		}
	},
	[4200150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200140,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200150,
		Level = 15,
		SoulId = 20010042,
		Name = getI18NValue(180490146),
		Order = getI18NValue(180490145),
		PieceIdList = {
			4200151,
			4200152,
			4200153,
			4200154
		},
		MemoryReward = {
			2,
			30,
			5042115,
			1
		}
	},
	[4200160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200150,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200160,
		Level = 16,
		SoulId = 20010042,
		Name = getI18NValue(180490148),
		Order = getI18NValue(180490147),
		PieceIdList = {
			4200161,
			4200162,
			4200163,
			4200164
		},
		MemoryReward = {
			2,
			30,
			5042116,
			1
		}
	},
	[4200170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200160,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200170,
		Level = 17,
		SoulId = 20010042,
		Name = getI18NValue(180490150),
		Order = getI18NValue(180490149),
		PieceIdList = {
			4200171,
			4200172,
			4200173,
			4200174
		},
		MemoryReward = {
			2,
			30,
			5042117,
			1
		}
	},
	[4200180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Aurora_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Haliva/Haliva.png",
		PreMemoryChapter = 4200170,
		Movie = "/Memory/Haliva/Memory_Haliva_Chapter00.mp4",
		Id = 4200180,
		Level = 18,
		SoulId = 20010042,
		Name = getI18NValue(180490152),
		Order = getI18NValue(180490151),
		PieceIdList = {
			4200181,
			4200182,
			4200183,
			4200184
		},
		MemoryReward = {
			2,
			30,
			5042118,
			1
		}
	},
	[4300010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter01.mp4",
		Id = 4300010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010043,
		Name = getI18NValue(180490154),
		Order = getI18NValue(180490153),
		PieceIdList = {
			4300011,
			4300012,
			4300013,
			4300014
		},
		MemoryReward = {
			2,
			30,
			5043101,
			1
		}
	},
	[4300020] = {
		ResourceSize = "5M",
		Scene = 10430201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300010,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300020,
		Level = 2,
		SoulId = 20010043,
		Name = getI18NValue(180490156),
		Order = getI18NValue(180490155),
		PieceIdList = {
			4300021,
			4300022,
			4300023,
			4300024
		},
		MemoryReward = {
			2,
			30,
			5043102,
			1
		}
	},
	[4300030] = {
		ResourceSize = "5M",
		Scene = 10430301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300020,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300030,
		Level = 3,
		SoulId = 20010043,
		Name = getI18NValue(180490158),
		Order = getI18NValue(180490157),
		PieceIdList = {
			4300031,
			4300032,
			4300033,
			4300034
		},
		MemoryReward = {
			2,
			30,
			5043103,
			1
		}
	},
	[4300040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300030,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter04.mp4",
		Id = 4300040,
		Level = 4,
		SoulId = 20010043,
		Name = getI18NValue(180490160),
		Order = getI18NValue(180490159),
		PieceIdList = {
			4300041,
			4300042,
			4300043,
			4300044
		},
		MemoryReward = {
			2,
			30,
			5043104,
			1
		}
	},
	[4300050] = {
		ResourceSize = "5M",
		Scene = 10430501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300040,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300050,
		Level = 5,
		SoulId = 20010043,
		Name = getI18NValue(180490162),
		Order = getI18NValue(180490161),
		PieceIdList = {
			4300051,
			4300052,
			4300053,
			4300054
		},
		MemoryReward = {
			2,
			30,
			5043105,
			1
		}
	},
	[4300060] = {
		ResourceSize = "5M",
		Scene = 10430601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300050,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300060,
		Level = 6,
		SoulId = 20010043,
		Name = getI18NValue(180490164),
		Order = getI18NValue(180490163),
		PieceIdList = {
			4300061,
			4300062,
			4300063,
			4300064
		},
		MemoryReward = {
			2,
			30,
			5043106,
			1
		}
	},
	[4300070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300060,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter07.mp4",
		Id = 4300070,
		Level = 7,
		SoulId = 20010043,
		Name = getI18NValue(180490166),
		Order = getI18NValue(180490165),
		PieceIdList = {
			4300071,
			4300072,
			4300073,
			4300074
		},
		MemoryReward = {
			2,
			30,
			5043107,
			1
		}
	},
	[4300080] = {
		ResourceSize = "5M",
		Scene = 10430801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300070,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300080,
		Level = 8,
		SoulId = 20010043,
		Name = getI18NValue(180490168),
		Order = getI18NValue(180490167),
		PieceIdList = {
			4300081,
			4300082,
			4300083,
			4300084
		},
		MemoryReward = {
			2,
			30,
			5043108,
			1
		}
	},
	[4300090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300080,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300090,
		Level = 9,
		SoulId = 20010043,
		Name = getI18NValue(180490170),
		Order = getI18NValue(180490169),
		PieceIdList = {
			4300091,
			4300092,
			4300093,
			4300094
		},
		MemoryReward = {
			2,
			30,
			5043109,
			1
		}
	},
	[4300100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300090,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300100,
		Level = 10,
		SoulId = 20010043,
		Name = getI18NValue(180490172),
		Order = getI18NValue(180490171),
		PieceIdList = {
			4300101,
			4300102,
			4300103,
			4300104
		},
		MemoryReward = {
			2,
			30,
			5043110,
			1
		}
	},
	[4300110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300100,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300110,
		Level = 11,
		SoulId = 20010043,
		Name = getI18NValue(180490174),
		Order = getI18NValue(180490173),
		PieceIdList = {
			4300111,
			4300112,
			4300113,
			4300114
		},
		MemoryReward = {
			2,
			30,
			5043111,
			1
		}
	},
	[4300120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300110,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300120,
		Level = 12,
		SoulId = 20010043,
		Name = getI18NValue(180490176),
		Order = getI18NValue(180490175),
		PieceIdList = {
			4300121,
			4300122,
			4300123,
			4300124
		},
		MemoryReward = {
			2,
			30,
			5043112,
			1
		}
	},
	[4300130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300120,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300130,
		Level = 13,
		SoulId = 20010043,
		Name = getI18NValue(180490178),
		Order = getI18NValue(180490177),
		PieceIdList = {
			4300131,
			4300132,
			4300133,
			4300134
		},
		MemoryReward = {
			2,
			30,
			5043113,
			1
		}
	},
	[4300140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300130,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300140,
		Level = 14,
		SoulId = 20010043,
		Name = getI18NValue(180490180),
		Order = getI18NValue(180490179),
		PieceIdList = {
			4300141,
			4300142,
			4300143,
			4300144
		},
		MemoryReward = {
			2,
			30,
			5043114,
			1
		}
	},
	[4300150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300140,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300150,
		Level = 15,
		SoulId = 20010043,
		Name = getI18NValue(180490182),
		Order = getI18NValue(180490181),
		PieceIdList = {
			4300151,
			4300152,
			4300153,
			4300154
		},
		MemoryReward = {
			2,
			30,
			5043115,
			1
		}
	},
	[4300160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300150,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300160,
		Level = 16,
		SoulId = 20010043,
		Name = getI18NValue(180490184),
		Order = getI18NValue(180490183),
		PieceIdList = {
			4300161,
			4300162,
			4300163,
			4300164
		},
		MemoryReward = {
			2,
			30,
			5043116,
			1
		}
	},
	[4300170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300160,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300170,
		Level = 17,
		SoulId = 20010043,
		Name = getI18NValue(180490186),
		Order = getI18NValue(180490185),
		PieceIdList = {
			4300171,
			4300172,
			4300173,
			4300174
		},
		MemoryReward = {
			2,
			30,
			5043117,
			1
		}
	},
	[4300180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Juewa_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_HeLing/HeLing.png",
		PreMemoryChapter = 4300170,
		Movie = "/Memory/HeLing/Memory_HeLing_Chapter00.mp4",
		Id = 4300180,
		Level = 18,
		SoulId = 20010043,
		Name = getI18NValue(180490188),
		Order = getI18NValue(180490187),
		PieceIdList = {
			4300181,
			4300182,
			4300183,
			4300184
		},
		MemoryReward = {
			2,
			30,
			5043118,
			1
		}
	},
	[4400010] = {
		ResourceSize = "5M",
		Scene = 10440101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010044,
		Name = getI18NValue(180490190),
		Order = getI18NValue(180490189),
		PieceIdList = {
			4400011,
			4400012,
			4400013,
			4400014
		},
		MemoryReward = {
			2,
			30,
			5044101,
			1
		}
	},
	[4400020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400010,
		Movie = "/Memory/Dora/Memory_Dora_Chapter02.mp4",
		Id = 4400020,
		Level = 2,
		SoulId = 20010044,
		Name = getI18NValue(180490192),
		Order = getI18NValue(180490191),
		PieceIdList = {
			4400021,
			4400022,
			4400023,
			4400024
		},
		MemoryReward = {
			2,
			30,
			5044102,
			1
		}
	},
	[4400030] = {
		ResourceSize = "5M",
		Scene = 10440301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400020,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400030,
		Level = 3,
		SoulId = 20010044,
		Name = getI18NValue(180490194),
		Order = getI18NValue(180490193),
		PieceIdList = {
			4400031,
			4400032,
			4400033,
			4400034
		},
		MemoryReward = {
			2,
			30,
			5044103,
			1
		}
	},
	[4400040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400030,
		Movie = "/Memory/Dora/Memory_Dora_Chapter04.mp4",
		Id = 4400040,
		Level = 4,
		SoulId = 20010044,
		Name = getI18NValue(180490196),
		Order = getI18NValue(180490195),
		PieceIdList = {
			4400041,
			4400042,
			4400043,
			4400044
		},
		MemoryReward = {
			2,
			30,
			5044104,
			1
		}
	},
	[4400050] = {
		ResourceSize = "5M",
		Scene = 10440501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400040,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400050,
		Level = 5,
		SoulId = 20010044,
		Name = getI18NValue(180490198),
		Order = getI18NValue(180490197),
		PieceIdList = {
			4400051,
			4400052,
			4400053,
			4400054
		},
		MemoryReward = {
			2,
			30,
			5044105,
			1
		}
	},
	[4400060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400050,
		Movie = "/Memory/Dora/Memory_Dora_Chapter06.mp4",
		Id = 4400060,
		Level = 6,
		SoulId = 20010044,
		Name = getI18NValue(180490200),
		Order = getI18NValue(180490199),
		PieceIdList = {
			4400061,
			4400062,
			4400063,
			4400064
		},
		MemoryReward = {
			2,
			30,
			5044106,
			1
		}
	},
	[4400070] = {
		ResourceSize = "5M",
		Scene = 10440701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400060,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400070,
		Level = 7,
		SoulId = 20010044,
		Name = getI18NValue(180490202),
		Order = getI18NValue(180490201),
		PieceIdList = {
			4400071,
			4400072,
			4400073,
			4400074
		},
		MemoryReward = {
			2,
			30,
			5044107,
			1
		}
	},
	[4400080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400070,
		Movie = "/Memory/Dora/Memory_Dora_Chapter08.mp4",
		Id = 4400080,
		Level = 8,
		SoulId = 20010044,
		Name = getI18NValue(180490204),
		Order = getI18NValue(180490203),
		PieceIdList = {
			4400081,
			4400082,
			4400083,
			4400084
		},
		MemoryReward = {
			2,
			30,
			5044108,
			1
		}
	},
	[4400090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400080,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400090,
		Level = 9,
		SoulId = 20010044,
		Name = getI18NValue(180490206),
		Order = getI18NValue(180490205),
		PieceIdList = {
			4400091,
			4400092,
			4400093,
			4400094
		},
		MemoryReward = {
			2,
			30,
			5044109,
			1
		}
	},
	[4400100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400090,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400100,
		Level = 10,
		SoulId = 20010044,
		Name = getI18NValue(180490208),
		Order = getI18NValue(180490207),
		PieceIdList = {
			4400101,
			4400102,
			4400103,
			4400104
		},
		MemoryReward = {
			2,
			30,
			5044110,
			1
		}
	},
	[4400110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400100,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400110,
		Level = 11,
		SoulId = 20010044,
		Name = getI18NValue(180490210),
		Order = getI18NValue(180490209),
		PieceIdList = {
			4400111,
			4400112,
			4400113,
			4400114
		},
		MemoryReward = {
			2,
			30,
			5044111,
			1
		}
	},
	[4400120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400110,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400120,
		Level = 12,
		SoulId = 20010044,
		Name = getI18NValue(180490212),
		Order = getI18NValue(180490211),
		PieceIdList = {
			4400121,
			4400122,
			4400123,
			4400124
		},
		MemoryReward = {
			2,
			30,
			5044112,
			1
		}
	},
	[4400130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400120,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400130,
		Level = 13,
		SoulId = 20010044,
		Name = getI18NValue(180490214),
		Order = getI18NValue(180490213),
		PieceIdList = {
			4400131,
			4400132,
			4400133,
			4400134
		},
		MemoryReward = {
			2,
			30,
			5044113,
			1
		}
	},
	[4400140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400130,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400140,
		Level = 14,
		SoulId = 20010044,
		Name = getI18NValue(180490216),
		Order = getI18NValue(180490215),
		PieceIdList = {
			4400141,
			4400142,
			4400143,
			4400144
		},
		MemoryReward = {
			2,
			30,
			5044114,
			1
		}
	},
	[4400150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400140,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400150,
		Level = 15,
		SoulId = 20010044,
		Name = getI18NValue(180490218),
		Order = getI18NValue(180490217),
		PieceIdList = {
			4400151,
			4400152,
			4400153,
			4400154
		},
		MemoryReward = {
			2,
			30,
			5044115,
			1
		}
	},
	[4400160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400150,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400160,
		Level = 16,
		SoulId = 20010044,
		Name = getI18NValue(180490220),
		Order = getI18NValue(180490219),
		PieceIdList = {
			4400161,
			4400162,
			4400163,
			4400164
		},
		MemoryReward = {
			2,
			30,
			5044116,
			1
		}
	},
	[4400170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400160,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400170,
		Level = 17,
		SoulId = 20010044,
		Name = getI18NValue(180490222),
		Order = getI18NValue(180490221),
		PieceIdList = {
			4400171,
			4400172,
			4400173,
			4400174
		},
		MemoryReward = {
			2,
			30,
			5044117,
			1
		}
	},
	[4400180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Dora/Dora.png",
		PreMemoryChapter = 4400170,
		Movie = "/Memory/Dora/Memory_Dora_Chapter00.mp4",
		Id = 4400180,
		Level = 18,
		SoulId = 20010044,
		Name = getI18NValue(180490224),
		Order = getI18NValue(180490223),
		PieceIdList = {
			4400181,
			4400182,
			4400183,
			4400184
		},
		MemoryReward = {
			2,
			30,
			5044118,
			1
		}
	},
	[4500010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter01.mp4",
		Id = 4500010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010045,
		Name = getI18NValue(180490226),
		Order = getI18NValue(180490225),
		PieceIdList = {
			4500011,
			4500012,
			4500013,
			4500014
		},
		MemoryReward = {
			2,
			30,
			5045101,
			1
		}
	},
	[4500020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500010,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter02.mp4",
		Id = 4500020,
		Level = 2,
		SoulId = 20010045,
		Name = getI18NValue(180490228),
		Order = getI18NValue(180490227),
		PieceIdList = {
			4500021,
			4500022,
			4500023,
			4500024
		},
		MemoryReward = {
			2,
			30,
			5045102,
			1
		}
	},
	[4500030] = {
		ResourceSize = "5M",
		Scene = 10450301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500020,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500030,
		Level = 3,
		SoulId = 20010045,
		Name = getI18NValue(180490230),
		Order = getI18NValue(180490229),
		PieceIdList = {
			4500031,
			4500032,
			4500033,
			4500034
		},
		MemoryReward = {
			2,
			30,
			5045103,
			1
		}
	},
	[4500040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500030,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter04.mp4",
		Id = 4500040,
		Level = 4,
		SoulId = 20010045,
		Name = getI18NValue(180490232),
		Order = getI18NValue(180490231),
		PieceIdList = {
			4500041,
			4500042,
			4500043,
			4500044
		},
		MemoryReward = {
			2,
			30,
			5045104,
			1
		}
	},
	[4500050] = {
		ResourceSize = "5M",
		Scene = 10450501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500040,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500050,
		Level = 5,
		SoulId = 20010045,
		Name = getI18NValue(180490234),
		Order = getI18NValue(180490233),
		PieceIdList = {
			4500051,
			4500052,
			4500053,
			4500054
		},
		MemoryReward = {
			2,
			30,
			5045105,
			1
		}
	},
	[4500060] = {
		ResourceSize = "5M",
		Scene = 10450601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500050,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500060,
		Level = 6,
		SoulId = 20010045,
		Name = getI18NValue(180490236),
		Order = getI18NValue(180490235),
		PieceIdList = {
			4500061,
			4500062,
			4500063,
			4500064
		},
		MemoryReward = {
			2,
			30,
			5045106,
			1
		}
	},
	[4500070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500060,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter07.mp4",
		Id = 4500070,
		Level = 7,
		SoulId = 20010045,
		Name = getI18NValue(180490238),
		Order = getI18NValue(180490237),
		PieceIdList = {
			4500071,
			4500072,
			4500073,
			4500074
		},
		MemoryReward = {
			2,
			30,
			5045107,
			1
		}
	},
	[4500080] = {
		ResourceSize = "5M",
		Scene = 10450801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500070,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500080,
		Level = 8,
		SoulId = 20010045,
		Name = getI18NValue(180490240),
		Order = getI18NValue(180490239),
		PieceIdList = {
			4500081,
			4500082,
			4500083,
			4500084
		},
		MemoryReward = {
			2,
			30,
			5045108,
			1
		}
	},
	[4500090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500080,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500090,
		Level = 9,
		SoulId = 20010045,
		Name = getI18NValue(180490242),
		Order = getI18NValue(180490241),
		PieceIdList = {
			4500091,
			4500092,
			4500093,
			4500094
		},
		MemoryReward = {
			2,
			30,
			5045109,
			1
		}
	},
	[4500100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500090,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500100,
		Level = 10,
		SoulId = 20010045,
		Name = getI18NValue(180490244),
		Order = getI18NValue(180490243),
		PieceIdList = {
			4500101,
			4500102,
			4500103,
			4500104
		},
		MemoryReward = {
			2,
			30,
			5045110,
			1
		}
	},
	[4500110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500100,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500110,
		Level = 11,
		SoulId = 20010045,
		Name = getI18NValue(180490246),
		Order = getI18NValue(180490245),
		PieceIdList = {
			4500111,
			4500112,
			4500113,
			4500114
		},
		MemoryReward = {
			2,
			30,
			5045111,
			1
		}
	},
	[4500120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500110,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500120,
		Level = 12,
		SoulId = 20010045,
		Name = getI18NValue(180490248),
		Order = getI18NValue(180490247),
		PieceIdList = {
			4500121,
			4500122,
			4500123,
			4500124
		},
		MemoryReward = {
			2,
			30,
			5045112,
			1
		}
	},
	[4500130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500120,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500130,
		Level = 13,
		SoulId = 20010045,
		Name = getI18NValue(180490250),
		Order = getI18NValue(180490249),
		PieceIdList = {
			4500131,
			4500132,
			4500133,
			4500134
		},
		MemoryReward = {
			2,
			30,
			5045113,
			1
		}
	},
	[4500140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500130,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500140,
		Level = 14,
		SoulId = 20010045,
		Name = getI18NValue(180490252),
		Order = getI18NValue(180490251),
		PieceIdList = {
			4500141,
			4500142,
			4500143,
			4500144
		},
		MemoryReward = {
			2,
			30,
			5045114,
			1
		}
	},
	[4500150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500140,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500150,
		Level = 15,
		SoulId = 20010045,
		Name = getI18NValue(180490254),
		Order = getI18NValue(180490253),
		PieceIdList = {
			4500151,
			4500152,
			4500153,
			4500154
		},
		MemoryReward = {
			2,
			30,
			5045115,
			1
		}
	},
	[4500160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500150,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500160,
		Level = 16,
		SoulId = 20010045,
		Name = getI18NValue(180490256),
		Order = getI18NValue(180490255),
		PieceIdList = {
			4500161,
			4500162,
			4500163,
			4500164
		},
		MemoryReward = {
			2,
			30,
			5045116,
			1
		}
	},
	[4500170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500160,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500170,
		Level = 17,
		SoulId = 20010045,
		Name = getI18NValue(180490258),
		Order = getI18NValue(180490257),
		PieceIdList = {
			4500171,
			4500172,
			4500173,
			4500174
		},
		MemoryReward = {
			2,
			30,
			5045117,
			1
		}
	},
	[4500180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lavira_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_RubyRose/RubyRose.png",
		PreMemoryChapter = 4500170,
		Movie = "/Memory/RubyRose/Memory_RubyRose_Chapter00.mp4",
		Id = 4500180,
		Level = 18,
		SoulId = 20010045,
		Name = getI18NValue(180490260),
		Order = getI18NValue(180490259),
		PieceIdList = {
			4500181,
			4500182,
			4500183,
			4500184
		},
		MemoryReward = {
			2,
			30,
			5045118,
			1
		}
	},
	[4600010] = {
		ResourceSize = "5M",
		Scene = 10460101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010046,
		Name = getI18NValue(180889432),
		Order = getI18NValue(180889431),
		PieceIdList = {
			4600011,
			4600012,
			4600013,
			4600014
		},
		MemoryReward = {
			2,
			30,
			5046101,
			1
		}
	},
	[4600020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600010,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter02.mp4",
		Id = 4600020,
		Level = 2,
		SoulId = 20010046,
		Name = getI18NValue(180889434),
		Order = getI18NValue(180889433),
		PieceIdList = {
			4600021,
			4600022,
			4600023,
			4600024
		},
		MemoryReward = {
			2,
			30,
			5046102,
			1
		}
	},
	[4600030] = {
		ResourceSize = "5M",
		Scene = 10460301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600020,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600030,
		Level = 3,
		SoulId = 20010046,
		Name = getI18NValue(180889436),
		Order = getI18NValue(180889435),
		PieceIdList = {
			4600031,
			4600032,
			4600033,
			4600034
		},
		MemoryReward = {
			2,
			30,
			5046103,
			1
		}
	},
	[4600040] = {
		ResourceSize = "5M",
		Scene = 10460401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600030,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600040,
		Level = 4,
		SoulId = 20010046,
		Name = getI18NValue(180889438),
		Order = getI18NValue(180889437),
		PieceIdList = {
			4600041,
			4600042,
			4600043,
			4600044
		},
		MemoryReward = {
			2,
			30,
			5046104,
			1
		}
	},
	[4600050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600040,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter05.mp4",
		Id = 4600050,
		Level = 5,
		SoulId = 20010046,
		Name = getI18NValue(180889440),
		Order = getI18NValue(180889439),
		PieceIdList = {
			4600051,
			4600052,
			4600053,
			4600054
		},
		MemoryReward = {
			2,
			30,
			5046105,
			1
		}
	},
	[4600060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600050,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter06.mp4",
		Id = 4600060,
		Level = 6,
		SoulId = 20010046,
		Name = getI18NValue(180889442),
		Order = getI18NValue(180889441),
		PieceIdList = {
			4600061,
			4600062,
			4600063,
			4600064
		},
		MemoryReward = {
			2,
			30,
			5046106,
			1
		}
	},
	[4600070] = {
		ResourceSize = "5M",
		Scene = 10460701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600060,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600070,
		Level = 7,
		SoulId = 20010046,
		Name = getI18NValue(180889444),
		Order = getI18NValue(180889443),
		PieceIdList = {
			4600071,
			4600072,
			4600073,
			4600074
		},
		MemoryReward = {
			2,
			30,
			5046107,
			1
		}
	},
	[4600080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600070,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter08.mp4",
		Id = 4600080,
		Level = 8,
		SoulId = 20010046,
		Name = getI18NValue(180889446),
		Order = getI18NValue(180889445),
		PieceIdList = {
			4600081,
			4600082,
			4600083,
			4600084
		},
		MemoryReward = {
			2,
			30,
			5046108,
			1
		}
	},
	[4600090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600080,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600090,
		Level = 9,
		SoulId = 20010046,
		Name = getI18NValue(180889448),
		Order = getI18NValue(180889447),
		PieceIdList = {
			4600091,
			4600092,
			4600093,
			4600094
		},
		MemoryReward = {
			2,
			30,
			5046109,
			1
		}
	},
	[4600100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600090,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600100,
		Level = 10,
		SoulId = 20010046,
		Name = getI18NValue(180889450),
		Order = getI18NValue(180889449),
		PieceIdList = {
			4600101,
			4600102,
			4600103,
			4600104
		},
		MemoryReward = {
			2,
			30,
			5046110,
			1
		}
	},
	[4600110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600100,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600110,
		Level = 11,
		SoulId = 20010046,
		Name = getI18NValue(180889452),
		Order = getI18NValue(180889451),
		PieceIdList = {
			4600111,
			4600112,
			4600113,
			4600114
		},
		MemoryReward = {
			2,
			30,
			5046111,
			1
		}
	},
	[4600120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600110,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600120,
		Level = 12,
		SoulId = 20010046,
		Name = getI18NValue(180889454),
		Order = getI18NValue(180889453),
		PieceIdList = {
			4600121,
			4600122,
			4600123,
			4600124
		},
		MemoryReward = {
			2,
			30,
			5046112,
			1
		}
	},
	[4600130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600120,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600130,
		Level = 13,
		SoulId = 20010046,
		Name = getI18NValue(180889456),
		Order = getI18NValue(180889455),
		PieceIdList = {
			4600131,
			4600132,
			4600133,
			4600134
		},
		MemoryReward = {
			2,
			30,
			5046113,
			1
		}
	},
	[4600140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600130,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600140,
		Level = 14,
		SoulId = 20010046,
		Name = getI18NValue(180889458),
		Order = getI18NValue(180889457),
		PieceIdList = {
			4600141,
			4600142,
			4600143,
			4600144
		},
		MemoryReward = {
			2,
			30,
			5046114,
			1
		}
	},
	[4600150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600140,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600150,
		Level = 15,
		SoulId = 20010046,
		Name = getI18NValue(180889460),
		Order = getI18NValue(180889459),
		PieceIdList = {
			4600151,
			4600152,
			4600153,
			4600154
		},
		MemoryReward = {
			2,
			30,
			5046115,
			1
		}
	},
	[4600160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600150,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600160,
		Level = 16,
		SoulId = 20010046,
		Name = getI18NValue(180889462),
		Order = getI18NValue(180889461),
		PieceIdList = {
			4600161,
			4600162,
			4600163,
			4600164
		},
		MemoryReward = {
			2,
			30,
			5046116,
			1
		}
	},
	[4600170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600160,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600170,
		Level = 17,
		SoulId = 20010046,
		Name = getI18NValue(180889464),
		Order = getI18NValue(180889463),
		PieceIdList = {
			4600171,
			4600172,
			4600173,
			4600174
		},
		MemoryReward = {
			2,
			30,
			5046117,
			1
		}
	},
	[4600180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Clarice/Clarice.png",
		PreMemoryChapter = 4600170,
		Movie = "/Memory/Clarice/Memory_Clarice_Chapter00.mp4",
		Id = 4600180,
		Level = 18,
		SoulId = 20010046,
		Name = getI18NValue(180889466),
		Order = getI18NValue(180889465),
		PieceIdList = {
			4600181,
			4600182,
			4600183,
			4600184
		},
		MemoryReward = {
			2,
			30,
			5046118,
			1
		}
	},
	[4700010] = {
		ResourceSize = "5M",
		Scene = 10470101,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		Level = 1,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010047,
		Name = getI18NValue(180889468),
		Order = getI18NValue(180889467),
		PieceIdList = {
			4700011,
			4700012,
			4700013,
			4700014
		},
		MemoryReward = {
			2,
			30,
			5047101,
			1
		}
	},
	[4700020] = {
		ResourceSize = "5M",
		Scene = 10470201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700010,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700020,
		Level = 2,
		SoulId = 20010047,
		Name = getI18NValue(180889470),
		Order = getI18NValue(180889469),
		PieceIdList = {
			4700021,
			4700022,
			4700023,
			4700024
		},
		MemoryReward = {
			2,
			30,
			5047102,
			1
		}
	},
	[4700030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700020,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter03.mp4",
		Id = 4700030,
		Level = 3,
		SoulId = 20010047,
		Name = getI18NValue(180889472),
		Order = getI18NValue(180889471),
		PieceIdList = {
			4700031,
			4700032,
			4700033,
			4700034
		},
		MemoryReward = {
			2,
			30,
			5047103,
			1
		}
	},
	[4700040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700030,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter04.mp4",
		Id = 4700040,
		Level = 4,
		SoulId = 20010047,
		Name = getI18NValue(180889474),
		Order = getI18NValue(180889473),
		PieceIdList = {
			4700041,
			4700042,
			4700043,
			4700044
		},
		MemoryReward = {
			2,
			30,
			5047104,
			1
		}
	},
	[4700050] = {
		ResourceSize = "5M",
		Scene = 10470501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700040,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700050,
		Level = 5,
		SoulId = 20010047,
		Name = getI18NValue(180889476),
		Order = getI18NValue(180889475),
		PieceIdList = {
			4700051,
			4700052,
			4700053,
			4700054
		},
		MemoryReward = {
			2,
			30,
			5047105,
			1
		}
	},
	[4700060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700050,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter06.mp4",
		Id = 4700060,
		Level = 6,
		SoulId = 20010047,
		Name = getI18NValue(180889478),
		Order = getI18NValue(180889477),
		PieceIdList = {
			4700061,
			4700062,
			4700063,
			4700064
		},
		MemoryReward = {
			2,
			30,
			5047106,
			1
		}
	},
	[4700070] = {
		ResourceSize = "5M",
		Scene = 10470701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700060,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700070,
		Level = 7,
		SoulId = 20010047,
		Name = getI18NValue(180889480),
		Order = getI18NValue(180889479),
		PieceIdList = {
			4700071,
			4700072,
			4700073,
			4700074
		},
		MemoryReward = {
			2,
			30,
			5047107,
			1
		}
	},
	[4700080] = {
		ResourceSize = "5M",
		Scene = 10470801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700070,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700080,
		Level = 8,
		SoulId = 20010047,
		Name = getI18NValue(180889482),
		Order = getI18NValue(180889481),
		PieceIdList = {
			4700081,
			4700082,
			4700083,
			4700084
		},
		MemoryReward = {
			2,
			30,
			5047108,
			1
		}
	},
	[4700090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700080,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700090,
		Level = 9,
		SoulId = 20010047,
		Name = getI18NValue(180889484),
		Order = getI18NValue(180889483),
		PieceIdList = {
			4700091,
			4700092,
			4700093,
			4700094
		},
		MemoryReward = {
			2,
			30,
			5047109,
			1
		}
	},
	[4700100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700090,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700100,
		Level = 10,
		SoulId = 20010047,
		Name = getI18NValue(180889486),
		Order = getI18NValue(180889485),
		PieceIdList = {
			4700101,
			4700102,
			4700103,
			4700104
		},
		MemoryReward = {
			2,
			30,
			5047110,
			1
		}
	},
	[4700110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700100,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700110,
		Level = 11,
		SoulId = 20010047,
		Name = getI18NValue(180889488),
		Order = getI18NValue(180889487),
		PieceIdList = {
			4700111,
			4700112,
			4700113,
			4700114
		},
		MemoryReward = {
			2,
			30,
			5047111,
			1
		}
	},
	[4700120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700110,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700120,
		Level = 12,
		SoulId = 20010047,
		Name = getI18NValue(180889490),
		Order = getI18NValue(180889489),
		PieceIdList = {
			4700121,
			4700122,
			4700123,
			4700124
		},
		MemoryReward = {
			2,
			30,
			5047112,
			1
		}
	},
	[4700130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700120,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700130,
		Level = 13,
		SoulId = 20010047,
		Name = getI18NValue(180889492),
		Order = getI18NValue(180889491),
		PieceIdList = {
			4700131,
			4700132,
			4700133,
			4700134
		},
		MemoryReward = {
			2,
			30,
			5047113,
			1
		}
	},
	[4700140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700130,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700140,
		Level = 14,
		SoulId = 20010047,
		Name = getI18NValue(180889494),
		Order = getI18NValue(180889493),
		PieceIdList = {
			4700141,
			4700142,
			4700143,
			4700144
		},
		MemoryReward = {
			2,
			30,
			5047114,
			1
		}
	},
	[4700150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700140,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700150,
		Level = 15,
		SoulId = 20010047,
		Name = getI18NValue(180889496),
		Order = getI18NValue(180889495),
		PieceIdList = {
			4700151,
			4700152,
			4700153,
			4700154
		},
		MemoryReward = {
			2,
			30,
			5047115,
			1
		}
	},
	[4700160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700150,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700160,
		Level = 16,
		SoulId = 20010047,
		Name = getI18NValue(180889498),
		Order = getI18NValue(180889497),
		PieceIdList = {
			4700161,
			4700162,
			4700163,
			4700164
		},
		MemoryReward = {
			2,
			30,
			5047116,
			1
		}
	},
	[4700170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700160,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700170,
		Level = 17,
		SoulId = 20010047,
		Name = getI18NValue(180889500),
		Order = getI18NValue(180889499),
		PieceIdList = {
			4700171,
			4700172,
			4700173,
			4700174
		},
		MemoryReward = {
			2,
			30,
			5047117,
			1
		}
	},
	[4700180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Fanny/Fanny.png",
		PreMemoryChapter = 4700170,
		Movie = "/Memory/Fanny/Memory_Fanny_Chapter00.mp4",
		Id = 4700180,
		Level = 18,
		SoulId = 20010047,
		Name = getI18NValue(180889502),
		Order = getI18NValue(180889501),
		PieceIdList = {
			4700181,
			4700182,
			4700183,
			4700184
		},
		MemoryReward = {
			2,
			30,
			5047118,
			1
		}
	},
	[4800010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		Movie = "/Memory/Micha/Memory_Micha_Chapter01.mp4",
		Id = 4800010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010048,
		Name = getI18NValue(180889504),
		Order = getI18NValue(180889503),
		PieceIdList = {
			4800011,
			4800012,
			4800013,
			4800014
		},
		MemoryReward = {
			2,
			30,
			5048101,
			1
		}
	},
	[4800020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800010,
		Movie = "/Memory/Micha/Memory_Micha_Chapter02.mp4",
		Id = 4800020,
		Level = 2,
		SoulId = 20010048,
		Name = getI18NValue(180889506),
		Order = getI18NValue(180889505),
		PieceIdList = {
			4800021,
			4800022,
			4800023,
			4800024
		},
		MemoryReward = {
			2,
			30,
			5048102,
			1
		}
	},
	[4800030] = {
		ResourceSize = "5M",
		Scene = 10480301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800020,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800030,
		Level = 3,
		SoulId = 20010048,
		Name = getI18NValue(180889508),
		Order = getI18NValue(180889507),
		PieceIdList = {
			4800031,
			4800032,
			4800033,
			4800034
		},
		MemoryReward = {
			2,
			30,
			5048103,
			1
		}
	},
	[4800040] = {
		ResourceSize = "5M",
		Scene = 10480401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800030,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800040,
		Level = 4,
		SoulId = 20010048,
		Name = getI18NValue(180889510),
		Order = getI18NValue(180889509),
		PieceIdList = {
			4800041,
			4800042,
			4800043,
			4800044
		},
		MemoryReward = {
			2,
			30,
			5048104,
			1
		}
	},
	[4800050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800040,
		Movie = "/Memory/Micha/Memory_Micha_Chapter05.mp4",
		Id = 4800050,
		Level = 5,
		SoulId = 20010048,
		Name = getI18NValue(180889512),
		Order = getI18NValue(180889511),
		PieceIdList = {
			4800051,
			4800052,
			4800053,
			4800054
		},
		MemoryReward = {
			2,
			30,
			5048105,
			1
		}
	},
	[4800060] = {
		ResourceSize = "5M",
		Scene = 10480601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800050,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800060,
		Level = 6,
		SoulId = 20010048,
		Name = getI18NValue(180889514),
		Order = getI18NValue(180889513),
		PieceIdList = {
			4800061,
			4800062,
			4800063,
			4800064
		},
		MemoryReward = {
			2,
			30,
			5048106,
			1
		}
	},
	[4800070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800060,
		Movie = "/Memory/Micha/Memory_Micha_Chapter07.mp4",
		Id = 4800070,
		Level = 7,
		SoulId = 20010048,
		Name = getI18NValue(180889516),
		Order = getI18NValue(180889515),
		PieceIdList = {
			4800071,
			4800072,
			4800073,
			4800074
		},
		MemoryReward = {
			2,
			30,
			5048107,
			1
		}
	},
	[4800080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800070,
		Movie = "/Memory/Micha/Memory_Micha_Chapter08.mp4",
		Id = 4800080,
		Level = 8,
		SoulId = 20010048,
		Name = getI18NValue(180889518),
		Order = getI18NValue(180889517),
		PieceIdList = {
			4800081,
			4800082,
			4800083,
			4800084
		},
		MemoryReward = {
			2,
			30,
			5048108,
			1
		}
	},
	[4800090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800080,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800090,
		Level = 9,
		SoulId = 20010048,
		Name = getI18NValue(180889520),
		Order = getI18NValue(180889519),
		PieceIdList = {
			4800091,
			4800092,
			4800093,
			4800094
		},
		MemoryReward = {
			2,
			30,
			5048109,
			1
		}
	},
	[4800100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800090,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800100,
		Level = 10,
		SoulId = 20010048,
		Name = getI18NValue(180889522),
		Order = getI18NValue(180889521),
		PieceIdList = {
			4800101,
			4800102,
			4800103,
			4800104
		},
		MemoryReward = {
			2,
			30,
			5048110,
			1
		}
	},
	[4800110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800100,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800110,
		Level = 11,
		SoulId = 20010048,
		Name = getI18NValue(180889524),
		Order = getI18NValue(180889523),
		PieceIdList = {
			4800111,
			4800112,
			4800113,
			4800114
		},
		MemoryReward = {
			2,
			30,
			5048111,
			1
		}
	},
	[4800120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800110,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800120,
		Level = 12,
		SoulId = 20010048,
		Name = getI18NValue(180889526),
		Order = getI18NValue(180889525),
		PieceIdList = {
			4800121,
			4800122,
			4800123,
			4800124
		},
		MemoryReward = {
			2,
			30,
			5048112,
			1
		}
	},
	[4800130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800120,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800130,
		Level = 13,
		SoulId = 20010048,
		Name = getI18NValue(180889528),
		Order = getI18NValue(180889527),
		PieceIdList = {
			4800131,
			4800132,
			4800133,
			4800134
		},
		MemoryReward = {
			2,
			30,
			5048113,
			1
		}
	},
	[4800140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800130,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800140,
		Level = 14,
		SoulId = 20010048,
		Name = getI18NValue(180889530),
		Order = getI18NValue(180889529),
		PieceIdList = {
			4800141,
			4800142,
			4800143,
			4800144
		},
		MemoryReward = {
			2,
			30,
			5048114,
			1
		}
	},
	[4800150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800140,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800150,
		Level = 15,
		SoulId = 20010048,
		Name = getI18NValue(180889532),
		Order = getI18NValue(180889531),
		PieceIdList = {
			4800151,
			4800152,
			4800153,
			4800154
		},
		MemoryReward = {
			2,
			30,
			5048115,
			1
		}
	},
	[4800160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800150,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800160,
		Level = 16,
		SoulId = 20010048,
		Name = getI18NValue(180889534),
		Order = getI18NValue(180889533),
		PieceIdList = {
			4800161,
			4800162,
			4800163,
			4800164
		},
		MemoryReward = {
			2,
			30,
			5048116,
			1
		}
	},
	[4800170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800160,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800170,
		Level = 17,
		SoulId = 20010048,
		Name = getI18NValue(180889536),
		Order = getI18NValue(180889535),
		PieceIdList = {
			4800171,
			4800172,
			4800173,
			4800174
		},
		MemoryReward = {
			2,
			30,
			5048117,
			1
		}
	},
	[4800180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Micha/Micha.png",
		PreMemoryChapter = 4800170,
		Movie = "/Memory/Micha/Memory_Micha_Chapter00.mp4",
		Id = 4800180,
		Level = 18,
		SoulId = 20010048,
		Name = getI18NValue(180889538),
		Order = getI18NValue(180889537),
		PieceIdList = {
			4800181,
			4800182,
			4800183,
			4800184
		},
		MemoryReward = {
			2,
			30,
			5048118,
			1
		}
	},
	[4900010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		Movie = "/Memory/Truda/Memory_Truda_Chapter01.mp4",
		Id = 4900010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010049,
		Name = getI18NValue(180889540),
		Order = getI18NValue(180889539),
		PieceIdList = {
			4900011,
			4900012,
			4900013,
			4900014
		},
		MemoryReward = {
			2,
			30,
			5049101,
			1
		}
	},
	[4900020] = {
		ResourceSize = "5M",
		Scene = 10490201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900010,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900020,
		Level = 2,
		SoulId = 20010049,
		Name = getI18NValue(180889542),
		Order = getI18NValue(180889541),
		PieceIdList = {
			4900021,
			4900022,
			4900023,
			4900024
		},
		MemoryReward = {
			2,
			30,
			5049102,
			1
		}
	},
	[4900030] = {
		ResourceSize = "5M",
		Scene = 10490301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900020,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900030,
		Level = 3,
		SoulId = 20010049,
		Name = getI18NValue(180889544),
		Order = getI18NValue(180889543),
		PieceIdList = {
			4900031,
			4900032,
			4900033,
			4900034
		},
		MemoryReward = {
			2,
			30,
			5049103,
			1
		}
	},
	[4900040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900030,
		Movie = "/Memory/Truda/Memory_Truda_Chapter04.mp4",
		Id = 4900040,
		Level = 4,
		SoulId = 20010049,
		Name = getI18NValue(180889546),
		Order = getI18NValue(180889545),
		PieceIdList = {
			4900041,
			4900042,
			4900043,
			4900044
		},
		MemoryReward = {
			2,
			30,
			5049104,
			1
		}
	},
	[4900050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900040,
		Movie = "/Memory/Truda/Memory_Truda_Chapter05.mp4",
		Id = 4900050,
		Level = 5,
		SoulId = 20010049,
		Name = getI18NValue(180889548),
		Order = getI18NValue(180889547),
		PieceIdList = {
			4900051,
			4900052,
			4900053,
			4900054
		},
		MemoryReward = {
			2,
			30,
			5049105,
			1
		}
	},
	[4900060] = {
		ResourceSize = "5M",
		Scene = 10490601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900050,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900060,
		Level = 6,
		SoulId = 20010049,
		Name = getI18NValue(180889550),
		Order = getI18NValue(180889549),
		PieceIdList = {
			4900061,
			4900062,
			4900063,
			4900064
		},
		MemoryReward = {
			2,
			30,
			5049106,
			1
		}
	},
	[4900070] = {
		ResourceSize = "5M",
		Scene = 10490701,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 17,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900060,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900070,
		Level = 7,
		SoulId = 20010049,
		Name = getI18NValue(180889552),
		Order = getI18NValue(180889551),
		PieceIdList = {
			4900071,
			4900072,
			4900073,
			4900074
		},
		MemoryReward = {
			2,
			30,
			5049107,
			1
		}
	},
	[4900080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900070,
		Movie = "/Memory/Truda/Memory_Truda_Chapter08.mp4",
		Id = 4900080,
		Level = 8,
		SoulId = 20010049,
		Name = getI18NValue(180889554),
		Order = getI18NValue(180889553),
		PieceIdList = {
			4900081,
			4900082,
			4900083,
			4900084
		},
		MemoryReward = {
			2,
			30,
			5049108,
			1
		}
	},
	[4900090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900080,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900090,
		Level = 9,
		SoulId = 20010049,
		Name = getI18NValue(180889556),
		Order = getI18NValue(180889555),
		PieceIdList = {
			4900091,
			4900092,
			4900093,
			4900094
		},
		MemoryReward = {
			2,
			30,
			5049109,
			1
		}
	},
	[4900100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900090,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900100,
		Level = 10,
		SoulId = 20010049,
		Name = getI18NValue(180889558),
		Order = getI18NValue(180889557),
		PieceIdList = {
			4900101,
			4900102,
			4900103,
			4900104
		},
		MemoryReward = {
			2,
			30,
			5049110,
			1
		}
	},
	[4900110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900100,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900110,
		Level = 11,
		SoulId = 20010049,
		Name = getI18NValue(180889560),
		Order = getI18NValue(180889559),
		PieceIdList = {
			4900111,
			4900112,
			4900113,
			4900114
		},
		MemoryReward = {
			2,
			30,
			5049111,
			1
		}
	},
	[4900120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900110,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900120,
		Level = 12,
		SoulId = 20010049,
		Name = getI18NValue(180889562),
		Order = getI18NValue(180889561),
		PieceIdList = {
			4900121,
			4900122,
			4900123,
			4900124
		},
		MemoryReward = {
			2,
			30,
			5049112,
			1
		}
	},
	[4900130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900120,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900130,
		Level = 13,
		SoulId = 20010049,
		Name = getI18NValue(180889564),
		Order = getI18NValue(180889563),
		PieceIdList = {
			4900131,
			4900132,
			4900133,
			4900134
		},
		MemoryReward = {
			2,
			30,
			5049113,
			1
		}
	},
	[4900140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900130,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900140,
		Level = 14,
		SoulId = 20010049,
		Name = getI18NValue(180889566),
		Order = getI18NValue(180889565),
		PieceIdList = {
			4900141,
			4900142,
			4900143,
			4900144
		},
		MemoryReward = {
			2,
			30,
			5049114,
			1
		}
	},
	[4900150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900140,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900150,
		Level = 15,
		SoulId = 20010049,
		Name = getI18NValue(180889568),
		Order = getI18NValue(180889567),
		PieceIdList = {
			4900151,
			4900152,
			4900153,
			4900154
		},
		MemoryReward = {
			2,
			30,
			5049115,
			1
		}
	},
	[4900160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900150,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900160,
		Level = 16,
		SoulId = 20010049,
		Name = getI18NValue(180889570),
		Order = getI18NValue(180889569),
		PieceIdList = {
			4900161,
			4900162,
			4900163,
			4900164
		},
		MemoryReward = {
			2,
			30,
			5049116,
			1
		}
	},
	[4900170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900160,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900170,
		Level = 17,
		SoulId = 20010049,
		Name = getI18NValue(180889572),
		Order = getI18NValue(180889571),
		PieceIdList = {
			4900171,
			4900172,
			4900173,
			4900174
		},
		MemoryReward = {
			2,
			30,
			5049117,
			1
		}
	},
	[4900180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Freesia_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Truda/Truda.png",
		PreMemoryChapter = 4900170,
		Movie = "/Memory/Truda/Memory_Truda_Chapter00.mp4",
		Id = 4900180,
		Level = 18,
		SoulId = 20010049,
		Name = getI18NValue(180889574),
		Order = getI18NValue(180889573),
		PieceIdList = {
			4900181,
			4900182,
			4900183,
			4900184
		},
		MemoryReward = {
			2,
			30,
			5049118,
			1
		}
	},
	[5000010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter01.mp4",
		Id = 5000010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010050,
		Name = getI18NValue(180889576),
		Order = getI18NValue(180889575),
		PieceIdList = {
			5000011,
			5000012,
			5000013,
			5000014
		},
		MemoryReward = {
			2,
			30,
			5050101,
			1
		}
	},
	[5000020] = {
		ResourceSize = "5M",
		Scene = 10500201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000010,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000020,
		Level = 2,
		SoulId = 20010050,
		Name = getI18NValue(180889578),
		Order = getI18NValue(180889577),
		PieceIdList = {
			5000021,
			5000022,
			5000023,
			5000024
		},
		MemoryReward = {
			2,
			30,
			5050102,
			1
		}
	},
	[5000030] = {
		ResourceSize = "5M",
		Scene = 10500301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000020,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000030,
		Level = 3,
		SoulId = 20010050,
		Name = getI18NValue(180889580),
		Order = getI18NValue(180889579),
		PieceIdList = {
			5000031,
			5000032,
			5000033,
			5000034
		},
		MemoryReward = {
			2,
			30,
			5050103,
			1
		}
	},
	[5000040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000030,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter04.mp4",
		Id = 5000040,
		Level = 4,
		SoulId = 20010050,
		Name = getI18NValue(180889582),
		Order = getI18NValue(180889581),
		PieceIdList = {
			5000041,
			5000042,
			5000043,
			5000044
		},
		MemoryReward = {
			2,
			30,
			5050104,
			1
		}
	},
	[5000050] = {
		ResourceSize = "5M",
		Scene = 10500501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000040,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000050,
		Level = 5,
		SoulId = 20010050,
		Name = getI18NValue(180889584),
		Order = getI18NValue(180889583),
		PieceIdList = {
			5000051,
			5000052,
			5000053,
			5000054
		},
		MemoryReward = {
			2,
			30,
			5050105,
			1
		}
	},
	[5000060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000050,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter06.mp4",
		Id = 5000060,
		Level = 6,
		SoulId = 20010050,
		Name = getI18NValue(180889586),
		Order = getI18NValue(180889585),
		PieceIdList = {
			5000061,
			5000062,
			5000063,
			5000064
		},
		MemoryReward = {
			2,
			30,
			5050106,
			1
		}
	},
	[5000070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000060,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter07.mp4",
		Id = 5000070,
		Level = 7,
		SoulId = 20010050,
		Name = getI18NValue(180889588),
		Order = getI18NValue(180889587),
		PieceIdList = {
			5000071,
			5000072,
			5000073,
			5000074
		},
		MemoryReward = {
			2,
			30,
			5050107,
			1
		}
	},
	[5000080] = {
		ResourceSize = "5M",
		Scene = 10500801,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 19,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000070,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000080,
		Level = 8,
		SoulId = 20010050,
		Name = getI18NValue(180889590),
		Order = getI18NValue(180889589),
		PieceIdList = {
			5000081,
			5000082,
			5000083,
			5000084
		},
		MemoryReward = {
			2,
			30,
			5050108,
			1
		}
	},
	[5000090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000080,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000090,
		Level = 9,
		SoulId = 20010050,
		Name = getI18NValue(180889592),
		Order = getI18NValue(180889591),
		PieceIdList = {
			5000091,
			5000092,
			5000093,
			5000094
		},
		MemoryReward = {
			2,
			30,
			5050109,
			1
		}
	},
	[5000100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000090,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000100,
		Level = 10,
		SoulId = 20010050,
		Name = getI18NValue(180889594),
		Order = getI18NValue(180889593),
		PieceIdList = {
			5000101,
			5000102,
			5000103,
			5000104
		},
		MemoryReward = {
			2,
			30,
			5050110,
			1
		}
	},
	[5000110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000100,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000110,
		Level = 11,
		SoulId = 20010050,
		Name = getI18NValue(180889596),
		Order = getI18NValue(180889595),
		PieceIdList = {
			5000111,
			5000112,
			5000113,
			5000114
		},
		MemoryReward = {
			2,
			30,
			5050111,
			1
		}
	},
	[5000120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000110,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000120,
		Level = 12,
		SoulId = 20010050,
		Name = getI18NValue(180889598),
		Order = getI18NValue(180889597),
		PieceIdList = {
			5000121,
			5000122,
			5000123,
			5000124
		},
		MemoryReward = {
			2,
			30,
			5050112,
			1
		}
	},
	[5000130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000120,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000130,
		Level = 13,
		SoulId = 20010050,
		Name = getI18NValue(180889600),
		Order = getI18NValue(180889599),
		PieceIdList = {
			5000131,
			5000132,
			5000133,
			5000134
		},
		MemoryReward = {
			2,
			30,
			5050113,
			1
		}
	},
	[5000140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000130,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000140,
		Level = 14,
		SoulId = 20010050,
		Name = getI18NValue(180889602),
		Order = getI18NValue(180889601),
		PieceIdList = {
			5000141,
			5000142,
			5000143,
			5000144
		},
		MemoryReward = {
			2,
			30,
			5050114,
			1
		}
	},
	[5000150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000140,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000150,
		Level = 15,
		SoulId = 20010050,
		Name = getI18NValue(180889604),
		Order = getI18NValue(180889603),
		PieceIdList = {
			5000151,
			5000152,
			5000153,
			5000154
		},
		MemoryReward = {
			2,
			30,
			5050115,
			1
		}
	},
	[5000160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000150,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000160,
		Level = 16,
		SoulId = 20010050,
		Name = getI18NValue(180889606),
		Order = getI18NValue(180889605),
		PieceIdList = {
			5000161,
			5000162,
			5000163,
			5000164
		},
		MemoryReward = {
			2,
			30,
			5050116,
			1
		}
	},
	[5000170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000160,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000170,
		Level = 17,
		SoulId = 20010050,
		Name = getI18NValue(180889608),
		Order = getI18NValue(180889607),
		PieceIdList = {
			5000171,
			5000172,
			5000173,
			5000174
		},
		MemoryReward = {
			2,
			30,
			5050117,
			1
		}
	},
	[5000180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Dreizehn_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Cecilia/Cecilia.png",
		PreMemoryChapter = 5000170,
		Movie = "/Memory/Cecilia/Memory_Cecilia_Chapter00.mp4",
		Id = 5000180,
		Level = 18,
		SoulId = 20010050,
		Name = getI18NValue(180889610),
		Order = getI18NValue(180889609),
		PieceIdList = {
			5000181,
			5000182,
			5000183,
			5000184
		},
		MemoryReward = {
			2,
			30,
			5050118,
			1
		}
	},
	[5100010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter01.mp4",
		Id = 5100010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010051,
		Name = getI18NValue(180889612),
		Order = getI18NValue(180889611),
		PieceIdList = {
			5100011,
			5100012,
			5100013,
			5100014
		},
		MemoryReward = {
			2,
			30,
			5051101,
			1
		}
	},
	[5100020] = {
		ResourceSize = "5M",
		Scene = 10510201,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 3,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100010,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100020,
		Level = 2,
		SoulId = 20010051,
		Name = getI18NValue(180889614),
		Order = getI18NValue(180889613),
		PieceIdList = {
			5100021,
			5100022,
			5100023,
			5100024
		},
		MemoryReward = {
			2,
			30,
			5051102,
			1
		}
	},
	[5100030] = {
		ResourceSize = "5M",
		Scene = 10510301,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 6,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100020,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100030,
		Level = 3,
		SoulId = 20010051,
		Name = getI18NValue(180889616),
		Order = getI18NValue(180889615),
		PieceIdList = {
			5100031,
			5100032,
			5100033,
			5100034
		},
		MemoryReward = {
			2,
			30,
			5051103,
			1
		}
	},
	[5100040] = {
		ResourceSize = "5M",
		Scene = 10510401,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 8,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100030,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100040,
		Level = 4,
		SoulId = 20010051,
		Name = getI18NValue(180889618),
		Order = getI18NValue(180889617),
		PieceIdList = {
			5100041,
			5100042,
			5100043,
			5100044
		},
		MemoryReward = {
			2,
			30,
			5051104,
			1
		}
	},
	[5100050] = {
		ResourceSize = "5M",
		Scene = 10510501,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 10,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100040,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100050,
		Level = 5,
		SoulId = 20010051,
		Name = getI18NValue(180889620),
		Order = getI18NValue(180889619),
		PieceIdList = {
			5100051,
			5100052,
			5100053,
			5100054
		},
		MemoryReward = {
			2,
			30,
			5051105,
			1
		}
	},
	[5100060] = {
		ResourceSize = "5M",
		Scene = 10510601,
		MemoryType = 2,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		UnlockFavorDegreeLevel = 13,
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100050,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100060,
		Level = 6,
		SoulId = 20010051,
		Name = getI18NValue(180889622),
		Order = getI18NValue(180889621),
		PieceIdList = {
			5100061,
			5100062,
			5100063,
			5100064
		},
		MemoryReward = {
			2,
			30,
			5051106,
			1
		}
	},
	[5100070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100060,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter07.mp4",
		Id = 5100070,
		Level = 7,
		SoulId = 20010051,
		Name = getI18NValue(180889624),
		Order = getI18NValue(180889623),
		PieceIdList = {
			5100071,
			5100072,
			5100073,
			5100074
		},
		MemoryReward = {
			2,
			30,
			5051107,
			1
		}
	},
	[5100080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100070,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter08.mp4",
		Id = 5100080,
		Level = 8,
		SoulId = 20010051,
		Name = getI18NValue(180889626),
		Order = getI18NValue(180889625),
		PieceIdList = {
			5100081,
			5100082,
			5100083,
			5100084
		},
		MemoryReward = {
			2,
			30,
			5051108,
			1
		}
	},
	[5100090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100080,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100090,
		Level = 9,
		SoulId = 20010051,
		Name = getI18NValue(180889628),
		Order = getI18NValue(180889627),
		PieceIdList = {
			5100091,
			5100092,
			5100093,
			5100094
		},
		MemoryReward = {
			2,
			30,
			5051109,
			1
		}
	},
	[5100100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100090,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100100,
		Level = 10,
		SoulId = 20010051,
		Name = getI18NValue(180889630),
		Order = getI18NValue(180889629),
		PieceIdList = {
			5100101,
			5100102,
			5100103,
			5100104
		},
		MemoryReward = {
			2,
			30,
			5051110,
			1
		}
	},
	[5100110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100100,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100110,
		Level = 11,
		SoulId = 20010051,
		Name = getI18NValue(180889632),
		Order = getI18NValue(180889631),
		PieceIdList = {
			5100111,
			5100112,
			5100113,
			5100114
		},
		MemoryReward = {
			2,
			30,
			5051111,
			1
		}
	},
	[5100120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100110,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100120,
		Level = 12,
		SoulId = 20010051,
		Name = getI18NValue(180889634),
		Order = getI18NValue(180889633),
		PieceIdList = {
			5100121,
			5100122,
			5100123,
			5100124
		},
		MemoryReward = {
			2,
			30,
			5051112,
			1
		}
	},
	[5100130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100120,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100130,
		Level = 13,
		SoulId = 20010051,
		Name = getI18NValue(180889636),
		Order = getI18NValue(180889635),
		PieceIdList = {
			5100131,
			5100132,
			5100133,
			5100134
		},
		MemoryReward = {
			2,
			30,
			5051113,
			1
		}
	},
	[5100140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100130,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100140,
		Level = 14,
		SoulId = 20010051,
		Name = getI18NValue(180889638),
		Order = getI18NValue(180889637),
		PieceIdList = {
			5100141,
			5100142,
			5100143,
			5100144
		},
		MemoryReward = {
			2,
			30,
			5051114,
			1
		}
	},
	[5100150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100140,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100150,
		Level = 15,
		SoulId = 20010051,
		Name = getI18NValue(180889640),
		Order = getI18NValue(180889639),
		PieceIdList = {
			5100151,
			5100152,
			5100153,
			5100154
		},
		MemoryReward = {
			2,
			30,
			5051115,
			1
		}
	},
	[5100160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100150,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100160,
		Level = 16,
		SoulId = 20010051,
		Name = getI18NValue(180889642),
		Order = getI18NValue(180889641),
		PieceIdList = {
			5100161,
			5100162,
			5100163,
			5100164
		},
		MemoryReward = {
			2,
			30,
			5051116,
			1
		}
	},
	[5100170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100160,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100170,
		Level = 17,
		SoulId = 20010051,
		Name = getI18NValue(180889644),
		Order = getI18NValue(180889643),
		PieceIdList = {
			5100171,
			5100172,
			5100173,
			5100174
		},
		MemoryReward = {
			2,
			30,
			5051117,
			1
		}
	},
	[5100180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Lilyiro_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Louisa/Louisa.png",
		PreMemoryChapter = 5100170,
		Movie = "/Memory/Louisa/Memory_Louisa_Chapter00.mp4",
		Id = 5100180,
		Level = 18,
		SoulId = 20010051,
		Name = getI18NValue(180889646),
		Order = getI18NValue(180889645),
		PieceIdList = {
			5100181,
			5100182,
			5100183,
			5100184
		},
		MemoryReward = {
			2,
			30,
			5051118,
			1
		}
	},
	[5200010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter01.mp4",
		Id = 5200010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010052,
		Name = getI18NValue(180889648),
		Order = getI18NValue(180889647),
		PieceIdList = {
			5200011,
			5200012,
			5200013,
			5200014
		},
		MemoryReward = {
			2,
			30,
			5052101,
			1
		}
	},
	[5200020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200010,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter02.mp4",
		Id = 5200020,
		Level = 2,
		SoulId = 20010052,
		Name = getI18NValue(180889650),
		Order = getI18NValue(180889649),
		PieceIdList = {
			5200021,
			5200022,
			5200023,
			5200024
		},
		MemoryReward = {
			2,
			30,
			5052102,
			1
		}
	},
	[5200030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200020,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter03.mp4",
		Id = 5200030,
		Level = 3,
		SoulId = 20010052,
		Name = getI18NValue(180889652),
		Order = getI18NValue(180889651),
		PieceIdList = {
			5200031,
			5200032,
			5200033,
			5200034
		},
		MemoryReward = {
			2,
			30,
			5052103,
			1
		}
	},
	[5200040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200030,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter04.mp4",
		Id = 5200040,
		Level = 4,
		SoulId = 20010052,
		Name = getI18NValue(180889654),
		Order = getI18NValue(180889653),
		PieceIdList = {
			5200041,
			5200042,
			5200043,
			5200044
		},
		MemoryReward = {
			2,
			30,
			5052104,
			1
		}
	},
	[5200050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200040,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter05.mp4",
		Id = 5200050,
		Level = 5,
		SoulId = 20010052,
		Name = getI18NValue(180889656),
		Order = getI18NValue(180889655),
		PieceIdList = {
			5200051,
			5200052,
			5200053,
			5200054
		},
		MemoryReward = {
			2,
			30,
			5052105,
			1
		}
	},
	[5200060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200050,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter06.mp4",
		Id = 5200060,
		Level = 6,
		SoulId = 20010052,
		Name = getI18NValue(180889658),
		Order = getI18NValue(180889657),
		PieceIdList = {
			5200061,
			5200062,
			5200063,
			5200064
		},
		MemoryReward = {
			2,
			30,
			5052106,
			1
		}
	},
	[5200070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200060,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter07.mp4",
		Id = 5200070,
		Level = 7,
		SoulId = 20010052,
		Name = getI18NValue(180889660),
		Order = getI18NValue(180889659),
		PieceIdList = {
			5200071,
			5200072,
			5200073,
			5200074
		},
		MemoryReward = {
			2,
			30,
			5052107,
			1
		}
	},
	[5200080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200070,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter08.mp4",
		Id = 5200080,
		Level = 8,
		SoulId = 20010052,
		Name = getI18NValue(180889662),
		Order = getI18NValue(180889661),
		PieceIdList = {
			5200081,
			5200082,
			5200083,
			5200084
		},
		MemoryReward = {
			2,
			30,
			5052108,
			1
		}
	},
	[5200090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200080,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter09.mp4",
		Id = 5200090,
		Level = 9,
		SoulId = 20010052,
		Name = getI18NValue(180889664),
		Order = getI18NValue(180889663),
		PieceIdList = {
			5200091,
			5200092,
			5200093,
			5200094
		},
		MemoryReward = {
			2,
			30,
			5052109,
			1
		}
	},
	[5200100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200090,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter10.mp4",
		Id = 5200100,
		Level = 10,
		SoulId = 20010052,
		Name = getI18NValue(180889666),
		Order = getI18NValue(180889665),
		PieceIdList = {
			5200101,
			5200102,
			5200103,
			5200104
		},
		MemoryReward = {
			2,
			30,
			5052110,
			1
		}
	},
	[5200110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200100,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter11.mp4",
		Id = 5200110,
		Level = 11,
		SoulId = 20010052,
		Name = getI18NValue(180889668),
		Order = getI18NValue(180889667),
		PieceIdList = {
			5200111,
			5200112,
			5200113,
			5200114
		},
		MemoryReward = {
			2,
			30,
			5052111,
			1
		}
	},
	[5200120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200110,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter12.mp4",
		Id = 5200120,
		Level = 12,
		SoulId = 20010052,
		Name = getI18NValue(180889670),
		Order = getI18NValue(180889669),
		PieceIdList = {
			5200121,
			5200122,
			5200123,
			5200124
		},
		MemoryReward = {
			2,
			30,
			5052112,
			1
		}
	},
	[5200130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200120,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter13.mp4",
		Id = 5200130,
		Level = 13,
		SoulId = 20010052,
		Name = getI18NValue(180889672),
		Order = getI18NValue(180889671),
		PieceIdList = {
			5200131,
			5200132,
			5200133,
			5200134
		},
		MemoryReward = {
			2,
			30,
			5052113,
			1
		}
	},
	[5200140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200130,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter14.mp4",
		Id = 5200140,
		Level = 14,
		SoulId = 20010052,
		Name = getI18NValue(180889674),
		Order = getI18NValue(180889673),
		PieceIdList = {
			5200141,
			5200142,
			5200143,
			5200144
		},
		MemoryReward = {
			2,
			30,
			5052114,
			1
		}
	},
	[5200150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200140,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter15.mp4",
		Id = 5200150,
		Level = 15,
		SoulId = 20010052,
		Name = getI18NValue(180889676),
		Order = getI18NValue(180889675),
		PieceIdList = {
			5200151,
			5200152,
			5200153,
			5200154
		},
		MemoryReward = {
			2,
			30,
			5052115,
			1
		}
	},
	[5200160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200150,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter16.mp4",
		Id = 5200160,
		Level = 16,
		SoulId = 20010052,
		Name = getI18NValue(180889678),
		Order = getI18NValue(180889677),
		PieceIdList = {
			5200161,
			5200162,
			5200163,
			5200164
		},
		MemoryReward = {
			2,
			30,
			5052116,
			1
		}
	},
	[5200170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200160,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter17.mp4",
		Id = 5200170,
		Level = 17,
		SoulId = 20010052,
		Name = getI18NValue(180889680),
		Order = getI18NValue(180889679),
		PieceIdList = {
			5200171,
			5200172,
			5200173,
			5200174
		},
		MemoryReward = {
			2,
			30,
			5052117,
			1
		}
	},
	[5200180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5200170,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter18.mp4",
		Id = 5200180,
		Level = 18,
		SoulId = 20010052,
		Name = getI18NValue(180889682),
		Order = getI18NValue(180889681),
		PieceIdList = {
			5200181,
			5200182,
			5200183,
			5200184
		},
		MemoryReward = {
			2,
			30,
			5052118,
			1
		}
	},
	[5300010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter01.mp4",
		Id = 5300010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010053,
		Name = getI18NValue(180889684),
		Order = getI18NValue(180889683),
		PieceIdList = {
			5300011,
			5300012,
			5300013,
			5300014
		},
		MemoryReward = {
			2,
			30,
			5053101,
			1
		}
	},
	[5300020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300010,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter02.mp4",
		Id = 5300020,
		Level = 2,
		SoulId = 20010053,
		Name = getI18NValue(180889686),
		Order = getI18NValue(180889685),
		PieceIdList = {
			5300021,
			5300022,
			5300023,
			5300024
		},
		MemoryReward = {
			2,
			30,
			5053102,
			1
		}
	},
	[5300030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300020,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter03.mp4",
		Id = 5300030,
		Level = 3,
		SoulId = 20010053,
		Name = getI18NValue(180889688),
		Order = getI18NValue(180889687),
		PieceIdList = {
			5300031,
			5300032,
			5300033,
			5300034
		},
		MemoryReward = {
			2,
			30,
			5053103,
			1
		}
	},
	[5300040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300030,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter04.mp4",
		Id = 5300040,
		Level = 4,
		SoulId = 20010053,
		Name = getI18NValue(180889690),
		Order = getI18NValue(180889689),
		PieceIdList = {
			5300041,
			5300042,
			5300043,
			5300044
		},
		MemoryReward = {
			2,
			30,
			5053104,
			1
		}
	},
	[5300050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300040,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter05.mp4",
		Id = 5300050,
		Level = 5,
		SoulId = 20010053,
		Name = getI18NValue(180889692),
		Order = getI18NValue(180889691),
		PieceIdList = {
			5300051,
			5300052,
			5300053,
			5300054
		},
		MemoryReward = {
			2,
			30,
			5053105,
			1
		}
	},
	[5300060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300050,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter06.mp4",
		Id = 5300060,
		Level = 6,
		SoulId = 20010053,
		Name = getI18NValue(180889694),
		Order = getI18NValue(180889693),
		PieceIdList = {
			5300061,
			5300062,
			5300063,
			5300064
		},
		MemoryReward = {
			2,
			30,
			5053106,
			1
		}
	},
	[5300070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300060,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter07.mp4",
		Id = 5300070,
		Level = 7,
		SoulId = 20010053,
		Name = getI18NValue(180889696),
		Order = getI18NValue(180889695),
		PieceIdList = {
			5300071,
			5300072,
			5300073,
			5300074
		},
		MemoryReward = {
			2,
			30,
			5053107,
			1
		}
	},
	[5300080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300070,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter08.mp4",
		Id = 5300080,
		Level = 8,
		SoulId = 20010053,
		Name = getI18NValue(180889698),
		Order = getI18NValue(180889697),
		PieceIdList = {
			5300081,
			5300082,
			5300083,
			5300084
		},
		MemoryReward = {
			2,
			30,
			5053108,
			1
		}
	},
	[5300090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300080,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter09.mp4",
		Id = 5300090,
		Level = 9,
		SoulId = 20010053,
		Name = getI18NValue(180889700),
		Order = getI18NValue(180889699),
		PieceIdList = {
			5300091,
			5300092,
			5300093,
			5300094
		},
		MemoryReward = {
			2,
			30,
			5053109,
			1
		}
	},
	[5300100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300090,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter10.mp4",
		Id = 5300100,
		Level = 10,
		SoulId = 20010053,
		Name = getI18NValue(180889702),
		Order = getI18NValue(180889701),
		PieceIdList = {
			5300101,
			5300102,
			5300103,
			5300104
		},
		MemoryReward = {
			2,
			30,
			5053110,
			1
		}
	},
	[5300110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300100,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter11.mp4",
		Id = 5300110,
		Level = 11,
		SoulId = 20010053,
		Name = getI18NValue(180889704),
		Order = getI18NValue(180889703),
		PieceIdList = {
			5300111,
			5300112,
			5300113,
			5300114
		},
		MemoryReward = {
			2,
			30,
			5053111,
			1
		}
	},
	[5300120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300110,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter12.mp4",
		Id = 5300120,
		Level = 12,
		SoulId = 20010053,
		Name = getI18NValue(180889706),
		Order = getI18NValue(180889705),
		PieceIdList = {
			5300121,
			5300122,
			5300123,
			5300124
		},
		MemoryReward = {
			2,
			30,
			5053112,
			1
		}
	},
	[5300130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300120,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter13.mp4",
		Id = 5300130,
		Level = 13,
		SoulId = 20010053,
		Name = getI18NValue(180889708),
		Order = getI18NValue(180889707),
		PieceIdList = {
			5300131,
			5300132,
			5300133,
			5300134
		},
		MemoryReward = {
			2,
			30,
			5053113,
			1
		}
	},
	[5300140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300130,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter14.mp4",
		Id = 5300140,
		Level = 14,
		SoulId = 20010053,
		Name = getI18NValue(180889710),
		Order = getI18NValue(180889709),
		PieceIdList = {
			5300141,
			5300142,
			5300143,
			5300144
		},
		MemoryReward = {
			2,
			30,
			5053114,
			1
		}
	},
	[5300150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300140,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter15.mp4",
		Id = 5300150,
		Level = 15,
		SoulId = 20010053,
		Name = getI18NValue(180889712),
		Order = getI18NValue(180889711),
		PieceIdList = {
			5300151,
			5300152,
			5300153,
			5300154
		},
		MemoryReward = {
			2,
			30,
			5053115,
			1
		}
	},
	[5300160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300150,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter16.mp4",
		Id = 5300160,
		Level = 16,
		SoulId = 20010053,
		Name = getI18NValue(180889714),
		Order = getI18NValue(180889713),
		PieceIdList = {
			5300161,
			5300162,
			5300163,
			5300164
		},
		MemoryReward = {
			2,
			30,
			5053116,
			1
		}
	},
	[5300170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300160,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter17.mp4",
		Id = 5300170,
		Level = 17,
		SoulId = 20010053,
		Name = getI18NValue(180889716),
		Order = getI18NValue(180889715),
		PieceIdList = {
			5300171,
			5300172,
			5300173,
			5300174
		},
		MemoryReward = {
			2,
			30,
			5053117,
			1
		}
	},
	[5300180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5300170,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter18.mp4",
		Id = 5300180,
		Level = 18,
		SoulId = 20010053,
		Name = getI18NValue(180889718),
		Order = getI18NValue(180889717),
		PieceIdList = {
			5300181,
			5300182,
			5300183,
			5300184
		},
		MemoryReward = {
			2,
			30,
			5053118,
			1
		}
	},
	[5400010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter01.mp4",
		Id = 5400010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010054,
		Name = getI18NValue(180889720),
		Order = getI18NValue(180889719),
		PieceIdList = {
			5400011,
			5400012,
			5400013,
			5400014
		},
		MemoryReward = {
			2,
			30,
			5054101,
			1
		}
	},
	[5400020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400010,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter02.mp4",
		Id = 5400020,
		Level = 2,
		SoulId = 20010054,
		Name = getI18NValue(180889722),
		Order = getI18NValue(180889721),
		PieceIdList = {
			5400021,
			5400022,
			5400023,
			5400024
		},
		MemoryReward = {
			2,
			30,
			5054102,
			1
		}
	},
	[5400030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400020,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter03.mp4",
		Id = 5400030,
		Level = 3,
		SoulId = 20010054,
		Name = getI18NValue(180889724),
		Order = getI18NValue(180889723),
		PieceIdList = {
			5400031,
			5400032,
			5400033,
			5400034
		},
		MemoryReward = {
			2,
			30,
			5054103,
			1
		}
	},
	[5400040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400030,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter04.mp4",
		Id = 5400040,
		Level = 4,
		SoulId = 20010054,
		Name = getI18NValue(180889726),
		Order = getI18NValue(180889725),
		PieceIdList = {
			5400041,
			5400042,
			5400043,
			5400044
		},
		MemoryReward = {
			2,
			30,
			5054104,
			1
		}
	},
	[5400050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400040,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter05.mp4",
		Id = 5400050,
		Level = 5,
		SoulId = 20010054,
		Name = getI18NValue(180889728),
		Order = getI18NValue(180889727),
		PieceIdList = {
			5400051,
			5400052,
			5400053,
			5400054
		},
		MemoryReward = {
			2,
			30,
			5054105,
			1
		}
	},
	[5400060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400050,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter06.mp4",
		Id = 5400060,
		Level = 6,
		SoulId = 20010054,
		Name = getI18NValue(180889730),
		Order = getI18NValue(180889729),
		PieceIdList = {
			5400061,
			5400062,
			5400063,
			5400064
		},
		MemoryReward = {
			2,
			30,
			5054106,
			1
		}
	},
	[5400070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400060,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter07.mp4",
		Id = 5400070,
		Level = 7,
		SoulId = 20010054,
		Name = getI18NValue(180889732),
		Order = getI18NValue(180889731),
		PieceIdList = {
			5400071,
			5400072,
			5400073,
			5400074
		},
		MemoryReward = {
			2,
			30,
			5054107,
			1
		}
	},
	[5400080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400070,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter08.mp4",
		Id = 5400080,
		Level = 8,
		SoulId = 20010054,
		Name = getI18NValue(180889734),
		Order = getI18NValue(180889733),
		PieceIdList = {
			5400081,
			5400082,
			5400083,
			5400084
		},
		MemoryReward = {
			2,
			30,
			5054108,
			1
		}
	},
	[5400090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400080,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter09.mp4",
		Id = 5400090,
		Level = 9,
		SoulId = 20010054,
		Name = getI18NValue(180889736),
		Order = getI18NValue(180889735),
		PieceIdList = {
			5400091,
			5400092,
			5400093,
			5400094
		},
		MemoryReward = {
			2,
			30,
			5054109,
			1
		}
	},
	[5400100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400090,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter10.mp4",
		Id = 5400100,
		Level = 10,
		SoulId = 20010054,
		Name = getI18NValue(180889738),
		Order = getI18NValue(180889737),
		PieceIdList = {
			5400101,
			5400102,
			5400103,
			5400104
		},
		MemoryReward = {
			2,
			30,
			5054110,
			1
		}
	},
	[5400110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400100,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter11.mp4",
		Id = 5400110,
		Level = 11,
		SoulId = 20010054,
		Name = getI18NValue(180889740),
		Order = getI18NValue(180889739),
		PieceIdList = {
			5400111,
			5400112,
			5400113,
			5400114
		},
		MemoryReward = {
			2,
			30,
			5054111,
			1
		}
	},
	[5400120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400110,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter12.mp4",
		Id = 5400120,
		Level = 12,
		SoulId = 20010054,
		Name = getI18NValue(180889742),
		Order = getI18NValue(180889741),
		PieceIdList = {
			5400121,
			5400122,
			5400123,
			5400124
		},
		MemoryReward = {
			2,
			30,
			5054112,
			1
		}
	},
	[5400130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400120,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter13.mp4",
		Id = 5400130,
		Level = 13,
		SoulId = 20010054,
		Name = getI18NValue(180889744),
		Order = getI18NValue(180889743),
		PieceIdList = {
			5400131,
			5400132,
			5400133,
			5400134
		},
		MemoryReward = {
			2,
			30,
			5054113,
			1
		}
	},
	[5400140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400130,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter14.mp4",
		Id = 5400140,
		Level = 14,
		SoulId = 20010054,
		Name = getI18NValue(180889746),
		Order = getI18NValue(180889745),
		PieceIdList = {
			5400141,
			5400142,
			5400143,
			5400144
		},
		MemoryReward = {
			2,
			30,
			5054114,
			1
		}
	},
	[5400150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400140,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter15.mp4",
		Id = 5400150,
		Level = 15,
		SoulId = 20010054,
		Name = getI18NValue(180889748),
		Order = getI18NValue(180889747),
		PieceIdList = {
			5400151,
			5400152,
			5400153,
			5400154
		},
		MemoryReward = {
			2,
			30,
			5054115,
			1
		}
	},
	[5400160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400150,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter16.mp4",
		Id = 5400160,
		Level = 16,
		SoulId = 20010054,
		Name = getI18NValue(180889750),
		Order = getI18NValue(180889749),
		PieceIdList = {
			5400161,
			5400162,
			5400163,
			5400164
		},
		MemoryReward = {
			2,
			30,
			5054116,
			1
		}
	},
	[5400170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400160,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter17.mp4",
		Id = 5400170,
		Level = 17,
		SoulId = 20010054,
		Name = getI18NValue(180889752),
		Order = getI18NValue(180889751),
		PieceIdList = {
			5400171,
			5400172,
			5400173,
			5400174
		},
		MemoryReward = {
			2,
			30,
			5054117,
			1
		}
	},
	[5400180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5400170,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter18.mp4",
		Id = 5400180,
		Level = 18,
		SoulId = 20010054,
		Name = getI18NValue(180889754),
		Order = getI18NValue(180889753),
		PieceIdList = {
			5400181,
			5400182,
			5400183,
			5400184
		},
		MemoryReward = {
			2,
			30,
			5054118,
			1
		}
	},
	[5500010] = {
		ResourceSize = "5M",
		Level = 1,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter01.mp4",
		Id = 5500010,
		UnlockFavorDegreeLevel = 1,
		SoulId = 20010055,
		Name = getI18NValue(180889756),
		Order = getI18NValue(180889755),
		PieceIdList = {
			5500011,
			5500012,
			5500013,
			5500014
		},
		MemoryReward = {
			2,
			30,
			5055101,
			1
		}
	},
	[5500020] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 3,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500010,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter02.mp4",
		Id = 5500020,
		Level = 2,
		SoulId = 20010055,
		Name = getI18NValue(180889758),
		Order = getI18NValue(180889757),
		PieceIdList = {
			5500021,
			5500022,
			5500023,
			5500024
		},
		MemoryReward = {
			2,
			30,
			5055102,
			1
		}
	},
	[5500030] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 6,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500020,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter03.mp4",
		Id = 5500030,
		Level = 3,
		SoulId = 20010055,
		Name = getI18NValue(180889760),
		Order = getI18NValue(180889759),
		PieceIdList = {
			5500031,
			5500032,
			5500033,
			5500034
		},
		MemoryReward = {
			2,
			30,
			5055103,
			1
		}
	},
	[5500040] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 8,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500030,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter04.mp4",
		Id = 5500040,
		Level = 4,
		SoulId = 20010055,
		Name = getI18NValue(180889762),
		Order = getI18NValue(180889761),
		PieceIdList = {
			5500041,
			5500042,
			5500043,
			5500044
		},
		MemoryReward = {
			2,
			30,
			5055104,
			1
		}
	},
	[5500050] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 10,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500040,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter05.mp4",
		Id = 5500050,
		Level = 5,
		SoulId = 20010055,
		Name = getI18NValue(180889764),
		Order = getI18NValue(180889763),
		PieceIdList = {
			5500051,
			5500052,
			5500053,
			5500054
		},
		MemoryReward = {
			2,
			30,
			5055105,
			1
		}
	},
	[5500060] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 13,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500050,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter06.mp4",
		Id = 5500060,
		Level = 6,
		SoulId = 20010055,
		Name = getI18NValue(180889766),
		Order = getI18NValue(180889765),
		PieceIdList = {
			5500061,
			5500062,
			5500063,
			5500064
		},
		MemoryReward = {
			2,
			30,
			5055106,
			1
		}
	},
	[5500070] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 17,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500060,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter07.mp4",
		Id = 5500070,
		Level = 7,
		SoulId = 20010055,
		Name = getI18NValue(180889768),
		Order = getI18NValue(180889767),
		PieceIdList = {
			5500071,
			5500072,
			5500073,
			5500074
		},
		MemoryReward = {
			2,
			30,
			5055107,
			1
		}
	},
	[5500080] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 19,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500070,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter08.mp4",
		Id = 5500080,
		Level = 8,
		SoulId = 20010055,
		Name = getI18NValue(180889770),
		Order = getI18NValue(180889769),
		PieceIdList = {
			5500081,
			5500082,
			5500083,
			5500084
		},
		MemoryReward = {
			2,
			30,
			5055108,
			1
		}
	},
	[5500090] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 22,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500080,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter09.mp4",
		Id = 5500090,
		Level = 9,
		SoulId = 20010055,
		Name = getI18NValue(180889772),
		Order = getI18NValue(180889771),
		PieceIdList = {
			5500091,
			5500092,
			5500093,
			5500094
		},
		MemoryReward = {
			2,
			30,
			5055109,
			1
		}
	},
	[5500100] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 25,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500090,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter10.mp4",
		Id = 5500100,
		Level = 10,
		SoulId = 20010055,
		Name = getI18NValue(180889774),
		Order = getI18NValue(180889773),
		PieceIdList = {
			5500101,
			5500102,
			5500103,
			5500104
		},
		MemoryReward = {
			2,
			30,
			5055110,
			1
		}
	},
	[5500110] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 29,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500100,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter11.mp4",
		Id = 5500110,
		Level = 11,
		SoulId = 20010055,
		Name = getI18NValue(180889776),
		Order = getI18NValue(180889775),
		PieceIdList = {
			5500111,
			5500112,
			5500113,
			5500114
		},
		MemoryReward = {
			2,
			30,
			5055111,
			1
		}
	},
	[5500120] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 31,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500110,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter12.mp4",
		Id = 5500120,
		Level = 12,
		SoulId = 20010055,
		Name = getI18NValue(180889778),
		Order = getI18NValue(180889777),
		PieceIdList = {
			5500121,
			5500122,
			5500123,
			5500124
		},
		MemoryReward = {
			2,
			30,
			5055112,
			1
		}
	},
	[5500130] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 34,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500120,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter13.mp4",
		Id = 5500130,
		Level = 13,
		SoulId = 20010055,
		Name = getI18NValue(180889780),
		Order = getI18NValue(180889779),
		PieceIdList = {
			5500131,
			5500132,
			5500133,
			5500134
		},
		MemoryReward = {
			2,
			30,
			5055113,
			1
		}
	},
	[5500140] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 38,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500130,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter14.mp4",
		Id = 5500140,
		Level = 14,
		SoulId = 20010055,
		Name = getI18NValue(180889782),
		Order = getI18NValue(180889781),
		PieceIdList = {
			5500141,
			5500142,
			5500143,
			5500144
		},
		MemoryReward = {
			2,
			30,
			5055114,
			1
		}
	},
	[5500150] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 41,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500140,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter15.mp4",
		Id = 5500150,
		Level = 15,
		SoulId = 20010055,
		Name = getI18NValue(180889784),
		Order = getI18NValue(180889783),
		PieceIdList = {
			5500151,
			5500152,
			5500153,
			5500154
		},
		MemoryReward = {
			2,
			30,
			5055115,
			1
		}
	},
	[5500160] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 44,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500150,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter16.mp4",
		Id = 5500160,
		Level = 16,
		SoulId = 20010055,
		Name = getI18NValue(180889786),
		Order = getI18NValue(180889785),
		PieceIdList = {
			5500161,
			5500162,
			5500163,
			5500164
		},
		MemoryReward = {
			2,
			30,
			5055116,
			1
		}
	},
	[5500170] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 47,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500160,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter17.mp4",
		Id = 5500170,
		Level = 17,
		SoulId = 20010055,
		Name = getI18NValue(180889788),
		Order = getI18NValue(180889787),
		PieceIdList = {
			5500171,
			5500172,
			5500173,
			5500174
		},
		MemoryReward = {
			2,
			30,
			5055117,
			1
		}
	},
	[5500180] = {
		ResourceSize = "5M",
		UnlockFavorDegreeLevel = 50,
		MemoryType = 1,
		PlayPrefab = "/ART_Prefabs/UI/UIModel/UI_Memory_Andrea_VideoFrame.prefab",
		ImageCover = "/Image_Resources/SoulResources/SoulSoulUICoverImage/CoverImage_Andrea/Andrea.png",
		PreMemoryChapter = 5500170,
		Movie = "/Memory/Andrea/Memory_Andrea_Chapter18.mp4",
		Id = 5500180,
		Level = 18,
		SoulId = 20010055,
		Name = getI18NValue(180889790),
		Order = getI18NValue(180889789),
		PieceIdList = {
			5500181,
			5500182,
			5500183,
			5500184
		},
		MemoryReward = {
			2,
			30,
			5055118,
			1
		}
	}
}

setmetatable(CfgSoulMemoryChapterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSoulMemoryChapterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ResourceSize = "",
		Scene = 0,
		Level = 0,
		PlayPrefab = "",
		SceneEntity = 0,
		Order = "",
		ImageCover = "",
		Icon = "",
		Name = "",
		PreMemoryChapter = 0,
		Movie = "",
		MemoryType = 0,
		UnlockFavorDegreeLevel = 0,
		SoulId = 0,
		PieceIdList = {},
		MemoryReward = {}
	}
}

for i, data in pairs(CfgSoulMemoryChapterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSoulMemoryChapterTable
