local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				id = 20410010,
				sound = {
					"20400_attack",
					0.6
				}
			},
			{
				frame = 16,
				id = 20410011
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20400_skill1",
					0.6
				}
			},
			{
				frame = 30,
				id = 20420010
			},
			{
				frame = 31,
				id = 20420011
			},
			{
				frame = 32,
				id = 20420012
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	usexp1 = {
		totalframe = 90,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20400_xp",
					0.6
				}
			},
			{
				frame = 30,
				id = 20430010
			},
			{
				frame = 40,
				id = 20430010
			},
			{
				frame = 45,
				id = 20430010
			},
			{
				frame = 89,
				id = 20430011
			},
			{
				frame = 46,
				id = 20430012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "20430_bg",
	totalframe = 60,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/20430.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20420_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 60,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 60,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
