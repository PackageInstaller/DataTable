return {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10066120,
				frame = 15
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
				id = 10066130,
				frame = 25,
				force = {
					{
						time = 0.6,
						shutdown = true,
						distance = "150",
						object = "target"
					}
				}
			}
		}
	}
}
