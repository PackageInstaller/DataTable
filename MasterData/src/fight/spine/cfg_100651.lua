local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 12,
				bullet = "attack"
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
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill1 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 10065130,
				frame = 17,
				effect = {
					{
						ani = "skill",
						name = "100631_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		totalframe = 50,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10065140,
				frame = 30,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = 150,
						object = "target"
					}
				},
				effect = {
					{
						ani = "run2",
						name = "100651_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			}
		}
	},
	useskill3 = {
		totalframe = 45,
		animation = "skill3",
		exe_tbl = {
			{
				id = 10065150,
				frame = 25
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
	usexp = {
		totalframe = 80,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 10065160,
				behitted = "hitdown",
				frame = 25
			},
			{
				id = 10065160,
				behitted = "hitdown",
				frame = 35
			},
			{
				id = 10065160,
				behitted = "hitdown",
				frame = 45
			},
			{
				id = 10065160,
				behitted = "hitdown",
				frame = 55
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 60,
	bgfile = "45080_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100651_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 10065120,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "100651_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
