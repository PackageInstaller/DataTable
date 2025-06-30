-- chunkname: @IQIGame\\Config\\CfgHomeLandActionTable_1.lua

local CfgHomeLandActionTable_1 = {
	[1000] = {
		Id = 1000,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[1001] = {
		Id = 1001,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000110,
			1000100,
			1000110,
			1000120
		}
	},
	[1002] = {
		Id = 1002,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000130
		}
	},
	[1003] = {
		Id = 1003,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000110,
			1000100,
			1000110,
			1000131,
			1000100
		}
	},
	[1004] = {
		Id = 1004,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000111,
			1000100,
			1000111,
			1000120
		}
	},
	[101] = {
		Id = 101,
		RandomWeight = 1,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1
		}
	},
	[102] = {
		Id = 102,
		RandomWeight = 2,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			2
		}
	},
	[103] = {
		Id = 103,
		RandomWeight = 3,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3
		}
	},
	[104] = {
		Id = 104,
		ActionUnitIDList = {
			130,
			131,
			132,
			133
		}
	},
	[105] = {
		Id = 105,
		ActionUnitIDList = {
			130,
			131
		}
	},
	[1000001] = {
		Id = 1000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[1000002] = {
		Id = 1000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[1000003] = {
		Id = 1000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[1000004] = {
		Id = 1000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			1000010
		}
	},
	[1000005] = {
		Id = 1000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			1000020
		}
	},
	[1000006] = {
		RandomWeight = 1000,
		Id = 1000006,
		SubstituteAction = 1000605,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			1000020,
			1000640
		}
	},
	[1000007] = {
		RandomWeight = 1000,
		Id = 1000007,
		SubstituteAction = 1000606,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			1000020,
			1000642
		}
	},
	[1000008] = {
		RandomWeight = 1000,
		Id = 1000008,
		SubstituteAction = 1000615,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			1000020,
			1000650
		}
	},
	[1000009] = {
		RandomWeight = 1000,
		Id = 1000009,
		SubstituteAction = 1000616,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			1000020,
			1000652
		}
	},
	[1000011] = {
		RandomWeight = 10,
		Id = 1000011,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000110,
			1000100,
			1000110,
			1000120
		}
	},
	[1000012] = {
		RandomWeight = 10,
		Id = 1000012,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000130
		}
	},
	[1000013] = {
		RandomWeight = 10,
		Id = 1000013,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000110,
			1000100,
			1000110,
			1000131,
			1000100
		}
	},
	[1000021] = {
		RandomWeight = 20,
		Id = 1000021,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000111,
			1000100,
			1000111,
			1000120
		}
	},
	[1000022] = {
		RandomWeight = 20,
		Id = 1000022,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000112,
			1000100,
			1000112,
			1000120
		}
	},
	[1000023] = {
		RandomWeight = 20,
		Id = 1000023,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000113,
			1000100,
			1000113,
			1000120
		}
	},
	[1000024] = {
		RandomWeight = 20,
		Id = 1000024,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000140
		}
	},
	[1000025] = {
		RandomWeight = 20,
		Id = 1000025,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			1000110,
			1000100,
			1000110,
			1000141,
			1000100
		}
	},
	[1000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 1000026,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			1000150
		}
	},
	[1000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 1000031,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101,
			802
		},
		ActionUnitIDList = {
			1000151
		}
	},
	[1000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 1000041,
		SubstituteAction = 1000004,
		ConditionIDList = {
			101,
			804
		},
		ActionUnitIDList = {
			1000152
		}
	},
	[1000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 1000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			1000200
		}
	},
	[1000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 1000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			1000201
		}
	},
	[1000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 1000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			1000200
		}
	},
	[1000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 1000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			1000201
		}
	},
	[1000121] = {
		Id = 1000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[1000122] = {
		Id = 1000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[1000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 1000201,
		SubstituteAction = 1000005,
		ActionUnitIDList = {
			1000300,
			1000310
		}
	},
	[1000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 1000202,
		SubstituteAction = 1000005,
		ActionUnitIDList = {
			1000300,
			1000311
		}
	},
	[1000211] = {
		Id = 1000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[1000212] = {
		RandomWeight = 10,
		Id = 1000212,
		SubstituteAction = 1000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1000320
		}
	},
	[1000213] = {
		Id = 1000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[1000214] = {
		RandomWeight = 60,
		Id = 1000214,
		SubstituteAction = 1000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1000321
		}
	},
	[1000221] = {
		RandomWeight = 10,
		Id = 1000221,
		SubstituteAction = 1000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			1000310
		}
	},
	[1000222] = {
		RandomWeight = 20,
		Id = 1000222,
		SubstituteAction = 1000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			1000311
		}
	},
	[1000231] = {
		isDailyAction = true,
		Id = 1000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000330
		}
	},
	[1000232] = {
		isDailyAction = true,
		Id = 1000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000331
		}
	},
	[1000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 1000301,
		SubstituteAction = 1000005,
		ActionUnitIDList = {
			1000400,
			1000410
		}
	},
	[1000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 1000302,
		SubstituteAction = 1000005,
		ActionUnitIDList = {
			1000400,
			1000411
		}
	},
	[1000311] = {
		Id = 1000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[1000312] = {
		RandomWeight = 10,
		Id = 1000312,
		SubstituteAction = 1000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1000420
		}
	},
	[1000313] = {
		Id = 1000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[1000314] = {
		RandomWeight = 60,
		Id = 1000314,
		SubstituteAction = 1000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1000421
		}
	},
	[1000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000321,
		SubstituteAction = 1000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			1000410
		}
	},
	[1000322] = {
		RandomWeight = 20,
		Id = 1000322,
		SubstituteAction = 1000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			1000411
		}
	},
	[1000331] = {
		isDailyAction = true,
		Id = 1000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000430
		}
	},
	[1000332] = {
		isDailyAction = true,
		Id = 1000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000431
		}
	},
	[1000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 1000401,
		SubstituteAction = 1000005,
		ActionUnitIDList = {
			1000500,
			1000510
		}
	},
	[1000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 1000402,
		SubstituteAction = 1000005,
		ActionUnitIDList = {
			1000500,
			1000511
		}
	},
	[1000411] = {
		Id = 1000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[1000412] = {
		RandomWeight = 10,
		Id = 1000412,
		SubstituteAction = 1000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1000520
		}
	},
	[1000413] = {
		Id = 1000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[1000414] = {
		RandomWeight = 60,
		Id = 1000414,
		SubstituteAction = 1000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			1000521
		}
	},
	[1000421] = {
		RandomWeight = 10,
		Id = 1000421,
		SubstituteAction = 1000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			1000510
		}
	},
	[1000422] = {
		RandomWeight = 20,
		Id = 1000422,
		SubstituteAction = 1000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			1000511
		}
	},
	[1000431] = {
		isDailyAction = true,
		Id = 1000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000530
		}
	},
	[1000432] = {
		isDailyAction = true,
		Id = 1000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			1000531
		}
	},
	[1000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000501,
		SubstituteAction = 1000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000600,
			1000601,
			1000602,
			1000603,
			1000604
		}
	},
	[1000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000502,
		SubstituteAction = 1000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000610,
			1000611,
			1000612,
			1000613,
			1000614
		}
	},
	[1000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000605,
			1000606
		}
	},
	[1000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000615,
			1000616
		}
	},
	[1000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000511,
		SubstituteAction = 1000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000620,
			1000621,
			1000622
		}
	},
	[1000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000512,
		SubstituteAction = 1000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000630,
			1000631,
			1000632
		}
	},
	[1000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000623,
			1000624
		}
	},
	[1000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 1000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000633,
			1000634
		}
	},
	[1000601] = {
		Id = 1000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[1000602] = {
		RandomWeight = 10,
		Id = 1000602,
		SubstituteAction = 1000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000640
		}
	},
	[1000603] = {
		Id = 1000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[1000604] = {
		RandomWeight = 30,
		Id = 1000604,
		SubstituteAction = 1000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000642
		}
	},
	[1000605] = {
		Id = 1000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000641
		}
	},
	[1000606] = {
		Id = 1000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			1000643
		}
	},
	[1000611] = {
		Id = 1000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[1000612] = {
		RandomWeight = 30,
		Id = 1000612,
		SubstituteAction = 1000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000650,
			1000651
		}
	},
	[1000613] = {
		Id = 1000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[1000614] = {
		RandomWeight = 30,
		Id = 1000614,
		SubstituteAction = 1000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000652,
			1000653
		}
	},
	[1000615] = {
		Id = 1000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000651
		}
	},
	[1000616] = {
		Id = 1000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			1000653
		}
	},
	[1000701] = {
		RandomWeight = 30,
		Id = 1000701,
		SubstituteAction = 1000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			1000603,
			1000604
		}
	},
	[1000702] = {
		RandomWeight = 10,
		Id = 1000702,
		SubstituteAction = 1000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			1000613,
			1000614
		}
	},
	[1000711] = {
		RandomWeight = 10,
		Id = 1000711,
		SubstituteAction = 1000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			1000621,
			1000622
		}
	},
	[1000712] = {
		RandomWeight = 10,
		Id = 1000712,
		SubstituteAction = 1000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			1000631,
			1000632
		}
	},
	[1000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 1000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			1000810,
			1000811,
			1000812,
			1000813
		}
	},
	[1000802] = {
		isDailyAction = true,
		Id = 1000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			1000820,
			1000821,
			1000822,
			1000823
		}
	},
	[1000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 1000803,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			1000830,
			1000831,
			1000832,
			1000833
		}
	},
	[1000901] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 1000901,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			1000910,
			1000911,
			1000912,
			1000913
		}
	},
	[1000902] = {
		isDailyAction = true,
		Id = 1000902,
		RandomWeight = 50,
		ActionUnitIDList = {
			1000920,
			1000921,
			1000922,
			1000923
		}
	},
	[1005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 1005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[1005002] = {
		Id = 1005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			1000100,
			1000110,
			1000111,
			1000112,
			1000113,
			1000120
		}
	},
	[2000001] = {
		Id = 2000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[2010001] = {
		Id = 2010001,
		RandomWeight = 10,
		ConditionIDList = {
			120211
		},
		ActionUnitIDList = {
			100
		}
	},
	[2000002] = {
		Id = 2000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[2000003] = {
		Id = 2000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[2000004] = {
		Id = 2000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			2000010
		}
	},
	[2000005] = {
		Id = 2000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			2000020
		}
	},
	[2000011] = {
		RandomWeight = 10,
		Id = 2000011,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000120
		}
	},
	[2000012] = {
		RandomWeight = 10,
		Id = 2000012,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000130
		}
	},
	[2000013] = {
		RandomWeight = 10,
		Id = 2000013,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000131,
			2000100
		}
	},
	[2000021] = {
		RandomWeight = 20,
		Id = 2000021,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000111,
			2000100,
			2000111,
			2000120
		}
	},
	[2000022] = {
		RandomWeight = 20,
		Id = 2000022,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000112,
			2000100,
			2000112,
			2000120
		}
	},
	[2000023] = {
		RandomWeight = 20,
		Id = 2000023,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000113,
			2000100,
			2000113,
			2000120
		}
	},
	[2000024] = {
		RandomWeight = 20,
		Id = 2000024,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000140
		}
	},
	[2000025] = {
		RandomWeight = 20,
		Id = 2000025,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000141,
			2000100
		}
	},
	[2000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 2000026,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			2000150
		}
	},
	[2010002] = {
		Id = 2010002,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			120211
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[2010003] = {
		Id = 2010003,
		RandomWeight = 1000,
		ConditionIDList = {
			103,
			120211
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[2010004] = {
		Id = 2010004,
		RandomWeight = 1000,
		ConditionIDList = {
			120211
		},
		ActionUnitIDList = {
			2000010
		}
	},
	[2010005] = {
		Id = 2010005,
		RandomWeight = 1000,
		ConditionIDList = {
			120211
		},
		ActionUnitIDList = {
			2000020
		}
	},
	[2010011] = {
		RandomWeight = 10,
		Id = 2010011,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000120
		}
	},
	[2010012] = {
		RandomWeight = 10,
		Id = 2010012,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000130
		}
	},
	[2010013] = {
		RandomWeight = 10,
		Id = 2010013,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000131,
			2000100
		}
	},
	[2010021] = {
		RandomWeight = 20,
		Id = 2010021,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000111,
			2000100,
			2000111,
			2000120
		}
	},
	[2010022] = {
		RandomWeight = 20,
		Id = 2010022,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000112,
			2000100,
			2000112,
			2000120
		}
	},
	[2010023] = {
		RandomWeight = 20,
		Id = 2010023,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000113,
			2000100,
			2000113,
			2000120
		}
	},
	[2010024] = {
		RandomWeight = 20,
		Id = 2010024,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000140
		}
	},
	[2010025] = {
		RandomWeight = 20,
		Id = 2010025,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000141,
			2000100
		}
	},
	[2010026] = {
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 2010026,
		SubstituteAction = 2010004,
		ConditionIDList = {
			101,
			901,
			120211
		},
		ActionUnitIDList = {
			2000150
		}
	},
	[2011002] = {
		Id = 2011002,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			120211,
			11031
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[2011003] = {
		Id = 2011003,
		RandomWeight = 1000,
		ConditionIDList = {
			103,
			120211,
			11031
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[2011004] = {
		Id = 2011004,
		RandomWeight = 1000,
		ConditionIDList = {
			120211,
			11031
		},
		ActionUnitIDList = {
			2000010
		}
	},
	[2011005] = {
		Id = 2011005,
		RandomWeight = 1000,
		ConditionIDList = {
			120211,
			11031
		},
		ActionUnitIDList = {
			2000020
		}
	},
	[2011011] = {
		RandomWeight = 10,
		Id = 2011011,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000120
		}
	},
	[2011012] = {
		RandomWeight = 10,
		Id = 2011012,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000130
		}
	},
	[2011013] = {
		RandomWeight = 10,
		Id = 2011013,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000131,
			2000100
		}
	},
	[2011021] = {
		RandomWeight = 20,
		Id = 2011021,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000111,
			2000100,
			2000111,
			2000120
		}
	},
	[2011022] = {
		RandomWeight = 20,
		Id = 2011022,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000112,
			2000100,
			2000112,
			2000120
		}
	},
	[2011023] = {
		RandomWeight = 20,
		Id = 2011023,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000113,
			2000100,
			2000113,
			2000120
		}
	},
	[2011024] = {
		RandomWeight = 20,
		Id = 2011024,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000140
		}
	},
	[2011025] = {
		RandomWeight = 20,
		Id = 2011025,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000110,
			2000100,
			2000110,
			2000141,
			2000100
		}
	},
	[2011026] = {
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 2011026,
		SubstituteAction = 2011004,
		ConditionIDList = {
			101,
			901,
			120211,
			11031
		},
		ActionUnitIDList = {
			2000150
		}
	},
	[2000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 2000031,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101,
			801
		},
		ActionUnitIDList = {
			2000151
		}
	},
	[2000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 2000041,
		SubstituteAction = 2000004,
		ConditionIDList = {
			101,
			809
		},
		ActionUnitIDList = {
			2000152
		}
	},
	[2000071] = {
		RandomWeight = 50,
		Id = 2000071,
		SubstituteAction = 2000004,
		ConditionIDList = {
			20011
		},
		ActionUnitIDList = {
			2000170
		}
	},
	[2000072] = {
		RandomWeight = 50,
		Id = 2000072,
		SubstituteAction = 2000004,
		ConditionIDList = {
			20012
		},
		ActionUnitIDList = {
			2000171,
			2000172
		}
	},
	[2000073] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 2000073,
		SubstituteAction = 2000004,
		ConditionIDList = {
			20012
		},
		ActionUnitIDList = {
			2000171,
			2000173
		}
	},
	[2000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2000121] = {
		Id = 2000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[2000122] = {
		Id = 2000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			102
		}
	},
	[2000201] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000201,
		SubstituteAction = 2000203,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000300,
			2000301,
			2000302,
			2000303,
			2000304
		}
	},
	[2000202] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000202,
		SubstituteAction = 2000204,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000310,
			2000311,
			2000312,
			2000313,
			2000314
		}
	},
	[2000203] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000203,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000303,
			2000304
		}
	},
	[2000204] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000204,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000313,
			2000314
		}
	},
	[2000211] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000211,
		SubstituteAction = 2000213,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000320,
			2000321,
			2000322
		}
	},
	[2000212] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000212,
		SubstituteAction = 2000214,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000330,
			2000331,
			2000332
		}
	},
	[2000213] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000213,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000321,
			2000322
		}
	},
	[2000214] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000214,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000331,
			2000332
		}
	},
	[2000301] = {
		Id = 2000301,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2000302] = {
		RandomWeight = 10,
		Id = 2000302,
		SubstituteAction = 2000305,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000340
		}
	},
	[2000303] = {
		Id = 2000303,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2000304] = {
		RandomWeight = 30,
		Id = 2000304,
		SubstituteAction = 2000306,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000341
		}
	},
	[2000305] = {
		Id = 2000305,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000340
		}
	},
	[2000306] = {
		Id = 2000306,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000341
		}
	},
	[2000311] = {
		Id = 2000311,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2000312] = {
		RandomWeight = 30,
		Id = 2000312,
		SubstituteAction = 2000315,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000350
		}
	},
	[2000313] = {
		Id = 2000313,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2000314] = {
		RandomWeight = 30,
		Id = 2000314,
		SubstituteAction = 2000316,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000351
		}
	},
	[2000315] = {
		Id = 2000315,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000350
		}
	},
	[2000316] = {
		Id = 2000316,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000351
		}
	},
	[2000401] = {
		RandomWeight = 30,
		Id = 2000401,
		SubstituteAction = 2000203,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000303,
			2000304
		}
	},
	[2000402] = {
		RandomWeight = 10,
		Id = 2000402,
		SubstituteAction = 2000204,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000313,
			2000314
		}
	},
	[2000411] = {
		RandomWeight = 10,
		Id = 2000411,
		SubstituteAction = 2000213,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000321,
			2000322
		}
	},
	[2000412] = {
		RandomWeight = 10,
		Id = 2000412,
		SubstituteAction = 2000214,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000331,
			2000332
		}
	},
	[2000501] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000501,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2000502] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000502,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2000511] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000511,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2000512] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000512,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2000601] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000601,
		SubstituteAction = 2000603,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000400,
			2000401,
			2000402,
			2000403,
			2000404
		}
	},
	[2000602] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000602,
		SubstituteAction = 2000604,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000410,
			2000411,
			2000412,
			2000413,
			2000414
		}
	},
	[2000603] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000603,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000403,
			2000404
		}
	},
	[2000604] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000604,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000413,
			2000414
		}
	},
	[2000611] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000611,
		SubstituteAction = 2000613,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000420,
			2000421,
			2000422
		}
	},
	[2000612] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000612,
		SubstituteAction = 2000614,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000430,
			2000431,
			2000432
		}
	},
	[2000613] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000613,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000421,
			2000422
		}
	},
	[2000614] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2000614,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000431,
			2000432
		}
	},
	[2000701] = {
		Id = 2000701,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2000702] = {
		RandomWeight = 10,
		Id = 2000702,
		SubstituteAction = 2000705,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000440
		}
	},
	[2000703] = {
		Id = 2000703,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2000704] = {
		RandomWeight = 30,
		Id = 2000704,
		SubstituteAction = 2000706,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000441
		}
	},
	[2000705] = {
		Id = 2000705,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000440
		}
	},
	[2000706] = {
		Id = 2000706,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000441
		}
	},
	[2000711] = {
		Id = 2000711,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2000712] = {
		RandomWeight = 30,
		Id = 2000712,
		SubstituteAction = 2000715,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000450
		}
	},
	[2000713] = {
		Id = 2000713,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2000714] = {
		RandomWeight = 30,
		Id = 2000714,
		SubstituteAction = 2000716,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000451
		}
	},
	[2000715] = {
		Id = 2000715,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000450
		}
	},
	[2000716] = {
		Id = 2000716,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000451
		}
	},
	[2000801] = {
		RandomWeight = 30,
		Id = 2000801,
		SubstituteAction = 2000603,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000403,
			2000404
		}
	},
	[2000802] = {
		RandomWeight = 10,
		Id = 2000802,
		SubstituteAction = 2000604,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000413,
			2000414
		}
	},
	[2000811] = {
		RandomWeight = 10,
		Id = 2000811,
		SubstituteAction = 2000613,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000421,
			2000422
		}
	},
	[2000812] = {
		RandomWeight = 10,
		Id = 2000812,
		SubstituteAction = 2000614,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000431,
			2000432
		}
	},
	[2000901] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000901,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2000902] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000902,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2000911] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000911,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2000912] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2000912,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2001001] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001001,
		SubstituteAction = 2001003,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000500,
			2000501,
			2000502,
			2000503,
			2000504
		}
	},
	[2001002] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001002,
		SubstituteAction = 2001004,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000510,
			2000511,
			2000512,
			2000513,
			2000514
		}
	},
	[2001003] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001003,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000503,
			2000504
		}
	},
	[2001004] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001004,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000513,
			2000514
		}
	},
	[2001011] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001011,
		SubstituteAction = 2001013,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000520,
			2000521,
			2000522
		}
	},
	[2001012] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001012,
		SubstituteAction = 2001014,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000530,
			2000531,
			2000532
		}
	},
	[2001013] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001013,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000521,
			2000522
		}
	},
	[2001014] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001014,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000531,
			2000532
		}
	},
	[2001101] = {
		Id = 2001101,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2001102] = {
		RandomWeight = 10,
		Id = 2001102,
		SubstituteAction = 2001105,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000540
		}
	},
	[2001103] = {
		Id = 2001103,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2001104] = {
		RandomWeight = 30,
		Id = 2001104,
		SubstituteAction = 2001106,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000541
		}
	},
	[2001105] = {
		Id = 2001105,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000540
		}
	},
	[2001106] = {
		Id = 2001106,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000541
		}
	},
	[2001111] = {
		Id = 2001111,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2001112] = {
		RandomWeight = 30,
		Id = 2001112,
		SubstituteAction = 2001115,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000550
		}
	},
	[2001113] = {
		Id = 2001113,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2001114] = {
		RandomWeight = 30,
		Id = 2001114,
		SubstituteAction = 2001116,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000551
		}
	},
	[2001115] = {
		Id = 2001115,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000550
		}
	},
	[2001116] = {
		Id = 2001116,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000551
		}
	},
	[2001201] = {
		RandomWeight = 30,
		Id = 2001201,
		SubstituteAction = 2001003,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000503,
			2000504
		}
	},
	[2001202] = {
		RandomWeight = 10,
		Id = 2001202,
		SubstituteAction = 2001004,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000513,
			2000514
		}
	},
	[2001211] = {
		RandomWeight = 10,
		Id = 2001211,
		SubstituteAction = 2001013,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000521,
			2000522
		}
	},
	[2001212] = {
		RandomWeight = 10,
		Id = 2001212,
		SubstituteAction = 2001014,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000531,
			2000532
		}
	},
	[2001301] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2001301,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2001302] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2001302,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2001311] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2001311,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000200
		}
	},
	[2001312] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 2001312,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000201
		}
	},
	[2001401] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001401,
		SubstituteAction = 2001403,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000600,
			2000601,
			2000602,
			2000603,
			2000604
		}
	},
	[2001402] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001402,
		SubstituteAction = 2001404,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000610,
			2000611,
			2000612,
			2000613,
			2000614
		}
	},
	[2001403] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001403,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000603,
			2000604
		}
	},
	[2001404] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001404,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000613,
			2000614
		}
	},
	[2001411] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001411,
		SubstituteAction = 2001413,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000620,
			2000621,
			2000622
		}
	},
	[2001412] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001412,
		SubstituteAction = 2001414,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000630,
			2000631,
			2000632
		}
	},
	[2001413] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001413,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000621,
			2000622
		}
	},
	[2001414] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2001414,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000631,
			2000632
		}
	},
	[2001501] = {
		Id = 2001501,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2001502] = {
		RandomWeight = 10,
		Id = 2001502,
		SubstituteAction = 2001505,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000640
		}
	},
	[2001503] = {
		Id = 2001503,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			101
		}
	},
	[2001504] = {
		RandomWeight = 30,
		Id = 2001504,
		SubstituteAction = 2001506,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000641
		}
	},
	[2001505] = {
		Id = 2001505,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000640
		}
	},
	[2001506] = {
		Id = 2001506,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120212
		},
		ActionUnitIDList = {
			2000641
		}
	},
	[2001511] = {
		Id = 2001511,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2001512] = {
		RandomWeight = 30,
		Id = 2001512,
		SubstituteAction = 2001515,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000650
		}
	},
	[2001513] = {
		Id = 2001513,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			102
		}
	},
	[2001514] = {
		RandomWeight = 30,
		Id = 2001514,
		SubstituteAction = 2001516,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000651
		}
	},
	[2001515] = {
		Id = 2001515,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000650
		}
	},
	[2001516] = {
		Id = 2001516,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120212
		},
		ActionUnitIDList = {
			2000651
		}
	},
	[2001601] = {
		RandomWeight = 30,
		Id = 2001601,
		SubstituteAction = 2001403,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000603,
			2000604
		}
	},
	[2001602] = {
		RandomWeight = 10,
		Id = 2001602,
		SubstituteAction = 2001404,
		ConditionIDList = {
			301,
			401,
			120212
		},
		ActionUnitIDList = {
			2000613,
			2000614
		}
	},
	[2001611] = {
		RandomWeight = 10,
		Id = 2001611,
		SubstituteAction = 2001413,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000621,
			2000622
		}
	},
	[2001612] = {
		RandomWeight = 10,
		Id = 2001612,
		SubstituteAction = 2001414,
		ConditionIDList = {
			301,
			402,
			120212
		},
		ActionUnitIDList = {
			2000631,
			2000632
		}
	},
	[2002002] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 2002002,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			2000820,
			2000821,
			2000822,
			2000823
		}
	},
	[2002003] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 2002003,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			2000830,
			2000831,
			2000832,
			2000833
		}
	},
	[2011401] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011401,
		SubstituteAction = 2011403,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001600,
			2001601,
			2001602,
			2001603,
			2001604
		}
	},
	[2011402] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011402,
		SubstituteAction = 2011404,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001610,
			2001611,
			2001612,
			2001613,
			2001614
		}
	},
	[2011403] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011403,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001603,
			2001604
		}
	},
	[2011404] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011404,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001613,
			2001614
		}
	},
	[2011411] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011411,
		SubstituteAction = 2011413,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001620,
			2001621,
			2001622
		}
	},
	[2011412] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011412,
		SubstituteAction = 2011414,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001630,
			2001631,
			2001632
		}
	},
	[2011413] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011413,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001621,
			2001622
		}
	},
	[2011414] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2011414,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001631,
			2001632
		}
	},
	[2011501] = {
		Id = 2011501,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			101
		}
	},
	[2011502] = {
		RandomWeight = 10,
		Id = 2011502,
		SubstituteAction = 2011505,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001640
		}
	},
	[2011503] = {
		Id = 2011503,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			101
		}
	},
	[2011504] = {
		RandomWeight = 30,
		Id = 2011504,
		SubstituteAction = 2011506,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001641
		}
	},
	[2011505] = {
		Id = 2011505,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001640
		}
	},
	[2011506] = {
		Id = 2011506,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001641
		}
	},
	[2011511] = {
		Id = 2011511,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			102
		}
	},
	[2011512] = {
		RandomWeight = 30,
		Id = 2011512,
		SubstituteAction = 2011515,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001650
		}
	},
	[2011513] = {
		Id = 2011513,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			102
		}
	},
	[2011514] = {
		RandomWeight = 30,
		Id = 2011514,
		SubstituteAction = 2011516,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001651
		}
	},
	[2011515] = {
		Id = 2011515,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001650
		}
	},
	[2011516] = {
		Id = 2011516,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001651
		}
	},
	[2011601] = {
		RandomWeight = 30,
		Id = 2011601,
		SubstituteAction = 2011403,
		ConditionIDList = {
			301,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001603,
			2001604
		}
	},
	[2011602] = {
		RandomWeight = 10,
		Id = 2011602,
		SubstituteAction = 2011404,
		ConditionIDList = {
			301,
			401,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001613,
			2001614
		}
	},
	[2011611] = {
		RandomWeight = 10,
		Id = 2011611,
		SubstituteAction = 2011413,
		ConditionIDList = {
			301,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001621,
			2001622
		}
	},
	[2011612] = {
		RandomWeight = 10,
		Id = 2011612,
		SubstituteAction = 2011414,
		ConditionIDList = {
			301,
			402,
			120211,
			11042
		},
		ActionUnitIDList = {
			2001631,
			2001632
		}
	},
	[2012001] = {
		Id = 2012001,
		RandomWeight = 200,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2001801,
			2001802,
			2001803
		}
	},
	[2012002] = {
		Id = 2012002,
		RandomWeight = 200,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2001811,
			2001812,
			2001813
		}
	},
	[2012003] = {
		Id = 2012003,
		RandomWeight = 200,
		ConditionIDList = {
			101,
			120211
		},
		ActionUnitIDList = {
			2001821,
			2001822,
			2001823
		}
	},
	[2012004] = {
		Id = 2012004,
		RandomWeight = 200,
		ConditionIDList = {
			101,
			120211,
			11031
		},
		ActionUnitIDList = {
			2001841,
			2001842,
			2001843
		}
	},
	[2012005] = {
		Id = 2012005,
		RandomWeight = 200,
		ConditionIDList = {
			101,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001841,
			2001842,
			2001843
		}
	},
	[2012011] = {
		Id = 2012011,
		RandomWeight = 30,
		ConditionIDList = {
			120211
		},
		ActionUnitIDList = {
			2001851,
			2001852,
			2001853
		}
	},
	[2012021] = {
		Id = 2012021,
		RandomWeight = 30,
		ConditionIDList = {
			120211
		},
		ActionUnitIDList = {
			2001861,
			2001862,
			2001863
		}
	},
	[2012031] = {
		Id = 2012031,
		RandomWeight = 1000,
		ConditionIDList = {
			120211,
			11032,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[2012032] = {
		Id = 2012032,
		RandomWeight = 1000,
		ConditionIDList = {
			120211,
			11032,
			402
		},
		ActionUnitIDList = {
			102
		}
	},
	[2012033] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 2012033,
		ConditionIDList = {
			120211,
			11032,
			401
		},
		ActionUnitIDList = {
			2001610,
			2001611,
			2001612,
			2001613,
			2001614
		}
	},
	[2012034] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 2012034,
		ConditionIDList = {
			120211,
			11032,
			402
		},
		ActionUnitIDList = {
			2001630,
			2001631,
			2001632
		}
	},
	[2012035] = {
		RandomWeight = 50,
		Id = 2012035,
		SubstituteAction = 2012036,
		ConditionIDList = {
			120211,
			11032
		},
		ActionUnitIDList = {
			2001871,
			2001872,
			2001873
		}
	},
	[2012036] = {
		Id = 2012036,
		RandomWeight = 50,
		ConditionIDList = {
			120211,
			11032
		},
		ActionUnitIDList = {
			2001874
		}
	},
	[2013401] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013401,
		SubstituteAction = 2013403,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001600,
			2001601,
			2001602,
			2001603,
			2001604
		}
	},
	[2013402] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013402,
		SubstituteAction = 2013404,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001610,
			2001611,
			2001612,
			2001613,
			2001614
		}
	},
	[2013403] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013403,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001603,
			2001604
		}
	},
	[2013404] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013404,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001613,
			2001614
		}
	},
	[2013411] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013411,
		SubstituteAction = 2013413,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001620,
			2001621,
			2001622
		}
	},
	[2013412] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013412,
		SubstituteAction = 2013414,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001630,
			2001631,
			2001632
		}
	},
	[2013413] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013413,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001621,
			2001622
		}
	},
	[2013414] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 2013414,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001631,
			2001632
		}
	},
	[2013501] = {
		Id = 2013501,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			101
		}
	},
	[2013502] = {
		RandomWeight = 10,
		Id = 2013502,
		SubstituteAction = 2013505,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001640
		}
	},
	[2013503] = {
		Id = 2013503,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			101
		}
	},
	[2013504] = {
		RandomWeight = 30,
		Id = 2013504,
		SubstituteAction = 2013506,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001641
		}
	},
	[2013505] = {
		Id = 2013505,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001640
		}
	},
	[2013506] = {
		Id = 2013506,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001641
		}
	},
	[2013511] = {
		Id = 2013511,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			102
		}
	},
	[2013512] = {
		RandomWeight = 30,
		Id = 2013512,
		SubstituteAction = 2013515,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001650
		}
	},
	[2013513] = {
		Id = 2013513,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			102
		}
	},
	[2013514] = {
		RandomWeight = 30,
		Id = 2013514,
		SubstituteAction = 2013516,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001651
		}
	},
	[2013515] = {
		Id = 2013515,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001650
		}
	},
	[2013516] = {
		Id = 2013516,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001651
		}
	},
	[2013601] = {
		RandomWeight = 30,
		Id = 2013601,
		SubstituteAction = 2013403,
		ConditionIDList = {
			301,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001603,
			2001604
		}
	},
	[2013602] = {
		RandomWeight = 10,
		Id = 2013602,
		SubstituteAction = 2013404,
		ConditionIDList = {
			301,
			401,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001613,
			2001614
		}
	},
	[2013611] = {
		RandomWeight = 10,
		Id = 2013611,
		SubstituteAction = 2013413,
		ConditionIDList = {
			301,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001621,
			2001622
		}
	},
	[2013612] = {
		RandomWeight = 10,
		Id = 2013612,
		SubstituteAction = 2013414,
		ConditionIDList = {
			301,
			402,
			120211,
			11041
		},
		ActionUnitIDList = {
			2001631,
			2001632
		}
	},
	[2005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 2005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[2005002] = {
		Id = 2005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			2000100,
			2000110,
			2000111,
			2000112,
			2000113,
			2000120
		}
	},
	[3000001] = {
		Id = 3000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[3000002] = {
		Id = 3000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[3000003] = {
		Id = 3000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[3000004] = {
		Id = 3000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			3000010
		}
	},
	[3000005] = {
		Id = 3000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			3000020
		}
	},
	[3000011] = {
		RandomWeight = 10,
		Id = 3000011,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000110,
			3000100,
			3000110,
			3000120
		}
	},
	[3000012] = {
		RandomWeight = 10,
		Id = 3000012,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000130
		}
	},
	[3000013] = {
		RandomWeight = 10,
		Id = 3000013,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000110,
			3000100,
			3000110,
			3000131,
			3000100
		}
	},
	[3000021] = {
		RandomWeight = 20,
		Id = 3000021,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000111,
			3000100,
			3000111,
			3000120
		}
	},
	[3000022] = {
		RandomWeight = 20,
		Id = 3000022,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000112,
			3000100,
			3000112,
			3000120
		}
	},
	[3000023] = {
		RandomWeight = 20,
		Id = 3000023,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000113,
			3000100,
			3000113,
			3000120
		}
	},
	[3000024] = {
		RandomWeight = 20,
		Id = 3000024,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000140
		}
	},
	[3000025] = {
		RandomWeight = 20,
		Id = 3000025,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			3000110,
			3000100,
			3000110,
			3000141,
			3000100
		}
	},
	[3000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 3000026,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			3000150
		}
	},
	[3000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 3000031,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			3000151
		}
	},
	[3000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 3000041,
		SubstituteAction = 3000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			3000152
		}
	},
	[3000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 3000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			3000210
		}
	},
	[3000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 3000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			3000211
		}
	},
	[3000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 3000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			3000210
		}
	},
	[3000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 3000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			3000211
		}
	},
	[3000121] = {
		Id = 3000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[3000122] = {
		Id = 3000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[3000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 3000201,
		SubstituteAction = 3000005,
		ActionUnitIDList = {
			3000300,
			3000310
		}
	},
	[3000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 3000202,
		SubstituteAction = 3000005,
		ActionUnitIDList = {
			3000300,
			3000311
		}
	},
	[3000211] = {
		Id = 3000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[3000212] = {
		RandomWeight = 10,
		Id = 3000212,
		SubstituteAction = 3000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			3000320
		}
	},
	[3000213] = {
		Id = 3000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[3000214] = {
		RandomWeight = 60,
		Id = 3000214,
		SubstituteAction = 3000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			3000321
		}
	},
	[3000221] = {
		RandomWeight = 10,
		Id = 3000221,
		SubstituteAction = 3000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3000310
		}
	},
	[3000222] = {
		RandomWeight = 20,
		Id = 3000222,
		SubstituteAction = 3000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3000311
		}
	},
	[3000231] = {
		isDailyAction = true,
		Id = 3000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			3000330
		}
	},
	[3000232] = {
		isDailyAction = true,
		Id = 3000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			3000331
		}
	},
	[3000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 3000301,
		SubstituteAction = 3000005,
		ActionUnitIDList = {
			3000400,
			3000410
		}
	},
	[3000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 3000302,
		SubstituteAction = 3000005,
		ActionUnitIDList = {
			3000400,
			3000411
		}
	},
	[3000311] = {
		Id = 3000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[3000312] = {
		RandomWeight = 10,
		Id = 3000312,
		SubstituteAction = 3000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			3000420
		}
	},
	[3000313] = {
		Id = 3000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[3000314] = {
		RandomWeight = 60,
		Id = 3000314,
		SubstituteAction = 3000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			3000421
		}
	},
	[3000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000321,
		SubstituteAction = 3000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3000410
		}
	},
	[3000322] = {
		RandomWeight = 20,
		Id = 3000322,
		SubstituteAction = 3000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3000411
		}
	},
	[3000331] = {
		isDailyAction = true,
		Id = 3000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			3000430
		}
	},
	[3000332] = {
		isDailyAction = true,
		Id = 3000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			3000431
		}
	},
	[3000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 3000401,
		SubstituteAction = 3000005,
		ActionUnitIDList = {
			3000500,
			3000510
		}
	},
	[3000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 3000402,
		SubstituteAction = 3000005,
		ActionUnitIDList = {
			3000500,
			3000511
		}
	},
	[3000411] = {
		Id = 3000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[3000412] = {
		RandomWeight = 10,
		Id = 3000412,
		SubstituteAction = 3000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			3000520
		}
	},
	[3000413] = {
		Id = 3000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[3000414] = {
		RandomWeight = 60,
		Id = 3000414,
		SubstituteAction = 3000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			3000521
		}
	},
	[3000421] = {
		RandomWeight = 10,
		Id = 3000421,
		SubstituteAction = 3000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3000510
		}
	},
	[3000422] = {
		RandomWeight = 20,
		Id = 3000422,
		SubstituteAction = 3000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			3000511
		}
	},
	[3000431] = {
		isDailyAction = true,
		Id = 3000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			3000530
		}
	},
	[3000432] = {
		isDailyAction = true,
		Id = 3000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			3000531
		}
	},
	[3000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000501,
		SubstituteAction = 3000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000600,
			3000601,
			3000602,
			3000603,
			3000604
		}
	},
	[3000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000502,
		SubstituteAction = 3000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000610,
			3000611,
			3000612,
			3000613,
			3000614
		}
	},
	[3000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000605,
			3000606
		}
	},
	[3000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000615,
			3000616
		}
	},
	[3000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000511,
		SubstituteAction = 3000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			3000620,
			3000621,
			3000622
		}
	},
	[3000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000512,
		SubstituteAction = 3000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			3000630,
			3000631,
			3000632
		}
	},
	[3000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			3000623,
			3000624
		}
	},
	[3000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			3000633,
			3000634
		}
	},
	[3000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000521,
		SubstituteAction = 3000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			3000620,
			3000625,
			3000624
		}
	},
	[3000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 3000522,
		SubstituteAction = 3000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			3000630,
			3000635,
			3000634
		}
	},
	[3000601] = {
		Id = 3000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[3000602] = {
		RandomWeight = 10,
		Id = 3000602,
		SubstituteAction = 3000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000100,
			3000640
		}
	},
	[3000603] = {
		Id = 3000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[3000604] = {
		RandomWeight = 30,
		Id = 3000604,
		SubstituteAction = 3000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000100,
			3000642
		}
	},
	[3000605] = {
		Id = 3000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000641
		}
	},
	[3000606] = {
		Id = 3000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000643
		}
	},
	[3000607] = {
		RandomWeight = 10,
		Id = 3000607,
		SubstituteAction = 3000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000640
		}
	},
	[3000608] = {
		RandomWeight = 30,
		Id = 3000608,
		SubstituteAction = 3000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			3000642
		}
	},
	[3000611] = {
		Id = 3000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[3000612] = {
		RandomWeight = 30,
		Id = 3000612,
		SubstituteAction = 3000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			3000100,
			3000650,
			3000651
		}
	},
	[3000613] = {
		Id = 3000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[3000614] = {
		RandomWeight = 30,
		Id = 3000614,
		SubstituteAction = 3000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			3000100,
			3000652,
			3000653
		}
	},
	[3000615] = {
		Id = 3000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			3000651
		}
	},
	[3000616] = {
		Id = 3000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			3000653
		}
	},
	[3000617] = {
		RandomWeight = 30,
		Id = 3000617,
		SubstituteAction = 3000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			3000650,
			3000651
		}
	},
	[3000618] = {
		RandomWeight = 30,
		Id = 3000618,
		SubstituteAction = 3000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			3000652,
			3000653
		}
	},
	[3000621] = {
		Id = 3000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[3000622] = {
		RandomWeight = 30,
		Id = 3000622,
		SubstituteAction = 3000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			3000635,
			3000624
		}
	},
	[3000623] = {
		Id = 3000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[3000624] = {
		RandomWeight = 30,
		Id = 3000624,
		SubstituteAction = 3000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			3000635,
			3000632
		}
	},
	[3000625] = {
		RandomWeight = 30,
		Id = 3000625,
		SubstituteAction = 3000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			3000661
		}
	},
	[3000626] = {
		RandomWeight = 30,
		Id = 3000626,
		SubstituteAction = 3000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			3000662
		}
	},
	[3000701] = {
		RandomWeight = 30,
		Id = 3000701,
		SubstituteAction = 3000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			3000603,
			3000604
		}
	},
	[3000702] = {
		RandomWeight = 10,
		Id = 3000702,
		SubstituteAction = 3000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			3000613,
			3000614
		}
	},
	[3000711] = {
		SubstituteAction = 3000513,
		RandomWeight = 10,
		Id = 3000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[3000712] = {
		RandomWeight = 10,
		Id = 3000712,
		SubstituteAction = 3000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			3000631,
			3000632
		}
	},
	[3000713] = {
		RandomWeight = 10,
		Id = 3000713,
		SubstituteAction = 3000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			3000635,
			3000624
		}
	},
	[3000714] = {
		RandomWeight = 10,
		Id = 3000714,
		SubstituteAction = 3000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			3000635,
			3000632
		}
	},
	[3000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 3000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			3000810,
			3000811,
			3000812,
			3000813
		}
	},
	[3000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 3000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			3000820,
			3000821,
			3000822,
			3000823
		}
	},
	[3005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 3005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[3005002] = {
		Id = 3005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			3000100,
			3000110,
			3000111,
			3000112,
			3000113,
			3000120
		}
	},
	[4000001] = {
		Id = 4000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[4000002] = {
		Id = 4000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[4000003] = {
		Id = 4000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[4000004] = {
		Id = 4000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			4000010
		}
	},
	[4000005] = {
		Id = 4000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			4000020
		}
	},
	[4000011] = {
		RandomWeight = 10,
		Id = 4000011,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000110,
			4000100,
			4000110,
			4000120
		}
	},
	[4000012] = {
		RandomWeight = 10,
		Id = 4000012,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000130
		}
	},
	[4000013] = {
		RandomWeight = 10,
		Id = 4000013,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000110,
			4000100,
			4000110,
			4000131,
			4000100
		}
	},
	[4000021] = {
		RandomWeight = 20,
		Id = 4000021,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000111,
			4000100,
			4000111,
			4000120
		}
	},
	[4000022] = {
		RandomWeight = 20,
		Id = 4000022,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000112,
			4000100,
			4000112,
			4000120
		}
	},
	[4000023] = {
		RandomWeight = 20,
		Id = 4000023,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000113,
			4000100,
			4000113,
			4000120
		}
	},
	[4000024] = {
		RandomWeight = 20,
		Id = 4000024,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000140
		}
	},
	[4000025] = {
		RandomWeight = 20,
		Id = 4000025,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			4000110,
			4000100,
			4000110,
			4000141,
			4000100
		}
	},
	[4000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 4000026,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			4000150
		}
	},
	[4000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 4000031,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101,
			814
		},
		ActionUnitIDList = {
			4000151
		}
	},
	[4000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 4000041,
		SubstituteAction = 4000004,
		ConditionIDList = {
			101,
			801
		},
		ActionUnitIDList = {
			4000152
		}
	},
	[4000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 4000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			4000210
		}
	},
	[4000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 4000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			4000211
		}
	},
	[4000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 4000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			4000210
		}
	},
	[4000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 4000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			4000211
		}
	},
	[4000121] = {
		Id = 4000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[4000122] = {
		Id = 4000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[4000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 4000201,
		SubstituteAction = 4000005,
		ActionUnitIDList = {
			4000300,
			4000310
		}
	},
	[4000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 4000202,
		SubstituteAction = 4000005,
		ActionUnitIDList = {
			4000300,
			4000311
		}
	},
	[4000211] = {
		Id = 4000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[4000212] = {
		RandomWeight = 10,
		Id = 4000212,
		SubstituteAction = 4000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			4000320
		}
	},
	[4000213] = {
		Id = 4000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[4000214] = {
		RandomWeight = 60,
		Id = 4000214,
		SubstituteAction = 4000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			4000321
		}
	},
	[4000221] = {
		RandomWeight = 10,
		Id = 4000221,
		SubstituteAction = 4000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			4000310
		}
	},
	[4000222] = {
		RandomWeight = 20,
		Id = 4000222,
		SubstituteAction = 4000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			4000311
		}
	},
	[4000231] = {
		isDailyAction = true,
		Id = 4000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			4000330
		}
	},
	[4000232] = {
		isDailyAction = true,
		Id = 4000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			4000331
		}
	},
	[4000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 4000301,
		SubstituteAction = 4000005,
		ActionUnitIDList = {
			4000400,
			4000410
		}
	},
	[4000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 4000302,
		SubstituteAction = 4000005,
		ActionUnitIDList = {
			4000400,
			4000411
		}
	},
	[4000311] = {
		Id = 4000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[4000312] = {
		RandomWeight = 10,
		Id = 4000312,
		SubstituteAction = 4000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			4000420
		}
	},
	[4000313] = {
		Id = 4000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[4000314] = {
		RandomWeight = 60,
		Id = 4000314,
		SubstituteAction = 4000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			4000421
		}
	},
	[4000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000321,
		SubstituteAction = 4000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			4000410
		}
	},
	[4000322] = {
		RandomWeight = 20,
		Id = 4000322,
		SubstituteAction = 4000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			4000411
		}
	},
	[4000331] = {
		isDailyAction = true,
		Id = 4000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			4000430
		}
	},
	[4000332] = {
		isDailyAction = true,
		Id = 4000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			4000431
		}
	},
	[4000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 4000401,
		SubstituteAction = 4000005,
		ActionUnitIDList = {
			4000500,
			4000510
		}
	},
	[4000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 4000402,
		SubstituteAction = 4000005,
		ActionUnitIDList = {
			4000500,
			4000511
		}
	},
	[4000411] = {
		Id = 4000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[4000412] = {
		RandomWeight = 10,
		Id = 4000412,
		SubstituteAction = 4000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			4000520
		}
	},
	[4000413] = {
		Id = 4000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[4000414] = {
		RandomWeight = 60,
		Id = 4000414,
		SubstituteAction = 4000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			4000521
		}
	},
	[4000421] = {
		RandomWeight = 10,
		Id = 4000421,
		SubstituteAction = 4000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			4000510
		}
	},
	[4000422] = {
		RandomWeight = 20,
		Id = 4000422,
		SubstituteAction = 4000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			4000511
		}
	},
	[4000431] = {
		isDailyAction = true,
		Id = 4000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			4000530
		}
	},
	[4000432] = {
		isDailyAction = true,
		Id = 4000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			4000531
		}
	},
	[4000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000501,
		SubstituteAction = 4000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000600,
			4000601,
			4000602,
			4000603,
			4000604
		}
	},
	[4000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000502,
		SubstituteAction = 4000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000610,
			4000611,
			4000612,
			4000613,
			4000614
		}
	},
	[4000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000605,
			4000606
		}
	},
	[4000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000615,
			4000616
		}
	},
	[4000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000511,
		SubstituteAction = 4000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			4000620,
			4000621,
			4000622
		}
	},
	[4000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000512,
		SubstituteAction = 4000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			4000630,
			4000631,
			4000632
		}
	},
	[4000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			4000623,
			4000624
		}
	},
	[4000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			4000633,
			4000634
		}
	},
	[4000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000521,
		SubstituteAction = 4000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			4000620,
			4000625,
			4000624
		}
	},
	[4000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 4000522,
		SubstituteAction = 4000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			4000630,
			4000635,
			4000634
		}
	},
	[4000601] = {
		Id = 4000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[4000602] = {
		RandomWeight = 10,
		Id = 4000602,
		SubstituteAction = 4000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000100,
			4000640
		}
	},
	[4000603] = {
		Id = 4000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[4000604] = {
		RandomWeight = 30,
		Id = 4000604,
		SubstituteAction = 4000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000100,
			4000642
		}
	},
	[4000605] = {
		Id = 4000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000641
		}
	},
	[4000606] = {
		Id = 4000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000643
		}
	},
	[4000607] = {
		RandomWeight = 10,
		Id = 4000607,
		SubstituteAction = 4000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000640
		}
	},
	[4000608] = {
		RandomWeight = 30,
		Id = 4000608,
		SubstituteAction = 4000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			4000642
		}
	},
	[4000611] = {
		Id = 4000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[4000612] = {
		RandomWeight = 30,
		Id = 4000612,
		SubstituteAction = 4000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			4000100,
			4000650,
			4000651
		}
	},
	[4000613] = {
		Id = 4000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[4000614] = {
		RandomWeight = 30,
		Id = 4000614,
		SubstituteAction = 4000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			4000100,
			4000652,
			4000653
		}
	},
	[4000615] = {
		Id = 4000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			4000651
		}
	},
	[4000616] = {
		Id = 4000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			4000653
		}
	},
	[4000617] = {
		RandomWeight = 30,
		Id = 4000617,
		SubstituteAction = 4000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			4000650,
			4000651
		}
	},
	[4000618] = {
		RandomWeight = 30,
		Id = 4000618,
		SubstituteAction = 4000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			4000652,
			4000653
		}
	},
	[4000621] = {
		Id = 4000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[4000622] = {
		RandomWeight = 30,
		Id = 4000622,
		SubstituteAction = 4000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			4000625,
			4000624
		}
	},
	[4000623] = {
		Id = 4000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[4000624] = {
		RandomWeight = 30,
		Id = 4000624,
		SubstituteAction = 4000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			4000635,
			4000634
		}
	},
	[4000625] = {
		RandomWeight = 30,
		Id = 4000625,
		SubstituteAction = 4000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			4000661
		}
	},
	[4000626] = {
		RandomWeight = 30,
		Id = 4000626,
		SubstituteAction = 4000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			4000662
		}
	},
	[4000701] = {
		RandomWeight = 30,
		Id = 4000701,
		SubstituteAction = 4000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			4000603,
			4000604
		}
	},
	[4000702] = {
		RandomWeight = 10,
		Id = 4000702,
		SubstituteAction = 4000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			4000613,
			4000614
		}
	},
	[4000711] = {
		RandomWeight = 10,
		Id = 4000711,
		SubstituteAction = 4000513,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			4000621,
			4000622
		}
	},
	[4000712] = {
		RandomWeight = 10,
		Id = 4000712,
		SubstituteAction = 4000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			4000631,
			4000632
		}
	},
	[4000713] = {
		RandomWeight = 10,
		Id = 4000713,
		SubstituteAction = 4000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			4000625,
			4000624
		}
	},
	[4000714] = {
		RandomWeight = 10,
		Id = 4000714,
		SubstituteAction = 4000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			4000635,
			4000634
		}
	},
	[4000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 4000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			4000810,
			4000811,
			4000812
		}
	},
	[4000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 4000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			4000820,
			4000821,
			4000822
		}
	},
	[4005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 4005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[4005002] = {
		Id = 4005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			4000100,
			4000110,
			4000111,
			4000112,
			4000113,
			4000120
		}
	},
	[5000001] = {
		Id = 5000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[5000002] = {
		Id = 5000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[5000003] = {
		Id = 5000003,
		RandomWeight = 5000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[5000004] = {
		Id = 5000004,
		RandomWeight = 5000,
		ActionUnitIDList = {
			5000010
		}
	},
	[5000005] = {
		Id = 5000005,
		RandomWeight = 5000,
		ActionUnitIDList = {
			5000020
		}
	},
	[5000011] = {
		RandomWeight = 10,
		Id = 5000011,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000110,
			5000100,
			5000110,
			5000120
		}
	},
	[5000012] = {
		RandomWeight = 10,
		Id = 5000012,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000130
		}
	},
	[5000013] = {
		RandomWeight = 10,
		Id = 5000013,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000110,
			5000100,
			5000110,
			5000131,
			5000100
		}
	},
	[5000021] = {
		RandomWeight = 20,
		Id = 5000021,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000111,
			5000100,
			5000111,
			5000120
		}
	},
	[5000022] = {
		RandomWeight = 20,
		Id = 5000022,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000112,
			5000100,
			5000112,
			5000120
		}
	},
	[5000023] = {
		RandomWeight = 20,
		Id = 5000023,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000113,
			5000100,
			5000113,
			5000120
		}
	},
	[5000024] = {
		RandomWeight = 20,
		Id = 5000024,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000140
		}
	},
	[5000025] = {
		RandomWeight = 20,
		Id = 5000025,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000110,
			5000100,
			5000110,
			5000141,
			5000100
		}
	},
	[5000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 5000026,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			5000150
		}
	},
	[5000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 5000031,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101,
			813
		},
		ActionUnitIDList = {
			5000151
		}
	},
	[5000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 5000041,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101,
			803
		},
		ActionUnitIDList = {
			5000152
		}
	},
	[5000071] = {
		RandomWeight = 20,
		Id = 5000071,
		SubstituteAction = 5000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			5000170,
			5000171,
			5000172
		}
	},
	[5000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 5000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			5000200
		}
	},
	[5000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 5000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			5000201
		}
	},
	[5000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 5000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			5000200
		}
	},
	[5000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 5000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			5000201
		}
	},
	[5000121] = {
		Id = 5000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[5000122] = {
		Id = 5000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			104
		}
	},
	[5000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 5000201,
		SubstituteAction = 5000005,
		ActionUnitIDList = {
			5000300,
			5000310
		}
	},
	[5000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 5000202,
		SubstituteAction = 5000005,
		ActionUnitIDList = {
			5000300,
			5000311
		}
	},
	[5000211] = {
		Id = 5000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[5000212] = {
		RandomWeight = 10,
		Id = 5000212,
		SubstituteAction = 5000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			5000320
		}
	},
	[5000213] = {
		Id = 5000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[5000214] = {
		RandomWeight = 60,
		Id = 5000214,
		SubstituteAction = 5000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			5000321
		}
	},
	[5000221] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000221,
		SubstituteAction = 5000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			5000310
		}
	},
	[5000222] = {
		RandomWeight = 20,
		Id = 5000222,
		SubstituteAction = 5000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			5000311
		}
	},
	[5000231] = {
		isDailyAction = true,
		Id = 5000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			5000330
		}
	},
	[5000232] = {
		isDailyAction = true,
		Id = 5000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			5000331
		}
	},
	[5000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 5000301,
		SubstituteAction = 5000005,
		ActionUnitIDList = {
			5000400,
			5000410
		}
	},
	[5000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 5000302,
		SubstituteAction = 5000005,
		ActionUnitIDList = {
			5000400,
			5000411
		}
	},
	[5000311] = {
		Id = 5000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[5000312] = {
		RandomWeight = 10,
		Id = 5000312,
		SubstituteAction = 5000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			5000420
		}
	},
	[5000313] = {
		Id = 5000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[5000314] = {
		RandomWeight = 60,
		Id = 5000314,
		SubstituteAction = 5000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			5000421
		}
	},
	[5000321] = {
		RandomWeight = 10,
		Id = 5000321,
		SubstituteAction = 5000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			5000410
		}
	},
	[5000322] = {
		RandomWeight = 20,
		Id = 5000322,
		SubstituteAction = 5000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			5000411
		}
	},
	[5000331] = {
		isDailyAction = true,
		Id = 5000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			5000430
		}
	},
	[5000332] = {
		isDailyAction = true,
		Id = 5000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			5000431
		}
	},
	[5000401] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000401,
		SubstituteAction = 5000403,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000500,
			5000501,
			5000502,
			5000503,
			5000504
		}
	},
	[5000402] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000402,
		SubstituteAction = 5000404,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000510,
			5000511,
			5000512,
			5000513,
			5000514
		}
	},
	[5000403] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000403,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000505,
			5000506
		}
	},
	[5000404] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000404,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000515,
			5000516
		}
	},
	[5000411] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000411,
		SubstituteAction = 5000413,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000520,
			5000521,
			5000522
		}
	},
	[5000412] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000412,
		SubstituteAction = 5000414,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000530,
			5000531,
			5000532
		}
	},
	[5000413] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000413,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000521,
			5000522
		}
	},
	[5000414] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 5000414,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000531,
			5000532
		}
	},
	[5000501] = {
		Id = 5000501,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[5000502] = {
		RandomWeight = 10,
		Id = 5000502,
		SubstituteAction = 5000505,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000100,
			5000540
		}
	},
	[5000503] = {
		Id = 5000503,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[5000504] = {
		RandomWeight = 30,
		Id = 5000504,
		SubstituteAction = 5000505,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000100,
			5000542
		}
	},
	[5000505] = {
		Id = 5000505,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000541
		}
	},
	[5000506] = {
		Id = 5000506,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000543
		}
	},
	[5000507] = {
		RandomWeight = 10,
		Id = 5000507,
		SubstituteAction = 5000505,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000540
		}
	},
	[5000508] = {
		RandomWeight = 30,
		Id = 5000508,
		SubstituteAction = 5000505,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			5000542
		}
	},
	[5000511] = {
		Id = 5000511,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[5000512] = {
		RandomWeight = 30,
		Id = 5000512,
		SubstituteAction = 5000515,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000100,
			5000550
		}
	},
	[5000513] = {
		Id = 5000513,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[5000514] = {
		RandomWeight = 30,
		Id = 5000514,
		SubstituteAction = 5000516,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000100,
			5000551
		}
	},
	[5000515] = {
		Id = 5000515,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000550
		}
	},
	[5000516] = {
		Id = 5000516,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000551
		}
	},
	[5000517] = {
		RandomWeight = 30,
		Id = 5000517,
		SubstituteAction = 5000515,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000550
		}
	},
	[5000518] = {
		RandomWeight = 30,
		Id = 5000518,
		SubstituteAction = 5000516,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			5000551
		}
	},
	[5000601] = {
		RandomWeight = 30,
		Id = 5000601,
		SubstituteAction = 5000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			5000503,
			5000504
		}
	},
	[5000602] = {
		RandomWeight = 10,
		Id = 5000602,
		SubstituteAction = 5000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			5000513,
			5000514
		}
	},
	[5000611] = {
		RandomWeight = 10,
		Id = 5000611,
		SubstituteAction = 5000515,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			5000521,
			5000522
		}
	},
	[5000612] = {
		RandomWeight = 10,
		Id = 5000612,
		SubstituteAction = 5000516,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			5000531,
			5000532
		}
	},
	[5000701] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 5000701,
		SubstituteAction = 5000004,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			5000810,
			5000811,
			5000812,
			5000813
		}
	},
	[5000702] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 5000702,
		SubstituteAction = 5000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			5000820,
			5000821,
			5000822,
			5000823
		}
	},
	[5000703] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 5000703,
		SubstituteAction = 5000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			5000830,
			5000831,
			5000832,
			5000833
		}
	},
	[5005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 5005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[5005002] = {
		Id = 5005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			5000100,
			5000110,
			5000111,
			5000112,
			5000113,
			5000120
		}
	},
	[6000001] = {
		Id = 6000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[6000002] = {
		Id = 6000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[6000003] = {
		Id = 6000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[6000004] = {
		Id = 6000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			6000010
		}
	},
	[6000005] = {
		Id = 6000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			6000020
		}
	},
	[6000006] = {
		Id = 6000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000010
		}
	},
	[6000011] = {
		RandomWeight = 10,
		Id = 6000011,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000110,
			6000100,
			6000110,
			6000120
		}
	},
	[6000012] = {
		RandomWeight = 10,
		Id = 6000012,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000130
		}
	},
	[6000013] = {
		RandomWeight = 10,
		Id = 6000013,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000110,
			6000100,
			6000110,
			6000131,
			6000100
		}
	},
	[6000021] = {
		RandomWeight = 20,
		Id = 6000021,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000111,
			6000100,
			6000111,
			6000120
		}
	},
	[6000022] = {
		RandomWeight = 20,
		Id = 6000022,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000112,
			6000100,
			6000112,
			6000120
		}
	},
	[6000023] = {
		RandomWeight = 20,
		Id = 6000023,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000113,
			6000100,
			6000113,
			6000120
		}
	},
	[6000024] = {
		RandomWeight = 20,
		Id = 6000024,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000140
		}
	},
	[6000025] = {
		RandomWeight = 20,
		Id = 6000025,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			6000110,
			6000100,
			6000110,
			6000141,
			6000100
		}
	},
	[6000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 6000026,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			6000150
		}
	},
	[6000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 6000031,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101,
			808
		},
		ActionUnitIDList = {
			6000151
		}
	},
	[6000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 6000041,
		SubstituteAction = 6000004,
		ConditionIDList = {
			101,
			808
		},
		ActionUnitIDList = {
			6000152
		}
	},
	[6000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 6000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			6000210
		}
	},
	[6000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 6000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			6000211
		}
	},
	[6000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 6000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			6000210
		}
	},
	[6000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 6000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			6000211
		}
	},
	[6000121] = {
		Id = 6000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[6000122] = {
		Id = 6000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			111
		}
	},
	[6000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 6000201,
		SubstituteAction = 6000005,
		ActionUnitIDList = {
			6000300,
			6000310
		}
	},
	[6000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 6000202,
		SubstituteAction = 6000005,
		ActionUnitIDList = {
			6000300,
			6000311
		}
	},
	[6000211] = {
		Id = 6000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[6000212] = {
		RandomWeight = 10,
		Id = 6000212,
		SubstituteAction = 6000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			6000320
		}
	},
	[6000213] = {
		Id = 6000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[6000214] = {
		RandomWeight = 60,
		Id = 6000214,
		SubstituteAction = 6000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			6000321
		}
	},
	[6000221] = {
		RandomWeight = 10,
		Id = 6000221,
		SubstituteAction = 6000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			6000310
		}
	},
	[6000222] = {
		RandomWeight = 20,
		Id = 6000222,
		SubstituteAction = 6000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			6000311
		}
	},
	[6000231] = {
		isDailyAction = true,
		Id = 6000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000330
		}
	},
	[6000232] = {
		isDailyAction = true,
		Id = 6000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000331
		}
	},
	[6000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 6000301,
		SubstituteAction = 6000005,
		ActionUnitIDList = {
			6000400,
			6000410
		}
	},
	[6000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 6000302,
		SubstituteAction = 6000005,
		ActionUnitIDList = {
			6000400,
			6000411
		}
	},
	[6000311] = {
		Id = 6000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[6000312] = {
		RandomWeight = 10,
		Id = 6000312,
		SubstituteAction = 6000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			6000420
		}
	},
	[6000313] = {
		Id = 6000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[6000314] = {
		RandomWeight = 60,
		Id = 6000314,
		SubstituteAction = 6000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			6000421
		}
	},
	[6000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000321,
		SubstituteAction = 6000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			6000410
		}
	},
	[6000322] = {
		RandomWeight = 20,
		Id = 6000322,
		SubstituteAction = 6000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			6000411
		}
	},
	[6000331] = {
		isDailyAction = true,
		Id = 6000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000430
		}
	},
	[6000332] = {
		isDailyAction = true,
		Id = 6000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000431
		}
	},
	[6000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 6000401,
		SubstituteAction = 6000005,
		ActionUnitIDList = {
			6000500,
			6000510
		}
	},
	[6000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 6000402,
		SubstituteAction = 6000005,
		ActionUnitIDList = {
			6000500,
			6000511
		}
	},
	[6000411] = {
		Id = 6000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[6000412] = {
		RandomWeight = 10,
		Id = 6000412,
		SubstituteAction = 6000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			6000520
		}
	},
	[6000413] = {
		Id = 6000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[6000414] = {
		RandomWeight = 60,
		Id = 6000414,
		SubstituteAction = 6000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			6000521
		}
	},
	[6000421] = {
		RandomWeight = 10,
		Id = 6000421,
		SubstituteAction = 6000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			6000510
		}
	},
	[6000422] = {
		RandomWeight = 20,
		Id = 6000422,
		SubstituteAction = 6000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			6000511
		}
	},
	[6000431] = {
		isDailyAction = true,
		Id = 6000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000530
		}
	},
	[6000432] = {
		isDailyAction = true,
		Id = 6000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			6000531
		}
	},
	[6000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000501,
		SubstituteAction = 6000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000600,
			6000601,
			6000602,
			6000603,
			6000604
		}
	},
	[6000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000502,
		SubstituteAction = 6000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000610,
			6000611,
			6000612,
			6000613,
			6000614
		}
	},
	[6000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000605,
			6000606
		}
	},
	[6000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000615,
			6000616
		}
	},
	[6000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000511,
		SubstituteAction = 6000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000620,
			6000621,
			6000622
		}
	},
	[6000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000512,
		SubstituteAction = 6000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000630,
			6000631,
			6000632
		}
	},
	[6000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000623,
			6000624
		}
	},
	[6000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000633,
			6000634
		}
	},
	[6000601] = {
		Id = 6000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[6000602] = {
		RandomWeight = 10,
		Id = 6000602,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000100,
			6000640
		}
	},
	[6000603] = {
		Id = 6000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[6000604] = {
		RandomWeight = 30,
		Id = 6000604,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000100,
			6000642
		}
	},
	[6000605] = {
		Id = 6000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000641
		}
	},
	[6000606] = {
		Id = 6000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000643
		}
	},
	[6000607] = {
		RandomWeight = 10,
		Id = 6000607,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000640
		}
	},
	[6000608] = {
		RandomWeight = 30,
		Id = 6000608,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000642
		}
	},
	[6000611] = {
		Id = 6000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			111
		}
	},
	[6000612] = {
		RandomWeight = 30,
		Id = 6000612,
		SubstituteAction = 6000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000100,
			6000650,
			6000651
		}
	},
	[6000613] = {
		Id = 6000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			111
		}
	},
	[6000614] = {
		RandomWeight = 30,
		Id = 6000614,
		SubstituteAction = 6000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000100,
			6000652,
			6000653
		}
	},
	[6000615] = {
		Id = 6000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000651
		}
	},
	[6000616] = {
		Id = 6000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000653
		}
	},
	[6000617] = {
		RandomWeight = 30,
		Id = 6000617,
		SubstituteAction = 6000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000650,
			6000651
		}
	},
	[6000618] = {
		RandomWeight = 30,
		Id = 6000618,
		SubstituteAction = 6000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000652,
			6000653
		}
	},
	[6000701] = {
		RandomWeight = 30,
		Id = 6000701,
		SubstituteAction = 6000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			6000603,
			6000604
		}
	},
	[6000702] = {
		RandomWeight = 10,
		Id = 6000702,
		SubstituteAction = 6000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			6000613,
			6000614
		}
	},
	[6000711] = {
		RandomWeight = 10,
		Id = 6000711,
		SubstituteAction = 6000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			6000621,
			6000622
		}
	},
	[6000712] = {
		RandomWeight = 10,
		Id = 6000712,
		SubstituteAction = 6000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			6000631,
			6000632
		}
	},
	[6000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 6000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			6000811,
			6000812,
			6000813
		}
	},
	[6000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 6000802,
		ConditionIDList = {
			902
		},
		ActionUnitIDList = {
			6000820,
			6000821,
			6000822,
			6000823
		}
	},
	[6000803] = {
		isDailyAction = true,
		Id = 6000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			6000830,
			6000831,
			6000832,
			6000833
		}
	},
	[6000901] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000901,
		SubstituteAction = 6000503,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			6000700,
			6000701,
			6000702,
			6000703,
			6000704
		}
	},
	[6000902] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000902,
		SubstituteAction = 6000504,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			6000710,
			6000711,
			6000712,
			6000713,
			6000714
		}
	},
	[6000903] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000903,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000705,
			6000706
		}
	},
	[6000904] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000904,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000715,
			6000716
		}
	},
	[6000911] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000911,
		SubstituteAction = 6000513,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			6000720,
			6000721,
			6000722
		}
	},
	[6000912] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000912,
		SubstituteAction = 6000514,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			6000730,
			6000731,
			6000732
		}
	},
	[6000913] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000913,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000723,
			6000724
		}
	},
	[6000914] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 6000914,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000733,
			6000734
		}
	},
	[6001001] = {
		Id = 6001001,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[6001002] = {
		RandomWeight = 10,
		Id = 6001002,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000100,
			6000740
		}
	},
	[6001003] = {
		Id = 6001003,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[6001004] = {
		RandomWeight = 30,
		Id = 6001004,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000100,
			6000742
		}
	},
	[6001005] = {
		Id = 6001005,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000741
		}
	},
	[6001006] = {
		Id = 6001006,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000743
		}
	},
	[6001007] = {
		RandomWeight = 10,
		Id = 6001007,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000740
		}
	},
	[6001008] = {
		RandomWeight = 30,
		Id = 6001008,
		SubstituteAction = 6000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			6000742
		}
	},
	[6001011] = {
		Id = 6001011,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			111
		}
	},
	[6001012] = {
		RandomWeight = 30,
		Id = 6001012,
		SubstituteAction = 6000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000100,
			6000750,
			6000751
		}
	},
	[6001013] = {
		Id = 6001013,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			111
		}
	},
	[6001014] = {
		RandomWeight = 30,
		Id = 6001014,
		SubstituteAction = 6000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000100,
			6000752,
			6000753
		}
	},
	[6001015] = {
		Id = 6001015,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000751
		}
	},
	[6001016] = {
		Id = 6001016,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000753
		}
	},
	[6001017] = {
		RandomWeight = 30,
		Id = 6001017,
		SubstituteAction = 6000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000750,
			6000751
		}
	},
	[6001018] = {
		RandomWeight = 30,
		Id = 6001018,
		SubstituteAction = 6000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			6000752,
			6000753
		}
	},
	[6001101] = {
		RandomWeight = 30,
		Id = 6001101,
		SubstituteAction = 6000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			6000703,
			6000704
		}
	},
	[6001102] = {
		RandomWeight = 10,
		Id = 6001102,
		SubstituteAction = 6000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			6000713,
			6000714
		}
	},
	[6001111] = {
		RandomWeight = 10,
		Id = 6001111,
		SubstituteAction = 6000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			6000721,
			6000722
		}
	},
	[6001112] = {
		RandomWeight = 10,
		Id = 6001112,
		SubstituteAction = 6000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			6000731,
			6000732
		}
	},
	[6005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 6005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[6005002] = {
		Id = 6005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			6000100,
			6000110,
			6000111,
			6000112,
			6000113,
			6000120
		}
	},
	[7000001] = {
		Id = 7000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[7000002] = {
		Id = 7000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[7000003] = {
		Id = 7000003,
		RandomWeight = 7000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[7000004] = {
		Id = 7000004,
		RandomWeight = 7000,
		ActionUnitIDList = {
			7000010
		}
	},
	[7000005] = {
		Id = 7000005,
		RandomWeight = 7000,
		ActionUnitIDList = {
			7000020
		}
	},
	[7000011] = {
		RandomWeight = 10,
		Id = 7000011,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000110,
			7000100,
			7000110,
			7000120
		}
	},
	[7000012] = {
		RandomWeight = 10,
		Id = 7000012,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000130
		}
	},
	[7000013] = {
		RandomWeight = 10,
		Id = 7000013,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000110,
			7000100,
			7000110,
			7000131,
			7000100
		}
	},
	[7000021] = {
		RandomWeight = 20,
		Id = 7000021,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000111,
			7000100,
			7000111,
			7000120
		}
	},
	[7000022] = {
		RandomWeight = 20,
		Id = 7000022,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000112,
			7000100,
			7000112,
			7000120
		}
	},
	[7000023] = {
		RandomWeight = 20,
		Id = 7000023,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000113,
			7000100,
			7000113,
			7000120
		}
	},
	[7000024] = {
		RandomWeight = 20,
		Id = 7000024,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000140
		}
	},
	[7000025] = {
		RandomWeight = 20,
		Id = 7000025,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			7000110,
			7000100,
			7000110,
			7000141,
			7000100
		}
	},
	[7000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 7000026,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			7000150
		}
	},
	[7000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 7000031,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101,
			808
		},
		ActionUnitIDList = {
			7000151
		}
	},
	[7000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 7000041,
		SubstituteAction = 7000004,
		ConditionIDList = {
			101,
			813
		},
		ActionUnitIDList = {
			7000152
		}
	},
	[7000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 7000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			7000200
		}
	},
	[7000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 7000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			7000201
		}
	},
	[7000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 7000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			7000200
		}
	},
	[7000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 7000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			7000201
		}
	},
	[7000121] = {
		Id = 7000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[7000122] = {
		Id = 7000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[7000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 7000201,
		SubstituteAction = 7000005,
		ActionUnitIDList = {
			7000300,
			7000310
		}
	},
	[7000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 7000202,
		SubstituteAction = 7000005,
		ActionUnitIDList = {
			7000300,
			7000311
		}
	},
	[7000211] = {
		Id = 7000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[7000212] = {
		RandomWeight = 10,
		Id = 7000212,
		SubstituteAction = 7000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			7000320
		}
	},
	[7000213] = {
		Id = 7000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[7000214] = {
		RandomWeight = 60,
		Id = 7000214,
		SubstituteAction = 7000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			7000321
		}
	},
	[7000221] = {
		RandomWeight = 10,
		Id = 7000221,
		SubstituteAction = 7000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			7000310
		}
	},
	[7000222] = {
		RandomWeight = 20,
		Id = 7000222,
		SubstituteAction = 7000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			7000311
		}
	},
	[7000231] = {
		isDailyAction = true,
		Id = 7000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			7000330
		}
	},
	[7000232] = {
		isDailyAction = true,
		Id = 7000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			7000331
		}
	},
	[7000301] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000301,
		SubstituteAction = 7000303,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000400,
			7000401,
			7000402,
			7000403,
			7000404
		}
	},
	[7000302] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000302,
		SubstituteAction = 7000304,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000410,
			7000411,
			7000412,
			7000413,
			7000414
		}
	},
	[7000303] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000303,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000405,
			7000406
		}
	},
	[7000304] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000304,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000415,
			7000416
		}
	},
	[7000311] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000311,
		SubstituteAction = 7000313,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000420,
			7000421,
			7000422
		}
	},
	[7000312] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000312,
		SubstituteAction = 7000314,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000430,
			7000431,
			7000432
		}
	},
	[7000313] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000313,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000423,
			7000424
		}
	},
	[7000314] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 7000314,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000433,
			7000434
		}
	},
	[7000401] = {
		Id = 7000401,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[7000402] = {
		RandomWeight = 10,
		Id = 7000402,
		SubstituteAction = 7000405,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000100,
			7000440
		}
	},
	[7000403] = {
		Id = 7000403,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[7000404] = {
		RandomWeight = 30,
		Id = 7000404,
		SubstituteAction = 7000405,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000100,
			7000442
		}
	},
	[7000405] = {
		Id = 7000405,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000441
		}
	},
	[7000406] = {
		Id = 7000406,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000443
		}
	},
	[7000407] = {
		RandomWeight = 10,
		Id = 7000407,
		SubstituteAction = 7000405,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000440
		}
	},
	[7000408] = {
		RandomWeight = 30,
		Id = 7000408,
		SubstituteAction = 7000405,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			7000442
		}
	},
	[7000411] = {
		Id = 7000411,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[7000412] = {
		RandomWeight = 30,
		Id = 7000412,
		SubstituteAction = 7000415,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000100,
			7000450,
			7000451
		}
	},
	[7000413] = {
		Id = 7000413,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[7000414] = {
		RandomWeight = 30,
		Id = 7000414,
		SubstituteAction = 7000416,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000100,
			7000452,
			7000453
		}
	},
	[7000415] = {
		Id = 7000415,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000451
		}
	},
	[7000416] = {
		Id = 7000416,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000453
		}
	},
	[7000417] = {
		RandomWeight = 30,
		Id = 7000417,
		SubstituteAction = 7000415,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000450,
			7000451
		}
	},
	[7000418] = {
		RandomWeight = 30,
		Id = 7000418,
		SubstituteAction = 7000416,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			7000452,
			7000453
		}
	},
	[7000501] = {
		RandomWeight = 30,
		Id = 7000501,
		SubstituteAction = 7000303,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			7000403,
			7000404
		}
	},
	[7000502] = {
		RandomWeight = 10,
		Id = 7000502,
		SubstituteAction = 7000304,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			7000413,
			7000414
		}
	},
	[7000511] = {
		RandomWeight = 10,
		Id = 7000511,
		SubstituteAction = 7000313,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			7000421,
			7000422
		}
	},
	[7000512] = {
		RandomWeight = 10,
		Id = 7000512,
		SubstituteAction = 7000314,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			7000431,
			7000432
		}
	},
	[7000601] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 7000601,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			7000810,
			7000811,
			7000812,
			7000813
		}
	},
	[7000602] = {
		isDailyAction = true,
		Id = 7000602,
		RandomWeight = 50,
		ActionUnitIDList = {
			7000820,
			7000821,
			7000822,
			7000823
		}
	},
	[7005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 7005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[7005002] = {
		Id = 7005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			7000100,
			7000110,
			7000111,
			7000112,
			7000113,
			7000120
		}
	},
	[8000001] = {
		Id = 8000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[8000002] = {
		Id = 8000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[8000003] = {
		Id = 8000003,
		RandomWeight = 8000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[8000004] = {
		Id = 8000004,
		RandomWeight = 8000,
		ActionUnitIDList = {
			8000010
		}
	},
	[8000005] = {
		Id = 8000005,
		RandomWeight = 8000,
		ActionUnitIDList = {
			8000020
		}
	},
	[8000011] = {
		RandomWeight = 10,
		Id = 8000011,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000110,
			8000100,
			8000110,
			8000120
		}
	},
	[8000012] = {
		RandomWeight = 10,
		Id = 8000012,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000130
		}
	},
	[8000013] = {
		RandomWeight = 10,
		Id = 8000013,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000110,
			8000100,
			8000110,
			8000131,
			8000100
		}
	},
	[8000021] = {
		RandomWeight = 20,
		Id = 8000021,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000111,
			8000100,
			8000111,
			8000120
		}
	},
	[8000022] = {
		RandomWeight = 20,
		Id = 8000022,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000112,
			8000100,
			8000112,
			8000120
		}
	},
	[8000023] = {
		RandomWeight = 20,
		Id = 8000023,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000113,
			8000100,
			8000113,
			8000120
		}
	},
	[8000024] = {
		RandomWeight = 20,
		Id = 8000024,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000140
		}
	},
	[8000025] = {
		RandomWeight = 20,
		Id = 8000025,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			8000110,
			8000100,
			8000110,
			8000141,
			8000100
		}
	},
	[8000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 8000026,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			8000150
		}
	},
	[8000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 8000031,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101,
			807
		},
		ActionUnitIDList = {
			8000151
		}
	},
	[8000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 8000041,
		SubstituteAction = 8000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			8000152
		}
	},
	[8000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 8000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			8000200
		}
	},
	[8000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 8000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			8000201
		}
	},
	[8000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 8000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			8000200
		}
	},
	[8000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 8000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			8000201
		}
	},
	[8000121] = {
		Id = 8000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[8000122] = {
		Id = 8000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			110
		}
	},
	[8000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 8000201,
		SubstituteAction = 8000005,
		ActionUnitIDList = {
			8000300,
			8000310
		}
	},
	[8000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 8000202,
		SubstituteAction = 8000005,
		ActionUnitIDList = {
			8000300,
			8000311
		}
	},
	[8000211] = {
		Id = 8000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[8000212] = {
		RandomWeight = 10,
		Id = 8000212,
		SubstituteAction = 8000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			8000320
		}
	},
	[8000213] = {
		Id = 8000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[8000214] = {
		RandomWeight = 60,
		Id = 8000214,
		SubstituteAction = 8000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			8000321
		}
	},
	[8000221] = {
		RandomWeight = 10,
		Id = 8000221,
		SubstituteAction = 8000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			8000310
		}
	},
	[8000222] = {
		RandomWeight = 20,
		Id = 8000222,
		SubstituteAction = 8000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			8000311
		}
	},
	[8000231] = {
		isDailyAction = true,
		Id = 8000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000330
		}
	},
	[8000232] = {
		isDailyAction = true,
		Id = 8000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000331
		}
	},
	[8000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 8000301,
		SubstituteAction = 8000005,
		ActionUnitIDList = {
			8000400,
			8000410
		}
	},
	[8000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 8000302,
		SubstituteAction = 8000005,
		ActionUnitIDList = {
			8000400,
			8000411
		}
	},
	[8000311] = {
		Id = 8000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[8000312] = {
		RandomWeight = 10,
		Id = 8000312,
		SubstituteAction = 8000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			8000420
		}
	},
	[8000313] = {
		Id = 8000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[8000314] = {
		RandomWeight = 60,
		Id = 8000314,
		SubstituteAction = 8000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			8000421
		}
	},
	[8000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000321,
		SubstituteAction = 8000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			8000410
		}
	},
	[8000322] = {
		RandomWeight = 20,
		Id = 8000322,
		SubstituteAction = 8000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			8000411
		}
	},
	[8000331] = {
		isDailyAction = true,
		Id = 8000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000430
		}
	},
	[8000332] = {
		isDailyAction = true,
		Id = 8000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000431
		}
	},
	[8000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 8000401,
		SubstituteAction = 8000005,
		ActionUnitIDList = {
			8000500,
			8000510
		}
	},
	[8000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 8000402,
		SubstituteAction = 8000005,
		ActionUnitIDList = {
			8000500,
			8000511
		}
	},
	[8000411] = {
		Id = 8000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[8000412] = {
		RandomWeight = 10,
		Id = 8000412,
		SubstituteAction = 8000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			8000520
		}
	},
	[8000413] = {
		Id = 8000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[8000414] = {
		RandomWeight = 60,
		Id = 8000414,
		SubstituteAction = 8000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			8000521
		}
	},
	[8000421] = {
		RandomWeight = 10,
		Id = 8000421,
		SubstituteAction = 8000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			8000510
		}
	},
	[8000422] = {
		RandomWeight = 20,
		Id = 8000422,
		SubstituteAction = 8000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			8000511
		}
	},
	[8000431] = {
		isDailyAction = true,
		Id = 8000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000530
		}
	},
	[8000432] = {
		isDailyAction = true,
		Id = 8000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000531
		}
	},
	[8000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000501,
		SubstituteAction = 8000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000600,
			8000601,
			8000602,
			8000603,
			8000604
		}
	},
	[8000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000502,
		SubstituteAction = 8000505,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000610,
			8000611,
			8000612,
			8000613,
			8000614
		}
	},
	[8000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000503,
		SubstituteAction = 8000506,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000620,
			8000621,
			8000622,
			8000623,
			8000624
		}
	},
	[8000504] = {
		Id = 8000504,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000605,
			8000606
		}
	},
	[8000505] = {
		Id = 8000505,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000615,
			8000616
		}
	},
	[8000506] = {
		Id = 8000506,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000625,
			8000626
		}
	},
	[8000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000511,
		SubstituteAction = 8000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000630,
			8000631,
			8000632
		}
	},
	[8000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000512,
		SubstituteAction = 8000515,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000640,
			8000641,
			8000642
		}
	},
	[8000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000513,
		SubstituteAction = 8000516,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000650,
			8000651,
			8000652
		}
	},
	[8000514] = {
		Id = 8000514,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000633,
			8000634
		}
	},
	[8000515] = {
		Id = 8000515,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000643,
			8000644
		}
	},
	[8000516] = {
		Id = 8000516,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000653,
			8000654
		}
	},
	[8000601] = {
		Id = 8000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[8000602] = {
		RandomWeight = 10,
		Id = 8000602,
		SubstituteAction = 8000607,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000100,
			8000660
		}
	},
	[8000603] = {
		Id = 8000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[8000604] = {
		RandomWeight = 30,
		Id = 8000604,
		SubstituteAction = 8000608,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000100,
			8000662
		}
	},
	[8000605] = {
		Id = 8000605,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[8000606] = {
		RandomWeight = 30,
		Id = 8000606,
		SubstituteAction = 8000609,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000100,
			8000664
		}
	},
	[8000607] = {
		Id = 8000607,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000661
		}
	},
	[8000608] = {
		Id = 8000608,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000663
		}
	},
	[8000609] = {
		Id = 8000609,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000665
		}
	},
	[8000610] = {
		RandomWeight = 10,
		Id = 8000610,
		SubstituteAction = 8000607,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000660
		}
	},
	[8000611] = {
		RandomWeight = 30,
		Id = 8000611,
		SubstituteAction = 8000608,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000662
		}
	},
	[8000612] = {
		RandomWeight = 30,
		Id = 8000612,
		SubstituteAction = 8000609,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000664
		}
	},
	[8000621] = {
		Id = 8000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			110
		}
	},
	[8000622] = {
		RandomWeight = 30,
		Id = 8000622,
		SubstituteAction = 8000627,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000100,
			8000670
		}
	},
	[8000623] = {
		Id = 8000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			110
		}
	},
	[8000624] = {
		RandomWeight = 30,
		Id = 8000624,
		SubstituteAction = 8000628,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000100,
			8000672
		}
	},
	[8000625] = {
		Id = 8000625,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			110
		}
	},
	[8000626] = {
		RandomWeight = 30,
		Id = 8000626,
		SubstituteAction = 8000629,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000100,
			8000674
		}
	},
	[8000627] = {
		Id = 8000627,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000671
		}
	},
	[8000628] = {
		Id = 8000628,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000673
		}
	},
	[8000629] = {
		Id = 8000629,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000675
		}
	},
	[8000630] = {
		RandomWeight = 30,
		Id = 8000630,
		SubstituteAction = 8000627,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000670
		}
	},
	[8000631] = {
		RandomWeight = 30,
		Id = 8000631,
		SubstituteAction = 8000628,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000672
		}
	},
	[8000632] = {
		RandomWeight = 30,
		Id = 8000632,
		SubstituteAction = 8000629,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000674
		}
	},
	[8000701] = {
		RandomWeight = 30,
		Id = 8000701,
		SubstituteAction = 8000607,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			8000604
		}
	},
	[8000702] = {
		RandomWeight = 10,
		Id = 8000702,
		SubstituteAction = 8000608,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			8000613,
			8000614
		}
	},
	[8000703] = {
		RandomWeight = 10,
		Id = 8000703,
		SubstituteAction = 8000609,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			8000623,
			8000624
		}
	},
	[8000711] = {
		RandomWeight = 10,
		Id = 8000711,
		SubstituteAction = 8000627,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			8000631,
			8000632
		}
	},
	[8000712] = {
		RandomWeight = 10,
		Id = 8000712,
		SubstituteAction = 8000628,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			8000641,
			8000642
		}
	},
	[8000713] = {
		RandomWeight = 10,
		Id = 8000713,
		SubstituteAction = 8000629,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			8000651,
			8000652
		}
	},
	[8000801] = {
		Id = 8000801,
		SubstituteAction = 8000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000701
		}
	},
	[8000811] = {
		Id = 8000811,
		SubstituteAction = 8000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000710
		}
	},
	[8000821] = {
		Id = 8000821,
		SubstituteAction = 8000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000720
		}
	},
	[8000822] = {
		Id = 8000822,
		SubstituteAction = 8000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			8000720,
			8000721
		}
	},
	[8000823] = {
		RandomWeight = 10,
		isDailyAction = true,
		Id = 8000823,
		SubstituteAction = 8000004,
		ActionUnitIDList = {
			8000720,
			8000722
		}
	},
	[8000903] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000903,
		SubstituteAction = 8000906,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000810,
			8000811,
			8000812,
			8000813,
			8000814
		}
	},
	[8000906] = {
		Id = 8000906,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000815,
			8000816
		}
	},
	[8000913] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 8000913,
		SubstituteAction = 8000916,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000820,
			8000821,
			8000822
		}
	},
	[8000916] = {
		Id = 8000916,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000823,
			8000824
		}
	},
	[8001005] = {
		Id = 8001005,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[8001006] = {
		RandomWeight = 30,
		Id = 8001006,
		SubstituteAction = 8001009,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000100,
			8000830
		}
	},
	[8001007] = {
		RandomWeight = 30,
		Id = 8001007,
		SubstituteAction = 8001009,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000830
		}
	},
	[8001009] = {
		Id = 8001009,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			8000831
		}
	},
	[8001015] = {
		Id = 8001015,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			110
		}
	},
	[8001016] = {
		RandomWeight = 30,
		Id = 8001016,
		SubstituteAction = 8001019,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000100,
			8000840
		}
	},
	[8001017] = {
		RandomWeight = 30,
		Id = 8001017,
		SubstituteAction = 8001019,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000840
		}
	},
	[8001019] = {
		Id = 8001019,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			8000841
		}
	},
	[8001103] = {
		RandomWeight = 10,
		Id = 8001103,
		SubstituteAction = 8001009,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			8000813,
			8000814
		}
	},
	[8001113] = {
		RandomWeight = 10,
		Id = 8001113,
		SubstituteAction = 8001019,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			8000821,
			8000822
		}
	},
	[8002001] = {
		isDailyAction = true,
		Id = 8002001,
		RandomWeight = 50,
		ActionUnitIDList = {
			8001010,
			8001011,
			8001012,
			8001013
		}
	},
	[8002003] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 8002003,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			8001030,
			8001031,
			8001032,
			8001033
		}
	},
	[8005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 8005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[8005002] = {
		Id = 8005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			8000100,
			8000110,
			8000111,
			8000112,
			8000113,
			8000120
		}
	},
	[9000001] = {
		Id = 9000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[9000002] = {
		Id = 9000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[9000003] = {
		Id = 9000003,
		RandomWeight = 9000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[9000004] = {
		Id = 9000004,
		RandomWeight = 9000,
		ActionUnitIDList = {
			9000010
		}
	},
	[9000005] = {
		Id = 9000005,
		RandomWeight = 9000,
		ActionUnitIDList = {
			9000020
		}
	},
	[9000011] = {
		RandomWeight = 10,
		Id = 9000011,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000110,
			9000100,
			9000110,
			9000120
		}
	},
	[9000012] = {
		RandomWeight = 10,
		Id = 9000012,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000130
		}
	},
	[9000013] = {
		RandomWeight = 10,
		Id = 9000013,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000110,
			9000100,
			9000110,
			9000131,
			9000100
		}
	},
	[9000021] = {
		RandomWeight = 20,
		Id = 9000021,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000111,
			9000100,
			9000111,
			9000120
		}
	},
	[9000022] = {
		RandomWeight = 20,
		Id = 9000022,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000112,
			9000100,
			9000112,
			9000120
		}
	},
	[9000023] = {
		RandomWeight = 20,
		Id = 9000023,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000113,
			9000100,
			9000113,
			9000120
		}
	},
	[9000024] = {
		RandomWeight = 20,
		Id = 9000024,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000140
		}
	},
	[9000025] = {
		RandomWeight = 20,
		Id = 9000025,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			9000110,
			9000100,
			9000110,
			9000141,
			9000100
		}
	},
	[9000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 9000026,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			9000150
		}
	},
	[9000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 9000031,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101,
			815
		},
		ActionUnitIDList = {
			9000151
		}
	},
	[9000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 9000041,
		SubstituteAction = 9000004,
		ConditionIDList = {
			101,
			802
		},
		ActionUnitIDList = {
			9000152
		}
	},
	[9000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 9000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			9000200
		}
	},
	[9000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 9000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			9000201
		}
	},
	[9000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 9000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			9000200
		}
	},
	[9000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 9000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			9000201
		}
	},
	[9000121] = {
		Id = 9000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[9000122] = {
		Id = 9000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			107
		}
	},
	[9000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 9000201,
		SubstituteAction = 9000005,
		ActionUnitIDList = {
			9000300,
			9000310
		}
	},
	[9000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 9000202,
		SubstituteAction = 9000005,
		ActionUnitIDList = {
			9000300,
			9000311
		}
	},
	[9000211] = {
		Id = 9000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[9000212] = {
		RandomWeight = 10,
		Id = 9000212,
		SubstituteAction = 9000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			9000320
		}
	},
	[9000213] = {
		Id = 9000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[9000214] = {
		RandomWeight = 60,
		Id = 9000214,
		SubstituteAction = 9000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			9000321
		}
	},
	[9000221] = {
		RandomWeight = 10,
		Id = 9000221,
		SubstituteAction = 9000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			9000310
		}
	},
	[9000222] = {
		RandomWeight = 20,
		Id = 9000222,
		SubstituteAction = 9000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			9000311
		}
	},
	[9000231] = {
		isDailyAction = true,
		Id = 9000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			9000330
		}
	},
	[9000232] = {
		isDailyAction = true,
		Id = 9000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			9000331
		}
	},
	[9000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 9000301,
		SubstituteAction = 9000005,
		ActionUnitIDList = {
			9000400,
			9000410
		}
	},
	[9000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 9000302,
		SubstituteAction = 9000005,
		ActionUnitIDList = {
			9000400,
			9000411
		}
	},
	[9000311] = {
		Id = 9000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[9000312] = {
		RandomWeight = 10,
		Id = 9000312,
		SubstituteAction = 9000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			9000420
		}
	},
	[9000313] = {
		Id = 9000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[9000314] = {
		RandomWeight = 60,
		Id = 9000314,
		SubstituteAction = 9000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			9000421
		}
	},
	[9000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000321,
		SubstituteAction = 9000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			9000410
		}
	},
	[9000322] = {
		RandomWeight = 20,
		Id = 9000322,
		SubstituteAction = 9000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			9000411
		}
	},
	[9000331] = {
		isDailyAction = true,
		Id = 9000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			9000430
		}
	},
	[9000332] = {
		isDailyAction = true,
		Id = 9000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			9000431
		}
	},
	[9000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 9000401,
		SubstituteAction = 9000005,
		ActionUnitIDList = {
			9000500,
			9000510
		}
	},
	[9000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 9000402,
		SubstituteAction = 9000005,
		ActionUnitIDList = {
			9000500,
			9000511
		}
	},
	[9000411] = {
		Id = 9000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[9000412] = {
		RandomWeight = 10,
		Id = 9000412,
		SubstituteAction = 9000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			9000520
		}
	},
	[9000413] = {
		Id = 9000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[9000414] = {
		RandomWeight = 60,
		Id = 9000414,
		SubstituteAction = 9000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			9000521
		}
	},
	[9000421] = {
		RandomWeight = 10,
		Id = 9000421,
		SubstituteAction = 9000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			9000510
		}
	},
	[9000422] = {
		RandomWeight = 20,
		Id = 9000422,
		SubstituteAction = 9000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			9000511
		}
	},
	[9000431] = {
		isDailyAction = true,
		Id = 9000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			9000530
		}
	},
	[9000432] = {
		isDailyAction = true,
		Id = 9000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			9000531
		}
	},
	[9000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000501,
		SubstituteAction = 9000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000600,
			9000601,
			9000602,
			9000603,
			9000604
		}
	},
	[9000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000502,
		SubstituteAction = 9000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000610,
			9000611,
			9000612,
			9000613,
			9000614
		}
	},
	[9000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000605,
			9000606
		}
	},
	[9000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000615,
			9000616
		}
	},
	[9000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000511,
		SubstituteAction = 9000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000620,
			9000621,
			9000622
		}
	},
	[9000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000512,
		SubstituteAction = 9000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000630,
			9000631,
			9000632
		}
	},
	[9000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000623,
			9000624
		}
	},
	[9000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 9000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000633,
			9000634
		}
	},
	[9000601] = {
		Id = 9000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[9000602] = {
		RandomWeight = 10,
		Id = 9000602,
		SubstituteAction = 9000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000100,
			9000640
		}
	},
	[9000603] = {
		Id = 9000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[9000604] = {
		RandomWeight = 30,
		Id = 9000604,
		SubstituteAction = 9000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000100,
			9000642
		}
	},
	[9000605] = {
		Id = 9000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000641
		}
	},
	[9000606] = {
		Id = 9000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000643
		}
	},
	[9000607] = {
		RandomWeight = 10,
		Id = 9000607,
		SubstituteAction = 9000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000640
		}
	},
	[9000608] = {
		RandomWeight = 30,
		Id = 9000608,
		SubstituteAction = 9000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			9000642
		}
	},
	[9000611] = {
		Id = 9000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[9000612] = {
		RandomWeight = 30,
		Id = 9000612,
		SubstituteAction = 9000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000100,
			9000650,
			9000651
		}
	},
	[9000613] = {
		Id = 9000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[9000614] = {
		RandomWeight = 30,
		Id = 9000614,
		SubstituteAction = 9000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000100,
			9000652,
			9000653
		}
	},
	[9000615] = {
		Id = 9000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000651
		}
	},
	[9000616] = {
		Id = 9000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000653
		}
	},
	[9000617] = {
		RandomWeight = 30,
		Id = 9000617,
		SubstituteAction = 9000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000650,
			9000651
		}
	},
	[9000618] = {
		RandomWeight = 30,
		Id = 9000618,
		SubstituteAction = 9000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			9000652,
			9000653
		}
	},
	[9000701] = {
		RandomWeight = 30,
		Id = 9000701,
		SubstituteAction = 9000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			9000603,
			9000604
		}
	},
	[9000702] = {
		RandomWeight = 10,
		Id = 9000702,
		SubstituteAction = 9000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			9000613,
			9000614
		}
	},
	[9000711] = {
		RandomWeight = 10,
		Id = 9000711,
		SubstituteAction = 9000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			9000621,
			9000622
		}
	},
	[9000712] = {
		RandomWeight = 10,
		Id = 9000712,
		SubstituteAction = 9000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			9000631,
			9000632
		}
	},
	[9000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 9000801,
		ConditionIDList = {
			202
		},
		ActionUnitIDList = {
			9000810,
			9000811,
			9000812,
			9000813
		}
	},
	[9000802] = {
		isDailyAction = true,
		Id = 9000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			9000820,
			9000821,
			9000822,
			9000823
		}
	},
	[9000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 9000803,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			9000830,
			9000831,
			9000832,
			9000833
		}
	},
	[9005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 9005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[9005002] = {
		Id = 9005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			9000100,
			9000110,
			9000111,
			9000112,
			9000113,
			9000120
		}
	},
	[10000001] = {
		Id = 10000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[10000002] = {
		Id = 10000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[10000003] = {
		Id = 10000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[10000004] = {
		Id = 10000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			10000010
		}
	},
	[10000005] = {
		Id = 10000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			10000020
		}
	},
	[10000011] = {
		RandomWeight = 10,
		Id = 10000011,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000110,
			10000100,
			10000110,
			10000120
		}
	},
	[10000012] = {
		RandomWeight = 10,
		Id = 10000012,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000130
		}
	},
	[10000013] = {
		RandomWeight = 10,
		Id = 10000013,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000110,
			10000100,
			10000110,
			10000131,
			10000100
		}
	},
	[10000021] = {
		RandomWeight = 20,
		Id = 10000021,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000111,
			10000100,
			10000111,
			10000120
		}
	},
	[10000022] = {
		RandomWeight = 20,
		Id = 10000022,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000112,
			10000100,
			10000112,
			10000120
		}
	},
	[10000023] = {
		RandomWeight = 20,
		Id = 10000023,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000113,
			10000100,
			10000113,
			10000120
		}
	},
	[10000024] = {
		RandomWeight = 20,
		Id = 10000024,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000140
		}
	},
	[10000025] = {
		RandomWeight = 20,
		Id = 10000025,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			10000110,
			10000100,
			10000110,
			10000141,
			10000100
		}
	},
	[10000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 10000026,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			10000150
		}
	},
	[10000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 10000031,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			10000151
		}
	},
	[10000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 10000041,
		SubstituteAction = 10000004,
		ConditionIDList = {
			101,
			803
		},
		ActionUnitIDList = {
			10000152
		}
	},
	[10000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 10000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			10000210
		}
	},
	[10000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 10000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			10000211
		}
	},
	[10000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 10000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			10000210
		}
	},
	[10000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 10000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			10000211
		}
	},
	[10000121] = {
		Id = 10000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[10000122] = {
		Id = 10000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[10000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 10000201,
		SubstituteAction = 10000005,
		ActionUnitIDList = {
			10000300,
			10000310
		}
	},
	[10000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 10000202,
		SubstituteAction = 10000005,
		ActionUnitIDList = {
			10000300,
			10000311
		}
	},
	[10000211] = {
		Id = 10000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[10000212] = {
		RandomWeight = 10,
		Id = 10000212,
		SubstituteAction = 10000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			10000320
		}
	},
	[10000213] = {
		Id = 10000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[10000214] = {
		RandomWeight = 60,
		Id = 10000214,
		SubstituteAction = 10000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			10000321
		}
	},
	[10000221] = {
		RandomWeight = 10,
		Id = 10000221,
		SubstituteAction = 10000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			10000310
		}
	},
	[10000222] = {
		RandomWeight = 20,
		Id = 10000222,
		SubstituteAction = 10000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			10000311
		}
	},
	[10000231] = {
		isDailyAction = true,
		Id = 10000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			10000330
		}
	},
	[10000232] = {
		isDailyAction = true,
		Id = 10000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			10000331
		}
	},
	[10000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 10000301,
		SubstituteAction = 10000005,
		ActionUnitIDList = {
			10000400,
			10000410
		}
	},
	[10000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 10000302,
		SubstituteAction = 10000005,
		ActionUnitIDList = {
			10000400,
			10000411
		}
	},
	[10000311] = {
		Id = 10000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[10000312] = {
		RandomWeight = 10,
		Id = 10000312,
		SubstituteAction = 10000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			10000420
		}
	},
	[10000313] = {
		Id = 10000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[10000314] = {
		RandomWeight = 60,
		Id = 10000314,
		SubstituteAction = 10000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			10000421
		}
	},
	[10000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000321,
		SubstituteAction = 10000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			10000410
		}
	},
	[10000322] = {
		RandomWeight = 20,
		Id = 10000322,
		SubstituteAction = 10000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			10000411
		}
	},
	[10000331] = {
		isDailyAction = true,
		Id = 10000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			10000430
		}
	},
	[10000332] = {
		isDailyAction = true,
		Id = 10000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			10000431
		}
	},
	[10000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 10000401,
		SubstituteAction = 10000005,
		ActionUnitIDList = {
			10000500,
			10000510
		}
	},
	[10000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 10000402,
		SubstituteAction = 10000005,
		ActionUnitIDList = {
			10000500,
			10000511
		}
	},
	[10000411] = {
		Id = 10000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[10000412] = {
		RandomWeight = 10,
		Id = 10000412,
		SubstituteAction = 10000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			10000520
		}
	},
	[10000413] = {
		Id = 10000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[10000414] = {
		RandomWeight = 60,
		Id = 10000414,
		SubstituteAction = 10000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			10000521
		}
	},
	[10000421] = {
		RandomWeight = 10,
		Id = 10000421,
		SubstituteAction = 10000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			10000510
		}
	},
	[10000422] = {
		RandomWeight = 20,
		Id = 10000422,
		SubstituteAction = 10000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			10000511
		}
	},
	[10000431] = {
		isDailyAction = true,
		Id = 10000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			10000530
		}
	},
	[10000432] = {
		isDailyAction = true,
		Id = 10000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			10000531
		}
	},
	[10000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000501,
		SubstituteAction = 10000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000600,
			10000601,
			10000602,
			10000603,
			10000604
		}
	},
	[10000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000502,
		SubstituteAction = 10000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000610,
			10000611,
			10000612,
			10000613,
			10000614
		}
	},
	[10000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000605,
			10000606
		}
	},
	[10000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000615,
			10000616
		}
	},
	[10000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000511,
		SubstituteAction = 10000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			10000620,
			10000621,
			10000622
		}
	},
	[10000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000512,
		SubstituteAction = 10000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			10000630,
			10000631,
			10000632
		}
	},
	[10000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			10000623,
			10000624
		}
	},
	[10000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			10000633,
			10000634
		}
	},
	[10000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000521,
		SubstituteAction = 10000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			10000620,
			10000625,
			10000624
		}
	},
	[10000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 10000522,
		SubstituteAction = 10000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			10000630,
			10000635,
			10000634
		}
	},
	[10000601] = {
		Id = 10000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[10000602] = {
		RandomWeight = 10,
		Id = 10000602,
		SubstituteAction = 10000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000100,
			10000640
		}
	},
	[10000603] = {
		Id = 10000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[10000604] = {
		RandomWeight = 30,
		Id = 10000604,
		SubstituteAction = 10000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000100,
			10000642
		}
	},
	[10000605] = {
		Id = 10000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000641
		}
	},
	[10000606] = {
		Id = 10000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000643
		}
	},
	[10000607] = {
		RandomWeight = 10,
		Id = 10000607,
		SubstituteAction = 10000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000640
		}
	},
	[10000608] = {
		RandomWeight = 30,
		Id = 10000608,
		SubstituteAction = 10000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			10000642
		}
	},
	[10000611] = {
		Id = 10000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[10000612] = {
		RandomWeight = 30,
		Id = 10000612,
		SubstituteAction = 10000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			10000100,
			10000650,
			10000651
		}
	},
	[10000613] = {
		Id = 10000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[10000614] = {
		RandomWeight = 30,
		Id = 10000614,
		SubstituteAction = 10000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			10000100,
			10000652,
			10000653
		}
	},
	[10000615] = {
		Id = 10000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			10000651
		}
	},
	[10000616] = {
		Id = 10000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			10000653
		}
	},
	[10000617] = {
		RandomWeight = 30,
		Id = 10000617,
		SubstituteAction = 10000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			10000650,
			10000651
		}
	},
	[10000618] = {
		RandomWeight = 30,
		Id = 10000618,
		SubstituteAction = 10000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			10000652,
			10000653
		}
	},
	[10000621] = {
		Id = 10000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[10000622] = {
		RandomWeight = 30,
		Id = 10000622,
		SubstituteAction = 10000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			10000635,
			10000624
		}
	},
	[10000623] = {
		Id = 10000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[10000624] = {
		RandomWeight = 30,
		Id = 10000624,
		SubstituteAction = 10000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			10000635,
			10000632
		}
	},
	[10000625] = {
		RandomWeight = 30,
		Id = 10000625,
		SubstituteAction = 10000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			10000661
		}
	},
	[10000626] = {
		RandomWeight = 30,
		Id = 10000626,
		SubstituteAction = 10000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			10000662
		}
	},
	[10000701] = {
		RandomWeight = 30,
		Id = 10000701,
		SubstituteAction = 10000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			10000603,
			10000604
		}
	},
	[10000702] = {
		RandomWeight = 10,
		Id = 10000702,
		SubstituteAction = 10000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			10000613,
			10000614
		}
	},
	[10000711] = {
		SubstituteAction = 10000513,
		RandomWeight = 10,
		Id = 10000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[10000712] = {
		RandomWeight = 10,
		Id = 10000712,
		SubstituteAction = 10000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			10000631,
			10000632
		}
	},
	[10000713] = {
		RandomWeight = 10,
		Id = 10000713,
		SubstituteAction = 10000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			10000635,
			10000624
		}
	},
	[10000714] = {
		RandomWeight = 10,
		Id = 10000714,
		SubstituteAction = 10000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			10000635,
			10000632
		}
	},
	[10000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 10000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			10000810,
			10000811,
			10000812,
			10000813
		}
	},
	[10000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 10000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			10000820,
			10000821,
			10000822,
			10000823
		}
	},
	[10005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 10005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[10005002] = {
		Id = 10005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			10000100,
			10000110,
			10000111,
			10000112,
			10000113,
			10000120
		}
	},
	[11000001] = {
		Id = 11000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[11000002] = {
		Id = 11000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[11000003] = {
		Id = 11000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[11000004] = {
		Id = 11000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			11000010
		}
	},
	[11000005] = {
		Id = 11000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			11000020
		}
	},
	[11000011] = {
		RandomWeight = 10,
		Id = 11000011,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000110,
			11000100,
			11000110,
			11000120
		}
	},
	[11000012] = {
		RandomWeight = 10,
		Id = 11000012,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000130
		}
	},
	[11000013] = {
		RandomWeight = 10,
		Id = 11000013,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000110,
			11000100,
			11000110,
			11000131,
			11000100
		}
	},
	[11000021] = {
		RandomWeight = 20,
		Id = 11000021,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000111,
			11000100,
			11000111,
			11000120
		}
	},
	[11000022] = {
		RandomWeight = 20,
		Id = 11000022,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000112,
			11000100,
			11000112,
			11000120
		}
	},
	[11000023] = {
		RandomWeight = 20,
		Id = 11000023,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000113,
			11000100,
			11000113,
			11000120
		}
	},
	[11000024] = {
		RandomWeight = 20,
		Id = 11000024,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000140
		}
	},
	[11000025] = {
		RandomWeight = 20,
		Id = 11000025,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			11000110,
			11000100,
			11000110,
			11000141,
			11000100
		}
	},
	[11000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 11000026,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			11000150
		}
	},
	[11000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 11000031,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101,
			808
		},
		ActionUnitIDList = {
			11000151
		}
	},
	[11000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 11000041,
		SubstituteAction = 11000004,
		ConditionIDList = {
			101,
			809
		},
		ActionUnitIDList = {
			11000152
		}
	},
	[11000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 11000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			11000210
		}
	},
	[11000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 11000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			11000211
		}
	},
	[11000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 11000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			11000210
		}
	},
	[11000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 11000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			11000211
		}
	},
	[11000121] = {
		Id = 11000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[11000122] = {
		Id = 11000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[11000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 11000201,
		SubstituteAction = 11000005,
		ActionUnitIDList = {
			11000300,
			11000310
		}
	},
	[11000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 11000202,
		SubstituteAction = 11000005,
		ActionUnitIDList = {
			11000300,
			11000311
		}
	},
	[11000211] = {
		Id = 11000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[11000212] = {
		RandomWeight = 10,
		Id = 11000212,
		SubstituteAction = 11000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			11000320
		}
	},
	[11000213] = {
		Id = 11000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[11000214] = {
		RandomWeight = 60,
		Id = 11000214,
		SubstituteAction = 11000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			11000321
		}
	},
	[11000221] = {
		RandomWeight = 10,
		Id = 11000221,
		SubstituteAction = 11000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			11000310
		}
	},
	[11000222] = {
		RandomWeight = 20,
		Id = 11000222,
		SubstituteAction = 11000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			11000311
		}
	},
	[11000231] = {
		isDailyAction = true,
		Id = 11000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			11000330
		}
	},
	[11000232] = {
		isDailyAction = true,
		Id = 11000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			11000331
		}
	},
	[11000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 11000301,
		SubstituteAction = 11000005,
		ActionUnitIDList = {
			11000400,
			11000410
		}
	},
	[11000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 11000302,
		SubstituteAction = 11000005,
		ActionUnitIDList = {
			11000400,
			11000411
		}
	},
	[11000311] = {
		Id = 11000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[11000312] = {
		RandomWeight = 10,
		Id = 11000312,
		SubstituteAction = 11000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			11000420
		}
	},
	[11000313] = {
		Id = 11000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[11000314] = {
		RandomWeight = 60,
		Id = 11000314,
		SubstituteAction = 11000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			11000421
		}
	},
	[11000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000321,
		SubstituteAction = 11000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			11000410
		}
	},
	[11000322] = {
		RandomWeight = 20,
		Id = 11000322,
		SubstituteAction = 11000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			11000411
		}
	},
	[11000331] = {
		isDailyAction = true,
		Id = 11000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			11000430
		}
	},
	[11000332] = {
		isDailyAction = true,
		Id = 11000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			11000431
		}
	},
	[11000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 11000401,
		SubstituteAction = 11000005,
		ActionUnitIDList = {
			11000500,
			11000510
		}
	},
	[11000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 11000402,
		SubstituteAction = 11000005,
		ActionUnitIDList = {
			11000500,
			11000511
		}
	},
	[11000411] = {
		Id = 11000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[11000412] = {
		RandomWeight = 10,
		Id = 11000412,
		SubstituteAction = 11000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			11000520
		}
	},
	[11000413] = {
		Id = 11000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[11000414] = {
		RandomWeight = 60,
		Id = 11000414,
		SubstituteAction = 11000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			11000521
		}
	},
	[11000421] = {
		RandomWeight = 10,
		Id = 11000421,
		SubstituteAction = 11000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			11000510
		}
	},
	[11000422] = {
		RandomWeight = 20,
		Id = 11000422,
		SubstituteAction = 11000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			11000511
		}
	},
	[11000431] = {
		isDailyAction = true,
		Id = 11000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			11000530
		}
	},
	[11000432] = {
		isDailyAction = true,
		Id = 11000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			11000531
		}
	},
	[11000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000501,
		SubstituteAction = 11000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000600,
			11000601,
			11000602,
			11000603,
			11000604
		}
	},
	[11000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000502,
		SubstituteAction = 11000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000610,
			11000611,
			11000612,
			11000613,
			11000614
		}
	},
	[11000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000605,
			11000606
		}
	},
	[11000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000615,
			11000616
		}
	},
	[11000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000511,
		SubstituteAction = 11000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			11000620,
			11000621,
			11000622
		}
	},
	[11000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000512,
		SubstituteAction = 11000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			11000630,
			11000631,
			11000632
		}
	},
	[11000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			11000623,
			11000624
		}
	},
	[11000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			11000633,
			11000634
		}
	},
	[11000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000521,
		SubstituteAction = 11000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			11000620,
			11000625,
			11000624
		}
	},
	[11000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 11000522,
		SubstituteAction = 11000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			11000630,
			11000635,
			11000634
		}
	},
	[11000601] = {
		Id = 11000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[11000602] = {
		RandomWeight = 10,
		Id = 11000602,
		SubstituteAction = 11000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000100,
			11000640
		}
	},
	[11000603] = {
		Id = 11000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[11000604] = {
		RandomWeight = 30,
		Id = 11000604,
		SubstituteAction = 11000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000100,
			11000642
		}
	},
	[11000605] = {
		Id = 11000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000641
		}
	},
	[11000606] = {
		Id = 11000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000643
		}
	},
	[11000607] = {
		RandomWeight = 10,
		Id = 11000607,
		SubstituteAction = 11000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000640
		}
	},
	[11000608] = {
		RandomWeight = 30,
		Id = 11000608,
		SubstituteAction = 11000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			11000642
		}
	},
	[11000611] = {
		Id = 11000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[11000612] = {
		RandomWeight = 30,
		Id = 11000612,
		SubstituteAction = 11000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			11000100,
			11000650,
			11000651
		}
	},
	[11000613] = {
		Id = 11000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[11000614] = {
		RandomWeight = 30,
		Id = 11000614,
		SubstituteAction = 11000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			11000100,
			11000652,
			11000653
		}
	},
	[11000615] = {
		Id = 11000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			11000651
		}
	},
	[11000616] = {
		Id = 11000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			11000653
		}
	},
	[11000617] = {
		RandomWeight = 30,
		Id = 11000617,
		SubstituteAction = 11000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			11000650,
			11000651
		}
	},
	[11000618] = {
		RandomWeight = 30,
		Id = 11000618,
		SubstituteAction = 11000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			11000652,
			11000653
		}
	},
	[11000621] = {
		Id = 11000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[11000622] = {
		RandomWeight = 30,
		Id = 11000622,
		SubstituteAction = 11000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			11000635,
			11000624
		}
	},
	[11000623] = {
		Id = 11000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[11000624] = {
		RandomWeight = 30,
		Id = 11000624,
		SubstituteAction = 11000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			11000635,
			11000632
		}
	},
	[11000625] = {
		RandomWeight = 30,
		Id = 11000625,
		SubstituteAction = 11000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			11000661
		}
	},
	[11000626] = {
		RandomWeight = 30,
		Id = 11000626,
		SubstituteAction = 11000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			11000662
		}
	},
	[11000701] = {
		RandomWeight = 30,
		Id = 11000701,
		SubstituteAction = 11000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			11000603,
			11000604
		}
	},
	[11000702] = {
		RandomWeight = 10,
		Id = 11000702,
		SubstituteAction = 11000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			11000613,
			11000614
		}
	},
	[11000711] = {
		SubstituteAction = 11000513,
		RandomWeight = 10,
		Id = 11000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[11000712] = {
		RandomWeight = 10,
		Id = 11000712,
		SubstituteAction = 11000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			11000631,
			11000632
		}
	},
	[11000713] = {
		RandomWeight = 10,
		Id = 11000713,
		SubstituteAction = 11000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			11000635,
			11000624
		}
	},
	[11000714] = {
		RandomWeight = 10,
		Id = 11000714,
		SubstituteAction = 11000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			11000635,
			11000632
		}
	},
	[11000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 11000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			11000810,
			11000811,
			11000812,
			11000813
		}
	},
	[11000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 11000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			11000820,
			11000821,
			11000822,
			11000823
		}
	},
	[11005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 11005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[11005002] = {
		Id = 11005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			11000100,
			11000110,
			11000111,
			11000112,
			11000113,
			11000120
		}
	},
	[12000001] = {
		Id = 12000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[12000002] = {
		Id = 12000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[12000003] = {
		Id = 12000003,
		RandomWeight = 12000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[12000004] = {
		Id = 12000004,
		RandomWeight = 12000,
		ActionUnitIDList = {
			12000010
		}
	},
	[12000005] = {
		Id = 12000005,
		RandomWeight = 12000,
		ActionUnitIDList = {
			12000020
		}
	},
	[12000011] = {
		RandomWeight = 10,
		Id = 12000011,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000110,
			12000100,
			12000110,
			12000120
		}
	},
	[12000012] = {
		RandomWeight = 10,
		Id = 12000012,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000130
		}
	},
	[12000013] = {
		RandomWeight = 10,
		Id = 12000013,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000110,
			12000100,
			12000110,
			12000131,
			12000100
		}
	},
	[12000021] = {
		RandomWeight = 20,
		Id = 12000021,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000111,
			12000100,
			12000111,
			12000120
		}
	},
	[12000022] = {
		RandomWeight = 20,
		Id = 12000022,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000112,
			12000100,
			12000112,
			12000120
		}
	},
	[12000023] = {
		RandomWeight = 20,
		Id = 12000023,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000113,
			12000100,
			12000113,
			12000120
		}
	},
	[12000024] = {
		RandomWeight = 20,
		Id = 12000024,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000140
		}
	},
	[12000025] = {
		RandomWeight = 20,
		Id = 12000025,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			12000110,
			12000100,
			12000110,
			12000141,
			12000100
		}
	},
	[12000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 12000026,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			12000150
		}
	},
	[12000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 12000031,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101,
			815
		},
		ActionUnitIDList = {
			12000151
		}
	},
	[12000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 12000041,
		SubstituteAction = 12000004,
		ConditionIDList = {
			101,
			851
		},
		ActionUnitIDList = {
			12000152
		}
	},
	[12000071] = {
		Id = 12000071,
		RandomWeight = 50,
		ActionUnitIDList = {
			104
		}
	},
	[12000072] = {
		Id = 12000072,
		RandomWeight = 50,
		ActionUnitIDList = {
			12000170,
			12000171
		}
	},
	[12000073] = {
		Id = 12000073,
		RandomWeight = 50,
		ActionUnitIDList = {
			12000170,
			12000172
		}
	},
	[12000074] = {
		isDailyAction = true,
		Id = 12000074,
		RandomWeight = 80,
		ActionUnitIDList = {
			12000170,
			12000173
		}
	},
	[12000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 12000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			12000200
		}
	},
	[12000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 12000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			12000201
		}
	},
	[12000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 12000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			12000200
		}
	},
	[12000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 12000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			12000201
		}
	},
	[12000121] = {
		Id = 12000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[12000122] = {
		Id = 12000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[12000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 12000201,
		SubstituteAction = 12000005,
		ActionUnitIDList = {
			12000300,
			12000310
		}
	},
	[12000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 12000202,
		SubstituteAction = 12000005,
		ActionUnitIDList = {
			12000300,
			12000311
		}
	},
	[12000211] = {
		Id = 12000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[12000212] = {
		RandomWeight = 10,
		Id = 12000212,
		SubstituteAction = 12000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			12000320
		}
	},
	[12000213] = {
		Id = 12000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[12000214] = {
		RandomWeight = 60,
		Id = 12000214,
		SubstituteAction = 12000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			12000321
		}
	},
	[12000221] = {
		RandomWeight = 10,
		Id = 12000221,
		SubstituteAction = 12000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			12000310
		}
	},
	[12000222] = {
		RandomWeight = 20,
		Id = 12000222,
		SubstituteAction = 12000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			12000311
		}
	},
	[12000231] = {
		isDailyAction = true,
		Id = 12000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			12000330
		}
	},
	[12000232] = {
		isDailyAction = true,
		Id = 12000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			12000331
		}
	},
	[12000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 12000301,
		SubstituteAction = 12000005,
		ActionUnitIDList = {
			12000400,
			12000410
		}
	},
	[12000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 12000302,
		SubstituteAction = 12000005,
		ActionUnitIDList = {
			12000400,
			12000411
		}
	},
	[12000311] = {
		Id = 12000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[12000312] = {
		RandomWeight = 10,
		Id = 12000312,
		SubstituteAction = 12000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			12000420
		}
	},
	[12000313] = {
		Id = 12000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[12000314] = {
		RandomWeight = 60,
		Id = 12000314,
		SubstituteAction = 12000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			12000421
		}
	},
	[12000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000321,
		SubstituteAction = 12000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			12000410
		}
	},
	[12000322] = {
		RandomWeight = 20,
		Id = 12000322,
		SubstituteAction = 12000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			12000411
		}
	},
	[12000331] = {
		isDailyAction = true,
		Id = 12000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			12000430
		}
	},
	[12000332] = {
		isDailyAction = true,
		Id = 12000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			12000431
		}
	},
	[12000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 12000401,
		SubstituteAction = 12000005,
		ActionUnitIDList = {
			12000500,
			12000510
		}
	},
	[12000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 12000402,
		SubstituteAction = 12000005,
		ActionUnitIDList = {
			12000500,
			12000511
		}
	},
	[12000411] = {
		Id = 12000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[12000412] = {
		RandomWeight = 10,
		Id = 12000412,
		SubstituteAction = 12000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			12000520
		}
	},
	[12000413] = {
		Id = 12000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[12000414] = {
		RandomWeight = 60,
		Id = 12000414,
		SubstituteAction = 12000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			12000521
		}
	},
	[12000421] = {
		RandomWeight = 10,
		Id = 12000421,
		SubstituteAction = 12000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			12000510
		}
	},
	[12000422] = {
		RandomWeight = 20,
		Id = 12000422,
		SubstituteAction = 12000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			12000511
		}
	},
	[12000431] = {
		isDailyAction = true,
		Id = 12000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			12000530
		}
	},
	[12000432] = {
		isDailyAction = true,
		Id = 12000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			12000531
		}
	},
	[12000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000501,
		SubstituteAction = 12000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000600,
			12000601,
			12000602,
			12000603,
			12000604
		}
	},
	[12000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000502,
		SubstituteAction = 12000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000610,
			12000611,
			12000612,
			12000613,
			12000614
		}
	},
	[12000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000605,
			12000606
		}
	},
	[12000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000615,
			12000616
		}
	},
	[12000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000511,
		SubstituteAction = 12000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000620,
			12000621,
			12000622
		}
	},
	[12000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000512,
		SubstituteAction = 12000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000630,
			12000631,
			12000632
		}
	},
	[12000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000623,
			12000624
		}
	},
	[12000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 12000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000633,
			12000634
		}
	},
	[12000601] = {
		Id = 12000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[12000602] = {
		RandomWeight = 10,
		Id = 12000602,
		SubstituteAction = 12000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000100,
			12000640
		}
	},
	[12000603] = {
		Id = 12000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[12000604] = {
		RandomWeight = 30,
		Id = 12000604,
		SubstituteAction = 12000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000100,
			12000642
		}
	},
	[12000605] = {
		Id = 12000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000641
		}
	},
	[12000606] = {
		Id = 12000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000643
		}
	},
	[12000607] = {
		RandomWeight = 10,
		Id = 12000607,
		SubstituteAction = 12000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000640
		}
	},
	[12000608] = {
		RandomWeight = 30,
		Id = 12000608,
		SubstituteAction = 12000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			12000642
		}
	},
	[12000611] = {
		Id = 12000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[12000612] = {
		RandomWeight = 30,
		Id = 12000612,
		SubstituteAction = 12000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000100,
			12000650,
			12000651
		}
	},
	[12000613] = {
		Id = 12000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[12000614] = {
		RandomWeight = 30,
		Id = 12000614,
		SubstituteAction = 12000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000100,
			12000652,
			12000653
		}
	},
	[12000615] = {
		Id = 12000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000651
		}
	},
	[12000616] = {
		Id = 12000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000653
		}
	},
	[12000617] = {
		RandomWeight = 30,
		Id = 12000617,
		SubstituteAction = 12000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000650,
			12000651
		}
	},
	[12000618] = {
		RandomWeight = 30,
		Id = 12000618,
		SubstituteAction = 12000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			12000652,
			12000653
		}
	},
	[12000701] = {
		RandomWeight = 30,
		Id = 12000701,
		SubstituteAction = 12000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			12000603,
			12000604
		}
	},
	[12000702] = {
		RandomWeight = 10,
		Id = 12000702,
		SubstituteAction = 12000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			12000613,
			12000614
		}
	},
	[12000711] = {
		RandomWeight = 10,
		Id = 12000711,
		SubstituteAction = 12000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			12000621,
			12000622
		}
	},
	[12000712] = {
		RandomWeight = 10,
		Id = 12000712,
		SubstituteAction = 12000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			12000631,
			12000632
		}
	},
	[12000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 12000802,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			12000820,
			12000821,
			12000822,
			12000823
		}
	},
	[12000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 12000803,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			12000830,
			12000831,
			12000832,
			12000833
		}
	},
	[12005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 12005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[12005002] = {
		Id = 12005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			12000100,
			12000110,
			12000111,
			12000112,
			12000113,
			12000120
		}
	},
	[13000001] = {
		Id = 13000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[13000002] = {
		Id = 13000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[13000003] = {
		Id = 13000003,
		RandomWeight = 13000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[13000004] = {
		Id = 13000004,
		RandomWeight = 13000,
		ActionUnitIDList = {
			13000010
		}
	},
	[13000005] = {
		Id = 13000005,
		RandomWeight = 13000,
		ActionUnitIDList = {
			13000020
		}
	},
	[13000011] = {
		RandomWeight = 10,
		Id = 13000011,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000110,
			13000100,
			13000110,
			13000120
		}
	},
	[13000012] = {
		RandomWeight = 10,
		Id = 13000012,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000130
		}
	},
	[13000013] = {
		RandomWeight = 10,
		Id = 13000013,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000110,
			13000100,
			13000110,
			13000131,
			13000100
		}
	},
	[13000021] = {
		RandomWeight = 20,
		Id = 13000021,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000111,
			13000100,
			13000111,
			13000120
		}
	},
	[13000022] = {
		RandomWeight = 20,
		Id = 13000022,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000112,
			13000100,
			13000112,
			13000120
		}
	},
	[13000023] = {
		RandomWeight = 20,
		Id = 13000023,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000113,
			13000100,
			13000113,
			13000120
		}
	},
	[13000024] = {
		RandomWeight = 20,
		Id = 13000024,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000140
		}
	},
	[13000025] = {
		RandomWeight = 20,
		Id = 13000025,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			13000110,
			13000100,
			13000110,
			13000141,
			13000100
		}
	},
	[13000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 13000026,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			13000150
		}
	},
	[13000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 13000031,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			13000151
		}
	},
	[13000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 13000041,
		SubstituteAction = 13000004,
		ConditionIDList = {
			101,
			807
		},
		ActionUnitIDList = {
			13000152
		}
	},
	[13000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 13000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			13000200
		}
	},
	[13000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 13000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			13000201
		}
	},
	[13000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 13000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			13000200
		}
	},
	[13000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 13000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			13000201
		}
	},
	[13000121] = {
		Id = 13000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[13000122] = {
		Id = 13000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			102
		}
	},
	[13000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 13000201,
		SubstituteAction = 13000005,
		ActionUnitIDList = {
			13000300,
			13000310
		}
	},
	[13000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 13000202,
		SubstituteAction = 13000005,
		ActionUnitIDList = {
			13000300,
			13000311
		}
	},
	[13000211] = {
		Id = 13000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[13000212] = {
		RandomWeight = 10,
		Id = 13000212,
		SubstituteAction = 13000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			13000320
		}
	},
	[13000213] = {
		Id = 13000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[13000214] = {
		RandomWeight = 60,
		Id = 13000214,
		SubstituteAction = 13000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			13000321
		}
	},
	[13000221] = {
		RandomWeight = 10,
		Id = 13000221,
		SubstituteAction = 13000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			13000310
		}
	},
	[13000222] = {
		RandomWeight = 20,
		Id = 13000222,
		SubstituteAction = 13000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			13000311
		}
	},
	[13000231] = {
		isDailyAction = true,
		Id = 13000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			13000330
		}
	},
	[13000232] = {
		isDailyAction = true,
		Id = 13000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			13000331
		}
	},
	[13000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 13000301,
		SubstituteAction = 13000005,
		ActionUnitIDList = {
			13000400,
			13000410
		}
	},
	[13000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 13000302,
		SubstituteAction = 13000005,
		ActionUnitIDList = {
			13000400,
			13000411
		}
	},
	[13000311] = {
		Id = 13000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[13000312] = {
		RandomWeight = 10,
		Id = 13000312,
		SubstituteAction = 13000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			13000420
		}
	},
	[13000313] = {
		Id = 13000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[13000314] = {
		RandomWeight = 60,
		Id = 13000314,
		SubstituteAction = 13000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			13000421
		}
	},
	[13000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000321,
		SubstituteAction = 13000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			13000410
		}
	},
	[13000322] = {
		RandomWeight = 20,
		Id = 13000322,
		SubstituteAction = 13000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			13000411
		}
	},
	[13000331] = {
		isDailyAction = true,
		Id = 13000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			13000430
		}
	},
	[13000332] = {
		isDailyAction = true,
		Id = 13000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			13000431
		}
	},
	[13000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 13000401,
		SubstituteAction = 13000005,
		ActionUnitIDList = {
			13000500,
			13000510
		}
	},
	[13000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 13000402,
		SubstituteAction = 13000005,
		ActionUnitIDList = {
			13000500,
			13000511
		}
	},
	[13000411] = {
		Id = 13000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[13000412] = {
		RandomWeight = 10,
		Id = 13000412,
		SubstituteAction = 13000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			13000520
		}
	},
	[13000413] = {
		Id = 13000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[13000414] = {
		RandomWeight = 60,
		Id = 13000414,
		SubstituteAction = 13000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			13000521
		}
	},
	[13000421] = {
		RandomWeight = 10,
		Id = 13000421,
		SubstituteAction = 13000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			13000510
		}
	},
	[13000422] = {
		RandomWeight = 20,
		Id = 13000422,
		SubstituteAction = 13000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			13000511
		}
	},
	[13000431] = {
		isDailyAction = true,
		Id = 13000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			13000530
		}
	},
	[13000432] = {
		isDailyAction = true,
		Id = 13000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			13000531
		}
	},
	[13000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000501,
		SubstituteAction = 13000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000600,
			13000601,
			13000602,
			13000603,
			13000604
		}
	},
	[13000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000502,
		SubstituteAction = 13000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000610,
			13000611,
			13000612,
			13000613,
			13000614
		}
	},
	[13000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000605,
			13000606
		}
	},
	[13000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000615,
			13000616
		}
	},
	[13000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000511,
		SubstituteAction = 13000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000620,
			13000621,
			13000622
		}
	},
	[13000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000512,
		SubstituteAction = 13000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000630,
			13000631,
			13000632
		}
	},
	[13000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000623,
			13000624
		}
	},
	[13000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 13000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000633,
			13000634
		}
	},
	[13000601] = {
		Id = 13000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[13000602] = {
		RandomWeight = 10,
		Id = 13000602,
		SubstituteAction = 13000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000100,
			13000640
		}
	},
	[13000603] = {
		Id = 13000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[13000604] = {
		RandomWeight = 30,
		Id = 13000604,
		SubstituteAction = 13000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000100,
			13000642
		}
	},
	[13000605] = {
		Id = 13000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000641
		}
	},
	[13000606] = {
		Id = 13000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000643
		}
	},
	[13000607] = {
		RandomWeight = 10,
		Id = 13000607,
		SubstituteAction = 13000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000640
		}
	},
	[13000608] = {
		RandomWeight = 30,
		Id = 13000608,
		SubstituteAction = 13000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			13000642
		}
	},
	[13000611] = {
		Id = 13000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[13000612] = {
		RandomWeight = 30,
		Id = 13000612,
		SubstituteAction = 13000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000100,
			13000650,
			13000651
		}
	},
	[13000613] = {
		Id = 13000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[13000614] = {
		RandomWeight = 30,
		Id = 13000614,
		SubstituteAction = 13000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000100,
			13000652,
			13000653
		}
	},
	[13000615] = {
		Id = 13000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000651
		}
	},
	[13000616] = {
		Id = 13000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000653
		}
	},
	[13000617] = {
		RandomWeight = 30,
		Id = 13000617,
		SubstituteAction = 13000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000650,
			13000651
		}
	},
	[13000618] = {
		RandomWeight = 30,
		Id = 13000618,
		SubstituteAction = 13000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			13000652,
			13000653
		}
	},
	[13000701] = {
		RandomWeight = 30,
		Id = 13000701,
		SubstituteAction = 13000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			13000603,
			13000604
		}
	},
	[13000702] = {
		RandomWeight = 10,
		Id = 13000702,
		SubstituteAction = 13000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			13000613,
			13000614
		}
	},
	[13000711] = {
		RandomWeight = 10,
		Id = 13000711,
		SubstituteAction = 13000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			13000621,
			13000622
		}
	},
	[13000712] = {
		RandomWeight = 10,
		Id = 13000712,
		SubstituteAction = 13000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			13000631,
			13000632
		}
	},
	[13000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 13000801,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			13000810,
			13000811,
			13000812,
			13000813
		}
	},
	[13000802] = {
		isDailyAction = true,
		Id = 13000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			13000820,
			13000821
		}
	},
	[13000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 13000803,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			13000830,
			13000831,
			13000832,
			13000833
		}
	},
	[13005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 13005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[13005002] = {
		Id = 13005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			13000100,
			13000110,
			13000111,
			13000112,
			13000113,
			13000120
		}
	},
	[14000001] = {
		Id = 14000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[14000002] = {
		Id = 14000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[14000003] = {
		Id = 14000003,
		RandomWeight = 14000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[14000004] = {
		Id = 14000004,
		RandomWeight = 14000,
		ActionUnitIDList = {
			14000010
		}
	},
	[14000005] = {
		Id = 14000005,
		RandomWeight = 14000,
		ActionUnitIDList = {
			14000020
		}
	},
	[14000011] = {
		RandomWeight = 10,
		Id = 14000011,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000110,
			14000100,
			14000110,
			14000120
		}
	},
	[14000012] = {
		RandomWeight = 10,
		Id = 14000012,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000130
		}
	},
	[14000013] = {
		RandomWeight = 10,
		Id = 14000013,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000110,
			14000100,
			14000110,
			14000131,
			14000100
		}
	},
	[14000021] = {
		RandomWeight = 20,
		Id = 14000021,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000111,
			14000100,
			14000111,
			14000120
		}
	},
	[14000022] = {
		RandomWeight = 20,
		Id = 14000022,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000112,
			14000100,
			14000112,
			14000120
		}
	},
	[14000023] = {
		RandomWeight = 20,
		Id = 14000023,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000113,
			14000100,
			14000113,
			14000120
		}
	},
	[14000024] = {
		RandomWeight = 20,
		Id = 14000024,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000140
		}
	},
	[14000025] = {
		RandomWeight = 20,
		Id = 14000025,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			14000110,
			14000100,
			14000110,
			14000141,
			14000100
		}
	},
	[14000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 14000026,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			14000150
		}
	},
	[14000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 14000031,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101,
			804
		},
		ActionUnitIDList = {
			14000151
		}
	},
	[14000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 14000041,
		SubstituteAction = 14000004,
		ConditionIDList = {
			101,
			852
		},
		ActionUnitIDList = {
			14000152
		}
	},
	[14000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 14000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			14000200
		}
	},
	[14000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 14000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			14000201
		}
	},
	[14000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 14000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			14000200
		}
	},
	[14000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 14000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			14000201
		}
	},
	[14000121] = {
		Id = 14000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[14000122] = {
		Id = 14000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			110
		}
	},
	[14000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 14000201,
		SubstituteAction = 14000005,
		ActionUnitIDList = {
			14000300,
			14000310
		}
	},
	[14000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 14000202,
		SubstituteAction = 14000005,
		ActionUnitIDList = {
			14000300,
			14000311
		}
	},
	[14000211] = {
		Id = 14000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[14000212] = {
		RandomWeight = 10,
		Id = 14000212,
		SubstituteAction = 14000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			14000320
		}
	},
	[14000213] = {
		Id = 14000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[14000214] = {
		RandomWeight = 60,
		Id = 14000214,
		SubstituteAction = 14000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			14000321
		}
	},
	[14000221] = {
		RandomWeight = 10,
		Id = 14000221,
		SubstituteAction = 14000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			14000310
		}
	},
	[14000222] = {
		RandomWeight = 20,
		Id = 14000222,
		SubstituteAction = 14000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			14000311
		}
	},
	[14000231] = {
		isDailyAction = true,
		Id = 14000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			14000330
		}
	},
	[14000232] = {
		isDailyAction = true,
		Id = 14000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			14000331
		}
	},
	[14000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 14000301,
		SubstituteAction = 14000005,
		ActionUnitIDList = {
			14000400,
			14000410
		}
	},
	[14000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 14000302,
		SubstituteAction = 14000005,
		ActionUnitIDList = {
			14000400,
			14000411
		}
	},
	[14000311] = {
		Id = 14000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[14000312] = {
		RandomWeight = 10,
		Id = 14000312,
		SubstituteAction = 14000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			14000420
		}
	},
	[14000313] = {
		Id = 14000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[14000314] = {
		RandomWeight = 60,
		Id = 14000314,
		SubstituteAction = 14000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			14000421
		}
	},
	[14000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000321,
		SubstituteAction = 14000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			14000410
		}
	},
	[14000322] = {
		RandomWeight = 20,
		Id = 14000322,
		SubstituteAction = 14000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			14000411
		}
	},
	[14000331] = {
		isDailyAction = true,
		Id = 14000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			14000430
		}
	},
	[14000332] = {
		isDailyAction = true,
		Id = 14000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			14000431
		}
	},
	[14000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 14000401,
		SubstituteAction = 14000005,
		ActionUnitIDList = {
			14000500,
			14000510
		}
	},
	[14000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 14000402,
		SubstituteAction = 14000005,
		ActionUnitIDList = {
			14000500,
			14000511
		}
	},
	[14000411] = {
		Id = 14000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[14000412] = {
		RandomWeight = 10,
		Id = 14000412,
		SubstituteAction = 14000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			14000520
		}
	},
	[14000413] = {
		Id = 14000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[14000414] = {
		RandomWeight = 60,
		Id = 14000414,
		SubstituteAction = 14000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			14000521
		}
	},
	[14000421] = {
		RandomWeight = 10,
		Id = 14000421,
		SubstituteAction = 14000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			14000510
		}
	},
	[14000422] = {
		RandomWeight = 20,
		Id = 14000422,
		SubstituteAction = 14000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			14000511
		}
	},
	[14000431] = {
		isDailyAction = true,
		Id = 14000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			14000530
		}
	},
	[14000432] = {
		isDailyAction = true,
		Id = 14000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			14000531
		}
	},
	[14000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000501,
		SubstituteAction = 14000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000600,
			14000601,
			14000602,
			14000603,
			14000604
		}
	},
	[14000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000502,
		SubstituteAction = 14000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000610,
			14000611,
			14000612,
			14000613,
			14000614
		}
	},
	[14000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000605,
			14000606
		}
	},
	[14000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000615,
			14000616
		}
	},
	[14000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000511,
		SubstituteAction = 14000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000620,
			14000621,
			14000622
		}
	},
	[14000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000512,
		SubstituteAction = 14000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000630,
			14000631,
			14000632
		}
	},
	[14000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000623,
			14000624
		}
	},
	[14000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 14000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000633,
			14000634
		}
	},
	[14000601] = {
		Id = 14000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[14000602] = {
		RandomWeight = 10,
		Id = 14000602,
		SubstituteAction = 14000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000100,
			14000640
		}
	},
	[14000603] = {
		Id = 14000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[14000604] = {
		RandomWeight = 30,
		Id = 14000604,
		SubstituteAction = 14000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000100,
			14000642
		}
	},
	[14000605] = {
		Id = 14000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000641
		}
	},
	[14000606] = {
		Id = 14000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000643
		}
	},
	[14000607] = {
		RandomWeight = 10,
		Id = 14000607,
		SubstituteAction = 14000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000640
		}
	},
	[14000608] = {
		RandomWeight = 30,
		Id = 14000608,
		SubstituteAction = 14000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			14000642
		}
	},
	[14000611] = {
		Id = 14000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[14000612] = {
		RandomWeight = 30,
		Id = 14000612,
		SubstituteAction = 14000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000100,
			14000650,
			14000651
		}
	},
	[14000613] = {
		Id = 14000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[14000614] = {
		RandomWeight = 30,
		Id = 14000614,
		SubstituteAction = 14000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000100,
			14000652,
			14000653
		}
	},
	[14000615] = {
		Id = 14000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000651
		}
	},
	[14000616] = {
		Id = 14000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000653
		}
	},
	[14000617] = {
		RandomWeight = 30,
		Id = 14000617,
		SubstituteAction = 14000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000650,
			14000651
		}
	},
	[14000618] = {
		RandomWeight = 30,
		Id = 14000618,
		SubstituteAction = 14000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			14000652,
			14000653
		}
	},
	[14000701] = {
		RandomWeight = 30,
		Id = 14000701,
		SubstituteAction = 14000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			14000603,
			14000604
		}
	},
	[14000702] = {
		RandomWeight = 10,
		Id = 14000702,
		SubstituteAction = 14000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			14000613,
			14000614
		}
	},
	[14000711] = {
		RandomWeight = 10,
		Id = 14000711,
		SubstituteAction = 14000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			14000621,
			14000622
		}
	},
	[14000712] = {
		RandomWeight = 10,
		Id = 14000712,
		SubstituteAction = 14000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			14000631,
			14000632
		}
	},
	[14000801] = {
		isDailyAction = true,
		Id = 14000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			14000810,
			14000811,
			14000812,
			14000813
		}
	},
	[14000802] = {
		isDailyAction = true,
		Id = 14000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			14000820,
			14000821,
			14000822,
			14000823
		}
	},
	[14000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 14000803,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			14000830,
			14000831,
			14000832,
			14000833
		}
	},
	[14005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 14005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[14005002] = {
		Id = 14005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			14000100,
			14000110,
			14000111,
			14000112,
			14000113,
			14000120
		}
	},
	[15000001] = {
		Id = 15000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[15000002] = {
		Id = 15000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[15000003] = {
		Id = 15000003,
		RandomWeight = 15000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[15000004] = {
		Id = 15000004,
		RandomWeight = 15000,
		ActionUnitIDList = {
			15000010
		}
	},
	[15000005] = {
		Id = 15000005,
		RandomWeight = 15000,
		ActionUnitIDList = {
			15000020
		}
	},
	[15000011] = {
		RandomWeight = 10,
		Id = 15000011,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000110,
			15000100,
			15000110,
			15000120
		}
	},
	[15000012] = {
		RandomWeight = 10,
		Id = 15000012,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000130
		}
	},
	[15000013] = {
		RandomWeight = 10,
		Id = 15000013,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000110,
			15000100,
			15000110,
			15000131,
			15000100
		}
	},
	[15000021] = {
		RandomWeight = 20,
		Id = 15000021,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000111,
			15000100,
			15000111,
			15000120
		}
	},
	[15000022] = {
		RandomWeight = 20,
		Id = 15000022,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000112,
			15000100,
			15000112,
			15000120
		}
	},
	[15000023] = {
		RandomWeight = 20,
		Id = 15000023,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000113,
			15000100,
			15000113,
			15000120
		}
	},
	[15000024] = {
		RandomWeight = 20,
		Id = 15000024,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000140
		}
	},
	[15000025] = {
		RandomWeight = 20,
		Id = 15000025,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			15000110,
			15000100,
			15000110,
			15000141,
			15000100
		}
	},
	[15000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 15000026,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			15000150
		}
	},
	[15000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 15000031,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101,
			809
		},
		ActionUnitIDList = {
			15000151
		}
	},
	[15000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 15000041,
		SubstituteAction = 15000004,
		ConditionIDList = {
			101,
			812
		},
		ActionUnitIDList = {
			15000152
		}
	},
	[15000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 15000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			15000200
		}
	},
	[15000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 15000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			15000201
		}
	},
	[15000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 15000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			15000200
		}
	},
	[15000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 15000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			15000201
		}
	},
	[15000121] = {
		Id = 15000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[15000122] = {
		Id = 15000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			113
		}
	},
	[15000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 15000301,
		SubstituteAction = 15000005,
		ActionUnitIDList = {
			15000400,
			15000410
		}
	},
	[15000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 15000302,
		SubstituteAction = 15000005,
		ActionUnitIDList = {
			15000400,
			15000411
		}
	},
	[15000311] = {
		Id = 15000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[15000312] = {
		RandomWeight = 10,
		Id = 15000312,
		SubstituteAction = 15000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			15000420
		}
	},
	[15000313] = {
		Id = 15000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[15000314] = {
		RandomWeight = 60,
		Id = 15000314,
		SubstituteAction = 15000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			15000421
		}
	},
	[15000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000321,
		SubstituteAction = 15000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			15000410
		}
	},
	[15000322] = {
		RandomWeight = 20,
		Id = 15000322,
		SubstituteAction = 15000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			15000411
		}
	},
	[15000331] = {
		isDailyAction = true,
		Id = 15000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			15000430
		}
	},
	[15000332] = {
		isDailyAction = true,
		Id = 15000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			15000431
		}
	},
	[15000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000501,
		SubstituteAction = 15000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000600,
			15000601,
			15000602,
			15000603,
			15000604
		}
	},
	[15000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000502,
		SubstituteAction = 15000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000610,
			15000611,
			15000612,
			15000613,
			15000614
		}
	},
	[15000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000605,
			15000606
		}
	},
	[15000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000615,
			15000616
		}
	},
	[15000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000511,
		SubstituteAction = 15000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000620,
			15000621,
			15000622
		}
	},
	[15000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000512,
		SubstituteAction = 15000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000630,
			15000631,
			15000632
		}
	},
	[15000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000623,
			15000624
		}
	},
	[15000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 15000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000633,
			15000634
		}
	},
	[15000601] = {
		Id = 15000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[15000602] = {
		RandomWeight = 10,
		Id = 15000602,
		SubstituteAction = 15000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000100,
			15000640
		}
	},
	[15000603] = {
		Id = 15000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[15000604] = {
		RandomWeight = 30,
		Id = 15000604,
		SubstituteAction = 15000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000100,
			15000642
		}
	},
	[15000605] = {
		Id = 15000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000641
		}
	},
	[15000606] = {
		Id = 15000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000643
		}
	},
	[15000607] = {
		RandomWeight = 10,
		Id = 15000607,
		SubstituteAction = 15000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000640
		}
	},
	[15000608] = {
		RandomWeight = 30,
		Id = 15000608,
		SubstituteAction = 15000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			15000642
		}
	},
	[15000611] = {
		Id = 15000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[15000612] = {
		RandomWeight = 30,
		Id = 15000612,
		SubstituteAction = 15000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000100,
			15000650,
			15000651
		}
	},
	[15000613] = {
		Id = 15000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			106
		}
	},
	[15000614] = {
		RandomWeight = 30,
		Id = 15000614,
		SubstituteAction = 15000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000100,
			15000652,
			15000653
		}
	},
	[15000615] = {
		Id = 15000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000651
		}
	},
	[15000616] = {
		Id = 15000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000653
		}
	},
	[15000617] = {
		RandomWeight = 30,
		Id = 15000617,
		SubstituteAction = 15000615,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000650,
			15000651
		}
	},
	[15000618] = {
		RandomWeight = 30,
		Id = 15000618,
		SubstituteAction = 15000616,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			15000652,
			15000653
		}
	},
	[15000701] = {
		RandomWeight = 30,
		Id = 15000701,
		SubstituteAction = 15000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			15000603,
			15000604
		}
	},
	[15000702] = {
		RandomWeight = 10,
		Id = 15000702,
		SubstituteAction = 15000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			15000613,
			15000614
		}
	},
	[15000711] = {
		RandomWeight = 10,
		Id = 15000711,
		SubstituteAction = 15000513,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			15000621,
			15000622
		}
	},
	[15000712] = {
		RandomWeight = 10,
		Id = 15000712,
		SubstituteAction = 15000514,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			15000631,
			15000632
		}
	},
	[15000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 15000801,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			15000810,
			15000811,
			15000812,
			15000813
		}
	},
	[15000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 15000802,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			15000820,
			15000821,
			15000822,
			15000823
		}
	},
	[15000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 15000803,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			15000830,
			15000831,
			15000832
		}
	},
	[15005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 15005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[15005002] = {
		Id = 15005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			15000100,
			15000110,
			15000111,
			15000112,
			15000113,
			15000120
		}
	},
	[16000001] = {
		Id = 16000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[16000002] = {
		Id = 16000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[16000003] = {
		Id = 16000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[16000004] = {
		Id = 16000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			16000010
		}
	},
	[16000005] = {
		Id = 16000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			16000020
		}
	},
	[16000006] = {
		Id = 16000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			105
		}
	},
	[16000007] = {
		Id = 16000007,
		RandomWeight = 10,
		ActionUnitIDList = {
			114
		}
	},
	[16000008] = {
		Id = 16000008,
		RandomWeight = 10,
		ActionUnitIDList = {
			102
		}
	},
	[16000009] = {
		Id = 16000009,
		RandomWeight = 10,
		ActionUnitIDList = {
			103
		}
	},
	[16000010] = {
		Id = 16000010,
		RandomWeight = 10,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			114
		}
	},
	[16000011] = {
		RandomWeight = 10,
		Id = 16000011,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000110,
			16000100,
			16000110,
			16000120
		}
	},
	[16000012] = {
		RandomWeight = 10,
		Id = 16000012,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000130
		}
	},
	[16000013] = {
		RandomWeight = 10,
		Id = 16000013,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000110,
			16000100,
			16000110,
			16000131,
			16000100
		}
	},
	[16000020] = {
		Id = 16000020,
		RandomWeight = 10,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000021] = {
		RandomWeight = 20,
		Id = 16000021,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000111,
			16000100,
			16000111,
			16000120
		}
	},
	[16000022] = {
		RandomWeight = 20,
		Id = 16000022,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000112,
			16000100,
			16000112,
			16000120
		}
	},
	[16000023] = {
		RandomWeight = 20,
		Id = 16000023,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000113,
			16000100,
			16000113,
			16000120
		}
	},
	[16000024] = {
		RandomWeight = 20,
		Id = 16000024,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000140
		}
	},
	[16000025] = {
		RandomWeight = 20,
		Id = 16000025,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			16000110,
			16000100,
			16000110,
			16000141,
			16000100
		}
	},
	[16000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 16000026,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			16000150
		}
	},
	[16000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 16000031,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101,
			818
		},
		ActionUnitIDList = {
			16000151
		}
	},
	[16000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 16000041,
		SubstituteAction = 16000004,
		ConditionIDList = {
			101,
			803
		},
		ActionUnitIDList = {
			16000152
		}
	},
	[16000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 16000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000210
		}
	},
	[16000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 16000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000211
		}
	},
	[16000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 16000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			16000210
		}
	},
	[16000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 16000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			16000211
		}
	},
	[16000121] = {
		Id = 16000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16000122] = {
		Id = 16000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 16000201,
		SubstituteAction = 16000005,
		ActionUnitIDList = {
			16000300,
			16000310
		}
	},
	[16000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 16000202,
		SubstituteAction = 16000005,
		ActionUnitIDList = {
			16000300,
			16000311
		}
	},
	[16000211] = {
		Id = 16000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[16000212] = {
		RandomWeight = 10,
		Id = 16000212,
		SubstituteAction = 16000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			16000320
		}
	},
	[16000213] = {
		Id = 16000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[16000214] = {
		RandomWeight = 60,
		Id = 16000214,
		SubstituteAction = 16000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			16000321
		}
	},
	[16000221] = {
		RandomWeight = 10,
		Id = 16000221,
		SubstituteAction = 16000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			16000310
		}
	},
	[16000222] = {
		RandomWeight = 20,
		Id = 16000222,
		SubstituteAction = 16000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			16000311
		}
	},
	[16000231] = {
		isDailyAction = true,
		Id = 16000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			16000330
		}
	},
	[16000232] = {
		isDailyAction = true,
		Id = 16000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			16000331
		}
	},
	[16000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 16000301,
		SubstituteAction = 16000005,
		ActionUnitIDList = {
			16000400,
			16000410
		}
	},
	[16000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 16000302,
		SubstituteAction = 16000005,
		ActionUnitIDList = {
			16000400,
			16000411
		}
	},
	[16000311] = {
		Id = 16000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[16000312] = {
		RandomWeight = 10,
		Id = 16000312,
		SubstituteAction = 16000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			16000420
		}
	},
	[16000313] = {
		Id = 16000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[16000314] = {
		RandomWeight = 60,
		Id = 16000314,
		SubstituteAction = 16000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			16000421
		}
	},
	[16000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000321,
		SubstituteAction = 16000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			16000410
		}
	},
	[16000322] = {
		RandomWeight = 20,
		Id = 16000322,
		SubstituteAction = 16000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			16000411
		}
	},
	[16000331] = {
		isDailyAction = true,
		Id = 16000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			16000430
		}
	},
	[16000332] = {
		isDailyAction = true,
		Id = 16000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			16000431
		}
	},
	[16000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 16000401,
		SubstituteAction = 16000005,
		ActionUnitIDList = {
			16000500,
			16000510
		}
	},
	[16000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 16000402,
		SubstituteAction = 16000005,
		ActionUnitIDList = {
			16000500,
			16000511
		}
	},
	[16000411] = {
		Id = 16000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[16000412] = {
		RandomWeight = 10,
		Id = 16000412,
		SubstituteAction = 16000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			16000520
		}
	},
	[16000413] = {
		Id = 16000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[16000414] = {
		RandomWeight = 60,
		Id = 16000414,
		SubstituteAction = 16000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			16000521
		}
	},
	[16000421] = {
		RandomWeight = 10,
		Id = 16000421,
		SubstituteAction = 16000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			16000510
		}
	},
	[16000422] = {
		RandomWeight = 20,
		Id = 16000422,
		SubstituteAction = 16000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			16000511
		}
	},
	[16000431] = {
		isDailyAction = true,
		Id = 16000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			16000530
		}
	},
	[16000432] = {
		isDailyAction = true,
		Id = 16000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			16000531
		}
	},
	[16000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000501,
		SubstituteAction = 16000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000600,
			16000601,
			16000602,
			16000603,
			16000604
		}
	},
	[16000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000502,
		SubstituteAction = 16000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000610,
			16000611,
			16000612,
			16000613,
			16000614
		}
	},
	[16000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000605,
			16000606
		}
	},
	[16000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000615,
			16000616
		}
	},
	[16000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000511,
		SubstituteAction = 16000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000620,
			16000621,
			16000622
		}
	},
	[16000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000512,
		SubstituteAction = 16000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000630,
			16000631,
			16000632
		}
	},
	[16000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000623,
			16000624
		}
	},
	[16000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000633,
			16000634
		}
	},
	[16000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000521,
		SubstituteAction = 16000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000620,
			16000625,
			16000624
		}
	},
	[16000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000522,
		SubstituteAction = 16000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000630,
			16000635,
			16000634
		}
	},
	[16000601] = {
		Id = 16000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16000602] = {
		RandomWeight = 10,
		Id = 16000602,
		SubstituteAction = 16000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000100,
			16000640
		}
	},
	[16000603] = {
		Id = 16000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16000604] = {
		RandomWeight = 30,
		Id = 16000604,
		SubstituteAction = 16000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000100,
			16000642
		}
	},
	[16000605] = {
		Id = 16000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000641
		}
	},
	[16000606] = {
		Id = 16000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000643
		}
	},
	[16000607] = {
		RandomWeight = 10,
		Id = 16000607,
		SubstituteAction = 16000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000640
		}
	},
	[16000608] = {
		RandomWeight = 30,
		Id = 16000608,
		SubstituteAction = 16000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000642
		}
	},
	[16000611] = {
		Id = 16000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000612] = {
		RandomWeight = 30,
		Id = 16000612,
		SubstituteAction = 16000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000100,
			16000650,
			16000651
		}
	},
	[16000613] = {
		Id = 16000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000614] = {
		RandomWeight = 30,
		Id = 16000614,
		SubstituteAction = 16000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000100,
			16000652,
			16000653
		}
	},
	[16000615] = {
		Id = 16000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000651
		}
	},
	[16000616] = {
		Id = 16000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000653
		}
	},
	[16000617] = {
		RandomWeight = 30,
		Id = 16000617,
		SubstituteAction = 16000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000650,
			16000651
		}
	},
	[16000618] = {
		RandomWeight = 30,
		Id = 16000618,
		SubstituteAction = 16000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000652,
			16000653
		}
	},
	[16000621] = {
		Id = 16000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000622] = {
		RandomWeight = 30,
		Id = 16000622,
		SubstituteAction = 16000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000624
		}
	},
	[16000623] = {
		Id = 16000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000624] = {
		RandomWeight = 30,
		Id = 16000624,
		SubstituteAction = 16000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000632
		}
	},
	[16000625] = {
		RandomWeight = 30,
		Id = 16000625,
		SubstituteAction = 16000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000661
		}
	},
	[16000626] = {
		RandomWeight = 30,
		Id = 16000626,
		SubstituteAction = 16000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000662
		}
	},
	[16000701] = {
		RandomWeight = 30,
		Id = 16000701,
		SubstituteAction = 16000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000603,
			16000604
		}
	},
	[16000702] = {
		RandomWeight = 10,
		Id = 16000702,
		SubstituteAction = 16000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000613,
			16000614
		}
	},
	[16000711] = {
		SubstituteAction = 16000513,
		RandomWeight = 10,
		Id = 16000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[16000712] = {
		RandomWeight = 10,
		Id = 16000712,
		SubstituteAction = 16000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			16000631,
			16000632
		}
	},
	[16000713] = {
		RandomWeight = 10,
		Id = 16000713,
		SubstituteAction = 16000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000624
		}
	},
	[16000714] = {
		RandomWeight = 10,
		Id = 16000714,
		SubstituteAction = 16000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000632
		}
	},
	[16001501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001501,
		SubstituteAction = 16001503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001600,
			16001601,
			16001602,
			16001603,
			16001604
		}
	},
	[16001502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001502,
		SubstituteAction = 16001504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001610,
			16001611,
			16001612,
			16001613,
			16001614
		}
	},
	[16001503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001605,
			16001606
		}
	},
	[16001504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001615,
			16001616
		}
	},
	[16001511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001511,
		SubstituteAction = 16001513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16001620,
			16001621,
			16001622
		}
	},
	[16001512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001512,
		SubstituteAction = 16001514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16001630,
			16001631,
			16001632
		}
	},
	[16001513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16001623,
			16001624
		}
	},
	[16001514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16001633,
			16001634
		}
	},
	[16001521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001521,
		SubstituteAction = 16001513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16001620,
			16001625,
			16001624
		}
	},
	[16001522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16001522,
		SubstituteAction = 16001514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16001630,
			16001635,
			16001634
		}
	},
	[16001601] = {
		Id = 16001601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16001602] = {
		RandomWeight = 10,
		Id = 16001602,
		SubstituteAction = 16001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000100,
			16001640
		}
	},
	[16001603] = {
		Id = 16001603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16001604] = {
		RandomWeight = 30,
		Id = 16001604,
		SubstituteAction = 16001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000100,
			16001642
		}
	},
	[16001605] = {
		Id = 16001605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001641
		}
	},
	[16001606] = {
		Id = 16001606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001643
		}
	},
	[16001607] = {
		RandomWeight = 10,
		Id = 16001607,
		SubstituteAction = 16001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001640
		}
	},
	[16001608] = {
		RandomWeight = 30,
		Id = 16001608,
		SubstituteAction = 16001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16001642
		}
	},
	[16001611] = {
		Id = 16001611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16001612] = {
		RandomWeight = 30,
		Id = 16001612,
		SubstituteAction = 16001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000100,
			16001650,
			16001651
		}
	},
	[16001613] = {
		Id = 16001613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16001614] = {
		RandomWeight = 30,
		Id = 16001614,
		SubstituteAction = 16001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000100,
			16001652,
			16001653
		}
	},
	[16001615] = {
		Id = 16001615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16001651
		}
	},
	[16001616] = {
		Id = 16001616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16001653
		}
	},
	[16001617] = {
		RandomWeight = 30,
		Id = 16001617,
		SubstituteAction = 16001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16001650,
			16001651
		}
	},
	[16001618] = {
		RandomWeight = 30,
		Id = 16001618,
		SubstituteAction = 16001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16001652,
			16001653
		}
	},
	[16001621] = {
		Id = 16001621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[16001622] = {
		RandomWeight = 30,
		Id = 16001622,
		SubstituteAction = 16001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16001635,
			16001624
		}
	},
	[16001623] = {
		Id = 16001623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[16001624] = {
		RandomWeight = 30,
		Id = 16001624,
		SubstituteAction = 16001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16001635,
			16001632
		}
	},
	[16001625] = {
		RandomWeight = 30,
		Id = 16001625,
		SubstituteAction = 16001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16001661
		}
	},
	[16001626] = {
		RandomWeight = 30,
		Id = 16001626,
		SubstituteAction = 16001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16001662
		}
	},
	[16001701] = {
		RandomWeight = 30,
		Id = 16001701,
		SubstituteAction = 16001503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16001603,
			16001604
		}
	},
	[16001702] = {
		RandomWeight = 10,
		Id = 16001702,
		SubstituteAction = 16001504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16001613,
			16001614
		}
	},
	[16001711] = {
		SubstituteAction = 16001513,
		RandomWeight = 10,
		Id = 16001711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[16001712] = {
		RandomWeight = 10,
		Id = 16001712,
		SubstituteAction = 16001514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			16001631,
			16001632
		}
	},
	[16001713] = {
		RandomWeight = 10,
		Id = 16001713,
		SubstituteAction = 16001513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			16001635,
			16001624
		}
	},
	[16001714] = {
		RandomWeight = 10,
		Id = 16001714,
		SubstituteAction = 16001514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			16001635,
			16001632
		}
	},
	[16000541] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000541,
		SubstituteAction = 16000543,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000600,
			16000601,
			16000602,
			16000603,
			16000704
		}
	},
	[16000542] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000542,
		SubstituteAction = 16000544,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000610,
			16000611,
			16000612,
			16000713,
			16000714
		}
	},
	[16000543] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000543,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000605,
			16000706
		}
	},
	[16000544] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000544,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000615,
			16000716
		}
	},
	[16000551] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000551,
		SubstituteAction = 16000553,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000620,
			16000721,
			16000722
		}
	},
	[16000552] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000552,
		SubstituteAction = 16000554,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000630,
			16000731,
			16000732
		}
	},
	[16000553] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000553,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000623,
			16000724
		}
	},
	[16000554] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000554,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000633,
			16000734
		}
	},
	[16000561] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000561,
		SubstituteAction = 16000553,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000620,
			16000625,
			16000724
		}
	},
	[16000562] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 16000562,
		SubstituteAction = 16000554,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000630,
			16000635,
			16000734
		}
	},
	[16000641] = {
		Id = 16000641,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16000642] = {
		RandomWeight = 10,
		Id = 16000642,
		SubstituteAction = 16000645,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000100,
			16000740
		}
	},
	[16000643] = {
		Id = 16000643,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[16000644] = {
		RandomWeight = 30,
		Id = 16000644,
		SubstituteAction = 16000645,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000100,
			16000742
		}
	},
	[16000645] = {
		Id = 16000645,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000641
		}
	},
	[16000646] = {
		Id = 16000646,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000643
		}
	},
	[16000647] = {
		RandomWeight = 10,
		Id = 16000647,
		SubstituteAction = 16000645,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000640
		}
	},
	[16000648] = {
		RandomWeight = 30,
		Id = 16000648,
		SubstituteAction = 16000645,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			16000642
		}
	},
	[16000651] = {
		Id = 16000651,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000652] = {
		RandomWeight = 30,
		Id = 16000652,
		SubstituteAction = 16000655,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000100,
			16000750,
			16000751
		}
	},
	[16000653] = {
		Id = 16000653,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000654] = {
		RandomWeight = 30,
		Id = 16000654,
		SubstituteAction = 16000656,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000100,
			16000752,
			16000753
		}
	},
	[16000655] = {
		Id = 16000655,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000651
		}
	},
	[16000656] = {
		Id = 16000656,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			16000653
		}
	},
	[16000657] = {
		RandomWeight = 30,
		Id = 16000657,
		SubstituteAction = 16000655,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000750,
			16000751
		}
	},
	[16000658] = {
		RandomWeight = 30,
		Id = 16000658,
		SubstituteAction = 16000656,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			16000752,
			16000753
		}
	},
	[16000661] = {
		Id = 16000661,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000662] = {
		RandomWeight = 30,
		Id = 16000662,
		SubstituteAction = 16000655,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000724
		}
	},
	[16000663] = {
		Id = 16000663,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[16000664] = {
		RandomWeight = 30,
		Id = 16000664,
		SubstituteAction = 16000656,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000732
		}
	},
	[16000665] = {
		RandomWeight = 30,
		Id = 16000665,
		SubstituteAction = 16000655,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000761
		}
	},
	[16000666] = {
		RandomWeight = 30,
		Id = 16000666,
		SubstituteAction = 16000656,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			16000762
		}
	},
	[16000741] = {
		RandomWeight = 30,
		Id = 16000741,
		SubstituteAction = 16000543,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000603,
			16000704
		}
	},
	[16000742] = {
		RandomWeight = 10,
		Id = 16000742,
		SubstituteAction = 16000544,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000713,
			16000714
		}
	},
	[16000751] = {
		SubstituteAction = 16000553,
		RandomWeight = 10,
		Id = 16000751,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[16000752] = {
		RandomWeight = 10,
		Id = 16000752,
		SubstituteAction = 16000554,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			16000731,
			16000732
		}
	},
	[16000753] = {
		RandomWeight = 10,
		Id = 16000753,
		SubstituteAction = 16000553,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000724
		}
	},
	[16000754] = {
		RandomWeight = 10,
		Id = 16000754,
		SubstituteAction = 16000554,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			16000635,
			16000732
		}
	},
	[16000801] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 16000801,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			16000810
		}
	},
	[16000802] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 16000802,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			16000810
		}
	},
	[16000803] = {
		Id = 16000803,
		RandomWeight = 80,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			16000814,
			16000811,
			16000812
		}
	},
	[16000804] = {
		Id = 16000804,
		RandomWeight = 80,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			16000824,
			16000821,
			16000822
		}
	},
	[16000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 16000805,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			16000833,
			16000830,
			16000831,
			16000832
		}
	},
	[16000901] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 16000901,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			16000910,
			16000911,
			16000912,
			16000913
		}
	},
	[16000902] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 16000902,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			16000920,
			16000921,
			16000922,
			16000923
		}
	},
	[16005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 16005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[16005002] = {
		Id = 16005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			16000100,
			16000110,
			16000111,
			16000112,
			16000113,
			16000120
		}
	},
	[17000001] = {
		Id = 17000001,
		RandomWeight = 10,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			114
		}
	},
	[17000002] = {
		Id = 17000002,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			213
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[17000003] = {
		Id = 17000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103,
			213
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[17000004] = {
		Id = 17000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			17000010
		}
	},
	[17000005] = {
		Id = 17000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			17000020
		}
	},
	[17000006] = {
		Id = 17000006,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			203
		},
		ActionUnitIDList = {
			123,
			121,
			122
		}
	},
	[17000007] = {
		Id = 17000007,
		RandomWeight = 1000,
		ConditionIDList = {
			103,
			203
		},
		ActionUnitIDList = {
			123,
			121,
			122
		}
	},
	[17000008] = {
		Id = 17000008,
		RandomWeight = 10,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[17000009] = {
		Id = 17000009,
		RandomWeight = 10,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			100
		}
	},
	[17000010] = {
		Id = 17000010,
		RandomWeight = 10,
		ActionUnitIDList = {
			109
		}
	},
	[17000011] = {
		RandomWeight = 10,
		Id = 17000011,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000110,
			17000100,
			17000110,
			17000120
		}
	},
	[17000012] = {
		RandomWeight = 10,
		Id = 17000012,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000130
		}
	},
	[17000013] = {
		RandomWeight = 10,
		Id = 17000013,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000110,
			17000100,
			17000110,
			17000131,
			17000100
		}
	},
	[17000021] = {
		RandomWeight = 20,
		Id = 17000021,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000111,
			17000100,
			17000111,
			17000120
		}
	},
	[17000022] = {
		RandomWeight = 20,
		Id = 17000022,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000112,
			17000100,
			17000112,
			17000120
		}
	},
	[17000023] = {
		RandomWeight = 20,
		Id = 17000023,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000113,
			17000100,
			17000113,
			17000120
		}
	},
	[17000024] = {
		RandomWeight = 20,
		Id = 17000024,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000140
		}
	},
	[17000025] = {
		RandomWeight = 20,
		Id = 17000025,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			17000110,
			17000100,
			17000110,
			17000141,
			17000100
		}
	},
	[17000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 17000026,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			17000150
		}
	},
	[17000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 17000031,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101,
			802
		},
		ActionUnitIDList = {
			17000151
		}
	},
	[17000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 17000041,
		SubstituteAction = 17000004,
		ConditionIDList = {
			101,
			822
		},
		ActionUnitIDList = {
			17000152
		}
	},
	[17000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 17000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			17000210
		}
	},
	[17000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 17000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			17000211
		}
	},
	[17000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 17000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			17000210
		}
	},
	[17000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 17000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			17000211
		}
	},
	[17000121] = {
		Id = 17000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[17000122] = {
		Id = 17000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[17000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 17000201,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000300,
			17000310
		}
	},
	[17000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 17000202,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000300,
			17000311
		}
	},
	[17000211] = {
		Id = 17000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[17000212] = {
		RandomWeight = 10,
		Id = 17000212,
		SubstituteAction = 17000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			17000320
		}
	},
	[17000213] = {
		Id = 17000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[17000214] = {
		RandomWeight = 60,
		Id = 17000214,
		SubstituteAction = 17000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			17000321
		}
	},
	[17000221] = {
		RandomWeight = 10,
		Id = 17000221,
		SubstituteAction = 17000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			17000310
		}
	},
	[17000222] = {
		RandomWeight = 20,
		Id = 17000222,
		SubstituteAction = 17000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			17000311
		}
	},
	[17000231] = {
		isDailyAction = true,
		Id = 17000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000330
		}
	},
	[17000232] = {
		isDailyAction = true,
		Id = 17000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000331
		}
	},
	[17000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 17000301,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000400,
			17000410
		}
	},
	[17000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 17000302,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000400,
			17000411
		}
	},
	[17000311] = {
		Id = 17000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[17000312] = {
		RandomWeight = 10,
		Id = 17000312,
		SubstituteAction = 17000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			17000420
		}
	},
	[17000313] = {
		Id = 17000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[17000314] = {
		RandomWeight = 60,
		Id = 17000314,
		SubstituteAction = 17000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			17000421
		}
	},
	[17000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000321,
		SubstituteAction = 17000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			17000410
		}
	},
	[17000322] = {
		RandomWeight = 20,
		Id = 17000322,
		SubstituteAction = 17000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			17000411
		}
	},
	[17000331] = {
		isDailyAction = true,
		Id = 17000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000430
		}
	},
	[17000332] = {
		isDailyAction = true,
		Id = 17000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000431
		}
	},
	[17000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 17000401,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000500,
			17000510
		}
	},
	[17000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 17000402,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000500,
			17000511
		}
	},
	[17000411] = {
		Id = 17000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[17000412] = {
		RandomWeight = 10,
		Id = 17000412,
		SubstituteAction = 17000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			17000520
		}
	},
	[17000413] = {
		Id = 17000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[17000414] = {
		RandomWeight = 60,
		Id = 17000414,
		SubstituteAction = 17000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			17000521
		}
	},
	[17000421] = {
		RandomWeight = 10,
		Id = 17000421,
		SubstituteAction = 17000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			17000510
		}
	},
	[17000422] = {
		RandomWeight = 20,
		Id = 17000422,
		SubstituteAction = 17000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			17000511
		}
	},
	[17000431] = {
		isDailyAction = true,
		Id = 17000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000530
		}
	},
	[17000432] = {
		isDailyAction = true,
		Id = 17000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000531
		}
	},
	[17000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000501,
		SubstituteAction = 17000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000600,
			17000601,
			17000602,
			17000603,
			17000604
		}
	},
	[17000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000502,
		SubstituteAction = 17000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000610,
			17000611,
			17000612,
			17000613,
			17000614
		}
	},
	[17000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000605,
			17000606
		}
	},
	[17000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000615,
			17000616
		}
	},
	[17000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000511,
		SubstituteAction = 17000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			17000620,
			17000621,
			17000622
		}
	},
	[17000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000512,
		SubstituteAction = 17000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			17000630,
			17000631,
			17000632
		}
	},
	[17000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			17000623,
			17000624
		}
	},
	[17000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			17000633,
			17000634
		}
	},
	[17000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000521,
		SubstituteAction = 17000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			17000620,
			17000625,
			17000624
		}
	},
	[17000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 17000522,
		SubstituteAction = 17000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			17000630,
			17000635,
			17000634
		}
	},
	[17000601] = {
		Id = 17000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[17000602] = {
		RandomWeight = 10,
		Id = 17000602,
		SubstituteAction = 17000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000100,
			17000640
		}
	},
	[17000603] = {
		Id = 17000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[17000604] = {
		RandomWeight = 30,
		Id = 17000604,
		SubstituteAction = 17000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000100,
			17000642
		}
	},
	[17000605] = {
		Id = 17000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000641
		}
	},
	[17000606] = {
		Id = 17000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000643
		}
	},
	[17000607] = {
		RandomWeight = 10,
		Id = 17000607,
		SubstituteAction = 17000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000640
		}
	},
	[17000608] = {
		RandomWeight = 30,
		Id = 17000608,
		SubstituteAction = 17000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			17000642
		}
	},
	[17000611] = {
		Id = 17000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[17000612] = {
		RandomWeight = 30,
		Id = 17000612,
		SubstituteAction = 17000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			17000100,
			17000650,
			17000651
		}
	},
	[17000613] = {
		Id = 17000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[17000614] = {
		RandomWeight = 30,
		Id = 17000614,
		SubstituteAction = 17000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			17000100,
			17000652,
			17000653
		}
	},
	[17000615] = {
		Id = 17000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			17000651
		}
	},
	[17000616] = {
		Id = 17000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			17000653
		}
	},
	[17000617] = {
		RandomWeight = 30,
		Id = 17000617,
		SubstituteAction = 17000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			17000650,
			17000651
		}
	},
	[17000618] = {
		RandomWeight = 30,
		Id = 17000618,
		SubstituteAction = 17000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			17000652,
			17000653
		}
	},
	[17000621] = {
		Id = 17000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[17000622] = {
		RandomWeight = 30,
		Id = 17000622,
		SubstituteAction = 17000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			17000635,
			17000624
		}
	},
	[17000623] = {
		Id = 17000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[17000624] = {
		RandomWeight = 30,
		Id = 17000624,
		SubstituteAction = 17000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			17000635,
			17000632
		}
	},
	[17000625] = {
		RandomWeight = 30,
		Id = 17000625,
		SubstituteAction = 17000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			17000661
		}
	},
	[17000626] = {
		RandomWeight = 30,
		Id = 17000626,
		SubstituteAction = 17000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			17000662
		}
	},
	[17000701] = {
		RandomWeight = 30,
		Id = 17000701,
		SubstituteAction = 17000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			17000603,
			17000604
		}
	},
	[17000702] = {
		RandomWeight = 10,
		Id = 17000702,
		SubstituteAction = 17000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			17000613,
			17000614
		}
	},
	[17000711] = {
		SubstituteAction = 17000513,
		RandomWeight = 10,
		Id = 17000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[17000712] = {
		RandomWeight = 10,
		Id = 17000712,
		SubstituteAction = 17000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			17000631,
			17000632
		}
	},
	[17000713] = {
		RandomWeight = 10,
		Id = 17000713,
		SubstituteAction = 17000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			17000635,
			17000624
		}
	},
	[17000714] = {
		RandomWeight = 10,
		Id = 17000714,
		SubstituteAction = 17000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			17000635,
			17000632
		}
	},
	[17000803] = {
		isDailyAction = true,
		RandomWeight = 40,
		Id = 17000803,
		SubstituteAction = 17000005,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			17000810,
			17000811,
			17000812,
			17000813
		}
	},
	[17000804] = {
		isDailyAction = true,
		RandomWeight = 80,
		Id = 17000804,
		SubstituteAction = 17000005,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			17000810,
			17000811,
			17000812,
			17000813
		}
	},
	[17000805] = {
		RandomWeight = 80,
		isDailyAction = true,
		Id = 17000805,
		SubstituteAction = 17000005,
		ActionUnitIDList = {
			17000820,
			17000821,
			17000822,
			17000823
		}
	},
	[17000806] = {
		Id = 17000806,
		SubstituteAction = 17000005,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000824
		}
	},
	[17000807] = {
		Id = 17000807,
		SubstituteAction = 17000005,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000825
		}
	},
	[17000808] = {
		Id = 17000808,
		SubstituteAction = 17000005,
		RandomWeight = 10,
		ActionUnitIDList = {
			17000826,
			17000827
		}
	},
	[17000809] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 17000809,
		SubstituteAction = 17000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			17000830,
			17000831
		}
	},
	[17000810] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 17000810,
		SubstituteAction = 17000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			17000840,
			17000841,
			17000842
		}
	},
	[17000901] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 17000901,
		SubstituteAction = 17000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			17000910,
			17000911,
			17000912,
			17000913
		}
	},
	[17000902] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 17000902,
		SubstituteAction = 17000005,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			17000920,
			17000921,
			17000922,
			17000923
		}
	},
	[17005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 17005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[17005002] = {
		Id = 17005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			17000100,
			17000110,
			17000111,
			17000112,
			17000113,
			17000120
		}
	},
	[18000001] = {
		Id = 18000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[18000002] = {
		Id = 18000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[18000003] = {
		Id = 18000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[18000004] = {
		Id = 18000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			18000010
		}
	},
	[18000005] = {
		Id = 18000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			18000020
		}
	},
	[18000006] = {
		Id = 18000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			102
		}
	},
	[18000007] = {
		Id = 18000007,
		RandomWeight = 10,
		ActionUnitIDList = {
			111
		}
	},
	[18000008] = {
		Id = 18000008,
		RandomWeight = 10,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			111
		}
	},
	[18000009] = {
		Id = 18000009,
		RandomWeight = 10,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			106
		}
	},
	[18000011] = {
		RandomWeight = 10,
		Id = 18000011,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000110,
			18000100,
			18000110,
			18000120
		}
	},
	[18000012] = {
		RandomWeight = 10,
		Id = 18000012,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000130
		}
	},
	[18000013] = {
		RandomWeight = 10,
		Id = 18000013,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000110,
			18000100,
			18000110,
			18000131,
			18000100
		}
	},
	[18000021] = {
		RandomWeight = 20,
		Id = 18000021,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000111,
			18000100,
			18000111,
			18000120
		}
	},
	[18000022] = {
		RandomWeight = 20,
		Id = 18000022,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000112,
			18000100,
			18000112,
			18000120
		}
	},
	[18000023] = {
		RandomWeight = 20,
		Id = 18000023,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000113,
			18000100,
			18000113,
			18000120
		}
	},
	[18000024] = {
		RandomWeight = 20,
		Id = 18000024,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000140
		}
	},
	[18000025] = {
		RandomWeight = 20,
		Id = 18000025,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			18000110,
			18000100,
			18000110,
			18000141,
			18000100
		}
	},
	[18000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 18000026,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			18000150
		}
	},
	[18000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000031,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101,
			821
		},
		ActionUnitIDList = {
			18000151
		}
	},
	[18000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000041,
		SubstituteAction = 18000004,
		ConditionIDList = {
			101,
			820
		},
		ActionUnitIDList = {
			18000152
		}
	},
	[18000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 18000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			18000210
		}
	},
	[18000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 18000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			18000211
		}
	},
	[18000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 18000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			18000210
		}
	},
	[18000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 18000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			18000211
		}
	},
	[18000121] = {
		Id = 18000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[18000122] = {
		Id = 18000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[18000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 18000201,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000300,
			18000310
		}
	},
	[18000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 18000202,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000300,
			18000311
		}
	},
	[18000211] = {
		Id = 18000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[18000212] = {
		RandomWeight = 10,
		Id = 18000212,
		SubstituteAction = 18000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			18000320
		}
	},
	[18000213] = {
		Id = 18000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[18000214] = {
		RandomWeight = 60,
		Id = 18000214,
		SubstituteAction = 18000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			18000321
		}
	},
	[18000221] = {
		RandomWeight = 10,
		Id = 18000221,
		SubstituteAction = 18000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			18000310
		}
	},
	[18000222] = {
		RandomWeight = 20,
		Id = 18000222,
		SubstituteAction = 18000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			18000311
		}
	},
	[18000231] = {
		isDailyAction = true,
		Id = 18000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000330
		}
	},
	[18000232] = {
		isDailyAction = true,
		Id = 18000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000331
		}
	},
	[18000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 18000301,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000400,
			18000410
		}
	},
	[18000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 18000302,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000400,
			18000411
		}
	},
	[18000311] = {
		Id = 18000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[18000312] = {
		RandomWeight = 10,
		Id = 18000312,
		SubstituteAction = 18000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			18000420
		}
	},
	[18000313] = {
		Id = 18000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[18000314] = {
		RandomWeight = 60,
		Id = 18000314,
		SubstituteAction = 18000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			18000421
		}
	},
	[18000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000321,
		SubstituteAction = 18000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			18000410
		}
	},
	[18000322] = {
		RandomWeight = 20,
		Id = 18000322,
		SubstituteAction = 18000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			18000411
		}
	},
	[18000331] = {
		isDailyAction = true,
		Id = 18000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000430
		}
	},
	[18000332] = {
		isDailyAction = true,
		Id = 18000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000431
		}
	},
	[18000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 18000401,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000500,
			18000510
		}
	},
	[18000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 18000402,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000500,
			18000511
		}
	},
	[18000411] = {
		Id = 18000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[18000412] = {
		RandomWeight = 10,
		Id = 18000412,
		SubstituteAction = 18000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			18000520
		}
	},
	[18000413] = {
		Id = 18000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[18000414] = {
		RandomWeight = 60,
		Id = 18000414,
		SubstituteAction = 18000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			18000521
		}
	},
	[18000421] = {
		RandomWeight = 10,
		Id = 18000421,
		SubstituteAction = 18000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			18000510
		}
	},
	[18000422] = {
		RandomWeight = 20,
		Id = 18000422,
		SubstituteAction = 18000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			18000511
		}
	},
	[18000431] = {
		isDailyAction = true,
		Id = 18000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000530
		}
	},
	[18000432] = {
		isDailyAction = true,
		Id = 18000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000531
		}
	},
	[18000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000501,
		SubstituteAction = 18000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000600,
			18000601,
			18000602,
			18000603,
			18000604
		}
	},
	[18000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000502,
		SubstituteAction = 18000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000610,
			18000611,
			18000612,
			18000613,
			18000614
		}
	},
	[18000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000605,
			18000606
		}
	},
	[18000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000615,
			18000616
		}
	},
	[18000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000511,
		SubstituteAction = 18000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			18000620,
			18000621,
			18000622
		}
	},
	[18000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000512,
		SubstituteAction = 18000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			18000630,
			18000631,
			18000632
		}
	},
	[18000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			18000623,
			18000624
		}
	},
	[18000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			18000633,
			18000634
		}
	},
	[18000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000521,
		SubstituteAction = 18000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			18000620,
			18000625,
			18000624
		}
	},
	[18000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 18000522,
		SubstituteAction = 18000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			18000630,
			18000635,
			18000634
		}
	},
	[18000601] = {
		Id = 18000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[18000602] = {
		RandomWeight = 10,
		Id = 18000602,
		SubstituteAction = 18000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000100,
			18000640
		}
	},
	[18000603] = {
		Id = 18000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[18000604] = {
		RandomWeight = 30,
		Id = 18000604,
		SubstituteAction = 18000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000100,
			18000642
		}
	},
	[18000605] = {
		Id = 18000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000641
		}
	},
	[18000606] = {
		Id = 18000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000643
		}
	},
	[18000607] = {
		RandomWeight = 10,
		Id = 18000607,
		SubstituteAction = 18000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000640
		}
	},
	[18000608] = {
		RandomWeight = 30,
		Id = 18000608,
		SubstituteAction = 18000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			18000642
		}
	},
	[18000611] = {
		Id = 18000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[18000612] = {
		RandomWeight = 30,
		Id = 18000612,
		SubstituteAction = 18000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			18000100,
			18000650,
			18000651
		}
	},
	[18000613] = {
		Id = 18000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[18000614] = {
		RandomWeight = 30,
		Id = 18000614,
		SubstituteAction = 18000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			18000100,
			18000652,
			18000653
		}
	},
	[18000615] = {
		Id = 18000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			18000651
		}
	},
	[18000616] = {
		Id = 18000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			18000653
		}
	},
	[18000617] = {
		RandomWeight = 30,
		Id = 18000617,
		SubstituteAction = 18000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			18000650,
			18000651
		}
	},
	[18000618] = {
		RandomWeight = 30,
		Id = 18000618,
		SubstituteAction = 18000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			18000652,
			18000653
		}
	},
	[18000621] = {
		Id = 18000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[18000622] = {
		RandomWeight = 30,
		Id = 18000622,
		SubstituteAction = 18000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			18000635,
			18000624
		}
	},
	[18000623] = {
		Id = 18000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[18000624] = {
		RandomWeight = 30,
		Id = 18000624,
		SubstituteAction = 18000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			18000635,
			18000632
		}
	},
	[18000625] = {
		RandomWeight = 30,
		Id = 18000625,
		SubstituteAction = 18000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			18000661
		}
	},
	[18000626] = {
		RandomWeight = 30,
		Id = 18000626,
		SubstituteAction = 18000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			18000662
		}
	},
	[18000701] = {
		RandomWeight = 30,
		Id = 18000701,
		SubstituteAction = 18000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			18000603,
			18000604
		}
	},
	[18000702] = {
		RandomWeight = 10,
		Id = 18000702,
		SubstituteAction = 18000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			18000613,
			18000614
		}
	},
	[18000711] = {
		SubstituteAction = 18000513,
		RandomWeight = 10,
		Id = 18000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[18000712] = {
		RandomWeight = 10,
		Id = 18000712,
		SubstituteAction = 18000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			18000631,
			18000632
		}
	},
	[18000713] = {
		RandomWeight = 10,
		Id = 18000713,
		SubstituteAction = 18000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			18000635,
			18000624
		}
	},
	[18000714] = {
		RandomWeight = 10,
		Id = 18000714,
		SubstituteAction = 18000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			18000635,
			18000632
		}
	},
	[18000803] = {
		RandomWeight = 50,
		isDailyAction = true,
		Id = 18000803,
		SubstituteAction = 18000005,
		ActionUnitIDList = {
			18000810,
			18000811,
			18000812,
			18000813
		}
	},
	[18000804] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000804,
		SubstituteAction = 18000005,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			18000820,
			18000821,
			18000822,
			18000823
		}
	},
	[18000806] = {
		Id = 18000806,
		SubstituteAction = 18000005,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000810,
			18000814
		}
	},
	[18000807] = {
		Id = 18000807,
		SubstituteAction = 18000005,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000810,
			18000815
		}
	},
	[18000808] = {
		Id = 18000808,
		SubstituteAction = 18000005,
		RandomWeight = 10,
		ActionUnitIDList = {
			18000810,
			18000816
		}
	},
	[18000809] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000809,
		SubstituteAction = 18000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			18000830,
			18000831,
			18000832,
			18000833
		}
	},
	[18000810] = {
		RandomWeight = 10,
		Id = 18000810,
		SubstituteAction = 18000005,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[18000811] = {
		RandomWeight = 1000,
		Id = 18000811,
		SubstituteAction = 18000005,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[18000812] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000812,
		SubstituteAction = 18000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			18000840,
			18000841,
			18000842,
			18000843
		}
	},
	[18000813] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000813,
		SubstituteAction = 18000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			18000850,
			18000851,
			18000852,
			18000853
		}
	},
	[18000901] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000901,
		SubstituteAction = 18000005,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			18000910,
			18000911,
			18000912,
			18000913
		}
	},
	[18000902] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 18000902,
		SubstituteAction = 18000005,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			18000920,
			18000921,
			18000922,
			18000923
		}
	},
	[18005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 18005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[18005002] = {
		Id = 18005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			18000100,
			18000110,
			18000111,
			18000112,
			18000113,
			18000120
		}
	},
	[19000001] = {
		Id = 19000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			111
		}
	},
	[19000002] = {
		Id = 19000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[19000003] = {
		Id = 19000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[19000004] = {
		Id = 19000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			19000010
		}
	},
	[19000005] = {
		Id = 19000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			19000020
		}
	},
	[19000006] = {
		Id = 19000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			102
		}
	},
	[19000007] = {
		Id = 19000007,
		RandomWeight = 10,
		ActionUnitIDList = {
			114
		}
	},
	[19000008] = {
		Id = 19000008,
		RandomWeight = 10,
		ActionUnitIDList = {
			105
		}
	},
	[19000009] = {
		Id = 19000009,
		RandomWeight = 1000,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[19000010] = {
		Id = 19000010,
		RandomWeight = 1000,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			114
		}
	},
	[19000011] = {
		RandomWeight = 10,
		Id = 19000011,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000110,
			19000100,
			19000110,
			19000120
		}
	},
	[19000012] = {
		RandomWeight = 10,
		Id = 19000012,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000130
		}
	},
	[19000013] = {
		RandomWeight = 10,
		Id = 19000013,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000110,
			19000100,
			19000110,
			19000131,
			19000100
		}
	},
	[19000021] = {
		RandomWeight = 20,
		Id = 19000021,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000111,
			19000100,
			19000111,
			19000120
		}
	},
	[19000022] = {
		RandomWeight = 20,
		Id = 19000022,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000112,
			19000100,
			19000112,
			19000120
		}
	},
	[19000023] = {
		RandomWeight = 20,
		Id = 19000023,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000113,
			19000100,
			19000113,
			19000120
		}
	},
	[19000024] = {
		RandomWeight = 20,
		Id = 19000024,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000140
		}
	},
	[19000025] = {
		RandomWeight = 20,
		Id = 19000025,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			19000110,
			19000100,
			19000110,
			19000141,
			19000100
		}
	},
	[19000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 19000026,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			19000150
		}
	},
	[19000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 19000031,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101,
			804
		},
		ActionUnitIDList = {
			19000151
		}
	},
	[19000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 19000041,
		SubstituteAction = 19000004,
		ConditionIDList = {
			101,
			825
		},
		ActionUnitIDList = {
			19000152
		}
	},
	[19000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 19000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			19000210
		}
	},
	[19000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 19000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			19000211
		}
	},
	[19000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 19000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			19000210
		}
	},
	[19000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 19000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			19000211
		}
	},
	[19000121] = {
		Id = 19000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[19000122] = {
		Id = 19000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[19000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 19000201,
		SubstituteAction = 19000005,
		ActionUnitIDList = {
			19000300,
			19000310
		}
	},
	[19000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 19000202,
		SubstituteAction = 19000005,
		ActionUnitIDList = {
			19000300,
			19000311
		}
	},
	[19000211] = {
		Id = 19000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[19000212] = {
		RandomWeight = 10,
		Id = 19000212,
		SubstituteAction = 19000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			19000320
		}
	},
	[19000213] = {
		Id = 19000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[19000214] = {
		RandomWeight = 60,
		Id = 19000214,
		SubstituteAction = 19000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			19000321
		}
	},
	[19000221] = {
		RandomWeight = 10,
		Id = 19000221,
		SubstituteAction = 19000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			19000310
		}
	},
	[19000222] = {
		RandomWeight = 20,
		Id = 19000222,
		SubstituteAction = 19000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			19000311
		}
	},
	[19000231] = {
		isDailyAction = true,
		Id = 19000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000330
		}
	},
	[19000232] = {
		isDailyAction = true,
		Id = 19000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000331
		}
	},
	[19000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 19000301,
		SubstituteAction = 19000005,
		ActionUnitIDList = {
			19000400,
			19000410
		}
	},
	[19000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 19000302,
		SubstituteAction = 19000005,
		ActionUnitIDList = {
			19000400,
			19000411
		}
	},
	[19000311] = {
		Id = 19000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[19000312] = {
		RandomWeight = 10,
		Id = 19000312,
		SubstituteAction = 19000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			19000420
		}
	},
	[19000313] = {
		Id = 19000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[19000314] = {
		RandomWeight = 60,
		Id = 19000314,
		SubstituteAction = 19000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			19000421
		}
	},
	[19000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000321,
		SubstituteAction = 19000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			19000410
		}
	},
	[19000322] = {
		RandomWeight = 20,
		Id = 19000322,
		SubstituteAction = 19000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			19000411
		}
	},
	[19000331] = {
		isDailyAction = true,
		Id = 19000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000430
		}
	},
	[19000332] = {
		isDailyAction = true,
		Id = 19000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000431
		}
	},
	[19000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 19000401,
		SubstituteAction = 19000005,
		ActionUnitIDList = {
			19000500,
			19000510
		}
	},
	[19000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 19000402,
		SubstituteAction = 19000005,
		ActionUnitIDList = {
			19000500,
			19000511
		}
	},
	[19000411] = {
		Id = 19000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[19000412] = {
		RandomWeight = 10,
		Id = 19000412,
		SubstituteAction = 19000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			19000520
		}
	},
	[19000413] = {
		Id = 19000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[19000414] = {
		RandomWeight = 60,
		Id = 19000414,
		SubstituteAction = 19000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			19000521
		}
	},
	[19000421] = {
		RandomWeight = 10,
		Id = 19000421,
		SubstituteAction = 19000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			19000510
		}
	},
	[19000422] = {
		RandomWeight = 20,
		Id = 19000422,
		SubstituteAction = 19000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			19000511
		}
	},
	[19000431] = {
		isDailyAction = true,
		Id = 19000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000530
		}
	},
	[19000432] = {
		isDailyAction = true,
		Id = 19000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000531
		}
	},
	[19000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000501,
		SubstituteAction = 19000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000600,
			19000601,
			19000602,
			19000603,
			19000604
		}
	},
	[19000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000502,
		SubstituteAction = 19000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000610,
			19000611,
			19000612,
			19000613,
			19000614
		}
	},
	[19000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000605,
			19000606
		}
	},
	[19000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000615,
			19000616
		}
	},
	[19000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000511,
		SubstituteAction = 19000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			19000620,
			19000621,
			19000622
		}
	},
	[19000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000512,
		SubstituteAction = 19000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			19000630,
			19000631,
			19000632
		}
	},
	[19000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			19000623,
			19000624
		}
	},
	[19000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			19000633,
			19000634
		}
	},
	[19000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000521,
		SubstituteAction = 19000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			19000620,
			19000625,
			19000624
		}
	},
	[19000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 19000522,
		SubstituteAction = 19000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			19000630,
			19000635,
			19000634
		}
	},
	[19000601] = {
		Id = 19000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[19000602] = {
		RandomWeight = 10,
		Id = 19000602,
		SubstituteAction = 19000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000100,
			19000640
		}
	},
	[19000603] = {
		Id = 19000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[19000604] = {
		RandomWeight = 30,
		Id = 19000604,
		SubstituteAction = 19000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000100,
			19000642
		}
	},
	[19000605] = {
		Id = 19000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000641
		}
	},
	[19000606] = {
		Id = 19000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000643
		}
	},
	[19000607] = {
		RandomWeight = 10,
		Id = 19000607,
		SubstituteAction = 19000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000640
		}
	},
	[19000608] = {
		RandomWeight = 30,
		Id = 19000608,
		SubstituteAction = 19000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			19000642
		}
	},
	[19000611] = {
		Id = 19000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[19000612] = {
		RandomWeight = 30,
		Id = 19000612,
		SubstituteAction = 19000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			19000100,
			19000650,
			19000651
		}
	},
	[19000613] = {
		Id = 19000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[19000614] = {
		RandomWeight = 30,
		Id = 19000614,
		SubstituteAction = 19000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			19000100,
			19000652,
			19000653
		}
	},
	[19000615] = {
		Id = 19000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			19000651
		}
	},
	[19000616] = {
		Id = 19000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			19000653
		}
	},
	[19000617] = {
		RandomWeight = 30,
		Id = 19000617,
		SubstituteAction = 19000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			19000650,
			19000651
		}
	},
	[19000618] = {
		RandomWeight = 30,
		Id = 19000618,
		SubstituteAction = 19000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			19000652,
			19000653
		}
	},
	[19000621] = {
		Id = 19000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[19000622] = {
		RandomWeight = 30,
		Id = 19000622,
		SubstituteAction = 19000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			19000635,
			19000624
		}
	},
	[19000623] = {
		Id = 19000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[19000624] = {
		RandomWeight = 30,
		Id = 19000624,
		SubstituteAction = 19000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			19000635,
			19000632
		}
	},
	[19000625] = {
		RandomWeight = 30,
		Id = 19000625,
		SubstituteAction = 19000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			19000661
		}
	},
	[19000626] = {
		RandomWeight = 30,
		Id = 19000626,
		SubstituteAction = 19000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			19000662
		}
	},
	[19000701] = {
		RandomWeight = 30,
		Id = 19000701,
		SubstituteAction = 19000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			19000603,
			19000604
		}
	},
	[19000702] = {
		RandomWeight = 10,
		Id = 19000702,
		SubstituteAction = 19000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			19000613,
			19000614
		}
	},
	[19000711] = {
		SubstituteAction = 19000513,
		RandomWeight = 10,
		Id = 19000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[19000712] = {
		RandomWeight = 10,
		Id = 19000712,
		SubstituteAction = 19000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			19000631,
			19000632
		}
	},
	[19000713] = {
		RandomWeight = 10,
		Id = 19000713,
		SubstituteAction = 19000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			19000635,
			19000624
		}
	},
	[19000714] = {
		RandomWeight = 10,
		Id = 19000714,
		SubstituteAction = 19000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			19000635,
			19000632
		}
	},
	[19000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 19000803,
		SubstituteAction = 19000808,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000810,
			19000811,
			19000812,
			19000813
		}
	},
	[19000804] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 19000804,
		SubstituteAction = 19000808,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000820,
			19000821,
			19000822,
			19000823
		}
	},
	[19000805] = {
		RandomWeight = 10,
		Id = 19000805,
		SubstituteAction = 19000808,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000828,
			19000824,
			19000825
		}
	},
	[19000806] = {
		Id = 19000806,
		RandomWeight = 10,
		ConditionIDList = {
			203,
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[19000807] = {
		Id = 19000807,
		RandomWeight = 1000,
		ConditionIDList = {
			203,
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[19000808] = {
		Id = 19000808,
		RandomWeight = 10,
		ActionUnitIDList = {
			19000827,
			19000828
		}
	},
	[19000809] = {
		RandomWeight = 50,
		Id = 19000809,
		SubstituteAction = 19000811,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			19000830,
			19000831,
			19000832,
			19000833
		}
	},
	[19000810] = {
		RandomWeight = 50,
		Id = 19000810,
		SubstituteAction = 19000812,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			19000840,
			19000841,
			19000842,
			19000843
		}
	},
	[19000811] = {
		Id = 19000811,
		RandomWeight = 10,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			19000834,
			19000835
		}
	},
	[19000812] = {
		Id = 19000812,
		RandomWeight = 10,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			19000844,
			19000845
		}
	},
	[19000813] = {
		Id = 19000813,
		RandomWeight = 10,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			111
		}
	},
	[19000814] = {
		Id = 19000814,
		RandomWeight = 10,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[19000815] = {
		RandomWeight = 10000,
		Id = 19000815,
		SubstituteAction = 19000816,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000825
		}
	},
	[19000816] = {
		Id = 19000816,
		RandomWeight = 10000,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000826
		}
	},
	[19000901] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 19000901,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000910,
			19000911,
			19000912,
			19000913
		}
	},
	[19000902] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 19000902,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			19000920,
			19000921,
			19000922,
			19000923
		}
	},
	[19005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 19005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[19005002] = {
		Id = 19005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			19000100,
			19000110,
			19000111,
			19000112,
			19000113,
			19000120
		}
	},
	[20000001] = {
		Id = 20000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[20000002] = {
		Id = 20000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[20000003] = {
		Id = 20000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[20000004] = {
		Id = 20000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			20000010
		}
	},
	[20000005] = {
		Id = 20000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			20000020
		}
	},
	[20000006] = {
		Id = 20000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			106
		}
	},
	[20000007] = {
		Id = 20000007,
		RandomWeight = 10,
		ActionUnitIDList = {
			110
		}
	},
	[20000011] = {
		RandomWeight = 10,
		Id = 20000011,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000110,
			20000100,
			20000110,
			20000120
		}
	},
	[20000012] = {
		RandomWeight = 10,
		Id = 20000012,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000130
		}
	},
	[20000013] = {
		RandomWeight = 10,
		Id = 20000013,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000110,
			20000100,
			20000110,
			20000131,
			20000100
		}
	},
	[20000021] = {
		RandomWeight = 20,
		Id = 20000021,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000111,
			20000100,
			20000111,
			20000120
		}
	},
	[20000022] = {
		RandomWeight = 20,
		Id = 20000022,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000112,
			20000100,
			20000112,
			20000120
		}
	},
	[20000023] = {
		RandomWeight = 20,
		Id = 20000023,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000113,
			20000100,
			20000113,
			20000120
		}
	},
	[20000024] = {
		RandomWeight = 20,
		Id = 20000024,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000140
		}
	},
	[20000025] = {
		RandomWeight = 20,
		Id = 20000025,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			20000110,
			20000100,
			20000110,
			20000141,
			20000100
		}
	},
	[20000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 20000026,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			20000150
		}
	},
	[20000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 20000031,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			20000151
		}
	},
	[20000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 20000041,
		SubstituteAction = 20000004,
		ConditionIDList = {
			101,
			815
		},
		ActionUnitIDList = {
			20000152
		}
	},
	[20000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			20000210
		}
	},
	[20000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			20000211
		}
	},
	[20000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			20000210
		}
	},
	[20000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			20000211
		}
	},
	[20000121] = {
		Id = 20000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[20000122] = {
		Id = 20000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[20000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 20000201,
		SubstituteAction = 20000005,
		ActionUnitIDList = {
			20000300,
			20000310
		}
	},
	[20000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 20000202,
		SubstituteAction = 20000005,
		ActionUnitIDList = {
			20000300,
			20000311
		}
	},
	[20000211] = {
		Id = 20000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[20000212] = {
		RandomWeight = 10,
		Id = 20000212,
		SubstituteAction = 20000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			20000320
		}
	},
	[20000213] = {
		Id = 20000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[20000214] = {
		RandomWeight = 60,
		Id = 20000214,
		SubstituteAction = 20000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			20000321
		}
	},
	[20000221] = {
		RandomWeight = 10,
		Id = 20000221,
		SubstituteAction = 20000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			20000310
		}
	},
	[20000222] = {
		RandomWeight = 20,
		Id = 20000222,
		SubstituteAction = 20000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			20000311
		}
	},
	[20000231] = {
		isDailyAction = true,
		Id = 20000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			20000330
		}
	},
	[20000232] = {
		isDailyAction = true,
		Id = 20000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			20000331
		}
	},
	[20000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 20000301,
		SubstituteAction = 20000005,
		ActionUnitIDList = {
			20000400,
			20000410
		}
	},
	[20000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 20000302,
		SubstituteAction = 20000005,
		ActionUnitIDList = {
			20000400,
			20000411
		}
	},
	[20000311] = {
		Id = 20000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[20000312] = {
		RandomWeight = 10,
		Id = 20000312,
		SubstituteAction = 20000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			20000420
		}
	},
	[20000313] = {
		Id = 20000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[20000314] = {
		RandomWeight = 60,
		Id = 20000314,
		SubstituteAction = 20000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			20000421
		}
	},
	[20000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000321,
		SubstituteAction = 20000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			20000410
		}
	},
	[20000322] = {
		RandomWeight = 20,
		Id = 20000322,
		SubstituteAction = 20000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			20000411
		}
	},
	[20000331] = {
		isDailyAction = true,
		Id = 20000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			20000430
		}
	},
	[20000332] = {
		isDailyAction = true,
		Id = 20000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			20000431
		}
	},
	[20000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 20000401,
		SubstituteAction = 20000005,
		ActionUnitIDList = {
			20000500,
			20000510
		}
	},
	[20000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 20000402,
		SubstituteAction = 20000005,
		ActionUnitIDList = {
			20000500,
			20000511
		}
	},
	[20000411] = {
		Id = 20000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[20000412] = {
		RandomWeight = 10,
		Id = 20000412,
		SubstituteAction = 20000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			20000520
		}
	},
	[20000413] = {
		Id = 20000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[20000414] = {
		RandomWeight = 60,
		Id = 20000414,
		SubstituteAction = 20000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			20000521
		}
	},
	[20000421] = {
		RandomWeight = 10,
		Id = 20000421,
		SubstituteAction = 20000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			20000510
		}
	},
	[20000422] = {
		RandomWeight = 20,
		Id = 20000422,
		SubstituteAction = 20000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			20000511
		}
	},
	[20000431] = {
		isDailyAction = true,
		Id = 20000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			20000530
		}
	},
	[20000432] = {
		isDailyAction = true,
		Id = 20000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			20000531
		}
	},
	[20000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000501,
		SubstituteAction = 20000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000600,
			20000601,
			20000602,
			20000603,
			20000604
		}
	},
	[20000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000502,
		SubstituteAction = 20000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000610,
			20000611,
			20000612,
			20000613,
			20000614
		}
	},
	[20000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000605,
			20000606
		}
	},
	[20000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000615,
			20000616
		}
	},
	[20000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000511,
		SubstituteAction = 20000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			20000620,
			20000621,
			20000622
		}
	},
	[20000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000512,
		SubstituteAction = 20000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			20000630,
			20000631,
			20000632
		}
	},
	[20000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			20000623,
			20000624
		}
	},
	[20000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			20000633,
			20000634
		}
	},
	[20000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000521,
		SubstituteAction = 20000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			20000620,
			20000625,
			20000624
		}
	},
	[20000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 20000522,
		SubstituteAction = 20000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			20000630,
			20000635,
			20000634
		}
	},
	[20000601] = {
		Id = 20000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[20000602] = {
		RandomWeight = 10,
		Id = 20000602,
		SubstituteAction = 20000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000100,
			20000640
		}
	},
	[20000603] = {
		Id = 20000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[20000604] = {
		RandomWeight = 30,
		Id = 20000604,
		SubstituteAction = 20000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000100,
			20000642
		}
	},
	[20000605] = {
		Id = 20000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000641
		}
	},
	[20000606] = {
		Id = 20000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000643
		}
	},
	[20000607] = {
		RandomWeight = 10,
		Id = 20000607,
		SubstituteAction = 20000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000640
		}
	},
	[20000608] = {
		RandomWeight = 30,
		Id = 20000608,
		SubstituteAction = 20000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			20000642
		}
	},
	[20000611] = {
		Id = 20000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[20000612] = {
		RandomWeight = 30,
		Id = 20000612,
		SubstituteAction = 20000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			20000100,
			20000650,
			20000651
		}
	},
	[20000613] = {
		Id = 20000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[20000614] = {
		RandomWeight = 30,
		Id = 20000614,
		SubstituteAction = 20000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			20000100,
			20000652,
			20000653
		}
	},
	[20000615] = {
		Id = 20000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			20000651
		}
	},
	[20000616] = {
		Id = 20000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			20000653
		}
	},
	[20000617] = {
		RandomWeight = 30,
		Id = 20000617,
		SubstituteAction = 20000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			20000650,
			20000651
		}
	},
	[20000618] = {
		RandomWeight = 30,
		Id = 20000618,
		SubstituteAction = 20000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			20000652,
			20000653
		}
	},
	[20000621] = {
		Id = 20000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[20000622] = {
		RandomWeight = 30,
		Id = 20000622,
		SubstituteAction = 20000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			20000635,
			20000624
		}
	},
	[20000623] = {
		Id = 20000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[20000624] = {
		RandomWeight = 30,
		Id = 20000624,
		SubstituteAction = 20000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			20000635,
			20000632
		}
	},
	[20000625] = {
		RandomWeight = 30,
		Id = 20000625,
		SubstituteAction = 20000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			20000661
		}
	},
	[20000626] = {
		RandomWeight = 30,
		Id = 20000626,
		SubstituteAction = 20000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			20000662
		}
	},
	[20000701] = {
		RandomWeight = 30,
		Id = 20000701,
		SubstituteAction = 20000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			20000603,
			20000604
		}
	},
	[20000702] = {
		RandomWeight = 10,
		Id = 20000702,
		SubstituteAction = 20000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			20000613,
			20000614
		}
	},
	[20000711] = {
		SubstituteAction = 20000513,
		RandomWeight = 10,
		Id = 20000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[20000712] = {
		RandomWeight = 10,
		Id = 20000712,
		SubstituteAction = 20000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			20000631,
			20000632
		}
	},
	[20000713] = {
		RandomWeight = 10,
		Id = 20000713,
		SubstituteAction = 20000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			20000635,
			20000624
		}
	},
	[20000714] = {
		RandomWeight = 10,
		Id = 20000714,
		SubstituteAction = 20000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			20000635,
			20000632
		}
	},
	[20000803] = {
		isDailyAction = true,
		Id = 20000803,
		RandomWeight = 5,
		ActionUnitIDList = {
			20000810,
			20000811,
			20000812,
			20000813
		}
	},
	[20000804] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000804,
		SubstituteAction = 20000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			20000820,
			20000821
		}
	},
	[20000805] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000805,
		SubstituteAction = 20000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			20000830,
			20000831
		}
	},
	[20000806] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000806,
		SubstituteAction = 20000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			20000840,
			20000841
		}
	},
	[20000901] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000901,
		SubstituteAction = 20000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			20000910,
			20000911,
			20000912,
			20000913
		}
	},
	[20000902] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 20000902,
		SubstituteAction = 20000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			20000920,
			20000921,
			20000922,
			20000923
		}
	},
	[20005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 20005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[20005002] = {
		Id = 20005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			20000100,
			20000110,
			20000111,
			20000112,
			20000113,
			20000120
		}
	},
	[21000001] = {
		Id = 21000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[21000002] = {
		Id = 21000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[21000003] = {
		Id = 21000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[21000004] = {
		Id = 21000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			21000010
		}
	},
	[21000005] = {
		Id = 21000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			21000020
		}
	},
	[21000006] = {
		Id = 21000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			107
		}
	},
	[21000007] = {
		Id = 21000007,
		RandomWeight = 10,
		ActionUnitIDList = {
			106
		}
	},
	[21000011] = {
		RandomWeight = 10,
		Id = 21000011,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000110,
			21000100,
			21000110,
			21000120
		}
	},
	[21000012] = {
		RandomWeight = 10,
		Id = 21000012,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000130
		}
	},
	[21000013] = {
		RandomWeight = 10,
		Id = 21000013,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000110,
			21000100,
			21000110,
			21000131,
			21000100
		}
	},
	[21000021] = {
		RandomWeight = 20,
		Id = 21000021,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000111,
			21000100,
			21000111,
			21000120
		}
	},
	[21000022] = {
		RandomWeight = 20,
		Id = 21000022,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000112,
			21000100,
			21000112,
			21000120
		}
	},
	[21000023] = {
		RandomWeight = 20,
		Id = 21000023,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000113,
			21000100,
			21000113,
			21000120
		}
	},
	[21000024] = {
		RandomWeight = 20,
		Id = 21000024,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000140
		}
	},
	[21000025] = {
		RandomWeight = 20,
		Id = 21000025,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			21000110,
			21000100,
			21000110,
			21000141,
			21000100
		}
	},
	[21000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 21000026,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			21000150
		}
	},
	[21000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 21000031,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			21000151
		}
	},
	[21000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 21000041,
		SubstituteAction = 21000004,
		ConditionIDList = {
			101,
			819
		},
		ActionUnitIDList = {
			21000152
		}
	},
	[21000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 21000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			21000210
		}
	},
	[21000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 21000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			21000211
		}
	},
	[21000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 21000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			21000210
		}
	},
	[21000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 21000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			21000211
		}
	},
	[21000121] = {
		Id = 21000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[21000122] = {
		Id = 21000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[21000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 21000201,
		SubstituteAction = 21000005,
		ActionUnitIDList = {
			21000300,
			21000310
		}
	},
	[21000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 21000202,
		SubstituteAction = 21000005,
		ActionUnitIDList = {
			21000300,
			21000311
		}
	},
	[21000211] = {
		Id = 21000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[21000212] = {
		RandomWeight = 10,
		Id = 21000212,
		SubstituteAction = 21000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			21000320
		}
	},
	[21000213] = {
		Id = 21000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[21000214] = {
		RandomWeight = 60,
		Id = 21000214,
		SubstituteAction = 21000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			21000321
		}
	},
	[21000221] = {
		RandomWeight = 10,
		Id = 21000221,
		SubstituteAction = 21000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			21000310
		}
	},
	[21000222] = {
		RandomWeight = 20,
		Id = 21000222,
		SubstituteAction = 21000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			21000311
		}
	},
	[21000231] = {
		isDailyAction = true,
		Id = 21000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000330
		}
	},
	[21000232] = {
		isDailyAction = true,
		Id = 21000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000331
		}
	},
	[21000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 21000301,
		SubstituteAction = 21000005,
		ActionUnitIDList = {
			21000400,
			21000410
		}
	},
	[21000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 21000302,
		SubstituteAction = 21000005,
		ActionUnitIDList = {
			21000400,
			21000411
		}
	},
	[21000311] = {
		Id = 21000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[21000312] = {
		RandomWeight = 10,
		Id = 21000312,
		SubstituteAction = 21000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			21000420
		}
	},
	[21000313] = {
		Id = 21000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[21000314] = {
		RandomWeight = 60,
		Id = 21000314,
		SubstituteAction = 21000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			21000421
		}
	},
	[21000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000321,
		SubstituteAction = 21000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			21000410
		}
	},
	[21000322] = {
		RandomWeight = 20,
		Id = 21000322,
		SubstituteAction = 21000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			21000411
		}
	},
	[21000331] = {
		isDailyAction = true,
		Id = 21000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000430
		}
	},
	[21000332] = {
		isDailyAction = true,
		Id = 21000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000431
		}
	},
	[21000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 21000401,
		SubstituteAction = 21000005,
		ActionUnitIDList = {
			21000500,
			21000510
		}
	},
	[21000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 21000402,
		SubstituteAction = 21000005,
		ActionUnitIDList = {
			21000500,
			21000511
		}
	},
	[21000411] = {
		Id = 21000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[21000412] = {
		RandomWeight = 10,
		Id = 21000412,
		SubstituteAction = 21000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			21000520
		}
	},
	[21000413] = {
		Id = 21000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[21000414] = {
		RandomWeight = 60,
		Id = 21000414,
		SubstituteAction = 21000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			21000521
		}
	},
	[21000421] = {
		RandomWeight = 10,
		Id = 21000421,
		SubstituteAction = 21000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			21000510
		}
	},
	[21000422] = {
		RandomWeight = 20,
		Id = 21000422,
		SubstituteAction = 21000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			21000511
		}
	},
	[21000431] = {
		isDailyAction = true,
		Id = 21000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000530
		}
	},
	[21000432] = {
		isDailyAction = true,
		Id = 21000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000531
		}
	},
	[21000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000501,
		SubstituteAction = 21000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000600,
			21000601,
			21000602,
			21000603,
			21000604
		}
	},
	[21000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000502,
		SubstituteAction = 21000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000610,
			21000611,
			21000612,
			21000613,
			21000614
		}
	},
	[21000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000605,
			21000606
		}
	},
	[21000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000615,
			21000616
		}
	},
	[21000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000511,
		SubstituteAction = 21000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			21000620,
			21000621,
			21000622
		}
	},
	[21000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000512,
		SubstituteAction = 21000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			21000630,
			21000631,
			21000632
		}
	},
	[21000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			21000623,
			21000624
		}
	},
	[21000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			21000633,
			21000634
		}
	},
	[21000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000521,
		SubstituteAction = 21000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			21000620,
			21000625,
			21000624
		}
	},
	[21000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 21000522,
		SubstituteAction = 21000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			21000630,
			21000635,
			21000634
		}
	},
	[21000601] = {
		Id = 21000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[21000602] = {
		RandomWeight = 10,
		Id = 21000602,
		SubstituteAction = 21000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000100,
			21000640
		}
	},
	[21000603] = {
		Id = 21000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[21000604] = {
		RandomWeight = 30,
		Id = 21000604,
		SubstituteAction = 21000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000100,
			21000642
		}
	},
	[21000605] = {
		Id = 21000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000641
		}
	},
	[21000606] = {
		Id = 21000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000643
		}
	},
	[21000607] = {
		RandomWeight = 10,
		Id = 21000607,
		SubstituteAction = 21000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000640
		}
	},
	[21000608] = {
		RandomWeight = 30,
		Id = 21000608,
		SubstituteAction = 21000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			21000642
		}
	},
	[21000611] = {
		Id = 21000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[21000612] = {
		RandomWeight = 30,
		Id = 21000612,
		SubstituteAction = 21000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			21000100,
			21000650,
			21000651
		}
	},
	[21000613] = {
		Id = 21000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[21000614] = {
		RandomWeight = 30,
		Id = 21000614,
		SubstituteAction = 21000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			21000100,
			21000652,
			21000653
		}
	},
	[21000615] = {
		Id = 21000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			21000651
		}
	},
	[21000616] = {
		Id = 21000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			21000653
		}
	},
	[21000617] = {
		RandomWeight = 30,
		Id = 21000617,
		SubstituteAction = 21000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			21000650,
			21000651
		}
	},
	[21000618] = {
		RandomWeight = 30,
		Id = 21000618,
		SubstituteAction = 21000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			21000652,
			21000653
		}
	},
	[21000621] = {
		Id = 21000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[21000622] = {
		RandomWeight = 30,
		Id = 21000622,
		SubstituteAction = 21000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			21000635,
			21000624
		}
	},
	[21000623] = {
		Id = 21000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[21000624] = {
		RandomWeight = 30,
		Id = 21000624,
		SubstituteAction = 21000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			21000635,
			21000632
		}
	},
	[21000625] = {
		RandomWeight = 30,
		Id = 21000625,
		SubstituteAction = 21000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			21000661
		}
	},
	[21000626] = {
		RandomWeight = 30,
		Id = 21000626,
		SubstituteAction = 21000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			21000662
		}
	},
	[21000701] = {
		RandomWeight = 30,
		Id = 21000701,
		SubstituteAction = 21000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			21000603,
			21000604
		}
	},
	[21000702] = {
		RandomWeight = 10,
		Id = 21000702,
		SubstituteAction = 21000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			21000613,
			21000614
		}
	},
	[21000711] = {
		SubstituteAction = 21000513,
		RandomWeight = 10,
		Id = 21000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[21000712] = {
		RandomWeight = 10,
		Id = 21000712,
		SubstituteAction = 21000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			21000631,
			21000632
		}
	},
	[21000713] = {
		RandomWeight = 10,
		Id = 21000713,
		SubstituteAction = 21000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			21000635,
			21000624
		}
	},
	[21000714] = {
		RandomWeight = 10,
		Id = 21000714,
		SubstituteAction = 21000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			21000635,
			21000632
		}
	},
	[21000804] = {
		Id = 21000804,
		RandomWeight = 100,
		ActionUnitIDList = {
			21000820,
			21000821,
			21000822,
			21000823
		}
	},
	[21000805] = {
		Id = 21000805,
		SubstituteAction = 21000806,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000810,
			21000814,
			21000812,
			21000813
		}
	},
	[21000806] = {
		Id = 21000806,
		RandomWeight = 10,
		ActionUnitIDList = {
			21000814,
			21000815
		}
	},
	[21000807] = {
		isDailyAction = true,
		Id = 21000807,
		RandomWeight = 50,
		ActionUnitIDList = {
			21000831,
			21000832,
			21000833
		}
	},
	[21000808] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 21000808,
		SubstituteAction = 21000806,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			21000841,
			21000842,
			21000843
		}
	},
	[21000809] = {
		RandomWeight = 10000,
		Id = 21000809,
		SubstituteAction = 21000810,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			21000850
		}
	},
	[21000810] = {
		Id = 21000810,
		RandomWeight = 10000,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			21000851
		}
	},
	[21000901] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 21000901,
		SubstituteAction = 21000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			21000910,
			21000911,
			21000912,
			21000913
		}
	},
	[21000902] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 21000902,
		SubstituteAction = 21000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			21000920,
			21000921,
			21000922,
			21000923
		}
	},
	[21005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 21005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[21005002] = {
		Id = 21005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			21000100,
			21000110,
			21000111,
			21000112,
			21000113,
			21000120
		}
	},
	[22000001] = {
		Id = 22000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			106
		}
	},
	[22000002] = {
		Id = 22000002,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			213
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[22000003] = {
		Id = 22000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103,
			213
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[22000004] = {
		Id = 22000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			22000010
		}
	},
	[22000005] = {
		Id = 22000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			22000020
		}
	},
	[22000006] = {
		Id = 22000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			107
		}
	},
	[22000007] = {
		Id = 22000007,
		RandomWeight = 10,
		ActionUnitIDList = {
			104
		}
	},
	[22000008] = {
		Id = 22000008,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			114
		}
	},
	[22000011] = {
		RandomWeight = 10,
		Id = 22000011,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000110,
			22000100,
			22000110,
			22000120
		}
	},
	[22000012] = {
		RandomWeight = 10,
		Id = 22000012,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000130
		}
	},
	[22000013] = {
		RandomWeight = 10,
		Id = 22000013,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000110,
			22000100,
			22000110,
			22000131,
			22000100
		}
	},
	[22000021] = {
		RandomWeight = 20,
		Id = 22000021,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000111,
			22000100,
			22000111,
			22000120
		}
	},
	[22000022] = {
		RandomWeight = 20,
		Id = 22000022,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000112,
			22000100,
			22000112,
			22000120
		}
	},
	[22000023] = {
		RandomWeight = 20,
		Id = 22000023,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000113,
			22000100,
			22000113,
			22000120
		}
	},
	[22000024] = {
		RandomWeight = 20,
		Id = 22000024,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000140
		}
	},
	[22000025] = {
		RandomWeight = 20,
		Id = 22000025,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			22000110,
			22000100,
			22000110,
			22000141,
			22000100
		}
	},
	[22000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 22000026,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			22000150
		}
	},
	[22000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 22000031,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101,
			815
		},
		ActionUnitIDList = {
			22000151
		}
	},
	[22000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 22000041,
		SubstituteAction = 22000004,
		ConditionIDList = {
			101,
			824
		},
		ActionUnitIDList = {
			22000152
		}
	},
	[22000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 22000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			22000210
		}
	},
	[22000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 22000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			22000211
		}
	},
	[22000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 22000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			22000210
		}
	},
	[22000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 22000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			22000211
		}
	},
	[22000121] = {
		Id = 22000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[22000122] = {
		Id = 22000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[22000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 22000201,
		SubstituteAction = 22000005,
		ActionUnitIDList = {
			22000300,
			22000310
		}
	},
	[22000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 22000202,
		SubstituteAction = 22000005,
		ActionUnitIDList = {
			22000300,
			22000311
		}
	},
	[22000211] = {
		Id = 22000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[22000212] = {
		RandomWeight = 10,
		Id = 22000212,
		SubstituteAction = 22000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			22000320
		}
	},
	[22000213] = {
		Id = 22000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[22000214] = {
		RandomWeight = 60,
		Id = 22000214,
		SubstituteAction = 22000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			22000321
		}
	},
	[22000221] = {
		RandomWeight = 10,
		Id = 22000221,
		SubstituteAction = 22000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			22000310
		}
	},
	[22000222] = {
		RandomWeight = 20,
		Id = 22000222,
		SubstituteAction = 22000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			22000311
		}
	},
	[22000231] = {
		isDailyAction = true,
		Id = 22000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			22000330
		}
	},
	[22000232] = {
		isDailyAction = true,
		Id = 22000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			22000331
		}
	},
	[22000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 22000301,
		SubstituteAction = 22000005,
		ActionUnitIDList = {
			22000400,
			22000410
		}
	},
	[22000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 22000302,
		SubstituteAction = 22000005,
		ActionUnitIDList = {
			22000400,
			22000411
		}
	},
	[22000311] = {
		Id = 22000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[22000312] = {
		RandomWeight = 10,
		Id = 22000312,
		SubstituteAction = 22000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			22000420
		}
	},
	[22000313] = {
		Id = 22000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[22000314] = {
		RandomWeight = 60,
		Id = 22000314,
		SubstituteAction = 22000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			22000421
		}
	},
	[22000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000321,
		SubstituteAction = 22000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			22000410
		}
	},
	[22000322] = {
		RandomWeight = 20,
		Id = 22000322,
		SubstituteAction = 22000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			22000411
		}
	},
	[22000331] = {
		isDailyAction = true,
		Id = 22000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			22000430
		}
	},
	[22000332] = {
		isDailyAction = true,
		Id = 22000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			22000431
		}
	},
	[22000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 22000401,
		SubstituteAction = 22000005,
		ActionUnitIDList = {
			22000500,
			22000510
		}
	},
	[22000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 22000402,
		SubstituteAction = 22000005,
		ActionUnitIDList = {
			22000500,
			22000511
		}
	},
	[22000411] = {
		Id = 22000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[22000412] = {
		RandomWeight = 10,
		Id = 22000412,
		SubstituteAction = 22000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			22000520
		}
	},
	[22000413] = {
		Id = 22000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[22000414] = {
		RandomWeight = 60,
		Id = 22000414,
		SubstituteAction = 22000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			22000521
		}
	},
	[22000421] = {
		RandomWeight = 10,
		Id = 22000421,
		SubstituteAction = 22000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			22000510
		}
	},
	[22000422] = {
		RandomWeight = 20,
		Id = 22000422,
		SubstituteAction = 22000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			22000511
		}
	},
	[22000431] = {
		isDailyAction = true,
		Id = 22000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			22000530
		}
	},
	[22000432] = {
		isDailyAction = true,
		Id = 22000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			22000531
		}
	},
	[22000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000501,
		SubstituteAction = 22000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000600,
			22000601,
			22000602,
			22000603,
			22000604
		}
	},
	[22000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000502,
		SubstituteAction = 22000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000610,
			22000611,
			22000612,
			22000613,
			22000614
		}
	},
	[22000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000605,
			22000606
		}
	},
	[22000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000615,
			22000616
		}
	},
	[22000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000511,
		SubstituteAction = 22000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			22000620,
			22000621,
			22000622
		}
	},
	[22000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000512,
		SubstituteAction = 22000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			22000630,
			22000631,
			22000632
		}
	},
	[22000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			22000623,
			22000624
		}
	},
	[22000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			22000633,
			22000634
		}
	},
	[22000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000521,
		SubstituteAction = 22000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			22000620,
			22000625,
			22000624
		}
	},
	[22000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 22000522,
		SubstituteAction = 22000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			22000630,
			22000635,
			22000634
		}
	},
	[22000601] = {
		Id = 22000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[22000602] = {
		RandomWeight = 10,
		Id = 22000602,
		SubstituteAction = 22000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000100,
			22000640
		}
	},
	[22000603] = {
		Id = 22000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[22000604] = {
		RandomWeight = 30,
		Id = 22000604,
		SubstituteAction = 22000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000100,
			22000642
		}
	},
	[22000605] = {
		Id = 22000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000641
		}
	},
	[22000606] = {
		Id = 22000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000643
		}
	},
	[22000607] = {
		RandomWeight = 10,
		Id = 22000607,
		SubstituteAction = 22000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000640
		}
	},
	[22000608] = {
		RandomWeight = 30,
		Id = 22000608,
		SubstituteAction = 22000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			22000642
		}
	},
	[22000611] = {
		Id = 22000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[22000612] = {
		RandomWeight = 30,
		Id = 22000612,
		SubstituteAction = 22000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			22000100,
			22000650,
			22000651
		}
	},
	[22000613] = {
		Id = 22000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[22000614] = {
		RandomWeight = 30,
		Id = 22000614,
		SubstituteAction = 22000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			22000100,
			22000652,
			22000653
		}
	},
	[22000615] = {
		Id = 22000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			22000651
		}
	},
	[22000616] = {
		Id = 22000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			22000653
		}
	},
	[22000617] = {
		RandomWeight = 30,
		Id = 22000617,
		SubstituteAction = 22000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			22000650,
			22000651
		}
	},
	[22000618] = {
		RandomWeight = 30,
		Id = 22000618,
		SubstituteAction = 22000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			22000652,
			22000653
		}
	},
	[22000621] = {
		Id = 22000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[22000622] = {
		RandomWeight = 30,
		Id = 22000622,
		SubstituteAction = 22000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			22000635,
			22000624
		}
	},
	[22000623] = {
		Id = 22000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[22000624] = {
		RandomWeight = 30,
		Id = 22000624,
		SubstituteAction = 22000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			22000635,
			22000632
		}
	},
	[22000625] = {
		RandomWeight = 30,
		Id = 22000625,
		SubstituteAction = 22000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			22000661
		}
	},
	[22000626] = {
		RandomWeight = 30,
		Id = 22000626,
		SubstituteAction = 22000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			22000662
		}
	},
	[22000701] = {
		RandomWeight = 30,
		Id = 22000701,
		SubstituteAction = 22000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			22000603,
			22000604
		}
	},
	[22000702] = {
		RandomWeight = 10,
		Id = 22000702,
		SubstituteAction = 22000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			22000613,
			22000614
		}
	},
	[22000711] = {
		SubstituteAction = 22000513,
		RandomWeight = 10,
		Id = 22000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[22000712] = {
		RandomWeight = 10,
		Id = 22000712,
		SubstituteAction = 22000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			22000631,
			22000632
		}
	},
	[22000713] = {
		RandomWeight = 10,
		Id = 22000713,
		SubstituteAction = 22000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			22000635,
			22000624
		}
	},
	[22000714] = {
		RandomWeight = 10,
		Id = 22000714,
		SubstituteAction = 22000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			22000635,
			22000632
		}
	},
	[22000803] = {
		isDailyAction = true,
		Id = 22000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			22000810,
			22000811,
			22000812,
			22000813
		}
	},
	[22000804] = {
		Id = 22000804,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			22000820,
			22000821,
			22000822,
			22000823
		}
	},
	[22000805] = {
		Id = 22000805,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			22000820,
			22000824,
			22000827
		}
	},
	[22000806] = {
		Id = 22000806,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			22000820,
			22000825,
			22000827
		}
	},
	[22000807] = {
		Id = 22000807,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			22000820,
			22000826,
			22000827
		}
	},
	[22000808] = {
		Id = 22000808,
		RandomWeight = 50,
		ActionUnitIDList = {
			22000810,
			22000814,
			22000815
		}
	},
	[22000809] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 22000809,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			22000828,
			22000830,
			22000829
		}
	},
	[22000901] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 22000901,
		SubstituteAction = 22000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			22000910,
			22000911,
			22000912,
			22000913
		}
	},
	[22000902] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 22000902,
		SubstituteAction = 22000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			22000920,
			22000921,
			22000922,
			22000923
		}
	},
	[22005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 22005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[22005002] = {
		Id = 22005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			22000100,
			22000110,
			22000111,
			22000112,
			22000113,
			22000120
		}
	},
	[23000001] = {
		Id = 23000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[23000002] = {
		Id = 23000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[23000003] = {
		Id = 23000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[23000004] = {
		Id = 23000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			23000010
		}
	},
	[23000005] = {
		Id = 23000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			23000020
		}
	},
	[23000011] = {
		RandomWeight = 10,
		Id = 23000011,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000110,
			23000100,
			23000110,
			23000120
		}
	},
	[23000012] = {
		RandomWeight = 10,
		Id = 23000012,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000130
		}
	},
	[23000013] = {
		RandomWeight = 10,
		Id = 23000013,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000110,
			23000100,
			23000110,
			23000131,
			23000100
		}
	},
	[23000021] = {
		RandomWeight = 20,
		Id = 23000021,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000111,
			23000100,
			23000111,
			23000120
		}
	},
	[23000022] = {
		RandomWeight = 20,
		Id = 23000022,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000112,
			23000100,
			23000112,
			23000120
		}
	},
	[23000023] = {
		RandomWeight = 20,
		Id = 23000023,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000113,
			23000100,
			23000113,
			23000120
		}
	},
	[23000024] = {
		RandomWeight = 20,
		Id = 23000024,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000140
		}
	},
	[23000025] = {
		RandomWeight = 20,
		Id = 23000025,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000110,
			23000100,
			23000110,
			23000141,
			23000100
		}
	},
	[23000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 23000026,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			23000150
		}
	},
	[23000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 23000031,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101,
			807
		},
		ActionUnitIDList = {
			23000151
		}
	},
	[23000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 23000041,
		SubstituteAction = 23000004,
		ConditionIDList = {
			101,
			811
		},
		ActionUnitIDList = {
			23000152
		}
	},
	[23000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 23000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			23000210
		}
	},
	[23000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 23000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			23000211
		}
	},
	[23000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 23000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			23000210
		}
	},
	[23000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 23000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			23000211
		}
	},
	[23000121] = {
		Id = 23000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[23000122] = {
		Id = 23000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[23000201] = {
		isDailyAction = true,
		RandomWeight = 2,
		Id = 23000201,
		SubstituteAction = 23000005,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000300,
			23000310
		}
	},
	[23000202] = {
		isDailyAction = true,
		RandomWeight = 2,
		Id = 23000202,
		SubstituteAction = 23000005,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000300,
			23000311
		}
	},
	[23000211] = {
		isDailyAction = true,
		RandomWeight = 2,
		Id = 23000211,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103,
			23000320
		}
	},
	[23000212] = {
		RandomWeight = 10,
		Id = 23000212,
		SubstituteAction = 23000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			23000320
		}
	},
	[23000213] = {
		Id = 23000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[23000214] = {
		RandomWeight = 60,
		Id = 23000214,
		SubstituteAction = 23000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			23000321
		}
	},
	[23000221] = {
		RandomWeight = 10,
		Id = 23000221,
		SubstituteAction = 23000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			23000310
		}
	},
	[23000222] = {
		RandomWeight = 20,
		Id = 23000222,
		SubstituteAction = 23000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			23000311
		}
	},
	[23000231] = {
		isDailyAction = true,
		Id = 23000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			23000330
		}
	},
	[23000232] = {
		isDailyAction = true,
		Id = 23000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			23000331
		}
	},
	[23000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 23000301,
		SubstituteAction = 23000005,
		ActionUnitIDList = {
			23000400,
			23000410
		}
	},
	[23000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 23000302,
		SubstituteAction = 23000005,
		ActionUnitIDList = {
			23000400,
			23000411
		}
	},
	[23000311] = {
		Id = 23000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[23000312] = {
		RandomWeight = 10,
		Id = 23000312,
		SubstituteAction = 23000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			23000420
		}
	},
	[23000313] = {
		Id = 23000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[23000314] = {
		RandomWeight = 60,
		Id = 23000314,
		SubstituteAction = 23000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			23000421
		}
	},
	[23000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000321,
		SubstituteAction = 23000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			23000410
		}
	},
	[23000322] = {
		RandomWeight = 20,
		Id = 23000322,
		SubstituteAction = 23000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			23000411
		}
	},
	[23000331] = {
		isDailyAction = true,
		Id = 23000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			23000430
		}
	},
	[23000332] = {
		isDailyAction = true,
		Id = 23000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			23000431
		}
	},
	[23000401] = {
		isDailyAction = true,
		RandomWeight = 2,
		Id = 23000401,
		SubstituteAction = 23000005,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000500,
			23000510
		}
	},
	[23000402] = {
		isDailyAction = true,
		RandomWeight = 2,
		Id = 23000402,
		SubstituteAction = 23000005,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			23000500,
			23000511
		}
	},
	[23000411] = {
		isDailyAction = true,
		RandomWeight = 2,
		Id = 23000411,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103,
			23000520
		}
	},
	[23000412] = {
		RandomWeight = 10,
		Id = 23000412,
		SubstituteAction = 23000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			23000520
		}
	},
	[23000413] = {
		Id = 23000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[23000414] = {
		RandomWeight = 60,
		Id = 23000414,
		SubstituteAction = 23000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			23000521
		}
	},
	[23000421] = {
		RandomWeight = 10,
		Id = 23000421,
		SubstituteAction = 23000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			23000510
		}
	},
	[23000422] = {
		RandomWeight = 20,
		Id = 23000422,
		SubstituteAction = 23000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			23000511
		}
	},
	[23000431] = {
		isDailyAction = true,
		Id = 23000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			23000530
		}
	},
	[23000432] = {
		isDailyAction = true,
		Id = 23000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			23000531
		}
	},
	[23000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000501,
		SubstituteAction = 23000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000600,
			23000601,
			23000602,
			23000603,
			23000604
		}
	},
	[23000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000502,
		SubstituteAction = 23000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000610,
			23000611,
			23000612,
			23000613,
			23000614
		}
	},
	[23000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000605,
			23000606
		}
	},
	[23000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000615,
			23000616
		}
	},
	[23000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000511,
		SubstituteAction = 23000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000620,
			23000621,
			23000622
		}
	},
	[23000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000512,
		SubstituteAction = 23000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000630,
			23000631,
			23000632
		}
	},
	[23000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000623,
			23000624
		}
	},
	[23000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000633,
			23000634
		}
	},
	[23000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000521,
		SubstituteAction = 23000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000620,
			23000625,
			23000624
		}
	},
	[23000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23000522,
		SubstituteAction = 23000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000630,
			23000635,
			23000634
		}
	},
	[23000601] = {
		Id = 23000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[23000602] = {
		RandomWeight = 10,
		Id = 23000602,
		SubstituteAction = 23000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000100,
			23000640
		}
	},
	[23000603] = {
		Id = 23000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[23000604] = {
		RandomWeight = 30,
		Id = 23000604,
		SubstituteAction = 23000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000100,
			23000642
		}
	},
	[23000605] = {
		Id = 23000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000641
		}
	},
	[23000606] = {
		Id = 23000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000643
		}
	},
	[23000607] = {
		RandomWeight = 10,
		Id = 23000607,
		SubstituteAction = 23000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000640
		}
	},
	[23000608] = {
		RandomWeight = 30,
		Id = 23000608,
		SubstituteAction = 23000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000642
		}
	},
	[23000611] = {
		Id = 23000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[23000612] = {
		RandomWeight = 30,
		Id = 23000612,
		SubstituteAction = 23000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000100,
			23000650,
			23000651
		}
	},
	[23000613] = {
		Id = 23000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[23000614] = {
		RandomWeight = 30,
		Id = 23000614,
		SubstituteAction = 23000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000100,
			23000652,
			23000653
		}
	},
	[23000615] = {
		Id = 23000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000651
		}
	},
	[23000616] = {
		Id = 23000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000653
		}
	},
	[23000617] = {
		RandomWeight = 30,
		Id = 23000617,
		SubstituteAction = 23000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000650,
			23000651
		}
	},
	[23000618] = {
		RandomWeight = 30,
		Id = 23000618,
		SubstituteAction = 23000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000652,
			23000653
		}
	},
	[23000621] = {
		Id = 23000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[23000622] = {
		RandomWeight = 30,
		Id = 23000622,
		SubstituteAction = 23000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000635,
			23000624
		}
	},
	[23000623] = {
		Id = 23000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[23000624] = {
		RandomWeight = 30,
		Id = 23000624,
		SubstituteAction = 23000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000635,
			23000632
		}
	},
	[23000625] = {
		RandomWeight = 30,
		Id = 23000625,
		SubstituteAction = 23000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000661
		}
	},
	[23000626] = {
		RandomWeight = 30,
		Id = 23000626,
		SubstituteAction = 23000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000662
		}
	},
	[23000701] = {
		RandomWeight = 30,
		Id = 23000701,
		SubstituteAction = 23000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			23000603,
			23000604
		}
	},
	[23000702] = {
		RandomWeight = 10,
		Id = 23000702,
		SubstituteAction = 23000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			23000613,
			23000614
		}
	},
	[23000711] = {
		SubstituteAction = 23000513,
		RandomWeight = 10,
		Id = 23000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[23000712] = {
		RandomWeight = 10,
		Id = 23000712,
		SubstituteAction = 23000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			23000631,
			23000632
		}
	},
	[23000713] = {
		RandomWeight = 10,
		Id = 23000713,
		SubstituteAction = 23000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			23000635,
			23000624
		}
	},
	[23000714] = {
		RandomWeight = 10,
		Id = 23000714,
		SubstituteAction = 23000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			23000635,
			23000632
		}
	},
	[23001501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001501,
		SubstituteAction = 23001503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000900,
			23000901,
			23000902,
			23000903,
			23000904
		}
	},
	[23001502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001502,
		SubstituteAction = 23001504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000910,
			23000911,
			23000912,
			23000913,
			23000914
		}
	},
	[23001503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000905,
			23000906
		}
	},
	[23001504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000915,
			23000916
		}
	},
	[23001511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001511,
		SubstituteAction = 23001513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000920,
			23000921,
			23000922
		}
	},
	[23001512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001512,
		SubstituteAction = 23001514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000930,
			23000931,
			23000932
		}
	},
	[23001513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000923,
			23000924
		}
	},
	[23001514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000933,
			23000934
		}
	},
	[23001521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001521,
		SubstituteAction = 23001513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000920,
			23000925,
			23000924
		}
	},
	[23001522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 23001522,
		SubstituteAction = 23001514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000930,
			23000935,
			23000934
		}
	},
	[23001601] = {
		Id = 23001601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[23001602] = {
		RandomWeight = 10,
		Id = 23001602,
		SubstituteAction = 23001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000100,
			23000940
		}
	},
	[23001603] = {
		Id = 23001603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[23001604] = {
		RandomWeight = 30,
		Id = 23001604,
		SubstituteAction = 23001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000100,
			23000942
		}
	},
	[23001605] = {
		Id = 23001605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000941
		}
	},
	[23001606] = {
		Id = 23001606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000943
		}
	},
	[23001607] = {
		RandomWeight = 10,
		Id = 23001607,
		SubstituteAction = 23001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000940
		}
	},
	[23001608] = {
		RandomWeight = 30,
		Id = 23001608,
		SubstituteAction = 23001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			23000942
		}
	},
	[23001611] = {
		Id = 23001611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[23001612] = {
		RandomWeight = 30,
		Id = 23001612,
		SubstituteAction = 23001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000100,
			23000950,
			23000951
		}
	},
	[23001613] = {
		Id = 23001613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[23001614] = {
		RandomWeight = 30,
		Id = 23001614,
		SubstituteAction = 23001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000100,
			23000952,
			23000953
		}
	},
	[23001615] = {
		Id = 23001615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000951
		}
	},
	[23001616] = {
		Id = 23001616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			23000953
		}
	},
	[23001617] = {
		RandomWeight = 30,
		Id = 23001617,
		SubstituteAction = 23001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000950,
			23000951
		}
	},
	[23001618] = {
		RandomWeight = 30,
		Id = 23001618,
		SubstituteAction = 23001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			23000952,
			23000953
		}
	},
	[23001621] = {
		Id = 23001621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[23001622] = {
		RandomWeight = 30,
		Id = 23001622,
		SubstituteAction = 23001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000935,
			23000924
		}
	},
	[23001623] = {
		Id = 23001623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[23001624] = {
		RandomWeight = 30,
		Id = 23001624,
		SubstituteAction = 23001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000935,
			23000932
		}
	},
	[23001625] = {
		RandomWeight = 30,
		Id = 23001625,
		SubstituteAction = 23001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000961
		}
	},
	[23001626] = {
		RandomWeight = 30,
		Id = 23001626,
		SubstituteAction = 23001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			23000962
		}
	},
	[23001701] = {
		RandomWeight = 30,
		Id = 23001701,
		SubstituteAction = 23001503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			23000903,
			23000904
		}
	},
	[23001702] = {
		RandomWeight = 10,
		Id = 23001702,
		SubstituteAction = 23001504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			23000913,
			23000914
		}
	},
	[23001711] = {
		SubstituteAction = 23001513,
		RandomWeight = 10,
		Id = 23001711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[23001712] = {
		RandomWeight = 10,
		Id = 23001712,
		SubstituteAction = 23001514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			23000931,
			23000932
		}
	},
	[23001713] = {
		RandomWeight = 10,
		Id = 23001713,
		SubstituteAction = 23001513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			23000935,
			23000924
		}
	},
	[23001714] = {
		RandomWeight = 10,
		Id = 23001714,
		SubstituteAction = 23001514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			23000935,
			23000932
		}
	},
	[23000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 23000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			23000810,
			23000811,
			23000812,
			23000813
		}
	},
	[23000802] = {
		Id = 23000802,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			23000821,
			23000822,
			23000823
		}
	},
	[23000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 23000803,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			23000830,
			23000831,
			23000832,
			23000833
		}
	},
	[23000804] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 23000804,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			23000810,
			23000811,
			23000812,
			23000814
		}
	},
	[23000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 23000805,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			23000840,
			23000841,
			23000842,
			23000843
		}
	},
	[23005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 23005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[23005002] = {
		Id = 23005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			23000100,
			23000110,
			23000111,
			23000112,
			23000113,
			23000120
		}
	},
	[24000001] = {
		Id = 24000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[24000002] = {
		Id = 24000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[24000003] = {
		Id = 24000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[24000004] = {
		Id = 24000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			24000010
		}
	},
	[24000005] = {
		Id = 24000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			24000020
		}
	},
	[24000011] = {
		RandomWeight = 10,
		Id = 24000011,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000110,
			24000100,
			24000110,
			24000120
		}
	},
	[24000012] = {
		RandomWeight = 10,
		Id = 24000012,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000130
		}
	},
	[24000013] = {
		RandomWeight = 10,
		Id = 24000013,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000110,
			24000100,
			24000110,
			24000131,
			24000100
		}
	},
	[24000021] = {
		RandomWeight = 20,
		Id = 24000021,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000111,
			24000100,
			24000111,
			24000120
		}
	},
	[24000022] = {
		RandomWeight = 20,
		Id = 24000022,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000112,
			24000100,
			24000112,
			24000120
		}
	},
	[24000023] = {
		RandomWeight = 20,
		Id = 24000023,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000113,
			24000100,
			24000113,
			24000120
		}
	},
	[24000024] = {
		RandomWeight = 20,
		Id = 24000024,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000140
		}
	},
	[24000025] = {
		RandomWeight = 20,
		Id = 24000025,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			24000110,
			24000100,
			24000110,
			24000141,
			24000100
		}
	},
	[24000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 24000026,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			24000150
		}
	},
	[24000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 24000031,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101,
			813
		},
		ActionUnitIDList = {
			24000151
		}
	},
	[24000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 24000041,
		SubstituteAction = 24000004,
		ConditionIDList = {
			101,
			802
		},
		ActionUnitIDList = {
			24000152
		}
	},
	[24000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 24000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			24000210
		}
	},
	[24000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 24000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			24000211
		}
	},
	[24000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 24000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			24000210
		}
	},
	[24000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 24000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			24000211
		}
	},
	[24000121] = {
		Id = 24000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[24000122] = {
		Id = 24000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[24000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000201,
		SubstituteAction = 24000005,
		ActionUnitIDList = {
			24000300,
			24000310
		}
	},
	[24000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000202,
		SubstituteAction = 24000005,
		ActionUnitIDList = {
			24000300,
			24000311
		}
	},
	[24000211] = {
		Id = 24000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[24000212] = {
		RandomWeight = 10,
		Id = 24000212,
		SubstituteAction = 24000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			24000320
		}
	},
	[24000213] = {
		Id = 24000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[24000214] = {
		RandomWeight = 60,
		Id = 24000214,
		SubstituteAction = 24000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			24000321
		}
	},
	[24000221] = {
		RandomWeight = 10,
		Id = 24000221,
		SubstituteAction = 24000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			24000310
		}
	},
	[24000222] = {
		RandomWeight = 20,
		Id = 24000222,
		SubstituteAction = 24000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			24000311
		}
	},
	[24000231] = {
		isDailyAction = true,
		Id = 24000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			24000330
		}
	},
	[24000232] = {
		isDailyAction = true,
		Id = 24000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			24000331
		}
	},
	[24000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000301,
		SubstituteAction = 24000005,
		ActionUnitIDList = {
			24000400,
			24000410
		}
	},
	[24000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000302,
		SubstituteAction = 24000005,
		ActionUnitIDList = {
			24000400,
			24000411
		}
	},
	[24000311] = {
		Id = 24000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[24000312] = {
		RandomWeight = 10,
		Id = 24000312,
		SubstituteAction = 24000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			24000420
		}
	},
	[24000313] = {
		Id = 24000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[24000314] = {
		RandomWeight = 60,
		Id = 24000314,
		SubstituteAction = 24000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			24000421
		}
	},
	[24000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000321,
		SubstituteAction = 24000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			24000410
		}
	},
	[24000322] = {
		RandomWeight = 20,
		Id = 24000322,
		SubstituteAction = 24000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			24000411
		}
	},
	[24000331] = {
		isDailyAction = true,
		Id = 24000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			24000430
		}
	},
	[24000332] = {
		isDailyAction = true,
		Id = 24000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			24000431
		}
	},
	[24000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000401,
		SubstituteAction = 24000005,
		ActionUnitIDList = {
			24000500,
			24000510
		}
	},
	[24000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000402,
		SubstituteAction = 24000005,
		ActionUnitIDList = {
			24000500,
			24000511
		}
	},
	[24000411] = {
		Id = 24000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[24000412] = {
		RandomWeight = 10,
		Id = 24000412,
		SubstituteAction = 24000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			24000520
		}
	},
	[24000413] = {
		Id = 24000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[24000414] = {
		RandomWeight = 60,
		Id = 24000414,
		SubstituteAction = 24000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			24000521
		}
	},
	[24000421] = {
		RandomWeight = 10,
		Id = 24000421,
		SubstituteAction = 24000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			24000510
		}
	},
	[24000422] = {
		RandomWeight = 20,
		Id = 24000422,
		SubstituteAction = 24000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			24000511
		}
	},
	[24000431] = {
		isDailyAction = true,
		Id = 24000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			24000530
		}
	},
	[24000432] = {
		isDailyAction = true,
		Id = 24000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			24000531
		}
	},
	[24000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000501,
		SubstituteAction = 24000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000600,
			24000601,
			24000602,
			24000603,
			24000604
		}
	},
	[24000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000502,
		SubstituteAction = 24000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000610,
			24000611,
			24000612,
			24000613,
			24000614
		}
	},
	[24000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000605,
			24000606
		}
	},
	[24000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000615,
			24000616
		}
	},
	[24000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000511,
		SubstituteAction = 24000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			24000620,
			24000621,
			24000622
		}
	},
	[24000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000512,
		SubstituteAction = 24000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			24000630,
			24000631,
			24000632
		}
	},
	[24000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			24000623,
			24000624
		}
	},
	[24000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			24000633,
			24000634
		}
	},
	[24000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000521,
		SubstituteAction = 24000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			24000620,
			24000625,
			24000624
		}
	},
	[24000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 24000522,
		SubstituteAction = 24000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			24000630,
			24000635,
			24000634
		}
	},
	[24000601] = {
		Id = 24000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[24000602] = {
		RandomWeight = 10,
		Id = 24000602,
		SubstituteAction = 24000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000100,
			24000640
		}
	},
	[24000603] = {
		Id = 24000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[24000604] = {
		RandomWeight = 30,
		Id = 24000604,
		SubstituteAction = 24000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000100,
			24000642
		}
	},
	[24000605] = {
		Id = 24000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000641
		}
	},
	[24000606] = {
		Id = 24000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000643
		}
	},
	[24000607] = {
		RandomWeight = 10,
		Id = 24000607,
		SubstituteAction = 24000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000640
		}
	},
	[24000608] = {
		RandomWeight = 30,
		Id = 24000608,
		SubstituteAction = 24000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			24000642
		}
	},
	[24000611] = {
		Id = 24000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[24000612] = {
		RandomWeight = 30,
		Id = 24000612,
		SubstituteAction = 24000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			24000100,
			24000650,
			24000651
		}
	},
	[24000613] = {
		Id = 24000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[24000614] = {
		RandomWeight = 30,
		Id = 24000614,
		SubstituteAction = 24000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			24000100,
			24000652,
			24000653
		}
	},
	[24000615] = {
		Id = 24000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			24000651
		}
	},
	[24000616] = {
		Id = 24000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			24000653
		}
	},
	[24000617] = {
		RandomWeight = 30,
		Id = 24000617,
		SubstituteAction = 24000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			24000650,
			24000651
		}
	},
	[24000618] = {
		RandomWeight = 30,
		Id = 24000618,
		SubstituteAction = 24000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			24000652,
			24000653
		}
	},
	[24000621] = {
		Id = 24000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[24000622] = {
		RandomWeight = 30,
		Id = 24000622,
		SubstituteAction = 24000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			24000635,
			24000624
		}
	},
	[24000623] = {
		Id = 24000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[24000624] = {
		RandomWeight = 30,
		Id = 24000624,
		SubstituteAction = 24000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			24000635,
			24000632
		}
	},
	[24000625] = {
		RandomWeight = 30,
		Id = 24000625,
		SubstituteAction = 24000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			24000661
		}
	},
	[24000626] = {
		RandomWeight = 30,
		Id = 24000626,
		SubstituteAction = 24000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			24000662
		}
	},
	[24000701] = {
		RandomWeight = 30,
		Id = 24000701,
		SubstituteAction = 24000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			24000603,
			24000604
		}
	},
	[24000702] = {
		RandomWeight = 10,
		Id = 24000702,
		SubstituteAction = 24000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			24000613,
			24000614
		}
	},
	[24000711] = {
		SubstituteAction = 24000513,
		RandomWeight = 10,
		Id = 24000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[24000712] = {
		RandomWeight = 10,
		Id = 24000712,
		SubstituteAction = 24000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			24000631,
			24000632
		}
	},
	[24000713] = {
		RandomWeight = 10,
		Id = 24000713,
		SubstituteAction = 24000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			24000635,
			24000624
		}
	},
	[24000714] = {
		RandomWeight = 10,
		Id = 24000714,
		SubstituteAction = 24000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			24000635,
			24000632
		}
	},
	[24000801] = {
		Id = 24000801,
		RandomWeight = 100,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			24000810,
			24000811,
			24000812,
			24000813
		}
	},
	[24000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 24000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			24000820,
			24000821,
			24000822,
			24000823
		}
	},
	[24000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 24000803,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			24000830,
			24000831,
			24000832,
			24000833
		}
	},
	[24000901] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000901,
		SubstituteAction = 24000004,
		ActionUnitIDList = {
			24000910,
			24000911,
			24000912,
			24000913
		}
	},
	[24000902] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 24000902,
		SubstituteAction = 24000004,
		ActionUnitIDList = {
			24000920,
			24000921,
			24000922,
			24000923
		}
	},
	[24005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 24005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[24005002] = {
		Id = 24005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			24000100,
			24000110,
			24000111,
			24000112,
			24000113,
			24000120
		}
	},
	[25000001] = {
		Id = 25000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[25000002] = {
		Id = 25000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[25000003] = {
		Id = 25000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[25000004] = {
		Id = 25000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			25000010
		}
	},
	[25000005] = {
		Id = 25000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			25000020
		}
	},
	[25000011] = {
		RandomWeight = 10,
		Id = 25000011,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000110,
			25000100,
			25000110,
			25000120
		}
	},
	[25000012] = {
		RandomWeight = 10,
		Id = 25000012,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000130
		}
	},
	[25000013] = {
		RandomWeight = 10,
		Id = 25000013,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000110,
			25000100,
			25000110,
			25000131,
			25000100
		}
	},
	[25000021] = {
		RandomWeight = 20,
		Id = 25000021,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000111,
			25000100,
			25000111,
			25000120
		}
	},
	[25000022] = {
		RandomWeight = 20,
		Id = 25000022,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000112,
			25000100,
			25000112,
			25000120
		}
	},
	[25000023] = {
		RandomWeight = 20,
		Id = 25000023,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000113,
			25000100,
			25000113,
			25000120
		}
	},
	[25000024] = {
		RandomWeight = 20,
		Id = 25000024,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000140
		}
	},
	[25000025] = {
		RandomWeight = 20,
		Id = 25000025,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			25000110,
			25000100,
			25000110,
			25000141,
			25000100
		}
	},
	[25000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 25000026,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			25000150
		}
	},
	[25000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 25000031,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101,
			807
		},
		ActionUnitIDList = {
			25000151
		}
	},
	[25000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 25000041,
		SubstituteAction = 25000004,
		ConditionIDList = {
			101,
			812
		},
		ActionUnitIDList = {
			25000152
		}
	},
	[25000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 25000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			25000210
		}
	},
	[25000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 25000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			25000211
		}
	},
	[25000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 25000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			25000210
		}
	},
	[25000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 25000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			25000211
		}
	},
	[25000121] = {
		Id = 25000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[25000122] = {
		Id = 25000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[25000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 25000201,
		SubstituteAction = 25000005,
		ActionUnitIDList = {
			25000300,
			25000310
		}
	},
	[25000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 25000202,
		SubstituteAction = 25000005,
		ActionUnitIDList = {
			25000300,
			25000311
		}
	},
	[25000211] = {
		Id = 25000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[25000212] = {
		RandomWeight = 10,
		Id = 25000212,
		SubstituteAction = 25000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			25000320
		}
	},
	[25000213] = {
		Id = 25000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[25000214] = {
		RandomWeight = 60,
		Id = 25000214,
		SubstituteAction = 25000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			25000321
		}
	},
	[25000221] = {
		RandomWeight = 10,
		Id = 25000221,
		SubstituteAction = 25000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			25000310
		}
	},
	[25000222] = {
		RandomWeight = 20,
		Id = 25000222,
		SubstituteAction = 25000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			25000311
		}
	},
	[25000231] = {
		isDailyAction = true,
		Id = 25000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			25000330
		}
	},
	[25000232] = {
		isDailyAction = true,
		Id = 25000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			25000331
		}
	},
	[25000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 25000301,
		SubstituteAction = 25000005,
		ActionUnitIDList = {
			25000400,
			25000410
		}
	},
	[25000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 25000302,
		SubstituteAction = 25000005,
		ActionUnitIDList = {
			25000400,
			25000411
		}
	},
	[25000311] = {
		Id = 25000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[25000312] = {
		RandomWeight = 10,
		Id = 25000312,
		SubstituteAction = 25000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			25000420
		}
	},
	[25000313] = {
		Id = 25000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[25000314] = {
		RandomWeight = 60,
		Id = 25000314,
		SubstituteAction = 25000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			25000421
		}
	},
	[25000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000321,
		SubstituteAction = 25000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			25000410
		}
	},
	[25000322] = {
		RandomWeight = 20,
		Id = 25000322,
		SubstituteAction = 25000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			25000411
		}
	},
	[25000331] = {
		isDailyAction = true,
		Id = 25000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			25000430
		}
	},
	[25000332] = {
		isDailyAction = true,
		Id = 25000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			25000431
		}
	},
	[25000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 25000401,
		SubstituteAction = 25000005,
		ActionUnitIDList = {
			25000500,
			25000510
		}
	},
	[25000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 25000402,
		SubstituteAction = 25000005,
		ActionUnitIDList = {
			25000500,
			25000511
		}
	},
	[25000411] = {
		Id = 25000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[25000412] = {
		RandomWeight = 10,
		Id = 25000412,
		SubstituteAction = 25000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			25000520
		}
	},
	[25000413] = {
		Id = 25000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[25000414] = {
		RandomWeight = 60,
		Id = 25000414,
		SubstituteAction = 25000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			25000521
		}
	},
	[25000421] = {
		RandomWeight = 10,
		Id = 25000421,
		SubstituteAction = 25000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			25000510
		}
	},
	[25000422] = {
		RandomWeight = 20,
		Id = 25000422,
		SubstituteAction = 25000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			25000511
		}
	},
	[25000431] = {
		isDailyAction = true,
		Id = 25000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			25000530
		}
	},
	[25000432] = {
		isDailyAction = true,
		Id = 25000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			25000531
		}
	},
	[25000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000501,
		SubstituteAction = 25000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000600,
			25000601,
			25000602,
			25000603,
			25000604
		}
	},
	[25000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000502,
		SubstituteAction = 25000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000610,
			25000611,
			25000612,
			25000613,
			25000614
		}
	},
	[25000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000605,
			25000606
		}
	},
	[25000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000615,
			25000616
		}
	},
	[25000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000511,
		SubstituteAction = 25000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			25000620,
			25000621,
			25000622
		}
	},
	[25000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000512,
		SubstituteAction = 25000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			25000630,
			25000631,
			25000632
		}
	},
	[25000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			25000623,
			25000624
		}
	},
	[25000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			25000633,
			25000634
		}
	},
	[25000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000521,
		SubstituteAction = 25000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			25000620,
			25000625,
			25000624
		}
	},
	[25000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 25000522,
		SubstituteAction = 25000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			25000630,
			25000635,
			25000634
		}
	},
	[25000601] = {
		Id = 25000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[25000602] = {
		RandomWeight = 10,
		Id = 25000602,
		SubstituteAction = 25000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000100,
			25000640
		}
	},
	[25000603] = {
		Id = 25000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[25000604] = {
		RandomWeight = 30,
		Id = 25000604,
		SubstituteAction = 25000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000100,
			25000642
		}
	},
	[25000605] = {
		Id = 25000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000641
		}
	},
	[25000606] = {
		Id = 25000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000643
		}
	},
	[25000607] = {
		RandomWeight = 10,
		Id = 25000607,
		SubstituteAction = 25000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000640
		}
	},
	[25000608] = {
		RandomWeight = 30,
		Id = 25000608,
		SubstituteAction = 25000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			25000642
		}
	},
	[25000611] = {
		Id = 25000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[25000612] = {
		RandomWeight = 30,
		Id = 25000612,
		SubstituteAction = 25000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			25000100,
			25000650,
			25000651
		}
	},
	[25000613] = {
		Id = 25000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[25000614] = {
		RandomWeight = 30,
		Id = 25000614,
		SubstituteAction = 25000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			25000100,
			25000652,
			25000653
		}
	},
	[25000615] = {
		Id = 25000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			25000651
		}
	},
	[25000616] = {
		Id = 25000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			25000653
		}
	},
	[25000617] = {
		RandomWeight = 30,
		Id = 25000617,
		SubstituteAction = 25000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			25000650,
			25000651
		}
	},
	[25000618] = {
		RandomWeight = 30,
		Id = 25000618,
		SubstituteAction = 25000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			25000652,
			25000653
		}
	},
	[25000621] = {
		Id = 25000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[25000622] = {
		RandomWeight = 30,
		Id = 25000622,
		SubstituteAction = 25000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			25000635,
			25000624
		}
	},
	[25000623] = {
		Id = 25000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[25000624] = {
		RandomWeight = 30,
		Id = 25000624,
		SubstituteAction = 25000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			25000635,
			25000632
		}
	},
	[25000625] = {
		RandomWeight = 30,
		Id = 25000625,
		SubstituteAction = 25000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			25000661
		}
	},
	[25000626] = {
		RandomWeight = 30,
		Id = 25000626,
		SubstituteAction = 25000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			25000662
		}
	},
	[25000701] = {
		RandomWeight = 30,
		Id = 25000701,
		SubstituteAction = 25000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			25000603,
			25000604
		}
	},
	[25000702] = {
		RandomWeight = 10,
		Id = 25000702,
		SubstituteAction = 25000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			25000613,
			25000614
		}
	},
	[25000711] = {
		SubstituteAction = 25000513,
		RandomWeight = 10,
		Id = 25000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[25000712] = {
		RandomWeight = 10,
		Id = 25000712,
		SubstituteAction = 25000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			25000631,
			25000632
		}
	},
	[25000713] = {
		RandomWeight = 10,
		Id = 25000713,
		SubstituteAction = 25000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			25000635,
			25000624
		}
	},
	[25000714] = {
		RandomWeight = 10,
		Id = 25000714,
		SubstituteAction = 25000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			25000635,
			25000632
		}
	},
	[25000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 25000801,
		SubstituteAction = 25000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			25000810,
			25000811,
			25000812,
			25000813
		}
	},
	[25000802] = {
		RandomWeight = 50,
		Id = 25000802,
		SubstituteAction = 25000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			25000820,
			25000821,
			25000822,
			25000823
		}
	},
	[25000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 25000803,
		SubstituteAction = 25000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			25000830,
			25000831,
			25000832,
			25000833
		}
	},
	[25000901] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 25000901,
		SubstituteAction = 25000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			25000910,
			25000911,
			25000912,
			25000913
		}
	},
	[25000902] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 25000902,
		SubstituteAction = 25000004,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			25000920,
			25000921,
			25000922,
			25000923
		}
	},
	[25005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 25005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[25005002] = {
		Id = 25005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			25000100,
			25000110,
			25000111,
			25000112,
			25000113,
			25000120
		}
	},
	[26000001] = {
		Id = 26000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[26000002] = {
		Id = 26000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[26000003] = {
		Id = 26000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[26000004] = {
		Id = 26000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			26000010
		}
	},
	[26000005] = {
		Id = 26000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			26000020
		}
	},
	[26000011] = {
		RandomWeight = 10,
		Id = 26000011,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000110,
			26000100,
			26000110,
			26000120
		}
	},
	[26000012] = {
		RandomWeight = 10,
		Id = 26000012,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000130
		}
	},
	[26000013] = {
		RandomWeight = 10,
		Id = 26000013,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000110,
			26000100,
			26000110,
			26000131,
			26000100
		}
	},
	[26000021] = {
		RandomWeight = 20,
		Id = 26000021,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000111,
			26000100,
			26000111,
			26000120
		}
	},
	[26000022] = {
		RandomWeight = 20,
		Id = 26000022,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000112,
			26000100,
			26000112,
			26000120
		}
	},
	[26000023] = {
		RandomWeight = 20,
		Id = 26000023,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000113,
			26000100,
			26000113,
			26000120
		}
	},
	[26000024] = {
		RandomWeight = 20,
		Id = 26000024,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000140
		}
	},
	[26000025] = {
		RandomWeight = 20,
		Id = 26000025,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			26000110,
			26000100,
			26000110,
			26000141,
			26000100
		}
	},
	[26000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 26000026,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			26000150
		}
	},
	[26000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 26000031,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			26000151
		}
	},
	[26000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 26000041,
		SubstituteAction = 26000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			26000152
		}
	},
	[26000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 26000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			26000210
		}
	},
	[26000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 26000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			26000211
		}
	},
	[26000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 26000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			26000210
		}
	},
	[26000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 26000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			26000211
		}
	},
	[26000121] = {
		Id = 26000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[26000122] = {
		Id = 26000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[26000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 26000201,
		SubstituteAction = 26000005,
		ActionUnitIDList = {
			26000300,
			26000310
		}
	},
	[26000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 26000202,
		SubstituteAction = 26000005,
		ActionUnitIDList = {
			26000300,
			26000311
		}
	},
	[26000211] = {
		Id = 26000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[26000212] = {
		RandomWeight = 10,
		Id = 26000212,
		SubstituteAction = 26000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			26000320
		}
	},
	[26000213] = {
		Id = 26000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[26000214] = {
		RandomWeight = 60,
		Id = 26000214,
		SubstituteAction = 26000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			26000321
		}
	},
	[26000221] = {
		RandomWeight = 10,
		Id = 26000221,
		SubstituteAction = 26000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			26000310
		}
	},
	[26000222] = {
		RandomWeight = 20,
		Id = 26000222,
		SubstituteAction = 26000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			26000311
		}
	},
	[26000231] = {
		isDailyAction = true,
		Id = 26000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			26000330
		}
	},
	[26000232] = {
		isDailyAction = true,
		Id = 26000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			26000331
		}
	},
	[26000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 26000301,
		SubstituteAction = 26000005,
		ActionUnitIDList = {
			26000400,
			26000410
		}
	},
	[26000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 26000302,
		SubstituteAction = 26000005,
		ActionUnitIDList = {
			26000400,
			26000411
		}
	},
	[26000311] = {
		Id = 26000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[26000312] = {
		RandomWeight = 10,
		Id = 26000312,
		SubstituteAction = 26000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			26000420
		}
	},
	[26000313] = {
		Id = 26000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[26000314] = {
		RandomWeight = 60,
		Id = 26000314,
		SubstituteAction = 26000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			26000421
		}
	},
	[26000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000321,
		SubstituteAction = 26000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			26000410
		}
	},
	[26000322] = {
		RandomWeight = 20,
		Id = 26000322,
		SubstituteAction = 26000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			26000411
		}
	},
	[26000331] = {
		isDailyAction = true,
		Id = 26000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			26000430
		}
	},
	[26000332] = {
		isDailyAction = true,
		Id = 26000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			26000431
		}
	},
	[26000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 26000401,
		SubstituteAction = 26000005,
		ActionUnitIDList = {
			26000500,
			26000510
		}
	},
	[26000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 26000402,
		SubstituteAction = 26000005,
		ActionUnitIDList = {
			26000500,
			26000511
		}
	},
	[26000411] = {
		Id = 26000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[26000412] = {
		RandomWeight = 10,
		Id = 26000412,
		SubstituteAction = 26000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			26000520
		}
	},
	[26000413] = {
		Id = 26000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[26000414] = {
		RandomWeight = 60,
		Id = 26000414,
		SubstituteAction = 26000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			26000521
		}
	},
	[26000421] = {
		RandomWeight = 10,
		Id = 26000421,
		SubstituteAction = 26000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			26000510
		}
	},
	[26000422] = {
		RandomWeight = 20,
		Id = 26000422,
		SubstituteAction = 26000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			26000511
		}
	},
	[26000431] = {
		isDailyAction = true,
		Id = 26000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			26000530
		}
	},
	[26000432] = {
		isDailyAction = true,
		Id = 26000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			26000531
		}
	},
	[26000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000501,
		SubstituteAction = 26000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000600,
			26000601,
			26000602,
			26000603,
			26000604
		}
	},
	[26000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000502,
		SubstituteAction = 26000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000610,
			26000611,
			26000612,
			26000613,
			26000614
		}
	},
	[26000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000605,
			26000606
		}
	},
	[26000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000615,
			26000616
		}
	},
	[26000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000511,
		SubstituteAction = 26000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			26000620,
			26000621,
			26000622
		}
	},
	[26000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000512,
		SubstituteAction = 26000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			26000630,
			26000631,
			26000632
		}
	},
	[26000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			26000623,
			26000624
		}
	},
	[26000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			26000633,
			26000634
		}
	},
	[26000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000521,
		SubstituteAction = 26000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			26000620,
			26000625,
			26000624
		}
	},
	[26000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 26000522,
		SubstituteAction = 26000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			26000630,
			26000635,
			26000634
		}
	},
	[26000601] = {
		Id = 26000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[26000602] = {
		RandomWeight = 10,
		Id = 26000602,
		SubstituteAction = 26000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000100,
			26000640
		}
	},
	[26000603] = {
		Id = 26000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[26000604] = {
		RandomWeight = 30,
		Id = 26000604,
		SubstituteAction = 26000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000100,
			26000642
		}
	},
	[26000605] = {
		Id = 26000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000641
		}
	},
	[26000606] = {
		Id = 26000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000643
		}
	},
	[26000607] = {
		RandomWeight = 10,
		Id = 26000607,
		SubstituteAction = 26000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000640
		}
	},
	[26000608] = {
		RandomWeight = 30,
		Id = 26000608,
		SubstituteAction = 26000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			26000642
		}
	},
	[26000611] = {
		Id = 26000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[26000612] = {
		RandomWeight = 30,
		Id = 26000612,
		SubstituteAction = 26000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			26000100,
			26000650,
			26000651
		}
	},
	[26000613] = {
		Id = 26000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[26000614] = {
		RandomWeight = 30,
		Id = 26000614,
		SubstituteAction = 26000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			26000100,
			26000652,
			26000653
		}
	},
	[26000615] = {
		Id = 26000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			26000651
		}
	},
	[26000616] = {
		Id = 26000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			26000653
		}
	},
	[26000617] = {
		RandomWeight = 30,
		Id = 26000617,
		SubstituteAction = 26000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			26000650,
			26000651
		}
	},
	[26000618] = {
		RandomWeight = 30,
		Id = 26000618,
		SubstituteAction = 26000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			26000652,
			26000653
		}
	},
	[26000621] = {
		Id = 26000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[26000622] = {
		RandomWeight = 30,
		Id = 26000622,
		SubstituteAction = 26000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			26000635,
			26000624
		}
	},
	[26000623] = {
		Id = 26000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[26000624] = {
		RandomWeight = 30,
		Id = 26000624,
		SubstituteAction = 26000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			26000635,
			26000632
		}
	},
	[26000625] = {
		RandomWeight = 30,
		Id = 26000625,
		SubstituteAction = 26000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			26000661
		}
	},
	[26000626] = {
		RandomWeight = 30,
		Id = 26000626,
		SubstituteAction = 26000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			26000662
		}
	},
	[26000701] = {
		RandomWeight = 30,
		Id = 26000701,
		SubstituteAction = 26000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			26000603,
			26000604
		}
	},
	[26000702] = {
		RandomWeight = 10,
		Id = 26000702,
		SubstituteAction = 26000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			26000613,
			26000614
		}
	},
	[26000711] = {
		SubstituteAction = 26000513,
		RandomWeight = 10,
		Id = 26000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[26000712] = {
		RandomWeight = 10,
		Id = 26000712,
		SubstituteAction = 26000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			26000631,
			26000632
		}
	},
	[26000713] = {
		RandomWeight = 10,
		Id = 26000713,
		SubstituteAction = 26000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			26000635,
			26000624
		}
	},
	[26000714] = {
		RandomWeight = 10,
		Id = 26000714,
		SubstituteAction = 26000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			26000635,
			26000632
		}
	},
	[26000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		IsLock = true,
		Id = 26000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			26000810,
			26000811,
			26000812,
			26000813
		}
	},
	[26000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		IsLock = true,
		Id = 26000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			26000820,
			26000821,
			26000822,
			26000823
		}
	},
	[26005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 26005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[26005002] = {
		Id = 26005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			26000100,
			26000110,
			26000111,
			26000112,
			26000113,
			26000120
		}
	},
	[27000001] = {
		Id = 27000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[27000002] = {
		Id = 27000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[27000003] = {
		Id = 27000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[27000004] = {
		Id = 27000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			27000010
		}
	},
	[27000005] = {
		Id = 27000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			27000020
		}
	},
	[27000006] = {
		Id = 27000006,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			203
		},
		ActionUnitIDList = {
			123,
			121,
			122
		}
	},
	[27000007] = {
		Id = 27000007,
		RandomWeight = 1000,
		ConditionIDList = {
			103,
			203
		},
		ActionUnitIDList = {
			123,
			121,
			122
		}
	},
	[27000008] = {
		Id = 27000008,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			27000820,
			121,
			122
		}
	},
	[27000009] = {
		Id = 27000009,
		RandomWeight = 10,
		ConditionIDList = {
			102,
			213
		},
		ActionUnitIDList = {
			27000830,
			121,
			122
		}
	},
	[27000011] = {
		RandomWeight = 10,
		Id = 27000011,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000110,
			27000100,
			27000110,
			27000120
		}
	},
	[27000012] = {
		RandomWeight = 10,
		Id = 27000012,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000130
		}
	},
	[27000013] = {
		RandomWeight = 10,
		Id = 27000013,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000110,
			27000100,
			27000110,
			27000131,
			27000100
		}
	},
	[27000021] = {
		RandomWeight = 20,
		Id = 27000021,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000111,
			27000100,
			27000111,
			27000120
		}
	},
	[27000022] = {
		RandomWeight = 20,
		Id = 27000022,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000112,
			27000100,
			27000112,
			27000120
		}
	},
	[27000023] = {
		RandomWeight = 20,
		Id = 27000023,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000113,
			27000100,
			27000113,
			27000120
		}
	},
	[27000024] = {
		RandomWeight = 20,
		Id = 27000024,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000140
		}
	},
	[27000025] = {
		RandomWeight = 20,
		Id = 27000025,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			27000110,
			27000100,
			27000110,
			27000141,
			27000100
		}
	},
	[27000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 27000026,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			27000150
		}
	},
	[27000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 27000031,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101,
			817
		},
		ActionUnitIDList = {
			27000151
		}
	},
	[27000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 27000041,
		SubstituteAction = 27000004,
		ConditionIDList = {
			101,
			802
		},
		ActionUnitIDList = {
			27000152
		}
	},
	[27000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 27000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			27000210
		}
	},
	[27000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 27000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			27000211
		}
	},
	[27000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 27000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			27000210
		}
	},
	[27000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 27000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			27000211
		}
	},
	[27000121] = {
		Id = 27000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[27000122] = {
		Id = 27000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[27000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 27000201,
		SubstituteAction = 27000005,
		ActionUnitIDList = {
			27000300,
			27000310
		}
	},
	[27000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 27000202,
		SubstituteAction = 27000005,
		ActionUnitIDList = {
			27000300,
			27000311
		}
	},
	[27000211] = {
		Id = 27000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[27000212] = {
		RandomWeight = 10,
		Id = 27000212,
		SubstituteAction = 27000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			27000320
		}
	},
	[27000213] = {
		Id = 27000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[27000214] = {
		RandomWeight = 60,
		Id = 27000214,
		SubstituteAction = 27000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			27000321
		}
	},
	[27000221] = {
		RandomWeight = 10,
		Id = 27000221,
		SubstituteAction = 27000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			27000310
		}
	},
	[27000222] = {
		RandomWeight = 20,
		Id = 27000222,
		SubstituteAction = 27000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			27000311
		}
	},
	[27000231] = {
		isDailyAction = true,
		Id = 27000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			27000330
		}
	},
	[27000232] = {
		isDailyAction = true,
		Id = 27000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			27000331
		}
	},
	[27000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 27000301,
		SubstituteAction = 27000005,
		ActionUnitIDList = {
			27000400,
			27000410
		}
	},
	[27000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 27000302,
		SubstituteAction = 27000005,
		ActionUnitIDList = {
			27000400,
			27000411
		}
	},
	[27000311] = {
		Id = 27000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[27000312] = {
		RandomWeight = 10,
		Id = 27000312,
		SubstituteAction = 27000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			27000420
		}
	},
	[27000313] = {
		Id = 27000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[27000314] = {
		RandomWeight = 60,
		Id = 27000314,
		SubstituteAction = 27000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			27000421
		}
	},
	[27000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 27000321,
		SubstituteAction = 27000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			27000410
		}
	},
	[27000322] = {
		RandomWeight = 20,
		Id = 27000322,
		SubstituteAction = 27000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			27000411
		}
	},
	[27000331] = {
		isDailyAction = true,
		Id = 27000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			27000430
		}
	},
	[27000332] = {
		isDailyAction = true,
		Id = 27000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			27000431
		}
	},
	[27000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 27000401,
		SubstituteAction = 27000005,
		ActionUnitIDList = {
			27000500,
			27000510
		}
	},
	[27000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 27000402,
		SubstituteAction = 27000005,
		ActionUnitIDList = {
			27000500,
			27000511
		}
	},
	[27000411] = {
		Id = 27000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[27000412] = {
		RandomWeight = 10,
		Id = 27000412,
		SubstituteAction = 27000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			27000520
		}
	},
	[27000413] = {
		Id = 27000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[27000414] = {
		RandomWeight = 60,
		Id = 27000414,
		SubstituteAction = 27000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			27000521
		}
	},
	[27000421] = {
		RandomWeight = 10,
		Id = 27000421,
		SubstituteAction = 27000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			27000510
		}
	},
	[27000422] = {
		RandomWeight = 20,
		Id = 27000422,
		SubstituteAction = 27000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			27000511
		}
	},
	[27000431] = {
		isDailyAction = true,
		Id = 27000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			27000530
		}
	},
	[27000432] = {
		isDailyAction = true,
		Id = 27000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			27000531
		}
	},
	[27000501] = {
		RandomWeight = 5,
		Id = 27000501,
		SubstituteAction = 27000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000600,
			27000601,
			27000602,
			27000603,
			27000604
		}
	},
	[27000502] = {
		RandomWeight = 5,
		Id = 27000502,
		SubstituteAction = 27000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000610,
			27000611,
			27000612,
			27000613,
			27000614
		}
	},
	[27000503] = {
		Id = 27000503,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000605,
			27000606
		}
	},
	[27000504] = {
		Id = 27000504,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000615,
			27000616
		}
	},
	[27000511] = {
		RandomWeight = 5,
		Id = 27000511,
		SubstituteAction = 27000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000620,
			27000621,
			27000622
		}
	},
	[27000512] = {
		RandomWeight = 5,
		Id = 27000512,
		SubstituteAction = 27000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000630,
			27000631,
			27000632
		}
	},
	[27000513] = {
		Id = 27000513,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			27000623,
			27000624
		}
	},
	[27000514] = {
		Id = 27000514,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			27000633,
			27000634
		}
	},
	[27000521] = {
		RandomWeight = 5,
		Id = 27000521,
		SubstituteAction = 27000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27000620,
			27000625,
			27000624
		}
	},
	[27000522] = {
		RandomWeight = 5,
		Id = 27000522,
		SubstituteAction = 27000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27000630,
			27000635,
			27000634
		}
	},
	[27000601] = {
		RandomWeight = 4,
		Id = 27000601,
		SubstituteAction = 27000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101,
			27000640
		}
	},
	[27000602] = {
		RandomWeight = 10,
		Id = 27000602,
		SubstituteAction = 27000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000100,
			27000640
		}
	},
	[27000603] = {
		RandomWeight = 4,
		Id = 27000603,
		SubstituteAction = 27000606,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101,
			27000642
		}
	},
	[27000604] = {
		RandomWeight = 30,
		Id = 27000604,
		SubstituteAction = 27000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000100,
			27000642
		}
	},
	[27000605] = {
		Id = 27000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000641
		}
	},
	[27000606] = {
		Id = 27000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000643
		}
	},
	[27000607] = {
		RandomWeight = 10,
		Id = 27000607,
		SubstituteAction = 27000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000640
		}
	},
	[27000608] = {
		RandomWeight = 30,
		Id = 27000608,
		SubstituteAction = 27000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000642
		}
	},
	[27000611] = {
		RandomWeight = 4,
		Id = 27000611,
		SubstituteAction = 27000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			111,
			27000650
		}
	},
	[27000612] = {
		RandomWeight = 30,
		Id = 27000612,
		SubstituteAction = 27000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000100,
			27000650,
			27000651
		}
	},
	[27000613] = {
		RandomWeight = 4,
		Id = 27000613,
		SubstituteAction = 27000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			111,
			27000652
		}
	},
	[27000614] = {
		RandomWeight = 30,
		Id = 27000614,
		SubstituteAction = 27000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000100,
			27000652,
			27000653
		}
	},
	[27000615] = {
		Id = 27000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			27000651
		}
	},
	[27000616] = {
		Id = 27000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			27000653
		}
	},
	[27000617] = {
		RandomWeight = 30,
		Id = 27000617,
		SubstituteAction = 27000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000650,
			27000651
		}
	},
	[27000618] = {
		RandomWeight = 30,
		Id = 27000618,
		SubstituteAction = 27000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000652,
			27000653
		}
	},
	[27000621] = {
		RandomWeight = 4,
		Id = 27000621,
		SubstituteAction = 27000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			111,
			27000650
		}
	},
	[27000622] = {
		RandomWeight = 30,
		Id = 27000622,
		SubstituteAction = 27000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27000635,
			27000624
		}
	},
	[27000623] = {
		RandomWeight = 4,
		Id = 27000623,
		SubstituteAction = 27000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			111,
			27000652
		}
	},
	[27000624] = {
		RandomWeight = 30,
		Id = 27000624,
		SubstituteAction = 27000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27000635,
			27000632
		}
	},
	[27000625] = {
		RandomWeight = 30,
		Id = 27000625,
		SubstituteAction = 27000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27000661
		}
	},
	[27000626] = {
		RandomWeight = 30,
		Id = 27000626,
		SubstituteAction = 27000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27000662
		}
	},
	[27000701] = {
		RandomWeight = 30,
		Id = 27000701,
		SubstituteAction = 27000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			27000603,
			27000604
		}
	},
	[27000702] = {
		RandomWeight = 10,
		Id = 27000702,
		SubstituteAction = 27000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			27000613,
			27000614
		}
	},
	[27000711] = {
		SubstituteAction = 27000513,
		RandomWeight = 10,
		Id = 27000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[27000712] = {
		RandomWeight = 10,
		Id = 27000712,
		SubstituteAction = 27000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			27000631,
			27000632
		}
	},
	[27000713] = {
		RandomWeight = 10,
		Id = 27000713,
		SubstituteAction = 27000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			27000635,
			27000624
		}
	},
	[27000714] = {
		RandomWeight = 10,
		Id = 27000714,
		SubstituteAction = 27000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			27000635,
			27000632
		}
	},
	[27001501] = {
		RandomWeight = 5,
		Id = 27001501,
		SubstituteAction = 27001503,
		ConditionIDList = {
			300,
			401,
			101
		},
		ActionUnitIDList = {
			27001600,
			27001601,
			27001602,
			27001603,
			27001604
		}
	},
	[27001502] = {
		RandomWeight = 5,
		Id = 27001502,
		SubstituteAction = 27001504,
		ConditionIDList = {
			300,
			401,
			101
		},
		ActionUnitIDList = {
			27001610,
			27001611,
			27001612,
			27001613,
			27001614
		}
	},
	[27001503] = {
		Id = 27001503,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			401,
			101
		},
		ActionUnitIDList = {
			27001605,
			27001606
		}
	},
	[27001504] = {
		Id = 27001504,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			401,
			101
		},
		ActionUnitIDList = {
			27001615,
			27001616
		}
	},
	[27001511] = {
		RandomWeight = 5,
		Id = 27001511,
		SubstituteAction = 27001513,
		ConditionIDList = {
			300,
			402,
			213,
			101
		},
		ActionUnitIDList = {
			27001620,
			27001621,
			27001622
		}
	},
	[27001512] = {
		RandomWeight = 5,
		Id = 27001512,
		SubstituteAction = 27001514,
		ConditionIDList = {
			300,
			402,
			213,
			101
		},
		ActionUnitIDList = {
			27001630,
			27001631,
			27001632
		}
	},
	[27001513] = {
		Id = 27001513,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			402,
			101
		},
		ActionUnitIDList = {
			27001623,
			27001624
		}
	},
	[27001514] = {
		Id = 27001514,
		RandomWeight = 5,
		ConditionIDList = {
			300,
			402,
			101
		},
		ActionUnitIDList = {
			27001633,
			27001634
		}
	},
	[27001521] = {
		RandomWeight = 5,
		Id = 27001521,
		SubstituteAction = 27001513,
		ConditionIDList = {
			300,
			402,
			203,
			101
		},
		ActionUnitIDList = {
			27001620,
			27001625,
			27001624
		}
	},
	[27001522] = {
		RandomWeight = 5,
		Id = 27001522,
		SubstituteAction = 27001514,
		ConditionIDList = {
			300,
			402,
			203,
			101
		},
		ActionUnitIDList = {
			27001630,
			27001635,
			27001634
		}
	},
	[27001601] = {
		RandomWeight = 10,
		Id = 27001601,
		SubstituteAction = 27001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101,
			27001640
		}
	},
	[27001602] = {
		RandomWeight = 10,
		Id = 27001602,
		SubstituteAction = 27001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000100,
			27001640
		}
	},
	[27001603] = {
		RandomWeight = 30,
		Id = 27001603,
		SubstituteAction = 27001606,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101,
			27001642
		}
	},
	[27001604] = {
		RandomWeight = 30,
		Id = 27001604,
		SubstituteAction = 27001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27000100,
			27001642
		}
	},
	[27001605] = {
		Id = 27001605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27001641
		}
	},
	[27001606] = {
		Id = 27001606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27001643
		}
	},
	[27001607] = {
		RandomWeight = 10,
		Id = 27001607,
		SubstituteAction = 27001605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27001640
		}
	},
	[27001608] = {
		RandomWeight = 30,
		Id = 27001608,
		SubstituteAction = 27001606,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			27001642
		}
	},
	[27001611] = {
		RandomWeight = 30,
		Id = 27001611,
		SubstituteAction = 27001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			111,
			27001650
		}
	},
	[27001612] = {
		RandomWeight = 30,
		Id = 27001612,
		SubstituteAction = 27001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000100,
			27001650,
			27001651
		}
	},
	[27001613] = {
		RandomWeight = 30,
		Id = 27001613,
		SubstituteAction = 27001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			111,
			27001652
		}
	},
	[27001614] = {
		RandomWeight = 30,
		Id = 27001614,
		SubstituteAction = 27001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27000100,
			27001652,
			27001653
		}
	},
	[27001615] = {
		Id = 27001615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			27001651
		}
	},
	[27001616] = {
		Id = 27001616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			27001653
		}
	},
	[27001617] = {
		RandomWeight = 30,
		Id = 27001617,
		SubstituteAction = 27001615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27001650,
			27001651
		}
	},
	[27001618] = {
		RandomWeight = 30,
		Id = 27001618,
		SubstituteAction = 27001616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			27001652,
			27001653
		}
	},
	[27001621] = {
		RandomWeight = 30,
		Id = 27001621,
		SubstituteAction = 27001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			111,
			27001650
		}
	},
	[27001622] = {
		RandomWeight = 30,
		Id = 27001622,
		SubstituteAction = 27001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27001635,
			27001624
		}
	},
	[27001623] = {
		RandomWeight = 30,
		Id = 27001623,
		SubstituteAction = 27001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			111,
			27001652
		}
	},
	[27001624] = {
		RandomWeight = 30,
		Id = 27001624,
		SubstituteAction = 27001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27001635,
			27001632
		}
	},
	[27001625] = {
		RandomWeight = 30,
		Id = 27001625,
		SubstituteAction = 27001615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27001661
		}
	},
	[27001626] = {
		RandomWeight = 30,
		Id = 27001626,
		SubstituteAction = 27001616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			27001662
		}
	},
	[27001701] = {
		RandomWeight = 30,
		Id = 27001701,
		SubstituteAction = 27001503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			27001603,
			27001604
		}
	},
	[27001702] = {
		RandomWeight = 10,
		Id = 27001702,
		SubstituteAction = 27001504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			27001613,
			27001614
		}
	},
	[27001711] = {
		SubstituteAction = 27001513,
		RandomWeight = 10,
		Id = 27001711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[27001712] = {
		RandomWeight = 10,
		Id = 27001712,
		SubstituteAction = 27001514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			27001631,
			27001632
		}
	},
	[27001713] = {
		RandomWeight = 10,
		Id = 27001713,
		SubstituteAction = 27001513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			27001635,
			27001624
		}
	},
	[27001714] = {
		RandomWeight = 10,
		Id = 27001714,
		SubstituteAction = 27001514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			27001635,
			27001632
		}
	},
	[27000801] = {
		isDailyAction = true,
		Id = 27000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			27000810,
			27000811,
			27000812,
			27000813
		}
	},
	[27000802] = {
		isDailyAction = true,
		Id = 27000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			27000820,
			27000821,
			27000822,
			27000823
		}
	},
	[27000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 27000803,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			27000830,
			27000831,
			27000832,
			27000833
		}
	},
	[27000804] = {
		isDailyAction = true,
		Id = 27000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			27000840,
			27000841,
			27000842,
			27000843
		}
	},
	[27000805] = {
		isDailyAction = true,
		Id = 27000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			27000850,
			27000851,
			27000852,
			27000853
		}
	},
	[27005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 27005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[27005002] = {
		Id = 27005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			27000100,
			27000110,
			27000111,
			27000112,
			27000113,
			27000120
		}
	},
	[28000001] = {
		Id = 28000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[28000002] = {
		Id = 28000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[28000003] = {
		Id = 28000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[28000004] = {
		Id = 28000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			28000010
		}
	},
	[28000005] = {
		Id = 28000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			28000020
		}
	},
	[28000011] = {
		RandomWeight = 10,
		Id = 28000011,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000110,
			28000100,
			28000110,
			28000120
		}
	},
	[28000012] = {
		RandomWeight = 10,
		Id = 28000012,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000130
		}
	},
	[28000013] = {
		RandomWeight = 10,
		Id = 28000013,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000110,
			28000100,
			28000110,
			28000131,
			28000100
		}
	},
	[28000021] = {
		RandomWeight = 20,
		Id = 28000021,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000111,
			28000100,
			28000111,
			28000120
		}
	},
	[28000022] = {
		RandomWeight = 20,
		Id = 28000022,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000112,
			28000100,
			28000112,
			28000120
		}
	},
	[28000023] = {
		RandomWeight = 20,
		Id = 28000023,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000113,
			28000100,
			28000113,
			28000120
		}
	},
	[28000024] = {
		RandomWeight = 20,
		Id = 28000024,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000140
		}
	},
	[28000025] = {
		RandomWeight = 20,
		Id = 28000025,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			28000110,
			28000100,
			28000110,
			28000141,
			28000100
		}
	},
	[28000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 28000026,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			28000150
		}
	},
	[28000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 28000031,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101,
			808
		},
		ActionUnitIDList = {
			28000151
		}
	},
	[28000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 28000041,
		SubstituteAction = 28000004,
		ConditionIDList = {
			101,
			813
		},
		ActionUnitIDList = {
			28000152
		}
	},
	[28000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 28000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			28000210
		}
	},
	[28000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 28000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			28000211
		}
	},
	[28000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 28000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			28000210
		}
	},
	[28000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 28000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			28000211
		}
	},
	[28000121] = {
		Id = 28000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[28000122] = {
		Id = 28000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[28000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 28000201,
		SubstituteAction = 28000005,
		ActionUnitIDList = {
			28000300,
			28000310
		}
	},
	[28000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 28000202,
		SubstituteAction = 28000005,
		ActionUnitIDList = {
			28000300,
			28000311
		}
	},
	[28000211] = {
		RandomWeight = 10,
		Id = 28000211,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103,
			28000420
		}
	},
	[28000212] = {
		RandomWeight = 10,
		Id = 28000212,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			28000320
		}
	},
	[28000213] = {
		RandomWeight = 60,
		Id = 28000213,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103,
			28000421
		}
	},
	[28000214] = {
		RandomWeight = 60,
		Id = 28000214,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			28000321
		}
	},
	[28000221] = {
		RandomWeight = 10,
		Id = 28000221,
		SubstituteAction = 28000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			28000310
		}
	},
	[28000222] = {
		RandomWeight = 20,
		Id = 28000222,
		SubstituteAction = 28000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			28000311
		}
	},
	[28000231] = {
		isDailyAction = true,
		Id = 28000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			28000330
		}
	},
	[28000232] = {
		isDailyAction = true,
		Id = 28000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			28000331
		}
	},
	[28000301] = {
		Id = 28000301,
		SubstituteAction = 28000005,
		RandomWeight = 20,
		ActionUnitIDList = {
			28000400,
			28000410
		}
	},
	[28000302] = {
		Id = 28000302,
		SubstituteAction = 28000005,
		RandomWeight = 80,
		ActionUnitIDList = {
			28000400,
			28000411
		}
	},
	[28000311] = {
		Id = 28000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[28000312] = {
		RandomWeight = 10,
		Id = 28000312,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			28000420
		}
	},
	[28000313] = {
		Id = 28000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[28000314] = {
		RandomWeight = 60,
		Id = 28000314,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			28000421
		}
	},
	[28000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000321,
		SubstituteAction = 28000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			28000410
		}
	},
	[28000322] = {
		RandomWeight = 20,
		Id = 28000322,
		SubstituteAction = 28000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			28000411
		}
	},
	[28000331] = {
		isDailyAction = true,
		Id = 28000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			28000430
		}
	},
	[28000332] = {
		isDailyAction = true,
		Id = 28000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			28000431
		}
	},
	[28000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 28000401,
		SubstituteAction = 28000005,
		ActionUnitIDList = {
			28000500,
			28000510
		}
	},
	[28000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 28000402,
		SubstituteAction = 28000005,
		ActionUnitIDList = {
			28000500,
			28000511
		}
	},
	[28000411] = {
		Id = 28000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[28000412] = {
		RandomWeight = 10,
		Id = 28000412,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			28000520
		}
	},
	[28000413] = {
		Id = 28000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[28000414] = {
		RandomWeight = 60,
		Id = 28000414,
		SubstituteAction = 28000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			28000521
		}
	},
	[28000421] = {
		RandomWeight = 10,
		Id = 28000421,
		SubstituteAction = 28000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			28000510
		}
	},
	[28000422] = {
		RandomWeight = 20,
		Id = 28000422,
		SubstituteAction = 28000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			28000511
		}
	},
	[28000431] = {
		isDailyAction = true,
		Id = 28000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			28000530
		}
	},
	[28000432] = {
		isDailyAction = true,
		Id = 28000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			28000531
		}
	},
	[28000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000501,
		SubstituteAction = 28000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000600,
			28000601,
			28000602,
			28000603,
			28000604
		}
	},
	[28000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000502,
		SubstituteAction = 28000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000610,
			28000611,
			28000612,
			28000613,
			28000614
		}
	},
	[28001501] = {
		RandomWeight = 10,
		Id = 28001501,
		SubstituteAction = 28001503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000600,
			28000601,
			28000602,
			28000603,
			28000604
		}
	},
	[28001502] = {
		RandomWeight = 10,
		Id = 28001502,
		SubstituteAction = 28001504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000610,
			28000611,
			28000612,
			28000613,
			28000614
		}
	},
	[28002501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002501,
		SubstituteAction = 28002503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000600,
			28000601,
			28000602,
			28000603,
			28000604
		}
	},
	[28002502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002502,
		SubstituteAction = 28002504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000610,
			28000611,
			28000612,
			28000613,
			28000614
		}
	},
	[28000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000605,
			28000606
		}
	},
	[28000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000615,
			28000616
		}
	},
	[28001503] = {
		Id = 28001503,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000605,
			28000606
		}
	},
	[28001504] = {
		Id = 28001504,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000615,
			28000616
		}
	},
	[28002503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000605,
			28000606
		}
	},
	[28002504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000615,
			28000616
		}
	},
	[28000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000511,
		SubstituteAction = 28000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000620,
			28000621,
			28000622
		}
	},
	[28000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000512,
		SubstituteAction = 28000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000630,
			28000631,
			28000632
		}
	},
	[28001511] = {
		RandomWeight = 10,
		Id = 28001511,
		SubstituteAction = 28001513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000620,
			28000621,
			28000622
		}
	},
	[28001512] = {
		RandomWeight = 10,
		Id = 28001512,
		SubstituteAction = 28001514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000630,
			28000631,
			28000632
		}
	},
	[28002511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002511,
		SubstituteAction = 28002513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000620,
			28000621,
			28000622
		}
	},
	[28002512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002512,
		SubstituteAction = 28002514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000630,
			28000631,
			28000632
		}
	},
	[28000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000623,
			28000624
		}
	},
	[28000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000633,
			28000634
		}
	},
	[28001513] = {
		Id = 28001513,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000623,
			28000624
		}
	},
	[28001514] = {
		Id = 28001514,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000633,
			28000634
		}
	},
	[28002513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000623,
			28000624
		}
	},
	[28002514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000633,
			28000634
		}
	},
	[28000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000521,
		SubstituteAction = 28000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000620,
			28000625,
			28000624
		}
	},
	[28000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28000522,
		SubstituteAction = 28000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000630,
			28000635,
			28000634
		}
	},
	[28001521] = {
		RandomWeight = 10,
		Id = 28001521,
		SubstituteAction = 28001513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000620,
			28000625,
			28000624
		}
	},
	[28001522] = {
		RandomWeight = 10,
		Id = 28001522,
		SubstituteAction = 28001514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000630,
			28000635,
			28000634
		}
	},
	[28002521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002521,
		SubstituteAction = 28002513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000620,
			28000625,
			28000624
		}
	},
	[28002522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 28002522,
		SubstituteAction = 28002514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000630,
			28000635,
			28000634
		}
	},
	[28000601] = {
		Id = 28000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[28000602] = {
		RandomWeight = 10,
		Id = 28000602,
		SubstituteAction = 28000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000100,
			28000640
		}
	},
	[28000603] = {
		Id = 28000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[28000604] = {
		RandomWeight = 30,
		Id = 28000604,
		SubstituteAction = 28000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000100,
			28000642
		}
	},
	[28000605] = {
		Id = 28000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000641
		}
	},
	[28000606] = {
		Id = 28000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000643
		}
	},
	[28000607] = {
		RandomWeight = 10,
		Id = 28000607,
		SubstituteAction = 28000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000640
		}
	},
	[28000608] = {
		RandomWeight = 30,
		Id = 28000608,
		SubstituteAction = 28000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			28000642
		}
	},
	[28000611] = {
		Id = 28000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[28000612] = {
		RandomWeight = 30,
		Id = 28000612,
		SubstituteAction = 28000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000100,
			28000650,
			28000651
		}
	},
	[28000613] = {
		Id = 28000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[28000614] = {
		RandomWeight = 30,
		Id = 28000614,
		SubstituteAction = 28000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000100,
			28000652,
			28000653
		}
	},
	[28000615] = {
		Id = 28000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000651
		}
	},
	[28000616] = {
		Id = 28000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			28000653
		}
	},
	[28000617] = {
		RandomWeight = 30,
		Id = 28000617,
		SubstituteAction = 28000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000650,
			28000651
		}
	},
	[28000618] = {
		RandomWeight = 30,
		Id = 28000618,
		SubstituteAction = 28000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			28000652,
			28000653
		}
	},
	[28000621] = {
		Id = 28000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[28000622] = {
		RandomWeight = 30,
		Id = 28000622,
		SubstituteAction = 28000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000635,
			28000624
		}
	},
	[28000623] = {
		Id = 28000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[28000624] = {
		RandomWeight = 30,
		Id = 28000624,
		SubstituteAction = 28000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000635,
			28000632
		}
	},
	[28000625] = {
		RandomWeight = 30,
		Id = 28000625,
		SubstituteAction = 28000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000661
		}
	},
	[28000626] = {
		RandomWeight = 30,
		Id = 28000626,
		SubstituteAction = 28000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			28000662
		}
	},
	[28000701] = {
		RandomWeight = 30,
		Id = 28000701,
		SubstituteAction = 28000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			28000603,
			28000604
		}
	},
	[28000702] = {
		RandomWeight = 10,
		Id = 28000702,
		SubstituteAction = 28000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			28000613,
			28000614
		}
	},
	[28000711] = {
		SubstituteAction = 28000513,
		RandomWeight = 10,
		Id = 28000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[28000712] = {
		RandomWeight = 10,
		Id = 28000712,
		SubstituteAction = 28000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			28000631,
			28000632
		}
	},
	[28000713] = {
		RandomWeight = 10,
		Id = 28000713,
		SubstituteAction = 28000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			28000635,
			28000624
		}
	},
	[28000714] = {
		RandomWeight = 10,
		Id = 28000714,
		SubstituteAction = 28000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			28000635,
			28000632
		}
	},
	[28000721] = {
		RandomWeight = 50,
		Id = 28000721,
		SubstituteAction = 28000605,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101,
			28000642
		}
	},
	[28000722] = {
		RandomWeight = 50,
		Id = 28000722,
		SubstituteAction = 28000605,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105,
			28000650
		}
	},
	[28000723] = {
		Id = 28000723,
		RandomWeight = 10,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[28000724] = {
		Id = 28000724,
		RandomWeight = 10,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[28000801] = {
		Id = 28000801,
		RandomWeight = 50,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			28000810,
			28000811,
			28000812,
			28000813
		}
	},
	[28000802] = {
		Id = 28000802,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			28000820,
			28000821,
			28000822,
			28000823
		}
	},
	[28000803] = {
		Id = 28000803,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			28000830,
			28000831,
			28000832,
			28000833
		}
	},
	[28000804] = {
		Id = 28000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			28000820,
			28000831,
			28000832,
			28000833
		}
	},
	[28000805] = {
		Id = 28000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			28000830,
			28000831,
			28000832,
			28000833
		}
	},
	[28000806] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 28000806,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			28000840,
			28000841,
			28000842,
			28000843
		}
	},
	[28000807] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 28000807,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			28000850,
			28000851,
			28000852,
			28000853
		}
	},
	[28005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 28005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[28005002] = {
		Id = 28005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			28000100,
			28000110,
			28000111,
			28000112,
			28000113,
			28000120
		}
	},
	[29000001] = {
		Id = 29000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[29000002] = {
		Id = 29000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[29000003] = {
		Id = 29000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[29000004] = {
		Id = 29000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			29000010
		}
	},
	[29000005] = {
		Id = 29000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			29000020
		}
	},
	[29000011] = {
		RandomWeight = 10,
		Id = 29000011,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000110,
			29000100,
			29000110,
			29000120
		}
	},
	[29000012] = {
		RandomWeight = 10,
		Id = 29000012,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000130
		}
	},
	[29000013] = {
		RandomWeight = 10,
		Id = 29000013,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000110,
			29000100,
			29000110,
			29000131,
			29000100
		}
	},
	[29000021] = {
		RandomWeight = 20,
		Id = 29000021,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000111,
			29000100,
			29000111,
			29000120
		}
	},
	[29000022] = {
		RandomWeight = 20,
		Id = 29000022,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000112,
			29000100,
			29000112,
			29000120
		}
	},
	[29000023] = {
		RandomWeight = 20,
		Id = 29000023,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000113,
			29000100,
			29000113,
			29000120
		}
	},
	[29000024] = {
		RandomWeight = 20,
		Id = 29000024,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000140
		}
	},
	[29000025] = {
		RandomWeight = 20,
		Id = 29000025,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000110,
			29000100,
			29000110,
			29000141,
			29000100
		}
	},
	[29000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 29000026,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			29000150
		}
	},
	[29000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 29000031,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101,
			817
		},
		ActionUnitIDList = {
			29000151
		}
	},
	[29000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 29000041,
		SubstituteAction = 29000004,
		ConditionIDList = {
			101,
			822
		},
		ActionUnitIDList = {
			29000152
		}
	},
	[29000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 29000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			29000210
		}
	},
	[29000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 29000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			29000211
		}
	},
	[29000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 29000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			29000210
		}
	},
	[29000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 29000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			29000211
		}
	},
	[29000121] = {
		Id = 29000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[29000122] = {
		Id = 29000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[29000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 29000201,
		SubstituteAction = 29000005,
		ActionUnitIDList = {
			29000300,
			29000310
		}
	},
	[29000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 29000202,
		SubstituteAction = 29000005,
		ActionUnitIDList = {
			29000300,
			29000311
		}
	},
	[29000211] = {
		Id = 29000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[29000212] = {
		RandomWeight = 10,
		Id = 29000212,
		SubstituteAction = 29000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			29000320
		}
	},
	[29000213] = {
		Id = 29000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[29000214] = {
		RandomWeight = 60,
		Id = 29000214,
		SubstituteAction = 29000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			29000321
		}
	},
	[29000221] = {
		RandomWeight = 10,
		Id = 29000221,
		SubstituteAction = 29000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			29000310
		}
	},
	[29000222] = {
		RandomWeight = 20,
		Id = 29000222,
		SubstituteAction = 29000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			29000311
		}
	},
	[29000231] = {
		isDailyAction = true,
		Id = 29000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			29000330
		}
	},
	[29000232] = {
		isDailyAction = true,
		Id = 29000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			29000331
		}
	},
	[29000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 29000301,
		SubstituteAction = 29000005,
		ActionUnitIDList = {
			29000400,
			29000410
		}
	},
	[29000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 29000302,
		SubstituteAction = 29000005,
		ActionUnitIDList = {
			29000400,
			29000411
		}
	},
	[29000311] = {
		Id = 29000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[29000312] = {
		RandomWeight = 10,
		Id = 29000312,
		SubstituteAction = 29000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			29000420
		}
	},
	[29000313] = {
		Id = 29000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[29000314] = {
		RandomWeight = 60,
		Id = 29000314,
		SubstituteAction = 29000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			29000421
		}
	},
	[29000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000321,
		SubstituteAction = 29000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			29000410
		}
	},
	[29000322] = {
		RandomWeight = 20,
		Id = 29000322,
		SubstituteAction = 29000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			29000411
		}
	},
	[29000331] = {
		isDailyAction = true,
		Id = 29000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			29000430
		}
	},
	[29000332] = {
		isDailyAction = true,
		Id = 29000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			29000431
		}
	},
	[29000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 29000401,
		SubstituteAction = 29000005,
		ActionUnitIDList = {
			29000500,
			29000510
		}
	},
	[29000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 29000402,
		SubstituteAction = 29000005,
		ActionUnitIDList = {
			29000500,
			29000511
		}
	},
	[29000411] = {
		Id = 29000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[29000412] = {
		RandomWeight = 10,
		Id = 29000412,
		SubstituteAction = 29000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			29000520
		}
	},
	[29000413] = {
		Id = 29000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[29000414] = {
		RandomWeight = 60,
		Id = 29000414,
		SubstituteAction = 29000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			29000521
		}
	},
	[29000421] = {
		RandomWeight = 10,
		Id = 29000421,
		SubstituteAction = 29000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			29000510
		}
	},
	[29000422] = {
		RandomWeight = 20,
		Id = 29000422,
		SubstituteAction = 29000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			29000511
		}
	},
	[29000431] = {
		isDailyAction = true,
		Id = 29000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			29000530
		}
	},
	[29000432] = {
		isDailyAction = true,
		Id = 29000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			29000531
		}
	},
	[29000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000501,
		SubstituteAction = 29000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000600,
			29000601,
			29000602,
			29000603,
			29000604
		}
	},
	[29000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000502,
		SubstituteAction = 29000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000610,
			29000611,
			29000612,
			29000613,
			29000614
		}
	},
	[29000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000605,
			29000606
		}
	},
	[29000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000615,
			29000616
		}
	},
	[29000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000511,
		SubstituteAction = 29000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			29000620,
			29000621,
			29000622
		}
	},
	[29000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000512,
		SubstituteAction = 29000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			29000630,
			29000631,
			29000632
		}
	},
	[29000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			29000623,
			29000624
		}
	},
	[29000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			29000633,
			29000634
		}
	},
	[29000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000521,
		SubstituteAction = 29000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			29000620,
			29000625,
			29000624
		}
	},
	[29000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 29000522,
		SubstituteAction = 29000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			29000630,
			29000635,
			29000634
		}
	},
	[29000601] = {
		Id = 29000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[29000602] = {
		RandomWeight = 10,
		Id = 29000602,
		SubstituteAction = 29000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000100,
			29000640
		}
	},
	[29000603] = {
		Id = 29000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[29000604] = {
		RandomWeight = 30,
		Id = 29000604,
		SubstituteAction = 29000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000100,
			29000642
		}
	},
	[29000605] = {
		Id = 29000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000641
		}
	},
	[29000606] = {
		Id = 29000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000643
		}
	},
	[29000607] = {
		RandomWeight = 10,
		Id = 29000607,
		SubstituteAction = 29000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000640
		}
	},
	[29000608] = {
		RandomWeight = 30,
		Id = 29000608,
		SubstituteAction = 29000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			29000642
		}
	},
	[29000611] = {
		Id = 29000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[29000612] = {
		RandomWeight = 30,
		Id = 29000612,
		SubstituteAction = 29000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			29000100,
			29000650,
			29000651
		}
	},
	[29000613] = {
		Id = 29000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[29000614] = {
		RandomWeight = 30,
		Id = 29000614,
		SubstituteAction = 29000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			29000100,
			29000652,
			29000653
		}
	},
	[29000615] = {
		Id = 29000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			29000651
		}
	},
	[29000616] = {
		Id = 29000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			29000653
		}
	},
	[29000617] = {
		RandomWeight = 30,
		Id = 29000617,
		SubstituteAction = 29000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			29000650,
			29000651
		}
	},
	[29000618] = {
		RandomWeight = 30,
		Id = 29000618,
		SubstituteAction = 29000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			29000652,
			29000653
		}
	},
	[29000621] = {
		Id = 29000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[29000622] = {
		RandomWeight = 30,
		Id = 29000622,
		SubstituteAction = 29000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			29000635,
			29000624
		}
	},
	[29000623] = {
		Id = 29000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[29000624] = {
		RandomWeight = 30,
		Id = 29000624,
		SubstituteAction = 29000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			29000635,
			29000632
		}
	},
	[29000625] = {
		RandomWeight = 30,
		Id = 29000625,
		SubstituteAction = 29000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			29000661
		}
	},
	[29000626] = {
		RandomWeight = 30,
		Id = 29000626,
		SubstituteAction = 29000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			29000662
		}
	},
	[29000701] = {
		RandomWeight = 30,
		Id = 29000701,
		SubstituteAction = 29000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			29000603,
			29000604
		}
	},
	[29000702] = {
		RandomWeight = 10,
		Id = 29000702,
		SubstituteAction = 29000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			29000613,
			29000614
		}
	},
	[29000711] = {
		SubstituteAction = 29000513,
		RandomWeight = 10,
		Id = 29000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[29000712] = {
		RandomWeight = 10,
		Id = 29000712,
		SubstituteAction = 29000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			29000631,
			29000632
		}
	},
	[29000713] = {
		RandomWeight = 10,
		Id = 29000713,
		SubstituteAction = 29000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			29000635,
			29000624
		}
	},
	[29000714] = {
		RandomWeight = 10,
		Id = 29000714,
		SubstituteAction = 29000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			29000635,
			29000632
		}
	},
	[29000801] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 29000801,
		ConditionIDList = {
			101,
			213
		},
		ActionUnitIDList = {
			29000810,
			29000811,
			29000812,
			29000813
		}
	},
	[29000802] = {
		Id = 29000802,
		RandomWeight = 5,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			29000820,
			29000821,
			29000822,
			29000823
		}
	},
	[29000803] = {
		isDailyAction = true,
		Id = 29000803,
		RandomWeight = 100,
		ActionUnitIDList = {
			29000830,
			29000831,
			29000832,
			29000833
		}
	},
	[29000804] = {
		Id = 29000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			105,
			29000835,
			29000836,
			29000837
		}
	},
	[29000805] = {
		Id = 29000805,
		RandomWeight = 100,
		ActionUnitIDList = {
			29000835,
			29000836,
			29000837
		}
	},
	[29000806] = {
		Id = 29000806,
		RandomWeight = 100,
		ActionUnitIDList = {
			29000830,
			29000831,
			29000832,
			29000833
		}
	},
	[29000807] = {
		isDailyAction = true,
		Id = 29000807,
		RandomWeight = 30,
		ActionUnitIDList = {
			29000840,
			29000841,
			29000842
		}
	},
	[29000808] = {
		isDailyAction = true,
		Id = 29000808,
		RandomWeight = 30,
		ActionUnitIDList = {
			29000850,
			29000851,
			29000852
		}
	},
	[29005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 29005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[29005002] = {
		Id = 29005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			29000100,
			29000110,
			29000111,
			29000112,
			29000113,
			29000120
		}
	},
	[30000001] = {
		Id = 30000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[30000002] = {
		Id = 30000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[30000003] = {
		Id = 30000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[30000004] = {
		Id = 30000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			30000010
		}
	},
	[30000005] = {
		Id = 30000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			30000020
		}
	},
	[30000006] = {
		Id = 30000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			109
		}
	},
	[30000011] = {
		RandomWeight = 10,
		Id = 30000011,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000110,
			30000100,
			30000110,
			30000120
		}
	},
	[30000012] = {
		RandomWeight = 10,
		Id = 30000012,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000130
		}
	},
	[30000013] = {
		RandomWeight = 10,
		Id = 30000013,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000110,
			30000100,
			30000110,
			30000131,
			30000100
		}
	},
	[30000021] = {
		RandomWeight = 20,
		Id = 30000021,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000111,
			30000100,
			30000111,
			30000120
		}
	},
	[30000022] = {
		RandomWeight = 20,
		Id = 30000022,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000112,
			30000100,
			30000112,
			30000120
		}
	},
	[30000023] = {
		RandomWeight = 20,
		Id = 30000023,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000113,
			30000100,
			30000113,
			30000120
		}
	},
	[30000024] = {
		RandomWeight = 20,
		Id = 30000024,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000140
		}
	},
	[30000025] = {
		RandomWeight = 20,
		Id = 30000025,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			30000110,
			30000100,
			30000110,
			30000141,
			30000100
		}
	},
	[30000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 30000026,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			30000150
		}
	},
	[30000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 30000031,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			30000151
		}
	},
	[30000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 30000041,
		SubstituteAction = 30000004,
		ConditionIDList = {
			101,
			810
		},
		ActionUnitIDList = {
			30000152
		}
	},
	[30000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 30000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			30000210
		}
	},
	[30000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 30000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			30000211
		}
	},
	[30000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 30000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			30000210
		}
	},
	[30000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 30000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			30000211
		}
	},
	[30000121] = {
		Id = 30000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[30000122] = {
		Id = 30000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[30000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 30000201,
		SubstituteAction = 30000005,
		ActionUnitIDList = {
			30000300,
			30000310
		}
	},
	[30000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 30000202,
		SubstituteAction = 30000005,
		ActionUnitIDList = {
			30000300,
			30000311
		}
	},
	[30000211] = {
		Id = 30000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[30000212] = {
		RandomWeight = 10,
		Id = 30000212,
		SubstituteAction = 30000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			30000320
		}
	},
	[30000213] = {
		Id = 30000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[30000214] = {
		RandomWeight = 60,
		Id = 30000214,
		SubstituteAction = 30000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			30000321
		}
	},
	[30000221] = {
		RandomWeight = 10,
		Id = 30000221,
		SubstituteAction = 30000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			30000310
		}
	},
	[30000222] = {
		RandomWeight = 20,
		Id = 30000222,
		SubstituteAction = 30000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			30000311
		}
	},
	[30000231] = {
		isDailyAction = true,
		Id = 30000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			30000330
		}
	},
	[30000232] = {
		isDailyAction = true,
		Id = 30000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			30000331
		}
	},
	[30000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 30000301,
		SubstituteAction = 30000005,
		ActionUnitIDList = {
			30000400,
			30000410
		}
	},
	[30000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 30000302,
		SubstituteAction = 30000005,
		ActionUnitIDList = {
			30000400,
			30000411
		}
	},
	[30000311] = {
		Id = 30000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[30000312] = {
		RandomWeight = 10,
		Id = 30000312,
		SubstituteAction = 30000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			30000420
		}
	},
	[30000313] = {
		Id = 30000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[30000314] = {
		RandomWeight = 60,
		Id = 30000314,
		SubstituteAction = 30000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			30000421
		}
	},
	[30000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000321,
		SubstituteAction = 30000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			30000410
		}
	},
	[30000322] = {
		RandomWeight = 20,
		Id = 30000322,
		SubstituteAction = 30000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			30000411
		}
	},
	[30000331] = {
		isDailyAction = true,
		Id = 30000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			30000430
		}
	},
	[30000332] = {
		isDailyAction = true,
		Id = 30000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			30000431
		}
	},
	[30000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 30000401,
		SubstituteAction = 30000005,
		ActionUnitIDList = {
			30000500,
			30000510
		}
	},
	[30000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 30000402,
		SubstituteAction = 30000005,
		ActionUnitIDList = {
			30000500,
			30000511
		}
	},
	[30000411] = {
		Id = 30000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[30000412] = {
		RandomWeight = 10,
		Id = 30000412,
		SubstituteAction = 30000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			30000520
		}
	},
	[30000413] = {
		Id = 30000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[30000414] = {
		RandomWeight = 60,
		Id = 30000414,
		SubstituteAction = 30000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			30000521
		}
	},
	[30000421] = {
		RandomWeight = 10,
		Id = 30000421,
		SubstituteAction = 30000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			30000510
		}
	},
	[30000422] = {
		RandomWeight = 20,
		Id = 30000422,
		SubstituteAction = 30000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			30000511
		}
	},
	[30000431] = {
		isDailyAction = true,
		Id = 30000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			30000530
		}
	},
	[30000432] = {
		isDailyAction = true,
		Id = 30000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			30000531
		}
	},
	[30000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000501,
		SubstituteAction = 30000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000600,
			30000601,
			30000602,
			30000603,
			30000604
		}
	},
	[30000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000502,
		SubstituteAction = 30000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000610,
			30000611,
			30000612,
			30000613,
			30000614
		}
	},
	[30000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000605,
			30000606
		}
	},
	[30000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000615,
			30000616
		}
	},
	[30000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000511,
		SubstituteAction = 30000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			30000620,
			30000621,
			30000622
		}
	},
	[30000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000512,
		SubstituteAction = 30000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			30000630,
			30000631,
			30000632
		}
	},
	[30000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			30000623,
			30000624
		}
	},
	[30000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			30000633,
			30000634
		}
	},
	[30000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000521,
		SubstituteAction = 30000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			30000620,
			30000625,
			30000624
		}
	},
	[30000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 30000522,
		SubstituteAction = 30000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			30000630,
			30000635,
			30000634
		}
	},
	[30000601] = {
		Id = 30000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[30000602] = {
		RandomWeight = 10,
		Id = 30000602,
		SubstituteAction = 30000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000100,
			30000640
		}
	},
	[30000603] = {
		Id = 30000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[30000604] = {
		RandomWeight = 30,
		Id = 30000604,
		SubstituteAction = 30000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000100,
			30000642
		}
	},
	[30000605] = {
		Id = 30000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000641
		}
	},
	[30000606] = {
		Id = 30000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000643
		}
	},
	[30000607] = {
		RandomWeight = 10,
		Id = 30000607,
		SubstituteAction = 30000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000640
		}
	},
	[30000608] = {
		RandomWeight = 30,
		Id = 30000608,
		SubstituteAction = 30000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			30000642
		}
	},
	[30000611] = {
		Id = 30000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[30000612] = {
		RandomWeight = 30,
		Id = 30000612,
		SubstituteAction = 30000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			30000100,
			30000650,
			30000651
		}
	},
	[30000613] = {
		Id = 30000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[30000614] = {
		RandomWeight = 30,
		Id = 30000614,
		SubstituteAction = 30000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			30000100,
			30000652,
			30000653
		}
	},
	[30000615] = {
		Id = 30000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			30000651
		}
	},
	[30000616] = {
		Id = 30000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			30000653
		}
	},
	[30000617] = {
		RandomWeight = 30,
		Id = 30000617,
		SubstituteAction = 30000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			30000650,
			30000651
		}
	},
	[30000618] = {
		RandomWeight = 30,
		Id = 30000618,
		SubstituteAction = 30000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			30000652,
			30000653
		}
	},
	[30000621] = {
		Id = 30000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[30000622] = {
		RandomWeight = 30,
		Id = 30000622,
		SubstituteAction = 30000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			30000635,
			30000624
		}
	},
	[30000623] = {
		Id = 30000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[30000624] = {
		RandomWeight = 30,
		Id = 30000624,
		SubstituteAction = 30000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			30000635,
			30000632
		}
	},
	[30000625] = {
		RandomWeight = 30,
		Id = 30000625,
		SubstituteAction = 30000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			30000661
		}
	},
	[30000626] = {
		RandomWeight = 30,
		Id = 30000626,
		SubstituteAction = 30000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			30000662
		}
	},
	[30000701] = {
		RandomWeight = 30,
		Id = 30000701,
		SubstituteAction = 30000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			30000603,
			30000604
		}
	},
	[30000702] = {
		RandomWeight = 10,
		Id = 30000702,
		SubstituteAction = 30000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			30000613,
			30000614
		}
	},
	[30000711] = {
		SubstituteAction = 30000513,
		RandomWeight = 10,
		Id = 30000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[30000712] = {
		RandomWeight = 10,
		Id = 30000712,
		SubstituteAction = 30000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			30000631,
			30000632
		}
	},
	[30000713] = {
		RandomWeight = 10,
		Id = 30000713,
		SubstituteAction = 30000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			30000635,
			30000624
		}
	},
	[30000714] = {
		RandomWeight = 10,
		Id = 30000714,
		SubstituteAction = 30000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			30000635,
			30000632
		}
	},
	[30000801] = {
		Id = 30000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			30000810,
			30000811,
			30000812,
			30000813
		}
	},
	[30000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 30000802,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			30000820,
			30000821,
			30000822,
			30000823
		}
	},
	[30000803] = {
		Id = 30000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			30000830,
			30000831,
			30000832,
			30000833
		}
	},
	[30000804] = {
		isDailyAction = true,
		Id = 30000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			30000840,
			30000841,
			30000842,
			30000843
		}
	},
	[30000805] = {
		isDailyAction = true,
		Id = 30000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			30000850,
			30000851,
			30000852,
			30000853
		}
	},
	[30005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 30005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[30005002] = {
		Id = 30005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			30000100,
			30000110,
			30000111,
			30000112,
			30000113,
			30000120
		}
	},
	[31000001] = {
		Id = 31000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[31000002] = {
		Id = 31000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[31000003] = {
		Id = 31000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[31000004] = {
		Id = 31000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			31000010
		}
	},
	[31000005] = {
		Id = 31000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			31000020
		}
	},
	[31000011] = {
		RandomWeight = 10,
		Id = 31000011,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000110,
			31000100,
			31000110,
			31000120
		}
	},
	[31000012] = {
		RandomWeight = 10,
		Id = 31000012,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000130
		}
	},
	[31000013] = {
		RandomWeight = 10,
		Id = 31000013,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000110,
			31000100,
			31000110,
			31000131,
			31000100
		}
	},
	[31000021] = {
		RandomWeight = 20,
		Id = 31000021,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000111,
			31000100,
			31000111,
			31000120
		}
	},
	[31000022] = {
		RandomWeight = 20,
		Id = 31000022,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000112,
			31000100,
			31000112,
			31000120
		}
	},
	[31000023] = {
		RandomWeight = 20,
		Id = 31000023,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000113,
			31000100,
			31000113,
			31000120
		}
	},
	[31000024] = {
		RandomWeight = 20,
		Id = 31000024,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000140
		}
	},
	[31000025] = {
		RandomWeight = 20,
		Id = 31000025,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			31000110,
			31000100,
			31000110,
			31000141,
			31000100
		}
	},
	[31000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 31000026,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			31000150
		}
	},
	[31000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 31000031,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101,
			807
		},
		ActionUnitIDList = {
			31000151
		}
	},
	[31000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 31000041,
		SubstituteAction = 31000004,
		ConditionIDList = {
			101,
			811
		},
		ActionUnitIDList = {
			31000152
		}
	},
	[31000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 31000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			31000210
		}
	},
	[31000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 31000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			31000211
		}
	},
	[31000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 31000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			31000210
		}
	},
	[31000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 31000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			31000211
		}
	},
	[31000121] = {
		Id = 31000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[31000122] = {
		Id = 31000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[31000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 31000201,
		SubstituteAction = 31000005,
		ActionUnitIDList = {
			31000300,
			31000310
		}
	},
	[31000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 31000202,
		SubstituteAction = 31000005,
		ActionUnitIDList = {
			31000300,
			31000311
		}
	},
	[31000211] = {
		Id = 31000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[31000212] = {
		RandomWeight = 10,
		Id = 31000212,
		SubstituteAction = 31000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			31000320
		}
	},
	[31000213] = {
		Id = 31000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[31000214] = {
		RandomWeight = 60,
		Id = 31000214,
		SubstituteAction = 31000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			31000321
		}
	},
	[31000221] = {
		RandomWeight = 10,
		Id = 31000221,
		SubstituteAction = 31000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			31000310
		}
	},
	[31000222] = {
		RandomWeight = 20,
		Id = 31000222,
		SubstituteAction = 31000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			31000311
		}
	},
	[31000231] = {
		isDailyAction = true,
		Id = 31000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			31000330
		}
	},
	[31000232] = {
		isDailyAction = true,
		Id = 31000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			31000331
		}
	},
	[31000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 31000301,
		SubstituteAction = 31000005,
		ActionUnitIDList = {
			31000400,
			31000410
		}
	},
	[31000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 31000302,
		SubstituteAction = 31000005,
		ActionUnitIDList = {
			31000400,
			31000411
		}
	},
	[31000311] = {
		Id = 31000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[31000312] = {
		RandomWeight = 10,
		Id = 31000312,
		SubstituteAction = 31000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			31000420
		}
	},
	[31000313] = {
		Id = 31000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[31000314] = {
		RandomWeight = 60,
		Id = 31000314,
		SubstituteAction = 31000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			31000421
		}
	},
	[31000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000321,
		SubstituteAction = 31000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			31000410
		}
	},
	[31000322] = {
		RandomWeight = 20,
		Id = 31000322,
		SubstituteAction = 31000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			31000411
		}
	},
	[31000331] = {
		isDailyAction = true,
		Id = 31000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			31000430
		}
	},
	[31000332] = {
		isDailyAction = true,
		Id = 31000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			31000431
		}
	},
	[31000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 31000401,
		SubstituteAction = 31000005,
		ActionUnitIDList = {
			31000500,
			31000510
		}
	},
	[31000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 31000402,
		SubstituteAction = 31000005,
		ActionUnitIDList = {
			31000500,
			31000511
		}
	},
	[31000411] = {
		Id = 31000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[31000412] = {
		RandomWeight = 10,
		Id = 31000412,
		SubstituteAction = 31000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			31000520
		}
	},
	[31000413] = {
		Id = 31000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[31000414] = {
		RandomWeight = 60,
		Id = 31000414,
		SubstituteAction = 31000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			31000521
		}
	},
	[31000421] = {
		RandomWeight = 10,
		Id = 31000421,
		SubstituteAction = 31000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			31000510
		}
	},
	[31000422] = {
		RandomWeight = 20,
		Id = 31000422,
		SubstituteAction = 31000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			31000511
		}
	},
	[31000431] = {
		isDailyAction = true,
		Id = 31000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			31000530
		}
	},
	[31000432] = {
		isDailyAction = true,
		Id = 31000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			31000531
		}
	},
	[31000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000501,
		SubstituteAction = 31000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000600,
			31000601,
			31000602,
			31000603,
			31000604
		}
	},
	[31000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000502,
		SubstituteAction = 31000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000610,
			31000611,
			31000612,
			31000613,
			31000614
		}
	},
	[31000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000605,
			31000606
		}
	},
	[31000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000615,
			31000616
		}
	},
	[31000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000511,
		SubstituteAction = 31000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			31000620,
			31000621,
			31000622
		}
	},
	[31000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000512,
		SubstituteAction = 31000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			31000630,
			31000631,
			31000632
		}
	},
	[31000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			31000623,
			31000624
		}
	},
	[31000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			31000633,
			31000634
		}
	},
	[31000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000521,
		SubstituteAction = 31000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			31000620,
			31000625,
			31000624
		}
	},
	[31000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 31000522,
		SubstituteAction = 31000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			31000630,
			31000635,
			31000634
		}
	},
	[31000601] = {
		Id = 31000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[31000602] = {
		RandomWeight = 10,
		Id = 31000602,
		SubstituteAction = 31000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000100,
			31000640
		}
	},
	[31000603] = {
		Id = 31000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[31000604] = {
		RandomWeight = 30,
		Id = 31000604,
		SubstituteAction = 31000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000100,
			31000642
		}
	},
	[31000605] = {
		Id = 31000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000641
		}
	},
	[31000606] = {
		Id = 31000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000643
		}
	},
	[31000607] = {
		RandomWeight = 10,
		Id = 31000607,
		SubstituteAction = 31000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000640
		}
	},
	[31000608] = {
		RandomWeight = 30,
		Id = 31000608,
		SubstituteAction = 31000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			31000642
		}
	},
	[31000611] = {
		Id = 31000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[31000612] = {
		RandomWeight = 30,
		Id = 31000612,
		SubstituteAction = 31000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			31000100,
			31000650,
			31000651
		}
	},
	[31000613] = {
		Id = 31000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[31000614] = {
		RandomWeight = 30,
		Id = 31000614,
		SubstituteAction = 31000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			31000100,
			31000652,
			31000653
		}
	},
	[31000615] = {
		Id = 31000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			31000651
		}
	},
	[31000616] = {
		Id = 31000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			31000653
		}
	},
	[31000617] = {
		RandomWeight = 30,
		Id = 31000617,
		SubstituteAction = 31000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			31000650,
			31000651
		}
	},
	[31000618] = {
		RandomWeight = 30,
		Id = 31000618,
		SubstituteAction = 31000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			31000652,
			31000653
		}
	},
	[31000621] = {
		Id = 31000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[31000622] = {
		RandomWeight = 30,
		Id = 31000622,
		SubstituteAction = 31000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			31000635,
			31000624
		}
	},
	[31000623] = {
		Id = 31000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[31000624] = {
		RandomWeight = 30,
		Id = 31000624,
		SubstituteAction = 31000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			31000635,
			31000632
		}
	},
	[31000625] = {
		RandomWeight = 30,
		Id = 31000625,
		SubstituteAction = 31000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			31000661
		}
	},
	[31000626] = {
		RandomWeight = 30,
		Id = 31000626,
		SubstituteAction = 31000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			31000662
		}
	},
	[31000701] = {
		RandomWeight = 30,
		Id = 31000701,
		SubstituteAction = 31000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			31000603,
			31000604
		}
	},
	[31000702] = {
		RandomWeight = 10,
		Id = 31000702,
		SubstituteAction = 31000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			31000613,
			31000614
		}
	},
	[31000711] = {
		SubstituteAction = 31000513,
		RandomWeight = 10,
		Id = 31000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[31000712] = {
		RandomWeight = 10,
		Id = 31000712,
		SubstituteAction = 31000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			31000631,
			31000632
		}
	},
	[31000713] = {
		RandomWeight = 10,
		Id = 31000713,
		SubstituteAction = 31000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			31000635,
			31000624
		}
	},
	[31000714] = {
		RandomWeight = 10,
		Id = 31000714,
		SubstituteAction = 31000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			31000635,
			31000632
		}
	},
	[31000801] = {
		Id = 31000801,
		RandomWeight = 5,
		ActionUnitIDList = {
			31000810,
			31000811,
			31000812,
			31000813
		}
	},
	[31000802] = {
		Id = 31000802,
		RandomWeight = 5,
		ActionUnitIDList = {
			31000820,
			31000821,
			31000822,
			31000823
		}
	},
	[31000803] = {
		Id = 31000803,
		RandomWeight = 5,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			31000830,
			31000831,
			31000832,
			31000833
		}
	},
	[31000804] = {
		isDailyAction = true,
		Id = 31000804,
		RandomWeight = 5,
		ActionUnitIDList = {
			31000840,
			31000841,
			31000842,
			31000843
		}
	},
	[31000805] = {
		isDailyAction = true,
		Id = 31000805,
		RandomWeight = 5,
		ActionUnitIDList = {
			31000850,
			31000851,
			31000852,
			31000853
		}
	},
	[31005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 31005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[31005002] = {
		Id = 31005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			31000100,
			31000110,
			31000111,
			31000112,
			31000113,
			31000120
		}
	},
	[32000001] = {
		Id = 32000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[32000002] = {
		Id = 32000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[32000003] = {
		Id = 32000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[32000004] = {
		Id = 32000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			32000010
		}
	},
	[32000005] = {
		Id = 32000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			32000020
		}
	},
	[32000006] = {
		Id = 32000006,
		RandomWeight = 10,
		ActionUnitIDList = {
			105
		}
	},
	[32000011] = {
		RandomWeight = 10,
		Id = 32000011,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000110,
			32000100,
			32000110,
			32000120
		}
	},
	[32000012] = {
		RandomWeight = 10,
		Id = 32000012,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000130
		}
	},
	[32000013] = {
		RandomWeight = 10,
		Id = 32000013,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000110,
			32000100,
			32000110,
			32000131,
			32000100
		}
	},
	[32000021] = {
		RandomWeight = 20,
		Id = 32000021,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000111,
			32000100,
			32000111,
			32000120
		}
	},
	[32000022] = {
		RandomWeight = 20,
		Id = 32000022,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000112,
			32000100,
			32000112,
			32000120
		}
	},
	[32000023] = {
		RandomWeight = 20,
		Id = 32000023,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000113,
			32000100,
			32000113,
			32000120
		}
	},
	[32000024] = {
		RandomWeight = 20,
		Id = 32000024,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000140
		}
	},
	[32000025] = {
		RandomWeight = 20,
		Id = 32000025,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			32000110,
			32000100,
			32000110,
			32000141,
			32000100
		}
	},
	[32000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 32000026,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			32000150
		}
	},
	[32000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 32000031,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101,
			823
		},
		ActionUnitIDList = {
			32000151
		}
	},
	[32000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 32000041,
		SubstituteAction = 32000004,
		ConditionIDList = {
			101,
			817
		},
		ActionUnitIDList = {
			32000152
		}
	},
	[32000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 32000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			32000210
		}
	},
	[32000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 32000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			32000211
		}
	},
	[32000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 32000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			32000210
		}
	},
	[32000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 32000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			32000211
		}
	},
	[32000121] = {
		Id = 32000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[32000122] = {
		Id = 32000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 32000201,
		SubstituteAction = 32000005,
		ActionUnitIDList = {
			32000300,
			32000310
		}
	},
	[32000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 32000202,
		SubstituteAction = 32000005,
		ActionUnitIDList = {
			32000300,
			32000311
		}
	},
	[32000211] = {
		Id = 32000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[32000212] = {
		RandomWeight = 10,
		Id = 32000212,
		SubstituteAction = 32000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			32000320
		}
	},
	[32000213] = {
		Id = 32000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[32000214] = {
		RandomWeight = 60,
		Id = 32000214,
		SubstituteAction = 32000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			32000321
		}
	},
	[32000221] = {
		RandomWeight = 10,
		Id = 32000221,
		SubstituteAction = 32000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			32000310
		}
	},
	[32000222] = {
		RandomWeight = 20,
		Id = 32000222,
		SubstituteAction = 32000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			32000311
		}
	},
	[32000231] = {
		isDailyAction = true,
		Id = 32000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			32000330
		}
	},
	[32000232] = {
		isDailyAction = true,
		Id = 32000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			32000331
		}
	},
	[32000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 32000301,
		SubstituteAction = 32000005,
		ActionUnitIDList = {
			32000400,
			32000410,
			32000411
		}
	},
	[32000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 32000302,
		SubstituteAction = 32000005,
		ActionUnitIDList = {
			32000400,
			32000410,
			32000411
		}
	},
	[32000311] = {
		Id = 32000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000312] = {
		RandomWeight = 10,
		Id = 32000312,
		SubstituteAction = 32000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			32000420
		}
	},
	[32000313] = {
		Id = 32000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000314] = {
		RandomWeight = 60,
		Id = 32000314,
		SubstituteAction = 32000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			32000421
		}
	},
	[32000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000321,
		SubstituteAction = 32000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			32000410,
			32000411
		}
	},
	[32000322] = {
		RandomWeight = 20,
		Id = 32000322,
		SubstituteAction = 32000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			32000410,
			32000411
		}
	},
	[32000331] = {
		isDailyAction = true,
		Id = 32000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			32000430
		}
	},
	[32000332] = {
		isDailyAction = true,
		Id = 32000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			32000431
		}
	},
	[32000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 32000401,
		SubstituteAction = 32000005,
		ActionUnitIDList = {
			32000500,
			32000510,
			32000511
		}
	},
	[32000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 32000402,
		SubstituteAction = 32000005,
		ActionUnitIDList = {
			32000500,
			32000510,
			32000511
		}
	},
	[32000411] = {
		Id = 32000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000412] = {
		RandomWeight = 10,
		Id = 32000412,
		SubstituteAction = 32000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			32000520
		}
	},
	[32000413] = {
		Id = 32000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000414] = {
		RandomWeight = 60,
		Id = 32000414,
		SubstituteAction = 32000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			32000521
		}
	},
	[32000421] = {
		RandomWeight = 10,
		Id = 32000421,
		SubstituteAction = 32000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			32000510,
			32000511
		}
	},
	[32000422] = {
		RandomWeight = 20,
		Id = 32000422,
		SubstituteAction = 32000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			32000510,
			32000511
		}
	},
	[32000431] = {
		isDailyAction = true,
		Id = 32000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			32000530
		}
	},
	[32000432] = {
		isDailyAction = true,
		Id = 32000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			32000531
		}
	},
	[32000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000501,
		SubstituteAction = 32000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000600,
			32000601,
			32000602,
			32000603,
			32000604
		}
	},
	[32000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000502,
		SubstituteAction = 32000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000610,
			32000611,
			32000612,
			32000613,
			32000614
		}
	},
	[32000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000605,
			32000606
		}
	},
	[32000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000615,
			32000616
		}
	},
	[32000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000511,
		SubstituteAction = 32000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			32000620,
			32000621,
			32000622
		}
	},
	[32000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000512,
		SubstituteAction = 32000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			32000630,
			32000631,
			32000632
		}
	},
	[32000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			32000623,
			32000624
		}
	},
	[32000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			32000633,
			32000634
		}
	},
	[32000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000521,
		SubstituteAction = 32000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			32000620,
			32000625,
			32000624
		}
	},
	[32000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 32000522,
		SubstituteAction = 32000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			32000630,
			32000635,
			32000634
		}
	},
	[32000601] = {
		Id = 32000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[32000602] = {
		RandomWeight = 10,
		Id = 32000602,
		SubstituteAction = 32000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000100,
			32000640
		}
	},
	[32000603] = {
		Id = 32000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[32000604] = {
		RandomWeight = 30,
		Id = 32000604,
		SubstituteAction = 32000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000100,
			32000642
		}
	},
	[32000605] = {
		Id = 32000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000641
		}
	},
	[32000606] = {
		Id = 32000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000643
		}
	},
	[32000607] = {
		RandomWeight = 10,
		Id = 32000607,
		SubstituteAction = 32000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000640
		}
	},
	[32000608] = {
		RandomWeight = 30,
		Id = 32000608,
		SubstituteAction = 32000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			32000642
		}
	},
	[32000611] = {
		Id = 32000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000612] = {
		RandomWeight = 30,
		Id = 32000612,
		SubstituteAction = 32000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			32000100,
			32000650,
			32000651
		}
	},
	[32000613] = {
		Id = 32000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000614] = {
		RandomWeight = 30,
		Id = 32000614,
		SubstituteAction = 32000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			32000100,
			32000652,
			32000653
		}
	},
	[32000615] = {
		Id = 32000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			32000651
		}
	},
	[32000616] = {
		Id = 32000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			32000653
		}
	},
	[32000617] = {
		RandomWeight = 30,
		Id = 32000617,
		SubstituteAction = 32000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			32000650,
			32000651
		}
	},
	[32000618] = {
		RandomWeight = 30,
		Id = 32000618,
		SubstituteAction = 32000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			32000652,
			32000653
		}
	},
	[32000621] = {
		Id = 32000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000622] = {
		RandomWeight = 30,
		Id = 32000622,
		SubstituteAction = 32000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			32000635,
			32000624
		}
	},
	[32000623] = {
		Id = 32000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[32000624] = {
		RandomWeight = 30,
		Id = 32000624,
		SubstituteAction = 32000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			32000635,
			32000632
		}
	},
	[32000625] = {
		RandomWeight = 30,
		Id = 32000625,
		SubstituteAction = 32000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			32000661
		}
	},
	[32000626] = {
		RandomWeight = 30,
		Id = 32000626,
		SubstituteAction = 32000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			32000662
		}
	},
	[32000701] = {
		RandomWeight = 30,
		Id = 32000701,
		SubstituteAction = 32000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			32000603,
			32000604
		}
	},
	[32000702] = {
		RandomWeight = 10,
		Id = 32000702,
		SubstituteAction = 32000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			32000613,
			32000614
		}
	},
	[32000711] = {
		SubstituteAction = 32000513,
		RandomWeight = 10,
		Id = 32000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[32000712] = {
		RandomWeight = 10,
		Id = 32000712,
		SubstituteAction = 32000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			32000631,
			32000632
		}
	},
	[32000713] = {
		RandomWeight = 10,
		Id = 32000713,
		SubstituteAction = 32000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			32000635,
			32000624
		}
	},
	[32000714] = {
		RandomWeight = 10,
		Id = 32000714,
		SubstituteAction = 32000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			32000635,
			32000632
		}
	},
	[32000801] = {
		Id = 32000801,
		RandomWeight = 100,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			32000810,
			32000811,
			32000812,
			32000813
		}
	},
	[32000802] = {
		Id = 32000802,
		RandomWeight = 100,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			32000820,
			32000821,
			32000822,
			32000823
		}
	},
	[32000803] = {
		Id = 32000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			32000830,
			32000831,
			32000832,
			32000833
		}
	},
	[32000804] = {
		Id = 32000804,
		RandomWeight = 50,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			32000840,
			32000841,
			32000842,
			32000843
		}
	},
	[32000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 32000805,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			32000850,
			32000851,
			32000852,
			32000853
		}
	},
	[32000806] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 32000806,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			32000860,
			32000861,
			32000862,
			32000863
		}
	},
	[32005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 32005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[32005002] = {
		Id = 32005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			32000100,
			32000110,
			32000111,
			32000112,
			32000113,
			32000120
		}
	},
	[33000001] = {
		Id = 33000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[33000002] = {
		Id = 33000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[33000003] = {
		Id = 33000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[33000004] = {
		Id = 33000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			33000010
		}
	},
	[33000005] = {
		Id = 33000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			33000020
		}
	},
	[33000011] = {
		RandomWeight = 10,
		Id = 33000011,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000110,
			33000100,
			33000110,
			33000120
		}
	},
	[33000012] = {
		RandomWeight = 10,
		Id = 33000012,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000130
		}
	},
	[33000013] = {
		RandomWeight = 10,
		Id = 33000013,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000110,
			33000100,
			33000110,
			33000131,
			33000100
		}
	},
	[33000021] = {
		RandomWeight = 20,
		Id = 33000021,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000111,
			33000100,
			33000111,
			33000120
		}
	},
	[33000022] = {
		RandomWeight = 20,
		Id = 33000022,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000112,
			33000100,
			33000112,
			33000120
		}
	},
	[33000023] = {
		RandomWeight = 20,
		Id = 33000023,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000113,
			33000100,
			33000113,
			33000120
		}
	},
	[33000024] = {
		RandomWeight = 20,
		Id = 33000024,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000140
		}
	},
	[33000025] = {
		RandomWeight = 20,
		Id = 33000025,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			33000110,
			33000100,
			33000110,
			33000141,
			33000100
		}
	},
	[33000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 33000026,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			33000150
		}
	},
	[33000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 33000031,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101,
			814
		},
		ActionUnitIDList = {
			33000151
		}
	},
	[33000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 33000041,
		SubstituteAction = 33000004,
		ConditionIDList = {
			101,
			816
		},
		ActionUnitIDList = {
			33000152
		}
	},
	[33000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 33000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			33000210
		}
	},
	[33000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 33000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			33000211
		}
	},
	[33000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 33000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			33000210
		}
	},
	[33000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 33000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			33000211
		}
	},
	[33000121] = {
		Id = 33000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[33000122] = {
		Id = 33000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[33000201] = {
		RandomWeight = 5,
		isDailyAction = true,
		Id = 33000201,
		SubstituteAction = 33000005,
		ActionUnitIDList = {
			33000300,
			33000310
		}
	},
	[33000202] = {
		RandomWeight = 5,
		isDailyAction = true,
		Id = 33000202,
		SubstituteAction = 33000005,
		ActionUnitIDList = {
			33000300,
			33000311
		}
	},
	[33000211] = {
		Id = 33000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[33000212] = {
		RandomWeight = 10,
		Id = 33000212,
		SubstituteAction = 33000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			33000320
		}
	},
	[33000213] = {
		Id = 33000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[33000214] = {
		RandomWeight = 60,
		Id = 33000214,
		SubstituteAction = 33000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			33000321
		}
	},
	[33000221] = {
		RandomWeight = 10,
		Id = 33000221,
		SubstituteAction = 33000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			33000310
		}
	},
	[33000222] = {
		RandomWeight = 20,
		Id = 33000222,
		SubstituteAction = 33000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			33000311
		}
	},
	[33000231] = {
		isDailyAction = true,
		Id = 33000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			33000330
		}
	},
	[33000232] = {
		isDailyAction = true,
		Id = 33000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			33000331
		}
	},
	[33000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 33000301,
		SubstituteAction = 33000005,
		ActionUnitIDList = {
			33000400,
			33000410
		}
	},
	[33000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 33000302,
		SubstituteAction = 33000005,
		ActionUnitIDList = {
			33000400,
			33000411
		}
	},
	[33000311] = {
		Id = 33000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[33000312] = {
		RandomWeight = 10,
		Id = 33000312,
		SubstituteAction = 33000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			33000420
		}
	},
	[33000313] = {
		Id = 33000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[33000314] = {
		RandomWeight = 60,
		Id = 33000314,
		SubstituteAction = 33000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			33000421
		}
	},
	[33000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000321,
		SubstituteAction = 33000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			33000410
		}
	},
	[33000322] = {
		RandomWeight = 20,
		Id = 33000322,
		SubstituteAction = 33000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			33000411
		}
	},
	[33000331] = {
		isDailyAction = true,
		Id = 33000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			33000430
		}
	},
	[33000332] = {
		isDailyAction = true,
		Id = 33000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			33000431
		}
	},
	[33000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 33000401,
		SubstituteAction = 33000005,
		ActionUnitIDList = {
			33000500,
			33000510
		}
	},
	[33000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 33000402,
		SubstituteAction = 33000005,
		ActionUnitIDList = {
			33000500,
			33000511
		}
	},
	[33000411] = {
		Id = 33000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[33000412] = {
		RandomWeight = 10,
		Id = 33000412,
		SubstituteAction = 33000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			33000520
		}
	},
	[33000413] = {
		Id = 33000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[33000414] = {
		RandomWeight = 60,
		Id = 33000414,
		SubstituteAction = 33000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			33000521
		}
	},
	[33000421] = {
		RandomWeight = 10,
		Id = 33000421,
		SubstituteAction = 33000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			33000510
		}
	},
	[33000422] = {
		RandomWeight = 20,
		Id = 33000422,
		SubstituteAction = 33000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			33000511
		}
	},
	[33000431] = {
		isDailyAction = true,
		Id = 33000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			33000530
		}
	},
	[33000432] = {
		isDailyAction = true,
		Id = 33000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			33000531
		}
	},
	[33000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000501,
		SubstituteAction = 33000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000600,
			33000601,
			33000602,
			33000603,
			33000604
		}
	},
	[33000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000502,
		SubstituteAction = 33000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000610,
			33000611,
			33000612,
			33000613,
			33000614
		}
	},
	[33000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000605,
			33000606
		}
	},
	[33000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000615,
			33000616
		}
	},
	[33000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000511,
		SubstituteAction = 33000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			33000620,
			33000621,
			33000622
		}
	},
	[33000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000512,
		SubstituteAction = 33000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			33000630,
			33000631,
			33000632
		}
	},
	[33000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			33000623,
			33000624
		}
	},
	[33000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			33000633,
			33000634
		}
	},
	[33000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000521,
		SubstituteAction = 33000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			33000620,
			33000625,
			33000624
		}
	},
	[33000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 33000522,
		SubstituteAction = 33000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			33000630,
			33000635,
			33000634
		}
	},
	[33000601] = {
		Id = 33000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[33000602] = {
		RandomWeight = 10,
		Id = 33000602,
		SubstituteAction = 33000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000100,
			33000640
		}
	},
	[33000603] = {
		Id = 33000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[33000604] = {
		RandomWeight = 30,
		Id = 33000604,
		SubstituteAction = 33000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000100,
			33000642
		}
	},
	[33000605] = {
		Id = 33000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000641
		}
	},
	[33000606] = {
		Id = 33000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000643
		}
	},
	[33000607] = {
		RandomWeight = 10,
		Id = 33000607,
		SubstituteAction = 33000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000640
		}
	},
	[33000608] = {
		RandomWeight = 30,
		Id = 33000608,
		SubstituteAction = 33000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			33000642
		}
	},
	[33000611] = {
		Id = 33000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[33000612] = {
		RandomWeight = 30,
		Id = 33000612,
		SubstituteAction = 33000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			33000100,
			33000650,
			33000651
		}
	},
	[33000613] = {
		Id = 33000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[33000614] = {
		RandomWeight = 30,
		Id = 33000614,
		SubstituteAction = 33000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			33000100,
			33000652,
			33000653
		}
	},
	[33000615] = {
		Id = 33000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			33000651
		}
	},
	[33000616] = {
		Id = 33000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			33000653
		}
	},
	[33000617] = {
		RandomWeight = 30,
		Id = 33000617,
		SubstituteAction = 33000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			33000650,
			33000651
		}
	},
	[33000618] = {
		RandomWeight = 30,
		Id = 33000618,
		SubstituteAction = 33000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			33000652,
			33000653
		}
	},
	[33000621] = {
		Id = 33000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[33000622] = {
		RandomWeight = 30,
		Id = 33000622,
		SubstituteAction = 33000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			33000635,
			33000624
		}
	},
	[33000623] = {
		Id = 33000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[33000624] = {
		RandomWeight = 30,
		Id = 33000624,
		SubstituteAction = 33000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			33000635,
			33000632
		}
	},
	[33000625] = {
		RandomWeight = 30,
		Id = 33000625,
		SubstituteAction = 33000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			33000661
		}
	},
	[33000626] = {
		RandomWeight = 30,
		Id = 33000626,
		SubstituteAction = 33000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			33000662
		}
	},
	[33000701] = {
		RandomWeight = 30,
		Id = 33000701,
		SubstituteAction = 33000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			33000603,
			33000604
		}
	},
	[33000702] = {
		RandomWeight = 10,
		Id = 33000702,
		SubstituteAction = 33000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			33000613,
			33000614
		}
	},
	[33000711] = {
		SubstituteAction = 33000513,
		RandomWeight = 10,
		Id = 33000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[33000712] = {
		RandomWeight = 10,
		Id = 33000712,
		SubstituteAction = 33000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			33000631,
			33000632
		}
	},
	[33000713] = {
		RandomWeight = 10,
		Id = 33000713,
		SubstituteAction = 33000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			33000635,
			33000624
		}
	},
	[33000714] = {
		RandomWeight = 10,
		Id = 33000714,
		SubstituteAction = 33000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			33000635,
			33000632
		}
	},
	[33000801] = {
		Id = 33000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			33000810,
			33000811,
			33000812,
			33000813
		}
	},
	[33000802] = {
		Id = 33000802,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			33000820,
			33000821,
			33000822,
			33000823
		}
	},
	[33000803] = {
		Id = 33000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			33000830,
			33000831,
			33000832,
			33000833
		}
	},
	[33000804] = {
		isDailyAction = true,
		Id = 33000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			33000840,
			33000841,
			33000842,
			33000843
		}
	},
	[33000805] = {
		isDailyAction = true,
		Id = 33000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			33000850,
			33000851,
			33000852,
			33000853
		}
	},
	[33005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 33005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[33005002] = {
		Id = 33005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			33000100,
			33000110,
			33000111,
			33000112,
			33000113,
			33000120
		}
	},
	[34000001] = {
		Id = 34000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[34000002] = {
		Id = 34000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[34000003] = {
		Id = 34000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[34000004] = {
		Id = 34000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			34000010
		}
	},
	[34000005] = {
		Id = 34000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			34000020
		}
	},
	[34000006] = {
		Id = 34000006,
		RandomWeight = 1000,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			114,
			34000823
		}
	},
	[34000011] = {
		RandomWeight = 10,
		Id = 34000011,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000110,
			34000100,
			34000110,
			34000120
		}
	},
	[34000012] = {
		RandomWeight = 10,
		Id = 34000012,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000130
		}
	},
	[34000013] = {
		RandomWeight = 10,
		Id = 34000013,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000110,
			34000100,
			34000110,
			34000131,
			34000100
		}
	},
	[34000021] = {
		RandomWeight = 20,
		Id = 34000021,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000111,
			34000100,
			34000111,
			34000120
		}
	},
	[34000022] = {
		RandomWeight = 20,
		Id = 34000022,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000112,
			34000100,
			34000112,
			34000120
		}
	},
	[34000023] = {
		RandomWeight = 20,
		Id = 34000023,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000113,
			34000100,
			34000113,
			34000120
		}
	},
	[34000024] = {
		RandomWeight = 20,
		Id = 34000024,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000140
		}
	},
	[34000025] = {
		RandomWeight = 20,
		Id = 34000025,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			34000110,
			34000100,
			34000110,
			34000141,
			34000100
		}
	},
	[34000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 34000026,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			34000150
		}
	},
	[34000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 34000031,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101,
			801
		},
		ActionUnitIDList = {
			34000151
		}
	},
	[34000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 34000041,
		SubstituteAction = 34000004,
		ConditionIDList = {
			101,
			819
		},
		ActionUnitIDList = {
			34000152
		}
	},
	[34000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 34000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			34000210
		}
	},
	[34000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 34000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			34000211
		}
	},
	[34000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 34000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			34000210
		}
	},
	[34000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 34000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			34000211
		}
	},
	[34000121] = {
		Id = 34000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[34000122] = {
		Id = 34000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[34000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 34000201,
		SubstituteAction = 34000005,
		ActionUnitIDList = {
			34000300,
			34000310
		}
	},
	[34000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 34000202,
		SubstituteAction = 34000005,
		ActionUnitIDList = {
			34000300,
			34000311
		}
	},
	[34000211] = {
		Id = 34000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[34000212] = {
		RandomWeight = 10,
		Id = 34000212,
		SubstituteAction = 34000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			34000320
		}
	},
	[34000213] = {
		Id = 34000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[34000214] = {
		RandomWeight = 60,
		Id = 34000214,
		SubstituteAction = 34000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			34000321
		}
	},
	[34000221] = {
		RandomWeight = 10,
		Id = 34000221,
		SubstituteAction = 34000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			34000310
		}
	},
	[34000222] = {
		RandomWeight = 20,
		Id = 34000222,
		SubstituteAction = 34000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			34000311
		}
	},
	[34000231] = {
		isDailyAction = true,
		Id = 34000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			34000330
		}
	},
	[34000232] = {
		isDailyAction = true,
		Id = 34000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			34000331
		}
	},
	[34000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 34000301,
		SubstituteAction = 34000005,
		ActionUnitIDList = {
			34000400,
			34000410
		}
	},
	[34000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 34000302,
		SubstituteAction = 34000005,
		ActionUnitIDList = {
			34000400,
			34000411
		}
	},
	[34000311] = {
		Id = 34000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[34000312] = {
		RandomWeight = 10,
		Id = 34000312,
		SubstituteAction = 34000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			34000420
		}
	},
	[34000313] = {
		Id = 34000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[34000314] = {
		RandomWeight = 60,
		Id = 34000314,
		SubstituteAction = 34000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			34000421
		}
	},
	[34000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000321,
		SubstituteAction = 34000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			34000410
		}
	},
	[34000322] = {
		RandomWeight = 20,
		Id = 34000322,
		SubstituteAction = 34000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			34000411
		}
	},
	[34000331] = {
		isDailyAction = true,
		Id = 34000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			34000430
		}
	},
	[34000332] = {
		isDailyAction = true,
		Id = 34000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			34000431
		}
	},
	[34000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 34000401,
		SubstituteAction = 34000005,
		ActionUnitIDList = {
			34000500,
			34000510
		}
	},
	[34000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 34000402,
		SubstituteAction = 34000005,
		ActionUnitIDList = {
			34000500,
			34000511
		}
	},
	[34000411] = {
		Id = 34000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[34000412] = {
		RandomWeight = 10,
		Id = 34000412,
		SubstituteAction = 34000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			34000520
		}
	},
	[34000413] = {
		Id = 34000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[34000414] = {
		RandomWeight = 60,
		Id = 34000414,
		SubstituteAction = 34000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			34000521
		}
	},
	[34000421] = {
		RandomWeight = 10,
		Id = 34000421,
		SubstituteAction = 34000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			34000510
		}
	},
	[34000422] = {
		RandomWeight = 20,
		Id = 34000422,
		SubstituteAction = 34000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			34000511
		}
	},
	[34000431] = {
		isDailyAction = true,
		Id = 34000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			34000530
		}
	},
	[34000432] = {
		isDailyAction = true,
		Id = 34000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			34000531
		}
	},
	[34000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000501,
		SubstituteAction = 34000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000600,
			34000601,
			34000602,
			34000603,
			34000604
		}
	},
	[34000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000502,
		SubstituteAction = 34000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000610,
			34000611,
			34000612,
			34000613,
			34000614
		}
	},
	[34000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000605,
			34000606
		}
	},
	[34000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000615,
			34000616
		}
	},
	[34000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000511,
		SubstituteAction = 34000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			34000620,
			34000621,
			34000622
		}
	},
	[34000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000512,
		SubstituteAction = 34000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			34000630,
			34000631,
			34000632
		}
	},
	[34000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			34000623,
			34000624
		}
	},
	[34000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			34000633,
			34000634
		}
	},
	[34000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000521,
		SubstituteAction = 34000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			34000620,
			34000625,
			34000624
		}
	},
	[34000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 34000522,
		SubstituteAction = 34000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			34000630,
			34000635,
			34000634
		}
	},
	[34000601] = {
		Id = 34000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[34000602] = {
		RandomWeight = 10,
		Id = 34000602,
		SubstituteAction = 34000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000100,
			34000640
		}
	},
	[34000603] = {
		Id = 34000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[34000604] = {
		RandomWeight = 30,
		Id = 34000604,
		SubstituteAction = 34000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000100,
			34000642
		}
	},
	[34000605] = {
		Id = 34000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000641
		}
	},
	[34000606] = {
		Id = 34000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000643
		}
	},
	[34000607] = {
		RandomWeight = 10,
		Id = 34000607,
		SubstituteAction = 34000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000640
		}
	},
	[34000608] = {
		RandomWeight = 30,
		Id = 34000608,
		SubstituteAction = 34000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			34000642
		}
	},
	[34000611] = {
		Id = 34000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[34000612] = {
		RandomWeight = 30,
		Id = 34000612,
		SubstituteAction = 34000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			34000100,
			34000650,
			34000651
		}
	},
	[34000613] = {
		Id = 34000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[34000614] = {
		RandomWeight = 30,
		Id = 34000614,
		SubstituteAction = 34000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			34000100,
			34000652,
			34000653
		}
	},
	[34000615] = {
		Id = 34000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			34000651
		}
	},
	[34000616] = {
		Id = 34000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			34000653
		}
	},
	[34000617] = {
		RandomWeight = 30,
		Id = 34000617,
		SubstituteAction = 34000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			34000650,
			34000651
		}
	},
	[34000618] = {
		RandomWeight = 30,
		Id = 34000618,
		SubstituteAction = 34000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			34000652,
			34000653
		}
	},
	[34000621] = {
		Id = 34000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[34000622] = {
		RandomWeight = 30,
		Id = 34000622,
		SubstituteAction = 34000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			34000635,
			34000624
		}
	},
	[34000623] = {
		Id = 34000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[34000624] = {
		RandomWeight = 30,
		Id = 34000624,
		SubstituteAction = 34000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			34000635,
			34000632
		}
	},
	[34000625] = {
		RandomWeight = 30,
		Id = 34000625,
		SubstituteAction = 34000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			34000661
		}
	},
	[34000626] = {
		RandomWeight = 30,
		Id = 34000626,
		SubstituteAction = 34000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			34000662
		}
	},
	[34000701] = {
		RandomWeight = 30,
		Id = 34000701,
		SubstituteAction = 34000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			34000603,
			34000604
		}
	},
	[34000702] = {
		RandomWeight = 10,
		Id = 34000702,
		SubstituteAction = 34000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			34000613,
			34000614
		}
	},
	[34000711] = {
		SubstituteAction = 34000513,
		RandomWeight = 10,
		Id = 34000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[34000712] = {
		RandomWeight = 10,
		Id = 34000712,
		SubstituteAction = 34000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			34000631,
			34000632
		}
	},
	[34000713] = {
		RandomWeight = 10,
		Id = 34000713,
		SubstituteAction = 34000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			34000635,
			34000624
		}
	},
	[34000714] = {
		RandomWeight = 10,
		Id = 34000714,
		SubstituteAction = 34000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			34000635,
			34000632
		}
	},
	[34000801] = {
		isDailyAction = true,
		Id = 34000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			34000810,
			34000811,
			34000812,
			34000813
		}
	},
	[34000802] = {
		isDailyAction = true,
		RandomWeight = 500,
		Id = 34000802,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			34000820,
			34000821,
			34000822,
			34000823
		}
	},
	[34000803] = {
		isDailyAction = true,
		Id = 34000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			34000830,
			34000831,
			34000832,
			34000833
		}
	},
	[34000804] = {
		isDailyAction = true,
		Id = 34000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			34000840,
			34000841,
			34000842,
			34000843
		}
	},
	[34000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 34000805,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			34000850,
			34000851,
			34000852,
			34000853
		}
	},
	[34005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 34005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[34005002] = {
		Id = 34005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			34000100,
			34000110,
			34000111,
			34000112,
			34000113,
			34000120
		}
	},
	[35000001] = {
		Id = 35000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[35000002] = {
		Id = 35000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[35000003] = {
		Id = 35000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[35000004] = {
		Id = 35000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			35000010
		}
	},
	[35000005] = {
		Id = 35000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			35000020
		}
	},
	[35000011] = {
		RandomWeight = 10,
		Id = 35000011,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000110,
			35000100,
			35000110,
			35000120
		}
	},
	[35000012] = {
		RandomWeight = 10,
		Id = 35000012,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000130
		}
	},
	[35000013] = {
		RandomWeight = 10,
		Id = 35000013,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000110,
			35000100,
			35000110,
			35000131,
			35000100
		}
	},
	[35000021] = {
		RandomWeight = 20,
		Id = 35000021,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000111,
			35000100,
			35000111,
			35000120
		}
	},
	[35000022] = {
		RandomWeight = 20,
		Id = 35000022,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000112,
			35000100,
			35000112,
			35000120
		}
	},
	[35000023] = {
		RandomWeight = 20,
		Id = 35000023,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000113,
			35000100,
			35000113,
			35000120
		}
	},
	[35000024] = {
		RandomWeight = 20,
		Id = 35000024,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000140
		}
	},
	[35000025] = {
		RandomWeight = 20,
		Id = 35000025,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			35000110,
			35000100,
			35000110,
			35000141,
			35000100
		}
	},
	[35000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 35000026,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			35000150
		}
	},
	[35000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 35000031,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101,
			836
		},
		ActionUnitIDList = {
			35000151
		}
	},
	[35000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 35000041,
		SubstituteAction = 35000004,
		ConditionIDList = {
			101,
			832
		},
		ActionUnitIDList = {
			35000152
		}
	},
	[35000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 35000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			35000210
		}
	},
	[35000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 35000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			35000211
		}
	},
	[35000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 35000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			35000210
		}
	},
	[35000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 35000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			35000211
		}
	},
	[35000121] = {
		Id = 35000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[35000122] = {
		Id = 35000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[35000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 35000201,
		SubstituteAction = 35000005,
		ActionUnitIDList = {
			35000300,
			35000310
		}
	},
	[35000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 35000202,
		SubstituteAction = 35000005,
		ActionUnitIDList = {
			35000300,
			35000311
		}
	},
	[35000211] = {
		Id = 35000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[35000212] = {
		RandomWeight = 10,
		Id = 35000212,
		SubstituteAction = 35000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			35000320
		}
	},
	[35000213] = {
		Id = 35000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[35000214] = {
		RandomWeight = 60,
		Id = 35000214,
		SubstituteAction = 35000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			35000321
		}
	},
	[35000221] = {
		RandomWeight = 10,
		Id = 35000221,
		SubstituteAction = 35000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			35000310
		}
	},
	[35000222] = {
		RandomWeight = 20,
		Id = 35000222,
		SubstituteAction = 35000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			35000311
		}
	},
	[35000231] = {
		isDailyAction = true,
		Id = 35000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			35000330
		}
	},
	[35000232] = {
		isDailyAction = true,
		Id = 35000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			35000331
		}
	},
	[35000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 35000301,
		SubstituteAction = 35000005,
		ActionUnitIDList = {
			35000400,
			35000410
		}
	},
	[35000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 35000302,
		SubstituteAction = 35000005,
		ActionUnitIDList = {
			35000400,
			35000411
		}
	},
	[35000311] = {
		Id = 35000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[35000312] = {
		RandomWeight = 10,
		Id = 35000312,
		SubstituteAction = 35000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			35000420
		}
	},
	[35000313] = {
		Id = 35000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[35000314] = {
		RandomWeight = 60,
		Id = 35000314,
		SubstituteAction = 35000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			35000421
		}
	},
	[35000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000321,
		SubstituteAction = 35000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			35000410
		}
	},
	[35000322] = {
		RandomWeight = 20,
		Id = 35000322,
		SubstituteAction = 35000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			35000411
		}
	},
	[35000331] = {
		isDailyAction = true,
		Id = 35000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			35000430
		}
	},
	[35000332] = {
		isDailyAction = true,
		Id = 35000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			35000431
		}
	},
	[35000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 35000401,
		SubstituteAction = 35000005,
		ActionUnitIDList = {
			35000500,
			35000510
		}
	},
	[35000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 35000402,
		SubstituteAction = 35000005,
		ActionUnitIDList = {
			35000500,
			35000511
		}
	},
	[35000411] = {
		Id = 35000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[35000412] = {
		RandomWeight = 10,
		Id = 35000412,
		SubstituteAction = 35000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			35000520
		}
	},
	[35000413] = {
		Id = 35000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[35000414] = {
		RandomWeight = 60,
		Id = 35000414,
		SubstituteAction = 35000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			35000521
		}
	},
	[35000421] = {
		RandomWeight = 10,
		Id = 35000421,
		SubstituteAction = 35000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			35000510
		}
	},
	[35000422] = {
		RandomWeight = 20,
		Id = 35000422,
		SubstituteAction = 35000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			35000511
		}
	},
	[35000431] = {
		isDailyAction = true,
		Id = 35000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			35000530
		}
	},
	[35000432] = {
		isDailyAction = true,
		Id = 35000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			35000531
		}
	},
	[35000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000501,
		SubstituteAction = 35000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000600,
			35000601,
			35000602,
			35000603,
			35000604
		}
	},
	[35000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000502,
		SubstituteAction = 35000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000610,
			35000611,
			35000612,
			35000613,
			35000614
		}
	},
	[35000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000605,
			35000606
		}
	},
	[35000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000615,
			35000616
		}
	},
	[35000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000511,
		SubstituteAction = 35000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			35000620,
			35000621,
			35000622
		}
	},
	[35000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000512,
		SubstituteAction = 35000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			35000630,
			35000631,
			35000632
		}
	},
	[35000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			35000623,
			35000624
		}
	},
	[35000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			35000633,
			35000634
		}
	},
	[35000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000521,
		SubstituteAction = 35000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			35000620,
			35000625,
			35000624
		}
	},
	[35000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 35000522,
		SubstituteAction = 35000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			35000630,
			35000635,
			35000634
		}
	},
	[35000601] = {
		Id = 35000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[35000602] = {
		RandomWeight = 10,
		Id = 35000602,
		SubstituteAction = 35000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000100,
			35000640
		}
	},
	[35000603] = {
		Id = 35000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[35000604] = {
		RandomWeight = 30,
		Id = 35000604,
		SubstituteAction = 35000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000100,
			35000642
		}
	},
	[35000605] = {
		Id = 35000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000641
		}
	},
	[35000606] = {
		Id = 35000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000643
		}
	},
	[35000607] = {
		RandomWeight = 10,
		Id = 35000607,
		SubstituteAction = 35000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000640
		}
	},
	[35000608] = {
		RandomWeight = 30,
		Id = 35000608,
		SubstituteAction = 35000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			35000642
		}
	},
	[35000611] = {
		Id = 35000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[35000612] = {
		RandomWeight = 30,
		Id = 35000612,
		SubstituteAction = 35000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			35000100,
			35000650,
			35000651
		}
	},
	[35000613] = {
		Id = 35000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[35000614] = {
		RandomWeight = 30,
		Id = 35000614,
		SubstituteAction = 35000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			35000100,
			35000652,
			35000653
		}
	},
	[35000615] = {
		Id = 35000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			35000651
		}
	},
	[35000616] = {
		Id = 35000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			35000653
		}
	},
	[35000617] = {
		RandomWeight = 30,
		Id = 35000617,
		SubstituteAction = 35000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			35000650,
			35000651
		}
	},
	[35000618] = {
		RandomWeight = 30,
		Id = 35000618,
		SubstituteAction = 35000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			35000652,
			35000653
		}
	},
	[35000621] = {
		Id = 35000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[35000622] = {
		RandomWeight = 30,
		Id = 35000622,
		SubstituteAction = 35000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			35000635,
			35000624
		}
	},
	[35000623] = {
		Id = 35000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[35000624] = {
		RandomWeight = 30,
		Id = 35000624,
		SubstituteAction = 35000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			35000635,
			35000632
		}
	},
	[35000625] = {
		RandomWeight = 30,
		Id = 35000625,
		SubstituteAction = 35000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			35000661
		}
	},
	[35000626] = {
		RandomWeight = 30,
		Id = 35000626,
		SubstituteAction = 35000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			35000662
		}
	},
	[35000701] = {
		RandomWeight = 30,
		Id = 35000701,
		SubstituteAction = 35000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			35000603,
			35000604
		}
	},
	[35000702] = {
		RandomWeight = 10,
		Id = 35000702,
		SubstituteAction = 35000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			35000613,
			35000614
		}
	},
	[35000711] = {
		SubstituteAction = 35000513,
		RandomWeight = 10,
		Id = 35000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[35000712] = {
		RandomWeight = 10,
		Id = 35000712,
		SubstituteAction = 35000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			35000631,
			35000632
		}
	},
	[35000713] = {
		RandomWeight = 10,
		Id = 35000713,
		SubstituteAction = 35000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			35000635,
			35000624
		}
	},
	[35000714] = {
		RandomWeight = 10,
		Id = 35000714,
		SubstituteAction = 35000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			35000635,
			35000632
		}
	},
	[35000801] = {
		Id = 35000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			35000810,
			35000811,
			35000812,
			35000813
		}
	},
	[35000802] = {
		Id = 35000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			35000820,
			35000821,
			35000822,
			35000823
		}
	},
	[35000803] = {
		Id = 35000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			35000831,
			35000832,
			35000833
		}
	},
	[35000804] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 35000804,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			35000840,
			35000841,
			35000842,
			35000843
		}
	},
	[35000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 35000805,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			35000850,
			35000851,
			35000852,
			35000853
		}
	},
	[35005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 35005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[35005002] = {
		Id = 35005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			35000100,
			35000110,
			35000111,
			35000112,
			35000113,
			35000120
		}
	},
	[36000001] = {
		Id = 36000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[36000002] = {
		Id = 36000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[36000003] = {
		Id = 36000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[36000004] = {
		Id = 36000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			36000010
		}
	},
	[36000005] = {
		Id = 36000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			36000020
		}
	},
	[36000011] = {
		RandomWeight = 10,
		Id = 36000011,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000110,
			36000100,
			36000110,
			36000120
		}
	},
	[36000012] = {
		RandomWeight = 10,
		Id = 36000012,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000130
		}
	},
	[36000013] = {
		RandomWeight = 10,
		Id = 36000013,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000110,
			36000100,
			36000110,
			36000131,
			36000100
		}
	},
	[36000021] = {
		RandomWeight = 20,
		Id = 36000021,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000111,
			36000100,
			36000111,
			36000120
		}
	},
	[36000022] = {
		RandomWeight = 20,
		Id = 36000022,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000112,
			36000100,
			36000112,
			36000120
		}
	},
	[36000023] = {
		RandomWeight = 20,
		Id = 36000023,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000113,
			36000100,
			36000113,
			36000120
		}
	},
	[36000024] = {
		RandomWeight = 20,
		Id = 36000024,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000140
		}
	},
	[36000025] = {
		RandomWeight = 20,
		Id = 36000025,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			36000110,
			36000100,
			36000110,
			36000141,
			36000100
		}
	},
	[36000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 36000026,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			36000150
		}
	},
	[36000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 36000031,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101,
			835
		},
		ActionUnitIDList = {
			36000151
		}
	},
	[36000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 36000041,
		SubstituteAction = 36000004,
		ConditionIDList = {
			101,
			823
		},
		ActionUnitIDList = {
			36000152
		}
	},
	[36000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 36000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			36000210
		}
	},
	[36000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 36000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			36000211
		}
	},
	[36000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 36000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			36000210
		}
	},
	[36000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 36000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			36000211
		}
	},
	[36000121] = {
		Id = 36000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[36000122] = {
		Id = 36000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[36000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 36000201,
		SubstituteAction = 36000005,
		ActionUnitIDList = {
			36000300,
			36000310
		}
	},
	[36000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 36000202,
		SubstituteAction = 36000005,
		ActionUnitIDList = {
			36000300,
			36000311
		}
	},
	[36000211] = {
		Id = 36000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[36000212] = {
		RandomWeight = 10,
		Id = 36000212,
		SubstituteAction = 36000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			36000320
		}
	},
	[36000213] = {
		Id = 36000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[36000214] = {
		RandomWeight = 60,
		Id = 36000214,
		SubstituteAction = 36000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			36000321
		}
	},
	[36000221] = {
		RandomWeight = 10,
		Id = 36000221,
		SubstituteAction = 36000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			36000310
		}
	},
	[36000222] = {
		RandomWeight = 20,
		Id = 36000222,
		SubstituteAction = 36000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			36000311
		}
	},
	[36000231] = {
		isDailyAction = true,
		Id = 36000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			36000330
		}
	},
	[36000232] = {
		isDailyAction = true,
		Id = 36000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			36000331
		}
	},
	[36000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 36000301,
		SubstituteAction = 36000005,
		ActionUnitIDList = {
			36000400,
			36000410
		}
	},
	[36000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 36000302,
		SubstituteAction = 36000005,
		ActionUnitIDList = {
			36000400,
			36000411
		}
	},
	[36000311] = {
		Id = 36000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[36000312] = {
		RandomWeight = 10,
		Id = 36000312,
		SubstituteAction = 36000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			36000420
		}
	},
	[36000313] = {
		Id = 36000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[36000314] = {
		RandomWeight = 60,
		Id = 36000314,
		SubstituteAction = 36000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			36000421
		}
	},
	[36000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000321,
		SubstituteAction = 36000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			36000410
		}
	},
	[36000322] = {
		RandomWeight = 20,
		Id = 36000322,
		SubstituteAction = 36000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			36000411
		}
	},
	[36000331] = {
		isDailyAction = true,
		Id = 36000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			36000430
		}
	},
	[36000332] = {
		isDailyAction = true,
		Id = 36000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			36000431
		}
	},
	[36000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 36000401,
		SubstituteAction = 36000005,
		ActionUnitIDList = {
			36000500,
			36000510
		}
	},
	[36000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 36000402,
		SubstituteAction = 36000005,
		ActionUnitIDList = {
			36000500,
			36000511
		}
	},
	[36000411] = {
		Id = 36000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[36000412] = {
		RandomWeight = 10,
		Id = 36000412,
		SubstituteAction = 36000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			36000520
		}
	},
	[36000413] = {
		Id = 36000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[36000414] = {
		RandomWeight = 60,
		Id = 36000414,
		SubstituteAction = 36000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			36000521
		}
	},
	[36000421] = {
		RandomWeight = 10,
		Id = 36000421,
		SubstituteAction = 36000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			36000510
		}
	},
	[36000422] = {
		RandomWeight = 20,
		Id = 36000422,
		SubstituteAction = 36000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			36000511
		}
	},
	[36000431] = {
		isDailyAction = true,
		Id = 36000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			36000530
		}
	},
	[36000432] = {
		isDailyAction = true,
		Id = 36000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			36000531
		}
	},
	[36000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000501,
		SubstituteAction = 36000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000600,
			36000601,
			36000602,
			36000603,
			36000604
		}
	},
	[36000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000502,
		SubstituteAction = 36000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000610,
			36000611,
			36000612,
			36000613,
			36000614
		}
	},
	[36000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000605,
			36000606
		}
	},
	[36000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000615,
			36000616
		}
	},
	[36000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000511,
		SubstituteAction = 36000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			36000620,
			36000621,
			36000622
		}
	},
	[36000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000512,
		SubstituteAction = 36000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			36000630,
			36000631,
			36000632
		}
	},
	[36000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			36000623,
			36000624
		}
	},
	[36000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			36000633,
			36000634
		}
	},
	[36000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000521,
		SubstituteAction = 36000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			36000620,
			36000625,
			36000624
		}
	},
	[36000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 36000522,
		SubstituteAction = 36000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			36000630,
			36000635,
			36000634
		}
	},
	[36000601] = {
		Id = 36000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[36000602] = {
		RandomWeight = 10,
		Id = 36000602,
		SubstituteAction = 36000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000100,
			36000640
		}
	},
	[36000603] = {
		Id = 36000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[36000604] = {
		RandomWeight = 30,
		Id = 36000604,
		SubstituteAction = 36000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000100,
			36000642
		}
	},
	[36000605] = {
		Id = 36000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000641
		}
	},
	[36000606] = {
		Id = 36000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000643
		}
	},
	[36000607] = {
		RandomWeight = 10,
		Id = 36000607,
		SubstituteAction = 36000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000640
		}
	},
	[36000608] = {
		RandomWeight = 30,
		Id = 36000608,
		SubstituteAction = 36000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			36000642
		}
	},
	[36000611] = {
		Id = 36000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[36000612] = {
		RandomWeight = 30,
		Id = 36000612,
		SubstituteAction = 36000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			36000100,
			36000650,
			36000651
		}
	},
	[36000613] = {
		Id = 36000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[36000614] = {
		RandomWeight = 30,
		Id = 36000614,
		SubstituteAction = 36000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			36000100,
			36000652,
			36000653
		}
	},
	[36000615] = {
		Id = 36000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			36000651
		}
	},
	[36000616] = {
		Id = 36000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			36000653
		}
	},
	[36000617] = {
		RandomWeight = 30,
		Id = 36000617,
		SubstituteAction = 36000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			36000650,
			36000651
		}
	},
	[36000618] = {
		RandomWeight = 30,
		Id = 36000618,
		SubstituteAction = 36000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			36000652,
			36000653
		}
	},
	[36000621] = {
		Id = 36000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[36000622] = {
		RandomWeight = 30,
		Id = 36000622,
		SubstituteAction = 36000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			36000635,
			36000624
		}
	},
	[36000623] = {
		Id = 36000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[36000624] = {
		RandomWeight = 30,
		Id = 36000624,
		SubstituteAction = 36000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			36000635,
			36000632
		}
	},
	[36000625] = {
		RandomWeight = 30,
		Id = 36000625,
		SubstituteAction = 36000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			36000661
		}
	},
	[36000626] = {
		RandomWeight = 30,
		Id = 36000626,
		SubstituteAction = 36000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			36000662
		}
	},
	[36000701] = {
		RandomWeight = 30,
		Id = 36000701,
		SubstituteAction = 36000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			36000603,
			36000604
		}
	},
	[36000702] = {
		RandomWeight = 10,
		Id = 36000702,
		SubstituteAction = 36000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			36000613,
			36000614
		}
	},
	[36000711] = {
		SubstituteAction = 36000513,
		RandomWeight = 10,
		Id = 36000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[36000712] = {
		RandomWeight = 10,
		Id = 36000712,
		SubstituteAction = 36000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			36000631,
			36000632
		}
	},
	[36000713] = {
		RandomWeight = 10,
		Id = 36000713,
		SubstituteAction = 36000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			36000635,
			36000624
		}
	},
	[36000714] = {
		RandomWeight = 10,
		Id = 36000714,
		SubstituteAction = 36000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			36000635,
			36000632
		}
	},
	[36000801] = {
		Id = 36000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			36000810,
			36000811,
			36000812,
			36000813
		}
	},
	[36000802] = {
		Id = 36000802,
		RandomWeight = 50,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			36000820,
			36000821,
			36000822,
			36000823
		}
	},
	[36000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 36000803,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			36000830,
			36000831,
			36000832,
			36000833
		}
	},
	[36000804] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 36000804,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			36000840,
			36000841,
			36000842,
			36000843
		}
	},
	[36000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 36000805,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			36000850,
			36000851,
			36000852,
			36000853
		}
	},
	[36005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 36005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[36005002] = {
		Id = 36005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			36000100,
			36000110,
			36000111,
			36000112,
			36000113,
			36000120
		}
	},
	[37000001] = {
		Id = 37000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[37000002] = {
		Id = 37000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[37000003] = {
		Id = 37000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[37000004] = {
		Id = 37000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			37000010
		}
	},
	[37000005] = {
		Id = 37000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			37000020
		}
	},
	[37000006] = {
		Id = 37000006,
		RandomWeight = 1000,
		ActionUnitIDList = {
			114
		}
	},
	[37000007] = {
		Id = 37000007,
		RandomWeight = 1000,
		ActionUnitIDList = {
			103
		}
	},
	[37000011] = {
		Id = 37000011,
		SubstituteAction = 37000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000110,
			37000100,
			37000110,
			37000120
		}
	},
	[37000012] = {
		Id = 37000012,
		SubstituteAction = 37000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000130
		}
	},
	[37000013] = {
		Id = 37000013,
		SubstituteAction = 37000004,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000110,
			37000100,
			37000110,
			37000131,
			37000100
		}
	},
	[37000021] = {
		RandomWeight = 20,
		Id = 37000021,
		SubstituteAction = 37000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			37000111,
			37000100,
			37000111,
			37000120
		}
	},
	[37000022] = {
		RandomWeight = 20,
		Id = 37000022,
		SubstituteAction = 37000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			37000112,
			37000100,
			37000112,
			37000120
		}
	},
	[37000023] = {
		RandomWeight = 20,
		Id = 37000023,
		SubstituteAction = 37000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			37000113,
			37000100,
			37000113,
			37000120
		}
	},
	[37000024] = {
		RandomWeight = 20,
		Id = 37000024,
		SubstituteAction = 37000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			37000140
		}
	},
	[37000025] = {
		RandomWeight = 20,
		Id = 37000025,
		SubstituteAction = 37000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			37000110,
			37000100,
			37000110,
			37000141,
			37000100
		}
	},
	[37000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 37000026,
		SubstituteAction = 37000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			37000150
		}
	},
	[37000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 37000031,
		SubstituteAction = 37000004,
		ConditionIDList = {
			824,
			813
		},
		ActionUnitIDList = {
			37000151
		}
	},
	[37000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 37000041,
		SubstituteAction = 37000004,
		ConditionIDList = {
			808,
			807
		},
		ActionUnitIDList = {
			37000152
		}
	},
	[37000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 37000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			37000210
		}
	},
	[37000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 37000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			37000211
		}
	},
	[37000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 37000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			37000210
		}
	},
	[37000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 37000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			37000211
		}
	},
	[37000121] = {
		Id = 37000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[37000122] = {
		Id = 37000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[37000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 37000201,
		SubstituteAction = 37000005,
		ActionUnitIDList = {
			37000300,
			37000310
		}
	},
	[37000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 37000202,
		SubstituteAction = 37000005,
		ActionUnitIDList = {
			37000300,
			37000311
		}
	},
	[37000211] = {
		Id = 37000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[37000212] = {
		RandomWeight = 10,
		Id = 37000212,
		SubstituteAction = 37000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			37000320
		}
	},
	[37000213] = {
		Id = 37000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[37000214] = {
		RandomWeight = 60,
		Id = 37000214,
		SubstituteAction = 37000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			37000321
		}
	},
	[37000221] = {
		RandomWeight = 10,
		Id = 37000221,
		SubstituteAction = 37000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			37000310
		}
	},
	[37000222] = {
		RandomWeight = 20,
		Id = 37000222,
		SubstituteAction = 37000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			37000311
		}
	},
	[37000231] = {
		isDailyAction = true,
		Id = 37000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000330
		}
	},
	[37000232] = {
		isDailyAction = true,
		Id = 37000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000331
		}
	},
	[37000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 37000301,
		SubstituteAction = 37000005,
		ActionUnitIDList = {
			37000400,
			37000410
		}
	},
	[37000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 37000302,
		SubstituteAction = 37000005,
		ActionUnitIDList = {
			37000400,
			37000411
		}
	},
	[37000311] = {
		Id = 37000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[37000312] = {
		RandomWeight = 10,
		Id = 37000312,
		SubstituteAction = 37000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			37000420
		}
	},
	[37000313] = {
		Id = 37000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[37000314] = {
		RandomWeight = 60,
		Id = 37000314,
		SubstituteAction = 37000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			37000421
		}
	},
	[37000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000321,
		SubstituteAction = 37000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			37000410
		}
	},
	[37000322] = {
		RandomWeight = 20,
		Id = 37000322,
		SubstituteAction = 37000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			37000411
		}
	},
	[37000331] = {
		isDailyAction = true,
		Id = 37000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000430
		}
	},
	[37000332] = {
		isDailyAction = true,
		Id = 37000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000431
		}
	},
	[37000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 37000401,
		SubstituteAction = 37000005,
		ActionUnitIDList = {
			37000500,
			37000510
		}
	},
	[37000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 37000402,
		SubstituteAction = 37000005,
		ActionUnitIDList = {
			37000500,
			37000511
		}
	},
	[37000411] = {
		Id = 37000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[37000412] = {
		RandomWeight = 10,
		Id = 37000412,
		SubstituteAction = 37000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			37000520
		}
	},
	[37000413] = {
		Id = 37000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[37000414] = {
		RandomWeight = 60,
		Id = 37000414,
		SubstituteAction = 37000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			37000521
		}
	},
	[37000421] = {
		RandomWeight = 10,
		Id = 37000421,
		SubstituteAction = 37000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			37000510
		}
	},
	[37000422] = {
		RandomWeight = 20,
		Id = 37000422,
		SubstituteAction = 37000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			37000511
		}
	},
	[37000431] = {
		isDailyAction = true,
		Id = 37000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000530
		}
	},
	[37000432] = {
		isDailyAction = true,
		Id = 37000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			37000531
		}
	},
	[37000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000501,
		SubstituteAction = 37000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000600,
			37000601,
			37000602,
			37000603,
			37000604
		}
	},
	[37000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000502,
		SubstituteAction = 37000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000610,
			37000611,
			37000612,
			37000613,
			37000614
		}
	},
	[37000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000605,
			37000606
		}
	},
	[37000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000615,
			37000616
		}
	},
	[37000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000511,
		SubstituteAction = 37000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			37000620,
			37000621,
			37000622
		}
	},
	[37000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000512,
		SubstituteAction = 37000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			37000630,
			37000631,
			37000632
		}
	},
	[37000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			37000623,
			37000624
		}
	},
	[37000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			37000633,
			37000634
		}
	},
	[37000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000521,
		SubstituteAction = 37000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			37000620,
			37000625,
			37000624
		}
	},
	[37000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 37000522,
		SubstituteAction = 37000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			37000630,
			37000635,
			37000634
		}
	},
	[37000601] = {
		Id = 37000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[37000602] = {
		RandomWeight = 10,
		Id = 37000602,
		SubstituteAction = 37000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000100,
			37000640
		}
	},
	[37000603] = {
		Id = 37000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[37000604] = {
		RandomWeight = 30,
		Id = 37000604,
		SubstituteAction = 37000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000100,
			37000642
		}
	},
	[37000605] = {
		Id = 37000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000641
		}
	},
	[37000606] = {
		Id = 37000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000643
		}
	},
	[37000607] = {
		RandomWeight = 10,
		Id = 37000607,
		SubstituteAction = 37000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000640
		}
	},
	[37000608] = {
		RandomWeight = 30,
		Id = 37000608,
		SubstituteAction = 37000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			37000642
		}
	},
	[37000611] = {
		Id = 37000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[37000612] = {
		RandomWeight = 30,
		Id = 37000612,
		SubstituteAction = 37000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			37000100,
			37000650,
			37000651
		}
	},
	[37000613] = {
		Id = 37000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[37000614] = {
		RandomWeight = 30,
		Id = 37000614,
		SubstituteAction = 37000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			37000100,
			37000652,
			37000653
		}
	},
	[37000615] = {
		Id = 37000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			37000651
		}
	},
	[37000616] = {
		Id = 37000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			37000653
		}
	},
	[37000617] = {
		RandomWeight = 30,
		Id = 37000617,
		SubstituteAction = 37000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			37000650,
			37000651
		}
	},
	[37000618] = {
		RandomWeight = 30,
		Id = 37000618,
		SubstituteAction = 37000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			37000652,
			37000653
		}
	},
	[37000621] = {
		Id = 37000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[37000622] = {
		RandomWeight = 30,
		Id = 37000622,
		SubstituteAction = 37000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			37000635,
			37000624
		}
	},
	[37000623] = {
		Id = 37000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[37000624] = {
		RandomWeight = 30,
		Id = 37000624,
		SubstituteAction = 37000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			37000635,
			37000632
		}
	},
	[37000625] = {
		RandomWeight = 30,
		Id = 37000625,
		SubstituteAction = 37000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			37000661
		}
	},
	[37000626] = {
		RandomWeight = 30,
		Id = 37000626,
		SubstituteAction = 37000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			37000662
		}
	},
	[37000701] = {
		RandomWeight = 30,
		Id = 37000701,
		SubstituteAction = 37000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			37000603,
			37000604
		}
	},
	[37000702] = {
		RandomWeight = 10,
		Id = 37000702,
		SubstituteAction = 37000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			37000613,
			37000614
		}
	},
	[37000711] = {
		SubstituteAction = 37000513,
		RandomWeight = 10,
		Id = 37000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[37000712] = {
		RandomWeight = 10,
		Id = 37000712,
		SubstituteAction = 37000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			37000631,
			37000632
		}
	},
	[37000713] = {
		RandomWeight = 10,
		Id = 37000713,
		SubstituteAction = 37000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			37000635,
			37000624
		}
	},
	[37000714] = {
		RandomWeight = 10,
		Id = 37000714,
		SubstituteAction = 37000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			37000635,
			37000632
		}
	},
	[37000801] = {
		Id = 37000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			37000810,
			37000811,
			37000812,
			37000813
		}
	},
	[37000802] = {
		Id = 37000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			37000820,
			37000821,
			37000822,
			37000823
		}
	},
	[37000803] = {
		Id = 37000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			37000830,
			37000831,
			37000832,
			37000833
		}
	},
	[37000804] = {
		Id = 37000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			37000840,
			37000841,
			37000842,
			37000843
		}
	},
	[37000805] = {
		Id = 37000805,
		RandomWeight = 20,
		ConditionIDList = {
			504,
			213
		},
		ActionUnitIDList = {
			37000850,
			37000851,
			37000852,
			37000853
		}
	},
	[37000806] = {
		Id = 37000806,
		RandomWeight = 50,
		ActionUnitIDList = {
			37000860,
			37000861,
			37000862,
			37000863
		}
	},
	[37000807] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 37000807,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			37000870,
			37000871,
			37000872,
			37000873
		}
	},
	[37000808] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 37000808,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			37000880,
			37000881,
			37000882,
			37000883
		}
	},
	[37005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 37005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[37005002] = {
		Id = 37005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			37000100,
			37000110,
			37000111,
			37000112,
			37000113,
			37000120
		}
	},
	[38000001] = {
		Id = 38000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[38000002] = {
		Id = 38000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[38000003] = {
		Id = 38000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[38000004] = {
		Id = 38000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			38000010
		}
	},
	[38000005] = {
		Id = 38000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			38000020
		}
	},
	[38000011] = {
		RandomWeight = 10,
		Id = 38000011,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000110,
			38000100,
			38000110,
			38000120
		}
	},
	[38000012] = {
		RandomWeight = 10,
		Id = 38000012,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000130
		}
	},
	[38000013] = {
		RandomWeight = 10,
		Id = 38000013,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000110,
			38000100,
			38000110,
			38000131,
			38000100
		}
	},
	[38000021] = {
		RandomWeight = 20,
		Id = 38000021,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000111,
			38000100,
			38000111,
			38000120
		}
	},
	[38000022] = {
		RandomWeight = 20,
		Id = 38000022,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000112,
			38000100,
			38000112,
			38000120
		}
	},
	[38000023] = {
		RandomWeight = 20,
		Id = 38000023,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000113,
			38000100,
			38000113,
			38000120
		}
	},
	[38000024] = {
		RandomWeight = 20,
		Id = 38000024,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000140
		}
	},
	[38000025] = {
		RandomWeight = 20,
		Id = 38000025,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			38000110,
			38000100,
			38000110,
			38000141,
			38000100
		}
	},
	[38000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 38000026,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			38000150
		}
	},
	[38000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 38000031,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101,
			820
		},
		ActionUnitIDList = {
			38000151
		}
	},
	[38000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 38000041,
		SubstituteAction = 38000004,
		ConditionIDList = {
			101,
			835
		},
		ActionUnitIDList = {
			38000152
		}
	},
	[38000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 38000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			38000210
		}
	},
	[38000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 38000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			38000211
		}
	},
	[38000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 38000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			38000210
		}
	},
	[38000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 38000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			38000211
		}
	},
	[38000121] = {
		Id = 38000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[38000122] = {
		Id = 38000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[38000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 38000201,
		SubstituteAction = 38000005,
		ActionUnitIDList = {
			38000300,
			38000310
		}
	},
	[38000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 38000202,
		SubstituteAction = 38000005,
		ActionUnitIDList = {
			38000300,
			38000311
		}
	},
	[38000211] = {
		Id = 38000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[38000212] = {
		RandomWeight = 10,
		Id = 38000212,
		SubstituteAction = 38000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			38000320
		}
	},
	[38000213] = {
		Id = 38000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[38000214] = {
		RandomWeight = 60,
		Id = 38000214,
		SubstituteAction = 38000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			38000321
		}
	},
	[38000221] = {
		RandomWeight = 10,
		Id = 38000221,
		SubstituteAction = 38000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			38000310
		}
	},
	[38000222] = {
		RandomWeight = 20,
		Id = 38000222,
		SubstituteAction = 38000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			38000311
		}
	},
	[38000231] = {
		isDailyAction = true,
		Id = 38000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			38000330
		}
	},
	[38000232] = {
		isDailyAction = true,
		Id = 38000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			38000331
		}
	},
	[38000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 38000301,
		SubstituteAction = 38000005,
		ActionUnitIDList = {
			38000400,
			38000410
		}
	},
	[38000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 38000302,
		SubstituteAction = 38000005,
		ActionUnitIDList = {
			38000400,
			38000411
		}
	},
	[38000311] = {
		Id = 38000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[38000312] = {
		RandomWeight = 10,
		Id = 38000312,
		SubstituteAction = 38000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			38000420
		}
	},
	[38000313] = {
		Id = 38000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[38000314] = {
		RandomWeight = 60,
		Id = 38000314,
		SubstituteAction = 38000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			38000421
		}
	},
	[38000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000321,
		SubstituteAction = 38000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			38000410
		}
	},
	[38000322] = {
		RandomWeight = 20,
		Id = 38000322,
		SubstituteAction = 38000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			38000411
		}
	},
	[38000331] = {
		isDailyAction = true,
		Id = 38000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			38000430
		}
	},
	[38000332] = {
		isDailyAction = true,
		Id = 38000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			38000431
		}
	},
	[38000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 38000401,
		SubstituteAction = 38000005,
		ActionUnitIDList = {
			38000500,
			38000510
		}
	},
	[38000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 38000402,
		SubstituteAction = 38000005,
		ActionUnitIDList = {
			38000500,
			38000511
		}
	},
	[38000411] = {
		Id = 38000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[38000412] = {
		RandomWeight = 10,
		Id = 38000412,
		SubstituteAction = 38000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			38000520
		}
	},
	[38000413] = {
		Id = 38000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[38000414] = {
		RandomWeight = 60,
		Id = 38000414,
		SubstituteAction = 38000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			38000521
		}
	},
	[38000421] = {
		RandomWeight = 10,
		Id = 38000421,
		SubstituteAction = 38000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			38000510
		}
	},
	[38000422] = {
		RandomWeight = 20,
		Id = 38000422,
		SubstituteAction = 38000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			38000511
		}
	},
	[38000431] = {
		isDailyAction = true,
		Id = 38000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			38000530
		}
	},
	[38000432] = {
		isDailyAction = true,
		Id = 38000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			38000531
		}
	},
	[38000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000501,
		SubstituteAction = 38000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000600,
			38000601,
			38000602,
			38000603,
			38000604
		}
	},
	[38000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000502,
		SubstituteAction = 38000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000610,
			38000611,
			38000612,
			38000613,
			38000614
		}
	},
	[38000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000605,
			38000606
		}
	},
	[38000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000615,
			38000616
		}
	},
	[38000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000511,
		SubstituteAction = 38000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			38000620,
			38000621,
			38000622
		}
	},
	[38000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000512,
		SubstituteAction = 38000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			38000630,
			38000631,
			38000632
		}
	},
	[38000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			38000623,
			38000624
		}
	},
	[38000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			38000633,
			38000634
		}
	},
	[38000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000521,
		SubstituteAction = 38000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			38000620,
			38000625,
			38000624
		}
	},
	[38000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 38000522,
		SubstituteAction = 38000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			38000630,
			38000635,
			38000634
		}
	},
	[38000601] = {
		Id = 38000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[38000602] = {
		RandomWeight = 10,
		Id = 38000602,
		SubstituteAction = 38000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000100,
			38000640
		}
	},
	[38000603] = {
		Id = 38000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[38000604] = {
		RandomWeight = 30,
		Id = 38000604,
		SubstituteAction = 38000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000100,
			38000642
		}
	},
	[38000605] = {
		Id = 38000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000641
		}
	},
	[38000606] = {
		Id = 38000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000643
		}
	},
	[38000607] = {
		RandomWeight = 10,
		Id = 38000607,
		SubstituteAction = 38000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000640
		}
	},
	[38000608] = {
		RandomWeight = 30,
		Id = 38000608,
		SubstituteAction = 38000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			38000642
		}
	},
	[38000611] = {
		Id = 38000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[38000612] = {
		RandomWeight = 30,
		Id = 38000612,
		SubstituteAction = 38000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			38000100,
			38000650,
			38000651
		}
	},
	[38000613] = {
		Id = 38000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[38000614] = {
		RandomWeight = 30,
		Id = 38000614,
		SubstituteAction = 38000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			38000100,
			38000652,
			38000653
		}
	},
	[38000615] = {
		Id = 38000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			38000651
		}
	},
	[38000616] = {
		Id = 38000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			38000653
		}
	},
	[38000617] = {
		RandomWeight = 30,
		Id = 38000617,
		SubstituteAction = 38000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			38000650,
			38000651
		}
	},
	[38000618] = {
		RandomWeight = 30,
		Id = 38000618,
		SubstituteAction = 38000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			38000652,
			38000653
		}
	},
	[38000621] = {
		Id = 38000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[38000622] = {
		RandomWeight = 30,
		Id = 38000622,
		SubstituteAction = 38000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			38000635,
			38000624
		}
	},
	[38000623] = {
		Id = 38000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[38000624] = {
		RandomWeight = 30,
		Id = 38000624,
		SubstituteAction = 38000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			38000635,
			38000632
		}
	},
	[38000625] = {
		RandomWeight = 30,
		Id = 38000625,
		SubstituteAction = 38000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			38000661
		}
	},
	[38000626] = {
		RandomWeight = 30,
		Id = 38000626,
		SubstituteAction = 38000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			38000662
		}
	},
	[38000701] = {
		RandomWeight = 30,
		Id = 38000701,
		SubstituteAction = 38000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			38000603,
			38000604
		}
	},
	[38000702] = {
		RandomWeight = 10,
		Id = 38000702,
		SubstituteAction = 38000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			38000613,
			38000614
		}
	},
	[38000711] = {
		SubstituteAction = 38000513,
		RandomWeight = 10,
		Id = 38000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[38000712] = {
		RandomWeight = 10,
		Id = 38000712,
		SubstituteAction = 38000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			38000631,
			38000632
		}
	},
	[38000713] = {
		RandomWeight = 10,
		Id = 38000713,
		SubstituteAction = 38000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			38000635,
			38000624
		}
	},
	[38000714] = {
		RandomWeight = 10,
		Id = 38000714,
		SubstituteAction = 38000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			38000635,
			38000632
		}
	},
	[38000801] = {
		Id = 38000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			38000810,
			38000811,
			38000812,
			38000813
		}
	},
	[38000802] = {
		Id = 38000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			38000820,
			38000821,
			38000822,
			38000823
		}
	},
	[38000803] = {
		Id = 38000803,
		RandomWeight = 50,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			38000830,
			38000831,
			38000832,
			38000833
		}
	},
	[38000804] = {
		isDailyAction = true,
		Id = 38000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			38000840,
			38000841,
			38000842,
			38000843
		}
	},
	[38000805] = {
		isDailyAction = true,
		Id = 38000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			38000850,
			38000851,
			38000852,
			38000853
		}
	},
	[38005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 38005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[38005002] = {
		Id = 38005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			38000100,
			38000110,
			38000111,
			38000112,
			38000113,
			38000120
		}
	},
	[39000001] = {
		Id = 39000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[39000002] = {
		Id = 39000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[39000003] = {
		Id = 39000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[39000004] = {
		Id = 39000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			39000010
		}
	},
	[39000005] = {
		Id = 39000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			39000020
		}
	},
	[39000011] = {
		RandomWeight = 10,
		Id = 39000011,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000110,
			39000100,
			39000110,
			39000120
		}
	},
	[39000012] = {
		RandomWeight = 10,
		Id = 39000012,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000130
		}
	},
	[39000013] = {
		RandomWeight = 10,
		Id = 39000013,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000110,
			39000100,
			39000110,
			39000131,
			39000100
		}
	},
	[39000021] = {
		RandomWeight = 20,
		Id = 39000021,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000111,
			39000100,
			39000111,
			39000120
		}
	},
	[39000022] = {
		RandomWeight = 20,
		Id = 39000022,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000112,
			39000100,
			39000112,
			39000120
		}
	},
	[39000023] = {
		RandomWeight = 20,
		Id = 39000023,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000113,
			39000100,
			39000113,
			39000120
		}
	},
	[39000024] = {
		RandomWeight = 20,
		Id = 39000024,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000140
		}
	},
	[39000025] = {
		RandomWeight = 20,
		Id = 39000025,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			39000110,
			39000100,
			39000110,
			39000141,
			39000100
		}
	},
	[39000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 39000026,
		SubstituteAction = 39000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			39000150
		}
	},
	[39000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 39000031,
		SubstituteAction = 39000004,
		ConditionIDList = {
			814,
			836
		},
		ActionUnitIDList = {
			39000151
		}
	},
	[39000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 39000041,
		SubstituteAction = 39000004,
		ConditionIDList = {
			825,
			833
		},
		ActionUnitIDList = {
			39000152
		}
	},
	[39000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 39000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			39000210
		}
	},
	[39000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 39000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			39000211
		}
	},
	[39000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 39000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			39000210
		}
	},
	[39000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 39000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			39000211
		}
	},
	[39000121] = {
		Id = 39000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[39000122] = {
		Id = 39000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[39000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 39000201,
		SubstituteAction = 39000005,
		ActionUnitIDList = {
			39000300,
			39000310
		}
	},
	[39000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 39000202,
		SubstituteAction = 39000005,
		ActionUnitIDList = {
			39000300,
			39000311
		}
	},
	[39000211] = {
		Id = 39000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[39000212] = {
		RandomWeight = 10,
		Id = 39000212,
		SubstituteAction = 39000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			39000320
		}
	},
	[39000213] = {
		Id = 39000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[39000214] = {
		RandomWeight = 60,
		Id = 39000214,
		SubstituteAction = 39000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			39000321
		}
	},
	[39000221] = {
		RandomWeight = 10,
		Id = 39000221,
		SubstituteAction = 39000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			39000310
		}
	},
	[39000222] = {
		RandomWeight = 20,
		Id = 39000222,
		SubstituteAction = 39000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			39000311
		}
	},
	[39000231] = {
		isDailyAction = true,
		Id = 39000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			39000330
		}
	},
	[39000232] = {
		isDailyAction = true,
		Id = 39000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			39000331
		}
	},
	[39000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 39000301,
		SubstituteAction = 39000005,
		ActionUnitIDList = {
			39000400,
			39000410
		}
	},
	[39000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 39000302,
		SubstituteAction = 39000005,
		ActionUnitIDList = {
			39000400,
			39000411
		}
	},
	[39000311] = {
		Id = 39000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[39000312] = {
		RandomWeight = 10,
		Id = 39000312,
		SubstituteAction = 39000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			39000420
		}
	},
	[39000313] = {
		Id = 39000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[39000314] = {
		RandomWeight = 60,
		Id = 39000314,
		SubstituteAction = 39000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			39000421
		}
	},
	[39000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000321,
		SubstituteAction = 39000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			39000410
		}
	},
	[39000322] = {
		RandomWeight = 20,
		Id = 39000322,
		SubstituteAction = 39000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			39000411
		}
	},
	[39000331] = {
		isDailyAction = true,
		Id = 39000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			39000430
		}
	},
	[39000332] = {
		isDailyAction = true,
		Id = 39000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			39000431
		}
	},
	[39000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 39000401,
		SubstituteAction = 39000005,
		ActionUnitIDList = {
			39000500,
			39000510
		}
	},
	[39000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 39000402,
		SubstituteAction = 39000005,
		ActionUnitIDList = {
			39000500,
			39000511
		}
	},
	[39000411] = {
		Id = 39000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[39000412] = {
		RandomWeight = 10,
		Id = 39000412,
		SubstituteAction = 39000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			39000520
		}
	},
	[39000413] = {
		Id = 39000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[39000414] = {
		RandomWeight = 60,
		Id = 39000414,
		SubstituteAction = 39000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			39000521
		}
	},
	[39000421] = {
		RandomWeight = 10,
		Id = 39000421,
		SubstituteAction = 39000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			39000510
		}
	},
	[39000422] = {
		RandomWeight = 20,
		Id = 39000422,
		SubstituteAction = 39000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			39000511
		}
	},
	[39000431] = {
		isDailyAction = true,
		Id = 39000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			39000530
		}
	},
	[39000432] = {
		isDailyAction = true,
		Id = 39000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			39000531
		}
	},
	[39000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000501,
		SubstituteAction = 39000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000600,
			39000601,
			39000602,
			39000603,
			39000604
		}
	},
	[39000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000502,
		SubstituteAction = 39000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000610,
			39000611,
			39000612,
			39000613,
			39000614
		}
	},
	[39000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000605,
			39000606
		}
	},
	[39000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000615,
			39000616
		}
	},
	[39000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000511,
		SubstituteAction = 39000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			39000620,
			39000621,
			39000622
		}
	},
	[39000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000512,
		SubstituteAction = 39000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			39000630,
			39000631,
			39000632
		}
	},
	[39000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			39000623,
			39000624
		}
	},
	[39000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			39000633,
			39000634
		}
	},
	[39000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000521,
		SubstituteAction = 39000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			39000620,
			39000625,
			39000624
		}
	},
	[39000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 39000522,
		SubstituteAction = 39000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			39000630,
			39000635,
			39000634
		}
	},
	[39000601] = {
		Id = 39000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[39000602] = {
		RandomWeight = 10,
		Id = 39000602,
		SubstituteAction = 39000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000100,
			39000640
		}
	},
	[39000603] = {
		Id = 39000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[39000604] = {
		RandomWeight = 30,
		Id = 39000604,
		SubstituteAction = 39000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000100,
			39000642
		}
	},
	[39000605] = {
		Id = 39000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000641
		}
	},
	[39000606] = {
		Id = 39000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000643
		}
	},
	[39000607] = {
		RandomWeight = 10,
		Id = 39000607,
		SubstituteAction = 39000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000640
		}
	},
	[39000608] = {
		RandomWeight = 30,
		Id = 39000608,
		SubstituteAction = 39000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			39000642
		}
	},
	[39000611] = {
		Id = 39000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[39000612] = {
		RandomWeight = 30,
		Id = 39000612,
		SubstituteAction = 39000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			39000100,
			39000650,
			39000651
		}
	},
	[39000613] = {
		Id = 39000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[39000614] = {
		RandomWeight = 30,
		Id = 39000614,
		SubstituteAction = 39000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			39000100,
			39000652,
			39000653
		}
	},
	[39000615] = {
		Id = 39000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			39000651
		}
	},
	[39000616] = {
		Id = 39000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			39000653
		}
	},
	[39000617] = {
		RandomWeight = 30,
		Id = 39000617,
		SubstituteAction = 39000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			39000650,
			39000651
		}
	},
	[39000618] = {
		RandomWeight = 30,
		Id = 39000618,
		SubstituteAction = 39000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			39000652,
			39000653
		}
	},
	[39000621] = {
		Id = 39000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[39000622] = {
		RandomWeight = 30,
		Id = 39000622,
		SubstituteAction = 39000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			39000635,
			39000624
		}
	},
	[39000623] = {
		Id = 39000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[39000624] = {
		RandomWeight = 30,
		Id = 39000624,
		SubstituteAction = 39000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			39000635,
			39000632
		}
	},
	[39000625] = {
		RandomWeight = 30,
		Id = 39000625,
		SubstituteAction = 39000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			39000661
		}
	},
	[39000626] = {
		RandomWeight = 30,
		Id = 39000626,
		SubstituteAction = 39000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			39000662
		}
	},
	[39000701] = {
		RandomWeight = 30,
		Id = 39000701,
		SubstituteAction = 39000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			39000603,
			39000604
		}
	},
	[39000702] = {
		RandomWeight = 10,
		Id = 39000702,
		SubstituteAction = 39000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			39000613,
			39000614
		}
	},
	[39000711] = {
		SubstituteAction = 39000513,
		RandomWeight = 10,
		Id = 39000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[39000712] = {
		RandomWeight = 10,
		Id = 39000712,
		SubstituteAction = 39000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			39000631,
			39000632
		}
	},
	[39000713] = {
		RandomWeight = 10,
		Id = 39000713,
		SubstituteAction = 39000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			39000635,
			39000624
		}
	},
	[39000714] = {
		RandomWeight = 10,
		Id = 39000714,
		SubstituteAction = 39000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			39000635,
			39000632
		}
	},
	[39000801] = {
		Id = 39000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			39000810,
			39000811,
			39000812,
			39000813
		}
	},
	[39000802] = {
		Id = 39000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			39000820,
			39000821,
			39000822,
			39000823
		}
	},
	[39000803] = {
		Id = 39000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			39000830,
			39000831,
			39000832,
			39000833
		}
	},
	[39000804] = {
		isDailyAction = true,
		Id = 39000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			39000840,
			39000841,
			39000842,
			39000843
		}
	},
	[39000805] = {
		isDailyAction = true,
		Id = 39000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			39000850,
			39000851,
			39000852,
			39000853
		}
	},
	[39005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 39005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[39005002] = {
		Id = 39005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			39000100,
			39000110,
			39000111,
			39000112,
			39000113,
			39000120
		}
	},
	[40000001] = {
		Id = 40000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[40000002] = {
		Id = 40000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[40000003] = {
		Id = 40000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[40000004] = {
		Id = 40000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			40000010
		}
	},
	[40000005] = {
		Id = 40000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			40000020
		}
	},
	[40000011] = {
		RandomWeight = 10,
		Id = 40000011,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000110,
			40000100,
			40000110,
			40000120
		}
	},
	[40000012] = {
		RandomWeight = 10,
		Id = 40000012,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000130
		}
	},
	[40000013] = {
		RandomWeight = 10,
		Id = 40000013,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000110,
			40000100,
			40000110,
			40000131,
			40000100
		}
	},
	[40000021] = {
		RandomWeight = 20,
		Id = 40000021,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000111,
			40000100,
			40000111,
			40000120
		}
	},
	[40000022] = {
		RandomWeight = 20,
		Id = 40000022,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000112,
			40000100,
			40000112,
			40000120
		}
	},
	[40000023] = {
		RandomWeight = 20,
		Id = 40000023,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000113,
			40000100,
			40000113,
			40000120
		}
	},
	[40000024] = {
		RandomWeight = 20,
		Id = 40000024,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000140
		}
	},
	[40000025] = {
		RandomWeight = 20,
		Id = 40000025,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			40000110,
			40000100,
			40000110,
			40000141,
			40000100
		}
	},
	[40000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 40000026,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			40000150
		}
	},
	[40000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 40000031,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101,
			816,
			842
		},
		ActionUnitIDList = {
			40000151
		}
	},
	[40000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 40000041,
		SubstituteAction = 40000004,
		ConditionIDList = {
			101,
			825
		},
		ActionUnitIDList = {
			40000152
		}
	},
	[40000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 40000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			40000210
		}
	},
	[40000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 40000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			40000211
		}
	},
	[40000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 40000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			40000210
		}
	},
	[40000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 40000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			40000211
		}
	},
	[40000121] = {
		Id = 40000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[40000122] = {
		Id = 40000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[40000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 40000201,
		SubstituteAction = 40000005,
		ActionUnitIDList = {
			40000300,
			40000310
		}
	},
	[40000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 40000202,
		SubstituteAction = 40000005,
		ActionUnitIDList = {
			40000300,
			40000311
		}
	},
	[40000211] = {
		Id = 40000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[40000212] = {
		RandomWeight = 10,
		Id = 40000212,
		SubstituteAction = 40000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			40000320
		}
	},
	[40000213] = {
		Id = 40000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[40000214] = {
		RandomWeight = 60,
		Id = 40000214,
		SubstituteAction = 40000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			40000321
		}
	},
	[40000221] = {
		RandomWeight = 10,
		Id = 40000221,
		SubstituteAction = 40000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			40000310
		}
	},
	[40000222] = {
		RandomWeight = 20,
		Id = 40000222,
		SubstituteAction = 40000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			40000311
		}
	},
	[40000231] = {
		isDailyAction = true,
		Id = 40000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			40000330
		}
	},
	[40000232] = {
		isDailyAction = true,
		Id = 40000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			40000331
		}
	},
	[40000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 40000301,
		SubstituteAction = 40000005,
		ActionUnitIDList = {
			40000400,
			40000410
		}
	},
	[40000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 40000302,
		SubstituteAction = 40000005,
		ActionUnitIDList = {
			40000400,
			40000411
		}
	},
	[40000311] = {
		Id = 40000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[40000312] = {
		RandomWeight = 10,
		Id = 40000312,
		SubstituteAction = 40000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			40000420
		}
	},
	[40000313] = {
		Id = 40000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[40000314] = {
		RandomWeight = 60,
		Id = 40000314,
		SubstituteAction = 40000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			40000421
		}
	},
	[40000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000321,
		SubstituteAction = 40000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			40000410
		}
	},
	[40000322] = {
		RandomWeight = 20,
		Id = 40000322,
		SubstituteAction = 40000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			40000411
		}
	},
	[40000331] = {
		isDailyAction = true,
		Id = 40000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			40000430
		}
	},
	[40000332] = {
		isDailyAction = true,
		Id = 40000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			40000431
		}
	},
	[40000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 40000401,
		SubstituteAction = 40000005,
		ActionUnitIDList = {
			40000500,
			40000510
		}
	},
	[40000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 40000402,
		SubstituteAction = 40000005,
		ActionUnitIDList = {
			40000500,
			40000511
		}
	},
	[40000411] = {
		Id = 40000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[40000412] = {
		RandomWeight = 10,
		Id = 40000412,
		SubstituteAction = 40000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			40000520
		}
	},
	[40000413] = {
		Id = 40000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[40000414] = {
		RandomWeight = 60,
		Id = 40000414,
		SubstituteAction = 40000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			40000521
		}
	},
	[40000421] = {
		RandomWeight = 10,
		Id = 40000421,
		SubstituteAction = 40000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			40000510
		}
	},
	[40000422] = {
		RandomWeight = 20,
		Id = 40000422,
		SubstituteAction = 40000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			40000511
		}
	},
	[40000431] = {
		isDailyAction = true,
		Id = 40000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			40000530
		}
	},
	[40000432] = {
		isDailyAction = true,
		Id = 40000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			40000531
		}
	},
	[40000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000501,
		SubstituteAction = 40000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000600,
			40000601,
			40000602,
			40000603,
			40000604
		}
	},
	[40000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000502,
		SubstituteAction = 40000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000610,
			40000611,
			40000612,
			40000613,
			40000614
		}
	},
	[40000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000605,
			40000606
		}
	},
	[40000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000615,
			40000616
		}
	},
	[40000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000511,
		SubstituteAction = 40000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			40000620,
			40000621,
			40000622
		}
	},
	[40000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000512,
		SubstituteAction = 40000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			40000630,
			40000631,
			40000632
		}
	},
	[40000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			40000623,
			40000624
		}
	},
	[40000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			40000633,
			40000634
		}
	},
	[40000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000521,
		SubstituteAction = 40000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			40000620,
			40000625,
			40000624
		}
	},
	[40000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 40000522,
		SubstituteAction = 40000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			40000630,
			40000635,
			40000634
		}
	},
	[40000601] = {
		Id = 40000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[40000602] = {
		RandomWeight = 10,
		Id = 40000602,
		SubstituteAction = 40000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000100,
			40000640
		}
	},
	[40000603] = {
		Id = 40000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[40000604] = {
		RandomWeight = 30,
		Id = 40000604,
		SubstituteAction = 40000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000100,
			40000642
		}
	},
	[40000605] = {
		Id = 40000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000641
		}
	},
	[40000606] = {
		Id = 40000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000643
		}
	},
	[40000607] = {
		RandomWeight = 10,
		Id = 40000607,
		SubstituteAction = 40000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000640
		}
	},
	[40000608] = {
		RandomWeight = 30,
		Id = 40000608,
		SubstituteAction = 40000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			40000642
		}
	},
	[40000611] = {
		Id = 40000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[40000612] = {
		RandomWeight = 30,
		Id = 40000612,
		SubstituteAction = 40000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			40000100,
			40000650,
			40000651
		}
	},
	[40000613] = {
		Id = 40000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[40000614] = {
		RandomWeight = 30,
		Id = 40000614,
		SubstituteAction = 40000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			40000100,
			40000652,
			40000653
		}
	},
	[40000615] = {
		Id = 40000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			40000651
		}
	},
	[40000616] = {
		Id = 40000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			40000653
		}
	},
	[40000617] = {
		RandomWeight = 30,
		Id = 40000617,
		SubstituteAction = 40000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			40000650,
			40000651
		}
	},
	[40000618] = {
		RandomWeight = 30,
		Id = 40000618,
		SubstituteAction = 40000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			40000652,
			40000653
		}
	},
	[40000621] = {
		Id = 40000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[40000622] = {
		RandomWeight = 30,
		Id = 40000622,
		SubstituteAction = 40000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			40000635,
			40000624
		}
	},
	[40000623] = {
		Id = 40000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[40000624] = {
		RandomWeight = 30,
		Id = 40000624,
		SubstituteAction = 40000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			40000635,
			40000632
		}
	},
	[40000625] = {
		RandomWeight = 30,
		Id = 40000625,
		SubstituteAction = 40000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			40000661
		}
	},
	[40000626] = {
		RandomWeight = 30,
		Id = 40000626,
		SubstituteAction = 40000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			40000662
		}
	},
	[40000701] = {
		RandomWeight = 30,
		Id = 40000701,
		SubstituteAction = 40000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			40000603,
			40000604
		}
	},
	[40000702] = {
		RandomWeight = 10,
		Id = 40000702,
		SubstituteAction = 40000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			40000613,
			40000614
		}
	},
	[40000711] = {
		SubstituteAction = 40000513,
		RandomWeight = 10,
		Id = 40000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[40000712] = {
		RandomWeight = 10,
		Id = 40000712,
		SubstituteAction = 40000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			40000631,
			40000632
		}
	},
	[40000713] = {
		RandomWeight = 10,
		Id = 40000713,
		SubstituteAction = 40000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			40000635,
			40000624
		}
	},
	[40000714] = {
		RandomWeight = 10,
		Id = 40000714,
		SubstituteAction = 40000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			40000635,
			40000632
		}
	},
	[40000801] = {
		Id = 40000801,
		RandomWeight = 50,
		ConditionIDList = {
			505
		},
		ActionUnitIDList = {
			40000810,
			40000811,
			40000812,
			40000813
		}
	},
	[40000802] = {
		Id = 40000802,
		RandomWeight = 50,
		ConditionIDList = {
			213
		},
		ActionUnitIDList = {
			40000820,
			40000821,
			40000822,
			40000823
		}
	},
	[40000803] = {
		Id = 40000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			40000830,
			40000831,
			40000832,
			40000833
		}
	},
	[40000804] = {
		Id = 40000804,
		RandomWeight = 50,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			40000840,
			40000841,
			40000842,
			40000843
		}
	},
	[40000805] = {
		Id = 40000805,
		RandomWeight = 50,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			40000850,
			40000851,
			40000852,
			40000853
		}
	},
	[40000806] = {
		Id = 40000806,
		RandomWeight = 50,
		ActionUnitIDList = {
			40000854,
			40000855
		}
	},
	[40005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 40005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[40005002] = {
		Id = 40005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			40000100,
			40000110,
			40000111,
			40000112,
			40000113,
			40000120
		}
	},
	[41000001] = {
		Id = 41000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[41000002] = {
		Id = 41000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[41000003] = {
		Id = 41000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[41000004] = {
		Id = 41000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			41000010
		}
	},
	[41000005] = {
		Id = 41000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			41000020
		}
	},
	[41000011] = {
		RandomWeight = 10,
		Id = 41000011,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000110,
			41000100,
			41000110,
			41000120
		}
	},
	[41000012] = {
		RandomWeight = 10,
		Id = 41000012,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000130
		}
	},
	[41000013] = {
		RandomWeight = 10,
		Id = 41000013,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000110,
			41000100,
			41000110,
			41000131,
			41000100
		}
	},
	[41000021] = {
		RandomWeight = 20,
		Id = 41000021,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000111,
			41000100,
			41000111,
			41000120
		}
	},
	[41000022] = {
		RandomWeight = 20,
		Id = 41000022,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000112,
			41000100,
			41000112,
			41000120
		}
	},
	[41000023] = {
		RandomWeight = 20,
		Id = 41000023,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000113,
			41000100,
			41000113,
			41000120
		}
	},
	[41000024] = {
		RandomWeight = 20,
		Id = 41000024,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000140
		}
	},
	[41000025] = {
		RandomWeight = 20,
		Id = 41000025,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			41000110,
			41000100,
			41000110,
			41000141,
			41000100
		}
	},
	[41000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 41000026,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			41000150
		}
	},
	[41000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 41000031,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101,
			817
		},
		ActionUnitIDList = {
			41000151
		}
	},
	[41000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 41000041,
		SubstituteAction = 41000004,
		ConditionIDList = {
			101,
			832
		},
		ActionUnitIDList = {
			41000152
		}
	},
	[41000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 41000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			41000210
		}
	},
	[41000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 41000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			41000211
		}
	},
	[41000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 41000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			41000210
		}
	},
	[41000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 41000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			41000211
		}
	},
	[41000121] = {
		Id = 41000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[41000122] = {
		Id = 41000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[41000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 41000201,
		SubstituteAction = 41000005,
		ActionUnitIDList = {
			41000300,
			41000310
		}
	},
	[41000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 41000202,
		SubstituteAction = 41000005,
		ActionUnitIDList = {
			41000300,
			41000311
		}
	},
	[41000211] = {
		Id = 41000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[41000212] = {
		RandomWeight = 10,
		Id = 41000212,
		SubstituteAction = 41000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			41000320
		}
	},
	[41000213] = {
		Id = 41000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[41000214] = {
		RandomWeight = 60,
		Id = 41000214,
		SubstituteAction = 41000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			41000321
		}
	},
	[41000221] = {
		RandomWeight = 10,
		Id = 41000221,
		SubstituteAction = 41000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			41000310
		}
	},
	[41000222] = {
		RandomWeight = 20,
		Id = 41000222,
		SubstituteAction = 41000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			41000311
		}
	},
	[41000231] = {
		isDailyAction = true,
		Id = 41000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			41000330
		}
	},
	[41000232] = {
		isDailyAction = true,
		Id = 41000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			41000331
		}
	},
	[41000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 41000301,
		SubstituteAction = 41000005,
		ActionUnitIDList = {
			41000400,
			41000410
		}
	},
	[41000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 41000302,
		SubstituteAction = 41000005,
		ActionUnitIDList = {
			41000400,
			41000411
		}
	},
	[41000311] = {
		Id = 41000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[41000312] = {
		RandomWeight = 10,
		Id = 41000312,
		SubstituteAction = 41000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			41000420
		}
	},
	[41000313] = {
		Id = 41000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[41000314] = {
		RandomWeight = 60,
		Id = 41000314,
		SubstituteAction = 41000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			41000421
		}
	},
	[41000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000321,
		SubstituteAction = 41000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			41000410
		}
	},
	[41000322] = {
		RandomWeight = 20,
		Id = 41000322,
		SubstituteAction = 41000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			41000411
		}
	},
	[41000331] = {
		isDailyAction = true,
		Id = 41000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			41000430
		}
	},
	[41000332] = {
		isDailyAction = true,
		Id = 41000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			41000431
		}
	},
	[41000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 41000401,
		SubstituteAction = 41000005,
		ActionUnitIDList = {
			41000500,
			41000510
		}
	},
	[41000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 41000402,
		SubstituteAction = 41000005,
		ActionUnitIDList = {
			41000500,
			41000511
		}
	},
	[41000411] = {
		Id = 41000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[41000412] = {
		RandomWeight = 10,
		Id = 41000412,
		SubstituteAction = 41000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			41000520
		}
	},
	[41000413] = {
		Id = 41000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[41000414] = {
		RandomWeight = 60,
		Id = 41000414,
		SubstituteAction = 41000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			41000521
		}
	},
	[41000421] = {
		RandomWeight = 10,
		Id = 41000421,
		SubstituteAction = 41000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			41000510
		}
	},
	[41000422] = {
		RandomWeight = 20,
		Id = 41000422,
		SubstituteAction = 41000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			41000511
		}
	},
	[41000431] = {
		isDailyAction = true,
		Id = 41000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			41000530
		}
	},
	[41000432] = {
		isDailyAction = true,
		Id = 41000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			41000531
		}
	},
	[41000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000501,
		SubstituteAction = 41000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000600,
			41000601,
			41000602,
			41000603,
			41000604
		}
	},
	[41000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000502,
		SubstituteAction = 41000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000610,
			41000611,
			41000612,
			41000613,
			41000614
		}
	},
	[41000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000605,
			41000606
		}
	},
	[41000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000615,
			41000616
		}
	},
	[41000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000511,
		SubstituteAction = 41000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			41000620,
			41000621,
			41000622
		}
	},
	[41000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000512,
		SubstituteAction = 41000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			41000630,
			41000631,
			41000632
		}
	},
	[41000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			41000623,
			41000624
		}
	},
	[41000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			41000633,
			41000634
		}
	},
	[41000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000521,
		SubstituteAction = 41000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			41000620,
			41000625,
			41000624
		}
	},
	[41000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 41000522,
		SubstituteAction = 41000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			41000630,
			41000635,
			41000634
		}
	},
	[41000601] = {
		Id = 41000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[41000602] = {
		RandomWeight = 10,
		Id = 41000602,
		SubstituteAction = 41000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000100,
			41000640
		}
	},
	[41000603] = {
		Id = 41000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[41000604] = {
		RandomWeight = 30,
		Id = 41000604,
		SubstituteAction = 41000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000100,
			41000642
		}
	},
	[41000605] = {
		Id = 41000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000641
		}
	},
	[41000606] = {
		Id = 41000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000643
		}
	},
	[41000607] = {
		RandomWeight = 10,
		Id = 41000607,
		SubstituteAction = 41000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000640
		}
	},
	[41000608] = {
		RandomWeight = 30,
		Id = 41000608,
		SubstituteAction = 41000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			41000642
		}
	},
	[41000611] = {
		Id = 41000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[41000612] = {
		RandomWeight = 30,
		Id = 41000612,
		SubstituteAction = 41000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			41000100,
			41000650,
			41000651
		}
	},
	[41000613] = {
		Id = 41000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[41000614] = {
		RandomWeight = 30,
		Id = 41000614,
		SubstituteAction = 41000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			41000100,
			41000652,
			41000653
		}
	},
	[41000615] = {
		Id = 41000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			41000651
		}
	},
	[41000616] = {
		Id = 41000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			41000653
		}
	},
	[41000617] = {
		RandomWeight = 30,
		Id = 41000617,
		SubstituteAction = 41000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			41000650,
			41000651
		}
	},
	[41000618] = {
		RandomWeight = 30,
		Id = 41000618,
		SubstituteAction = 41000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			41000652,
			41000653
		}
	},
	[41000621] = {
		Id = 41000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[41000622] = {
		RandomWeight = 30,
		Id = 41000622,
		SubstituteAction = 41000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			41000635,
			41000624
		}
	},
	[41000623] = {
		Id = 41000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[41000624] = {
		RandomWeight = 30,
		Id = 41000624,
		SubstituteAction = 41000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			41000635,
			41000632
		}
	},
	[41000625] = {
		RandomWeight = 30,
		Id = 41000625,
		SubstituteAction = 41000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			41000661
		}
	},
	[41000626] = {
		RandomWeight = 30,
		Id = 41000626,
		SubstituteAction = 41000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			41000662
		}
	},
	[41000701] = {
		RandomWeight = 30,
		Id = 41000701,
		SubstituteAction = 41000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			41000603,
			41000604
		}
	},
	[41000702] = {
		RandomWeight = 10,
		Id = 41000702,
		SubstituteAction = 41000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			41000613,
			41000614
		}
	},
	[41000711] = {
		SubstituteAction = 41000513,
		RandomWeight = 10,
		Id = 41000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[41000712] = {
		RandomWeight = 10,
		Id = 41000712,
		SubstituteAction = 41000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			41000631,
			41000632
		}
	},
	[41000713] = {
		RandomWeight = 10,
		Id = 41000713,
		SubstituteAction = 41000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			41000635,
			41000624
		}
	},
	[41000714] = {
		RandomWeight = 10,
		Id = 41000714,
		SubstituteAction = 41000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			41000635,
			41000632
		}
	},
	[41000801] = {
		Id = 41000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			41000810,
			41000811,
			41000812,
			41000813
		}
	},
	[41000802] = {
		Id = 41000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			41000820,
			41000821,
			41000822,
			41000823
		}
	},
	[41000803] = {
		Id = 41000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			41000830,
			41000831,
			41000832,
			41000833
		}
	},
	[41000804] = {
		isDailyAction = true,
		Id = 41000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			41000840,
			41000841,
			41000842,
			41000843
		}
	},
	[41000805] = {
		isDailyAction = true,
		Id = 41000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			41000850,
			41000851,
			41000852,
			41000853
		}
	},
	[41005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 41005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[41005002] = {
		Id = 41005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			41000100,
			41000110,
			41000111,
			41000112,
			41000113,
			41000120
		}
	},
	[42000001] = {
		Id = 42000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[42000002] = {
		Id = 42000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[42000003] = {
		Id = 42000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[42000004] = {
		Id = 42000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			42000010
		}
	},
	[42000005] = {
		Id = 42000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			42000020
		}
	},
	[42000011] = {
		RandomWeight = 10,
		Id = 42000011,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000110,
			42000100,
			42000110,
			42000120
		}
	},
	[42000012] = {
		RandomWeight = 10,
		Id = 42000012,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000130
		}
	},
	[42000013] = {
		RandomWeight = 10,
		Id = 42000013,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000110,
			42000100,
			42000110,
			42000131,
			42000100
		}
	},
	[42000021] = {
		RandomWeight = 20,
		Id = 42000021,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000111,
			42000100,
			42000111,
			42000120
		}
	},
	[42000022] = {
		RandomWeight = 20,
		Id = 42000022,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000112,
			42000100,
			42000112,
			42000120
		}
	},
	[42000023] = {
		RandomWeight = 20,
		Id = 42000023,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000113,
			42000100,
			42000113,
			42000120
		}
	},
	[42000024] = {
		RandomWeight = 20,
		Id = 42000024,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000140
		}
	},
	[42000025] = {
		RandomWeight = 20,
		Id = 42000025,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			42000110,
			42000100,
			42000110,
			42000141,
			42000100
		}
	},
	[42000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 42000026,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			42000150
		}
	},
	[42000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 42000031,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101,
			810,
			821
		},
		ActionUnitIDList = {
			42000151
		}
	},
	[42000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 42000041,
		SubstituteAction = 42000004,
		ConditionIDList = {
			101,
			809
		},
		ActionUnitIDList = {
			42000152
		}
	},
	[42000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 42000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			42000210
		}
	},
	[42000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 42000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			42000211
		}
	},
	[42000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 42000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			42000210
		}
	},
	[42000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 42000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			42000211
		}
	},
	[42000121] = {
		Id = 42000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[42000122] = {
		Id = 42000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[42000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 42000201,
		SubstituteAction = 42000005,
		ActionUnitIDList = {
			42000300,
			42000310
		}
	},
	[42000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 42000202,
		SubstituteAction = 42000005,
		ActionUnitIDList = {
			42000300,
			42000311
		}
	},
	[42000211] = {
		Id = 42000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[42000212] = {
		RandomWeight = 10,
		Id = 42000212,
		SubstituteAction = 42000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			42000320
		}
	},
	[42000213] = {
		Id = 42000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[42000214] = {
		RandomWeight = 60,
		Id = 42000214,
		SubstituteAction = 42000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			42000321
		}
	},
	[42000221] = {
		RandomWeight = 10,
		Id = 42000221,
		SubstituteAction = 42000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			42000310
		}
	},
	[42000222] = {
		RandomWeight = 20,
		Id = 42000222,
		SubstituteAction = 42000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			42000311
		}
	},
	[42000231] = {
		isDailyAction = true,
		Id = 42000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			42000330
		}
	},
	[42000232] = {
		isDailyAction = true,
		Id = 42000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			42000331
		}
	},
	[42000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 42000301,
		SubstituteAction = 42000005,
		ActionUnitIDList = {
			42000400,
			42000410
		}
	},
	[42000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 42000302,
		SubstituteAction = 42000005,
		ActionUnitIDList = {
			42000400,
			42000411
		}
	},
	[42000311] = {
		Id = 42000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[42000312] = {
		RandomWeight = 10,
		Id = 42000312,
		SubstituteAction = 42000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			42000420
		}
	},
	[42000313] = {
		Id = 42000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[42000314] = {
		RandomWeight = 60,
		Id = 42000314,
		SubstituteAction = 42000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			42000421
		}
	},
	[42000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000321,
		SubstituteAction = 42000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			42000410
		}
	},
	[42000322] = {
		RandomWeight = 20,
		Id = 42000322,
		SubstituteAction = 42000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			42000411
		}
	},
	[42000331] = {
		isDailyAction = true,
		Id = 42000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			42000430
		}
	},
	[42000332] = {
		isDailyAction = true,
		Id = 42000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			42000431
		}
	},
	[42000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 42000401,
		SubstituteAction = 42000005,
		ActionUnitIDList = {
			42000500,
			42000510
		}
	},
	[42000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 42000402,
		SubstituteAction = 42000005,
		ActionUnitIDList = {
			42000500,
			42000511
		}
	},
	[42000411] = {
		Id = 42000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[42000412] = {
		RandomWeight = 10,
		Id = 42000412,
		SubstituteAction = 42000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			42000520
		}
	},
	[42000413] = {
		Id = 42000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[42000414] = {
		RandomWeight = 60,
		Id = 42000414,
		SubstituteAction = 42000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			42000521
		}
	},
	[42000421] = {
		RandomWeight = 10,
		Id = 42000421,
		SubstituteAction = 42000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			42000510
		}
	},
	[42000422] = {
		RandomWeight = 20,
		Id = 42000422,
		SubstituteAction = 42000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			42000511
		}
	},
	[42000431] = {
		isDailyAction = true,
		Id = 42000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			42000530
		}
	},
	[42000432] = {
		isDailyAction = true,
		Id = 42000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			42000531
		}
	},
	[42000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000501,
		SubstituteAction = 42000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000600,
			42000601,
			42000602,
			42000603,
			42000604
		}
	},
	[42000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000502,
		SubstituteAction = 42000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000610,
			42000611,
			42000612,
			42000613,
			42000614
		}
	},
	[42000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000605,
			42000606
		}
	},
	[42000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000615,
			42000616
		}
	},
	[42000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000511,
		SubstituteAction = 42000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			42000620,
			42000621,
			42000622
		}
	},
	[42000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000512,
		SubstituteAction = 42000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			42000630,
			42000631,
			42000632
		}
	},
	[42000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			42000623,
			42000624
		}
	},
	[42000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			42000633,
			42000634
		}
	},
	[42000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000521,
		SubstituteAction = 42000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			42000620,
			42000625,
			42000624
		}
	},
	[42000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 42000522,
		SubstituteAction = 42000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			42000630,
			42000635,
			42000634
		}
	},
	[42000601] = {
		Id = 42000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[42000602] = {
		RandomWeight = 10,
		Id = 42000602,
		SubstituteAction = 42000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000100,
			42000640
		}
	},
	[42000603] = {
		Id = 42000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[42000604] = {
		RandomWeight = 30,
		Id = 42000604,
		SubstituteAction = 42000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000100,
			42000642
		}
	},
	[42000605] = {
		Id = 42000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000641
		}
	},
	[42000606] = {
		Id = 42000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000643
		}
	},
	[42000607] = {
		RandomWeight = 10,
		Id = 42000607,
		SubstituteAction = 42000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000640
		}
	},
	[42000608] = {
		RandomWeight = 30,
		Id = 42000608,
		SubstituteAction = 42000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			42000642
		}
	},
	[42000611] = {
		Id = 42000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[42000612] = {
		RandomWeight = 30,
		Id = 42000612,
		SubstituteAction = 42000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			42000100,
			42000650,
			42000651
		}
	},
	[42000613] = {
		Id = 42000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[42000614] = {
		RandomWeight = 30,
		Id = 42000614,
		SubstituteAction = 42000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			42000100,
			42000652,
			42000653
		}
	},
	[42000615] = {
		Id = 42000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			42000651
		}
	},
	[42000616] = {
		Id = 42000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			42000653
		}
	},
	[42000617] = {
		RandomWeight = 30,
		Id = 42000617,
		SubstituteAction = 42000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			42000650,
			42000651
		}
	},
	[42000618] = {
		RandomWeight = 30,
		Id = 42000618,
		SubstituteAction = 42000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			42000652,
			42000653
		}
	},
	[42000621] = {
		Id = 42000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[42000622] = {
		RandomWeight = 30,
		Id = 42000622,
		SubstituteAction = 42000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			42000635,
			42000624
		}
	},
	[42000623] = {
		Id = 42000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[42000624] = {
		RandomWeight = 30,
		Id = 42000624,
		SubstituteAction = 42000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			42000635,
			42000632
		}
	},
	[42000625] = {
		RandomWeight = 30,
		Id = 42000625,
		SubstituteAction = 42000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			42000661
		}
	},
	[42000626] = {
		RandomWeight = 30,
		Id = 42000626,
		SubstituteAction = 42000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			42000662
		}
	},
	[42000701] = {
		RandomWeight = 30,
		Id = 42000701,
		SubstituteAction = 42000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			42000603,
			42000604
		}
	},
	[42000702] = {
		RandomWeight = 10,
		Id = 42000702,
		SubstituteAction = 42000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			42000613,
			42000614
		}
	},
	[42000711] = {
		SubstituteAction = 42000513,
		RandomWeight = 10,
		Id = 42000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[42000712] = {
		RandomWeight = 10,
		Id = 42000712,
		SubstituteAction = 42000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			42000631,
			42000632
		}
	},
	[42000713] = {
		RandomWeight = 10,
		Id = 42000713,
		SubstituteAction = 42000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			42000635,
			42000624
		}
	},
	[42000714] = {
		RandomWeight = 10,
		Id = 42000714,
		SubstituteAction = 42000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			42000635,
			42000632
		}
	},
	[42000801] = {
		Id = 42000801,
		RandomWeight = 50,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			42000810,
			42000811,
			42000812,
			42000813
		}
	},
	[42000802] = {
		Id = 42000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			42000820,
			42000821,
			42000822,
			42000823
		}
	},
	[42000803] = {
		Id = 42000803,
		RandomWeight = 50,
		ActionUnitIDList = {
			42000830,
			42000831,
			42000832,
			42000833
		}
	},
	[42000804] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 42000804,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			42000840,
			42000841,
			42000842,
			42000843
		}
	},
	[42000805] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 42000805,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			42000850,
			42000851,
			42000852,
			42000853
		}
	},
	[42005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 42005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[42005002] = {
		Id = 42005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			42000100,
			42000110,
			42000111,
			42000112,
			42000113,
			42000120
		}
	},
	[43000001] = {
		Id = 43000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[43000002] = {
		Id = 43000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[43000003] = {
		Id = 43000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[43000004] = {
		Id = 43000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			43000010
		}
	},
	[43000005] = {
		Id = 43000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			43000020
		}
	},
	[43000011] = {
		RandomWeight = 10,
		Id = 43000011,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000110,
			43000100,
			43000110,
			43000120
		}
	},
	[43000012] = {
		RandomWeight = 10,
		Id = 43000012,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000130
		}
	},
	[43000013] = {
		RandomWeight = 10,
		Id = 43000013,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000110,
			43000100,
			43000110,
			43000131,
			43000100
		}
	},
	[43000021] = {
		RandomWeight = 20,
		Id = 43000021,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000111,
			43000100,
			43000111,
			43000120
		}
	},
	[43000022] = {
		RandomWeight = 20,
		Id = 43000022,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000112,
			43000100,
			43000112,
			43000120
		}
	},
	[43000023] = {
		RandomWeight = 20,
		Id = 43000023,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000113,
			43000100,
			43000113,
			43000120
		}
	},
	[43000024] = {
		RandomWeight = 20,
		Id = 43000024,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000140
		}
	},
	[43000025] = {
		RandomWeight = 20,
		Id = 43000025,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			43000110,
			43000100,
			43000110,
			43000141,
			43000100
		}
	},
	[43000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 43000026,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			43000150
		}
	},
	[43000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000031,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101,
			834
		},
		ActionUnitIDList = {
			43000151
		}
	},
	[43000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000041,
		SubstituteAction = 43000004,
		ConditionIDList = {
			101,
			838
		},
		ActionUnitIDList = {
			43000152
		}
	},
	[43000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 43000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			43000210
		}
	},
	[43000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 43000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			43000211
		}
	},
	[43000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 43000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			43000210
		}
	},
	[43000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 43000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			43000211
		}
	},
	[43000121] = {
		Id = 43000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[43000122] = {
		Id = 43000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[43000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 43000201,
		SubstituteAction = 43000005,
		ActionUnitIDList = {
			43000300,
			43000310
		}
	},
	[43000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 43000202,
		SubstituteAction = 43000005,
		ActionUnitIDList = {
			43000300,
			43000311
		}
	},
	[43000211] = {
		Id = 43000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[43000212] = {
		RandomWeight = 10,
		Id = 43000212,
		SubstituteAction = 43000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000320
		}
	},
	[43000213] = {
		Id = 43000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[43000214] = {
		RandomWeight = 60,
		Id = 43000214,
		SubstituteAction = 43000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000321
		}
	},
	[43000221] = {
		RandomWeight = 10,
		Id = 43000221,
		SubstituteAction = 43000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			43000310
		}
	},
	[43000222] = {
		RandomWeight = 20,
		Id = 43000222,
		SubstituteAction = 43000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			43000311
		}
	},
	[43000231] = {
		isDailyAction = true,
		Id = 43000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			43000330
		}
	},
	[43000232] = {
		isDailyAction = true,
		Id = 43000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			43000331
		}
	},
	[43000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 43000301,
		SubstituteAction = 43000005,
		ActionUnitIDList = {
			43000400,
			43000410
		}
	},
	[43000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 43000302,
		SubstituteAction = 43000005,
		ActionUnitIDList = {
			43000400,
			43000411
		}
	},
	[43000311] = {
		Id = 43000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[43000312] = {
		RandomWeight = 10,
		Id = 43000312,
		SubstituteAction = 43000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000420
		}
	},
	[43000313] = {
		Id = 43000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[43000314] = {
		RandomWeight = 60,
		Id = 43000314,
		SubstituteAction = 43000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000421
		}
	},
	[43000321] = {
		RandomWeight = 10,
		Id = 43000321,
		SubstituteAction = 43000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			43000410
		}
	},
	[43000322] = {
		RandomWeight = 20,
		Id = 43000322,
		SubstituteAction = 43000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			43000411
		}
	},
	[43000331] = {
		isDailyAction = true,
		Id = 43000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			43000430
		}
	},
	[43000332] = {
		isDailyAction = true,
		Id = 43000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			43000431
		}
	},
	[43000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 43000401,
		SubstituteAction = 43000005,
		ActionUnitIDList = {
			43000500,
			43000510
		}
	},
	[43000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 43000402,
		SubstituteAction = 43000005,
		ActionUnitIDList = {
			43000500,
			43000511
		}
	},
	[43000411] = {
		Id = 43000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[43000412] = {
		RandomWeight = 10,
		Id = 43000412,
		SubstituteAction = 43000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000520
		}
	},
	[43000413] = {
		Id = 43000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[43000414] = {
		RandomWeight = 60,
		Id = 43000414,
		SubstituteAction = 43000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000521
		}
	},
	[43000421] = {
		RandomWeight = 10,
		Id = 43000421,
		SubstituteAction = 43000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			43000510
		}
	},
	[43000422] = {
		RandomWeight = 20,
		Id = 43000422,
		SubstituteAction = 43000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			43000511
		}
	},
	[43000431] = {
		isDailyAction = true,
		Id = 43000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			43000530
		}
	},
	[43000432] = {
		isDailyAction = true,
		Id = 43000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			43000531
		}
	},
	[43000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000501,
		SubstituteAction = 43000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000600,
			43000601,
			43000602,
			43000603,
			43000604
		}
	},
	[43000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000502,
		SubstituteAction = 43000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000610,
			43000611,
			43000612,
			43000613,
			43000614
		}
	},
	[43000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000605,
			43000606
		}
	},
	[43000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000615,
			43000616
		}
	},
	[43000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000511,
		SubstituteAction = 43000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			43000620,
			43000621,
			43000622
		}
	},
	[43000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000512,
		SubstituteAction = 43000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			43000630,
			43000631,
			43000632
		}
	},
	[43000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			43000623,
			43000624
		}
	},
	[43000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			43000633,
			43000634
		}
	},
	[43000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000521,
		SubstituteAction = 43000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			43000620,
			43000625,
			43000624
		}
	},
	[43000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 43000522,
		SubstituteAction = 43000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			43000630,
			43000635,
			43000634
		}
	},
	[43000601] = {
		Id = 43000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[43000602] = {
		RandomWeight = 10,
		Id = 43000602,
		SubstituteAction = 43000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000100,
			43000640
		}
	},
	[43000603] = {
		Id = 43000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[43000604] = {
		RandomWeight = 30,
		Id = 43000604,
		SubstituteAction = 43000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000100,
			43000642
		}
	},
	[43000605] = {
		Id = 43000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000641
		}
	},
	[43000606] = {
		Id = 43000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000643
		}
	},
	[43000607] = {
		RandomWeight = 10,
		Id = 43000607,
		SubstituteAction = 43000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000640
		}
	},
	[43000608] = {
		RandomWeight = 30,
		Id = 43000608,
		SubstituteAction = 43000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			43000642
		}
	},
	[43000611] = {
		Id = 43000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[43000612] = {
		RandomWeight = 30,
		Id = 43000612,
		SubstituteAction = 43000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			43000100,
			43000650,
			43000651
		}
	},
	[43000613] = {
		Id = 43000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[43000614] = {
		RandomWeight = 30,
		Id = 43000614,
		SubstituteAction = 43000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			43000100,
			43000652,
			43000653
		}
	},
	[43000615] = {
		Id = 43000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			43000651
		}
	},
	[43000616] = {
		Id = 43000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			43000653
		}
	},
	[43000617] = {
		RandomWeight = 30,
		Id = 43000617,
		SubstituteAction = 43000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			43000650,
			43000651
		}
	},
	[43000618] = {
		RandomWeight = 30,
		Id = 43000618,
		SubstituteAction = 43000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			43000652,
			43000653
		}
	},
	[43000621] = {
		Id = 43000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[43000622] = {
		RandomWeight = 30,
		Id = 43000622,
		SubstituteAction = 43000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			43000635,
			43000624
		}
	},
	[43000623] = {
		Id = 43000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[43000624] = {
		RandomWeight = 30,
		Id = 43000624,
		SubstituteAction = 43000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			43000635,
			43000632
		}
	},
	[43000625] = {
		RandomWeight = 30,
		Id = 43000625,
		SubstituteAction = 43000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			43000661
		}
	},
	[43000626] = {
		RandomWeight = 30,
		Id = 43000626,
		SubstituteAction = 43000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			43000662
		}
	},
	[43000701] = {
		RandomWeight = 30,
		Id = 43000701,
		SubstituteAction = 43000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			43000603,
			43000604
		}
	},
	[43000702] = {
		RandomWeight = 10,
		Id = 43000702,
		SubstituteAction = 43000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			43000613,
			43000614
		}
	},
	[43000711] = {
		SubstituteAction = 43000513,
		RandomWeight = 10,
		Id = 43000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[43000712] = {
		RandomWeight = 10,
		Id = 43000712,
		SubstituteAction = 43000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			43000631,
			43000632
		}
	},
	[43000713] = {
		RandomWeight = 10,
		Id = 43000713,
		SubstituteAction = 43000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			43000635,
			43000624
		}
	},
	[43000714] = {
		RandomWeight = 10,
		Id = 43000714,
		SubstituteAction = 43000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			43000635,
			43000632
		}
	},
	[43000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			43000810,
			43000811,
			43000812,
			43000813
		}
	},
	[43000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000802,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000820,
			43000821,
			43000822,
			43000823
		}
	},
	[43000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000803,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			43000830,
			43000831,
			43000832,
			43000833
		}
	},
	[43000901] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000901,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			43000840,
			43000841,
			43000842,
			43000843
		}
	},
	[43000902] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 43000902,
		ConditionIDList = {
			202
		},
		ActionUnitIDList = {
			43000840,
			43000841,
			43000842,
			43000843
		}
	},
	[43005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 43005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[43005002] = {
		Id = 43005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			43000100,
			43000110,
			43000111,
			43000112,
			43000113,
			43000120
		}
	},
	[44000001] = {
		Id = 44000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[44000002] = {
		Id = 44000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[44000003] = {
		Id = 44000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[44000004] = {
		Id = 44000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			44000010
		}
	},
	[44000005] = {
		Id = 44000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			44000020
		}
	},
	[44000011] = {
		RandomWeight = 10,
		Id = 44000011,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000110,
			44000100,
			44000110,
			44000120
		}
	},
	[44000012] = {
		RandomWeight = 10,
		Id = 44000012,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000130
		}
	},
	[44000013] = {
		RandomWeight = 10,
		Id = 44000013,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000110,
			44000100,
			44000110,
			44000131,
			44000100
		}
	},
	[44000021] = {
		RandomWeight = 20,
		Id = 44000021,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000111,
			44000100,
			44000111,
			44000120
		}
	},
	[44000022] = {
		RandomWeight = 20,
		Id = 44000022,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000112,
			44000100,
			44000112,
			44000120
		}
	},
	[44000023] = {
		RandomWeight = 20,
		Id = 44000023,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000113,
			44000100,
			44000113,
			44000120
		}
	},
	[44000024] = {
		RandomWeight = 20,
		Id = 44000024,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000140
		}
	},
	[44000025] = {
		RandomWeight = 20,
		Id = 44000025,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			44000110,
			44000100,
			44000110,
			44000141,
			44000100
		}
	},
	[44000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 44000026,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			44000150
		}
	},
	[44000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 44000031,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101,
			832
		},
		ActionUnitIDList = {
			44000151
		}
	},
	[44000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 44000041,
		SubstituteAction = 44000004,
		ConditionIDList = {
			101,
			841
		},
		ActionUnitIDList = {
			44000152
		}
	},
	[44000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 44000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			44000210
		}
	},
	[44000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 44000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			44000211
		}
	},
	[44000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 44000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			44000210
		}
	},
	[44000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 44000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			44000211
		}
	},
	[44000121] = {
		Id = 44000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[44000122] = {
		Id = 44000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[44000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 44000201,
		SubstituteAction = 44000005,
		ActionUnitIDList = {
			44000300,
			44000310
		}
	},
	[44000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 44000202,
		SubstituteAction = 44000005,
		ActionUnitIDList = {
			44000300,
			44000311
		}
	},
	[44000211] = {
		Id = 44000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[44000212] = {
		RandomWeight = 10,
		Id = 44000212,
		SubstituteAction = 44000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			44000320
		}
	},
	[44000213] = {
		Id = 44000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[44000214] = {
		RandomWeight = 60,
		Id = 44000214,
		SubstituteAction = 44000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			44000321
		}
	},
	[44000221] = {
		RandomWeight = 10,
		Id = 44000221,
		SubstituteAction = 44000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			44000310
		}
	},
	[44000222] = {
		RandomWeight = 20,
		Id = 44000222,
		SubstituteAction = 44000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			44000311
		}
	},
	[44000231] = {
		isDailyAction = true,
		Id = 44000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			44000330
		}
	},
	[44000232] = {
		isDailyAction = true,
		Id = 44000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			44000331
		}
	},
	[44000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 44000301,
		SubstituteAction = 44000005,
		ActionUnitIDList = {
			44000400,
			44000410
		}
	},
	[44000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 44000302,
		SubstituteAction = 44000005,
		ActionUnitIDList = {
			44000400,
			44000411
		}
	},
	[44000311] = {
		Id = 44000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[44000312] = {
		RandomWeight = 10,
		Id = 44000312,
		SubstituteAction = 44000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			44000420
		}
	},
	[44000313] = {
		Id = 44000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[44000314] = {
		RandomWeight = 60,
		Id = 44000314,
		SubstituteAction = 44000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			44000421
		}
	},
	[44000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000321,
		SubstituteAction = 44000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			44000410
		}
	},
	[44000322] = {
		RandomWeight = 20,
		Id = 44000322,
		SubstituteAction = 44000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			44000411
		}
	},
	[44000331] = {
		isDailyAction = true,
		Id = 44000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			44000430
		}
	},
	[44000332] = {
		isDailyAction = true,
		Id = 44000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			44000431
		}
	},
	[44000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 44000401,
		SubstituteAction = 44000005,
		ActionUnitIDList = {
			44000500,
			44000510
		}
	},
	[44000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 44000402,
		SubstituteAction = 44000005,
		ActionUnitIDList = {
			44000500,
			44000511
		}
	},
	[44000411] = {
		Id = 44000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[44000412] = {
		RandomWeight = 10,
		Id = 44000412,
		SubstituteAction = 44000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			44000520
		}
	},
	[44000413] = {
		Id = 44000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[44000414] = {
		RandomWeight = 60,
		Id = 44000414,
		SubstituteAction = 44000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			44000521
		}
	},
	[44000421] = {
		RandomWeight = 10,
		Id = 44000421,
		SubstituteAction = 44000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			44000510
		}
	},
	[44000422] = {
		RandomWeight = 20,
		Id = 44000422,
		SubstituteAction = 44000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			44000511
		}
	},
	[44000431] = {
		isDailyAction = true,
		Id = 44000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			44000530
		}
	},
	[44000432] = {
		isDailyAction = true,
		Id = 44000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			44000531
		}
	},
	[44000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000501,
		SubstituteAction = 44000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000600,
			44000601,
			44000602,
			44000603,
			44000604
		}
	},
	[44000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000502,
		SubstituteAction = 44000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000610,
			44000611,
			44000612,
			44000613,
			44000614
		}
	},
	[44000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000605,
			44000606
		}
	},
	[44000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000615,
			44000616
		}
	},
	[44000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000511,
		SubstituteAction = 44000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			44000620,
			44000621,
			44000622
		}
	},
	[44000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000512,
		SubstituteAction = 44000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			44000630,
			44000631,
			44000632
		}
	},
	[44000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			44000623,
			44000624
		}
	},
	[44000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			44000633,
			44000634
		}
	},
	[44000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000521,
		SubstituteAction = 44000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			44000620,
			44000625,
			44000624
		}
	},
	[44000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 44000522,
		SubstituteAction = 44000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			44000630,
			44000635,
			44000634
		}
	},
	[44000601] = {
		Id = 44000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[44000602] = {
		RandomWeight = 10,
		Id = 44000602,
		SubstituteAction = 44000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000100,
			44000640
		}
	},
	[44000603] = {
		Id = 44000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[44000604] = {
		RandomWeight = 30,
		Id = 44000604,
		SubstituteAction = 44000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000100,
			44000642
		}
	},
	[44000605] = {
		Id = 44000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000641
		}
	},
	[44000606] = {
		Id = 44000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000643
		}
	},
	[44000607] = {
		RandomWeight = 10,
		Id = 44000607,
		SubstituteAction = 44000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000640
		}
	},
	[44000608] = {
		RandomWeight = 30,
		Id = 44000608,
		SubstituteAction = 44000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			44000642
		}
	},
	[44000611] = {
		Id = 44000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[44000612] = {
		RandomWeight = 30,
		Id = 44000612,
		SubstituteAction = 44000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			44000100,
			44000650,
			44000651
		}
	},
	[44000613] = {
		Id = 44000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[44000614] = {
		RandomWeight = 30,
		Id = 44000614,
		SubstituteAction = 44000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			44000100,
			44000652,
			44000653
		}
	},
	[44000615] = {
		Id = 44000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			44000651
		}
	},
	[44000616] = {
		Id = 44000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			44000653
		}
	},
	[44000617] = {
		RandomWeight = 30,
		Id = 44000617,
		SubstituteAction = 44000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			44000650,
			44000651
		}
	},
	[44000618] = {
		RandomWeight = 30,
		Id = 44000618,
		SubstituteAction = 44000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			44000652,
			44000653
		}
	},
	[44000621] = {
		Id = 44000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[44000622] = {
		RandomWeight = 30,
		Id = 44000622,
		SubstituteAction = 44000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			44000635,
			44000624
		}
	},
	[44000623] = {
		Id = 44000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[44000624] = {
		RandomWeight = 30,
		Id = 44000624,
		SubstituteAction = 44000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			44000635,
			44000632
		}
	},
	[44000625] = {
		RandomWeight = 30,
		Id = 44000625,
		SubstituteAction = 44000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			44000661
		}
	},
	[44000626] = {
		RandomWeight = 30,
		Id = 44000626,
		SubstituteAction = 44000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			44000662
		}
	},
	[44000701] = {
		RandomWeight = 30,
		Id = 44000701,
		SubstituteAction = 44000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			44000603,
			44000604
		}
	},
	[44000702] = {
		RandomWeight = 10,
		Id = 44000702,
		SubstituteAction = 44000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			44000613,
			44000614
		}
	},
	[44000711] = {
		SubstituteAction = 44000513,
		RandomWeight = 10,
		Id = 44000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[44000712] = {
		RandomWeight = 10,
		Id = 44000712,
		SubstituteAction = 44000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			44000631,
			44000632
		}
	},
	[44000713] = {
		RandomWeight = 10,
		Id = 44000713,
		SubstituteAction = 44000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			44000635,
			44000624
		}
	},
	[44000714] = {
		RandomWeight = 10,
		Id = 44000714,
		SubstituteAction = 44000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			44000635,
			44000632
		}
	},
	[44000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 44000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			44000810,
			44000811,
			44000812,
			44000813
		}
	},
	[44000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 44000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			44000820,
			44000821,
			44000822,
			44000823
		}
	},
	[44000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 44000803,
		ConditionIDList = {
			202
		},
		ActionUnitIDList = {
			44000830,
			44000831,
			44000832,
			44000833
		}
	},
	[44005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 44005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[44005002] = {
		Id = 44005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			44000100,
			44000110,
			44000111,
			44000112,
			44000113,
			44000120
		}
	},
	[45000001] = {
		Id = 45000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[45000002] = {
		Id = 45000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[45000003] = {
		Id = 45000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[45000004] = {
		Id = 45000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[45000005] = {
		Id = 45000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[45000011] = {
		RandomWeight = 10,
		Id = 45000011,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000110,
			45000100,
			45000110,
			45000120
		}
	},
	[45000012] = {
		RandomWeight = 10,
		Id = 45000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[45000013] = {
		RandomWeight = 10,
		Id = 45000013,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000110,
			45000100,
			45000110,
			45000131,
			45000100
		}
	},
	[45000021] = {
		RandomWeight = 20,
		Id = 45000021,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000111,
			45000100,
			45000111,
			45000120
		}
	},
	[45000022] = {
		RandomWeight = 20,
		Id = 45000022,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000112,
			45000100,
			45000112,
			45000120
		}
	},
	[45000023] = {
		RandomWeight = 20,
		Id = 45000023,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000113,
			45000100,
			45000113,
			45000120
		}
	},
	[45000024] = {
		RandomWeight = 20,
		Id = 45000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[45000025] = {
		RandomWeight = 20,
		Id = 45000025,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000110,
			45000100,
			45000110,
			45000141,
			45000100
		}
	},
	[45000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 45000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[45000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 45000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[45000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 45000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[45000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 45000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[45000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 45000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[45000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 45000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[45000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 45000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[45000121] = {
		Id = 45000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[45000122] = {
		Id = 45000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[45000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 45000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[45000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 45000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[45000211] = {
		Id = 45000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[45000212] = {
		RandomWeight = 10,
		Id = 45000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[45000213] = {
		Id = 45000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[45000214] = {
		RandomWeight = 60,
		Id = 45000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[45000221] = {
		RandomWeight = 10,
		Id = 45000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[45000222] = {
		RandomWeight = 20,
		Id = 45000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[45000231] = {
		isDailyAction = true,
		Id = 45000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[45000232] = {
		isDailyAction = true,
		Id = 45000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[45000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 45000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[45000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 45000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[45000311] = {
		Id = 45000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[45000312] = {
		RandomWeight = 10,
		Id = 45000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[45000313] = {
		Id = 45000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[45000314] = {
		RandomWeight = 60,
		Id = 45000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[45000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[45000322] = {
		RandomWeight = 20,
		Id = 45000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[45000331] = {
		isDailyAction = true,
		Id = 45000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[45000332] = {
		isDailyAction = true,
		Id = 45000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[45000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 45000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[45000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 45000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[45000411] = {
		Id = 45000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[45000412] = {
		RandomWeight = 10,
		Id = 45000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[45000413] = {
		Id = 45000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[45000414] = {
		RandomWeight = 60,
		Id = 45000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[45000421] = {
		RandomWeight = 10,
		Id = 45000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[45000422] = {
		RandomWeight = 20,
		Id = 45000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[45000431] = {
		isDailyAction = true,
		Id = 45000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[45000432] = {
		isDailyAction = true,
		Id = 45000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[45000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000501,
		SubstituteAction = 45000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000600,
			45000601,
			45000602,
			45000603,
			45000604
		}
	},
	[45000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000502,
		SubstituteAction = 45000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000610,
			45000611,
			45000612,
			45000613,
			45000614
		}
	},
	[45000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[45000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[45000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000511,
		SubstituteAction = 45000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			45000620,
			45000621,
			45000622
		}
	},
	[45000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000512,
		SubstituteAction = 45000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			45000630,
			45000631,
			45000632
		}
	},
	[45000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[45000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[45000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000521,
		SubstituteAction = 45000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			45000620,
			45000625,
			45000624
		}
	},
	[45000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 45000522,
		SubstituteAction = 45000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			45000630,
			45000635,
			45000634
		}
	},
	[45000601] = {
		Id = 45000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[45000602] = {
		RandomWeight = 10,
		Id = 45000602,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000100,
			45000640
		}
	},
	[45000603] = {
		Id = 45000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[45000604] = {
		RandomWeight = 30,
		Id = 45000604,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000100,
			45000642
		}
	},
	[45000605] = {
		Id = 45000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[45000606] = {
		Id = 45000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[45000607] = {
		RandomWeight = 10,
		Id = 45000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[45000608] = {
		RandomWeight = 30,
		Id = 45000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[45000611] = {
		Id = 45000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[45000612] = {
		RandomWeight = 30,
		Id = 45000612,
		SubstituteAction = 45000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			45000100,
			45000650,
			45000651
		}
	},
	[45000613] = {
		Id = 45000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[45000614] = {
		RandomWeight = 30,
		Id = 45000614,
		SubstituteAction = 45000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			45000100,
			45000652,
			45000653
		}
	},
	[45000615] = {
		Id = 45000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[45000616] = {
		Id = 45000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[45000617] = {
		RandomWeight = 30,
		Id = 45000617,
		SubstituteAction = 45000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			45000650,
			45000651
		}
	},
	[45000618] = {
		RandomWeight = 30,
		Id = 45000618,
		SubstituteAction = 45000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			45000652,
			45000653
		}
	},
	[45000621] = {
		Id = 45000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[45000622] = {
		RandomWeight = 30,
		Id = 45000622,
		SubstituteAction = 45000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			45000635,
			45000624
		}
	},
	[45000623] = {
		Id = 45000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[45000624] = {
		RandomWeight = 30,
		Id = 45000624,
		SubstituteAction = 45000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			45000635,
			45000632
		}
	},
	[45000625] = {
		RandomWeight = 30,
		Id = 45000625,
		SubstituteAction = 45000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			45000661
		}
	},
	[45000626] = {
		RandomWeight = 30,
		Id = 45000626,
		SubstituteAction = 45000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			45000662
		}
	},
	[45000701] = {
		RandomWeight = 30,
		Id = 45000701,
		SubstituteAction = 45000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000603,
			45000604
		}
	},
	[45000702] = {
		RandomWeight = 10,
		Id = 45000702,
		SubstituteAction = 45000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000613,
			45000614
		}
	},
	[45000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 45000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[45000712] = {
		RandomWeight = 10,
		Id = 45000712,
		SubstituteAction = 45000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			45000631,
			45000632
		}
	},
	[45000713] = {
		RandomWeight = 10,
		Id = 45000713,
		SubstituteAction = 45000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			45000635,
			45000624
		}
	},
	[45000714] = {
		RandomWeight = 10,
		Id = 45000714,
		SubstituteAction = 45000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			45000635,
			45000632
		}
	},
	[45000801] = {
		isDailyAction = true,
		Id = 45000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[45000802] = {
		isDailyAction = true,
		Id = 45000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[45000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 45000803,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000830,
			45000831,
			45000832,
			45000833
		}
	},
	[45000804] = {
		isDailyAction = true,
		Id = 45000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			45000835,
			45000836
		}
	},
	[45000805] = {
		isDailyAction = true,
		Id = 45000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			45000837,
			45000838
		}
	},
	[45000806] = {
		isDailyAction = true,
		Id = 45000806,
		RandomWeight = 50,
		ActionUnitIDList = {
			45000839,
			45000840
		}
	},
	[45005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 45005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[45005002] = {
		Id = 45005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			45000100,
			45000110,
			45000111,
			45000112,
			45000113,
			45000120
		}
	},
	[46000001] = {
		Id = 46000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[46000002] = {
		Id = 46000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[46000003] = {
		Id = 46000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[46000004] = {
		Id = 46000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			46000010
		}
	},
	[46000005] = {
		Id = 46000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			46000020
		}
	},
	[46000011] = {
		RandomWeight = 10,
		Id = 46000011,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000110,
			46000100,
			46000110,
			46000120
		}
	},
	[46000012] = {
		RandomWeight = 10,
		Id = 46000012,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000130
		}
	},
	[46000013] = {
		RandomWeight = 10,
		Id = 46000013,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000110,
			46000100,
			46000110,
			46000131,
			46000100
		}
	},
	[46000021] = {
		RandomWeight = 20,
		Id = 46000021,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000111,
			46000100,
			46000111,
			46000120
		}
	},
	[46000022] = {
		RandomWeight = 20,
		Id = 46000022,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000112,
			46000100,
			46000112,
			46000120
		}
	},
	[46000023] = {
		RandomWeight = 20,
		Id = 46000023,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000113,
			46000100,
			46000113,
			46000120
		}
	},
	[46000024] = {
		RandomWeight = 20,
		Id = 46000024,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000140
		}
	},
	[46000025] = {
		RandomWeight = 20,
		Id = 46000025,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			46000110,
			46000100,
			46000110,
			46000141,
			46000100
		}
	},
	[46000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 46000026,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			46000150
		}
	},
	[46000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 46000031,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			46000151
		}
	},
	[46000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 46000041,
		SubstituteAction = 46000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			46000152
		}
	},
	[46000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 46000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			46000210
		}
	},
	[46000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 46000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			46000211
		}
	},
	[46000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 46000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			46000210
		}
	},
	[46000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 46000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			46000211
		}
	},
	[46000121] = {
		Id = 46000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[46000122] = {
		Id = 46000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[46000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 46000201,
		SubstituteAction = 46000005,
		ActionUnitIDList = {
			46000300,
			46000310
		}
	},
	[46000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 46000202,
		SubstituteAction = 46000005,
		ActionUnitIDList = {
			46000300,
			46000311
		}
	},
	[46000211] = {
		Id = 46000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[46000212] = {
		RandomWeight = 10,
		Id = 46000212,
		SubstituteAction = 46000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			46000320
		}
	},
	[46000213] = {
		Id = 46000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[46000214] = {
		RandomWeight = 60,
		Id = 46000214,
		SubstituteAction = 46000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			46000321
		}
	},
	[46000221] = {
		RandomWeight = 10,
		Id = 46000221,
		SubstituteAction = 46000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			46000310
		}
	},
	[46000222] = {
		RandomWeight = 20,
		Id = 46000222,
		SubstituteAction = 46000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			46000311
		}
	},
	[46000231] = {
		isDailyAction = true,
		Id = 46000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			46000330
		}
	},
	[46000232] = {
		isDailyAction = true,
		Id = 46000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			46000331
		}
	},
	[46000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 46000301,
		SubstituteAction = 46000005,
		ActionUnitIDList = {
			46000400,
			46000410
		}
	},
	[46000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 46000302,
		SubstituteAction = 46000005,
		ActionUnitIDList = {
			46000400,
			46000411
		}
	},
	[46000311] = {
		Id = 46000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[46000312] = {
		RandomWeight = 10,
		Id = 46000312,
		SubstituteAction = 46000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			46000420
		}
	},
	[46000313] = {
		Id = 46000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[46000314] = {
		RandomWeight = 60,
		Id = 46000314,
		SubstituteAction = 46000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			46000421
		}
	},
	[46000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000321,
		SubstituteAction = 46000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			46000410
		}
	},
	[46000322] = {
		RandomWeight = 20,
		Id = 46000322,
		SubstituteAction = 46000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			46000411
		}
	},
	[46000331] = {
		isDailyAction = true,
		Id = 46000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			46000430
		}
	},
	[46000332] = {
		isDailyAction = true,
		Id = 46000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			46000431
		}
	},
	[46000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 46000401,
		SubstituteAction = 46000005,
		ActionUnitIDList = {
			46000500,
			46000510
		}
	},
	[46000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 46000402,
		SubstituteAction = 46000005,
		ActionUnitIDList = {
			46000500,
			46000511
		}
	},
	[46000411] = {
		Id = 46000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[46000412] = {
		RandomWeight = 10,
		Id = 46000412,
		SubstituteAction = 46000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			46000520
		}
	},
	[46000413] = {
		Id = 46000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[46000414] = {
		RandomWeight = 60,
		Id = 46000414,
		SubstituteAction = 46000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			46000521
		}
	},
	[46000421] = {
		RandomWeight = 10,
		Id = 46000421,
		SubstituteAction = 46000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			46000510
		}
	},
	[46000422] = {
		RandomWeight = 20,
		Id = 46000422,
		SubstituteAction = 46000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			46000511
		}
	},
	[46000431] = {
		isDailyAction = true,
		Id = 46000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			46000530
		}
	},
	[46000432] = {
		isDailyAction = true,
		Id = 46000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			46000531
		}
	},
	[46000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000501,
		SubstituteAction = 46000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000600,
			46000601,
			46000602,
			46000603,
			46000830,
			46000604
		}
	},
	[46000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000502,
		SubstituteAction = 46000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000610,
			46000611,
			46000612,
			46000613,
			46000830,
			46000614
		}
	},
	[46000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000605,
			46000606
		}
	},
	[46000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000615,
			46000616
		}
	},
	[46000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000511,
		SubstituteAction = 46000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			46000620,
			46000621,
			46000622
		}
	},
	[46000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000512,
		SubstituteAction = 46000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			46000630,
			46000631,
			46000632
		}
	},
	[46000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			46000623,
			46000624
		}
	},
	[46000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			46000633,
			46000634
		}
	},
	[46000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000521,
		SubstituteAction = 46000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			46000620,
			46000625,
			46000830,
			46000624
		}
	},
	[46000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 46000522,
		SubstituteAction = 46000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			46000630,
			46000635,
			46000830,
			46000634
		}
	},
	[46000601] = {
		Id = 46000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[46000602] = {
		RandomWeight = 10,
		Id = 46000602,
		SubstituteAction = 46000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000100,
			46000640
		}
	},
	[46000603] = {
		Id = 46000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[46000604] = {
		RandomWeight = 30,
		Id = 46000604,
		SubstituteAction = 46000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000100,
			46000642
		}
	},
	[46000605] = {
		Id = 46000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000641
		}
	},
	[46000606] = {
		Id = 46000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000643
		}
	},
	[46000607] = {
		RandomWeight = 10,
		Id = 46000607,
		SubstituteAction = 46000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000640
		}
	},
	[46000608] = {
		RandomWeight = 30,
		Id = 46000608,
		SubstituteAction = 46000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			46000642
		}
	},
	[46000611] = {
		Id = 46000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[46000612] = {
		RandomWeight = 30,
		Id = 46000612,
		SubstituteAction = 46000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			46000100,
			46000650,
			46000651
		}
	},
	[46000613] = {
		Id = 46000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[46000614] = {
		RandomWeight = 30,
		Id = 46000614,
		SubstituteAction = 46000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			46000100,
			46000652,
			46000653
		}
	},
	[46000615] = {
		Id = 46000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			46000651
		}
	},
	[46000616] = {
		Id = 46000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			46000653
		}
	},
	[46000617] = {
		RandomWeight = 30,
		Id = 46000617,
		SubstituteAction = 46000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			46000650,
			46000651
		}
	},
	[46000618] = {
		RandomWeight = 30,
		Id = 46000618,
		SubstituteAction = 46000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			46000652,
			46000653
		}
	},
	[46000621] = {
		Id = 46000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[46000622] = {
		RandomWeight = 30,
		Id = 46000622,
		SubstituteAction = 46000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			46000635,
			46000624
		}
	},
	[46000623] = {
		Id = 46000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[46000624] = {
		RandomWeight = 30,
		Id = 46000624,
		SubstituteAction = 46000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			46000635,
			46000632
		}
	},
	[46000625] = {
		RandomWeight = 30,
		Id = 46000625,
		SubstituteAction = 46000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			46000661
		}
	},
	[46000626] = {
		RandomWeight = 30,
		Id = 46000626,
		SubstituteAction = 46000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			46000662
		}
	},
	[46000701] = {
		RandomWeight = 30,
		Id = 46000701,
		SubstituteAction = 46000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			46000603,
			46000604
		}
	},
	[46000702] = {
		RandomWeight = 10,
		Id = 46000702,
		SubstituteAction = 46000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			46000613,
			46000614
		}
	},
	[46000711] = {
		SubstituteAction = 46000513,
		RandomWeight = 10,
		Id = 46000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[46000712] = {
		RandomWeight = 10,
		Id = 46000712,
		SubstituteAction = 46000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			46000631,
			46000632
		}
	},
	[46000713] = {
		RandomWeight = 10,
		Id = 46000713,
		SubstituteAction = 46000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			46000635,
			46000624
		}
	},
	[46000714] = {
		RandomWeight = 10,
		Id = 46000714,
		SubstituteAction = 46000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			46000635,
			46000632
		}
	},
	[46000801] = {
		isDailyAction = true,
		Id = 46000801,
		RandomWeight = 50,
		ActionUnitIDList = {
			46000810,
			46000811,
			46000812,
			46000813
		}
	},
	[46000802] = {
		isDailyAction = true,
		Id = 46000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			46000820,
			46000821,
			46000822,
			46000823
		}
	},
	[46005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 46005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[46005002] = {
		Id = 46005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			46000100,
			46000110,
			46000111,
			46000112,
			46000113,
			46000120
		}
	},
	[47000001] = {
		Id = 47000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[47000002] = {
		Id = 47000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[47000003] = {
		Id = 47000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[47000004] = {
		Id = 47000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			47000010
		}
	},
	[47000005] = {
		Id = 47000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			47000020
		}
	},
	[47000011] = {
		RandomWeight = 10,
		Id = 47000011,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000110,
			47000100,
			47000110,
			47000120
		}
	},
	[47000012] = {
		RandomWeight = 10,
		Id = 47000012,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000130
		}
	},
	[47000013] = {
		RandomWeight = 10,
		Id = 47000013,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000110,
			47000100,
			47000110,
			47000131,
			47000100
		}
	},
	[47000021] = {
		RandomWeight = 20,
		Id = 47000021,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000111,
			47000100,
			47000111,
			47000120
		}
	},
	[47000022] = {
		RandomWeight = 20,
		Id = 47000022,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000112,
			47000100,
			47000112,
			47000120
		}
	},
	[47000023] = {
		RandomWeight = 20,
		Id = 47000023,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000113,
			47000100,
			47000113,
			47000120
		}
	},
	[47000024] = {
		RandomWeight = 20,
		Id = 47000024,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000140
		}
	},
	[47000025] = {
		RandomWeight = 20,
		Id = 47000025,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			47000110,
			47000100,
			47000110,
			47000141,
			47000100
		}
	},
	[47000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 47000026,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			47000150
		}
	},
	[47000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 47000031,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101,
			839
		},
		ActionUnitIDList = {
			47000151
		}
	},
	[47000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 47000041,
		SubstituteAction = 47000004,
		ConditionIDList = {
			101,
			827
		},
		ActionUnitIDList = {
			47000152
		}
	},
	[47000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 47000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			47000210
		}
	},
	[47000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 47000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			47000211
		}
	},
	[47000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 47000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			47000210
		}
	},
	[47000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 47000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			47000211
		}
	},
	[47000121] = {
		Id = 47000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[47000122] = {
		Id = 47000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[47000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 47000201,
		SubstituteAction = 47000005,
		ActionUnitIDList = {
			47000300,
			47000310
		}
	},
	[47000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 47000202,
		SubstituteAction = 47000005,
		ActionUnitIDList = {
			47000300,
			47000311
		}
	},
	[47000211] = {
		Id = 47000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[47000212] = {
		RandomWeight = 10,
		Id = 47000212,
		SubstituteAction = 47000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			47000320
		}
	},
	[47000213] = {
		Id = 47000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[47000214] = {
		RandomWeight = 60,
		Id = 47000214,
		SubstituteAction = 47000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			47000321
		}
	},
	[47000221] = {
		RandomWeight = 10,
		Id = 47000221,
		SubstituteAction = 47000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			47000310
		}
	},
	[47000222] = {
		RandomWeight = 20,
		Id = 47000222,
		SubstituteAction = 47000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			47000311
		}
	},
	[47000231] = {
		isDailyAction = true,
		Id = 47000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			47000330
		}
	},
	[47000232] = {
		isDailyAction = true,
		Id = 47000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			47000331
		}
	},
	[47000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 47000301,
		SubstituteAction = 47000005,
		ActionUnitIDList = {
			47000400,
			47000410
		}
	},
	[47000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 47000302,
		SubstituteAction = 47000005,
		ActionUnitIDList = {
			47000400,
			47000411
		}
	},
	[47000311] = {
		Id = 47000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[47000312] = {
		RandomWeight = 10,
		Id = 47000312,
		SubstituteAction = 47000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			47000420
		}
	},
	[47000313] = {
		Id = 47000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[47000314] = {
		RandomWeight = 60,
		Id = 47000314,
		SubstituteAction = 47000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			47000421
		}
	},
	[47000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000321,
		SubstituteAction = 47000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			47000410
		}
	},
	[47000322] = {
		RandomWeight = 20,
		Id = 47000322,
		SubstituteAction = 47000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			47000411
		}
	},
	[47000331] = {
		isDailyAction = true,
		Id = 47000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			47000430
		}
	},
	[47000332] = {
		isDailyAction = true,
		Id = 47000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			47000431
		}
	},
	[47000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 47000401,
		SubstituteAction = 47000005,
		ActionUnitIDList = {
			47000500,
			47000510
		}
	},
	[47000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 47000402,
		SubstituteAction = 47000005,
		ActionUnitIDList = {
			47000500,
			47000511
		}
	},
	[47000411] = {
		Id = 47000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[47000412] = {
		RandomWeight = 10,
		Id = 47000412,
		SubstituteAction = 47000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			47000520
		}
	},
	[47000413] = {
		Id = 47000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[47000414] = {
		RandomWeight = 60,
		Id = 47000414,
		SubstituteAction = 47000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			47000521
		}
	},
	[47000421] = {
		RandomWeight = 10,
		Id = 47000421,
		SubstituteAction = 47000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			47000510
		}
	},
	[47000422] = {
		RandomWeight = 20,
		Id = 47000422,
		SubstituteAction = 47000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			47000511
		}
	},
	[47000431] = {
		isDailyAction = true,
		Id = 47000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			47000530
		}
	},
	[47000432] = {
		isDailyAction = true,
		Id = 47000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			47000531
		}
	},
	[47000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000501,
		SubstituteAction = 47000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000600,
			47000601,
			47000602,
			47000603,
			47000604
		}
	},
	[47000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000502,
		SubstituteAction = 47000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000610,
			47000611,
			47000612,
			47000613,
			47000614
		}
	},
	[47000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000605,
			47000606
		}
	},
	[47000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000615,
			47000616
		}
	},
	[47000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000511,
		SubstituteAction = 47000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			47000620,
			47000621,
			47000622
		}
	},
	[47000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000512,
		SubstituteAction = 47000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			47000630,
			47000631,
			47000632
		}
	},
	[47000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			47000623,
			47000624
		}
	},
	[47000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			47000633,
			47000634
		}
	},
	[47000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000521,
		SubstituteAction = 47000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			47000620,
			47000625,
			47000624
		}
	},
	[47000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 47000522,
		SubstituteAction = 47000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			47000630,
			47000635,
			47000634
		}
	},
	[47000601] = {
		Id = 47000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[47000602] = {
		RandomWeight = 10,
		Id = 47000602,
		SubstituteAction = 47000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000100,
			47000640
		}
	},
	[47000603] = {
		Id = 47000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[47000604] = {
		RandomWeight = 30,
		Id = 47000604,
		SubstituteAction = 47000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000100,
			47000642
		}
	},
	[47000605] = {
		Id = 47000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000641
		}
	},
	[47000606] = {
		Id = 47000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000643
		}
	},
	[47000607] = {
		RandomWeight = 10,
		Id = 47000607,
		SubstituteAction = 47000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000640
		}
	},
	[47000608] = {
		RandomWeight = 30,
		Id = 47000608,
		SubstituteAction = 47000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			47000642
		}
	},
	[47000611] = {
		Id = 47000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[47000612] = {
		RandomWeight = 30,
		Id = 47000612,
		SubstituteAction = 47000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			47000100,
			47000650,
			47000651
		}
	},
	[47000613] = {
		Id = 47000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[47000614] = {
		RandomWeight = 30,
		Id = 47000614,
		SubstituteAction = 47000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			47000100,
			47000652,
			47000653
		}
	},
	[47000615] = {
		Id = 47000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			47000651
		}
	},
	[47000616] = {
		Id = 47000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			47000653
		}
	},
	[47000617] = {
		RandomWeight = 30,
		Id = 47000617,
		SubstituteAction = 47000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			47000650,
			47000651
		}
	},
	[47000618] = {
		RandomWeight = 30,
		Id = 47000618,
		SubstituteAction = 47000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			47000652,
			47000653
		}
	},
	[47000621] = {
		Id = 47000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[47000622] = {
		RandomWeight = 30,
		Id = 47000622,
		SubstituteAction = 47000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			47000635,
			47000624
		}
	},
	[47000623] = {
		Id = 47000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[47000624] = {
		RandomWeight = 30,
		Id = 47000624,
		SubstituteAction = 47000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			47000635,
			47000632
		}
	},
	[47000625] = {
		RandomWeight = 30,
		Id = 47000625,
		SubstituteAction = 47000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			47000661
		}
	},
	[47000626] = {
		RandomWeight = 30,
		Id = 47000626,
		SubstituteAction = 47000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			47000662
		}
	},
	[47000701] = {
		RandomWeight = 30,
		Id = 47000701,
		SubstituteAction = 47000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			47000603,
			47000604
		}
	},
	[47000702] = {
		RandomWeight = 10,
		Id = 47000702,
		SubstituteAction = 47000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			47000613,
			47000614
		}
	},
	[47000711] = {
		SubstituteAction = 47000513,
		RandomWeight = 10,
		Id = 47000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[47000712] = {
		RandomWeight = 10,
		Id = 47000712,
		SubstituteAction = 47000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			47000631,
			47000632
		}
	},
	[47000713] = {
		RandomWeight = 10,
		Id = 47000713,
		SubstituteAction = 47000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			47000635,
			47000624
		}
	},
	[47000714] = {
		RandomWeight = 10,
		Id = 47000714,
		SubstituteAction = 47000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			47000635,
			47000632
		}
	},
	[47000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 47000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			47000810,
			47000811,
			47000812,
			47000813
		}
	},
	[47000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 47000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			47000820,
			47000821,
			47000822
		}
	},
	[47000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 47000803,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			47000830,
			47000831,
			47000832
		}
	},
	[47000804] = {
		isDailyAction = true,
		Id = 47000804,
		RandomWeight = 50,
		ActionUnitIDList = {
			47000833,
			47000834
		}
	},
	[47000805] = {
		isDailyAction = true,
		Id = 47000805,
		RandomWeight = 50,
		ActionUnitIDList = {
			47000835,
			47000836
		}
	},
	[47000806] = {
		isDailyAction = true,
		Id = 47000806,
		RandomWeight = 50,
		ActionUnitIDList = {
			47000837,
			47000838
		}
	},
	[47005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 47005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[47005002] = {
		Id = 47005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			47000100,
			47000110,
			47000111,
			47000112,
			47000113,
			47000120
		}
	},
	[48000001] = {
		Id = 48000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[48000002] = {
		Id = 48000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[48000003] = {
		Id = 48000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[48000004] = {
		Id = 48000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			48000010
		}
	},
	[48000005] = {
		Id = 48000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			48000020
		}
	},
	[48000011] = {
		RandomWeight = 10,
		Id = 48000011,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000110,
			48000100,
			48000110,
			48000120
		}
	},
	[48000012] = {
		RandomWeight = 10,
		Id = 48000012,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000130
		}
	},
	[48000013] = {
		RandomWeight = 10,
		Id = 48000013,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000110,
			48000100,
			48000110,
			48000131,
			48000100
		}
	},
	[48000021] = {
		RandomWeight = 20,
		Id = 48000021,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000111,
			48000100,
			48000111,
			48000120
		}
	},
	[48000022] = {
		RandomWeight = 20,
		Id = 48000022,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000112,
			48000100,
			48000112,
			48000120
		}
	},
	[48000023] = {
		RandomWeight = 20,
		Id = 48000023,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000113,
			48000100,
			48000113,
			48000120
		}
	},
	[48000024] = {
		RandomWeight = 20,
		Id = 48000024,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000140
		}
	},
	[48000025] = {
		RandomWeight = 20,
		Id = 48000025,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			48000110,
			48000100,
			48000110,
			48000141,
			48000100
		}
	},
	[48000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 48000026,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			48000150
		}
	},
	[48000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 48000031,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			48000151
		}
	},
	[48000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 48000041,
		SubstituteAction = 48000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			48000152
		}
	},
	[48000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 48000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			48000210
		}
	},
	[48000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 48000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			48000211
		}
	},
	[48000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 48000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			48000210
		}
	},
	[48000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 48000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			48000211
		}
	},
	[48000121] = {
		Id = 48000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[48000122] = {
		Id = 48000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[48000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 48000201,
		SubstituteAction = 48000005,
		ActionUnitIDList = {
			48000300,
			48000310
		}
	},
	[48000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 48000202,
		SubstituteAction = 48000005,
		ActionUnitIDList = {
			48000300,
			48000311
		}
	},
	[48000211] = {
		Id = 48000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[48000212] = {
		RandomWeight = 10,
		Id = 48000212,
		SubstituteAction = 48000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			48000320
		}
	},
	[48000213] = {
		Id = 48000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[48000214] = {
		RandomWeight = 60,
		Id = 48000214,
		SubstituteAction = 48000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			48000321
		}
	},
	[48000221] = {
		RandomWeight = 10,
		Id = 48000221,
		SubstituteAction = 48000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			48000310
		}
	},
	[48000222] = {
		RandomWeight = 20,
		Id = 48000222,
		SubstituteAction = 48000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			48000311
		}
	},
	[48000231] = {
		isDailyAction = true,
		Id = 48000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			48000330
		}
	},
	[48000232] = {
		isDailyAction = true,
		Id = 48000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			48000331
		}
	},
	[48000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 48000301,
		SubstituteAction = 48000005,
		ActionUnitIDList = {
			48000400,
			48000410
		}
	},
	[48000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 48000302,
		SubstituteAction = 48000005,
		ActionUnitIDList = {
			48000400,
			48000411
		}
	},
	[48000311] = {
		Id = 48000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[48000312] = {
		RandomWeight = 10,
		Id = 48000312,
		SubstituteAction = 48000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			48000420
		}
	},
	[48000313] = {
		Id = 48000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[48000314] = {
		RandomWeight = 60,
		Id = 48000314,
		SubstituteAction = 48000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			48000421
		}
	},
	[48000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000321,
		SubstituteAction = 48000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			48000410
		}
	},
	[48000322] = {
		RandomWeight = 20,
		Id = 48000322,
		SubstituteAction = 48000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			48000411
		}
	},
	[48000331] = {
		isDailyAction = true,
		Id = 48000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			48000430
		}
	},
	[48000332] = {
		isDailyAction = true,
		Id = 48000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			48000431
		}
	},
	[48000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 48000401,
		SubstituteAction = 48000005,
		ActionUnitIDList = {
			48000500,
			48000510
		}
	},
	[48000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 48000402,
		SubstituteAction = 48000005,
		ActionUnitIDList = {
			48000500,
			48000511
		}
	},
	[48000411] = {
		Id = 48000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[48000412] = {
		RandomWeight = 10,
		Id = 48000412,
		SubstituteAction = 48000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			48000520
		}
	},
	[48000413] = {
		Id = 48000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[48000414] = {
		RandomWeight = 60,
		Id = 48000414,
		SubstituteAction = 48000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			48000521
		}
	},
	[48000421] = {
		RandomWeight = 10,
		Id = 48000421,
		SubstituteAction = 48000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			48000510
		}
	},
	[48000422] = {
		RandomWeight = 20,
		Id = 48000422,
		SubstituteAction = 48000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			48000511
		}
	},
	[48000431] = {
		isDailyAction = true,
		Id = 48000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			48000530
		}
	},
	[48000432] = {
		isDailyAction = true,
		Id = 48000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			48000531
		}
	},
	[48000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000501,
		SubstituteAction = 48000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000600,
			48000601,
			48000602,
			48000603,
			48000604
		}
	},
	[48000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000502,
		SubstituteAction = 48000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000610,
			48000611,
			48000612,
			48000613,
			48000614
		}
	},
	[48000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000605,
			48000606
		}
	},
	[48000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000615,
			48000616
		}
	},
	[48000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000511,
		SubstituteAction = 48000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			48000620,
			48000621,
			48000622
		}
	},
	[48000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000512,
		SubstituteAction = 48000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			48000630,
			48000631,
			48000632
		}
	},
	[48000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			48000623,
			48000624
		}
	},
	[48000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			48000633,
			48000634
		}
	},
	[48000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000521,
		SubstituteAction = 48000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			48000620,
			48000625,
			48000624
		}
	},
	[48000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 48000522,
		SubstituteAction = 48000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			48000630,
			48000635,
			48000634
		}
	},
	[48000601] = {
		Id = 48000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[48000602] = {
		RandomWeight = 10,
		Id = 48000602,
		SubstituteAction = 48000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000100,
			48000640
		}
	},
	[48000603] = {
		Id = 48000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[48000604] = {
		RandomWeight = 30,
		Id = 48000604,
		SubstituteAction = 48000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000100,
			48000642
		}
	},
	[48000605] = {
		Id = 48000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000641
		}
	},
	[48000606] = {
		Id = 48000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000643
		}
	},
	[48000607] = {
		RandomWeight = 10,
		Id = 48000607,
		SubstituteAction = 48000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000640
		}
	},
	[48000608] = {
		RandomWeight = 30,
		Id = 48000608,
		SubstituteAction = 48000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			48000642
		}
	},
	[48000611] = {
		Id = 48000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[48000612] = {
		RandomWeight = 30,
		Id = 48000612,
		SubstituteAction = 48000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			48000100,
			48000650,
			48000651
		}
	},
	[48000613] = {
		Id = 48000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[48000614] = {
		RandomWeight = 30,
		Id = 48000614,
		SubstituteAction = 48000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			48000100,
			48000652,
			48000653
		}
	},
	[48000615] = {
		Id = 48000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			48000651
		}
	},
	[48000616] = {
		Id = 48000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			48000653
		}
	},
	[48000617] = {
		RandomWeight = 30,
		Id = 48000617,
		SubstituteAction = 48000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			48000650,
			48000651
		}
	},
	[48000618] = {
		RandomWeight = 30,
		Id = 48000618,
		SubstituteAction = 48000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			48000652,
			48000653
		}
	},
	[48000621] = {
		Id = 48000621,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[48000622] = {
		RandomWeight = 30,
		Id = 48000622,
		SubstituteAction = 48000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			48000635,
			48000624
		}
	},
	[48000623] = {
		Id = 48000623,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			105
		}
	},
	[48000624] = {
		RandomWeight = 30,
		Id = 48000624,
		SubstituteAction = 48000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			48000635,
			48000632
		}
	},
	[48000625] = {
		RandomWeight = 30,
		Id = 48000625,
		SubstituteAction = 48000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			48000661
		}
	},
	[48000626] = {
		RandomWeight = 30,
		Id = 48000626,
		SubstituteAction = 48000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			48000662
		}
	},
	[48000701] = {
		RandomWeight = 30,
		Id = 48000701,
		SubstituteAction = 48000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			48000603,
			48000604
		}
	},
	[48000702] = {
		RandomWeight = 10,
		Id = 48000702,
		SubstituteAction = 48000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			48000613,
			48000614
		}
	},
	[48000711] = {
		SubstituteAction = 48000513,
		RandomWeight = 10,
		Id = 48000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[48000712] = {
		RandomWeight = 10,
		Id = 48000712,
		SubstituteAction = 48000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			48000631,
			48000632
		}
	},
	[48000713] = {
		RandomWeight = 10,
		Id = 48000713,
		SubstituteAction = 48000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			48000635,
			48000624
		}
	},
	[48000714] = {
		RandomWeight = 10,
		Id = 48000714,
		SubstituteAction = 48000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			48000635,
			48000632
		}
	},
	[48000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 48000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			48000810,
			48000811,
			48000812,
			48000813
		}
	},
	[48000802] = {
		isDailyAction = true,
		Id = 48000802,
		RandomWeight = 50,
		ActionUnitIDList = {
			48000820,
			48000821,
			48000822
		}
	},
	[48000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 48000803,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			48000830,
			48000831,
			48000832
		}
	},
	[48005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 48005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[48005002] = {
		Id = 48005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			48000100,
			48000110,
			48000111,
			48000112,
			48000113,
			48000120
		}
	},
	[49000001] = {
		Id = 49000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[49000002] = {
		Id = 49000002,
		RandomWeight = 10,
		ConditionIDList = {
			102
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[49000003] = {
		Id = 49000003,
		RandomWeight = 1000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[49000004] = {
		Id = 49000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			49000010
		}
	},
	[49000005] = {
		Id = 49000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			49000020
		}
	},
	[49000011] = {
		RandomWeight = 10,
		Id = 49000011,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000110,
			49000100,
			49000110,
			49000120
		}
	},
	[49000012] = {
		RandomWeight = 10,
		Id = 49000012,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000130
		}
	},
	[49000013] = {
		RandomWeight = 10,
		Id = 49000013,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000110,
			49000100,
			49000110,
			49000131,
			49000100
		}
	},
	[49000021] = {
		RandomWeight = 20,
		Id = 49000021,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000111,
			49000100,
			49000111,
			49000120
		}
	},
	[49000022] = {
		RandomWeight = 20,
		Id = 49000022,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000112,
			49000100,
			49000112,
			49000120
		}
	},
	[49000023] = {
		RandomWeight = 20,
		Id = 49000023,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000113,
			49000100,
			49000113,
			49000120
		}
	},
	[49000024] = {
		RandomWeight = 20,
		Id = 49000024,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000140
		}
	},
	[49000025] = {
		RandomWeight = 20,
		Id = 49000025,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			49000110,
			49000100,
			49000110,
			49000141,
			49000100
		}
	},
	[49000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 49000026,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			49000150
		}
	},
	[49000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 49000031,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			49000151
		}
	},
	[49000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 49000041,
		SubstituteAction = 49000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			49000152
		}
	},
	[49000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 49000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			49000210
		}
	},
	[49000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 49000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			49000211
		}
	},
	[49000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 49000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			49000210
		}
	},
	[49000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 49000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			49000211
		}
	},
	[49000121] = {
		Id = 49000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[49000122] = {
		Id = 49000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[49000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 49000201,
		SubstituteAction = 49000005,
		ActionUnitIDList = {
			49000300,
			49000310
		}
	},
	[49000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 49000202,
		SubstituteAction = 49000005,
		ActionUnitIDList = {
			49000300,
			49000311
		}
	},
	[49000211] = {
		Id = 49000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[49000212] = {
		RandomWeight = 10,
		Id = 49000212,
		SubstituteAction = 49000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			49000320
		}
	},
	[49000213] = {
		Id = 49000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[49000214] = {
		RandomWeight = 60,
		Id = 49000214,
		SubstituteAction = 49000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			49000321
		}
	},
	[49000221] = {
		RandomWeight = 10,
		Id = 49000221,
		SubstituteAction = 49000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			49000310
		}
	},
	[49000222] = {
		RandomWeight = 20,
		Id = 49000222,
		SubstituteAction = 49000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			49000311
		}
	},
	[49000231] = {
		isDailyAction = true,
		Id = 49000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			49000330
		}
	},
	[49000232] = {
		isDailyAction = true,
		Id = 49000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			49000331
		}
	},
	[49000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 49000301,
		SubstituteAction = 49000005,
		ActionUnitIDList = {
			49000400,
			49000410
		}
	},
	[49000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 49000302,
		SubstituteAction = 49000005,
		ActionUnitIDList = {
			49000400,
			49000411
		}
	},
	[49000311] = {
		Id = 49000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[49000312] = {
		RandomWeight = 10,
		Id = 49000312,
		SubstituteAction = 49000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			49000420
		}
	},
	[49000313] = {
		Id = 49000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[49000314] = {
		RandomWeight = 60,
		Id = 49000314,
		SubstituteAction = 49000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			49000421
		}
	},
	[49000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000321,
		SubstituteAction = 49000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			49000410
		}
	},
	[49000322] = {
		RandomWeight = 20,
		Id = 49000322,
		SubstituteAction = 49000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			49000411
		}
	},
	[49000331] = {
		isDailyAction = true,
		Id = 49000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			49000430
		}
	},
	[49000332] = {
		isDailyAction = true,
		Id = 49000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			49000431
		}
	},
	[49000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 49000401,
		SubstituteAction = 49000005,
		ActionUnitIDList = {
			49000500,
			49000510
		}
	},
	[49000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 49000402,
		SubstituteAction = 49000005,
		ActionUnitIDList = {
			49000500,
			49000511
		}
	},
	[49000411] = {
		Id = 49000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[49000412] = {
		RandomWeight = 10,
		Id = 49000412,
		SubstituteAction = 49000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			49000520
		}
	},
	[49000413] = {
		Id = 49000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[49000414] = {
		RandomWeight = 60,
		Id = 49000414,
		SubstituteAction = 49000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			49000521
		}
	},
	[49000421] = {
		RandomWeight = 10,
		Id = 49000421,
		SubstituteAction = 49000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			49000510
		}
	},
	[49000422] = {
		RandomWeight = 20,
		Id = 49000422,
		SubstituteAction = 49000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			49000511
		}
	},
	[49000431] = {
		isDailyAction = true,
		Id = 49000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			49000530
		}
	},
	[49000432] = {
		isDailyAction = true,
		Id = 49000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			49000531
		}
	},
	[49000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000501,
		SubstituteAction = 49000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000600,
			49000601,
			49000602,
			49000603,
			49000604
		}
	},
	[49000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000502,
		SubstituteAction = 49000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000610,
			49000611,
			49000612,
			49000613,
			49000614
		}
	},
	[49000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000605,
			49000606
		}
	},
	[49000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000615,
			49000616
		}
	},
	[49000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000511,
		SubstituteAction = 49000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			49000620,
			49000621,
			49000622
		}
	},
	[49000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000512,
		SubstituteAction = 49000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			49000630,
			49000631,
			49000632
		}
	},
	[49000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			49000623,
			49000624
		}
	},
	[49000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			49000633,
			49000634
		}
	},
	[49000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000521,
		SubstituteAction = 49000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			49000620,
			49000625,
			49000624
		}
	},
	[49000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 49000522,
		SubstituteAction = 49000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			49000630,
			49000635,
			49000634
		}
	},
	[49000601] = {
		Id = 49000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[49000602] = {
		RandomWeight = 10,
		Id = 49000602,
		SubstituteAction = 49000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000100,
			49000640
		}
	},
	[49000603] = {
		Id = 49000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[49000604] = {
		RandomWeight = 30,
		Id = 49000604,
		SubstituteAction = 49000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000100,
			49000642
		}
	},
	[49000605] = {
		Id = 49000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000641
		}
	},
	[49000606] = {
		Id = 49000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000643
		}
	},
	[49000607] = {
		RandomWeight = 10,
		Id = 49000607,
		SubstituteAction = 49000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000640
		}
	},
	[49000608] = {
		RandomWeight = 30,
		Id = 49000608,
		SubstituteAction = 49000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			49000642
		}
	},
	[49000611] = {
		Id = 49000611,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[49000612] = {
		RandomWeight = 30,
		Id = 49000612,
		SubstituteAction = 49000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			49000100,
			49000650,
			49000651
		}
	},
	[49000613] = {
		Id = 49000613,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			105
		}
	},
	[49000614] = {
		RandomWeight = 30,
		Id = 49000614,
		SubstituteAction = 49000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			49000100,
			49000652,
			49000653
		}
	}
}

setmetatable(CfgHomeLandActionTable_1, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandActionTable_1]")
	end
})

local defaultMetaTable = {
	__index = {
		RandomWeight = 0,
		isDailyAction = false,
		isRoomLimit = false,
		IsLock = false,
		SubstituteAction = 0,
		ConditionIDList = {},
		ActionUnitIDList = {}
	}
}

for i, data in pairs(CfgHomeLandActionTable_1) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandActionTable_1
