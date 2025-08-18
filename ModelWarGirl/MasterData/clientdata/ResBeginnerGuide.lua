-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResBeginnerGuide.lua

local RT = {}

RT[1] = {
	"MiniGamePassLevel",
	"99",
	"99",
	"1"
}
RT[2] = {
	"MiniGameInfoCanvas"
}
RT[3] = {
	"1",
	"1",
	"1"
}
RT[4] = {
	"1",
	"1",
	"2"
}
RT[5] = {
	"MainMenuCanvas"
}
RT[6] = {
	"MainMenuOutsideCanvas"
}
RT[7] = {
	"1",
	"1",
	"3"
}
RT[8] = {
	"1",
	"1",
	"4"
}
RT[9] = {
	"HeroMainCanvas"
}
RT[10] = {
	"1",
	"1",
	"5",
	"1",
	"1",
	"9"
}
RT[11] = {
	"1",
	"1",
	"12"
}
RT[12] = {
	"MainBattleLvInfoCanvas"
}
RT[13] = {
	"1",
	"2",
	"6"
}
RT[14] = {
	"BattleResultFailCanvas"
}
RT[15] = {
	"1",
	"1",
	"15"
}
RT[16] = {
	"BackyardMainCanvas"
}
RT[17] = {
	"1",
	"2",
	"15"
}
RT[18] = {
	"1",
	"3",
	"15"
}
RT[19] = {
	"1",
	"3",
	"30"
}
RT[20] = {
	"1",
	"5",
	"1"
}
RT[21] = {
	"1",
	"9",
	"1"
}
RT[22] = {
	"1",
	"6",
	"6"
}
RT[23] = {
	"1",
	"13",
	"1"
}
RT[24] = {
	"1",
	"26",
	"1"
}
RT[25] = {
	"StageTowerCanvas"
}
RT[26] = {
	"PetMainCanvas"
}
RT[27] = {
	"ChallengeBossMainCanvas"
}
RT[28] = {
	"AsynPVPMainCanvas"
}
RT[29] = {
	"SeniorPVPMainCanvas"
}
RT[30] = {
	"WorldBossMainCanvas"
}
RT[31] = {
	"1",
	"1",
	"1",
	"1",
	"2",
	"24"
}
RT[32] = {
	"HeroUpgradeCanvas"
}
RT[33] = {
	"CheckRearHouseLevel",
	"8"
}
RT[34] = {
	"CrystalFirstStepOver"
}
RT[35] = {
	"CrystalSecondCheck"
}
RT[36] = {
	"BackyardCrystalLvUpCanvas"
}
RT[37] = {
	"HeroPoolNewCanvas"
}
RT[38] = {
	"HeroSellCanvas"
}
RT[39] = {
	"202"
}
RT[40] = {
	"203"
}
RT[41] = {
	"haveOverflowHero"
}
RT[42] = {
	"1",
	"4",
	"6"
}
RT[43] = {
	"GameGatherMainCanvas"
}
RT[44] = {
	"CaseTaskMainCanvas"
}
RT[45] = {
	"CircleBattleMainCanvas"
}
RT[46] = {
	"2101"
}
RT[47] = {
	"ActivityNewYearEveMainCanvas"
}
RT[48] = {
	"ActivityEveAwardCanvas"
}
RT[49] = {
	"2601"
}
RT[50] = {
	"ActivityCollectWordsCanvas"
}
RT[51] = {
	"ActivityCollectWordsGet"
}
RT[52] = {
	"29001"
}
RT[53] = {
	"ActivityValentineMainCanvas"
}
RT[54] = {
	"21001"
}
RT[55] = {
	"37002"
}
RT[56] = {
	"ActivityManagementMainCanvas"
}
RT[57] = {
	"ActivityBPCanvas"
}
RT[58] = {
	"CheckManagementCanCommitOrder"
}
RT[59] = {
	"CheckManagementAssignToyTypeOpen"
}
RT[60] = {
	"CheckManagementImproveToyQualityOpen"
}
RT[61] = {
	"CheckManagementBreakOutOpen"
}
RT[62] = {
	"29002"
}
RT[63] = {
	"ActivityMidAutumnMainCanvas"
}
RT[64] = {
	"2602"
}
RT[65] = {
	"21002"
}
RT[66] = {
	"29003"
}
RT[67] = {
	"37004"
}
RT[68] = {
	"29004"
}
RT[69] = {
	"37005"
}

local Data = {
	{
		id = 1,
		trigger_node = 1,
		conditions = 6,
		condition_args = RT[1]
	},
	{
		continue = 1,
		trigger_node = 2,
		conditions = 6,
		id = 2,
		condition_args = RT[1]
	},
	{
		id = 3,
		trigger_node = 2,
		conditions = 6,
		condition_args = {
			"MiniGamePassLevel",
			"1",
			"0",
			"0"
		}
	},
	{
		id = 4,
		trigger_node = 5,
		trigger_args = RT[2]
	},
	{
		trigger_node = 5,
		conditions = 6,
		id = 5,
		condition_args = {
			"MiniGamePassLevel",
			"1",
			"3",
			"0"
		},
		trigger_args = RT[2]
	},
	[11] = {
		id = 11,
		trigger_node = 8,
		trigger_args = RT[3]
	},
	[12] = {
		id = 12,
		trigger_node = 8,
		trigger_args = RT[4]
	},
	[99] = {
		continue = 1,
		trigger_node = 2,
		conditions = 6,
		id = 99,
		condition_args = RT[1]
	},
	[100] = {
		continue = 1,
		trigger_node = 2,
		conditions = 6,
		id = 100,
		condition_args = RT[1]
	},
	[101] = {
		trigger_node = 2,
		conditions = 6,
		id = 101,
		trigger_always = 1,
		condition_args = {
			"MiniGamePassLevel",
			"1",
			"3",
			"1"
		}
	},
	[102] = {
		id = 102,
		trigger_node = 3,
		trigger_args = RT[3]
	},
	[103] = {
		id = 103,
		trigger_node = 6,
		trigger_always = 1,
		trigger_args = RT[3]
	},
	[105] = {
		trigger_node = 5,
		conditions = 5,
		id = 105,
		trigger_always = 1,
		condition_args = {
			"1",
			"1",
			"1",
			"1",
			"1",
			"3"
		},
		trigger_args = RT[5]
	},
	[106] = {
		trigger_node = 5,
		conditions = 1,
		id = 106,
		trigger_always = 1,
		condition_args = RT[3],
		trigger_args = RT[6]
	},
	[107] = {
		id = 107,
		trigger_node = 3,
		trigger_args = RT[4]
	},
	[108] = {
		id = 108,
		trigger_node = 6,
		trigger_always = 1,
		trigger_args = RT[4]
	},
	[110] = {
		trigger_node = 5,
		conditions = 1,
		id = 110,
		trigger_always = 1,
		condition_args = RT[4],
		trigger_args = RT[6]
	},
	[111] = {
		id = 111,
		trigger_node = 3,
		trigger_args = RT[7]
	},
	[112] = {
		id = 112,
		trigger_node = 6,
		trigger_always = 1,
		trigger_args = RT[7]
	},
	[113] = {
		trigger_node = 5,
		conditions = 1,
		id = 113,
		trigger_always = 1,
		condition_args = RT[7],
		trigger_args = RT[6]
	},
	[120] = {
		continue = 1,
		trigger_node = 2,
		conditions = 1,
		id = 120,
		condition_args = RT[8]
	},
	[121] = {
		continue = 1,
		trigger_node = 2,
		conditions = 6,
		id = 121,
		trigger_always = 1,
		condition_args = {
			"BeforeCreateRole",
			"1",
			"1",
			"4"
		}
	},
	[123] = {
		continue = 1,
		trigger_node = 2,
		conditions = 1,
		id = 123,
		condition_args = RT[8]
	},
	[124] = {
		continue = 1,
		trigger_node = 2,
		conditions = 1,
		id = 124,
		condition_args = RT[8]
	},
	[125] = {
		trigger_node = 5,
		conditions = 5,
		id = 125,
		condition_args = {
			"1",
			"1",
			"4",
			"1",
			"1",
			"9"
		},
		trigger_args = RT[9]
	},
	[126] = {
		id = 126,
		trigger_node = 2,
		conditions = 1,
		condition_args = RT[8]
	},
	[135] = {
		id = 135,
		trigger_node = 3,
		trigger_args = {
			"1",
			"1",
			"5"
		}
	},
	[136] = {
		continue = 1,
		trigger_node = 5,
		conditions = 5,
		id = 136,
		condition_args = RT[10],
		trigger_args = RT[6]
	},
	[137] = {
		trigger_node = 5,
		conditions = 5,
		id = 137,
		condition_args = RT[10],
		trigger_args = RT[6]
	},
	[140] = {
		id = 140,
		trigger_node = 2,
		conditions = 1,
		condition_args = {
			"1",
			"1",
			"9"
		}
	},
	[141] = {
		trigger_node = 5,
		conditions = 5,
		id = 141,
		condition_args = {
			"1",
			"1",
			"9",
			"1",
			"1",
			"12"
		},
		trigger_args = RT[5]
	},
	[142] = {
		id = 142,
		trigger_node = 2,
		conditions = 1,
		condition_args = {
			"1",
			"1",
			"10"
		}
	},
	[150] = {
		continue = 1,
		trigger_node = 5,
		conditions = 1,
		id = 150,
		condition_args = RT[11],
		trigger_args = {
			"BattleResultMainWinAwardCanvas"
		}
	},
	[151] = {
		continue = 1,
		trigger_node = 2,
		conditions = 1,
		id = 151,
		condition_args = RT[11]
	},
	[152] = {
		id = 152,
		trigger_node = 2,
		conditions = 1,
		condition_args = RT[11]
	},
	[153] = {
		id = 153,
		trigger_node = 3,
		trigger_args = {
			"1",
			"1",
			"13"
		}
	},
	[154] = {
		trigger_node = 5,
		conditions = 6,
		id = 154,
		condition_args = {
			"ConditionStageCanSkip"
		},
		trigger_args = RT[12]
	},
	[171] = {
		id = 171,
		trigger_node = 6,
		trigger_args = {
			"1",
			"6",
			"24"
		}
	},
	[172] = {
		id = 172,
		trigger_node = 6,
		trigger_args = {
			"1",
			"2",
			"3"
		}
	},
	[173] = {
		id = 173,
		trigger_node = 6,
		trigger_args = {
			"1",
			"2",
			"9"
		}
	},
	[175] = {
		id = 175,
		trigger_node = 3,
		trigger_always = 1,
		trigger_args = {
			"1",
			"2",
			"1"
		}
	},
	[176] = {
		id = 176,
		trigger_node = 3,
		trigger_always = 1,
		trigger_args = RT[13]
	},
	[177] = {
		id = 177,
		trigger_node = 3,
		trigger_always = 1,
		trigger_args = {
			"1",
			"2",
			"10"
		}
	},
	[178] = {
		id = 178,
		trigger_node = 3,
		trigger_always = 1,
		trigger_args = {
			"1",
			"4",
			"4"
		}
	},
	[190] = {
		trigger_node = 5,
		conditions = 5,
		id = 190,
		condition_args = RT[10],
		trigger_args = RT[14]
	},
	[191] = {
		trigger_node = 5,
		conditions = 5,
		id = 191,
		condition_args = {
			"1",
			"1",
			"9",
			"1",
			"2",
			"4"
		},
		trigger_args = RT[14]
	},
	[192] = {
		continue = 1,
		trigger_node = 2,
		conditions = 1,
		id = 192,
		condition_args = RT[15]
	},
	[193] = {
		continue = 1,
		trigger_node = 5,
		conditions = 1,
		id = 193,
		condition_args = RT[15],
		trigger_args = RT[16]
	},
	[194] = {
		continue = 1,
		trigger_node = 5,
		conditions = 1,
		id = 194,
		condition_args = RT[15],
		trigger_args = RT[16]
	},
	[195] = {
		trigger_node = 5,
		conditions = 1,
		id = 195,
		condition_args = RT[15],
		trigger_args = RT[16]
	},
	[196] = {
		id = 196,
		trigger_node = 2,
		conditions = 1,
		condition_args = RT[15]
	},
	[198] = {
		id = 198,
		trigger_node = 2,
		conditions = 1,
		condition_args = RT[15]
	},
	[200] = {
		continue = 1,
		trigger_node = 2,
		conditions = 3,
		id = 200,
		condition_args = RT[13]
	},
	[201] = {
		id = 201,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[13]
	},
	[210] = {
		continue = 1,
		trigger_node = 2,
		conditions = 3,
		id = 210,
		condition_args = RT[17]
	},
	[211] = {
		id = 211,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[17]
	},
	[212] = {
		id = 212,
		trigger_node = 2,
		conditions = 3,
		condition_args = {
			"1",
			"3",
			"1"
		}
	},
	[213] = {
		trigger_node = 5,
		conditions = 1,
		id = 213,
		condition_args = {
			"1",
			"3",
			"2"
		},
		trigger_args = RT[12]
	},
	[215] = {
		continue = 1,
		trigger_node = 2,
		conditions = 3,
		id = 215,
		condition_args = RT[18]
	},
	[216] = {
		id = 216,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[18]
	},
	[220] = {
		continue = 1,
		trigger_node = 2,
		conditions = 3,
		id = 220,
		condition_args = RT[19]
	},
	[221] = {
		id = 221,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[19]
	},
	[225] = {
		continue = 1,
		trigger_node = 2,
		conditions = 3,
		id = 225,
		condition_args = RT[20]
	},
	[226] = {
		id = 226,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[20]
	},
	[227] = {
		id = 227,
		trigger_node = 2,
		conditions = 8,
		condition_args = {
			"1308"
		}
	},
	[230] = {
		continue = 1,
		trigger_node = 2,
		conditions = 3,
		id = 230,
		condition_args = RT[21]
	},
	[231] = {
		id = 231,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[21]
	},
	[232] = {
		trigger_node = 5,
		conditions = 6,
		id = 232,
		condition_args = {
			"ConditionFuncOpenWearInfo",
			"27"
		},
		trigger_args = {
			"TeamSetMainCanvas"
		}
	},
	[233] = {
		trigger_node = 5,
		conditions = 6,
		id = 233,
		condition_args = {
			"ConditionFuncOpenCreateNewPlan",
			"27"
		},
		trigger_args = {
			"BagMainCanvas"
		}
	},
	[235] = {
		id = 235,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[22]
	},
	[236] = {
		trigger_node = 5,
		conditions = 7,
		id = 236,
		condition_args = {
			"49"
		},
		trigger_args = RT[5]
	},
	[240] = {
		id = 240,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[23]
	},
	[245] = {
		id = 245,
		trigger_node = 2,
		conditions = 5,
		condition_args = {
			"1",
			"19",
			"1",
			"1",
			"19",
			"30"
		}
	},
	[246] = {
		id = 246,
		trigger_node = 2,
		conditions = 3,
		condition_args = {
			"1",
			"20",
			"1"
		}
	},
	[247] = {
		id = 247,
		trigger_node = 2,
		conditions = 3,
		condition_args = RT[24]
	},
	[248] = {
		trigger_node = 5,
		conditions = 3,
		id = 248,
		condition_args = RT[11],
		trigger_args = {
			"SetMainCanvas"
		}
	},
	[249] = {
		id = 249,
		trigger_node = 7,
		trigger_args = {
			"ShowHeroEnjoyPanel"
		}
	},
	[250] = {
		id = 250,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[25]
	},
	[251] = {
		trigger_node = 5,
		conditions = 4,
		id = 251,
		condition_args = {
			"1",
			"1"
		},
		trigger_args = RT[25]
	},
	[252] = {
		id = 252,
		trigger_node = 3,
		trigger_args = {
			"2010001"
		}
	},
	[255] = {
		id = 255,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[26]
	},
	[256] = {
		id = 256,
		trigger_node = 5,
		trigger_args = RT[26]
	},
	[260] = {
		id = 260,
		trigger_node = 5,
		trigger_args = RT[27]
	},
	[262] = {
		id = 262,
		trigger_node = 5,
		trigger_args = {
			"CircleListCanvas"
		}
	},
	[265] = {
		id = 265,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[28]
	},
	[266] = {
		id = 266,
		trigger_node = 5,
		trigger_args = RT[28]
	},
	[270] = {
		id = 270,
		trigger_node = 5,
		continue = 1,
		trigger_args = {
			"OneTimeTowerCanvas"
		}
	},
	[275] = {
		id = 275,
		trigger_node = 5,
		trigger_args = {
			"MazzChooseCanvas"
		}
	},
	[276] = {
		id = 276,
		trigger_node = 5,
		trigger_args = {
			"MazzMainCanvas"
		}
	},
	[277] = {
		id = 277,
		trigger_node = 5,
		trigger_args = {
			"MazzChooseMainCanvas"
		}
	},
	[278] = {
		id = 278,
		trigger_node = 5,
		continue = 1,
		trigger_args = {
			"MazzPetMainCanvas"
		}
	},
	[279] = {
		trigger_node = 5,
		conditions = 6,
		id = 279,
		condition_args = {
			"CheckPetMazeHaveBattleHeroList"
		},
		trigger_args = {
			"BattleNmlInfoCanvas"
		}
	},
	[280] = {
		id = 280,
		trigger_node = 5,
		trigger_args = {
			"EquipTowerMainCanvas"
		}
	},
	[285] = {
		trigger_node = 5,
		conditions = 3,
		id = 285,
		condition_args = RT[22],
		trigger_args = RT[27]
	},
	[290] = {
		trigger_node = 5,
		conditions = 3,
		id = 290,
		condition_args = RT[23],
		trigger_args = {
			"PVPMainCanvas"
		}
	},
	[291] = {
		continue = 1,
		trigger_node = 5,
		conditions = 3,
		id = 291,
		condition_args = RT[23],
		trigger_args = RT[29]
	},
	[292] = {
		trigger_node = 5,
		conditions = 3,
		id = 292,
		condition_args = RT[23],
		trigger_args = RT[29]
	},
	[296] = {
		id = 296,
		trigger_node = 5,
		trigger_args = RT[30]
	},
	[297] = {
		trigger_node = 5,
		conditions = 3,
		id = 297,
		condition_args = RT[24],
		trigger_args = {
			"NewChallengeBossLvCanvas"
		}
	},
	[300] = {
		trigger_node = 7,
		conditions = 3,
		id = 300,
		condition_args = {
			"1",
			"1",
			"6"
		},
		trigger_args = {
			"ShowHeroGrowPanel",
			"1",
			"11",
			"0"
		}
	},
	[301] = {
		id = 301,
		trigger_node = 7,
		trigger_args = {
			"HeroStepUp",
			"1"
		}
	},
	[302] = {
		id = 302,
		trigger_node = 7,
		trigger_args = {
			"HeroStepUp",
			"2"
		}
	},
	[303] = {
		trigger_node = 7,
		conditions = 3,
		id = 303,
		condition_args = RT[13],
		trigger_args = {
			"ShowHeroGrowPanel",
			"1",
			"21",
			"1"
		}
	},
	[305] = {
		id = 305,
		trigger_node = 7,
		trigger_args = {
			"CheckHeroHatEnhance"
		}
	},
	[306] = {
		continue = 1,
		trigger_node = 5,
		conditions = 5,
		id = 306,
		condition_args = RT[31],
		trigger_args = RT[32]
	},
	[307] = {
		trigger_node = 5,
		conditions = 5,
		id = 307,
		condition_args = RT[31],
		trigger_args = RT[32]
	},
	[310] = {
		id = 310,
		trigger_node = 7,
		continue = 1,
		trigger_args = RT[33]
	},
	[311] = {
		id = 311,
		trigger_node = 7,
		trigger_args = RT[33]
	},
	[312] = {
		id = 312,
		trigger_node = 7,
		trigger_args = {
			"CheckRearHouseLevel",
			"10"
		}
	},
	[313] = {
		id = 313,
		trigger_node = 5,
		trigger_args = {
			"BackyardDispatchInfoCanvas"
		}
	},
	[315] = {
		id = 315,
		trigger_node = 7,
		trigger_args = {
			"CheckRearHouseLevel",
			"38"
		}
	},
	[320] = {
		id = 320,
		trigger_node = 7,
		trigger_args = {
			"CrystalSecondUnlock"
		}
	},
	[321] = {
		trigger_node = 5,
		conditions = 6,
		id = 321,
		condition_args = RT[34],
		trigger_args = RT[5]
	},
	[322] = {
		trigger_node = 5,
		conditions = 6,
		id = 322,
		condition_args = RT[34],
		trigger_args = {
			"StoreMainCanvas"
		}
	},
	[323] = {
		id = 323,
		trigger_node = 5,
		trigger_args = {
			"HeroStarUpRevertCanvas"
		}
	},
	[324] = {
		trigger_node = 5,
		conditions = 3,
		id = 324,
		condition_args = RT[24],
		trigger_args = RT[5]
	},
	[325] = {
		trigger_node = 5,
		conditions = 3,
		id = 325,
		condition_args = RT[24],
		trigger_args = {
			"HeroShowRoomMainCanvas"
		}
	},
	[326] = {
		trigger_node = 5,
		conditions = 3,
		id = 326,
		condition_args = RT[24],
		trigger_args = {
			"HeroShowRoomListCanvas"
		}
	},
	[327] = {
		trigger_node = 5,
		conditions = 3,
		id = 327,
		condition_args = RT[24],
		trigger_args = {
			"HeroShowRoomGrowUpCanvas"
		}
	},
	[328] = {
		trigger_node = 5,
		conditions = 6,
		id = 328,
		condition_args = RT[35],
		trigger_args = RT[5]
	},
	[329] = {
		continue = 1,
		trigger_node = 5,
		conditions = 6,
		id = 329,
		condition_args = RT[35],
		trigger_args = RT[36]
	},
	[330] = {
		trigger_node = 5,
		conditions = 6,
		id = 330,
		condition_args = RT[35],
		trigger_args = {
			"BackyardCollectAchiCanvas"
		}
	},
	[331] = {
		trigger_node = 5,
		conditions = 6,
		id = 331,
		condition_args = RT[35],
		trigger_args = RT[36]
	},
	[332] = {
		id = 332,
		trigger_node = 7,
		trigger_args = {
			"CheckPetGemCanLvUp"
		}
	},
	[333] = {
		id = 333,
		trigger_node = 7,
		trigger_args = {
			"CheckPetCanWearGem"
		}
	},
	[334] = {
		id = 334,
		trigger_node = 5,
		continue = 1,
		trigger_args = {
			"PetPoolMainCanvas"
		}
	},
	[335] = {
		id = 335,
		trigger_node = 7,
		trigger_args = {
			"CheckPetPoolCanReset"
		}
	},
	[336] = {
		id = 336,
		trigger_node = 5,
		trigger_args = {
			"PetEnchantMainCanvas"
		}
	},
	[337] = {
		id = 337,
		trigger_node = 5,
		trigger_args = {
			"PetEnchantAttrWashCanvas"
		}
	},
	[338] = {
		id = 338,
		trigger_node = 5,
		trigger_args = {
			"PetEnchantGetSkillCanvas"
		}
	},
	[351] = {
		id = 351,
		trigger_node = 5,
		trigger_args = {
			"TaskMainCanvas"
		}
	},
	[352] = {
		id = 352,
		trigger_node = 5,
		trigger_args = {
			"BeginnerTaskCanvas"
		}
	},
	[353] = {
		id = 353,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[37]
	},
	[354] = {
		id = 354,
		trigger_node = 5,
		trigger_args = RT[37]
	},
	[355] = {
		id = 355,
		trigger_node = 5,
		trigger_args = RT[38]
	},
	[356] = {
		trigger_node = 5,
		conditions = 6,
		id = 356,
		condition_args = {
			"HeroResetCheck"
		},
		trigger_args = RT[9]
	},
	[357] = {
		id = 357,
		trigger_node = 5,
		trigger_args = {
			"ResetBoxCanvas"
		}
	},
	[358] = {
		trigger_node = 7,
		conditions = 3,
		id = 358,
		condition_args = RT[15],
		trigger_args = {
			"ShowDrawStandardHero"
		}
	},
	[359] = {
		trigger_node = 5,
		conditions = 6,
		id = 359,
		condition_args = {
			"HeroResetCheck2"
		},
		trigger_args = RT[9]
	},
	[360] = {
		id = 360,
		trigger_node = 3,
		trigger_args = {
			"kBattleTypeOpActPlot"
		}
	},
	[361] = {
		id = 361,
		trigger_node = 7,
		trigger_args = {
			"NewBieDrawCardOver"
		}
	},
	[364] = {
		id = 364,
		trigger_node = 2,
		conditions = 3,
		condition_args = {
			"1",
			"2",
			"24"
		}
	},
	[365] = {
		trigger_node = 5,
		conditions = 3,
		id = 365,
		condition_args = RT[11],
		trigger_args = {
			"PlayerInforPersonalCanvas"
		}
	},
	[366] = {
		id = 366,
		trigger_node = 5,
		trigger_args = {
			"HandBookHeroInfoCanvas"
		}
	},
	[367] = {
		id = 367,
		trigger_node = 5,
		trigger_args = {
			"ARCanvas"
		}
	},
	[370] = {
		continue = 1,
		trigger_node = 5,
		conditions = 7,
		id = 370,
		condition_args = RT[39],
		trigger_args = RT[30]
	},
	[371] = {
		trigger_node = 5,
		conditions = 7,
		id = 371,
		condition_args = RT[39],
		trigger_args = RT[30]
	},
	[372] = {
		continue = 1,
		trigger_node = 5,
		conditions = 7,
		id = 372,
		condition_args = RT[40],
		trigger_args = RT[30]
	},
	[373] = {
		trigger_node = 5,
		conditions = 7,
		id = 373,
		condition_args = RT[40],
		trigger_args = RT[30]
	},
	[376] = {
		trigger_node = 5,
		conditions = 6,
		id = 376,
		condition_args = RT[41],
		trigger_args = RT[9]
	},
	[377] = {
		trigger_node = 5,
		conditions = 6,
		id = 377,
		condition_args = RT[41],
		trigger_args = RT[38]
	},
	[378] = {
		id = 378,
		trigger_node = 5,
		trigger_args = {
			"HeroCoatingCanvas"
		}
	},
	[379] = {
		trigger_node = 5,
		conditions = 6,
		id = 379,
		condition_args = {
			"BeginnerNodeUniqueHero"
		},
		trigger_args = RT[9]
	},
	[380] = {
		trigger_node = 5,
		conditions = 6,
		id = 380,
		condition_args = {
			"HeroStoryUnlocked"
		},
		trigger_args = RT[9]
	},
	[381] = {
		trigger_node = 5,
		conditions = 6,
		id = 381,
		condition_args = {
			"EquipTowerNormalOver"
		},
		trigger_args = {
			"EquipTowerLvCanvas"
		}
	},
	[382] = {
		id = 382,
		trigger_node = 7,
		trigger_args = {
			"CheckPaintPlusCanUnlock"
		}
	},
	[400] = {
		trigger_node = 5,
		conditions = 3,
		id = 400,
		condition_args = RT[42],
		trigger_args = RT[6]
	},
	[401] = {
		id = 401,
		trigger_node = 5,
		trigger_args = {
			"SeasonTowerMainCanvas"
		}
	},
	[402] = {
		id = 402,
		trigger_node = 5,
		trigger_args = {
			"SeasonTowerLvCanvas"
		}
	},
	[403] = {
		continue = 1,
		trigger_node = 5,
		conditions = 3,
		id = 403,
		condition_args = RT[42],
		trigger_args = RT[43]
	},
	[404] = {
		id = 404,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[44]
	},
	[405] = {
		id = 405,
		trigger_node = 5,
		trigger_args = RT[44]
	},
	[406] = {
		id = 406,
		trigger_node = 5,
		trigger_args = {
			"NewSeasonTowerMainCanvas"
		}
	},
	[407] = {
		id = 407,
		trigger_node = 5,
		trigger_args = {
			"NewSeasonTowerLvCanvas"
		}
	},
	[410] = {
		trigger_node = 5,
		conditions = 3,
		id = 410,
		condition_args = RT[42],
		trigger_args = RT[43]
	},
	[411] = {
		id = 411,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[45]
	},
	[412] = {
		id = 412,
		trigger_node = 5,
		continue = 1,
		trigger_args = RT[45]
	},
	[413] = {
		trigger_node = 5,
		conditions = 6,
		id = 413,
		condition_args = {
			"isCircleMaster"
		},
		trigger_args = RT[45]
	},
	[414] = {
		trigger_node = 5,
		conditions = 3,
		id = 414,
		condition_args = RT[20],
		trigger_args = RT[43]
	},
	[415] = {
		id = 415,
		trigger_node = 5,
		trigger_args = {
			"RogueChooseCanvas"
		}
	},
	[416] = {
		id = 416,
		trigger_node = 5,
		trigger_args = {
			"RogueMainCanvas"
		}
	},
	[417] = {
		id = 417,
		trigger_node = 5,
		trigger_args = {
			"RogueTeamSetCanvas"
		}
	},
	[418] = {
		id = 418,
		trigger_node = 5,
		trigger_args = {
			"RogueChooseThreeCanvas"
		}
	},
	[419] = {
		id = 419,
		trigger_node = 7,
		trigger_args = {
			"CheckGoNextLayer",
			"2"
		}
	},
	[421] = {
		id = 421,
		trigger_node = 7,
		trigger_args = {
			"CheckGoNextLayer",
			"3"
		}
	},
	[422] = {
		id = 422,
		trigger_node = 7,
		trigger_args = {
			"CheckGoNextLayer",
			"4"
		}
	},
	[423] = {
		id = 423,
		trigger_node = 7,
		trigger_args = {
			"CheckGoNextLayer",
			"5"
		}
	},
	[424] = {
		id = 424,
		trigger_node = 7,
		trigger_args = {
			"CheckGoNextLayer",
			"6"
		}
	},
	[425] = {
		id = 425,
		trigger_node = 7,
		trigger_args = {
			"CheckGoNextLayer",
			"7"
		}
	},
	[426] = {
		trigger_node = 5,
		conditions = 8,
		id = 426,
		condition_args = {
			"1309"
		},
		trigger_args = RT[43]
	},
	[427] = {
		id = 427,
		trigger_node = 5,
		trigger_args = {
			"SneakBattleMainCanvas"
		}
	},
	[432] = {
		id = 432,
		trigger_node = 5,
		trigger_args = {
			"SneakBattleTeamSetCanvas"
		}
	},
	[433] = {
		id = 433,
		trigger_node = 5,
		trigger_args = {
			"SneakBattleLevelInfoCanvas"
		}
	},
	[435] = {
		id = 435,
		trigger_node = 7,
		trigger_args = {
			"CheckSneakBattleSecondLevel"
		}
	},
	[450] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 450,
		condition_args = RT[46],
		trigger_args = RT[47]
	},
	[451] = {
		trigger_node = 5,
		conditions = 8,
		id = 451,
		condition_args = RT[46],
		trigger_args = RT[48]
	},
	[452] = {
		trigger_node = 5,
		conditions = 8,
		id = 452,
		condition_args = RT[46],
		trigger_args = RT[47]
	},
	[453] = {
		trigger_node = 5,
		conditions = 8,
		id = 453,
		condition_args = {
			"303"
		},
		trigger_args = {
			"ActivityMonopolyMainCanvas"
		}
	},
	[454] = {
		trigger_node = 5,
		conditions = 8,
		id = 454,
		condition_args = {
			"2701"
		},
		trigger_args = {
			"ActivityCatRaceMainCanvas"
		}
	},
	[455] = {
		trigger_node = 5,
		conditions = 8,
		id = 455,
		condition_args = RT[49],
		trigger_args = RT[50]
	},
	[456] = {
		trigger_node = 5,
		conditions = 8,
		id = 456,
		condition_args = RT[49],
		trigger_args = RT[51]
	},
	[457] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 457,
		condition_args = RT[52],
		trigger_args = RT[53]
	},
	[458] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 458,
		condition_args = RT[52],
		trigger_args = RT[53]
	},
	[459] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 459,
		condition_args = RT[54],
		trigger_args = RT[47]
	},
	[460] = {
		trigger_node = 5,
		conditions = 8,
		id = 460,
		condition_args = RT[54],
		trigger_args = RT[48]
	},
	[461] = {
		trigger_node = 5,
		conditions = 8,
		id = 461,
		condition_args = RT[54],
		trigger_args = RT[47]
	},
	[462] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 462,
		condition_args = RT[55],
		trigger_args = RT[56]
	},
	[463] = {
		trigger_node = 5,
		conditions = 8,
		id = 463,
		condition_args = RT[55],
		trigger_args = RT[57]
	},
	[464] = {
		trigger_node = 5,
		conditions = 6,
		id = 464,
		condition_args = {
			"CheckManagementHaveStorehouseOrder"
		},
		trigger_args = RT[56]
	},
	[465] = {
		trigger_node = 7,
		conditions = 8,
		id = 465,
		condition_args = RT[55],
		trigger_args = RT[58]
	},
	[466] = {
		trigger_node = 7,
		conditions = 8,
		id = 466,
		condition_args = RT[55],
		trigger_args = RT[59]
	},
	[467] = {
		trigger_node = 7,
		conditions = 8,
		id = 467,
		condition_args = RT[55],
		trigger_args = RT[60]
	},
	[468] = {
		trigger_node = 7,
		conditions = 8,
		id = 468,
		condition_args = RT[55],
		trigger_args = RT[61]
	},
	[469] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 469,
		condition_args = RT[62],
		trigger_args = RT[63]
	},
	[470] = {
		trigger_node = 5,
		conditions = 8,
		id = 470,
		condition_args = RT[62],
		trigger_args = RT[63]
	},
	[471] = {
		trigger_node = 5,
		conditions = 8,
		id = 471,
		condition_args = RT[64],
		trigger_args = RT[50]
	},
	[472] = {
		trigger_node = 5,
		conditions = 8,
		id = 472,
		condition_args = RT[64],
		trigger_args = RT[51]
	},
	[473] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 473,
		condition_args = RT[65],
		trigger_args = RT[47]
	},
	[474] = {
		trigger_node = 5,
		conditions = 8,
		id = 474,
		condition_args = RT[65],
		trigger_args = RT[48]
	},
	[475] = {
		trigger_node = 5,
		conditions = 8,
		id = 475,
		condition_args = RT[65],
		trigger_args = RT[47]
	},
	[476] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 476,
		condition_args = RT[66],
		trigger_args = RT[53]
	},
	[477] = {
		trigger_node = 5,
		conditions = 8,
		id = 477,
		condition_args = RT[66],
		trigger_args = RT[53]
	},
	[478] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 478,
		condition_args = RT[67],
		trigger_args = RT[56]
	},
	[479] = {
		trigger_node = 5,
		conditions = 8,
		id = 479,
		condition_args = RT[67],
		trigger_args = RT[57]
	},
	[480] = {
		trigger_node = 7,
		conditions = 8,
		id = 480,
		condition_args = RT[67],
		trigger_args = RT[58]
	},
	[481] = {
		trigger_node = 7,
		conditions = 8,
		id = 481,
		condition_args = RT[67],
		trigger_args = RT[59]
	},
	[482] = {
		trigger_node = 7,
		conditions = 8,
		id = 482,
		condition_args = RT[67],
		trigger_args = RT[60]
	},
	[483] = {
		trigger_node = 7,
		conditions = 8,
		id = 483,
		condition_args = RT[67],
		trigger_args = RT[61]
	},
	[484] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 484,
		condition_args = RT[68],
		trigger_args = RT[63]
	},
	[485] = {
		trigger_node = 5,
		conditions = 8,
		id = 485,
		condition_args = RT[68],
		trigger_args = RT[63]
	},
	[486] = {
		continue = 1,
		trigger_node = 5,
		conditions = 8,
		id = 486,
		condition_args = RT[69],
		trigger_args = RT[56]
	},
	[487] = {
		trigger_node = 5,
		conditions = 8,
		id = 487,
		condition_args = RT[69],
		trigger_args = RT[57]
	},
	[488] = {
		trigger_node = 7,
		conditions = 8,
		id = 488,
		condition_args = RT[69],
		trigger_args = RT[58]
	},
	[489] = {
		trigger_node = 7,
		conditions = 8,
		id = 489,
		condition_args = RT[69],
		trigger_args = RT[59]
	},
	[490] = {
		trigger_node = 7,
		conditions = 8,
		id = 490,
		condition_args = RT[69],
		trigger_args = RT[60]
	},
	[491] = {
		trigger_node = 7,
		conditions = 8,
		id = 491,
		condition_args = RT[69],
		trigger_args = RT[61]
	}
}

return Data
