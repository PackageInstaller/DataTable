local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				frame = 27,
				bullet = "attack",
				effect = {
					{
						ani = "attack",
						name = "52000_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
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
		totalframe = 51,
		animation = "skill",
		exe_tbl = {
			{
				id = 5200031,
				frame = 33,
				effect = {
					{
						ani = "skill-attack",
						name = "52000_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "target"
					}
				}
			},
			{
				id = 5200031,
				frame = 36
			},
			{
				id = 5200031,
				frame = 40
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
		totalframe = 96,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				id = 5200061,
				frame = 69
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 96,
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
	filename = "52000_effect",
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
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				id = 5200021,
				frame = 6
			}
		}
	}
}

return var_0_0
