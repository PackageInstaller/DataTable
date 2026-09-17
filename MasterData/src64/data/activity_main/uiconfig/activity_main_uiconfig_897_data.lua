value_list = {
	btnLevel = {
		zorder = 2,
		path = "btn_level.png",
		desc = "关卡",
		pos = {
			{
				x = 166,
				y = 520
			},
			[2] = 1
		},
		reddotpos = {
			x = "240",
			y = "86"
		}
	},
	btnMultipt = {
		path = "btn_myltipt.png",
		zorder = 3,
		desc = "多线pt",
		pos = {
			{
				x = 195,
				y = 304 + 2 * GameDisplay.fix_y
			},
			[2] = -1
		},
		reddotpos = {
			x = "260",
			y = "85"
		}
	},
	textFinishtime = {
		fontstr = "剩余时间：",
		font = "fonts/name.ttf",
		zorder = 30,
		str = "",
		size = 20,
		desc = "结束时间",
		pos = {
			{
				x = 320,
				y = 915
			},
			[2] = 1
		},
		color = {
			g = 255,
			b = 255,
			r = 255
		}
	},
	showgirlLayer = {
		need_background = false,
		zorder = 1,
		desc = "皮肤背景",
		pos = {
			{
				x = 0,
				y = 0
			},
			[2] = 0
		}
	},
	btnReturn = {
		path = "btn_return.png",
		zorder = 3,
		desc = "返回键",
		pos = {
			{
				x = 97.448547363281,
				y = 53.99169921875
			},
			[2] = -1
		},
		reddotpos = {
			x = "240",
			y = "86"
		}
	},
	imgBg = {
		zorder = 0,
		path = "img_bg.png",
		desc = "背景",
		pos = {
			{
				x = 320,
				y = 450
			},
			[2] = 1
		}
	},
	btnRandfight = {
		path = "btn_randfight.png",
		zorder = 2,
		desc = "随机(boss)挑战",
		pos = {
			{
				x = 166,
				y = 634 + 2 * GameDisplay.fix_y
			},
			[2] = -1
		},
		reddotpos = {
			x = "200",
			y = "60"
		}
	},
	btnBp = {
		path = "btn_bp.png",
		zorder = 3,
		desc = "bp",
		pos = {
			{
				x = 498,
				y = 620
			},
			[2] = -1
		},
		reddotpos = {
			x = "100",
			y = "120"
		}
	},
	btnSign = {
		path = "btn_sign.png",
		zorder = 3,
		desc = "签到",
		pos = {
			{
				x = 101,
				y = 779
			},
			[2] = 1
		},
		reddotpos = {
			x = "90",
			y = "50"
		}
	},
	btnDetail = {
		path = "btn_detail.png",
		zorder = 3,
		desc = "标题",
		pos = {
			{
				x = 317.36624145508,
				y = 1012.2139892578
			},
			[2] = 1
		},
		reddotpos = {
			x = "240",
			y = "86"
		}
	},
	btnTwist = {
		path = "btn_twist.png",
		zorder = 4,
		desc = "扭蛋",
		pos = {
			{
				x = 503,
				y = 800
			},
			[2] = -1
		},
		reddotpos = {
			x = "240",
			y = "86"
		}
	},
	btnRoulette = {
		zorder = 2,
		path = "btn_roulette.png",
		desc = "转盘",
		pos = {
			{
				x = 419,
				y = 490
			},
			[2] = -1
		},
		reddotpos = {
			x = "100",
			y = "120"
		}
	},
	btnRecharge = {
		path = "btn_recharge.png",
		zorder = 3,
		desc = "充值礼包",
		pos = {
			{
				x = 493,
				y = 360
			},
			[2] = -1
		},
		reddotpos = {
			x = "170",
			y = "160"
		}
	},
	btnTotalTask = {
		path = "btn_totaltask.png",
		zorder = 2,
		desc = "累充累抽",
		pos = {
			{
				x = 195,
				y = 205
			},
			[2] = 1
		},
		reddotpos = {
			x = "270",
			y = "75"
		}
	},
	btnDailyLevel = {
		zorder = 2,
		path = "btn_daily_level.png",
		desc = "每日本",
		pos = {
			{
				x = 166,
				y = 406
			},
			[2] = 1
		},
		reddotpos = {
			x = "240",
			y = "86"
		}
	}
}

return value_list
