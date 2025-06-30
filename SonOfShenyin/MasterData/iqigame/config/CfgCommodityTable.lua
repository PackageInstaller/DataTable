-- chunkname: @IQIGame\\Config\\CfgCommodityTable.lua

local CfgCommodityTable = {
	[50200001] = {
		CommodityType = 1,
		ShopID = 50100000,
		BuyType = 1,
		ItemId = 2,
		IsDouble = true,
		Icon = "/Common/Icon_Currency_Jade1.png",
		AbsoluteValue = 6,
		Number = 6,
		sort = 1,
		Id = 50200001,
		Desc = "玺玉*6元",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		},
		Bonus = {
			60,
			0
		}
	},
	[50200002] = {
		CommodityType = 1,
		ShopID = 50100000,
		BuyType = 1,
		ItemId = 2,
		IsDouble = true,
		Icon = "/Common/Icon_Currency_Jade2.png",
		AbsoluteValue = 30,
		Number = 30,
		sort = 2,
		Id = 50200002,
		Desc = "玺玉*30元",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		},
		Bonus = {
			300,
			0
		}
	},
	[50200003] = {
		CommodityType = 1,
		ShopID = 50100000,
		BuyType = 1,
		ItemId = 2,
		IsDouble = true,
		Icon = "/Common/Icon_Currency_Jade3.png",
		AbsoluteValue = 90,
		Number = 98,
		sort = 3,
		Id = 50200003,
		Desc = "玺玉*98元",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		},
		Bonus = {
			980,
			0
		}
	},
	[50200004] = {
		CommodityType = 1,
		ShopID = 50100000,
		BuyType = 1,
		ItemId = 2,
		IsDouble = true,
		Icon = "/Common/Icon_Currency_Jade4.png",
		AbsoluteValue = 198,
		Number = 198,
		sort = 4,
		Id = 50200004,
		Desc = "玺玉*198元",
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		},
		Bonus = {
			1980,
			0
		}
	},
	[50200005] = {
		CommodityType = 1,
		ShopID = 50100000,
		BuyType = 1,
		ItemId = 2,
		IsDouble = true,
		Icon = "/Common/Icon_Currency_Jade5.png",
		AbsoluteValue = 328,
		Number = 328,
		sort = 5,
		Id = 50200005,
		Desc = "玺玉*328元",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		},
		Bonus = {
			3280,
			0
		}
	},
	[50200006] = {
		CommodityType = 1,
		ShopID = 50100000,
		BuyType = 1,
		ItemId = 2,
		IsDouble = true,
		Icon = "/Common/Icon_Currency_Jade6.png",
		AbsoluteValue = 648,
		Number = 648,
		sort = 6,
		Id = 50200006,
		Desc = "玺玉*648元",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		},
		Bonus = {
			6480,
			0
		}
	},
	[50200101] = {
		CommodityType = 1,
		ShopID = 50100010,
		BuyType = 1,
		ItemId = 1026,
		sort = 101,
		AbsoluteValue = 30,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50200101,
		Desc = "银月特权·30日月卡",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000131
		}
	},
	[50200201] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 3:59",
		Time = 1,
		ShopID = 50100020,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 600013,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50200201,
		Desc = "白玫瑰的拥抱",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50200202] = {
		CommodityType = 1,
		ShopID = 50100020,
		BuyType = 1,
		ItemId = 600093,
		Time = 1,
		AbsoluteValue = 68,
		Number = 1,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50200202,
		Desc = "夏日浪淘",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			40011002
		}
	},
	[50200203] = {
		CommodityType = 1,
		ShopID = 50100020,
		BuyType = 1,
		ItemId = 600014,
		Time = 1,
		AbsoluteValue = 68,
		Number = 1,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50200203,
		Desc = "星海轻语",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			40011001
		}
	},
	[50201001] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61011,
		Free = true,
		sort = 1,
		Number = 1,
		Time = 1,
		Id = 50201001,
		Desc = "成长好礼·5级",
		BuyConditionId = {
			30000005
		}
	},
	[50201002] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61012,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000301,
		Time = 1,
		Id = 50201002,
		Desc = "成长好礼·10级",
		BuyConditionId = {
			30000010
		}
	},
	[50201003] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61013,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000302,
		Time = 1,
		Id = 50201003,
		Desc = "成长好礼·15级",
		BuyConditionId = {
			30000015
		}
	},
	[50201004] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61014,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000303,
		Time = 1,
		Id = 50201004,
		Desc = "成长好礼·20级",
		BuyConditionId = {
			30000020
		}
	},
	[50201005] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61015,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000304,
		Time = 1,
		Id = 50201005,
		Desc = "成长好礼·25级",
		BuyConditionId = {
			30000025
		}
	},
	[50201006] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61016,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000305,
		Time = 1,
		Id = 50201006,
		Desc = "成长好礼·30级",
		BuyConditionId = {
			30000030
		}
	},
	[50201007] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61017,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000306,
		Time = 1,
		Id = 50201007,
		Desc = "成长好礼·35级",
		BuyConditionId = {
			30000035
		}
	},
	[50201008] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 2,
		ItemId = 61018,
		Free = true,
		sort = 1,
		Number = 1,
		UnlockConditionId = 30000307,
		Time = 1,
		Id = 50201008,
		Desc = "成长好礼·40级",
		BuyConditionId = {
			30000040
		}
	},
	[50201009] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61301,
		Time = 2,
		sort = 1,
		AbsoluteValue = 6,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50201009,
		Desc = "招揽特惠·小",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50201010] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61302,
		Time = 2,
		sort = 1,
		AbsoluteValue = 18,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50201010,
		Desc = "招揽特惠·中",
		Price = {
			{
				1,
				1800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50201011] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61303,
		Time = 2,
		sort = 1,
		AbsoluteValue = 30,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50201011,
		Desc = "超值晋级礼盒",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50201012] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61304,
		Time = 2,
		sort = 1,
		AbsoluteValue = 38,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50201012,
		Desc = "招揽特惠·大",
		Price = {
			{
				1,
				3800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50201013] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61305,
		Time = 6,
		sort = 1,
		AbsoluteValue = 68,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50201013,
		Desc = "超值扩张礼盒",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50201014] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61306,
		Time = 6,
		sort = 1,
		AbsoluteValue = 128,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50201014,
		Desc = "超值综合礼盒Ⅰ",
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202001] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 1,
		ResetType = 4,
		AbsoluteValue = 6,
		Number = 1,
		ItemId = 61701,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202001,
		Desc = "幸运礼盒",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202002] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 1,
		ResetType = 4,
		AbsoluteValue = 18,
		Number = 1,
		ItemId = 61702,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202002,
		Desc = "福气招来礼盒",
		Price = {
			{
				1,
				1800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202003] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 1,
		ResetType = 4,
		AbsoluteValue = 38,
		Number = 1,
		ItemId = 61703,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202003,
		Desc = "春日特招礼盒",
		Price = {
			{
				1,
				3800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202004] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 1,
		ResetType = 4,
		AbsoluteValue = 38,
		Number = 1,
		ItemId = 61704,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202004,
		Desc = "春日珍藏礼盒",
		Price = {
			{
				1,
				3800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202005] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 98,
		Number = 1,
		ItemId = 61705,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202005,
		Desc = "心想事成礼盒",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202006] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 168,
		Number = 1,
		ItemId = 61706,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202006,
		Desc = "合家欢乐·壹",
		Price = {
			{
				1,
				16800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202007] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 128,
		Number = 1,
		ItemId = 61707,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202007,
		Desc = "合家欢乐·贰",
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202008] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 268,
		Number = 1,
		ItemId = 61708,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202008,
		Desc = "金玉满堂礼盒",
		Price = {
			{
				1,
				26800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202009] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61709,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202009,
		Desc = "瑞蛇启新·壹",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202010] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61710,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202010,
		Desc = "瑞蛇启新·贰",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202011] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 648,
		Number = 1,
		ItemId = 61711,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202011,
		Desc = "蛇年大吉",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202101] = {
		CommodityType = 1,
		BuyType = 1,
		ItemId = 1039,
		sort = 1,
		TimeOvrtShow = 1,
		AbsoluteValue = 6,
		Number = 1,
		Id = 50202101,
		Desc = "黄泉石周卡",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202102] = {
		CommodityType = 1,
		OpenTime = "2025/4/9 4:00",
		BuyType = 1,
		CloseTime = "2025/5/9 3:59",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 6,
		Number = 1,
		ItemId = 61801,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202102,
		Desc = "春暖花开礼盒",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202103] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 6,
		Number = 1,
		ItemId = 61807,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202103,
		Desc = "喜迎五一礼盒",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202104] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 6,
		Number = 1,
		ItemId = 61804,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202104,
		Desc = "初遇礼箱",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202105] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 6,
		Number = 1,
		ItemId = 61805,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202105,
		Desc = "初遇宝箱",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202151] = {
		CommodityType = 1,
		OpenTime = "2025/4/9 4:00",
		BuyType = 1,
		CloseTime = "2025/5/9 3:59",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 30,
		Number = 1,
		ItemId = 61802,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202151,
		Desc = "神觉招来礼盒Ⅰ",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202152] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 30,
		Number = 1,
		ItemId = 61808,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202152,
		Desc = "水月降神礼盒Ⅰ",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202153] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 30,
		Number = 1,
		ItemId = 61808,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202153,
		Desc = "七光礼包2",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202154] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 30,
		Number = 1,
		ItemId = 61809,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202154,
		Desc = "七光礼包3",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202155] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 30,
		Number = 1,
		ItemId = 61810,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202155,
		Desc = "七光礼包4",
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202201] = {
		CommodityType = 1,
		ShopID = 50100220,
		ItemId = 60005,
		Time = 1,
		sort = 1,
		AbsoluteValue = 68,
		Number = 1,
		BuyType = 1,
		Id = 50202201,
		Desc = "等级通行证1期会员",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202202] = {
		CommodityType = 1,
		OpenTime = "2025/4/9 4:00",
		BuyType = 1,
		CloseTime = "2025/5/9 3:59",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61803,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202202,
		Desc = "神觉招来礼盒Ⅱ",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202203] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61809,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202203,
		Desc = "水月降神礼盒Ⅱ",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202204] = {
		CommodityType = 1,
		ShopID = 50100020,
		BuyType = 1,
		ItemId = 600163,
		Time = 1,
		AbsoluteValue = 68,
		Number = 1,
		sort = 1,
		TimeOvrtShow = 1,
		Id = 50202204,
		Desc = "无念·心念漂流",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			40011004
		}
	},
	[50202205] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61815,
		sort = 215,
		TimeOvrtShow = 1,
		Id = 50202205,
		Desc = "欧皇礼盒",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202206] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61816,
		sort = 216,
		TimeOvrtShow = 1,
		Id = 50202206,
		Desc = "萌新冒险箱",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202207] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61817,
		sort = 217,
		TimeOvrtShow = 1,
		Id = 50202207,
		Desc = "星辉闪耀",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202208] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61818,
		sort = 218,
		TimeOvrtShow = 1,
		Id = 50202208,
		Desc = "星辉闪耀1",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202209] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61819,
		sort = 219,
		TimeOvrtShow = 1,
		Id = 50202209,
		Desc = "星辉闪耀2",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202210] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 68,
		Number = 1,
		ItemId = 61820,
		sort = 220,
		TimeOvrtShow = 1,
		Id = 50202210,
		Desc = "星辉闪耀3",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202251] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 98,
		Number = 1,
		ItemId = 61712,
		sort = 106,
		TimeOvrtShow = 1,
		Id = 50202251,
		Desc = "欧气祈愿礼盒",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202252] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 98,
		Number = 1,
		ItemId = 61822,
		sort = 222,
		TimeOvrtShow = 1,
		Id = 50202252,
		Desc = "银蛇限定礼包1",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202253] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 98,
		Number = 1,
		ItemId = 61823,
		sort = 223,
		TimeOvrtShow = 1,
		Id = 50202253,
		Desc = "银蛇限定礼包2",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202254] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 98,
		Number = 1,
		ItemId = 61824,
		sort = 224,
		TimeOvrtShow = 1,
		Id = 50202254,
		Desc = "银蛇限定礼包3",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202255] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 98,
		Number = 1,
		ItemId = 61825,
		sort = 225,
		TimeOvrtShow = 1,
		Id = 50202255,
		Desc = "银蛇限定礼包4",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202301] = {
		CommodityType = 1,
		ShopID = 50100220,
		ItemId = 60006,
		Time = 1,
		AbsoluteValue = 128,
		Number = 1,
		BuyType = 1,
		Id = 50202301,
		Desc = "等级通行证2期会员",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202302] = {
		CommodityType = 1,
		ShopID = 50100042,
		BuyType = 1,
		CloseTime = "2025/4/8 3:59",
		Time = 3,
		ResetType = 4,
		AbsoluteValue = 128,
		Number = 1,
		ItemId = 61713,
		sort = 109,
		TimeOvrtShow = 1,
		Id = 50202302,
		Desc = "合家欢乐·叁",
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202303] = {
		CommodityType = 1,
		ShopID = 50100041,
		BuyType = 1,
		ItemId = 61307,
		Time = 6,
		sort = 107,
		AbsoluteValue = 128,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50202303,
		Desc = "超值综合礼盒Ⅱ",
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202304] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 128,
		Number = 1,
		ItemId = 61810,
		sort = 229,
		TimeOvrtShow = 1,
		Id = 50202304,
		Desc = "水月鬼武礼盒Ⅰ",
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202305] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 128,
		Number = 1,
		ItemId = 61830,
		sort = 230,
		TimeOvrtShow = 1,
		Id = 50202305,
		Desc = "魂玉礼包2",
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202351] = {
		CommodityType = 1,
		OpenTime = "2025/4/9 4:00",
		BuyType = 1,
		CloseTime = "2025/5/9 3:59",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 198,
		Number = 1,
		ItemId = 61804,
		sort = 231,
		TimeOvrtShow = 1,
		Id = 50202351,
		Desc = "鬼神之遇礼盒Ⅰ",
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202352] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 198,
		Number = 1,
		ItemId = 61811,
		sort = 232,
		TimeOvrtShow = 1,
		Id = 50202352,
		Desc = "水月鬼武礼盒Ⅱ",
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202353] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 198,
		Number = 1,
		ItemId = 61833,
		sort = 233,
		TimeOvrtShow = 1,
		Id = 50202353,
		Desc = "卡卡福袋3",
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202354] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 198,
		Number = 1,
		ItemId = 61834,
		sort = 234,
		TimeOvrtShow = 1,
		Id = 50202354,
		Desc = "卡卡福袋4",
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202355] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 198,
		Number = 1,
		ItemId = 61835,
		sort = 235,
		TimeOvrtShow = 1,
		Id = 50202355,
		Desc = "卡卡福袋5",
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202401] = {
		CommodityType = 1,
		OpenTime = "2025/4/9 4:00",
		BuyType = 1,
		CloseTime = "2025/5/9 3:59",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61805,
		sort = 236,
		TimeOvrtShow = 1,
		Id = 50202401,
		Desc = "鬼神之遇礼盒Ⅱ",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202402] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61837,
		sort = 237,
		TimeOvrtShow = 1,
		Id = 50202402,
		Desc = "春季优惠礼包2_计费点IOS占用",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202403] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61812,
		sort = 238,
		TimeOvrtShow = 1,
		Id = 50202403,
		Desc = "迎夏心神礼盒Ⅰ",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202404] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61839,
		sort = 239,
		TimeOvrtShow = 1,
		Id = 50202404,
		Desc = "春季优惠礼包4",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202405] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 328,
		Number = 1,
		ItemId = 61840,
		sort = 240,
		TimeOvrtShow = 1,
		Id = 50202405,
		Desc = "春季优惠礼包5",
		Price = {
			{
				1,
				32800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202451] = {
		CommodityType = 1,
		OpenTime = "2025/4/9 4:00",
		BuyType = 1,
		CloseTime = "2025/5/9 3:59",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 648,
		Number = 1,
		ItemId = 61806,
		sort = 241,
		TimeOvrtShow = 1,
		Id = 50202451,
		Desc = "鬼神之遇礼盒Ⅲ",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202452] = {
		CommodityType = 1,
		OpenTime = "2025/4/30 4:00",
		BuyType = 1,
		CloseTime = "2025/5/30 3:59",
		Time = 5,
		ShopID = 50100042,
		AbsoluteValue = 648,
		Number = 1,
		ItemId = 61813,
		sort = 242,
		TimeOvrtShow = 1,
		Id = 50202452,
		Desc = "迎夏心神礼盒Ⅱ",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202453] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 648,
		Number = 1,
		ItemId = 61843,
		sort = 243,
		TimeOvrtShow = 1,
		Id = 50202453,
		Desc = "玺玉招募箱",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202454] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 648,
		Number = 1,
		ItemId = 61844,
		sort = 244,
		TimeOvrtShow = 1,
		Id = 50202454,
		Desc = "玺玉招募福袋",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50202455] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 1,
		CloseTime = "2024/7/18 4:00",
		Time = 1,
		ShopID = 50100042,
		AbsoluteValue = 648,
		Number = 1,
		ItemId = 61845,
		sort = 245,
		TimeOvrtShow = 1,
		Id = 50202455,
		Desc = "玺玉招募欧盒",
		Price = {
			{
				1,
				64800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50203000] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 2,
		ItemId = 61001,
		Free = true,
		sort = 101,
		ResetType = 1,
		Number = 1,
		TimeOvrtShow = 1,
		Time = 1,
		Id = 50203000,
		Desc = "每日赠礼"
	},
	[50203001] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 1,
		ItemId = 61501,
		Time = 5,
		ResetType = 2,
		AbsoluteValue = 6,
		Number = 1,
		sort = 101,
		TimeOvrtShow = 1,
		Id = 50203001,
		Desc = "每周幸运礼盒",
		Price = {
			{
				1,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50203002] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 1,
		ItemId = 61502,
		Time = 10,
		ResetType = 2,
		AbsoluteValue = 9,
		Number = 1,
		sort = 102,
		TimeOvrtShow = 1,
		Id = 50203002,
		Desc = "金契特惠组合Ⅰ",
		Price = {
			{
				1,
				900
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50203003] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 1,
		ItemId = 61503,
		Time = 2,
		ResetType = 2,
		AbsoluteValue = 18,
		Number = 1,
		sort = 103,
		TimeOvrtShow = 1,
		Id = 50203003,
		Desc = "金契特惠组合Ⅱ",
		Price = {
			{
				1,
				1800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50203004] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 1,
		ItemId = 61504,
		Time = 2,
		ResetType = 2,
		AbsoluteValue = 38,
		Number = 1,
		sort = 104,
		TimeOvrtShow = 1,
		Id = 50203004,
		Desc = "金契特惠组合Ⅲ",
		Price = {
			{
				1,
				3800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50203005] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 1,
		ItemId = 61505,
		Time = 3,
		ResetType = 2,
		AbsoluteValue = 68,
		Number = 1,
		sort = 105,
		TimeOvrtShow = 1,
		Id = 50203005,
		Desc = "金契特惠组合Ⅳ",
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50203006] = {
		CommodityType = 1,
		ShopID = 50100043,
		BuyType = 1,
		ItemId = 61506,
		Time = 3,
		ResetType = 3,
		AbsoluteValue = 98,
		Number = 1,
		sort = 106,
		TimeOvrtShow = 1,
		Id = 50203006,
		Desc = "神觉计划礼盒",
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204001] = {
		CommodityType = 1,
		OpenTime = "2024/6/18 4:00",
		BuyType = 2,
		CloseTime = "2024/7/18 4:00",
		ShopID = 50100044,
		ItemId = 1100,
		sort = 200,
		Number = 1,
		Id = 50204001,
		Desc = "改名卡",
		Price = {
			{
				2,
				20
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204002] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61071,
		Time = 1,
		sort = 101,
		Number = 1,
		Id = 50204002,
		Desc = "豪华护航·5级",
		Price = {
			{
				2,
				50
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000005
		}
	},
	[50204003] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61072,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000361,
		Id = 50204003,
		Desc = "豪华护航·10级",
		Price = {
			{
				2,
				50
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000010
		}
	},
	[50204004] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61073,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000362,
		Id = 50204004,
		Desc = "豪华护航·15级",
		Price = {
			{
				2,
				60
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000015
		}
	},
	[50204005] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61074,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000363,
		Id = 50204005,
		Desc = "豪华护航·20级",
		Price = {
			{
				2,
				60
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000020
		}
	},
	[50204006] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61075,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000364,
		Id = 50204006,
		Desc = "豪华护航·25级",
		Price = {
			{
				2,
				65
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000025
		}
	},
	[50204007] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61076,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000365,
		Id = 50204007,
		Desc = "豪华护航·30级",
		Price = {
			{
				2,
				65
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000030
		}
	},
	[50204008] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61077,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000366,
		Id = 50204008,
		Desc = "豪华护航·35级",
		Price = {
			{
				2,
				70
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000035
		}
	},
	[50204009] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61078,
		Time = 1,
		sort = 101,
		Number = 1,
		UnlockConditionId = 30000367,
		Id = 50204009,
		Desc = "豪华护航·40级",
		Price = {
			{
				2,
				70
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000040
		}
	},
	[50204010] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61201,
		Time = 5,
		sort = 150,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204010,
		Desc = "情谊永存",
		Price = {
			{
				2,
				30
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204011] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61202,
		Time = 3,
		sort = 111,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204011,
		Desc = "突破精进·神觉",
		Price = {
			{
				2,
				30
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204012] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61220,
		Time = 1,
		sort = 122,
		ResetType = 1,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204012,
		Desc = "定向特招·少量",
		Price = {
			{
				2,
				6
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204013] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61211,
		Time = 1,
		sort = 121,
		ResetType = 1,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204013,
		Desc = "人才特招·少量",
		Price = {
			{
				2,
				6
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204014] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61212,
		Time = 1,
		sort = 123,
		ResetType = 1,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204014,
		Desc = "鬼武珍藏·少量",
		Price = {
			{
				2,
				6
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204015] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61213,
		Time = 2,
		sort = 124,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204015,
		Desc = "人才特招·中量",
		Price = {
			{
				2,
				60
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204016] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61214,
		Time = 2,
		sort = 126,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204016,
		Desc = "鬼武珍藏·中量",
		Price = {
			{
				2,
				60
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204017] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61215,
		Time = 1,
		sort = 127,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204017,
		Desc = "扩员计划·大量",
		Price = {
			{
				2,
				180
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204018] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61216,
		Time = 3,
		sort = 129,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204018,
		Desc = "人才特招·大量",
		Price = {
			{
				2,
				180
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204019] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61217,
		Time = 3,
		sort = 130,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204019,
		Desc = "鬼武珍藏·大量",
		Price = {
			{
				2,
				180
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204020] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61218,
		sort = 132,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50204020,
		Desc = "鬼武珍藏·豪华",
		Price = {
			{
				2,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204021] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61219,
		sort = 131,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50204021,
		Desc = "人才特招·豪华",
		Price = {
			{
				2,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204022] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61221,
		Time = 2,
		sort = 125,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204022,
		Desc = "定向特招·中量",
		Price = {
			{
				2,
				60
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204023] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 61222,
		Time = 3,
		sort = 128,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50204023,
		Desc = "定向特招·大量",
		Price = {
			{
				2,
				180
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204024] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 60135,
		Time = 5,
		sort = 111,
		ResetType = 1,
		Number = 1,
		Id = 50204024,
		Desc = "千髓礼包",
		Price = {
			{
				2,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50204025] = {
		CommodityType = 1,
		ShopID = 50100044,
		BuyType = 2,
		ItemId = 60136,
		sort = 111,
		Number = 1,
		Id = 50204025,
		Desc = "灵髓礼包",
		Price = {
			{
				2,
				50
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205001] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 3000,
		sort = 103,
		Number = 1,
		Id = 50205001,
		Desc = "神觉银契",
		Price = {
			{
				3,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205002] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 3001,
		sort = 101,
		Number = 1,
		Id = 50205002,
		Desc = "神觉金契",
		Price = {
			{
				3,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205003] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 3003,
		sort = 102,
		Number = 1,
		Id = 50205003,
		Desc = "鬼武专契",
		Price = {
			{
				3,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205004] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 3004,
		sort = 104,
		Number = 1,
		Id = 50205004,
		Desc = "神觉专契",
		Price = {
			{
				3,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205011] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61101,
		Time = 2,
		sort = 112,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50205011,
		Desc = "修行佳品·命",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205012] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61102,
		Time = 2,
		sort = 113,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50205012,
		Desc = "修行佳品·理",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205013] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61103,
		Time = 2,
		sort = 114,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50205013,
		Desc = "修行佳品·定",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50205101] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61041,
		Time = 1,
		sort = 110,
		Number = 1,
		Id = 50205101,
		Desc = "经营助力·5级",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000005
		}
	},
	[50205102] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61042,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000331,
		Id = 50205102,
		Desc = "经营助力·10级",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000010
		}
	},
	[50205103] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61043,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000332,
		Id = 50205103,
		Desc = "经营助力·15级",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000015
		}
	},
	[50205104] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61044,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000333,
		Id = 50205104,
		Desc = "经营助力·20级",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000020
		}
	},
	[50205105] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61045,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000334,
		Id = 50205105,
		Desc = "经营助力·25级",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000025
		}
	},
	[50205106] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61046,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000335,
		Id = 50205106,
		Desc = "经营助力·30级",
		Price = {
			{
				3,
				1000
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000030
		}
	},
	[50205107] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61047,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000336,
		Id = 50205107,
		Desc = "经营助力·35级",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000035
		}
	},
	[50205108] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 61048,
		Time = 1,
		sort = 110,
		Number = 1,
		UnlockConditionId = 30000337,
		Id = 50205108,
		Desc = "经营助力·40级",
		Price = {
			{
				3,
				1600
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30000040
		}
	},
	[50205109] = {
		CommodityType = 1,
		ShopID = 50100045,
		BuyType = 2,
		ItemId = 60135,
		Time = 10,
		sort = 111,
		ResetType = 2,
		Number = 1,
		Id = 50205109,
		Desc = "千髓礼包",
		Price = {
			{
				3,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50206001] = {
		ItemId = 3,
		CommodityType = 1,
		ShopID = 50100200,
		Desc = "玺玉兑换黄泉石，1:10比例换免费钻",
		Id = 50206001,
		BuyType = 2,
		Number = 10,
		Price = {
			{
				2,
				1
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50206011] = {
		CommodityType = 1,
		ShopID = 50100210,
		BuyType = 2,
		ItemId = 11,
		Time = 5,
		TimeOvrtShow = 1,
		ResetType = 1,
		Number = 60,
		Id = 50206011,
		Desc = "体力*60",
		Price = {
			{
				3,
				60
			},
			{
				3,
				80
			},
			{
				3,
				120
			},
			{
				3,
				160
			},
			{
				3,
				180
			},
			{}
		}
	},
	[50206021] = {
		CommodityType = 1,
		ShopID = 50100220,
		ItemId = 60001,
		AbsoluteValue = 68,
		Number = 1,
		BuyType = 1,
		Id = 50206021,
		Desc = "通行证：初级普通会员",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				6800
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30070102
		}
	},
	[50206022] = {
		CommodityType = 1,
		ShopID = 50100220,
		ItemId = 60002,
		AbsoluteValue = 98,
		Number = 1,
		BuyType = 1,
		Id = 50206022,
		Desc = "通行证：高级高级会员",
		Discount = {
			1,
			2
		},
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30070102
		}
	},
	[50206023] = {
		CommodityType = 1,
		ShopID = 50100220,
		ItemId = 60003,
		AbsoluteValue = 30,
		Number = 1,
		BuyType = 1,
		Id = 50206023,
		Desc = "通行证：升高级会员差价",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30070102
		}
	},
	[50206024] = {
		CommodityType = 1,
		ShopID = 50100220,
		BuyType = 2,
		ItemId = 103,
		Number = 500,
		Id = 50206024,
		Desc = "等级1级-经验*500",
		Price = {
			{
				3,
				150
			},
			{},
			{},
			{},
			{},
			{}
		},
		BuyConditionId = {
			30070102,
			30000121
		}
	},
	[50206031] = {
		CommodityType = 1,
		BuyType = 1,
		ItemId = 60005,
		AbsoluteValue = 128,
		Number = 1,
		Id = 50206031,
		Desc = "等级通行证1期会员-废弃",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				12800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50206032] = {
		CommodityType = 1,
		BuyType = 1,
		ItemId = 60006,
		AbsoluteValue = 198,
		Number = 1,
		Id = 50206032,
		Desc = "等级通行证2期会员-废弃",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				19800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50206033] = {
		CommodityType = 1,
		BuyType = 1,
		ItemId = 60007,
		AbsoluteValue = 98,
		Number = 1,
		Id = 50206033,
		Desc = "主线通行证会员-废弃",
		Discount = {
			1,
			1
		},
		Price = {
			{
				1,
				9800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210001] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15031,
		Time = 1,
		sort = 100,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210001,
		Desc = "鬼神心核·真",
		Price = {
			{
				12,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210002] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 3000,
		Time = 10,
		sort = 102,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210002,
		Desc = "神觉银契",
		Price = {
			{
				12,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210003] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 3001,
		Time = 10,
		sort = 101,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210003,
		Desc = "神觉金契",
		Price = {
			{
				12,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210004] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 3003,
		Time = 10,
		sort = 103,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210004,
		Desc = "鬼武专契",
		Price = {
			{
				12,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210005] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15000,
		Time = 1,
		sort = 104,
		ResetType = 3,
		Number = 1,
		Id = 50210005,
		Desc = "天照命晶",
		Price = {
			{
				12,
				100
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210007] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15001,
		Time = 10,
		sort = 113,
		ResetType = 3,
		Number = 20,
		Id = 50210007,
		Desc = "风缕之晶",
		Price = {
			{
				12,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210008] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15002,
		Time = 10,
		sort = 114,
		ResetType = 3,
		Number = 20,
		Id = 50210008,
		Desc = "灼燃之晶",
		Price = {
			{
				12,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210009] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15003,
		Time = 10,
		sort = 115,
		ResetType = 3,
		Number = 20,
		Id = 50210009,
		Desc = "震霄之晶",
		Price = {
			{
				12,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210010] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15004,
		Time = 10,
		sort = 116,
		ResetType = 3,
		Number = 20,
		Id = 50210010,
		Desc = "涡流之晶",
		Price = {
			{
				12,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210011] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15011,
		Time = 15,
		sort = 117,
		ResetType = 3,
		Number = 20,
		Id = 50210011,
		Desc = "守之印",
		Price = {
			{
				12,
				4
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210012] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15012,
		Time = 15,
		sort = 118,
		ResetType = 3,
		Number = 20,
		Id = 50210012,
		Desc = "斗之印",
		Price = {
			{
				12,
				4
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210013] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15013,
		Time = 15,
		sort = 119,
		ResetType = 3,
		Number = 20,
		Id = 50210013,
		Desc = "术之印",
		Price = {
			{
				12,
				4
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210014] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15014,
		Time = 15,
		sort = 120,
		ResetType = 3,
		Number = 20,
		Id = 50210014,
		Desc = "诡之印",
		Price = {
			{
				12,
				4
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210015] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 15021,
		Time = 20,
		sort = 121,
		ResetType = 3,
		Number = 30,
		Id = 50210015,
		Desc = "破封血刃",
		Price = {
			{
				12,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210016] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 4,
		Time = 10,
		sort = 122,
		ResetType = 2,
		Number = 100000,
		Id = 50210016,
		Desc = "札币",
		Price = {
			{
				12,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210017] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 4,
		sort = 123,
		Number = 100000,
		Id = 50210017,
		Desc = "札币",
		Price = {
			{
				12,
				15
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210018] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 50041,
		Time = 4,
		sort = 110,
		ResetType = 2,
		Number = 5,
		TimeOvrtShow = 1,
		Id = 50210018,
		Desc = "千变灵髓",
		Price = {
			{
				12,
				50
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210019] = {
		CommodityType = 1,
		ShopID = 50101001,
		BuyType = 2,
		ItemId = 50042,
		Time = 5,
		sort = 105,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210019,
		Desc = "万化灵髓",
		Price = {
			{
				12,
				100
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210101] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 15000,
		Time = 1,
		sort = 1,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210101,
		Desc = "天照命晶",
		Price = {
			{
				14,
				100
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210102] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 15032,
		Time = 3,
		sort = 2,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210102,
		Desc = "鬼神心核·伪",
		Price = {
			{
				14,
				80
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210103] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 60123,
		Time = 10,
		sort = 5,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210103,
		Desc = "四星鬼武",
		Price = {
			{
				14,
				60
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210104] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 60125,
		Time = 10,
		sort = 6,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210104,
		Desc = "四星鬼武-攻",
		Price = {
			{
				14,
				80
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210105] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 50002,
		Time = 30,
		sort = 7,
		ResetType = 3,
		Number = 8,
		TimeOvrtShow = 1,
		Id = 50210105,
		Desc = "阴阳秘文·残页",
		Price = {
			{
				14,
				2
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210106] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 50032,
		Time = 30,
		sort = 8,
		ResetType = 3,
		Number = 3,
		TimeOvrtShow = 1,
		Id = 50210106,
		Desc = "神宗鬼卷·注卷",
		Price = {
			{
				14,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210107] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 4,
		Time = 20,
		sort = 9,
		ResetType = 3,
		Number = 100000,
		TimeOvrtShow = 1,
		Id = 50210107,
		Desc = "札币",
		Price = {
			{
				14,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210108] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 4,
		sort = 10,
		TimeOvrtShow = 1,
		Number = 100000,
		Id = 50210108,
		Desc = "札币",
		Price = {
			{
				14,
				15
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210109] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 50041,
		Time = 4,
		sort = 4,
		ResetType = 2,
		Number = 5,
		TimeOvrtShow = 1,
		Id = 50210109,
		Desc = "千变灵髓",
		Price = {
			{
				14,
				50
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210110] = {
		CommodityType = 1,
		ShopID = 50101002,
		BuyType = 2,
		ItemId = 50042,
		Time = 5,
		sort = 3,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210110,
		Desc = "万化灵髓",
		Price = {
			{
				14,
				100
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210301] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 15000,
		Time = 2,
		sort = 101,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210301,
		Desc = "天照命晶",
		Price = {
			{
				115,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210303] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 60122,
		Time = 1,
		sort = 100,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210303,
		Desc = "五星鬼神（随机）",
		Price = {
			{
				115,
				4000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210304] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 15032,
		Time = 2,
		sort = 103,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210304,
		Desc = "鬼神心核·伪",
		Price = {
			{
				115,
				1000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210305] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 16004,
		Time = 5,
		sort = 105,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210305,
		Desc = "高级料理",
		Price = {
			{
				115,
				30
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210306] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 16002,
		Time = 20,
		sort = 106,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210306,
		Desc = "宝箱巧克力",
		Price = {
			{
				115,
				5
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210307] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 50004,
		Time = 5,
		sort = 104,
		ResetType = 2,
		Number = 2,
		TimeOvrtShow = 1,
		Id = 50210307,
		Desc = "阴阳秘文·完本",
		Price = {
			{
				115,
				20
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210308] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 50003,
		Time = 10,
		sort = 107,
		ResetType = 2,
		Number = 10,
		TimeOvrtShow = 1,
		Id = 50210308,
		Desc = "阴阳秘文·断章",
		Price = {
			{
				115,
				50
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210309] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 50003,
		sort = 108,
		TimeOvrtShow = 1,
		Number = 10,
		Id = 50210309,
		Desc = "阴阳秘文·断章",
		Price = {
			{
				115,
				100
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210310] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 4,
		sort = 109,
		TimeOvrtShow = 1,
		Number = 1000,
		Id = 50210310,
		Desc = "札币",
		Price = {
			{
				115,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210311] = {
		CommodityType = 1,
		ShopID = 50101010,
		BuyType = 2,
		ItemId = 12023,
		Time = 20,
		sort = 102,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210311,
		Desc = "黑铁的识域",
		Price = {
			{
				115,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210401] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 15000,
		Time = 1,
		sort = 1,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210401,
		Desc = "天照命晶",
		Price = {
			{
				117,
				2000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210402] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 15015,
		Time = 1,
		sort = 3,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210402,
		Desc = "遗馈之环",
		Price = {
			{
				117,
				1500
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210403] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 11,
		Time = 10,
		sort = 4,
		ResetType = 2,
		Number = 60,
		TimeOvrtShow = 1,
		Id = 50210403,
		Desc = "人格值",
		Price = {
			{
				117,
				240
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210404] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 16004,
		Time = 10,
		sort = 5,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210404,
		Desc = "高级料理",
		Price = {
			{
				117,
				80
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210405] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 15032,
		Time = 1,
		sort = 6,
		ResetType = 2,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210405,
		Desc = "鬼神心核·伪",
		Price = {
			{
				117,
				2000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210406] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 4,
		Time = 10,
		sort = 8,
		ResetType = 1,
		Number = 10000,
		TimeOvrtShow = 1,
		Id = 50210406,
		Desc = "札币",
		Price = {
			{
				117,
				40
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210407] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 50041,
		Time = 5,
		sort = 7,
		ResetType = 1,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210407,
		Desc = "千变灵髓",
		Price = {
			{
				117,
				80
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50210408] = {
		CommodityType = 1,
		ShopID = 50101011,
		BuyType = 2,
		ItemId = 50042,
		Time = 5,
		sort = 2,
		ResetType = 3,
		Number = 1,
		TimeOvrtShow = 1,
		Id = 50210408,
		Desc = "万化灵髓",
		Price = {
			{
				117,
				500
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220001] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 15000,
		Time = 1,
		sort = 1,
		ResetType = 3,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220001,
		Desc = "天照命晶",
		Price = {
			{
				22,
				5000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220002] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 15015,
		Time = 1,
		sort = 2,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220002,
		Desc = "遗馈之环",
		Price = {
			{
				22,
				1800
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220003] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 3000,
		Time = 2,
		sort = 4,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220003,
		Desc = "神觉银契",
		Price = {
			{
				22,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220004] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 3003,
		Time = 2,
		sort = 5,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220004,
		Desc = "鬼武专契",
		Price = {
			{
				22,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220005] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 60127,
		Time = 6,
		sort = 7,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220005,
		Desc = "四星识域",
		Price = {
			{
				22,
				200
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220006] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 60128,
		Time = 3,
		sort = 6,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220006,
		Desc = "五星识域",
		Price = {
			{
				22,
				600
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220007] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 4,
		Time = 5,
		sort = 14,
		ResetType = 2,
		Number = 50000,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220007,
		Desc = "札币",
		Price = {
			{
				22,
				180
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220008] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 50034,
		Time = 20,
		sort = 11,
		ResetType = 2,
		Number = 5,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220008,
		Desc = "神宗鬼卷·真言",
		Price = {
			{
				22,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220009] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 50033,
		Time = 20,
		sort = 12,
		ResetType = 2,
		Number = 10,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220009,
		Desc = "神宗鬼卷·拓本",
		Price = {
			{
				22,
				200
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220010] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 50032,
		Time = 20,
		sort = 13,
		ResetType = 2,
		Number = 20,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220010,
		Desc = "神宗鬼卷·注卷",
		Price = {
			{
				22,
				120
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220011] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 3001,
		Time = 2,
		sort = 3,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220011,
		Desc = "神觉金契",
		Price = {
			{
				22,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220012] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 60123,
		Time = 1,
		sort = 9,
		ResetType = 3,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220012,
		Desc = "四星鬼武",
		Price = {
			{
				22,
				3000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220013] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 15032,
		Time = 1,
		sort = 8,
		ResetType = 3,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220013,
		Desc = "鬼神心核·伪",
		Price = {
			{
				22,
				5000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220014] = {
		CommodityType = 1,
		ShopID = 50102000,
		BuyType = 2,
		ItemId = 55002,
		Time = 5,
		sort = 10,
		ResetType = 2,
		Number = 1,
		UnlockConditionId = 30067001,
		TimeOvrtShow = 1,
		Id = 50220014,
		Desc = "人格安定药剂",
		Price = {
			{
				22,
				500
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220117] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 10034,
		Time = 1,
		sort = 100,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220117,
		Desc = "一川晴",
		Price = {
			{
				18,
				20000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220118] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15031,
		Time = 1,
		sort = 101,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220118,
		Desc = "鬼神心核·真",
		Price = {
			{
				18,
				15000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220119] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15000,
		Time = 1,
		sort = 102,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220119,
		Desc = "天照命晶",
		Price = {
			{
				18,
				8000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220120] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15015,
		Time = 2,
		sort = 103,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220120,
		Desc = "遗馈之环",
		Price = {
			{
				18,
				5000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220121] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 60128,
		Time = 10,
		sort = 104,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220121,
		Desc = "五星识域",
		Price = {
			{
				18,
				2000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220122] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 60127,
		Time = 20,
		sort = 105,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220122,
		Desc = "四星识域",
		Price = {
			{
				18,
				500
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220123] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 3000,
		Time = 5,
		sort = 106,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220123,
		Desc = "神觉银契",
		Price = {
			{
				18,
				1000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220124] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 3001,
		Time = 5,
		sort = 107,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220124,
		Desc = "神觉金契",
		Price = {
			{
				18,
				1000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220125] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 3003,
		Time = 5,
		sort = 108,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220125,
		Desc = "鬼武专契",
		Price = {
			{
				18,
				1000
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220126] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 55001,
		Time = 10,
		sort = 109,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220126,
		Desc = "人格稳定试剂",
		Price = {
			{
				18,
				500
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220127] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15011,
		Time = 10,
		sort = 110,
		TimeOvrtShow = 1,
		Number = 10,
		Id = 50220127,
		Desc = "守之印",
		Price = {
			{
				18,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220128] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15012,
		Time = 10,
		sort = 111,
		TimeOvrtShow = 1,
		Number = 10,
		Id = 50220128,
		Desc = "斗之印",
		Price = {
			{
				18,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220129] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15013,
		Time = 10,
		sort = 112,
		TimeOvrtShow = 1,
		Number = 10,
		Id = 50220129,
		Desc = "术之印",
		Price = {
			{
				18,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220130] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15014,
		Time = 10,
		sort = 113,
		TimeOvrtShow = 1,
		Number = 10,
		Id = 50220130,
		Desc = "诡之印",
		Price = {
			{
				18,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220131] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 15021,
		Time = 20,
		sort = 114,
		TimeOvrtShow = 1,
		Number = 10,
		Id = 50220131,
		Desc = "破封血刃",
		Price = {
			{
				18,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220132] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 50004,
		Time = 20,
		sort = 115,
		TimeOvrtShow = 1,
		Number = 3,
		Id = 50220132,
		Desc = "阴阳秘文·完本",
		Price = {
			{
				18,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220133] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 50034,
		Time = 20,
		sort = 116,
		TimeOvrtShow = 1,
		Number = 3,
		Id = 50220133,
		Desc = "神宗鬼卷·真言",
		Price = {
			{
				18,
				500
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220134] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 50003,
		Time = 30,
		sort = 117,
		TimeOvrtShow = 1,
		Number = 5,
		Id = 50220134,
		Desc = "阴阳秘文·断章",
		Price = {
			{
				18,
				150
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220135] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 50033,
		Time = 30,
		sort = 118,
		TimeOvrtShow = 1,
		Number = 5,
		Id = 50220135,
		Desc = "神宗鬼卷·拓本",
		Price = {
			{
				18,
				300
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220136] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 4,
		sort = 119,
		TimeOvrtShow = 1,
		Number = 1000,
		Id = 50220136,
		Desc = "札币",
		Price = {
			{
				18,
				10
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220137] = {
		CommodityType = 1,
		ShopID = 50102010,
		BuyType = 2,
		ItemId = 4,
		sort = 120,
		TimeOvrtShow = 1,
		Number = 100,
		Id = 50220137,
		Desc = "札币",
		Price = {
			{
				18,
				1
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220201] = {
		CommodityType = 1,
		ShopID = 50102020,
		BuyType = 2,
		ItemId = 55002,
		Time = 5,
		sort = 100,
		TimeOvrtShow = 1,
		Number = 1,
		Id = 50220201,
		Desc = "人格安定药剂",
		Price = {
			{
				201,
				100
			},
			{},
			{},
			{},
			{},
			{}
		}
	},
	[50220202] = {
		CommodityType = 1,
		ShopID = 50102020,
		BuyType = 2,
		ItemId = 4,
		Time = 10,
		sort = 116,
		TimeOvrtShow = 1,
		Number = 100000,
		Id = 50220202,
		Desc = "札币",
		Price = {
			{
				201,
				30
			},
			{},
			{},
			{},
			{},
			{}
		}
	}
}

setmetatable(CfgCommodityTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCommodityTable]")
	end
})

local defaultMetaTable = {
	__index = {
		CommodityType = 0,
		OpenTime = "",
		AbsoluteValue = 0,
		ResetType = 0,
		BuyType = 0,
		TimeOvrtShow = 0,
		UnlockConditionId = 0,
		sort = 0,
		Recommend = false,
		CloseTime = "",
		DiscountRate = 0,
		ShopID = 0,
		Desc = "",
		ItemId = 0,
		Free = false,
		Icon = "",
		Number = 0,
		Time = 0,
		IsDouble = false,
		Discount = {},
		addTime = {},
		PackageShowUI = {},
		BuyConditionId = {},
		Bonus = {},
		Additional = {},
		Price = {
			{},
			{},
			{},
			{},
			{},
			{}
		}
	}
}

for i, data in pairs(CfgCommodityTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCommodityTable
