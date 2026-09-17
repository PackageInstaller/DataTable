value_list = {
	textFinishtime = {
		fontstr = "剩余时间：",
		font = "fonts/W5.ttf",
		zorder = 25,
		str = "",
		size = 22,
		desc = "结束时间",
		pos = {
			{
				x = 300,
				y = 910
			},
			[2] = 1
		},
		color = {
			g = 255,
			b = 255,
			r = 255
		}
	},
	btnTwist2 = {
		path = "btn_twist2.png",
		zorder = 2,
		desc = "扭蛋2",
		pos = {
			{
				x = 500,
				y = 450
			},
			[2] = 1
		}
	},
	btnFlop = {
		zorder = 3,
		path = "btn_flop.png",
		desc = "翻牌",
		pos = {
			{
				x = 160,
				y = 373 + 1.5 * GameDisplay.fix_y
			},
			[2] = -1
		},
		reddotpos = {
			x = "210",
			y = "80"
		}
	},
	btnDetail = {
		path = "btn_detail.png",
		zorder = 3,
		desc = "标题",
		pos = {
			{
				x = 310,
				y = 995
			},
			[2] = 1
		}
	},
	btnTwist = {
		path = "btn_twist.png",
		zorder = 2,
		desc = "扭蛋",
		pos = {
			{
				x = 500,
				y = 250
			},
			[2] = 1
		}
	},
	btnRecharge = {
		path = "btn_recharge.png",
		zorder = 3,
		desc = "充值礼包",
		pos = {
			{
				x = 160,
				y = 254 + 1.3 * GameDisplay.fix_y
			},
			[2] = -1
		}
	},
	showgirlLayer = {
		need_background = false,
		zorder = 0,
		desc = "皮肤背景",
		pos = {
			{
				x = 0,
				y = 0
			},
			[2] = 0
		}
	},
	btnSign = {
		zorder = 3,
		path = "btn_sign.png",
		desc = "签到",
		pos = {
			{
				x = 160,
				y = 482
			},
			[2] = 1
		},
		reddotpos = {
			x = "210",
			y = "80"
		}
	},
	btnReturn = {
		zorder = 3,
		path = "btn_return.png",
		desc = "返回键",
		pos = {
			{
				x = 144.85597229004,
				y = 106.66674804688
			},
			[2] = -1
		}
	}
}

return value_list
