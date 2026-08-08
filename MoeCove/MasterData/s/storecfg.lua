
local ShopConfig = {
	Recharge = {
		{
			title = "新手礼包",
			extra = "<color=#7FD067>超值礼品</color>",
			desc = "新手超值大礼包。",
			money = 1,
			limit = 1,	-- 限制次数
			package = {
				gold = 100,
				silver = 10000,

				items = {
					{45007, 2},
					{45008, 2},
					{45009, 2},
					{45010, 2},
				},

			},
			purchase = {
				storeSpecificId = ".newuserpackage1",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>60黄金</color>",
			extra = nil,
			money = 6,
			package = {
				gold = 60,
			},
			purchase = {
				storeSpecificId = ".gold60",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>300黄金</color>",
			extra = "另赠送15黄金",
			money = 30,
			package = {
				gold = 300,
				extraGold = 15,
			},
			purchase = {
				storeSpecificId = ".300gold",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>500黄金</color>",
			extra = "另赠送50黄金",
			money = 50,
			package = {
				gold = 500,
				extraGold = 50,
			},
			purchase = {
				storeSpecificId = ".500gold",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>980黄金</color>",
			extra = "另赠送120黄金",
			money = 98,
			package = {
				gold = 980,
				extraGold = 120,
			},
			purchase = {
				storeSpecificId = ".980gold",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>1980黄金</color>",
			extra = "另赠送250黄金",
			money = 198,
			package = {
				gold = 1980,
				extraGold = 250,
			},
			purchase = {
				storeSpecificId = ".1980gold",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>2980黄金</color>",
			extra = "另赠送400黄金",
			money = 298,
			package = {
				gold = 2980,
				extraGold = 400,
			},
			purchase = {
				storeSpecificId = ".2980gold",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>4880黄金</color>",
			extra = "另赠送688黄金",
			money = 488,
			package = {
				gold = 4880,
				extraGold = 688,
			},
			purchase = {
				storeSpecificId = ".4880gold",
				productType = "Consumable",
			},
		},

		{
			title = "<color=#D6A616>6480黄金</color>",
			extra = "另赠送999黄金",
			money = 648,
			package = {
				gold = 6480,
				extraGold = 999,
			},
			purchase = {
				storeSpecificId = ".6480gold",
				productType = "Consumable",
			},
		},
	},

	Store = {

		{
			title = "少林残章盒",
			-- extra = "<color=#7FD067>超值礼品</color>",
			gold = 200,
			package = {
				-- silver = 10000,

				items = {
					{80001, 1},
				},

			},
		},

		{
			title = "10000银两",
			-- extra = "<color=#7FD067>超值礼品</color>",
			gold = 10,
			package = {
				silver = 10000,
			},
		},
		
		{
			title = "100000银两",
			-- extra = "<color=#7FD067>超值礼品</color>",
			gold = 90,
			package = {
				silver = 100000,
			},
		},
		
	},
}

return ShopConfig