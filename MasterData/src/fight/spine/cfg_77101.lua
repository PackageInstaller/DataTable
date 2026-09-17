local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 75,
					range = 100
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				id = 77210001,
				frame = 18,
				effect = {
					{
						ani = "attack",
						name = "77101_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				id = 77210002,
				frame = 16
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 11,
				id = 77220001
			}
		}
	},
	useskill2 = {
		totalframe = 67,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				id = 77221001,
				behitted = "hitdown",
				frame = 19,
				effect = {
					{
						ani = "skill",
						name = "77101_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 77221001,
				behitted = "hitdown",
				frame = 25,
				effect = {
					{
						ani = "skill",
						name = "77101_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 77221002,
				behitted = "hitdown",
				frame = 50,
				effect = {
					{
						ani = "skill",
						name = "77101_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 80,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 77230001,
				frame = 60,
				effect = {
					{
						ani = "xp",
						name = "77101_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
	bgfile = "77100_bg",
	locktarget = {
		mindistance = 240,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 10,
			startframe = 30,
			timescale = 0.8
		}
	}
}

return var_0_0
