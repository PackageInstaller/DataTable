local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 37,
		animation = "attack",
		exe_tbl = {
			{
				frame = 25,
				bullet = "attack",
				effect = {
					{
						ani = "attack",
						name = "51900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
		totalframe = 63,
		animation = "skill",
		exe_tbl = {
			{
				id = 5190031,
				frame = 42
			},
			{
				id = 5190031,
				frame = 47
			},
			{
				id = 5190031,
				frame = 53
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
		totalframe = 87,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5190061,
				frame = 26,
				effect = {
					{
						ani = "xp-attack",
						name = "51900_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 5190061,
				frame = 43
			},
			{
				id = 5190062,
				behitted = "hitdown",
				frame = 78
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 87,
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
	filename = "51900_effect",
	initpos = {
		offsetY = 1.3,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 5190021,
				frame = 7
			}
		}
	}
}

return var_0_0
