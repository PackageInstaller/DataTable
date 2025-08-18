-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\CueData\\13008.lua

local Data = {
	[130080001] = {
		TypeString = "Effect",
		CueID = 130080001,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14008/efx_14008_battle_attack_basic_Hit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14008_battle_attack_basic_Hit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080002] = {
		TypeString = "Effect",
		CueID = 130080002,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/14008/efx_14008_battle_attack_basic_Ballistic.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_14008_battle_attack_basic_Ballistic",
			playLength = -1,
			height = 3,
			speed = 0,
			mountType = 0,
			curve = 5,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130086001] = {
		TypeString = "ModelEffect",
		CueID = 130086001,
		CueType = 6,
		ModelEffect = {
			howToPlay = 0,
			length = 10,
			type = 3,
			modelChangeMotion = {
				newStateName = "idle01",
				oldStateName = "idle"
			}
		}
	},
	[130080003] = {
		TypeString = "Effect",
		CueID = 130080003,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_passive_21_buff.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_passive_21_buff",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Spine",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080004] = {
		TypeString = "Effect",
		CueID = 130080004,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_Hit02.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_basic_Hit02",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Behit",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080005] = {
		TypeString = "Effect",
		CueID = 130080005,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_Bullet02.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_13008_battle_attack_basic_Bullet02",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130082001] = {
		TypeString = "GroupCue",
		CueID = 130082001,
		CueType = 2,
		GroupCue = {
			CueList = {
				130086001,
				130080003
			}
		}
	},
	[130085001] = {
		TypeString = "PostProcess",
		CueID = 130085001,
		CueType = 5,
		PostProcess = {
			fadeOut = 0.2,
			fadeIn = 0.2,
			length = 1.7,
			type = 4,
			cullingPlayer = 1,
			tintColorParam = {
				G = 0,
				A = 0.9607843,
				blendMode = true,
				R = 0,
				B = 0
			}
		}
	},
	[130080006] = {
		TypeString = "Effect",
		CueID = 130080006,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_01.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14003_battle_attack_ultra_01",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Spine",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080007] = {
		TypeString = "Effect",
		CueID = 130080007,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_passive_01.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_passive_01",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080008] = {
		TypeString = "Effect",
		CueID = 130080008,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13010/efx_13010_battle_attack_basic_01_bullet.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_13010_battle_attack_basic_01_bullet",
			playLength = -1,
			height = 3,
			speed = 0,
			mountType = 0,
			curve = 5,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080009] = {
		TypeString = "Effect",
		CueID = 130080009,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13010/efx_13010_battle_attack_basic_01_bullet_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13010_battle_attack_basic_01_bullet_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080010] = {
		TypeString = "Effect",
		CueID = 130080010,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/14001/efx_14001_battle_attack_basic_01_bullet.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_14001_battle_attack_basic_01_bullet",
			playLength = -1,
			height = 3,
			speed = 0,
			mountType = 0,
			curve = 5,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080011] = {
		TypeString = "Effect",
		CueID = 130080011,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14001/efx_14001_battle_attack_basic_01_bullet_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14001_battle_attack_basic_01_bullet_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080012] = {
		TypeString = "Effect",
		CueID = 130080012,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13010/efx_13010_battle_attack_passive_21_buff.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13010_battle_attack_passive_21_buff",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Spine",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080013] = {
		TypeString = "Effect",
		CueID = 130080013,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14001/efx_14001_battle_attack_passive_01.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14001_battle_attack_passive_01",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080014] = {
		TypeString = "Effect",
		CueID = 130080014,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/14001/efx_14001_battle_attack_ultra_01_bullet.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_14001_battle_attack_ultra_01_bullet",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080015] = {
		TypeString = "Effect",
		CueID = 130080015,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14001/efx_14001_battle_attack_ultra_01_bullet_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14001_battle_attack_ultra_01_bullet_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Behit",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080016] = {
		TypeString = "Effect",
		CueID = 130080016,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_basic_01_bullet.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_14009_battle_attack_basic_01_bullet",
			playLength = -1,
			height = 3,
			speed = 0,
			mountType = 0,
			curve = 5,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080017] = {
		TypeString = "Effect",
		CueID = 130080017,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_basic_01_bullet_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14009_battle_attack_basic_01_bullet_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080018] = {
		TypeString = "Effect",
		CueID = 130080018,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_passive_01.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14009_battle_attack_passive_01",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bone016",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080019] = {
		TypeString = "Effect",
		CueID = 130080019,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_passive_01_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14009_battle_attack_passive_01_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080020] = {
		TypeString = "Effect",
		CueID = 130080020,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_ultra_01_bullet.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Spine",
			Source = "efx_14009_battle_attack_ultra_01_bullet",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080021] = {
		TypeString = "Effect",
		CueID = 130080021,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_ultra_01_bullet_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14009_battle_attack_ultra_01_bullet_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Behit",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080022] = {
		TypeString = "Effect",
		CueID = 130080022,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14001/efx_14001_battle_attack_ultra_01.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14001_battle_attack_ultra_01",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bone016",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080023] = {
		TypeString = "Effect",
		CueID = 130080023,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14009/efx_14009_battle_attack_ultra_01.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_14009_battle_attack_ultra_01",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bone016",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080024] = {
		TypeString = "Effect",
		CueID = 130080024,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_test_double_side.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_test_double_side",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 2,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130081001] = {
		TypeString = "Audio",
		CueID = 130081001,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_13008_11_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_13008_11_2"
		}
	},
	[130081002] = {
		TypeString = "Audio",
		CueID = 130081002,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_13008_12_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_13008_12_2"
		}
	},
	[130080025] = {
		TypeString = "Effect",
		CueID = 130080025,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_01_1.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_basic_01_1",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080026] = {
		TypeString = "Effect",
		CueID = 130080026,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_01_2.prefab",
			startPos = "Bip001 R Hand",
			endPos = "Bip001 Spine",
			Source = "efx_13008_battle_attack_basic_01_2",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 R Hand",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080027] = {
		TypeString = "Effect",
		CueID = 130080027,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_01_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_basic_01_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Behit",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080028] = {
		TypeString = "Effect",
		CueID = 130080028,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_02_1.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_basic_02_1",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080029] = {
		TypeString = "Effect",
		CueID = 130080029,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_02_1_hand.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_basic_02_1_hand",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 R Hand",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080030] = {
		TypeString = "Effect",
		CueID = 130080030,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_02_2.prefab",
			startPos = "Bip001 R Hand",
			endPos = "Bip001 Spine",
			Source = "efx_13008_battle_attack_basic_02_2",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080031] = {
		TypeString = "Effect",
		CueID = 130080031,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_02_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_basic_02_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Behit",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080032] = {
		TypeString = "Effect",
		CueID = 130080032,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_passive_21_buff.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_passive_21_buff",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Behit",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080033] = {
		TypeString = "Effect",
		CueID = 130080033,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_ultra_51_1.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_ultra_51_1",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130080034] = {
		TypeString = "Effect",
		CueID = 130080034,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_ultra_51_buff.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_13008_battle_attack_ultra_51_buff",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "Bip001 Spine",
			oppositeDirection = false,
			motionMode = 0,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[130081003] = {
		TypeString = "Audio",
		CueID = 130081003,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_1300801_11_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_1300801_11_1"
		}
	},
	[130081004] = {
		TypeString = "Audio",
		CueID = 130081004,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_1300801_11_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_1300801_11_2"
		}
	},
	[130081005] = {
		TypeString = "Audio",
		CueID = 130081005,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_1300801_12_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_1300801_12_1"
		}
	},
	[130081006] = {
		TypeString = "Audio",
		CueID = 130081006,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_1300801_12_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_1300801_12_2"
		}
	},
	[130081007] = {
		TypeString = "Audio",
		CueID = 130081007,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_1300801_51_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_1300801_51_1"
		}
	},
	[130080035] = {
		TypeString = "Effect",
		CueID = 130080035,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/13008/efx_13008_battle_attack_basic_02_2.prefab",
			startPos = "Bip001 R Hand",
			endPos = "Bip001 Spine",
			Source = "efx_13008_battle_attack_basic_02_2",
			playLength = -1,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
			motionMode = 1,
			scale = 2,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	}
}

return Data
