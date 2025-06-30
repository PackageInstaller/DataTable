-- chunkname: @IQIGame\\Config\\CfgHomeLandActionTable_2.lua

local CfgHomeLandActionTable_2 = {
	[49000615] = {
		Id = 49000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			49000651
		}
	},
	[49000616] = {
		Id = 49000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			49000653
		}
	},
	[49000617] = {
		RandomWeight = 30,
		Id = 49000617,
		SubstituteAction = 49000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			49000650,
			49000651
		}
	},
	[49000618] = {
		RandomWeight = 30,
		Id = 49000618,
		SubstituteAction = 49000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			49000652,
			49000653
		}
	},
	[49000621] = {
		Id = 49000621,
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
	[49000622] = {
		RandomWeight = 30,
		Id = 49000622,
		SubstituteAction = 49000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			49000635,
			49000624
		}
	},
	[49000623] = {
		Id = 49000623,
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
	[49000624] = {
		RandomWeight = 30,
		Id = 49000624,
		SubstituteAction = 49000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			49000635,
			49000632
		}
	},
	[49000625] = {
		RandomWeight = 30,
		Id = 49000625,
		SubstituteAction = 49000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			49000661
		}
	},
	[49000626] = {
		RandomWeight = 30,
		Id = 49000626,
		SubstituteAction = 49000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			49000662
		}
	},
	[49000701] = {
		RandomWeight = 30,
		Id = 49000701,
		SubstituteAction = 49000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			49000603,
			49000604
		}
	},
	[49000702] = {
		RandomWeight = 10,
		Id = 49000702,
		SubstituteAction = 49000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			49000613,
			49000614
		}
	},
	[49000711] = {
		SubstituteAction = 49000513,
		RandomWeight = 10,
		Id = 49000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[49000712] = {
		RandomWeight = 10,
		Id = 49000712,
		SubstituteAction = 49000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			49000631,
			49000632
		}
	},
	[49000713] = {
		RandomWeight = 10,
		Id = 49000713,
		SubstituteAction = 49000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			49000635,
			49000624
		}
	},
	[49000714] = {
		RandomWeight = 10,
		Id = 49000714,
		SubstituteAction = 49000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			49000635,
			49000632
		}
	},
	[49000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 49000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			49000810,
			49000811,
			49000812
		}
	},
	[49000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 49000802,
		ConditionIDList = {
			202
		},
		ActionUnitIDList = {
			49000820,
			49000821,
			49000822
		}
	},
	[49000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 49000803,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			49000830,
			49000831,
			49000832
		}
	},
	[49005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 49005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[49005002] = {
		Id = 49005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			49000100,
			49000110,
			49000111,
			49000112,
			49000113,
			49000120
		}
	},
	[50000001] = {
		Id = 50000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[50000002] = {
		Id = 50000002,
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
	[50000003] = {
		Id = 50000003,
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
	[50000004] = {
		Id = 50000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			50000010
		}
	},
	[50000005] = {
		Id = 50000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			50000020
		}
	},
	[50000011] = {
		RandomWeight = 10,
		Id = 50000011,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000110,
			50000100,
			50000110,
			50000120
		}
	},
	[50000012] = {
		RandomWeight = 10,
		Id = 50000012,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000130
		}
	},
	[50000013] = {
		RandomWeight = 10,
		Id = 50000013,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000110,
			50000100,
			50000110,
			50000131,
			50000100
		}
	},
	[50000021] = {
		RandomWeight = 20,
		Id = 50000021,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000111,
			50000100,
			50000111,
			50000120
		}
	},
	[50000022] = {
		RandomWeight = 20,
		Id = 50000022,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000112,
			50000100,
			50000112,
			50000120
		}
	},
	[50000023] = {
		RandomWeight = 20,
		Id = 50000023,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000113,
			50000100,
			50000113,
			50000120
		}
	},
	[50000024] = {
		RandomWeight = 20,
		Id = 50000024,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000140
		}
	},
	[50000025] = {
		RandomWeight = 20,
		Id = 50000025,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			50000110,
			50000100,
			50000110,
			50000141,
			50000100
		}
	},
	[50000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 50000026,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			50000150
		}
	},
	[50000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 50000031,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			50000151
		}
	},
	[50000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 50000041,
		SubstituteAction = 50000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			50000152
		}
	},
	[50000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 50000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			50000210
		}
	},
	[50000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 50000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			50000211
		}
	},
	[50000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 50000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			50000210
		}
	},
	[50000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 50000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			50000211
		}
	},
	[50000121] = {
		Id = 50000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[50000122] = {
		Id = 50000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[50000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 50000201,
		SubstituteAction = 50000005,
		ActionUnitIDList = {
			50000300,
			50000310
		}
	},
	[50000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 50000202,
		SubstituteAction = 50000005,
		ActionUnitIDList = {
			50000300,
			50000311
		}
	},
	[50000211] = {
		Id = 50000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[50000212] = {
		RandomWeight = 10,
		Id = 50000212,
		SubstituteAction = 50000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			50000320
		}
	},
	[50000213] = {
		Id = 50000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[50000214] = {
		RandomWeight = 60,
		Id = 50000214,
		SubstituteAction = 50000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			50000321
		}
	},
	[50000221] = {
		RandomWeight = 10,
		Id = 50000221,
		SubstituteAction = 50000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			50000310
		}
	},
	[50000222] = {
		RandomWeight = 20,
		Id = 50000222,
		SubstituteAction = 50000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			50000311
		}
	},
	[50000231] = {
		isDailyAction = true,
		Id = 50000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			50000330
		}
	},
	[50000232] = {
		isDailyAction = true,
		Id = 50000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			50000331
		}
	},
	[50000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 50000301,
		SubstituteAction = 50000005,
		ActionUnitIDList = {
			50000400,
			50000410
		}
	},
	[50000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 50000302,
		SubstituteAction = 50000005,
		ActionUnitIDList = {
			50000400,
			50000411
		}
	},
	[50000311] = {
		Id = 50000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[50000312] = {
		RandomWeight = 10,
		Id = 50000312,
		SubstituteAction = 50000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			50000420
		}
	},
	[50000313] = {
		Id = 50000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[50000314] = {
		RandomWeight = 60,
		Id = 50000314,
		SubstituteAction = 50000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			50000421
		}
	},
	[50000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000321,
		SubstituteAction = 50000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			50000410
		}
	},
	[50000322] = {
		RandomWeight = 20,
		Id = 50000322,
		SubstituteAction = 50000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			50000411
		}
	},
	[50000331] = {
		isDailyAction = true,
		Id = 50000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			50000430
		}
	},
	[50000332] = {
		isDailyAction = true,
		Id = 50000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			50000431
		}
	},
	[50000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 50000401,
		SubstituteAction = 50000005,
		ActionUnitIDList = {
			50000500,
			50000510
		}
	},
	[50000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 50000402,
		SubstituteAction = 50000005,
		ActionUnitIDList = {
			50000500,
			50000511
		}
	},
	[50000411] = {
		Id = 50000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[50000412] = {
		RandomWeight = 10,
		Id = 50000412,
		SubstituteAction = 50000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			50000520
		}
	},
	[50000413] = {
		Id = 50000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[50000414] = {
		RandomWeight = 60,
		Id = 50000414,
		SubstituteAction = 50000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			50000521
		}
	},
	[50000421] = {
		RandomWeight = 10,
		Id = 50000421,
		SubstituteAction = 50000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			50000510
		}
	},
	[50000422] = {
		RandomWeight = 20,
		Id = 50000422,
		SubstituteAction = 50000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			50000511
		}
	},
	[50000431] = {
		isDailyAction = true,
		Id = 50000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			50000530
		}
	},
	[50000432] = {
		isDailyAction = true,
		Id = 50000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			50000531
		}
	},
	[50000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000501,
		SubstituteAction = 50000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000600,
			50000601,
			50000602,
			50000603,
			50000604
		}
	},
	[50000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000502,
		SubstituteAction = 50000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000610,
			50000611,
			50000612,
			50000613,
			50000614
		}
	},
	[50000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000605,
			50000606
		}
	},
	[50000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000615,
			50000616
		}
	},
	[50000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000511,
		SubstituteAction = 50000513,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			50000620,
			50000621,
			50000622
		}
	},
	[50000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000512,
		SubstituteAction = 50000514,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			50000630,
			50000631,
			50000632
		}
	},
	[50000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			50000623,
			50000624
		}
	},
	[50000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			50000633,
			50000634
		}
	},
	[50000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000521,
		SubstituteAction = 50000513,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			50000620,
			50000625,
			50000624
		}
	},
	[50000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 50000522,
		SubstituteAction = 50000514,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			50000630,
			50000635,
			50000634
		}
	},
	[50000601] = {
		Id = 50000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[50000602] = {
		RandomWeight = 10,
		Id = 50000602,
		SubstituteAction = 50000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000100,
			50000640
		}
	},
	[50000603] = {
		Id = 50000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[50000604] = {
		RandomWeight = 30,
		Id = 50000604,
		SubstituteAction = 50000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000100,
			50000642
		}
	},
	[50000605] = {
		Id = 50000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000641
		}
	},
	[50000606] = {
		Id = 50000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000643
		}
	},
	[50000607] = {
		RandomWeight = 10,
		Id = 50000607,
		SubstituteAction = 50000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000640
		}
	},
	[50000608] = {
		RandomWeight = 30,
		Id = 50000608,
		SubstituteAction = 50000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			50000642
		}
	},
	[50000611] = {
		Id = 50000611,
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
	[50000612] = {
		RandomWeight = 30,
		Id = 50000612,
		SubstituteAction = 50000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			50000100,
			50000650,
			50000651
		}
	},
	[50000613] = {
		Id = 50000613,
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
	[50000614] = {
		RandomWeight = 30,
		Id = 50000614,
		SubstituteAction = 50000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			50000100,
			50000652,
			50000653
		}
	},
	[50000615] = {
		Id = 50000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			50000651
		}
	},
	[50000616] = {
		Id = 50000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			50000653
		}
	},
	[50000617] = {
		RandomWeight = 30,
		Id = 50000617,
		SubstituteAction = 50000615,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			50000650,
			50000651
		}
	},
	[50000618] = {
		RandomWeight = 30,
		Id = 50000618,
		SubstituteAction = 50000616,
		ConditionIDList = {
			300,
			402,
			213
		},
		ActionUnitIDList = {
			50000652,
			50000653
		}
	},
	[50000621] = {
		Id = 50000621,
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
	[50000622] = {
		RandomWeight = 30,
		Id = 50000622,
		SubstituteAction = 50000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			50000635,
			50000624
		}
	},
	[50000623] = {
		Id = 50000623,
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
	[50000624] = {
		RandomWeight = 30,
		Id = 50000624,
		SubstituteAction = 50000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			50000635,
			50000632
		}
	},
	[50000625] = {
		RandomWeight = 30,
		Id = 50000625,
		SubstituteAction = 50000615,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			50000661
		}
	},
	[50000626] = {
		RandomWeight = 30,
		Id = 50000626,
		SubstituteAction = 50000616,
		ConditionIDList = {
			300,
			402,
			203
		},
		ActionUnitIDList = {
			50000662
		}
	},
	[50000701] = {
		RandomWeight = 30,
		Id = 50000701,
		SubstituteAction = 50000503,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			50000603,
			50000604
		}
	},
	[50000702] = {
		RandomWeight = 10,
		Id = 50000702,
		SubstituteAction = 50000504,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			50000613,
			50000614
		}
	},
	[50000711] = {
		SubstituteAction = 50000513,
		RandomWeight = 10,
		Id = 50000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[50000712] = {
		RandomWeight = 10,
		Id = 50000712,
		SubstituteAction = 50000514,
		ConditionIDList = {
			301,
			402,
			213
		},
		ActionUnitIDList = {
			50000631,
			50000632
		}
	},
	[50000713] = {
		RandomWeight = 10,
		Id = 50000713,
		SubstituteAction = 50000513,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			50000635,
			50000624
		}
	},
	[50000714] = {
		RandomWeight = 10,
		Id = 50000714,
		SubstituteAction = 50000514,
		ConditionIDList = {
			301,
			402,
			203
		},
		ActionUnitIDList = {
			50000635,
			50000632
		}
	},
	[50000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 50000801,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			50000810,
			50000811,
			50000812,
			50000813
		}
	},
	[50000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 50000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			50000820,
			50000821,
			50000822,
			50000823
		}
	},
	[50000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 50000803,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			50000820,
			50000821,
			50000822,
			50000823
		}
	},
	[50005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 50005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[50005002] = {
		Id = 50005002,
		RandomWeight = 20,
		ConditionIDList = {
			1001
		},
		ActionUnitIDList = {
			50000100,
			50000110,
			50000111,
			50000112,
			50000113,
			50000120
		}
	},
	[51000001] = {
		Id = 51000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[51000002] = {
		Id = 51000002,
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
	[51000003] = {
		Id = 51000003,
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
	[51000004] = {
		Id = 51000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[51000005] = {
		Id = 51000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[51000011] = {
		RandomWeight = 10,
		Id = 51000011,
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
	[51000012] = {
		RandomWeight = 10,
		Id = 51000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[51000013] = {
		RandomWeight = 10,
		Id = 51000013,
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
	[51000021] = {
		RandomWeight = 20,
		Id = 51000021,
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
	[51000022] = {
		RandomWeight = 20,
		Id = 51000022,
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
	[51000023] = {
		RandomWeight = 20,
		Id = 51000023,
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
	[51000024] = {
		RandomWeight = 20,
		Id = 51000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[51000025] = {
		RandomWeight = 20,
		Id = 51000025,
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
	[51000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 51000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[51000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 51000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[51000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 51000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[51000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 51000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[51000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 51000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[51000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 51000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[51000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 51000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[51000121] = {
		Id = 51000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[51000122] = {
		Id = 51000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[51000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 51000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[51000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 51000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[51000211] = {
		Id = 51000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[51000212] = {
		RandomWeight = 10,
		Id = 51000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[51000213] = {
		Id = 51000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[51000214] = {
		RandomWeight = 60,
		Id = 51000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[51000221] = {
		RandomWeight = 10,
		Id = 51000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[51000222] = {
		RandomWeight = 20,
		Id = 51000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[51000231] = {
		isDailyAction = true,
		Id = 51000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[51000232] = {
		isDailyAction = true,
		Id = 51000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[51000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 51000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[51000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 51000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[51000311] = {
		Id = 51000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[51000312] = {
		RandomWeight = 10,
		Id = 51000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[51000313] = {
		Id = 51000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[51000314] = {
		RandomWeight = 60,
		Id = 51000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[51000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[51000322] = {
		RandomWeight = 20,
		Id = 51000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[51000331] = {
		isDailyAction = true,
		Id = 51000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[51000332] = {
		isDailyAction = true,
		Id = 51000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[51000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 51000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[51000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 51000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[51000411] = {
		Id = 51000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[51000412] = {
		RandomWeight = 10,
		Id = 51000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[51000413] = {
		Id = 51000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[51000414] = {
		RandomWeight = 60,
		Id = 51000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[51000421] = {
		RandomWeight = 10,
		Id = 51000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[51000422] = {
		RandomWeight = 20,
		Id = 51000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[51000431] = {
		isDailyAction = true,
		Id = 51000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[51000432] = {
		isDailyAction = true,
		Id = 51000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[51000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000501,
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
	[51000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000502,
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
	[51000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[51000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[51000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000511,
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
	[51000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000512,
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
	[51000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[51000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[51000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000521,
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
	[51000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 51000522,
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
	[51000601] = {
		Id = 51000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[51000602] = {
		RandomWeight = 10,
		Id = 51000602,
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
	[51000603] = {
		Id = 51000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[51000604] = {
		RandomWeight = 30,
		Id = 51000604,
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
	[51000605] = {
		Id = 51000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[51000606] = {
		Id = 51000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[51000607] = {
		RandomWeight = 10,
		Id = 51000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[51000608] = {
		RandomWeight = 30,
		Id = 51000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[51000611] = {
		Id = 51000611,
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
	[51000612] = {
		RandomWeight = 30,
		Id = 51000612,
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
	[51000613] = {
		Id = 51000613,
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
	[51000614] = {
		RandomWeight = 30,
		Id = 51000614,
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
	[51000615] = {
		Id = 51000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[51000616] = {
		Id = 51000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[51000617] = {
		RandomWeight = 30,
		Id = 51000617,
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
	[51000618] = {
		RandomWeight = 30,
		Id = 51000618,
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
	[51000621] = {
		Id = 51000621,
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
	[51000622] = {
		RandomWeight = 30,
		Id = 51000622,
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
	[51000623] = {
		Id = 51000623,
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
	[51000624] = {
		RandomWeight = 30,
		Id = 51000624,
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
	[51000625] = {
		RandomWeight = 30,
		Id = 51000625,
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
	[51000626] = {
		RandomWeight = 30,
		Id = 51000626,
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
	[51000701] = {
		RandomWeight = 30,
		Id = 51000701,
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
	[51000702] = {
		RandomWeight = 10,
		Id = 51000702,
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
	[51000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 51000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[51000712] = {
		RandomWeight = 10,
		Id = 51000712,
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
	[51000713] = {
		RandomWeight = 10,
		Id = 51000713,
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
	[51000714] = {
		RandomWeight = 10,
		Id = 51000714,
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
	[51000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 51000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[51000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 51000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[51000803] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 51000803,
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
	[51005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 51005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[51005002] = {
		Id = 51005002,
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
	[52000001] = {
		Id = 52000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[52000002] = {
		Id = 52000002,
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
	[52000003] = {
		Id = 52000003,
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
	[52000004] = {
		Id = 52000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[52000005] = {
		Id = 52000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[52000011] = {
		RandomWeight = 10,
		Id = 52000011,
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
	[52000012] = {
		RandomWeight = 10,
		Id = 52000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[52000013] = {
		RandomWeight = 10,
		Id = 52000013,
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
	[52000021] = {
		RandomWeight = 20,
		Id = 52000021,
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
	[52000022] = {
		RandomWeight = 20,
		Id = 52000022,
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
	[52000023] = {
		RandomWeight = 20,
		Id = 52000023,
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
	[52000024] = {
		RandomWeight = 20,
		Id = 52000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[52000025] = {
		RandomWeight = 20,
		Id = 52000025,
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
	[52000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 52000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[52000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 52000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[52000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 52000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[52000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 52000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[52000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 52000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[52000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 52000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[52000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 52000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[52000121] = {
		Id = 52000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[52000122] = {
		Id = 52000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[52000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 52000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[52000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 52000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[52000211] = {
		Id = 52000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[52000212] = {
		RandomWeight = 10,
		Id = 52000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[52000213] = {
		Id = 52000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[52000214] = {
		RandomWeight = 60,
		Id = 52000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[52000221] = {
		RandomWeight = 10,
		Id = 52000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[52000222] = {
		RandomWeight = 20,
		Id = 52000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[52000231] = {
		isDailyAction = true,
		Id = 52000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[52000232] = {
		isDailyAction = true,
		Id = 52000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[52000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 52000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[52000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 52000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[52000311] = {
		Id = 52000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[52000312] = {
		RandomWeight = 10,
		Id = 52000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[52000313] = {
		Id = 52000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[52000314] = {
		RandomWeight = 60,
		Id = 52000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[52000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[52000322] = {
		RandomWeight = 20,
		Id = 52000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[52000331] = {
		isDailyAction = true,
		Id = 52000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[52000332] = {
		isDailyAction = true,
		Id = 52000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[52000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 52000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[52000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 52000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[52000411] = {
		Id = 52000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[52000412] = {
		RandomWeight = 10,
		Id = 52000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[52000413] = {
		Id = 52000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[52000414] = {
		RandomWeight = 60,
		Id = 52000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[52000421] = {
		RandomWeight = 10,
		Id = 52000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[52000422] = {
		RandomWeight = 20,
		Id = 52000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[52000431] = {
		isDailyAction = true,
		Id = 52000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[52000432] = {
		isDailyAction = true,
		Id = 52000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[52000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000501,
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
	[52000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000502,
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
	[52000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[52000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[52000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000511,
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
	[52000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000512,
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
	[52000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[52000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[52000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000521,
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
	[52000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 52000522,
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
	[52000601] = {
		Id = 52000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[52000602] = {
		RandomWeight = 10,
		Id = 52000602,
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
	[52000603] = {
		Id = 52000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[52000604] = {
		RandomWeight = 30,
		Id = 52000604,
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
	[52000605] = {
		Id = 52000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[52000606] = {
		Id = 52000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[52000607] = {
		RandomWeight = 10,
		Id = 52000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[52000608] = {
		RandomWeight = 30,
		Id = 52000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[52000611] = {
		Id = 52000611,
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
	[52000612] = {
		RandomWeight = 30,
		Id = 52000612,
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
	[52000613] = {
		Id = 52000613,
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
	[52000614] = {
		RandomWeight = 30,
		Id = 52000614,
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
	[52000615] = {
		Id = 52000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[52000616] = {
		Id = 52000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[52000617] = {
		RandomWeight = 30,
		Id = 52000617,
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
	[52000618] = {
		RandomWeight = 30,
		Id = 52000618,
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
	[52000621] = {
		Id = 52000621,
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
	[52000622] = {
		RandomWeight = 30,
		Id = 52000622,
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
	[52000623] = {
		Id = 52000623,
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
	[52000624] = {
		RandomWeight = 30,
		Id = 52000624,
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
	[52000625] = {
		RandomWeight = 30,
		Id = 52000625,
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
	[52000626] = {
		RandomWeight = 30,
		Id = 52000626,
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
	[52000701] = {
		RandomWeight = 30,
		Id = 52000701,
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
	[52000702] = {
		RandomWeight = 10,
		Id = 52000702,
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
	[52000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 52000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[52000712] = {
		RandomWeight = 10,
		Id = 52000712,
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
	[52000713] = {
		RandomWeight = 10,
		Id = 52000713,
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
	[52000714] = {
		RandomWeight = 10,
		Id = 52000714,
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
	[52000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 52000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[52000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 52000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[52005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 52005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[52005002] = {
		Id = 52005002,
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
	[53000001] = {
		Id = 53000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[53000002] = {
		Id = 53000002,
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
	[53000003] = {
		Id = 53000003,
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
	[53000004] = {
		Id = 53000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[53000005] = {
		Id = 53000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[53000011] = {
		RandomWeight = 10,
		Id = 53000011,
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
	[53000012] = {
		RandomWeight = 10,
		Id = 53000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[53000013] = {
		RandomWeight = 10,
		Id = 53000013,
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
	[53000021] = {
		RandomWeight = 20,
		Id = 53000021,
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
	[53000022] = {
		RandomWeight = 20,
		Id = 53000022,
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
	[53000023] = {
		RandomWeight = 20,
		Id = 53000023,
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
	[53000024] = {
		RandomWeight = 20,
		Id = 53000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[53000025] = {
		RandomWeight = 20,
		Id = 53000025,
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
	[53000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 53000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[53000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 53000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[53000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 53000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[53000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 53000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[53000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 53000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[53000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 53000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[53000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 53000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[53000121] = {
		Id = 53000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[53000122] = {
		Id = 53000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[53000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 53000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[53000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 53000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[53000211] = {
		Id = 53000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[53000212] = {
		RandomWeight = 10,
		Id = 53000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[53000213] = {
		Id = 53000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[53000214] = {
		RandomWeight = 60,
		Id = 53000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[53000221] = {
		RandomWeight = 10,
		Id = 53000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[53000222] = {
		RandomWeight = 20,
		Id = 53000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[53000231] = {
		isDailyAction = true,
		Id = 53000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[53000232] = {
		isDailyAction = true,
		Id = 53000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[53000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 53000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[53000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 53000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[53000311] = {
		Id = 53000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[53000312] = {
		RandomWeight = 10,
		Id = 53000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[53000313] = {
		Id = 53000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[53000314] = {
		RandomWeight = 60,
		Id = 53000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[53000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[53000322] = {
		RandomWeight = 20,
		Id = 53000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[53000331] = {
		isDailyAction = true,
		Id = 53000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[53000332] = {
		isDailyAction = true,
		Id = 53000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[53000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 53000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[53000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 53000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[53000411] = {
		Id = 53000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[53000412] = {
		RandomWeight = 10,
		Id = 53000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[53000413] = {
		Id = 53000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[53000414] = {
		RandomWeight = 60,
		Id = 53000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[53000421] = {
		RandomWeight = 10,
		Id = 53000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[53000422] = {
		RandomWeight = 20,
		Id = 53000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[53000431] = {
		isDailyAction = true,
		Id = 53000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[53000432] = {
		isDailyAction = true,
		Id = 53000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[53000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000501,
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
	[53000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000502,
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
	[53000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[53000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[53000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000511,
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
	[53000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000512,
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
	[53000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[53000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[53000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000521,
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
	[53000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 53000522,
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
	[53000601] = {
		Id = 53000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[53000602] = {
		RandomWeight = 10,
		Id = 53000602,
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
	[53000603] = {
		Id = 53000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[53000604] = {
		RandomWeight = 30,
		Id = 53000604,
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
	[53000605] = {
		Id = 53000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[53000606] = {
		Id = 53000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[53000607] = {
		RandomWeight = 10,
		Id = 53000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[53000608] = {
		RandomWeight = 30,
		Id = 53000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[53000611] = {
		Id = 53000611,
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
	[53000612] = {
		RandomWeight = 30,
		Id = 53000612,
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
	[53000613] = {
		Id = 53000613,
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
	[53000614] = {
		RandomWeight = 30,
		Id = 53000614,
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
	[53000615] = {
		Id = 53000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[53000616] = {
		Id = 53000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[53000617] = {
		RandomWeight = 30,
		Id = 53000617,
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
	[53000618] = {
		RandomWeight = 30,
		Id = 53000618,
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
	[53000621] = {
		Id = 53000621,
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
	[53000622] = {
		RandomWeight = 30,
		Id = 53000622,
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
	[53000623] = {
		Id = 53000623,
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
	[53000624] = {
		RandomWeight = 30,
		Id = 53000624,
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
	[53000625] = {
		RandomWeight = 30,
		Id = 53000625,
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
	[53000626] = {
		RandomWeight = 30,
		Id = 53000626,
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
	[53000701] = {
		RandomWeight = 30,
		Id = 53000701,
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
	[53000702] = {
		RandomWeight = 10,
		Id = 53000702,
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
	[53000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 53000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[53000712] = {
		RandomWeight = 10,
		Id = 53000712,
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
	[53000713] = {
		RandomWeight = 10,
		Id = 53000713,
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
	[53000714] = {
		RandomWeight = 10,
		Id = 53000714,
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
	[53000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 53000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[53000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 53000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[53005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 53005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[53005002] = {
		Id = 53005002,
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
	[54000001] = {
		Id = 54000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[54000002] = {
		Id = 54000002,
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
	[54000003] = {
		Id = 54000003,
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
	[54000004] = {
		Id = 54000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[54000005] = {
		Id = 54000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[54000011] = {
		RandomWeight = 10,
		Id = 54000011,
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
	[54000012] = {
		RandomWeight = 10,
		Id = 54000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[54000013] = {
		RandomWeight = 10,
		Id = 54000013,
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
	[54000021] = {
		RandomWeight = 20,
		Id = 54000021,
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
	[54000022] = {
		RandomWeight = 20,
		Id = 54000022,
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
	[54000023] = {
		RandomWeight = 20,
		Id = 54000023,
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
	[54000024] = {
		RandomWeight = 20,
		Id = 54000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[54000025] = {
		RandomWeight = 20,
		Id = 54000025,
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
	[54000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 54000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[54000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 54000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[54000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 54000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[54000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 54000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[54000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 54000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[54000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 54000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[54000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 54000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[54000121] = {
		Id = 54000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[54000122] = {
		Id = 54000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[54000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 54000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[54000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 54000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[54000211] = {
		Id = 54000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[54000212] = {
		RandomWeight = 10,
		Id = 54000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[54000213] = {
		Id = 54000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[54000214] = {
		RandomWeight = 60,
		Id = 54000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[54000221] = {
		RandomWeight = 10,
		Id = 54000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[54000222] = {
		RandomWeight = 20,
		Id = 54000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[54000231] = {
		isDailyAction = true,
		Id = 54000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[54000232] = {
		isDailyAction = true,
		Id = 54000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[54000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 54000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[54000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 54000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[54000311] = {
		Id = 54000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[54000312] = {
		RandomWeight = 10,
		Id = 54000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[54000313] = {
		Id = 54000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[54000314] = {
		RandomWeight = 60,
		Id = 54000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[54000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[54000322] = {
		RandomWeight = 20,
		Id = 54000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[54000331] = {
		isDailyAction = true,
		Id = 54000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[54000332] = {
		isDailyAction = true,
		Id = 54000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[54000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 54000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[54000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 54000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[54000411] = {
		Id = 54000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[54000412] = {
		RandomWeight = 10,
		Id = 54000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[54000413] = {
		Id = 54000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[54000414] = {
		RandomWeight = 60,
		Id = 54000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[54000421] = {
		RandomWeight = 10,
		Id = 54000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[54000422] = {
		RandomWeight = 20,
		Id = 54000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[54000431] = {
		isDailyAction = true,
		Id = 54000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[54000432] = {
		isDailyAction = true,
		Id = 54000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[54000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000501,
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
	[54000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000502,
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
	[54000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[54000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[54000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000511,
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
	[54000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000512,
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
	[54000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[54000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[54000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000521,
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
	[54000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 54000522,
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
	[54000601] = {
		Id = 54000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[54000602] = {
		RandomWeight = 10,
		Id = 54000602,
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
	[54000603] = {
		Id = 54000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[54000604] = {
		RandomWeight = 30,
		Id = 54000604,
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
	[54000605] = {
		Id = 54000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[54000606] = {
		Id = 54000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[54000607] = {
		RandomWeight = 10,
		Id = 54000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[54000608] = {
		RandomWeight = 30,
		Id = 54000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[54000611] = {
		Id = 54000611,
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
	[54000612] = {
		RandomWeight = 30,
		Id = 54000612,
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
	[54000613] = {
		Id = 54000613,
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
	[54000614] = {
		RandomWeight = 30,
		Id = 54000614,
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
	[54000615] = {
		Id = 54000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[54000616] = {
		Id = 54000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[54000617] = {
		RandomWeight = 30,
		Id = 54000617,
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
	[54000618] = {
		RandomWeight = 30,
		Id = 54000618,
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
	[54000621] = {
		Id = 54000621,
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
	[54000622] = {
		RandomWeight = 30,
		Id = 54000622,
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
	[54000623] = {
		Id = 54000623,
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
	[54000624] = {
		RandomWeight = 30,
		Id = 54000624,
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
	[54000625] = {
		RandomWeight = 30,
		Id = 54000625,
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
	[54000626] = {
		RandomWeight = 30,
		Id = 54000626,
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
	[54000701] = {
		RandomWeight = 30,
		Id = 54000701,
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
	[54000702] = {
		RandomWeight = 10,
		Id = 54000702,
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
	[54000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 54000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[54000712] = {
		RandomWeight = 10,
		Id = 54000712,
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
	[54000713] = {
		RandomWeight = 10,
		Id = 54000713,
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
	[54000714] = {
		RandomWeight = 10,
		Id = 54000714,
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
	[54000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 54000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[54000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 54000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[54005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 54005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[54005002] = {
		Id = 54005002,
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
	[55000001] = {
		Id = 55000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[55000002] = {
		Id = 55000002,
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
	[55000003] = {
		Id = 55000003,
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
	[55000004] = {
		Id = 55000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[55000005] = {
		Id = 55000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[55000011] = {
		RandomWeight = 10,
		Id = 55000011,
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
	[55000012] = {
		RandomWeight = 10,
		Id = 55000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[55000013] = {
		RandomWeight = 10,
		Id = 55000013,
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
	[55000021] = {
		RandomWeight = 20,
		Id = 55000021,
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
	[55000022] = {
		RandomWeight = 20,
		Id = 55000022,
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
	[55000023] = {
		RandomWeight = 20,
		Id = 55000023,
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
	[55000024] = {
		RandomWeight = 20,
		Id = 55000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[55000025] = {
		RandomWeight = 20,
		Id = 55000025,
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
	[55000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 55000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[55000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 55000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[55000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 55000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[55000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 55000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[55000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 55000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[55000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 55000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[55000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 55000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[55000121] = {
		Id = 55000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[55000122] = {
		Id = 55000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[55000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 55000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[55000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 55000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[55000211] = {
		Id = 55000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[55000212] = {
		RandomWeight = 10,
		Id = 55000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[55000213] = {
		Id = 55000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[55000214] = {
		RandomWeight = 60,
		Id = 55000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[55000221] = {
		RandomWeight = 10,
		Id = 55000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[55000222] = {
		RandomWeight = 20,
		Id = 55000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[55000231] = {
		isDailyAction = true,
		Id = 55000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[55000232] = {
		isDailyAction = true,
		Id = 55000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[55000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 55000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[55000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 55000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[55000311] = {
		Id = 55000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[55000312] = {
		RandomWeight = 10,
		Id = 55000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[55000313] = {
		Id = 55000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[55000314] = {
		RandomWeight = 60,
		Id = 55000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[55000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[55000322] = {
		RandomWeight = 20,
		Id = 55000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[55000331] = {
		isDailyAction = true,
		Id = 55000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[55000332] = {
		isDailyAction = true,
		Id = 55000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[55000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 55000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[55000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 55000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[55000411] = {
		Id = 55000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[55000412] = {
		RandomWeight = 10,
		Id = 55000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[55000413] = {
		Id = 55000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[55000414] = {
		RandomWeight = 60,
		Id = 55000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[55000421] = {
		RandomWeight = 10,
		Id = 55000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[55000422] = {
		RandomWeight = 20,
		Id = 55000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[55000431] = {
		isDailyAction = true,
		Id = 55000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[55000432] = {
		isDailyAction = true,
		Id = 55000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[55000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000501,
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
	[55000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000502,
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
	[55000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[55000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[55000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000511,
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
	[55000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000512,
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
	[55000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[55000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[55000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000521,
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
	[55000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 55000522,
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
	[55000601] = {
		Id = 55000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[55000602] = {
		RandomWeight = 10,
		Id = 55000602,
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
	[55000603] = {
		Id = 55000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[55000604] = {
		RandomWeight = 30,
		Id = 55000604,
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
	[55000605] = {
		Id = 55000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[55000606] = {
		Id = 55000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[55000607] = {
		RandomWeight = 10,
		Id = 55000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[55000608] = {
		RandomWeight = 30,
		Id = 55000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[55000611] = {
		Id = 55000611,
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
	[55000612] = {
		RandomWeight = 30,
		Id = 55000612,
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
	[55000613] = {
		Id = 55000613,
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
	[55000614] = {
		RandomWeight = 30,
		Id = 55000614,
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
	[55000615] = {
		Id = 55000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[55000616] = {
		Id = 55000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[55000617] = {
		RandomWeight = 30,
		Id = 55000617,
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
	[55000618] = {
		RandomWeight = 30,
		Id = 55000618,
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
	[55000621] = {
		Id = 55000621,
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
	[55000622] = {
		RandomWeight = 30,
		Id = 55000622,
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
	[55000623] = {
		Id = 55000623,
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
	[55000624] = {
		RandomWeight = 30,
		Id = 55000624,
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
	[55000625] = {
		RandomWeight = 30,
		Id = 55000625,
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
	[55000626] = {
		RandomWeight = 30,
		Id = 55000626,
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
	[55000701] = {
		RandomWeight = 30,
		Id = 55000701,
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
	[55000702] = {
		RandomWeight = 10,
		Id = 55000702,
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
	[55000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 55000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[55000712] = {
		RandomWeight = 10,
		Id = 55000712,
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
	[55000713] = {
		RandomWeight = 10,
		Id = 55000713,
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
	[55000714] = {
		RandomWeight = 10,
		Id = 55000714,
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
	[55000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 55000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[55000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 55000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[55005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 55005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[55005002] = {
		Id = 55005002,
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
	[56000001] = {
		Id = 56000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[56000002] = {
		Id = 56000002,
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
	[56000003] = {
		Id = 56000003,
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
	[56000004] = {
		Id = 56000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[56000005] = {
		Id = 56000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[56000011] = {
		RandomWeight = 10,
		Id = 56000011,
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
	[56000012] = {
		RandomWeight = 10,
		Id = 56000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[56000013] = {
		RandomWeight = 10,
		Id = 56000013,
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
	[56000021] = {
		RandomWeight = 20,
		Id = 56000021,
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
	[56000022] = {
		RandomWeight = 20,
		Id = 56000022,
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
	[56000023] = {
		RandomWeight = 20,
		Id = 56000023,
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
	[56000024] = {
		RandomWeight = 20,
		Id = 56000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[56000025] = {
		RandomWeight = 20,
		Id = 56000025,
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
	[56000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 56000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[56000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 56000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[56000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 56000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[56000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 56000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[56000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 56000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[56000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 56000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[56000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 56000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[56000121] = {
		Id = 56000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[56000122] = {
		Id = 56000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[56000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 56000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[56000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 56000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[56000211] = {
		Id = 56000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[56000212] = {
		RandomWeight = 10,
		Id = 56000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[56000213] = {
		Id = 56000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[56000214] = {
		RandomWeight = 60,
		Id = 56000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[56000221] = {
		RandomWeight = 10,
		Id = 56000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[56000222] = {
		RandomWeight = 20,
		Id = 56000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[56000231] = {
		isDailyAction = true,
		Id = 56000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[56000232] = {
		isDailyAction = true,
		Id = 56000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[56000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 56000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[56000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 56000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[56000311] = {
		Id = 56000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[56000312] = {
		RandomWeight = 10,
		Id = 56000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[56000313] = {
		Id = 56000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[56000314] = {
		RandomWeight = 60,
		Id = 56000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[56000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[56000322] = {
		RandomWeight = 20,
		Id = 56000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[56000331] = {
		isDailyAction = true,
		Id = 56000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[56000332] = {
		isDailyAction = true,
		Id = 56000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[56000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 56000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[56000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 56000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[56000411] = {
		Id = 56000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[56000412] = {
		RandomWeight = 10,
		Id = 56000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[56000413] = {
		Id = 56000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[56000414] = {
		RandomWeight = 60,
		Id = 56000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[56000421] = {
		RandomWeight = 10,
		Id = 56000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[56000422] = {
		RandomWeight = 20,
		Id = 56000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[56000431] = {
		isDailyAction = true,
		Id = 56000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[56000432] = {
		isDailyAction = true,
		Id = 56000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[56000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000501,
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
	[56000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000502,
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
	[56000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[56000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[56000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000511,
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
	[56000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000512,
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
	[56000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[56000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[56000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000521,
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
	[56000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 56000522,
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
	[56000601] = {
		Id = 56000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[56000602] = {
		RandomWeight = 10,
		Id = 56000602,
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
	[56000603] = {
		Id = 56000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[56000604] = {
		RandomWeight = 30,
		Id = 56000604,
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
	[56000605] = {
		Id = 56000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[56000606] = {
		Id = 56000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[56000607] = {
		RandomWeight = 10,
		Id = 56000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[56000608] = {
		RandomWeight = 30,
		Id = 56000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[56000611] = {
		Id = 56000611,
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
	[56000612] = {
		RandomWeight = 30,
		Id = 56000612,
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
	[56000613] = {
		Id = 56000613,
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
	[56000614] = {
		RandomWeight = 30,
		Id = 56000614,
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
	[56000615] = {
		Id = 56000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[56000616] = {
		Id = 56000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[56000617] = {
		RandomWeight = 30,
		Id = 56000617,
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
	[56000618] = {
		RandomWeight = 30,
		Id = 56000618,
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
	[56000621] = {
		Id = 56000621,
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
	[56000622] = {
		RandomWeight = 30,
		Id = 56000622,
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
	[56000623] = {
		Id = 56000623,
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
	[56000624] = {
		RandomWeight = 30,
		Id = 56000624,
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
	[56000625] = {
		RandomWeight = 30,
		Id = 56000625,
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
	[56000626] = {
		RandomWeight = 30,
		Id = 56000626,
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
	[56000701] = {
		RandomWeight = 30,
		Id = 56000701,
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
	[56000702] = {
		RandomWeight = 10,
		Id = 56000702,
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
	[56000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 56000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[56000712] = {
		RandomWeight = 10,
		Id = 56000712,
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
	[56000713] = {
		RandomWeight = 10,
		Id = 56000713,
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
	[56000714] = {
		RandomWeight = 10,
		Id = 56000714,
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
	[56000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 56000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[56000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 56000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[56005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 56005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[56005002] = {
		Id = 56005002,
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
	[57000001] = {
		Id = 57000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[57000002] = {
		Id = 57000002,
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
	[57000003] = {
		Id = 57000003,
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
	[57000004] = {
		Id = 57000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[57000005] = {
		Id = 57000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[57000011] = {
		RandomWeight = 10,
		Id = 57000011,
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
	[57000012] = {
		RandomWeight = 10,
		Id = 57000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[57000013] = {
		RandomWeight = 10,
		Id = 57000013,
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
	[57000021] = {
		RandomWeight = 20,
		Id = 57000021,
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
	[57000022] = {
		RandomWeight = 20,
		Id = 57000022,
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
	[57000023] = {
		RandomWeight = 20,
		Id = 57000023,
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
	[57000024] = {
		RandomWeight = 20,
		Id = 57000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[57000025] = {
		RandomWeight = 20,
		Id = 57000025,
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
	[57000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 57000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[57000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 57000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[57000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 57000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[57000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 57000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[57000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 57000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[57000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 57000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[57000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 57000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[57000121] = {
		Id = 57000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[57000122] = {
		Id = 57000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[57000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 57000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[57000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 57000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[57000211] = {
		Id = 57000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[57000212] = {
		RandomWeight = 10,
		Id = 57000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[57000213] = {
		Id = 57000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[57000214] = {
		RandomWeight = 60,
		Id = 57000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[57000221] = {
		RandomWeight = 10,
		Id = 57000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[57000222] = {
		RandomWeight = 20,
		Id = 57000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[57000231] = {
		isDailyAction = true,
		Id = 57000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[57000232] = {
		isDailyAction = true,
		Id = 57000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[57000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 57000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[57000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 57000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[57000311] = {
		Id = 57000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[57000312] = {
		RandomWeight = 10,
		Id = 57000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[57000313] = {
		Id = 57000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[57000314] = {
		RandomWeight = 60,
		Id = 57000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[57000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[57000322] = {
		RandomWeight = 20,
		Id = 57000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[57000331] = {
		isDailyAction = true,
		Id = 57000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[57000332] = {
		isDailyAction = true,
		Id = 57000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[57000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 57000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[57000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 57000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[57000411] = {
		Id = 57000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[57000412] = {
		RandomWeight = 10,
		Id = 57000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[57000413] = {
		Id = 57000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[57000414] = {
		RandomWeight = 60,
		Id = 57000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[57000421] = {
		RandomWeight = 10,
		Id = 57000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[57000422] = {
		RandomWeight = 20,
		Id = 57000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[57000431] = {
		isDailyAction = true,
		Id = 57000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[57000432] = {
		isDailyAction = true,
		Id = 57000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[57000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000501,
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
	[57000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000502,
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
	[57000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[57000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[57000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000511,
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
	[57000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000512,
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
	[57000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[57000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[57000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000521,
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
	[57000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 57000522,
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
	[57000601] = {
		Id = 57000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[57000602] = {
		RandomWeight = 10,
		Id = 57000602,
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
	[57000603] = {
		Id = 57000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[57000604] = {
		RandomWeight = 30,
		Id = 57000604,
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
	[57000605] = {
		Id = 57000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[57000606] = {
		Id = 57000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[57000607] = {
		RandomWeight = 10,
		Id = 57000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[57000608] = {
		RandomWeight = 30,
		Id = 57000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[57000611] = {
		Id = 57000611,
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
	[57000612] = {
		RandomWeight = 30,
		Id = 57000612,
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
	[57000613] = {
		Id = 57000613,
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
	[57000614] = {
		RandomWeight = 30,
		Id = 57000614,
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
	[57000615] = {
		Id = 57000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[57000616] = {
		Id = 57000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[57000617] = {
		RandomWeight = 30,
		Id = 57000617,
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
	[57000618] = {
		RandomWeight = 30,
		Id = 57000618,
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
	[57000621] = {
		Id = 57000621,
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
	[57000622] = {
		RandomWeight = 30,
		Id = 57000622,
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
	[57000623] = {
		Id = 57000623,
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
	[57000624] = {
		RandomWeight = 30,
		Id = 57000624,
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
	[57000625] = {
		RandomWeight = 30,
		Id = 57000625,
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
	[57000626] = {
		RandomWeight = 30,
		Id = 57000626,
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
	[57000701] = {
		RandomWeight = 30,
		Id = 57000701,
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
	[57000702] = {
		RandomWeight = 10,
		Id = 57000702,
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
	[57000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 57000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[57000712] = {
		RandomWeight = 10,
		Id = 57000712,
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
	[57000713] = {
		RandomWeight = 10,
		Id = 57000713,
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
	[57000714] = {
		RandomWeight = 10,
		Id = 57000714,
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
	[57000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 57000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[57000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 57000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[57005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 57005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[57005002] = {
		Id = 57005002,
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
	[58000001] = {
		Id = 58000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[58000002] = {
		Id = 58000002,
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
	[58000003] = {
		Id = 58000003,
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
	[58000004] = {
		Id = 58000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[58000005] = {
		Id = 58000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[58000011] = {
		RandomWeight = 10,
		Id = 58000011,
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
	[58000012] = {
		RandomWeight = 10,
		Id = 58000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[58000013] = {
		RandomWeight = 10,
		Id = 58000013,
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
	[58000021] = {
		RandomWeight = 20,
		Id = 58000021,
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
	[58000022] = {
		RandomWeight = 20,
		Id = 58000022,
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
	[58000023] = {
		RandomWeight = 20,
		Id = 58000023,
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
	[58000024] = {
		RandomWeight = 20,
		Id = 58000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[58000025] = {
		RandomWeight = 20,
		Id = 58000025,
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
	[58000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 58000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[58000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 58000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[58000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 58000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[58000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 58000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[58000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 58000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[58000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 58000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[58000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 58000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[58000121] = {
		Id = 58000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[58000122] = {
		Id = 58000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[58000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 58000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[58000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 58000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[58000211] = {
		Id = 58000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[58000212] = {
		RandomWeight = 10,
		Id = 58000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[58000213] = {
		Id = 58000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[58000214] = {
		RandomWeight = 60,
		Id = 58000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[58000221] = {
		RandomWeight = 10,
		Id = 58000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[58000222] = {
		RandomWeight = 20,
		Id = 58000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[58000231] = {
		isDailyAction = true,
		Id = 58000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[58000232] = {
		isDailyAction = true,
		Id = 58000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[58000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 58000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[58000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 58000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[58000311] = {
		Id = 58000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[58000312] = {
		RandomWeight = 10,
		Id = 58000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[58000313] = {
		Id = 58000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[58000314] = {
		RandomWeight = 60,
		Id = 58000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[58000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[58000322] = {
		RandomWeight = 20,
		Id = 58000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[58000331] = {
		isDailyAction = true,
		Id = 58000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[58000332] = {
		isDailyAction = true,
		Id = 58000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[58000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 58000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[58000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 58000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[58000411] = {
		Id = 58000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[58000412] = {
		RandomWeight = 10,
		Id = 58000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[58000413] = {
		Id = 58000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[58000414] = {
		RandomWeight = 60,
		Id = 58000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[58000421] = {
		RandomWeight = 10,
		Id = 58000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[58000422] = {
		RandomWeight = 20,
		Id = 58000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[58000431] = {
		isDailyAction = true,
		Id = 58000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[58000432] = {
		isDailyAction = true,
		Id = 58000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[58000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000501,
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
	[58000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000502,
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
	[58000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[58000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[58000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000511,
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
	[58000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000512,
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
	[58000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[58000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[58000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000521,
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
	[58000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 58000522,
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
	[58000601] = {
		Id = 58000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[58000602] = {
		RandomWeight = 10,
		Id = 58000602,
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
	[58000603] = {
		Id = 58000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[58000604] = {
		RandomWeight = 30,
		Id = 58000604,
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
	[58000605] = {
		Id = 58000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[58000606] = {
		Id = 58000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[58000607] = {
		RandomWeight = 10,
		Id = 58000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[58000608] = {
		RandomWeight = 30,
		Id = 58000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[58000611] = {
		Id = 58000611,
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
	[58000612] = {
		RandomWeight = 30,
		Id = 58000612,
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
	[58000613] = {
		Id = 58000613,
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
	[58000614] = {
		RandomWeight = 30,
		Id = 58000614,
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
	[58000615] = {
		Id = 58000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[58000616] = {
		Id = 58000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[58000617] = {
		RandomWeight = 30,
		Id = 58000617,
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
	[58000618] = {
		RandomWeight = 30,
		Id = 58000618,
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
	[58000621] = {
		Id = 58000621,
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
	[58000622] = {
		RandomWeight = 30,
		Id = 58000622,
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
	[58000623] = {
		Id = 58000623,
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
	[58000624] = {
		RandomWeight = 30,
		Id = 58000624,
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
	[58000625] = {
		RandomWeight = 30,
		Id = 58000625,
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
	[58000626] = {
		RandomWeight = 30,
		Id = 58000626,
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
	[58000701] = {
		RandomWeight = 30,
		Id = 58000701,
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
	[58000702] = {
		RandomWeight = 10,
		Id = 58000702,
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
	[58000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 58000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[58000712] = {
		RandomWeight = 10,
		Id = 58000712,
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
	[58000713] = {
		RandomWeight = 10,
		Id = 58000713,
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
	[58000714] = {
		RandomWeight = 10,
		Id = 58000714,
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
	[58000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 58000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[58000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 58000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[58005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 58005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[58005002] = {
		Id = 58005002,
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
	[59000001] = {
		Id = 59000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[59000002] = {
		Id = 59000002,
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
	[59000003] = {
		Id = 59000003,
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
	[59000004] = {
		Id = 59000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[59000005] = {
		Id = 59000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[59000011] = {
		RandomWeight = 10,
		Id = 59000011,
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
	[59000012] = {
		RandomWeight = 10,
		Id = 59000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[59000013] = {
		RandomWeight = 10,
		Id = 59000013,
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
	[59000021] = {
		RandomWeight = 20,
		Id = 59000021,
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
	[59000022] = {
		RandomWeight = 20,
		Id = 59000022,
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
	[59000023] = {
		RandomWeight = 20,
		Id = 59000023,
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
	[59000024] = {
		RandomWeight = 20,
		Id = 59000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[59000025] = {
		RandomWeight = 20,
		Id = 59000025,
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
	[59000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 59000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[59000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 59000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[59000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 59000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[59000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 59000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[59000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 59000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[59000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 59000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[59000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 59000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[59000121] = {
		Id = 59000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[59000122] = {
		Id = 59000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[59000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 59000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[59000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 59000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[59000211] = {
		Id = 59000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[59000212] = {
		RandomWeight = 10,
		Id = 59000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[59000213] = {
		Id = 59000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[59000214] = {
		RandomWeight = 60,
		Id = 59000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[59000221] = {
		RandomWeight = 10,
		Id = 59000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[59000222] = {
		RandomWeight = 20,
		Id = 59000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[59000231] = {
		isDailyAction = true,
		Id = 59000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[59000232] = {
		isDailyAction = true,
		Id = 59000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[59000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 59000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[59000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 59000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[59000311] = {
		Id = 59000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[59000312] = {
		RandomWeight = 10,
		Id = 59000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[59000313] = {
		Id = 59000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[59000314] = {
		RandomWeight = 60,
		Id = 59000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[59000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[59000322] = {
		RandomWeight = 20,
		Id = 59000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[59000331] = {
		isDailyAction = true,
		Id = 59000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[59000332] = {
		isDailyAction = true,
		Id = 59000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[59000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 59000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[59000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 59000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[59000411] = {
		Id = 59000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[59000412] = {
		RandomWeight = 10,
		Id = 59000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[59000413] = {
		Id = 59000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[59000414] = {
		RandomWeight = 60,
		Id = 59000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[59000421] = {
		RandomWeight = 10,
		Id = 59000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[59000422] = {
		RandomWeight = 20,
		Id = 59000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[59000431] = {
		isDailyAction = true,
		Id = 59000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[59000432] = {
		isDailyAction = true,
		Id = 59000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[59000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000501,
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
	[59000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000502,
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
	[59000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[59000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[59000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000511,
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
	[59000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000512,
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
	[59000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[59000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[59000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000521,
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
	[59000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 59000522,
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
	[59000601] = {
		Id = 59000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[59000602] = {
		RandomWeight = 10,
		Id = 59000602,
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
	[59000603] = {
		Id = 59000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[59000604] = {
		RandomWeight = 30,
		Id = 59000604,
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
	[59000605] = {
		Id = 59000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[59000606] = {
		Id = 59000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[59000607] = {
		RandomWeight = 10,
		Id = 59000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[59000608] = {
		RandomWeight = 30,
		Id = 59000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[59000611] = {
		Id = 59000611,
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
	[59000612] = {
		RandomWeight = 30,
		Id = 59000612,
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
	[59000613] = {
		Id = 59000613,
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
	[59000614] = {
		RandomWeight = 30,
		Id = 59000614,
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
	[59000615] = {
		Id = 59000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[59000616] = {
		Id = 59000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[59000617] = {
		RandomWeight = 30,
		Id = 59000617,
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
	[59000618] = {
		RandomWeight = 30,
		Id = 59000618,
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
	[59000621] = {
		Id = 59000621,
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
	[59000622] = {
		RandomWeight = 30,
		Id = 59000622,
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
	[59000623] = {
		Id = 59000623,
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
	[59000624] = {
		RandomWeight = 30,
		Id = 59000624,
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
	[59000625] = {
		RandomWeight = 30,
		Id = 59000625,
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
	[59000626] = {
		RandomWeight = 30,
		Id = 59000626,
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
	[59000701] = {
		RandomWeight = 30,
		Id = 59000701,
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
	[59000702] = {
		RandomWeight = 10,
		Id = 59000702,
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
	[59000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 59000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[59000712] = {
		RandomWeight = 10,
		Id = 59000712,
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
	[59000713] = {
		RandomWeight = 10,
		Id = 59000713,
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
	[59000714] = {
		RandomWeight = 10,
		Id = 59000714,
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
	[59000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 59000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[59000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 59000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[59005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 59005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[59005002] = {
		Id = 59005002,
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
	[60000001] = {
		Id = 60000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[60000002] = {
		Id = 60000002,
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
	[60000003] = {
		Id = 60000003,
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
	[60000004] = {
		Id = 60000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[60000005] = {
		Id = 60000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[60000011] = {
		RandomWeight = 10,
		Id = 60000011,
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
	[60000012] = {
		RandomWeight = 10,
		Id = 60000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[60000013] = {
		RandomWeight = 10,
		Id = 60000013,
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
	[60000021] = {
		RandomWeight = 20,
		Id = 60000021,
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
	[60000022] = {
		RandomWeight = 20,
		Id = 60000022,
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
	[60000023] = {
		RandomWeight = 20,
		Id = 60000023,
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
	[60000024] = {
		RandomWeight = 20,
		Id = 60000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[60000025] = {
		RandomWeight = 20,
		Id = 60000025,
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
	[60000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 60000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[60000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 60000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[60000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 60000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[60000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 60000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[60000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 60000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[60000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 60000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[60000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 60000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[60000121] = {
		Id = 60000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[60000122] = {
		Id = 60000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[60000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 60000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[60000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 60000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[60000211] = {
		Id = 60000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[60000212] = {
		RandomWeight = 10,
		Id = 60000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[60000213] = {
		Id = 60000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[60000214] = {
		RandomWeight = 60,
		Id = 60000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[60000221] = {
		RandomWeight = 10,
		Id = 60000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[60000222] = {
		RandomWeight = 20,
		Id = 60000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[60000231] = {
		isDailyAction = true,
		Id = 60000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[60000232] = {
		isDailyAction = true,
		Id = 60000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[60000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 60000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[60000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 60000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[60000311] = {
		Id = 60000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[60000312] = {
		RandomWeight = 10,
		Id = 60000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[60000313] = {
		Id = 60000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[60000314] = {
		RandomWeight = 60,
		Id = 60000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[60000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[60000322] = {
		RandomWeight = 20,
		Id = 60000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[60000331] = {
		isDailyAction = true,
		Id = 60000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[60000332] = {
		isDailyAction = true,
		Id = 60000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[60000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 60000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[60000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 60000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[60000411] = {
		Id = 60000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[60000412] = {
		RandomWeight = 10,
		Id = 60000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[60000413] = {
		Id = 60000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[60000414] = {
		RandomWeight = 60,
		Id = 60000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[60000421] = {
		RandomWeight = 10,
		Id = 60000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[60000422] = {
		RandomWeight = 20,
		Id = 60000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[60000431] = {
		isDailyAction = true,
		Id = 60000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[60000432] = {
		isDailyAction = true,
		Id = 60000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[60000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000501,
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
	[60000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000502,
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
	[60000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[60000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[60000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000511,
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
	[60000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000512,
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
	[60000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[60000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[60000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000521,
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
	[60000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 60000522,
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
	[60000601] = {
		Id = 60000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[60000602] = {
		RandomWeight = 10,
		Id = 60000602,
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
	[60000603] = {
		Id = 60000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[60000604] = {
		RandomWeight = 30,
		Id = 60000604,
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
	[60000605] = {
		Id = 60000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[60000606] = {
		Id = 60000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[60000607] = {
		RandomWeight = 10,
		Id = 60000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[60000608] = {
		RandomWeight = 30,
		Id = 60000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[60000611] = {
		Id = 60000611,
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
	[60000612] = {
		RandomWeight = 30,
		Id = 60000612,
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
	[60000613] = {
		Id = 60000613,
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
	[60000614] = {
		RandomWeight = 30,
		Id = 60000614,
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
	[60000615] = {
		Id = 60000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[60000616] = {
		Id = 60000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[60000617] = {
		RandomWeight = 30,
		Id = 60000617,
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
	[60000618] = {
		RandomWeight = 30,
		Id = 60000618,
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
	[60000621] = {
		Id = 60000621,
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
	[60000622] = {
		RandomWeight = 30,
		Id = 60000622,
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
	[60000623] = {
		Id = 60000623,
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
	[60000624] = {
		RandomWeight = 30,
		Id = 60000624,
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
	[60000625] = {
		RandomWeight = 30,
		Id = 60000625,
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
	[60000626] = {
		RandomWeight = 30,
		Id = 60000626,
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
	[60000701] = {
		RandomWeight = 30,
		Id = 60000701,
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
	[60000702] = {
		RandomWeight = 10,
		Id = 60000702,
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
	[60000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 60000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[60000712] = {
		RandomWeight = 10,
		Id = 60000712,
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
	[60000713] = {
		RandomWeight = 10,
		Id = 60000713,
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
	[60000714] = {
		RandomWeight = 10,
		Id = 60000714,
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
	[60000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 60000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[60000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 60000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[60005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 60005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[60005002] = {
		Id = 60005002,
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
	[61000001] = {
		Id = 61000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[61000002] = {
		Id = 61000002,
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
	[61000003] = {
		Id = 61000003,
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
	[61000004] = {
		Id = 61000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[61000005] = {
		Id = 61000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[61000011] = {
		RandomWeight = 10,
		Id = 61000011,
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
	[61000012] = {
		RandomWeight = 10,
		Id = 61000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[61000013] = {
		RandomWeight = 10,
		Id = 61000013,
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
	[61000021] = {
		RandomWeight = 20,
		Id = 61000021,
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
	[61000022] = {
		RandomWeight = 20,
		Id = 61000022,
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
	[61000023] = {
		RandomWeight = 20,
		Id = 61000023,
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
	[61000024] = {
		RandomWeight = 20,
		Id = 61000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[61000025] = {
		RandomWeight = 20,
		Id = 61000025,
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
	[61000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 61000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[61000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 61000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[61000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 61000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[61000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 61000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[61000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 61000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[61000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 61000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[61000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 61000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[61000121] = {
		Id = 61000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[61000122] = {
		Id = 61000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[61000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 61000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[61000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 61000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[61000211] = {
		Id = 61000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[61000212] = {
		RandomWeight = 10,
		Id = 61000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[61000213] = {
		Id = 61000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[61000214] = {
		RandomWeight = 60,
		Id = 61000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[61000221] = {
		RandomWeight = 10,
		Id = 61000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[61000222] = {
		RandomWeight = 20,
		Id = 61000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[61000231] = {
		isDailyAction = true,
		Id = 61000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[61000232] = {
		isDailyAction = true,
		Id = 61000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[61000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 61000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[61000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 61000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[61000311] = {
		Id = 61000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[61000312] = {
		RandomWeight = 10,
		Id = 61000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[61000313] = {
		Id = 61000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[61000314] = {
		RandomWeight = 60,
		Id = 61000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[61000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[61000322] = {
		RandomWeight = 20,
		Id = 61000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[61000331] = {
		isDailyAction = true,
		Id = 61000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[61000332] = {
		isDailyAction = true,
		Id = 61000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[61000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 61000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[61000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 61000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[61000411] = {
		Id = 61000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[61000412] = {
		RandomWeight = 10,
		Id = 61000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[61000413] = {
		Id = 61000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[61000414] = {
		RandomWeight = 60,
		Id = 61000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[61000421] = {
		RandomWeight = 10,
		Id = 61000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[61000422] = {
		RandomWeight = 20,
		Id = 61000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[61000431] = {
		isDailyAction = true,
		Id = 61000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[61000432] = {
		isDailyAction = true,
		Id = 61000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[61000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000501,
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
	[61000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000502,
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
	[61000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[61000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[61000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000511,
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
	[61000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000512,
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
	[61000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[61000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[61000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000521,
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
	[61000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 61000522,
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
	[61000601] = {
		Id = 61000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[61000602] = {
		RandomWeight = 10,
		Id = 61000602,
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
	[61000603] = {
		Id = 61000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[61000604] = {
		RandomWeight = 30,
		Id = 61000604,
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
	[61000605] = {
		Id = 61000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[61000606] = {
		Id = 61000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[61000607] = {
		RandomWeight = 10,
		Id = 61000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[61000608] = {
		RandomWeight = 30,
		Id = 61000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[61000611] = {
		Id = 61000611,
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
	[61000612] = {
		RandomWeight = 30,
		Id = 61000612,
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
	[61000613] = {
		Id = 61000613,
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
	[61000614] = {
		RandomWeight = 30,
		Id = 61000614,
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
	[61000615] = {
		Id = 61000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[61000616] = {
		Id = 61000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[61000617] = {
		RandomWeight = 30,
		Id = 61000617,
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
	[61000618] = {
		RandomWeight = 30,
		Id = 61000618,
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
	[61000621] = {
		Id = 61000621,
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
	[61000622] = {
		RandomWeight = 30,
		Id = 61000622,
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
	[61000623] = {
		Id = 61000623,
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
	[61000624] = {
		RandomWeight = 30,
		Id = 61000624,
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
	[61000625] = {
		RandomWeight = 30,
		Id = 61000625,
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
	[61000626] = {
		RandomWeight = 30,
		Id = 61000626,
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
	[61000701] = {
		RandomWeight = 30,
		Id = 61000701,
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
	[61000702] = {
		RandomWeight = 10,
		Id = 61000702,
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
	[61000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 61000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[61000712] = {
		RandomWeight = 10,
		Id = 61000712,
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
	[61000713] = {
		RandomWeight = 10,
		Id = 61000713,
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
	[61000714] = {
		RandomWeight = 10,
		Id = 61000714,
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
	[61000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 61000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[61000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 61000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[61005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 61005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[61005002] = {
		Id = 61005002,
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
	[62000001] = {
		Id = 62000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[62000002] = {
		Id = 62000002,
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
	[62000003] = {
		Id = 62000003,
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
	[62000004] = {
		Id = 62000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[62000005] = {
		Id = 62000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[62000011] = {
		RandomWeight = 10,
		Id = 62000011,
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
	[62000012] = {
		RandomWeight = 10,
		Id = 62000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[62000013] = {
		RandomWeight = 10,
		Id = 62000013,
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
	[62000021] = {
		RandomWeight = 20,
		Id = 62000021,
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
	[62000022] = {
		RandomWeight = 20,
		Id = 62000022,
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
	[62000023] = {
		RandomWeight = 20,
		Id = 62000023,
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
	[62000024] = {
		RandomWeight = 20,
		Id = 62000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[62000025] = {
		RandomWeight = 20,
		Id = 62000025,
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
	[62000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 62000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[62000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 62000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[62000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 62000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[62000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 62000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[62000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 62000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[62000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 62000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[62000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 62000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[62000121] = {
		Id = 62000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[62000122] = {
		Id = 62000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[62000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 62000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[62000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 62000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[62000211] = {
		Id = 62000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[62000212] = {
		RandomWeight = 10,
		Id = 62000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[62000213] = {
		Id = 62000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[62000214] = {
		RandomWeight = 60,
		Id = 62000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[62000221] = {
		RandomWeight = 10,
		Id = 62000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[62000222] = {
		RandomWeight = 20,
		Id = 62000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[62000231] = {
		isDailyAction = true,
		Id = 62000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[62000232] = {
		isDailyAction = true,
		Id = 62000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[62000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 62000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[62000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 62000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[62000311] = {
		Id = 62000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[62000312] = {
		RandomWeight = 10,
		Id = 62000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[62000313] = {
		Id = 62000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[62000314] = {
		RandomWeight = 60,
		Id = 62000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[62000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[62000322] = {
		RandomWeight = 20,
		Id = 62000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[62000331] = {
		isDailyAction = true,
		Id = 62000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[62000332] = {
		isDailyAction = true,
		Id = 62000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[62000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 62000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[62000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 62000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[62000411] = {
		Id = 62000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[62000412] = {
		RandomWeight = 10,
		Id = 62000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[62000413] = {
		Id = 62000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[62000414] = {
		RandomWeight = 60,
		Id = 62000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[62000421] = {
		RandomWeight = 10,
		Id = 62000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[62000422] = {
		RandomWeight = 20,
		Id = 62000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[62000431] = {
		isDailyAction = true,
		Id = 62000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[62000432] = {
		isDailyAction = true,
		Id = 62000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[62000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000501,
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
	[62000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000502,
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
	[62000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[62000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[62000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000511,
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
	[62000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000512,
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
	[62000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[62000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[62000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000521,
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
	[62000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 62000522,
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
	[62000601] = {
		Id = 62000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[62000602] = {
		RandomWeight = 10,
		Id = 62000602,
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
	[62000603] = {
		Id = 62000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[62000604] = {
		RandomWeight = 30,
		Id = 62000604,
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
	[62000605] = {
		Id = 62000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[62000606] = {
		Id = 62000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[62000607] = {
		RandomWeight = 10,
		Id = 62000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[62000608] = {
		RandomWeight = 30,
		Id = 62000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[62000611] = {
		Id = 62000611,
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
	[62000612] = {
		RandomWeight = 30,
		Id = 62000612,
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
	[62000613] = {
		Id = 62000613,
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
	[62000614] = {
		RandomWeight = 30,
		Id = 62000614,
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
	[62000615] = {
		Id = 62000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[62000616] = {
		Id = 62000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[62000617] = {
		RandomWeight = 30,
		Id = 62000617,
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
	[62000618] = {
		RandomWeight = 30,
		Id = 62000618,
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
	[62000621] = {
		Id = 62000621,
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
	[62000622] = {
		RandomWeight = 30,
		Id = 62000622,
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
	[62000623] = {
		Id = 62000623,
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
	[62000624] = {
		RandomWeight = 30,
		Id = 62000624,
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
	[62000625] = {
		RandomWeight = 30,
		Id = 62000625,
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
	[62000626] = {
		RandomWeight = 30,
		Id = 62000626,
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
	[62000701] = {
		RandomWeight = 30,
		Id = 62000701,
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
	[62000702] = {
		RandomWeight = 10,
		Id = 62000702,
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
	[62000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 62000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[62000712] = {
		RandomWeight = 10,
		Id = 62000712,
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
	[62000713] = {
		RandomWeight = 10,
		Id = 62000713,
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
	[62000714] = {
		RandomWeight = 10,
		Id = 62000714,
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
	[62000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 62000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[62000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 62000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[62005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 62005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[62005002] = {
		Id = 62005002,
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
	[63000001] = {
		Id = 63000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[63000002] = {
		Id = 63000002,
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
	[63000003] = {
		Id = 63000003,
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
	[63000004] = {
		Id = 63000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[63000005] = {
		Id = 63000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[63000011] = {
		RandomWeight = 10,
		Id = 63000011,
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
	[63000012] = {
		RandomWeight = 10,
		Id = 63000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[63000013] = {
		RandomWeight = 10,
		Id = 63000013,
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
	[63000021] = {
		RandomWeight = 20,
		Id = 63000021,
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
	[63000022] = {
		RandomWeight = 20,
		Id = 63000022,
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
	[63000023] = {
		RandomWeight = 20,
		Id = 63000023,
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
	[63000024] = {
		RandomWeight = 20,
		Id = 63000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[63000025] = {
		RandomWeight = 20,
		Id = 63000025,
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
	[63000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 63000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[63000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 63000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[63000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 63000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[63000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 63000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[63000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 63000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[63000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 63000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[63000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 63000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[63000121] = {
		Id = 63000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[63000122] = {
		Id = 63000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[63000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 63000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[63000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 63000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[63000211] = {
		Id = 63000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[63000212] = {
		RandomWeight = 10,
		Id = 63000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[63000213] = {
		Id = 63000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[63000214] = {
		RandomWeight = 60,
		Id = 63000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[63000221] = {
		RandomWeight = 10,
		Id = 63000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[63000222] = {
		RandomWeight = 20,
		Id = 63000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[63000231] = {
		isDailyAction = true,
		Id = 63000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[63000232] = {
		isDailyAction = true,
		Id = 63000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[63000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 63000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[63000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 63000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[63000311] = {
		Id = 63000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[63000312] = {
		RandomWeight = 10,
		Id = 63000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[63000313] = {
		Id = 63000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[63000314] = {
		RandomWeight = 60,
		Id = 63000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[63000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[63000322] = {
		RandomWeight = 20,
		Id = 63000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[63000331] = {
		isDailyAction = true,
		Id = 63000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[63000332] = {
		isDailyAction = true,
		Id = 63000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[63000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 63000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[63000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 63000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[63000411] = {
		Id = 63000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[63000412] = {
		RandomWeight = 10,
		Id = 63000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[63000413] = {
		Id = 63000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[63000414] = {
		RandomWeight = 60,
		Id = 63000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[63000421] = {
		RandomWeight = 10,
		Id = 63000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[63000422] = {
		RandomWeight = 20,
		Id = 63000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[63000431] = {
		isDailyAction = true,
		Id = 63000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[63000432] = {
		isDailyAction = true,
		Id = 63000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[63000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000501,
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
	[63000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000502,
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
	[63000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[63000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[63000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000511,
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
	[63000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000512,
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
	[63000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[63000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[63000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000521,
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
	[63000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 63000522,
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
	[63000601] = {
		Id = 63000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[63000602] = {
		RandomWeight = 10,
		Id = 63000602,
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
	[63000603] = {
		Id = 63000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[63000604] = {
		RandomWeight = 30,
		Id = 63000604,
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
	[63000605] = {
		Id = 63000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[63000606] = {
		Id = 63000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[63000607] = {
		RandomWeight = 10,
		Id = 63000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[63000608] = {
		RandomWeight = 30,
		Id = 63000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[63000611] = {
		Id = 63000611,
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
	[63000612] = {
		RandomWeight = 30,
		Id = 63000612,
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
	[63000613] = {
		Id = 63000613,
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
	[63000614] = {
		RandomWeight = 30,
		Id = 63000614,
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
	[63000615] = {
		Id = 63000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[63000616] = {
		Id = 63000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[63000617] = {
		RandomWeight = 30,
		Id = 63000617,
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
	[63000618] = {
		RandomWeight = 30,
		Id = 63000618,
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
	[63000621] = {
		Id = 63000621,
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
	[63000622] = {
		RandomWeight = 30,
		Id = 63000622,
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
	[63000623] = {
		Id = 63000623,
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
	[63000624] = {
		RandomWeight = 30,
		Id = 63000624,
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
	[63000625] = {
		RandomWeight = 30,
		Id = 63000625,
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
	[63000626] = {
		RandomWeight = 30,
		Id = 63000626,
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
	[63000701] = {
		RandomWeight = 30,
		Id = 63000701,
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
	[63000702] = {
		RandomWeight = 10,
		Id = 63000702,
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
	[63000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 63000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[63000712] = {
		RandomWeight = 10,
		Id = 63000712,
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
	[63000713] = {
		RandomWeight = 10,
		Id = 63000713,
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
	[63000714] = {
		RandomWeight = 10,
		Id = 63000714,
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
	[63000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 63000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[63000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 63000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[63005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 63005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[63005002] = {
		Id = 63005002,
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
	[64000001] = {
		Id = 64000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[64000002] = {
		Id = 64000002,
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
	[64000003] = {
		Id = 64000003,
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
	[64000004] = {
		Id = 64000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[64000005] = {
		Id = 64000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[64000011] = {
		RandomWeight = 10,
		Id = 64000011,
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
	[64000012] = {
		RandomWeight = 10,
		Id = 64000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[64000013] = {
		RandomWeight = 10,
		Id = 64000013,
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
	[64000021] = {
		RandomWeight = 20,
		Id = 64000021,
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
	[64000022] = {
		RandomWeight = 20,
		Id = 64000022,
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
	[64000023] = {
		RandomWeight = 20,
		Id = 64000023,
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
	[64000024] = {
		RandomWeight = 20,
		Id = 64000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[64000025] = {
		RandomWeight = 20,
		Id = 64000025,
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
	[64000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 64000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[64000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 64000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[64000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 64000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[64000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 64000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[64000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 64000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[64000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 64000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[64000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 64000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[64000121] = {
		Id = 64000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[64000122] = {
		Id = 64000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[64000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 64000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[64000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 64000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[64000211] = {
		Id = 64000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[64000212] = {
		RandomWeight = 10,
		Id = 64000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[64000213] = {
		Id = 64000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[64000214] = {
		RandomWeight = 60,
		Id = 64000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[64000221] = {
		RandomWeight = 10,
		Id = 64000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[64000222] = {
		RandomWeight = 20,
		Id = 64000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[64000231] = {
		isDailyAction = true,
		Id = 64000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[64000232] = {
		isDailyAction = true,
		Id = 64000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[64000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 64000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[64000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 64000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[64000311] = {
		Id = 64000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[64000312] = {
		RandomWeight = 10,
		Id = 64000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[64000313] = {
		Id = 64000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[64000314] = {
		RandomWeight = 60,
		Id = 64000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[64000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[64000322] = {
		RandomWeight = 20,
		Id = 64000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[64000331] = {
		isDailyAction = true,
		Id = 64000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[64000332] = {
		isDailyAction = true,
		Id = 64000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[64000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 64000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[64000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 64000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[64000411] = {
		Id = 64000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[64000412] = {
		RandomWeight = 10,
		Id = 64000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[64000413] = {
		Id = 64000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[64000414] = {
		RandomWeight = 60,
		Id = 64000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[64000421] = {
		RandomWeight = 10,
		Id = 64000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[64000422] = {
		RandomWeight = 20,
		Id = 64000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[64000431] = {
		isDailyAction = true,
		Id = 64000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[64000432] = {
		isDailyAction = true,
		Id = 64000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[64000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000501,
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
	[64000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000502,
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
	[64000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[64000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[64000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000511,
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
	[64000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000512,
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
	[64000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[64000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[64000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000521,
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
	[64000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 64000522,
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
	[64000601] = {
		Id = 64000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[64000602] = {
		RandomWeight = 10,
		Id = 64000602,
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
	[64000603] = {
		Id = 64000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[64000604] = {
		RandomWeight = 30,
		Id = 64000604,
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
	[64000605] = {
		Id = 64000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[64000606] = {
		Id = 64000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[64000607] = {
		RandomWeight = 10,
		Id = 64000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[64000608] = {
		RandomWeight = 30,
		Id = 64000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[64000611] = {
		Id = 64000611,
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
	[64000612] = {
		RandomWeight = 30,
		Id = 64000612,
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
	[64000613] = {
		Id = 64000613,
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
	[64000614] = {
		RandomWeight = 30,
		Id = 64000614,
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
	[64000615] = {
		Id = 64000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[64000616] = {
		Id = 64000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[64000617] = {
		RandomWeight = 30,
		Id = 64000617,
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
	[64000618] = {
		RandomWeight = 30,
		Id = 64000618,
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
	[64000621] = {
		Id = 64000621,
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
	[64000622] = {
		RandomWeight = 30,
		Id = 64000622,
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
	[64000623] = {
		Id = 64000623,
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
	[64000624] = {
		RandomWeight = 30,
		Id = 64000624,
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
	[64000625] = {
		RandomWeight = 30,
		Id = 64000625,
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
	[64000626] = {
		RandomWeight = 30,
		Id = 64000626,
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
	[64000701] = {
		RandomWeight = 30,
		Id = 64000701,
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
	[64000702] = {
		RandomWeight = 10,
		Id = 64000702,
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
	[64000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 64000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[64000712] = {
		RandomWeight = 10,
		Id = 64000712,
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
	[64000713] = {
		RandomWeight = 10,
		Id = 64000713,
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
	[64000714] = {
		RandomWeight = 10,
		Id = 64000714,
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
	[64000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 64000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[64000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 64000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[64005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 64005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[64005002] = {
		Id = 64005002,
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
	[65000001] = {
		Id = 65000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[65000002] = {
		Id = 65000002,
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
	[65000003] = {
		Id = 65000003,
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
	[65000004] = {
		Id = 65000004,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000010
		}
	},
	[65000005] = {
		Id = 65000005,
		RandomWeight = 1000,
		ActionUnitIDList = {
			45000020
		}
	},
	[65000011] = {
		RandomWeight = 10,
		Id = 65000011,
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
	[65000012] = {
		RandomWeight = 10,
		Id = 65000012,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000130
		}
	},
	[65000013] = {
		RandomWeight = 10,
		Id = 65000013,
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
	[65000021] = {
		RandomWeight = 20,
		Id = 65000021,
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
	[65000022] = {
		RandomWeight = 20,
		Id = 65000022,
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
	[65000023] = {
		RandomWeight = 20,
		Id = 65000023,
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
	[65000024] = {
		RandomWeight = 20,
		Id = 65000024,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			45000140
		}
	},
	[65000025] = {
		RandomWeight = 20,
		Id = 65000025,
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
	[65000026] = {
		isDailyAction = true,
		RandomWeight = 30,
		Id = 65000026,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			45000150
		}
	},
	[65000031] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 65000031,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			805
		},
		ActionUnitIDList = {
			45000151
		}
	},
	[65000041] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 65000041,
		SubstituteAction = 45000004,
		ConditionIDList = {
			101,
			806
		},
		ActionUnitIDList = {
			45000152
		}
	},
	[65000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 65000101,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[65000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 65000102,
		ConditionIDList = {
			301,
			401
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[65000111] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 65000111,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000210
		}
	},
	[65000112] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 65000112,
		ConditionIDList = {
			301,
			402
		},
		ActionUnitIDList = {
			45000211
		}
	},
	[65000121] = {
		Id = 65000121,
		RandomWeight = 20,
		ConditionIDList = {
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[65000122] = {
		Id = 65000122,
		RandomWeight = 20,
		ConditionIDList = {
			402
		},
		ActionUnitIDList = {
			105
		}
	},
	[65000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 65000201,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000310
		}
	},
	[65000202] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 65000202,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000300,
			45000311
		}
	},
	[65000211] = {
		Id = 65000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[65000212] = {
		RandomWeight = 10,
		Id = 65000212,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000320
		}
	},
	[65000213] = {
		Id = 65000213,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[65000214] = {
		RandomWeight = 60,
		Id = 65000214,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000321
		}
	},
	[65000221] = {
		RandomWeight = 10,
		Id = 65000221,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000310
		}
	},
	[65000222] = {
		RandomWeight = 20,
		Id = 65000222,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000311
		}
	},
	[65000231] = {
		isDailyAction = true,
		Id = 65000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000330
		}
	},
	[65000232] = {
		isDailyAction = true,
		Id = 65000232,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000331
		}
	},
	[65000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 65000301,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000410
		}
	},
	[65000302] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 65000302,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000400,
			45000411
		}
	},
	[65000311] = {
		Id = 65000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[65000312] = {
		RandomWeight = 10,
		Id = 65000312,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000420
		}
	},
	[65000313] = {
		Id = 65000313,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[65000314] = {
		RandomWeight = 60,
		Id = 65000314,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000421
		}
	},
	[65000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000321,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000410
		}
	},
	[65000322] = {
		RandomWeight = 20,
		Id = 65000322,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000411
		}
	},
	[65000331] = {
		isDailyAction = true,
		Id = 65000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000430
		}
	},
	[65000332] = {
		isDailyAction = true,
		Id = 65000332,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000431
		}
	},
	[65000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 65000401,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000510
		}
	},
	[65000402] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 65000402,
		SubstituteAction = 45000005,
		ActionUnitIDList = {
			45000500,
			45000511
		}
	},
	[65000411] = {
		Id = 65000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[65000412] = {
		RandomWeight = 10,
		Id = 65000412,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000520
		}
	},
	[65000413] = {
		Id = 65000413,
		RandomWeight = 60,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[65000414] = {
		RandomWeight = 60,
		Id = 65000414,
		SubstituteAction = 45000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			45000521
		}
	},
	[65000421] = {
		RandomWeight = 10,
		Id = 65000421,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000510
		}
	},
	[65000422] = {
		RandomWeight = 20,
		Id = 65000422,
		SubstituteAction = 45000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			45000511
		}
	},
	[65000431] = {
		isDailyAction = true,
		Id = 65000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000530
		}
	},
	[65000432] = {
		isDailyAction = true,
		Id = 65000432,
		RandomWeight = 10,
		ActionUnitIDList = {
			45000531
		}
	},
	[65000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000501,
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
	[65000502] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000502,
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
	[65000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000503,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000605,
			45000606
		}
	},
	[65000504] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000504,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000615,
			45000616
		}
	},
	[65000511] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000511,
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
	[65000512] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000512,
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
	[65000513] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000513,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000623,
			45000624
		}
	},
	[65000514] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000514,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000633,
			45000634
		}
	},
	[65000521] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000521,
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
	[65000522] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 65000522,
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
	[65000601] = {
		Id = 65000601,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[65000602] = {
		RandomWeight = 10,
		Id = 65000602,
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
	[65000603] = {
		Id = 65000603,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			101
		}
	},
	[65000604] = {
		RandomWeight = 30,
		Id = 65000604,
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
	[65000605] = {
		Id = 65000605,
		RandomWeight = 10,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000641
		}
	},
	[65000606] = {
		Id = 65000606,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000643
		}
	},
	[65000607] = {
		RandomWeight = 10,
		Id = 65000607,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000640
		}
	},
	[65000608] = {
		RandomWeight = 30,
		Id = 65000608,
		SubstituteAction = 45000605,
		ConditionIDList = {
			300,
			401
		},
		ActionUnitIDList = {
			45000642
		}
	},
	[65000611] = {
		Id = 65000611,
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
	[65000612] = {
		RandomWeight = 30,
		Id = 65000612,
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
	[65000613] = {
		Id = 65000613,
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
	[65000614] = {
		RandomWeight = 30,
		Id = 65000614,
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
	[65000615] = {
		Id = 65000615,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000651
		}
	},
	[65000616] = {
		Id = 65000616,
		RandomWeight = 30,
		ConditionIDList = {
			300,
			402
		},
		ActionUnitIDList = {
			45000653
		}
	},
	[65000617] = {
		RandomWeight = 30,
		Id = 65000617,
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
	[65000618] = {
		RandomWeight = 30,
		Id = 65000618,
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
	[65000621] = {
		Id = 65000621,
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
	[65000622] = {
		RandomWeight = 30,
		Id = 65000622,
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
	[65000623] = {
		Id = 65000623,
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
	[65000624] = {
		RandomWeight = 30,
		Id = 65000624,
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
	[65000625] = {
		RandomWeight = 30,
		Id = 65000625,
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
	[65000626] = {
		RandomWeight = 30,
		Id = 65000626,
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
	[65000701] = {
		RandomWeight = 30,
		Id = 65000701,
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
	[65000702] = {
		RandomWeight = 10,
		Id = 65000702,
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
	[65000711] = {
		SubstituteAction = 45000513,
		RandomWeight = 10,
		Id = 65000711,
		ConditionIDList = {
			301,
			402,
			213
		}
	},
	[65000712] = {
		RandomWeight = 10,
		Id = 65000712,
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
	[65000713] = {
		RandomWeight = 10,
		Id = 65000713,
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
	[65000714] = {
		RandomWeight = 10,
		Id = 65000714,
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
	[65000801] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 65000801,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			45000810,
			45000811,
			45000812,
			45000813
		}
	},
	[65000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 65000802,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			45000820,
			45000821,
			45000822,
			45000823
		}
	},
	[65005001] = {
		isRoomLimit = true,
		RandomWeight = 20,
		Id = 65005001,
		ConditionIDList = {
			1003
		},
		ActionUnitIDList = {
			115
		}
	},
	[65005002] = {
		Id = 65005002,
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
	[100000001] = {
		Id = 100000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[100000002] = {
		Id = 100000002,
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
	[100000003] = {
		Id = 100000003,
		RandomWeight = 100000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[100000004] = {
		Id = 100000004,
		RandomWeight = 100000,
		ActionUnitIDList = {
			100000010
		}
	},
	[100000005] = {
		Id = 100000005,
		RandomWeight = 100000,
		ActionUnitIDList = {
			100000020
		}
	},
	[100000011] = {
		RandomWeight = 10,
		Id = 100000011,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000110,
			100000100,
			100000110,
			100000120
		}
	},
	[100000012] = {
		RandomWeight = 10,
		Id = 100000012,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000130
		}
	},
	[100000013] = {
		RandomWeight = 10,
		Id = 100000013,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000110,
			100000100,
			100000110,
			100000131,
			100000100
		}
	},
	[100000021] = {
		RandomWeight = 20,
		Id = 100000021,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000111,
			100000100,
			100000111,
			100000120
		}
	},
	[100000022] = {
		RandomWeight = 20,
		Id = 100000022,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000112,
			100000100,
			100000112,
			100000120
		}
	},
	[100000023] = {
		RandomWeight = 20,
		Id = 100000023,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000113,
			100000100,
			100000113,
			100000120
		}
	},
	[100000024] = {
		RandomWeight = 20,
		Id = 100000024,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000140
		}
	},
	[100000025] = {
		RandomWeight = 20,
		Id = 100000025,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			100000110,
			100000100,
			100000110,
			100000141,
			100000100
		}
	},
	[100000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 100000026,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			100000150
		}
	},
	[100000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 100000031,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101,
			852
		},
		ActionUnitIDList = {
			100000151
		}
	},
	[100000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 100000041,
		SubstituteAction = 100000004,
		ConditionIDList = {
			101,
			812
		},
		ActionUnitIDList = {
			100000152
		}
	},
	[100000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 100000101,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			100000200
		}
	},
	[100000121] = {
		Id = 100000121,
		RandomWeight = 20,
		ActionUnitIDList = {
			112
		}
	},
	[100000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 100000201,
		SubstituteAction = 100000005,
		ActionUnitIDList = {
			100000300,
			100000310
		}
	},
	[100000211] = {
		Id = 100000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[100000212] = {
		RandomWeight = 10,
		Id = 100000212,
		SubstituteAction = 100000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000320
		}
	},
	[100000221] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 100000221,
		SubstituteAction = 100000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			100000310
		}
	},
	[100000231] = {
		isDailyAction = true,
		Id = 100000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			100000330
		}
	},
	[100000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 100000301,
		SubstituteAction = 100000005,
		ActionUnitIDList = {
			100000400,
			100000410
		}
	},
	[100000311] = {
		Id = 100000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[100000312] = {
		RandomWeight = 10,
		Id = 100000312,
		SubstituteAction = 100000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000420
		}
	},
	[100000321] = {
		RandomWeight = 10,
		Id = 100000321,
		SubstituteAction = 100000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			100000410
		}
	},
	[100000331] = {
		isDailyAction = true,
		Id = 100000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			100000430
		}
	},
	[100000401] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 100000401,
		SubstituteAction = 100000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000500,
			100000501,
			100000502
		}
	},
	[100000403] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 100000403,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000503
		}
	},
	[100000501] = {
		Id = 100000501,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			112
		}
	},
	[100000502] = {
		RandomWeight = 10,
		Id = 100000502,
		SubstituteAction = 100000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000100,
			100000510
		}
	},
	[100000503] = {
		Id = 100000503,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000511
		}
	},
	[100000504] = {
		RandomWeight = 10,
		Id = 100000504,
		SubstituteAction = 100000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000510
		}
	},
	[100000601] = {
		RandomWeight = 30,
		Id = 100000601,
		SubstituteAction = 100000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100000501,
			100000502
		}
	},
	[100000701] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 100000701,
		SubstituteAction = 100000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			100000810,
			100000811,
			100000812,
			100000813
		}
	},
	[100000702] = {
		RandomWeight = 50,
		isDailyAction = true,
		Id = 100000702,
		SubstituteAction = 100000004,
		ActionUnitIDList = {
			100000820,
			100000821,
			100000822,
			100000823
		}
	},
	[100000703] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 100000703,
		SubstituteAction = 100000004,
		ConditionIDList = {
			203
		},
		ActionUnitIDList = {
			100000830,
			100000831,
			100000832,
			100000833
		}
	},
	[200000001] = {
		Id = 200000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[200000002] = {
		Id = 200000002,
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
	[200000003] = {
		Id = 200000003,
		RandomWeight = 200000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[200000004] = {
		Id = 200000004,
		RandomWeight = 200000,
		ActionUnitIDList = {
			200000010
		}
	},
	[200000005] = {
		Id = 200000005,
		RandomWeight = 200000,
		ActionUnitIDList = {
			200000020
		}
	},
	[200000011] = {
		RandomWeight = 10,
		Id = 200000011,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000110,
			200000100,
			200000110,
			200000120
		}
	},
	[200000012] = {
		RandomWeight = 10,
		Id = 200000012,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000130
		}
	},
	[200000013] = {
		RandomWeight = 10,
		Id = 200000013,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000110,
			200000100,
			200000110,
			200000131,
			200000100
		}
	},
	[200000021] = {
		RandomWeight = 20,
		Id = 200000021,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000111,
			200000100,
			200000111,
			200000120
		}
	},
	[200000022] = {
		RandomWeight = 20,
		Id = 200000022,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000112,
			200000100,
			200000112,
			200000120
		}
	},
	[200000023] = {
		RandomWeight = 20,
		Id = 200000023,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000113,
			200000100,
			200000113,
			200000120
		}
	},
	[200000024] = {
		RandomWeight = 20,
		Id = 200000024,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000140
		}
	},
	[200000025] = {
		RandomWeight = 20,
		Id = 200000025,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000110,
			200000100,
			200000110,
			200000141,
			200000100
		}
	},
	[200000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 200000026,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			200000150
		}
	},
	[200000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 200000031,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101,
			851
		},
		ActionUnitIDList = {
			200000151
		}
	},
	[200000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 200000041,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101,
			814
		},
		ActionUnitIDList = {
			200000152
		}
	},
	[200000071] = {
		RandomWeight = 20,
		Id = 200000071,
		SubstituteAction = 200000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			200000170,
			200000171,
			200000172
		}
	},
	[200000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 200000101,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			200000200
		}
	},
	[200000121] = {
		Id = 200000121,
		RandomWeight = 20,
		ActionUnitIDList = {
			112
		}
	},
	[200000201] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 200000201,
		SubstituteAction = 200000005,
		ActionUnitIDList = {
			200000300,
			200000310
		}
	},
	[200000211] = {
		Id = 200000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[200000212] = {
		RandomWeight = 10,
		Id = 200000212,
		SubstituteAction = 200000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000320
		}
	},
	[200000221] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 200000221,
		SubstituteAction = 200000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			200000310
		}
	},
	[200000231] = {
		isDailyAction = true,
		Id = 200000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			200000330
		}
	},
	[200000301] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 200000301,
		SubstituteAction = 200000005,
		ActionUnitIDList = {
			200000400,
			200000410
		}
	},
	[200000311] = {
		Id = 200000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[200000312] = {
		RandomWeight = 10,
		Id = 200000312,
		SubstituteAction = 200000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000420
		}
	},
	[200000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 200000321,
		SubstituteAction = 200000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			200000410
		}
	},
	[200000331] = {
		isDailyAction = true,
		Id = 200000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			200000430
		}
	},
	[200000401] = {
		RandomWeight = 20,
		isDailyAction = true,
		Id = 200000401,
		SubstituteAction = 200000005,
		ActionUnitIDList = {
			200000500,
			200000510
		}
	},
	[200000411] = {
		Id = 200000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			103
		}
	},
	[200000412] = {
		RandomWeight = 10,
		Id = 200000412,
		SubstituteAction = 200000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000520
		}
	},
	[200000421] = {
		RandomWeight = 10,
		Id = 200000421,
		SubstituteAction = 200000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			200000510
		}
	},
	[200000431] = {
		isDailyAction = true,
		Id = 200000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			200000530
		}
	},
	[200000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 200000501,
		SubstituteAction = 200000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000600,
			200000601,
			200000602
		}
	},
	[200000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 200000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000603
		}
	},
	[200000601] = {
		Id = 200000601,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			112
		}
	},
	[200000602] = {
		RandomWeight = 10,
		Id = 200000602,
		SubstituteAction = 200000603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000100,
			200000610,
			200000611
		}
	},
	[200000603] = {
		Id = 200000603,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000611
		}
	},
	[200000604] = {
		RandomWeight = 10,
		Id = 200000604,
		SubstituteAction = 200000603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000610,
			200000611
		}
	},
	[200000701] = {
		RandomWeight = 30,
		Id = 200000701,
		SubstituteAction = 200000603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			200000601,
			200000602
		}
	},
	[200000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 200000802,
		SubstituteAction = 200000004,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			200000820,
			200000821,
			200000822,
			200000823
		}
	},
	[200000803] = {
		RandomWeight = 50,
		isDailyAction = true,
		Id = 200000803,
		SubstituteAction = 200000004,
		ActionUnitIDList = {
			200000830,
			200000831,
			200000832,
			200000833
		}
	},
	[300000001] = {
		Id = 300000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			100
		}
	},
	[300000002] = {
		Id = 300000002,
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
	[300000003] = {
		Id = 300000003,
		RandomWeight = 300000,
		ConditionIDList = {
			103
		},
		ActionUnitIDList = {
			120,
			121,
			122
		}
	},
	[300000004] = {
		Id = 300000004,
		RandomWeight = 300000,
		ActionUnitIDList = {
			300000010
		}
	},
	[300000005] = {
		Id = 300000005,
		RandomWeight = 300000,
		ActionUnitIDList = {
			300000020
		}
	},
	[300000011] = {
		RandomWeight = 10,
		Id = 300000011,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000110,
			300000100,
			300000110,
			300000120
		}
	},
	[300000012] = {
		RandomWeight = 10,
		Id = 300000012,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000130
		}
	},
	[300000013] = {
		RandomWeight = 10,
		Id = 300000013,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000110,
			300000100,
			300000110,
			300000131,
			300000100
		}
	},
	[300000021] = {
		RandomWeight = 20,
		Id = 300000021,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000111,
			300000100,
			300000111,
			300000120
		}
	},
	[300000022] = {
		RandomWeight = 20,
		Id = 300000022,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000112,
			300000100,
			300000112,
			300000120
		}
	},
	[300000023] = {
		RandomWeight = 20,
		Id = 300000023,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000113,
			300000100,
			300000113,
			300000120
		}
	},
	[300000024] = {
		RandomWeight = 20,
		Id = 300000024,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000140
		}
	},
	[300000025] = {
		RandomWeight = 20,
		Id = 300000025,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000110,
			300000100,
			300000110,
			300000141,
			300000100
		}
	},
	[300000026] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 30,
		Id = 300000026,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101,
			901
		},
		ActionUnitIDList = {
			300000150
		}
	},
	[300000031] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 300000031,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101,
			851
		},
		ActionUnitIDList = {
			300000151
		}
	},
	[300000041] = {
		isDailyAction = true,
		isRoomLimit = true,
		RandomWeight = 50,
		Id = 300000041,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101,
			814
		},
		ActionUnitIDList = {
			300000152
		}
	},
	[300000071] = {
		RandomWeight = 20,
		Id = 300000071,
		SubstituteAction = 300000004,
		ConditionIDList = {
			101
		},
		ActionUnitIDList = {
			300000170,
			300000171,
			300000172
		}
	},
	[300000101] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 300000101,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			300000200
		}
	},
	[300000102] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 300000102,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			300000200
		}
	},
	[300000103] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 300000103,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			300000200
		}
	},
	[300000104] = {
		isDailyAction = true,
		RandomWeight = 20,
		Id = 300000104,
		ConditionIDList = {
			301
		},
		ActionUnitIDList = {
			300000200
		}
	},
	[300000105] = {
		Id = 300000105,
		RandomWeight = 10,
		ActionUnitIDList = {
			300000010
		}
	},
	[300000121] = {
		Id = 300000121,
		RandomWeight = 20,
		ActionUnitIDList = {
			100
		}
	},
	[300000211] = {
		Id = 300000211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300000212] = {
		RandomWeight = 10,
		Id = 300000212,
		SubstituteAction = 300000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000320
		}
	},
	[300000221] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300000221,
		SubstituteAction = 300000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			300000310
		}
	},
	[300000231] = {
		isDailyAction = true,
		Id = 300000231,
		RandomWeight = 10,
		ActionUnitIDList = {
			300000330
		}
	},
	[300001211] = {
		Id = 300001211,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300001212] = {
		RandomWeight = 10,
		Id = 300001212,
		SubstituteAction = 300000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001320
		}
	},
	[300001221] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300001221,
		SubstituteAction = 300000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			300001310
		}
	},
	[300001231] = {
		isDailyAction = true,
		Id = 300001231,
		RandomWeight = 10,
		ActionUnitIDList = {
			300001330
		}
	},
	[300000311] = {
		Id = 300000311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300000312] = {
		RandomWeight = 10,
		Id = 300000312,
		SubstituteAction = 300000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000420
		}
	},
	[300000321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300000321,
		SubstituteAction = 300000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			300000410
		}
	},
	[300000331] = {
		isDailyAction = true,
		Id = 300000331,
		RandomWeight = 10,
		ActionUnitIDList = {
			300000430
		}
	},
	[300001311] = {
		Id = 300001311,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300001312] = {
		RandomWeight = 10,
		Id = 300001312,
		SubstituteAction = 300000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001420
		}
	},
	[300001321] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300001321,
		SubstituteAction = 300000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			300001410
		}
	},
	[300001331] = {
		isDailyAction = true,
		Id = 300001331,
		RandomWeight = 10,
		ActionUnitIDList = {
			300001430
		}
	},
	[300000411] = {
		Id = 300000411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300000412] = {
		RandomWeight = 10,
		Id = 300000412,
		SubstituteAction = 300000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000520
		}
	},
	[300000421] = {
		RandomWeight = 10,
		Id = 300000421,
		SubstituteAction = 300000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			300000510
		}
	},
	[300000431] = {
		isDailyAction = true,
		Id = 300000431,
		RandomWeight = 10,
		ActionUnitIDList = {
			300000530
		}
	},
	[300001411] = {
		Id = 300001411,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300001412] = {
		RandomWeight = 10,
		Id = 300001412,
		SubstituteAction = 300000005,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001520
		}
	},
	[300001421] = {
		RandomWeight = 10,
		Id = 300001421,
		SubstituteAction = 300000005,
		ConditionIDList = {
			302
		},
		ActionUnitIDList = {
			300001510
		}
	},
	[300001431] = {
		isDailyAction = true,
		Id = 300001431,
		RandomWeight = 10,
		ActionUnitIDList = {
			300001530
		}
	},
	[300000501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300000501,
		SubstituteAction = 300000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000601,
			300000602
		}
	},
	[300000503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300000503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000603
		}
	},
	[300000601] = {
		Id = 300000601,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300000602] = {
		RandomWeight = 10,
		Id = 300000602,
		SubstituteAction = 300000603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000100,
			300000610
		}
	},
	[300000603] = {
		Id = 300000603,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000611
		}
	},
	[300000604] = {
		RandomWeight = 10,
		Id = 300000604,
		SubstituteAction = 300000603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000610
		}
	},
	[300000701] = {
		RandomWeight = 30,
		Id = 300000701,
		SubstituteAction = 300000603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000601,
			300000602
		}
	},
	[300001501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300001501,
		SubstituteAction = 300001503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001601,
			300001602
		}
	},
	[300001503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300001503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001603
		}
	},
	[300001601] = {
		Id = 300001601,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300001602] = {
		RandomWeight = 10,
		Id = 300001602,
		SubstituteAction = 300001603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000100,
			300001610
		}
	},
	[300001603] = {
		Id = 300001603,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001611
		}
	},
	[300001604] = {
		RandomWeight = 10,
		Id = 300001604,
		SubstituteAction = 300001603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001610
		}
	},
	[300001701] = {
		RandomWeight = 30,
		Id = 300001701,
		SubstituteAction = 300001603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300001601,
			300001602
		}
	},
	[300002501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300002501,
		SubstituteAction = 300002503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300002601,
			300002602
		}
	},
	[300002503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300002503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300002603
		}
	},
	[300002601] = {
		Id = 300002601,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300002602] = {
		RandomWeight = 10,
		Id = 300002602,
		SubstituteAction = 300002603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000100,
			300002610
		}
	},
	[300002603] = {
		Id = 300002603,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300002611
		}
	},
	[300002604] = {
		RandomWeight = 10,
		Id = 300002604,
		SubstituteAction = 300002603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300002610
		}
	},
	[300002701] = {
		RandomWeight = 30,
		Id = 300002701,
		SubstituteAction = 300002603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300002601,
			300002602
		}
	},
	[300003501] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300003501,
		SubstituteAction = 300003503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300003601,
			300003602
		}
	},
	[300003503] = {
		isDailyAction = true,
		RandomWeight = 10,
		Id = 300003503,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300003603
		}
	},
	[300003601] = {
		Id = 300003601,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			100
		}
	},
	[300003602] = {
		RandomWeight = 10,
		Id = 300003602,
		SubstituteAction = 300003603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300000100,
			300003610
		}
	},
	[300003603] = {
		Id = 300003603,
		RandomWeight = 10,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300003611
		}
	},
	[300003604] = {
		RandomWeight = 10,
		Id = 300003604,
		SubstituteAction = 300003603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300003610
		}
	},
	[300003701] = {
		RandomWeight = 30,
		Id = 300003701,
		SubstituteAction = 300003603,
		ConditionIDList = {
			300
		},
		ActionUnitIDList = {
			300003601,
			300003602
		}
	},
	[300000802] = {
		isDailyAction = true,
		RandomWeight = 50,
		Id = 300000802,
		SubstituteAction = 300000004,
		ConditionIDList = {
			201
		},
		ActionUnitIDList = {
			300000831,
			300000832,
			300000833
		}
	},
	[300000803] = {
		Id = 300000803,
		SubstituteAction = 300000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			300000834,
			300000835,
			300000836
		}
	},
	[300000804] = {
		Id = 300000804,
		SubstituteAction = 300000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			300000837,
			300000838,
			300000839
		}
	},
	[400000001] = {
		Id = 400000001,
		RandomWeight = 10,
		ActionUnitIDList = {
			102
		}
	},
	[400000004] = {
		Id = 400000004,
		RandomWeight = 400000,
		ActionUnitIDList = {
			400000010
		}
	},
	[400000005] = {
		Id = 400000005,
		RandomWeight = 400000,
		ActionUnitIDList = {
			400000020
		}
	},
	[400000601] = {
		Id = 400000601,
		RandomWeight = 10,
		ActionUnitIDList = {
			102
		}
	},
	[400000602] = {
		Id = 400000602,
		SubstituteAction = 400000603,
		RandomWeight = 10,
		ActionUnitIDList = {
			400000030,
			400000610
		}
	},
	[400000603] = {
		Id = 400000603,
		RandomWeight = 10,
		ActionUnitIDList = {
			400000611
		}
	},
	[400000604] = {
		Id = 400000604,
		SubstituteAction = 400000603,
		RandomWeight = 10,
		ActionUnitIDList = {
			400000610
		}
	},
	[400000701] = {
		Id = 400000701,
		SubstituteAction = 400000603,
		RandomWeight = 30,
		ActionUnitIDList = {
			400000030,
			400000602
		}
	},
	[400000801] = {
		Id = 400000801,
		RandomWeight = 10,
		ActionUnitIDList = {
			102
		}
	},
	[400000802] = {
		Id = 400000802,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000800,
			400000801,
			400000802
		}
	},
	[400000803] = {
		Id = 400000803,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000020,
			400000010
		}
	},
	[400000811] = {
		Id = 400000811,
		RandomWeight = 10,
		ActionUnitIDList = {
			106
		}
	},
	[400000812] = {
		Id = 400000812,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000810,
			400000801,
			400000802
		}
	},
	[400000821] = {
		Id = 400000821,
		RandomWeight = 10,
		ActionUnitIDList = {
			107
		}
	},
	[400000822] = {
		Id = 400000822,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000820,
			400000801,
			400000802
		}
	},
	[400000831] = {
		Id = 400000831,
		RandomWeight = 10,
		ActionUnitIDList = {
			108
		}
	},
	[400000832] = {
		Id = 400000832,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000830,
			400000801,
			400000802
		}
	},
	[400000841] = {
		Id = 400000841,
		RandomWeight = 10,
		ActionUnitIDList = {
			103
		}
	},
	[400000842] = {
		Id = 400000842,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000840,
			400000801,
			400000802
		}
	},
	[400000851] = {
		Id = 400000851,
		RandomWeight = 10,
		ActionUnitIDList = {
			104
		}
	},
	[400000852] = {
		Id = 400000852,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000850,
			400000801,
			400000802
		}
	},
	[400000861] = {
		Id = 400000861,
		RandomWeight = 10,
		ActionUnitIDList = {
			111
		}
	},
	[400000862] = {
		Id = 400000862,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000860,
			400000801,
			400000802
		}
	},
	[400000871] = {
		Id = 400000871,
		RandomWeight = 10,
		ActionUnitIDList = {
			110
		}
	},
	[400000872] = {
		Id = 400000872,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000870,
			400000801,
			400000802
		}
	},
	[400000881] = {
		Id = 400000881,
		RandomWeight = 10,
		ActionUnitIDList = {
			109
		}
	},
	[400000882] = {
		Id = 400000882,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000880,
			400000801,
			400000802
		}
	},
	[400000891] = {
		Id = 400000891,
		RandomWeight = 10,
		ActionUnitIDList = {
			113
		}
	},
	[400000892] = {
		Id = 400000892,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000890,
			400000801,
			400000802
		}
	},
	[400000901] = {
		Id = 400000901,
		RandomWeight = 10,
		ActionUnitIDList = {
			112
		}
	},
	[400000902] = {
		Id = 400000902,
		SubstituteAction = 400000004,
		RandomWeight = 50,
		ActionUnitIDList = {
			400000900,
			400000801,
			400000802
		}
	}
}

setmetatable(CfgHomeLandActionTable_2, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandActionTable_2]")
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

for i, data in pairs(CfgHomeLandActionTable_2) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandActionTable_2
