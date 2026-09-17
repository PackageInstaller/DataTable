return {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				id = 10075121,
				frame = 15,
				effect = {
					{
						ani = "attack",
						name = "100751_effect",
						offsetZ = 1,
						offsetY = 1,
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				id = 10075131,
				frame = 18,
				effect = {
					{
						ani = "skill",
						name = "100751_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10075131,
				frame = 27,
				effect = {
					{
						ani = "skill",
						name = "100751_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
	useskill2 = {
		totalframe = 45,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10075141,
				frame = 19,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill",
						name = "100751_effect",
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
