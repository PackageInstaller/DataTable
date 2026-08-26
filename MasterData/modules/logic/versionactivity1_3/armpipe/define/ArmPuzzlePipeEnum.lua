-- chunkname: @modules/logic/versionactivity1_3/armpipe/define/ArmPuzzlePipeEnum.lua

module("modules.logic.versionactivity1_3.armpipe.define.ArmPuzzlePipeEnum", package.seeall)

local ArmPuzzlePipeEnum = _M

ArmPuzzlePipeEnum.hintCount = 3
ArmPuzzlePipeEnum.pipeEntryClearCount = 2
ArmPuzzlePipeEnum.pipeEntryClearDecimal = 10
ArmPuzzlePipeEnum.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
ArmPuzzlePipeEnum.type = {
	x_shape = 10,
	corner = 6,
	first = 1,
	zhanwei = 8,
	connect = 9,
	signsingle = 3,
	straight = 5,
	wrong = 4,
	t_shape = 7,
	last = 2
}
ArmPuzzlePipeEnum.status = {
	correct = 2,
	normal = 1
}
ArmPuzzlePipeEnum.pathColor = {
	[0] = "#FFFFFF",
	"#BE8757",
	"#BB5F4C"
}
ArmPuzzlePipeEnum.entryColor = {
	[0] = "#FFFFFF",
	"#9A4B05",
	"#AA0F09"
}
ArmPuzzlePipeEnum.entryTypeColor = {
	[ArmPuzzlePipeEnum.type.first] = {
		[1] = "#9D4D01",
		[2] = "#A93737"
	},
	[ArmPuzzlePipeEnum.type.last] = {
		[1] = "#9D4D01",
		[2] = "#A93737"
	}
}
ArmPuzzlePipeEnum.ruleConnect = {
	[ArmPuzzlePipeEnum.type.first] = 2468,
	[ArmPuzzlePipeEnum.type.last] = 2468,
	[ArmPuzzlePipeEnum.type.signsingle] = 2468,
	[ArmPuzzlePipeEnum.type.wrong] = 2468,
	[ArmPuzzlePipeEnum.type.straight] = 28,
	[ArmPuzzlePipeEnum.type.corner] = 26,
	[ArmPuzzlePipeEnum.type.t_shape] = 468,
	[ArmPuzzlePipeEnum.type.zhanwei] = 0,
	[ArmPuzzlePipeEnum.type.connect] = 2468,
	[ArmPuzzlePipeEnum.type.x_shape] = 2468
}
ArmPuzzlePipeEnum.entry = {
	[ArmPuzzlePipeEnum.type.first] = true,
	[ArmPuzzlePipeEnum.type.last] = true,
	[ArmPuzzlePipeEnum.type.signsingle] = true,
	[ArmPuzzlePipeEnum.type.wrong] = true,
	[ArmPuzzlePipeEnum.type.connect] = true
}
ArmPuzzlePipeEnum.pathConn = {
	[ArmPuzzlePipeEnum.type.straight] = true,
	[ArmPuzzlePipeEnum.type.corner] = true,
	[ArmPuzzlePipeEnum.type.t_shape] = true,
	[ArmPuzzlePipeEnum.type.x_shape] = true
}
ArmPuzzlePipeEnum.UIDragRes = {
	[ArmPuzzlePipeEnum.type.straight] = "v1a3_arm_puzzlepipegrid3",
	[ArmPuzzlePipeEnum.type.corner] = "v1a3_arm_puzzlepipegrid2",
	[ArmPuzzlePipeEnum.type.t_shape] = "v1a3_arm_puzzlepipegrid1"
}
ArmPuzzlePipeEnum.UIDragEmptyRes = {
	[ArmPuzzlePipeEnum.type.straight] = "v1a3_arm_puzzlepipegrid3disable",
	[ArmPuzzlePipeEnum.type.corner] = "v1a3_arm_puzzlepipegrid2disable",
	[ArmPuzzlePipeEnum.type.t_shape] = "v1a3_arm_puzzlepipegrid1disable"
}
ArmPuzzlePipeEnum.res = {
	[ArmPuzzlePipeEnum.type.first] = {
		"v1a3_arm_puzzlesignstart",
		"v1a3_arm_puzzlesignstart"
	},
	[ArmPuzzlePipeEnum.type.last] = {
		"v1a3_arm_puzzlesignend",
		"v1a3_arm_puzzlesignend"
	},
	[ArmPuzzlePipeEnum.type.signsingle] = {
		"v1a3_arm_puzzlesignsingle",
		"v1a3_arm_puzzlesignright"
	},
	[ArmPuzzlePipeEnum.type.wrong] = {
		"v1a3_arm_puzzlesignwrong",
		"v1a3_arm_puzzlesignright"
	},
	[ArmPuzzlePipeEnum.type.straight] = {
		"v1a3_arm_puzzlepipe3",
		"v1a3_arm_puzzlepipepath3"
	},
	[ArmPuzzlePipeEnum.type.corner] = {
		"v1a3_arm_puzzlepipe2",
		"v1a3_arm_puzzlepipepath2"
	},
	[ArmPuzzlePipeEnum.type.t_shape] = {
		"v1a3_arm_puzzlepipe1",
		"v1a3_arm_puzzlepipepath1"
	},
	[ArmPuzzlePipeEnum.type.zhanwei] = {
		"v1a3_arm_puzzleputgrid3",
		"v1a3_arm_puzzleputgrid3"
	},
	[ArmPuzzlePipeEnum.type.connect] = {
		"v1a3_arm_puzzlesignsingle",
		"v1a3_arm_puzzlesignright"
	},
	[ArmPuzzlePipeEnum.type.x_shape] = {
		"v1a3_arm_puzzleputgrid2",
		"v1a3_arm_puzzlesignright"
	}
}
ArmPuzzlePipeEnum.resNumIcons = {
	"v1a3_arm_puzzlesignnum1",
	"v1a3_arm_puzzlesignnum2",
	"v1a3_arm_puzzlesignnum3",
	"v1a3_arm_puzzlesignnum4"
}
ArmPuzzlePipeEnum.resGridBg = {
	[ArmPuzzlePipeEnum.type.straight] = "v1a3_arm_puzzlepipegrid3",
	[ArmPuzzlePipeEnum.type.corner] = "v1a3_arm_puzzlepipegrid2",
	[ArmPuzzlePipeEnum.type.t_shape] = "v1a3_arm_puzzlepipegrid1",
	[ArmPuzzlePipeEnum.type.zhanwei] = "v1a3_arm_puzzleputgrid2"
}
ArmPuzzlePipeEnum.pathGridBg = {
	[0] = "v1a3_arm_puzzleputgrid1",
	"v1a3_arm_puzzleputgrid2",
	"v1a3_arm_puzzleputgrid3"
}
ArmPuzzlePipeEnum.rotate = {
	[ArmPuzzlePipeEnum.type.straight] = {
		[28] = {
			0
		},
		[46] = {
			90
		}
	},
	[ArmPuzzlePipeEnum.type.corner] = {
		[26] = {
			0
		},
		[24] = {
			270
		},
		[48] = {
			180
		},
		[68] = {
			90
		}
	},
	[ArmPuzzlePipeEnum.type.t_shape] = {
		[468] = {
			0
		},
		[268] = {
			270
		},
		[246] = {
			180
		},
		[248] = {
			90
		}
	}
}
ArmPuzzlePipeEnum.connDir = {
	[ArmPuzzlePipeEnum.dir.left] = ArmPuzzlePipeEnum.dir.right,
	[ArmPuzzlePipeEnum.dir.right] = ArmPuzzlePipeEnum.dir.left,
	[ArmPuzzlePipeEnum.dir.up] = ArmPuzzlePipeEnum.dir.down,
	[ArmPuzzlePipeEnum.dir.down] = ArmPuzzlePipeEnum.dir.up
}
ArmPuzzlePipeEnum.posDir = {
	[ArmPuzzlePipeEnum.dir.left] = {
		x = -1,
		y = 0
	},
	[ArmPuzzlePipeEnum.dir.right] = {
		x = 1,
		y = 0
	},
	[ArmPuzzlePipeEnum.dir.up] = {
		x = 0,
		y = 1
	},
	[ArmPuzzlePipeEnum.dir.down] = {
		x = 0,
		y = -1
	}
}
ArmPuzzlePipeEnum.PathNO = {
	PathOne = 1,
	PathTwo = 2
}
ArmPuzzlePipeEnum.PathType = {
	Order = 1
}
ArmPuzzlePipeEnum.AnimEvent_OnJump = "OnJump"
ArmPuzzlePipeEnum.EpisodeState = {
	Finish = 1,
	Received = 2,
	Normal = 0
}
ArmPuzzlePipeEnum.ComponentType = {
	Animator = typeof(UnityEngine.Animator)
}
ArmPuzzlePipeEnum.AnimatorTime = {
	GameFinish = 2.2,
	WaitUnFixedTime = 0.3,
	UnFixedTime = 1.5,
	OpenView = 2
}

return ArmPuzzlePipeEnum
