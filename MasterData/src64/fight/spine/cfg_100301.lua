return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10030161,
				frame = 16
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
		totalframe = 35,
		animation = "skill",
		exe_tbl = {
			{
				id = 10030171,
				frame = 21,
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 200,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 500
					}
				}
			}
		}
	}
}
